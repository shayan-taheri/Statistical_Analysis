*-------------------------------------------------------------------------;
*Randomized Complete Block With Factorial Treatment Structure             ;
*                                                                         ;                          
*This example uses statements for the analysis of a randomized block      ;
*with two treatment factors occurring in a factorial structure. The       ;
*data, from Neter, Wasserman, and Kutner (1990, p. 941), are from an      ;
*experiment examining the effects of codeine and acupuncture on           ;
*post-operative dental pain in male subjects. Both treatment factors      ;
*have two levels. The codeine levels are a codeine capsule or a sugar     ;
*capsule. The acupuncture levels are two inactive acupuncture points      ;
*or two active acupuncture points. There are four distinct treatment      ;
*combinations due to the factorial treatment structure. The 32 subjects   ; 
*are assigned to eight blocks of four subjects each based on an           ;
*assessment of pain tolerance.                                            ;
*-------------------------------------------------------------------------;

title1 'Randomized Complete Block With Two Factors';
   data PainRelief;
      input PainLevel Codeine Acupuncture Relief @@;
      datalines;
   1 1 1 0.0  1 2 1 0.5  1 1 2 0.6  1 2 2 1.2
   2 1 1 0.3  2 2 1 0.6  2 1 2 0.7  2 2 2 1.3
   3 1 1 0.4  3 2 1 0.8  3 1 2 0.8  3 2 2 1.6
   4 1 1 0.4  4 2 1 0.7  4 1 2 0.9  4 2 2 1.5
   5 1 1 0.6  5 2 1 1.0  5 1 2 1.5  5 2 2 1.9
   6 1 1 0.9  6 2 1 1.4  6 1 2 1.6  6 2 2 2.3
   7 1 1 1.0  7 2 1 1.8  7 1 2 1.7  7 2 2 2.1
   8 1 1 1.2  8 2 1 1.7  8 1 2 1.6  8 2 2 2.4
   ;
 run;


 proc print data=PainRelief;
 run;


ods trace on;
ods output "Overall ANOVA"=anovatable;
ods output "Anova Model ANOVA"=Model; 
proc anova data=PainRelief;
      class PainLevel Codeine Acupuncture;
      model Relief = PainLevel Codeine|Acupuncture;
   run;
ods trace off;

options nodate nonumber;
proc print data=anovatable noobs;
title "ANOVA TABLE";
run; 

proc print data=model noobs; 
var Dependent  Source  DF  SS  MS  FValue ProbF;
title "SS and Sources";
run;

*---------------;
* Test contrast ;
*---------------;

proc means data = PainRelief mean;
 class Painlevel;
 var Relief;
run;

*---------------------------------------------------;
*By looking at the means of different pain levels   ;
*We may want to test level 1 2 3 4 versus 5 6 7 8   ;
*---------------------------------------------------;

proc glm data = PainRelief;
  class PainLevel;
  model Relief= PainLevel;
  means PainLevel /deponly;
  contrast 'Compare Pain Levels 1 2 3 4 versus  5 6 7 8' PainLevel 1 1 1 1 -1 -1 -1 -1;
  contrast 'Compare Pain Levels 1  versus 8'             PainLevel 1 0 0 0  0  0  0 -1;
  contrast 'Compare Pain Levels 6 versus  7 8'           PainLevel 1 0 0 0  0  0 -0.5 -0.5;
  contrast 'Compare Pain Levels 2 versus  6'             PainLevel 0 1 0 0  0  -1 0  0;
run;
quit;
  
