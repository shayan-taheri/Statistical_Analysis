
Data example; input district x1 x2 x3 x4 y; 
datalines;

1 5.5 31 10 8 79.3 
1 2.5 55 8 6 200.1 
1 8.0 67 12 9 163.2 
1 3.0 50 7 16 200.1 
2 3.0 38 8 15 146.0 
2 2.9 71 12 17 177.7 
2 8   30 12 8 30.9 
2 9 56 5 10 291.9 
2 4 42 8 4 160 
3 6.5 73 5 16 339.4 
3 5.5 60 11 7 159.6 
3 5 44 12 12 86.3 
3 6 50 6 6 237.5 
3 5 39 10 4 107.2 
3 3.5 55 10 4 155.0
; 
run;

*Histogram with normal curve fitting; 
proc univariate data=example; 
histogram x4 / normal (color=red mu=10 sigma=3.5); 
title "Histogram for Variable X4 with Normal Curve Fitting "; 
run;


*Calcualte descriptive statistics; 
proc univariate data=example; 
var x1 x2 x3 x4 ; 
title "Proc Univariate Output for Variables X1-X4"; 
run;


*Generate plots; 
ods select Plots SSplots; 
proc univariate data=example plot; 
var x1-x4 ; 
title "Proc Univariate Boxplots, Normal Plots, and Stem-leaf-plots for Variables X1-X4"; 
run;



*Generate boxplot using Proc Boxplot; 
title "Boxplot of X4 by district"; 
Proc boxplot data=example; 
plot x4*district; 
run;
