* Statistical Analysis -- Mid-Term Project: Question 1
* Define a library path where the dataset exists;
libname libsas 'C:\Users\shaya\Desktop\Midterm_Project';

* Chi-square test for one-way contingency table;
proc freq data=libsas.schdata order=internal;
   tables race / chisq testp=(45 20 35);
run;
