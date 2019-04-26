
*---------------------------------------------------------------------;
*Signed Rank test can be carried out in SAS PROC UNIVARIATE.          ;                                      ;
*---------------------------------------------------------------------; 

DATA Stest;
INPUT A B @@;
Sign=A-B;
CARDS;
1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5
2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2
;
run;

proc print data=Stest; run;

ods trace on;
ods output "Tests For Location"=SignTest; 
ods output "Quantiles"=Quantile;
PROC UNIVARIATE DATA=Stest LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR sign;
RUN;
ods trace off;


proc print data=SignTest; run;

*-----------------------------------------------;
*Output data set of sign test and  p-value      ;
*-----------------------------------------------;

data signtest; set signtest;
if test="Signed Rank";                            
keep Test Testlab Stat  pType pValue  Mu0;
run;

proc print data=signtest noobs;
title "Sign test using Proc Univariate";
run;

*--------------------------------;
*report result using proc report ;
*--------------------------------;
option nodate nonumber;
ods rtf file = "C:\Xin Yan Folders\UCF\STA5206\SAS examples\Sign_sum_example.rtf";
title1 'Using Proc REPORT to Print Results';
proc report data=signtest nowd split="*" center;
columns Test Testlab Stat pType pValue  Mu0;
define  test       / display  'Test'               width=10 center;
define  testlab    / display  'Lable for*Test'     width=10  center;
define  stat       / display  'Statistic '         width=10  f=5.3 center;
define  pType      / display  'P-Value*Definition' width=30         center;
define  pValue     / display  'P-Value of*Test'    width=10  f=5.3 center;
define  Mu0        / display  'Test for*Median'    width=10  f=5.2 center;
run;
ods rtf close;

