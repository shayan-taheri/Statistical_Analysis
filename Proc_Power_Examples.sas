
*---------------------------;
*SAS Proc Power Example     ;
*---------------------------;
options nodate nonumber;
ods rtf file="C:\Xin Folder\UCF\UCF Teaching\STA5206\SAS examples\Proc_Power_output.rtf";

*----------------------------------------;
*Power calculation of test for one mean  ;
*----------------------------------------;
proc power;
onesamplemeans dist=normal alpha=0.05
mean = 8
ntotal = 200
stddev = 40
power = .;
run;

*----------------------------------;
*Powers calculations for several   ;
*sample sizes, standard deviations ;
*and means                         ;
*----------------------------------;
proc power; onesamplemeans dist=normal alpha=0.05
mean = 2 3 4 5 6 7 8
ntotal = 150 160 170 180 190 200
stddev = 10 20 30 40
power = .;
run;

*---------------------------------;
*Sample size calculation of test  ;
*for one sample mean              ;
*---------------------------------;
proc power; onesamplemeans dist=normal alpha=0.05
mean = 8
ntotal = .
stddev = 40
power = 0.80;
run;

proc power; onesamplemeans dist=normal alpha=0.05
mean = 8 9 10 11 12
ntotal = .
stddev = 40
power = 0.8;
run;

*---------------------------------;
*Plot powers for test of one mean ;
*---------------------------------;
proc power; onesamplemeans dist=normal alpha=0.05
mean = 0.5 0.75  1
ntotal =10
stddev = 2
power = .;
plot x=n min=20 max=80;
run;

*----------------------------------;
*Sample size for two sample t-test ;
*µ1 = 13, µ2 = 14, *sigma = 1.2    ;
*alpha=0.05, power=0.8             ;
*----------------------------------;
proc power; twosamplemeans dist=normal alpha=0.05
groupmeans = (3.43 1.5)
stddev = 7 6 5 4 4.5 3 2 2.6 2
power = 0.8
ntotal =. ;
run;

*----------------------------------;
*Sample size for two sample t-test ;
*1. µ1 = 13, µ2 = 14               ;
*2. µ1 = 13, µ2 = 14.5             ;
*3. µ1 = 13, µ2 = 15               ;
*sigma = 1.2 1.7                   ;
*alpha=0.05 0.10                   ;
*power=0.8 0.9                     ;
*----------------------------------;

proc power; twosamplemeans dist=normal alpha=0.05 0.1
groupmeans = (13 14) (13 14.5) (13 15)
stddev = 1.2 1.7
power = 0.8 0.9
ntotal = . ;
run;

*--------------------------------------------------;
*Compare two means in one-way ANOVA using contrast ;
*Null hypothesis: contrast=0 vs contrast not = 0   ;
*--------------------------------------------------;
proc power; onewayanova test=contrast
contrast = (1 -1 0)
groupmeans = 3 | 7 | 8
stddev = 4
npergroup = 17
power = .;
plot x=n min=10 max=20;
run;

proc power; onewayanova test=contrast
contrast = (0.5  0.5  -1)
groupmeans = 3 | 7 | 8
stddev = 4
npergroup = 10
power = .;
plot x=n min=14 max=26;
run;

*-------------------------------;
*Two independent proportions    ;
*using chisquare approach       ;
*-------------------------------;
proc power; 
  twosamplefreq test=pchi
  groupproportions = (.3 .2)
  nullproportiondiff = 0
  power = .80
  npergroup =.;
run;

*---------------------------------;
*Likelihood Ratio Chi-square Test ;
*for Two Proportions              ;
*---------------------------------;

proc power;
  twosamplefreq test=lrchi
  groupproportions = (.3  .2)
  power = .8
  npergroup =.;
run;

*----------------------------------;
*Fisher's Exact Conditional Test   ;
*for Two Proportions               ;
*----------------------------------;
proc power;
  twosamplefreq test=fisher
  groupproportions = (.3  .2) (0.3 0.5) (0.3, 0.6)
  power = .8
  npergroup = . ;
run;

proc power;
  twosamplefreq test=pchi
  groupproportions = (0.01  0.034)
  nullproportiondiff = 0  0.02
  power = .80
  npergroup =.;
run;

*-----------------------------------------------;
*Sample size for means from two paired samples  ;
*-----------------------------------------------;
proc power;
  pairedmeans test=diff
  meandiff = 5
  std = 5
  corr = .5
  npairs = .
  power = 0.6 to .9 by .1;
run;
ods rtf close;
