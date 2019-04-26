
*---------------------------------------------------------------------;
*Wilcoxon Signed Rank test can be carried out in SAS PROC UNIVARIATE. ;
*The following code does the analysis for paired sample               ;
*The 95% confidence intervals for the t-test and median               ;
*(quantile=0.5) can be produced using the options:                    ;  
*CIPCTLDF(ALPHA=0.05).                                                ;
*---------------------------------------------------------------------; 

DATA examp1;
INPUT first second;
difference=second-first;
CARDS;
86	88
71	77
77	76
68	64
91	96
72	72
77	65
91	90
70	65
71	80	
88	81	
87	72
;

proc print data=examp1; 
run;

ods trace on;
ods output "Tests For Location"=LocationTest; 
ods output "Quantiles"=Quantile;
ods output "Moments"=Moments;
ods output "Basic Measures of Location and Variability"=Location;
ods output "Extreme Observations"=Extreme;

PROC UNIVARIATE DATA=examp1 LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR difference;
RUN;
ods trace off;

*---------------------------------;
*Some output data sets from ODS   ;
*---------------------------------;
proc print data=Moments;
title "Moments Data";
proc print data=Location;
title "Location Data";
proc print data=Extreme;
title "Extreme";
run; 

*------------------------------------------------------;
*Prepare Wilcoxon Sined Rank Test output data set      ;
*------------------------------------------------------;

data WL_test; set LocationTest;
if test="Signed Rank";
run;

title "test for location";
proc print data = WL_test;
run;

*-----------------------------------------------;
*Output data set of median rank and its 95% CI  ;
*-----------------------------------------------;

data MedianCI; set quantile;
if quantile="50% Median";                            
keep Name Quantile Estimate LCLRank UCLRank;
run;

title "Quantiles and 95% CIs for quantiles";
proc print data=MedianCI;
run;

*--------------------------------------------------;
*Example 9.12, Page337                             ;
*Note that the total rank is 420                   ;
*Proc univariate compute the smaller of the        ; 
*positive rank sum and negative rank sum.          ;
*The total rank sum =410 and the larger rank       ;
*sum=162. The large rank sum=410-162=248.          ;
*--------------------------------------------------;
data sign; input diff rep $;
cards;
-8   1     
-7   3  
-7   ''
-7   ''
-6   2  
-6   ''
-5   2
-5   ''
-4   1   
-3   5     
-3   ''
-3   ''
-3   ''
-3   ''
 3    2   
 3   ''
-2    4  
-2   '' 
-2   ''
-2   ''
 2    6
 2   ''
 2   ''
 2   ''
 2   ''
 2   ''
-1   4 
-1   ''
-1   ''
-1   ''
 1   10 
 1   ''
 1   ''
 1   ''
 1   ''
 1   ''
 1   ''
 1   ''
 1   ''
 1   ''
;  
run;

proc print data=sign; 
run;



PROC UNIVARIATE DATA=sign LOCATION=0;
VAR diff;
output out=outputdata median=median  SIGNRANK=signrank_statistic PROBS=P_Value_Median PROBN=P_Value_Normality; 
RUN;

proc print data=outputdata; 
title "Wicoxon Signed Rank Test for Median=0 (Paried two-sample nonparametric test)";
run;

*--------------------------------;
*report result using proc report ;
*--------------------------------;

option nodate nonumber;
ods rtf file = "C:\Xin's Folder\UCF\UCF Teaching\STA5206\SAS examples\Wilcoxon_Sign_Rank__example.rtf";
title1 'Using Proc REPORT to Print Results';
proc report data=outputdata nowd split="*" center;
columns median Signrank_Statistic P_Value_Median P_Value_Normality;
define  median               / display  'Median' width=10 center;
define Signrank_Statistic    / display  'Sign Rank * Statistic' width=20 f=5.3 center;
define P_Value_Median        / display  'P-Value for * Median Test' width=20  f=5.3 center;
define P_Value_Normality     / display  'P-Value for * Normality * Test' width=20  f=5.3 center;
run;
ods rtf close;


