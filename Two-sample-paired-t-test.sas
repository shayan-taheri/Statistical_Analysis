

**********************************;
*Two samples piared t-test
*********************************;


data pressure;
         input SBPbefore SBPafter @@;
         datalines;
   120 128   124 131   130 131   118 127
   140 132   128 125   140 141   135 137
   126 118   130 132   126 129   127 135
   ;
   run;


proc ttest;
      paired SBPbefore*SBPafter;
run;
