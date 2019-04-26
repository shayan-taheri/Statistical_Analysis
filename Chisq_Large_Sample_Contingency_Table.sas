
*----------------------------------------------------------------;
*Chisqure test for contingency table (Large Sample Example)      ;
*----------------------------------------------------------------;

proc format;
   value case   1='Case'
                0='Noncase';
   value age    1='>=30'
                0='<=29';
run;

data cancer;
   input case age Count;

   datalines;
0 0  683
0 1  2537
1 0  1498
1 1  8747
;
run;

proc print data=cancer;
run;

ods trace on;
ods output "Chi-Square Tests"=Chisquare;
proc freq data=cancer order=data;
   format case case. age  age.;
   tables case*age / chisq relrisk;
   weight Count;
   title 'Breast Cancer and Age of First Birth Study';
run;
ods trace off;

*Chisqure test (with and without continuity correction);
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

options nodate nonumber;
proc print data=Chisq noobs; 
title "Chisqure Test of 2x2 Contingency Table";
run;

