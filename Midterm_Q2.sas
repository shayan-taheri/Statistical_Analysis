* Statistical Analysis -- Mid-Term Project: Question 2
* Define a library path where the dataset exists;
libname libsas 'C:\Users\shaya\Desktop\Midterm_Project';

* Chi-square test;
proc freq data=libsas.schdata;
   tables gender / chisq testp=(50 50);
run;

* Binomial proportion test;
proc freq data=libsas.schdata;
   tables gender / binomial(p=0.5);
run;
