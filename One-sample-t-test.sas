

*************************;
*One sample t-test       ;
*************************;

data time;
      input time @@;
      datalines;
    43  90  84  87  116   95  86   99   93  92
   121  71  66  98   79  102  60  112  105  98
   ;
   run;

********************************************************************;
*The SIDES=U option test whether the mean court case length 
*is greater than 80 days, rather than different than 
*80 days (in which case you would use the default SIDES=2 option). 
********************************************************************;

proc ttest h0=80 sides=u alpha=0.1;
      var time;
   run;
   
