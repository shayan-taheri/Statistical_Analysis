
**Data manipulation example;
**Concatenating data sets;

   data a; input x1 x2 x3;
   cards;
   1 2 3
   4 5 6
   7 8 9
   ;
   run;

proc print data=a; run;

   data b; input x1 x2 x3;
   cards;
   10 11 12
   13 14 15
   16 17 18
   ;
   run;

   proc print data=b; run;

   data c; set  a b ;
   run;

   proc print data=c; 
   run;


 **Merge data sets;

   data a; input name $ x1 x2;
   datalines;
   John 100 40
   Aida 200 49
   ;
   run;

   data b; input name $ x3 gender $;
   datalines;
   John  2  M
   Aida  3  F
   Susan 4  F
   ;
   run;

   proc print data=a; run;
   proc print data=b; run;

   proc sort data=a; by name;
   proc sort data=b; by name;
   run;

   data c; merge a(in=x) b(in=y);
   by name;
   if x and y;
   run;

   proc print data=c; run;
   run;


**Sort data to delete duplicated observations;

   data a; input name $ x1 x2 x3;
   datalines;
   John   100 123 143
   Aida   100 121 892
   Susan  332 121 982
   John   100 123 143
   Aida   100 121 892
   ;
   run;

   proc print data=a; run;

   proc sort data=a nodupkey out=c;
   by name;
   run;
  
   proc print data=c; 
   run;

