
*Example of Power Calculation;
data size; input n @@;
cards;
10 20 30 40 50 60 70 80 90 100
;
run;

proc print; run;

data size; set size;
cutoff1=sqrt(n)*0.5/2-1.96; 
cutoff2=sqrt(n)*0.75/2-1.96;
cutoff3=sqrt(n)*1/2-1.96;
power1=CDF('normal', cutoff1);
power2=CDF('normal', cutoff2);
power3=CDF('normal', cutoff3); 
run;

proc print data=size; run;

options nodate nonumber;
ods rtf file = "C:\Xin Yan Folders\UCF\STA5206\SAS examples\Power.rtf";
proc print data=size noobs;
var n power1 power2 power3;
title "Powers of tests for detactable difference d=0.5, 0.75 and 1.0";
footnote1 "It needs larger sample size to detect a smaller difference.";
footnote2 "A large sample size results in a higher test power."; 
run; 

goptions reset = all;
legend1 across=3 value=('d=0.5' 'd=0.75' 'd=1.0');
symbol1 i = join v="square"   c=blue  l = 1;
symbol2 i = join v="square"   c=red   l = 21;
symbol3 i = join v="square"   c=green l = 31;
axis1 order=(10 to 100 by 10) offset=(2,2)
      label=("Sample Size")   minor=none;
axis2 order=(0 to 1 by 0.2)   offset=(1,1)
      label=(a=90 "Test Power") minor=none;

title1 h=1 "Test Power for Sample Sizes n";
title2 h=1 "(Alpha=0.05)";

proc gplot data=size;
plot power1*n power2*n power3*n /overlay legend=legend1 
                                 haxis=axis1 vaxis=axis2;
run;
ods rtf close;
