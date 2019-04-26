
***************************************;
*Wilcoxon rank sum test using SAS      ;
*CLASS---1: DOMINANT, 2--SEX-LINKED    ;
***************************************;

*read raw data;

data ranksum; input VISUAL $ CLASS;
datalines;
20-20      1
20-20      1
20-20      1
20-20      1
20-20      1
20-20      2
20-25      1
20-25      1
20-25      1
20-25      1
20-25      1
20-25      1
20-25      1
20-25      1
20-25      1
20-25      2
20-25      2
20-25      2
20-25      2
20-25      2
20-30      1
20-30      1
20-30      1
20-30      1
20-30      1
20-30      1
20-30      2
20-30      2
20-30      2
20-30      2
20-40      1
20-40      1
20-40      1
20-40      2
20-40      2
20-40      2
20-40      2
20-50      1 
20-50      1 
20-50      2
20-50      2
20-50      2
20-50      2
20-50      2
20-50      2
20-50      2
20-50      2 
20-60      2
20-60      2
20-60      2
20-60      2
20-60      2
20-70      2
20-70      2
20-80      2
;
run;

proc print; run;
*prepare data for analysis;

data ranksum; set ranksum;
if visual ="20-20" then VA=1;
if visual ="20-25" then VA=2;
if visual ="20-30" then VA=3;
if visual ="20-35" then VA=4;
if visual ="20-40" then VA=5;
if visual ="20-45" then VA=6;
if visual ="20-50" then VA=7;
if visual ="20-60" then VA=8;
if visual ="20-70" then VA=9;
if visual ="20-80" then VA=10;
run;

proc print data=ranksum; run;

***************************************************;
*Call SAS procedure NP1WAY to perform Wicoxon      ;
*rank sum test                                     ;
***************************************************;
proc npar1way  wilcoxon correct=yes  data = ranksum;
  class CLASS;
  var VA;
run;

*------------------------------------------------------------;
*Use ODS data set label to create desired output data set    ;
*Actual label name can be found from the SAS log file when   ;
*the ODS trace function is activated (ods trace on) when     ;
*option is specified                                         ;
*------------------------------------------------------------;

ods trace on;
ods output "Two-Sample Test"=Wtest;
ods output "Scores"=Wscore;
proc npar1way  wilcoxon correct=yes  data=ranksum;
  class CLASS;
  var VA;
run;
ods trace off;

proc print data=Wtest;
title1 "Wilcoxon Rank Sum Test---Test Statistic and P-value Output";
title2 "Using Outout Deliveray System (ODS)";
run;

proc print data=Wscore;
title1 "Wilcoxon Rank Sum Test---Score Output";
title2 "Using Outout Deliveray System (ODS)";
run;


*-----------------------------------------------------;
*ODS output table using ods output data set name      ;
*-----------------------------------------------------;
ods trace on;
proc npar1way  wilcoxon correct=yes  data=ranksum;
  class CLASS;
  var VA;
ods output WilcoxonScores=WL_Score WilcoxonTest=WL_test ;
run;
ods trace off;

proc print data=Wtest;
title1 "Wilcoxon Rank Sum Test---Test Statistic and P-value Output";
title2 "Using Outout Deliveray System (ODS)";
run;

proc print data=Wscore;
title1 "Wilcoxon Rank Sum Test---Score Output";
title2 "Using Outout Deliveray System (ODS)";
run;
