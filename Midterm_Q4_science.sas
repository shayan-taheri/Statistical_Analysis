* Statistical Analysis -- Mid-Term Project: Question 4
* Define a library path where the dataset exists;
* Means Comparisons in one-way layout. ;

* Create the data set;
* Compute the analysis of variance;
* Compute the Dunnett's test;
* Comparisons test for pairwise differences between groups; 

libname libsas 'C:\Users\shaya\Desktop\Midterm_Project';

ods trace on;
ods output "Comparisons"=Compare;
proc anova data=libsas.schdata;
     class gender;
     model science = gender;
     means gender / dunnett;
run;
ods trace off;

proc ttest data=libsas.schdata sides=2 alpha=0.05 h0=0;
 	class gender; 
	var science;
run;

proc npar1way wilcoxon correct=no data=libsas.schdata;
	class gender;
	var science;
run;
