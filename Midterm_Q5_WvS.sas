* Statistical Analysis -- Mid-Term Project: Question 5 (Part B)
* Define a library path where the dataset exists;
libname libsas 'C:\Users\shaya\Desktop\Midterm_Project';

* The Pearson chis-quare test;
proc freq data=libsas.schdata order=data;
	tables write * socst / chisq riskdiff;
run;

* The Fisher's exact test;
proc freq data=libsas.schdata order=data;
	tables write * socst / riskdiff(cl=exact);
	exact riskdiff;
run;

data diff_data; input diff_var;
cards;
2
10
4
1
16
9
2
6
3
5
0
7
3
5
2
3
7
2
3
9
15
9
16
4
3
5
2
1
5
4
3
16
12
9
9
4
0
12
5
16
0
14
9
7
1
15
3
8
2
11
6
8
20
8
3
;
run;

proc univariate data=diff_data;
	var diff_var;
run;
