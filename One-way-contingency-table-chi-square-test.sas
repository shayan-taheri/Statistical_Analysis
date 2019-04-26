
*Example in lecture_notes3;

*Chi-square test for one-way contingency table;
data a; input count;
cards;
63 
45 
72
;
run;

proc freq data=a order=data;
   tables count / nocum chisq testp=(33.3 33.3 33.3);
   weight count;
run;



