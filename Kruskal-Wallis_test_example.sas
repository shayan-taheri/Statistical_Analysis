
*--------------------------------------------;
*Example 1                                   ;
*SAS code for example in lecture notes 11    ;
*Example of analysis of eye-lid closure data ;
*--------------------------------------------;

data aa; input a b c d;
cards;
2 1 3  1
3 3 1  0
3 1 2  0
3 2 1  0
3 2 3  0
0 3 3 -1
;
run;

title;
proc print data=aa; run;

*create a data set with two variables score and class;
data aa1(keep=class score) 
aa2(keep=class score) 
aa3(keep=class score) 
aa4(keep=class score); set aa;
score=a;
class="Idome";
output aa1;
score=b;
class="Asprin";
output aa2;
score=c;
class="Pirox";
output aa3;
score=d;
class="BW755C";
output aa4;
run;

data bb; set aa1-aa4;
keep class score;
run;

proc print data=bb; 
run;


ods select none;
ods output "Scores"=WS;
ods output "Kruskal-Wallis Test"=W1;
proc npar1way wilcoxon correct=yes data=bb;
   class class;
   var score;
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


*---------------------------------------------------------------------;
*Example 2                                                            ;
*The data set Gossypol contains the variable Dose, the amount of      ;
*gossypol additive, and the variable Gain, the weight gain.           ;                    ;
*---------------------------------------------------------------------;

data Gossypol;
   input Dose n @@;
      do i=1 to n;
      input Gain @@;
      output;
      end;
   datalines;
0    16    228 229 218 216 224 208 235 229 233 219 224 220 232 200 208 232
.04  11    186 229 220 208 228 198 222 273 216 198 213
.07  12    179 193 183 180 143 204 114 188 178 134 208 196
.10  17    130 87 135 116 118 165 151 59 126 64 78 94 150 160 122 110 178
.13  11    154 130 130 118 118 104 112 134 98 100 104
;
run;

*************************************************************;
*5 dose levels  0, 0.04, 0.07, 0.10, 0.13                    ;  
*Sample size for 5 dose levels are  16, 11, 12, 17, and 11   ;
*Weight gain is the response variable                   ;
*************************************************************; 

title;
proc print data=Gossypol noobs; 
title "Weight Gain Data";
run;


*--------------------------------------------------------;
*Researchers are interested in whether there is a        ;
*difference in weight gain among animals receiving       ;
*different dose levels of gossypol. The following        ;
*SAS codes invoke the NPAR1WAY procedure to perform      ;
*the Kruskal-Wallis test.                                ;  
*--------------------------------------------------------;

*ods trace on;
ods output "Scores"=WScore1;
ods output "Kruskal-Wallis Test"=Wtest1; 
proc npar1way wilcoxon correct=yes data=Gossypol;
   class Dose;
   var Gain;
run;
quit;
*ods trace off;

title "Comapre mean wqeight gain among five dose levels (scores)";
proc print data=Wscore1 noobs;
var Variable Class N MeanScore StdDevOfSum;
run;

title "Comapre mean weight gains among five dose levels (Kruskal-Wallis test)";
proc print data=Wtest1 noobs;
var Label1 cValue1; 
run;

*--------------------------------------------------------;
*If we want to test two out of five gossypol levels take ;
*a subset of the data and use the npar1way to comapre    ;
*means between two groups.                               ;
*--------------------------------------------------------;

data test; set Gossypol;
if dose =0.00 or dose=0.13;
run;

proc print data=test; run;

ods select none;
ods output "Scores"=WScore2;
ods output "Kruskal-Wallis Test"=Wtest2;
proc npar1way wilcoxon correct=yes data=test;
   class Dose;
   var Gain;
run;
quit;
ods select all;

title "Comapre mean weight gains between two dose levels (scores)";
proc print data=Wscore2 noobs;
var Variable Class N MeanScore StdDevOfSum;
run;

title "Comapre mean weight gains between two dose levels";
proc print data=Wtest2 noobs;
var Label1 cValue1; 
run;
title;



