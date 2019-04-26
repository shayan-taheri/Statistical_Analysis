
*----------------------------------------------;
*Analysis example of Student paired diet data  ;
*----------------------------------------------;
DATA diet;
INPUT m1 m2;
Sign=m1-m2;
CARDS;
1530    1290 
2130    2250
2940    2430
1960    1900
2270    2120
;
run;

proc print data=diet; 
run;

ods select none;
ods output "Tests For Location"=SignTest; 
PROC UNIVARIATE DATA=diet LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR sign;
RUN;

ods select all;
proc print data=Signtest noobs; 
where test="Signed Rank";
var Test Stat pType pValue;
title "Signed Rank Test for Student Paired Diet Survey Data";
run;
