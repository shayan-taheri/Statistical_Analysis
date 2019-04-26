
/***********************************************************************;
ANCOVA Example;

Ten patients are selected for each treatment (Drug),  and six sites 
on each patient are measured for leprosy bacilli

The covariate (a pretreatment score) is included in the model 
for increased precision in determining the effect of drug treatments 
on the posttreatment count of bacilli. 

Variables in the study are as follows: 
1. Drug:  two antibiotics (A and D) and a control (F) 
2. PreTreatment:  a pretreatment score of leprosy bacilli 
3. PostTreatment:  a posttreatment score of leprosy bacilli 
**************************************************************************/; 

data DrugTest;
      input Drug $ PreTreatment PostTreatment @@;
      datalines;
   A 11  6   A  8  0   A  5  2   A 14  8   A 19 11
   A  6  4   A 10 13   A  6  1   A 11  8   A  3  0
   D  6  0   D  6  2   D  7  3   D  8  1   D 18 18
   D  8  4   D 19 14   D  8  9   D  5  1   D 15  9
   F 16 13   F 13 10   F 11 18   F  9  5   F 21 23
   F 16 12   F 12  5   F 12 16   F  7  1   F 12 20
   ;
run;

options nodate nonumber;
proc print  n noobs;
title "Data of Pre and post Treatment Scores of Three Drugs";
run;


/******************************************************************;
This model assumes that the slopes relating posttreatment 
scores to pretreatment scores are parallel for all drugs. 
You can check this assumption by including the class-by-covariate 
interaction, Drug*PreTreatment, in the model and examining the 
ANOVA test for the significance of this effect.
*******************************************************************/;


ods select none; *suppress all SAS default outputs;
ods output  ParameterEstimates=Parms;
proc glm data=DrugTest;
      class Drug;
      model PostTreatment = Drug  PreTreatment Drug*PreTreatment / solution;
run;
quit;
ods select all;  *recover all SAS default output;

proc print data=parms noobs;
var Parameter Estimate StdErr tValue Probt; 
title "ANCOVA model with Drug by Pre-treatment Interaction";
run;

/********************************************************************;
*There is no drug by preTreatmentinteraction. We then use ANCOVA     ; 
*********************************************************************/;
ods select none;
ods output  ParameterEstimates=Parms1;
proc glm data=DrugTest;
      class Drug;
      model PostTreatment = PreTreatment DRUG / solution;
      lsmeans Drug / stderr pdiff cov;
run;
quit;
ods select all;

proc print data=parms1 noobs;
var Parameter Estimate StdErr tValue Probt; 
title "Comparison of three drugs using ANCOVA model without Drug by Pre-treatment Interaction";
run;

**********************************************************************************;
*Since interaction is not significant the ANCOVA model is appropriate.            ;   
*However if we do not use ANCOVA model the drug A and D are statistically         ;
*different from Drug F (p-value=0.0157 and p-value=0.0305). Is this correct?      ;
**********************************************************************************;
ods select none;
ods output  ParameterEstimates=Parms2;
proc glm data=DrugTest;
      class Drug;
      model PostTreatment = Drug / solution;
      lsmeans Drug / stderr pdiff cov out=adjmeans1;
run;
quit;
ods select all;


proc print data=parms2 noobs;
var Parameter Estimate StdErr tValue Probt; 
title "Comparison of three drugs using ANOVA model";
run;

*******************************************************************************;
*The post treatment differences between Drugs A and F, Drugs D and F, are      ;
*partially from the pre-treatment score difference. By excluding the           ;
*pre-treatment difference the post-treatment difference between drugs A and F, ;
*D and F are not statistically diferent, However this is the true treatment    ;
*effect----new treatment actually dose not work!!                              ;               
*******************************************************************************;

*******************************************************************************;
*Graphical display of comparisons between drugs A and F, and Drugs D and F     ;
*******************************************************************************;
ods graphics on;
   proc glm data=DrugTest plot=meanplot(cl);
      class Drug;
      model PostTreatment = Drug PreTreatment;
      lsmeans Drug / pdiff;
   run;
 ods graphics off;

