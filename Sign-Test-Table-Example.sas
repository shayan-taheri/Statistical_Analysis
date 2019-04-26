
*---------------------------------------------------------------------;
*Compute Minumu (min) and Maximu (max) numbers for Signed Test        ;  
*Note that if observed counts X satisfies min < X < max then          ;
*Median=0  will be confirmed at a level of 95%.                       ;
*---------------------------------------------------------------------; 

DATA Stest(drop=i);
do i=20 to 60;
n=i; 
output;
end;
run;

data CI; set stest;
min=ceil(n/2-1.96*sqrt(n/4));
max=floor(n/2+1.96*sqrt(n/4));
run;

proc print data=CI; run;

*Or you can add correction 0.5 to the calcualation;

data CI1; set stest;
min=ceil(n/2-1.96*sqrt(n/4) -0.5);
max=floor(n/2+1.96*sqrt(n/4)+0.5);
run;

proc print data=CI1; run;

*--------------------------------;
*report result using proc report ;
*--------------------------------;

option nodate nonumber;
ods rtf file = "C:\Xin Yan Folders\UCF\STA5206\SAS examples\Sign_test_example.rtf";
title1 'Minimum and Maximum Numbers for Sign Test';
proc report data=CI nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;

title1 'Minimum and Maximum Numbers for Sign Test With Continuity Correction';
proc report data=CI1 nowd split="*";
columns n min max;
define  n      / display  'Total*Sample*Size (n)'   width=10  center;
define  min    / display  'Miminum*Number*(Low)'    width=10  center;
define  max    / display  'Maximum*Number*(Upper)'  width=10  center;
run;
ods rtf close;
