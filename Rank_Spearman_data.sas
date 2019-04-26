
*Rank data using SAS;

data scatter; input id x y;
cards;
1 12 7.7
2 15 8.1
3 35 6.9
4 21 8.2
5 20 8.6
6 17 8.3
7 19 9.4
8 46 7.8
9 20 8.3
10 25 5.2
11 39 6.4
12 25 7.9
13 30  8
14 27 6.1
15 29 8.6
;
run;

***********************************************;
*Rank the data using SAS rank procedure        ;
*Usung mean to deal with ties                  ;
***********************************************;

proc rank data=scatter out=rank_scatter ties=mean;
   var x y;
   ranks x_Rank y_Rank;
run;

proc print data=rank_scatter;
title "Rank of X and Y";
run;

*Calculate the Spearman correlation;

data rank_scatter; set rank_scatter;
d=(y_rank-x_rank);
d_square=d**2;
run;

proc print data=rank_scatter; run;

proc means data=rank_scatter noprint;
var d_square;
output out=a(drop=_freq_ _type_) sum=d_square n=n;
run;

proc print data=a; run;

data a; set a;
r_s=1-6*d_square/(n*(n*n-1));
run;

proc print data=a;
title "Calculation of Spearman Correlation";
run;


*Using SAS proceedure CORR to compute spearman correlation;

proc corr data=scatter spearman;
   var x;
   with y;
   run;
