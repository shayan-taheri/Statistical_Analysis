* Statistical Analysis -- Final Project: Question 1;

* ---------------------------------------------------------------------;
* 12 Adults --> A liquid diet in a weight-reducing plan                ;
* Data 1 = Weights Before Diet and Data 2 = Weights After Diet         ;
* Is the plan successful?                                              ;
* Using the Wilcoxon Signed Rank Test                                  ;
* In the SAS PROC UNIVARIATE --> Analysis for the paired sample        ;
* The 95% confidence intervals for the t-test and median               ;
* quantile=0.5 can be produced using the options: CIPCTLDF(ALPHA=0.05) ;
* CIPCTLDF(ALPHA=0.05)                                                 ;
* ---------------------------------------------------------------------;

DATA Q1_Data;
INPUT Before After;
Difference=Before-After;
CARDS;
186	188
171	177
177	176
168	169
191	196
172	172
177	165
191	190
170	166
171	180	
188	181	
187	172
;

proc print data=Q1_Data; 
run;

ods trace on;
ods output "Tests For Location"=LocationTest; 
ods output "Quantiles"=Quantile;
ods output "Moments"=Moments;
ods output "Basic Measures of Location and Variability"=Location;
ods output "Extreme Observations"=Extreme;

PROC UNIVARIATE DATA=Q1_Data LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR Difference;
RUN;
ods trace off;

*---------------------------------;
* Output Data Sets from ODS       ;
*---------------------------------;
proc print data=Moments;
title "Moments Data";
proc print data=Location;
title "Location Data";
proc print data=Extreme;
title "Extreme";
run; 

*------------------------------------------------------;
* Prepare Wilcoxon Sined Rank Test Output Data Set     ;
*------------------------------------------------------;

data WL_test; set LocationTest;
if test="Signed Rank";
run;

title "Test for Location";
proc print data = WL_test;
run;

*-----------------------------------------------;
* Output Dataset of Median Rank and its 95% CI  ;
*-----------------------------------------------;

data MedianCI; set quantile;
if quantile="50% Median";                            
keep Name Quantile Estimate LCLRank UCLRank;
run;

title "Quantiles and 95% CIs for Quantiles";
proc print data=MedianCI;
run;

proc means data=Q1_Data;
var Before After;
output out=BA mean=MeanB MeanA median=MedianA MedianB;
run;

ods select all;
proc print data=BA noobs; 
var MeanB MeanA; 
title "Means and Medians of Before and After Weights";
run;
