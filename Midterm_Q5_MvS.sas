* Statistical Analysis -- Mid-Term Project: Question 5 (Part A)
* Define a library path where the dataset exists;
libname libsas 'C:\Users\shaya\Desktop\Midterm_Project';

* The Pearson chis-quare test;
proc freq data=libsas.schdata order=data;
	tables math * science / chisq riskdiff;
run;

* The Fisher's exact test;
proc freq data=libsas.schdata order=data;
	tables math * science / riskdiff(cl=exact);
	exact riskdiff;
run;

data diff_data; input diff_var;
cards;
11
6
2
19
10
4
6
7
6
8
7
10
12
4
11
18
17
8
5
2
12
15
19
8
1
16
4
2
2
1
0
11
4
12
18
11
9
5
1
4
6
10
1
4
6
8
11
1
9
0
6
0
0
8
10
;
run;

proc univariate data=diff_data;
	var diff_var;
run;
