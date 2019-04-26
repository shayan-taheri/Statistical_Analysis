

* Test two proportions;
* Using "input" to format the variables for the SAS;
* Using "output" to create multiple SAS data sets in a single DATA step;
data YesNo;
        input Gender $ NumYes Total;
        Response="Yes"; Count=NumYes;       output;
        Response="No "; Count=Total-NumYes; output;
        datalines;
      Men   30 100
      Women 45 100
      ;
      
      proc print noobs; 
        var Gender Response Count;
      run;


      proc freq order=data;
        weight Count;
        table Gender * Response / chisq nocol nopercent nocum;
       run;
