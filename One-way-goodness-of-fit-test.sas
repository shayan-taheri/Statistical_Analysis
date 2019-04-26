
*Goodness-of-fit test for normality baed on observed counts;
data blood; input pat  a  b obs_count;
datalines;
1 -999   50    57
2 50     60    330
3 60     70    2130
4 70     80    4584
5 80     90    4604
6 90     100   2119
7 100    110   659
8 110    999   251
;
run;

proc print data=blood; run;

*Computer expected counts based on normal distribution N(80.68, 12*12);
data blood; set blood;
bb=(b-80.68)/12;
aa=(a-80.68)/12;
if _n_=1 then exp_count=14736*probnorm(aa);
if _n_=8 then exp_count=14736*(1-probnorm(aa));
exp_count=14736*(probnorm(bb)-probnorm(aa));
run;

proc print data=blood; run;

*Computer Chi-square test statistic;

data blood; set blood;
chisq=(obs_count-exp_count)**2/exp_count;
run;

proc print data=blood; run;

proc means data=blood;
var chisq;
output out=aa sum=sum_chisq;
run;

proc print data=aa; run;

*Computer p-value for test normal distribution based on observed counts;
*df=g-k-1=number of groups - number of parameters for the distribution -1;

data aa; set aa;
p_value=1-probchi(sum_chisq, 5);
run;

proc print data=aa; run;
