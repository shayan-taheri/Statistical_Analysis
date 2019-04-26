
***************************************************;
*SAS code for Homework on Fisher's exact tes  t    ;
*Note: Control SAS output to print desired output  ;
***************************************************;

*Problem 1;

data product;
  input a b count;
  cards ;
  0 0 95
  0 1 41
  1 0 55
  1 1 109  
  ;
run;


ODS SELECT NONE;   *deactivate print from prodedure but generate output data sets;
ods output "Chi-Square Tests" =Chisquare;
ods output "Fisher's Exact Test"=FisherTest; 
 proc freq data = product order = data ;
  tables a*b / chisq nopercent norow nocol ;
  exact pchi ;
  weight count ;
  run ;
quit;


*Chisqure test;
option nodate nonumber;
ODS SELECT ALL ; *recover print function;
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x2 Contingency Table (Problem 1)";
run;

data exact1; set FisherTest;
if _n_ in (5, 6);
drop Table Name1  nValue1;
run;

proc print data=exact1 noobs; 
title "Output of Fisher Exact Test (peoblem 1)";
run;

*Problem 2;
data product;
  input a b count;
  cards ;
  0 0 10
  0 1 12
  1 0 2
  1 1 26  
  ;
run;


ods select none;
ods output "Chi-Square Tests" =Chisquare;
ods output "Fisher's Exact Test"=FisherTest; 
 proc freq data = product order = data ;
  tables a*b / chisq nopercent norow nocol ;
  exact pchi ;
  weight count ;
  run ;
quit;


*Chisqure test;
option nodate nonumber;
ODS SELECT ALL ;
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x2 Contingency Table (Problem 2)";
run;


data exact1; set FisherTest;
if _n_ in (5, 6);
drop Table Name1  nValue1;
run;


proc print data=exact1 noobs; 
title "Output of Fisher Exact Test (peoblem 2)";
run;


*Problem 3;
data product;
  input a b count;
  cards ;
  0 0 25
  0 1 8
  1 0 3
  1 1 6  
  ;
run;

ods select none;
ods output "Chi-Square Tests" =Chisquare;
ods output "Fisher's Exact Test"=FisherTest; 
 proc freq data = product order = data ;
  tables a*b / chisq nopercent norow nocol ;
  exact pchi ;
  weight count ;
  run ;
quit;


*Chisqure test;
option nodate nonumber;
ODS SELECT ALL ;
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

proc print data=Chisq; 
title "Chisqure Test of 2x2 Contingency Table (Problem 3)";
run;

data exact1; set FisherTest;
if _n_ in (5, 6);
drop Table Name1  nValue1;
run;

proc print data=exact1 noobs; 
title "Output of Fisher Exact Test (peoblem 3)";
run;



