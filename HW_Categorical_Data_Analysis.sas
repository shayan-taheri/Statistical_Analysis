
*----------------------------------------------------------------;
*SAS PGM for HW (Categorical Data Analysis)                      ;
*----------------------------------------------------------------;

proc format;
   value identify    0='Can Identify Product'
                     1='Cannot Identify Product';
   value gender      0='Male'
                     1='Femal';
run;

data problem1;
   input  identify gender count;
   datalines;
0 0  95
0 1  41
1 0  55
1 1  109
;
run;

ods output "Chi-Square Tests"=Chisquare;
proc freq data=problem1 order=data;
   format identify identify. gender gender.;
   tables  identify*gender / chisq ;
   weight count;
   title 'Problem 1';
run;

*Chisqure test (with and without continuity correction);
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

options nodate nonumber;
proc print data=Chisq noobs; 
title "Chisqure Test of 2x2 Contingency Table (Problem 1)";
run;

*-------------------------------;
*Problem 2                      ;
********************************;

proc format;
   value work        0='worked'
                     1='did not work';
   value health      0='ill'
                     1='well';
run;

data problem2;
   input  work health count;
   datalines;
0 0  10
0 1  12
1 0  2
1 1  26
;
run;

*The minimum expected count in the table is >5, Chisqre test is appropriate;

ods output "Chi-Square Tests"=Chisquare;
proc freq data=problem2 order=data;
   format work work. health health.;
   tables  work*health / chisq ;
   weight count;
   title 'Problem 2';
run;

*Chisqure test (with and without continuity correction);
data Chisq; set chisquare;
if statistic in ("Chi-Square","Continuity Adj. Chi-Square");
drop table;
run;

options nodate nonumber;
proc print data=Chisq noobs; 
title "Chisqure Test of 2x2 Contingency Table (Problem 2)";
run;

*--------------------;
*Proble 3            ;
*--------------------;

proc format;
   value salad       0='ate'
                     1='did not ate';
   value health      0='ill'
                     1='well';
run;

data problem3;
   input  salad health count;
   datalines;
0 0  25
0 1  8
1 0  3
1 1  6
;
run;

*------------------------------------------;
*Calculate 2x2 tableprobabilities          ;
*according to hypergeometric distribution  ;
*------------------------------------------;

data aa; 
format p f16.14;
do x=0 to 9;
N=42;
R=28;
nn=9;
x=x;
p=PDF('HYPER', x, 42, 28, 9);
output;
end;
run; 

proc sort data=aa;
by p;
run;

options nodate nonumber;
proc print data=aa noobs;
var x p;
title "2x2 table probabilities";
run;

data aa1; set aa;
if x< =3;
run;

proc means data=aa1 noprint;
var p;
output out=aa2(keep=n sum) n=n sum=sum; 
run;

data aa2; set aa2;
p_value=2*sum;
run;

proc print data=aa2; 
title "Calculate two-sided p-value based on hypergeometric distribution";
run;

*There is one cell with expected count <5. Fisher's exact test is appropriate;
ods output "Fisher's Exact Test"=Fisher; 
proc freq data=problem3 order=data;
   format salad salad. health health.;
   tables  salad*health / fisher ;
   weight count;
   title 'Problem 3';
run;

*Chisqure test (with and without continuity correction);
data Fisher; set Fisher;
if _n_ in (2,3,5,6);
drop Table Name1  nValue1;
run;

options nodate nonumber;
proc print data=Fisher; run;
title "Fisher's Exact Test (Problem 3)";
run;
