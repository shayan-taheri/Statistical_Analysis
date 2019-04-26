
*-----------------------------------------;
*Chisqure test for contingency table      ;
*-----------------------------------------;

proc format;
   value ExpFmt 1='High Cholesterol Diet'
                0='Low Cholesterol Diet';
   value RspFmt 1='Yes'
                0='No';
run;
data FatComp;
   input Exposure Response Count;
   label Response='Heart Disease';
   datalines;
0 0  6
0 1  2
1 0  4
1 1 11
;
run;

proc print data=fatComp;
run;

*------------------------------------------------------;
*ORDER=DATA option orders the contingency table        ; 
*values by their order in the input data set.          ;
*The TABLES statement requests a two-way table of      ;
*Exposure by Response. The CHISQ option produces       ;
*several chi-square tests, while the RELRISK option    ;
*produces relative risk measures. The EXACT statement  ;
*requests the exact Pearson chi-square test and exact  ;
*confidence limits for the odds ratio.                 ;
*------------------------------------------------------;

ods trace on;
ods output "Chi-Square Tests"=Chisquare;
ods output "Fisher's Exact Test"=FisherTest; 
proc freq data=FatComp order=data;
   format Exposure ExpFmt. Response RspFmt.;
   tables Exposure*Response / chisq relrisk;
   exact pchi or;
   weight Count;
   title 'Case-Control Study of High Fat/Cholesterol Diet';
run;
ods trace off;

*Chisqure test;

proc print data=Chisquare; run;

data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x2 Contingency Table";
run;

*Fisher's exact test;
proc print data=FisherTest; 
run;


*Fisher's exact test for CVD example in the lecture notes;

proc format;
   value cause  1='CVD'
                0='Non-CVD';
   value salt   1='Low'
                0='High';
run;
data CVD;
   input  cause salt Count;
   datalines;
0 0  2
0 1  23
1 0  5
1 1  30
;
run;

proc print data=CVD;
format cause cause. salt salt.;
title "CVD and Salt Intake Data (2x2 table)";
run;

ods output "Fisher's Exact Test"=Exact; 
proc freq data=CVD order=data ;
format cause cause. salt salt.;
   tables cause*salt / chisq relrisk;
   exact pchi or;
   weight Count;
   title '2x2 table analysis of CVD and salt intake data';
run;

data exact1; set exact;
if _n_ in (2,3,5,6);
drop Table Name1  nValue1;
run;

option nodate nonumber;
proc print data=exact1 noobs; 
title "Output of Fisher Exact Test";
run;
