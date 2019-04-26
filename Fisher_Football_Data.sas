
data football ;
  input conference $ points $ count @@ ;
  cards ;
  AFC le7 5  AFC gt7 0 
  NFC le7 2  NFC gt7 4 
    ;

proc print; run;

 proc freq data = football order = data ;
  tables conference*points / chisq nopercent norow nocol ;
  exact pchi ;
  weight count ;
  run ;
