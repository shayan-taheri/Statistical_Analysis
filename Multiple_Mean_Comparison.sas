
*--------------------------------------------------------------------;
*Means Comparisons in one-way layout.                                ;
*You are studying the effect of bacteria on the nitrogen content     ;
*of red clover plants, and the analysis of variance shows a highly   ;
*significant effect. The following statements create the data set    ;
*and compute the analysis of variance as well as Tukey’s multiple    ;
*comparisons test for pairwise differences between bacteria strains  ; 
*--------------------------------------------------------------------;

title1 'Nitrogen Content of Red Clover Plants';
data Clover;
input Strain $ Nitrogen @@;
datalines;
3DOK1  19.4 3DOK1  32.6 3DOK1  27.0 3DOK1  32.1 3DOK1  33.0
3DOK5  17.7 3DOK5  24.8 3DOK5  27.9 3DOK5  25.2 3DOK5  24.3
3DOK4  17.0 3DOK4  19.4 3DOK4   9.1 3DOK4  11.9 3DOK4  15.8
3DOK7  20.7 3DOK7  21.0 3DOK7  20.5 3DOK7  18.8 3DOK7  18.6
3DOK13 14.3 3DOK13 14.4 3DOK13 11.8 3DOK13 11.6 3DOK13 14.2
COMPOS 17.3 COMPOS 19.4 COMPOS 19.1 COMPOS 16.9 COMPOS 20.8
;
run;

options nodate nonumber;
proc print data=Clover; 
run;

ods trace on;
ods output "Comparisons"=Compare;
proc anova data=Clover;
     class Strain;
     model Nitrogen = Strain;
     means Strain / tukey;
run;
ods trace off;

proc print data=compare; 
title "Multiple Mean Comparison (One-Way ANOVA)"; 
run;
