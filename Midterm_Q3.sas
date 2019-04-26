* Statistical Analysis -- Mid-Term Project: Question 3
* Define a library path where the dataset exists;

proc freq data=libsas.schdata order=freq;

* Goodness-of-fit test for normality based on observed counts;
data read_stat; input cat  a  b obs_count;
datalines;
1 -999   40    10
2 40     46    11
3 46     48    13
4 48     52    9 
5 52    999    12
;
run;

proc print data=read_stat; run;

* Computer expected counts based on normal distribution N(47.7636, 8.8170*8.8170);
data read_stat; set read_stat;
bb=(b-47.7636)/8.8170;
aa=(a-47.7636)/8.8170;
if _n_=1 then exp_count=55*probnorm(aa);
if _n_=5 then exp_count=55*(1-probnorm(aa));
exp_count=55*(probnorm(bb)-probnorm(aa));
run;

proc print data=read_stat; run;

* Computer Chi-square test statistic;

data read_stat; set read_stat;
chisq=(obs_count-exp_count)**2/exp_count;
run;

proc print data=read_stat; run;

proc means data=read_stat;
var chisq;
output out=aa sum=sum_chisq;
run;

proc print data=aa; run;

* Computer p-value for test normal distribution based on observed counts;
* (Degree of Freedom) df = g-k-1 = Number of Groups - Number of parameters for the distribution -1;

data aa; set aa;
p_value=1-probchi(sum_chisq,2);
run;

proc print data=aa; run;
