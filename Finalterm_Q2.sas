* Statistical Analysis -- Final Project: Question 2;

* ---------------------------------------------------------------------;
* An agriculture experiment --> 4 varieties of sweet potatoes          ;
* The experiment is randomized                                         ;
* (a) Are the yields of the four varieties the same?                   ;
* (b) Testing whether the varieties C and D are the same?              ;
* ---------------------------------------------------------------------;

data example;
input g1 g2 g3 g4;
cards;
8.3 9.1 10.1 7.8
9.4 9.0 10.0 8.2
9.1 8.1 9.6 8.1
9.1 8.2 9.3 7.9
9.0 8.8 9.8 7.7
8.9 8.4 9.5 8.0
8.9 8.3 9.4 8.1
;
run;

* Compute the means and the medians of the four varieties;
ods select none;
proc means data=example;
var g1 g2 g3 g4;
output out=a mean=mean1 mean2 mean3 mean4 median=med1 med2 med3 med4;
run;

proc univariate data=example;
 histogram g1 g2 g3 g4;
run;

ods select all;
proc print data=a noobs; 
var mean1 mean2 mean3 mean4 med1 med2 med3 med4; 
title "Means and Medians of the Four Varieties";
run;

data xx1 xx2 xx3 xx4; set example;

group="Variety A";
y=g1;
output xx1;

group="Variety B";
y=g2;
output xx2;

group="Variety C";
y=g3;
output xx3;

group="Variety D";
y=g4;
output xx4;
run;

data WAll; set xx1 xx2 xx3 xx4;
run;

ods trace on;
ods output "Scores"=WSAll;
ods output "Kruskal-Wallis Test"=W1All;
proc npar1way wilcoxon correct=yes data=WAll;
   class group;
   var y;
title "Wilcoxon Distribution Information for All Varieties"; 
run;
ods trace off;

proc print data=WSAll noobs;
var Variable Class N SumOfScores StdDevOfSum MeanScore; 
title "Kruskal-Wallis Test Scores for All Varieties";  
run;

proc print data=W1All noobs;
var Variable Name1 Label1 cValue1; 
title "Kruskal-Wallis Test Statistics for All Varieties";
run;

* Perform Wilcoxon test on equality of distributions in the data for varieties C and D;

data aa3 aa4; set example;

group="Variety C";
y=g2;
output aa3;

group="Variety D";
y=g3;
output aa3;
run;

data W; set aa3 aa4;
run;


* Perform Kruskal-Wallis test to compare distributions between varieties C and D;
ods select none;
ods output "Scores"=WS;
ods output "Kruskal-Wallis Test"=W1;
proc npar1way wilcoxon correct=yes data=W;
   class group;
   var y;
run;

ods select all;
proc print data=WS noobs;
var Variable Class N SumOfScores StdDevOfSum MeanScore; 
title "Kruskal-Wallis Test Scores for Varieties C and D"; 
run;

proc print data=W1 noobs;
var Variable Name1 Label1 cValue1; 
title "Kruskal-Wallis Test Statistics for Varieties C and D";
run;
