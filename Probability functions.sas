******************************;
*SAS probability function     ;
******************************;
data a;
p1=PROBBNML(0.3,6,2);
p2=PROBCHI(5, 10);
p3=PROBF(2.5, 3, 10);
p4=PROBNORM(1.96);
p5=PROBT(2.234, 35);
run;

proc print data=a noobs; 
title "Probability Functions";
run;
