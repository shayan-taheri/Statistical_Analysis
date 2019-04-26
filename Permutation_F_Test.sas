
*--------------------------------------;
*Permutation F test for car wax data   ;
*--------------------------------------;
data test; input g1 g2 g3;
cards;
44 40 50
45 42 53
46 51 58
47 52 59
48 55 .
49 .  .
;
run;

data a1(keep=group days)
     a2(keep=group days) 
     a3(keep=group days);  set test;
group=1;
days=g1;
output a1;
group=2;
days=g2;
output a2;
group=3;
days=g3;
output a3;
run;

data PMF; set a1 a2 a3;
if days > .z;
run;

*-------------------------------------------------------------------------------;
*Permutation F test, Kruskal-Wallis Test, and One-ay ANOVA from Proc NPAR1WAY   ;
*-------------------------------------------------------------------------------;
ods output  "Monte Carlo Estimate for the Exact Test"=permu;
ods output  "ANOVA"=ANOVAout;
ods output  "Kruskal-Wallis Test"=KWtest;
proc npar1way data = PMF wilcoxon scores=data anova;
   class group ;
   var days;
   exact scores = data /n = 20000 seed=123456;
run ;

proc print data=KWtest noobs;
var Label1 cValue1 ; 
title "Kruskal-Wallis Test Results (CAR WAX DATA)";
run;

proc print data=ANOVAout noobs; 
var Source DF SS MS FValue ProbF; 
title "One-way ANOVA Results(CAR WAX DATA)";
run;
 
proc print data=permu noobs; 
var Label1 cValue1;
title "Permutaion F Test Results(CAR WAX DATA)";
run;


