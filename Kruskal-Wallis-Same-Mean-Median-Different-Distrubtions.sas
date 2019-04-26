

*--------------------------------------------------;
*This example provide data for three groups with   ;
*same means and same median. However the p-value   ;
*from Kruskal-Wallis test is 0.0253 that indicates ;
*there is statistically siginificant difference    ;
*among the three distributions.                    ;
*--------------------------------------------------;

data example;
input g1 g2 g3;
cards;
1 10 19
2 11 20
3 12 21
4 13 22
5 14 23
6 15 24
7 16 25
8 17 26
9 18 27
46 37 28
47 58 65
48 59 66
49 60 67
50 61 68
51 62 69
52 63 70
53 64 71
342 193 72
;
run;

*compute the means and medians of the three groups;
ods select none;
proc means data=example;
var g1 g2 g3;
output out=a mean=mean1 mean2 mean3 median=med1 med2 med3;
run;

proc univariate data=example;
 histogram g1 g2 g3;
run;

ods select all;
proc print data=a noobs; 
var mean1 mean2 mean3 med1 med2 med3; 
title "Means and medians from three groups";
run;

*Perform Wilcoxon test on equality of distributions from three groups;

data aa1 aa2 aa3; set example;
group="group1";
y=g1;
output aa1;

group="group2";
y=g2;
output aa2;

group="group3";
y=g3;
output aa3;
run;

data W; set aa1 aa2 aa3;
run;


*perform Kruskal-Wallis test to conpare distributions;
ods select none;
ods output "Scores"=WS;
ods output "Kruskal-Wallis Test"=W1;
proc npar1way wilcoxon correct=yes data=W;
   class group;
   var y;
run;

ods select all;
proc print data=WS noobs;
format SumOfScores StdDevOfSum MeanScore 6.2;
var Class N SumOfScores StdDevOfSum MeanScore; 
title "Scores of each group"; 
run;

proc print data=W1 noobs;
format cValue1 $6.;
var Variable Name1 Label1 cValue1; 
title "Kruskal-Wallis Test for means";
run;




