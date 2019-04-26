* Statistical Analysis -- Final Project: Question 4;

* ------------------------------------------------------------------------------;
* Graduated students from college --> Deeply in debt from different resourses   ;
* Standard Treatment Group: 116 Members and Four Infected                       ;
* New Treatment Group: 116 Members and Two Infected                             ;
* ------------------------------------------------------------------------------;

proc format;
   value ExpFmt 1='New Treatment Group'
                0='Standard Treatment Group';
   value RspFmt 1='Infected'
                0='Healthy';
run;
data ClinStudy;
   input Exposure Response Count;
   datalines;
0 0 112
0 1 4
1 0 114
1 1 2
;
run;

proc print data=ClinStudy;
run;

ods trace on;
ods output "Chi-Square Tests"=Chisquare;
ods output "Fisher's Exact Test"=FisherTest; 
proc freq data=ClinStudy order=data;
   format Exposure ExpFmt. Response RspFmt.;
   tables Exposure*Response / chisq relrisk;
   exact pchi or;
   weight Count;
   title 'Clinical Study on Treatment for Controlling Blood Glucose';
run;
ods trace off;

* The Chisqure Test;

proc print data=Chisquare; run;

data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x2 Contingency Table";
run;

* The Fisher's exact test;
proc print data=FisherTest noobs;
title "Output of Fisher Exact Test";
run;
