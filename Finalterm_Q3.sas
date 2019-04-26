* Statistical Analysis -- Final Project: Question 3;

* ------------------------------------------------------------------------------;
* Graduated students from college --> Deeply in debt from different resourses   ;
* A random sample of 401 single persons --> Classification by gender           ;
* A survey on marrying someone in debt?                                         ;
* ------------------------------------------------------------------------------;

proc format;
   value ExpFmt 1='Women'
                0='Men';
   value RspFmt 2='Yes'
                1='No'
                0='Uncertain';
run;
data SurveyRes;
   input Exposure Response Count;
   datalines;
1 2 125
1 1 59
1 0 21
0 2 101
0 1 79
0 0 16
;
run;

proc print data=SurveyRes;
run;

*------------------------------------------------------;
* ORDER=DATA option orders the contingency table       ; 
* values by their order in the input data set.         ;

* The TABLES statement requests a two-way table of     ;
* Exposure by Response. The CHISQ option produces      ;
* several chi-square tests, while the RELRISK option   ;
* produces relative risk measures.                     ;

* The EXACT statement requests the exact Pearson       ;
* chi-square test and exact confidence limits for      ;
* the odds ratio.                                      ;
* -----------------------------------------------------;

ods trace on;
ods output "Chi-Square Tests"=Chisquare;
proc freq data=SurveyRes order=data;
   format Exposure ExpFmt. Response RspFmt.;
   tables Exposure*Response / chisq expected relrisk;
   exact pchi;
   weight Count;
   title 'Survey Results on Deciding an In-Debt Marriage';
run;
ods trace off;

* Chi-squred Test;

proc print data=Chisquare; run;

data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x3 Contingency Table";
run;
