

*****************************;
*Two samples t-test          ;
*****************************;

********************************************************
compares two grazing methods using 32 steers. 
Half of the steers are allowed to graze continuously 
while the other half are subjected to controlled grazing 
time. The researchers want to know if these two grazing 
methods affect weight gain differently. 
********************************************************;

data graze;
      length GrazeType $ 10;
      input GrazeType $ WtGain @@;
      datalines;
   controlled  45   controlled  62
   controlled  96   controlled 128
   controlled 120   controlled  99
   controlled  28   controlled  50
   controlled 109   controlled 115
   controlled  39   controlled  96
   controlled  87   controlled 100
   controlled  76   controlled  80
   continuous  94   continuous  12
   continuous  26   continuous  89
   continuous  88   continuous  96
   continuous  85   continuous 130
   continuous  75   continuous  54
   continuous 112   continuous  69
   continuous 104   continuous  95
   continuous  53   continuous  21
   ;
   run;


   proc ttest data=graze;
      class GrazeType;
      var WtGain;
   run;
