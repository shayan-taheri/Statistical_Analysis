***************************;
*Homework One-Way ANOVA    ;
*--------------------------;

data HWANOVA; input Group $ Mean sd n;
cards;
STD 74 16 10
LAC 56 16 10
VEG 55 9  10
;
run;

*-------------------------------------------;
*Assuming data is mormally distributed      ;
*Calculate the ANOVA F statistic            ;
*-------------------------------------------;

data aa;
BTW_SS= 10*74**2+10*56**2+10*55**2-(10*74+10*56+10*55)**2/30;
BTW_MS=BTW_SS/2;
WITHIN_SS=9*16**2+9*16**2+9*9**2;
WITHIN_MS=WITHIN_SS/(30-3);
F=BTW_MS/WITHIN_MS;
P_Value=1-PROBF(F, 2, 27);
if P_value < 0.05 then Conclusion="Three means are not equal";
else Conclusion ="Three means are equal"; 
run;

*****************************************;
*Mean comparison of each pair means      ;
*****************************************;

data bb;
ss=(9*16**2+9*16**2+9*9**2)/27;
pool_ss= ss*(1/10+1/10);
t_STD_LAC=(74-56)/sqrt(pool_ss); 
t_STD_VAG=(74-55)/sqrt(pool_ss);
t_LAC_VAG=(56-55)/sqrt(pool_ss);
p_STD_LAC=1-PROBT(t_STD_LAC, 27);
p_STD_VAG=1-PROBT(t_STD_VAG, 27);
p_LAC_VAG=1-PROBT(t_LAC_VAG, 27);
if p_STD_LAC < 0.05 then conclusion1="Mean STD = Mean LAC is rejected";
else conclusion1="Mean STD=Mean LAC is confirmed";
if p_STD_VAG < 0.05 then conclusion2="Mean STD = Mean VAG is rejected";
else conclusion2="Mean STD=Mean VAG is comfirmed";
if p_LAC_VAG < 0.05 then conclusion3="Mean LAC = Mean VAG is rejected"; 
else conclusion3="Mean LAC=Mean VAG is confirmed"; 
run;

data bb1; set bb;
keep ss pool_ss t Means P_Value Conclusion;
t=t_STD_LAC; Means="STD vs LAC"; P_Value=p_STD_LAC; Conclusion=Conclusion1; output; 
t=t_STD_VAG; Means="STD vs VAG"; P_Value=p_STD_VAG; Conclusion=Conclusion2; output;
t=t_LAC_VAG; Means="LAC vs VAG"; p_Value=p_LAC_VAG; Conclusion=Conclusion3; output;
run;


*******************************************;
*Calculate contract and perform test       ;
*------------------------------------------;

data cc; 
L=0.7*56 +0.3*55-74;
L_se=sqrt(197.7*(0.7*0.7/10+0.3*0.3/10+1/10));
t=L/L_se;
P_Value=probt(t, 27);
if P_value < 0.05 then Conclusion="0.7mu1+0.3mu2-mu3=0 is rejected"; 
else conclusion="0.7mu1+0.3mu2-mu3=0 is confirmed";
run;


options nodate nonumber;
ods rtf file = "C:\Xin Folder\UCF\UCF Teaching\STA5206\SAS examples\HW-One-Way-ANOVA-Solution.rtf";
proc print data=aa; 
title "ONE-Way ANOVA Test";
run;

proc print data=bb1 Noobs;
title "Pairwise Mean Comparison";
run;

proc print data=cc Noobs;
title "Test for Contract L=0.7mu1+0.3mu2-mu3=0 versus nonzero";
run;
ods rtf close;


