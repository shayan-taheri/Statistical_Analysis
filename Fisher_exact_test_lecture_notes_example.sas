

*Fisher’s exact test for CVD example in the lecture notes;
proc format;

value cause 
      1='CVD'
      0='Non-CVD';

value salt 
      1='Low'
      0='High';
run;



data CVD;
input cause salt Count;
datalines;
0 0 2
0 1 23
1 0 5
1 1 30
;
run;

proc print; run;

ods output "Fisher's Exact Test"=Exact;
proc freq data=CVD order=data;
format cause cause. salt salt.;
tables cause*salt / chisq relrisk;
exact pchi or;
weight Count;
title ’2x2 table analysis of CVD and salt intake data’;
run;


data exact1; set exact;
if _n_ in (2,3,5,6);
drop Table Name1 nValue1; 
run;


proc print data=exact1 noobs;
title "Output of Fisher Exact Test";
run;



*Simpler code;
proc freq data=CVD;
tables cause*salt/exact;
weight count;
run;
