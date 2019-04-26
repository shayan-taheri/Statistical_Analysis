
*************************************;
*Example of Kolmogorove Smirnov test ;
*Test for two distributions          ;
*************************************;

data ingot; input group weight;
cards;
     1 15.7
     1 16.1 
     1 15.9
     1 16.2
     1 15.9
     1 16.0
     1 15.8
     1 16.1
     1 16.3
     1 16.5
     1 15.5
     2 15.4
     2 16.0 
     2 15.6
     2 15.7
     2 16.6
     2 16.3
     2 16.4
     2 16.8
     2 15.2
     2 16.9
     2 15.1
;
run;

proc print data=ingot noobs;
run;

title "Kolmogorove Smirnov test";
ods graphics on;
proc univariate data = ingot normal;
  class group;
  var weight;
  histogram / kernel normal;
run;


*Test two distributions using Kolmogorov-Smirnov Test(asymptotic); 
ods output "Kolmogorov-Smirnov Test"=KStest;
ods output  "EDF Plot"=EDF;
proc npar1way data = ingot;
class group;
var weight;
run;

proc print data=KStest; run;
proc print data=EDF; run;


options nodate nonumber;
ods rtf file="U:\Xin Yan Folder\UCF Teaching\STA5206\Lecture Notes\Lecture notes 11\EDFPlot.rtf";
symbol1 i=join value=square   c=steelblue h=1.5;
symbol2 i=join value=circle   c=red       h=1.5;
axis1 label=("Weight" f=simplex h=2) order=(15 to 17 by 0.2);
axis2 label=("Probability"  f=simplex  h=2 rotate=180) order=(0 to 1 by 0.1);
title1 "Empirical Distribution Function Plot";

proc gplot data=EDF;
   plot _EDF*_X=_class/ haxis=axis1
                        vaxis=axis2 
                        hminor=1
                        vminor=1
                        vref=0.2 0.5 0.8
						href=15.4 16 16.6
                        lvref=2;
run;
quit;
ods rtf close;



















proc gplot data=EDF;
plot _EDF* _X /overlay;
run;
