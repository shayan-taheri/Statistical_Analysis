
*----------------------------;
*SAS code for HW1 problems   ;
*----------------------------;

*Problems in the lecture notes;
*Second proble;
DATA Stest(drop=i);
do i=20 to 60;
n=i; 
output;
end;
run;

data CI; set stest;
min=ceil(n/2-1.96*sqrt(n/4));
max=floor(n/2+1.96*sqrt(n/4));
run;

*Or you can add correction 0.5 to the calcualation;
data CI1; set stest;
min=ceil(n/2-1.96*sqrt(n/4) -0.5);
max=floor(n/2+1.96*sqrt(n/4)+0.5);
run;

option nodate nonumber;
ods rtf file = "C:\Xin Yan Folders\UCF\STA5206\SAS examples\Sign_test_example.rtf";
title1 'Lower and Upper Bound For Sign Test of Sample Sizes From 40 to 60';
proc report data=CI nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;

title1 'Minimum and Maximum Numbers for Sign Test With Continuity Correction';
proc report data=CI1 nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;
ods rtf close;


*Homework 9.15-9.18;
DATA examp1;
INPUT first second @@;
difference=second-first;
CARDS;
20 18 11 35 3 7 24 182 7 6 28 33 58	223 7 7 
39  57 17 76 17 186 12 29 52 39 14 15 12 21 30	
28 7 8 15 27 65	77 10 12 7 8 19	16 34 28 25	20
;

ods output "Tests For Location"=LocationTest; 
ods output "Quantiles"=Quantile;
PROC UNIVARIATE DATA=examp1 LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR difference;
RUN;

data WL_test; set LocationTest;
if test="Signed Rank";
run;

title "test for location (Problem 9.15-9.18)";
proc print data = WL_test;
run;

data MedianCI; set quantile;
if quantile="50% Median";                            
keep Name Quantile Estimate LCLRank UCLRank;
title "Quantiles and 95% CIs for quantiles";
proc print data=MedianCI;
run;

*Homework 9.51-9.52;
data serum; input SERUM ETHNIC @@; 
datalines;
94	0 54	1 31	0 21	1 46	1 56	0 18	1 19	1  12	1 
14	0 25	0 35	1 22	1 71	0 43	1 35	1  42	1 50	1 
44	1 41	0 28	0 65	0 31	0 35	1 91	1
;
run;

proc freq data=serum;
tables ETHNIC;
run; 

ods output "Two-Sample Test"=Wtest;
ods output "Scores"=Wscore;
proc npar1way  wilcoxon correct=yes  data = serum;
class ETHNIC;  
var SERUM;
run;

data Wtest1; set Wtest;
if name1 in ("_WIL_", "Z_WIL",  "P2_WIL" );
run;

proc print data=Wtest1 noobs;
var Name1  Label1  cValue1;
title1 "Wilcoxon Rank Sum Test---Test Statistic and P-value Output";
run;

proc print data=Wscore;
title1 "Wilcoxon Rank Sum Test---Score Output";
run;

*----------------------------------;
*Output HW1 Result to an rtf file  ;
*----------------------------------;

option nodate nonumber;
ods rtf file = "C:\Xin Yan Folders\UCF\STA5206\SAS examples\HW1_Solution.rtf";
title1 'Lower and Upper Bound For Sign Test of Sample Sizes From 40 to 60';
title2 '(Without Continuity Correction)';
proc report data=CI nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;

title1 'Lower and Upper Bound For Sign Test of Sample Sizes From 40 to 60';
title2 '(With Continuity Correction)';
proc report data=CI1 nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;

title "Test for Location (Problem 9.15-9.18)";
proc report data=WL_test nowd split="*";
columns Test Stat  pType   pValue;
define  test    / display  'Test'              width=10  center;
define  Stat    / display  'Observed*Value'    width=10  center;
define  pType   / display  'Test Type'         width=10  center;
define  pValue   / display  'P-Value'          width=10  center;
run;

title "Test for Distributions (Problem 9.51-9.52)";
proc report data=Wtest1 nowd split="*";
columns Name1  Label1  cValue1;
define  name1    / display  'Name'              width=10  center;
define  labe1    / display  'Label'             width=10  center;
define  cValue   / display  'Value'             width=10  center;
run;
ods rtf close;








