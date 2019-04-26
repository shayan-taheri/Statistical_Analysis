

/***************************************************************************************;
Muscle weight data;

1. Rep:      the replicate number, 1 or 2 
2. Time:     the length of time the current is applied to the muscle, ranging from 1 to 4 
3. Current:  the level of electric current applied, ranging from 1 to 4 
4. Number:   the number of treatments per day, ranging from 1 to 3 
5. MuscleWeight: the weight of the denervated muscle-----response variable 
***************************************************************************************/;


data muscles;
   do Rep=1 to 2;
      do Time=1 to 4;
         do Current=1 to 4;
            do Number=1 to 3;
               input MuscleWeight @@;
               output;
            end;
         end;
      end;
   end;
   datalines;
72 74 69 61 61 65 62 65 70 85 76 61
67 52 62 60 55 59 64 65 64 67 72 60
57 66 72 72 43 43 63 66 72 56 75 92
57 56 78 60 63 58 61 79 68 73 86 71
46 74 58 60 64 52 71 64 71 53 65 66
44 58 54 57 55 51 62 61 79 60 78 82
53 50 61 56 57 56 56 56 71 56 58 69
46 55 64 56 55 57 64 66 62 59 58 88
;
run;


*Full model;

proc glm data=muscles outstat=summary;
   class Rep Current Time Number;
   model MuscleWeight = Rep Current|Time|Number/ss1;
   contrast 'Time in Current 3'
      Time 1 0 0 -1 Current*Time 0 0 0 0   0 0 0 0   1 0 0 -1     0 0 0 0,
      Time 0 1 0 -1 Current*Time 0 0 0 0   0 0 0 0   0 1 0 -1     0 0 0 0,
      Time 0 0 1 -1 Current*Time 0 0 0 0   0 0 0 0   0 0 1 -1     0 0 0 0;
   contrast 'Current 1 versus 2' Current 1 -1 0  0 ; 
   lsmeans Current*Time / slice=Current;
run;


proc print data=summary;
run;


*Reduced model;
proc glm data=muscles outstat=summary1;
   class Rep Current Time Number;
   model MuscleWeight = Rep  Current Time Number Current*Time/ss1;
   contrast 'Time in Current 3'
      Time 1 0 0 -1 Current*Time 0 0 0 0 0 0 0 0 1 0 0 -1,
      Time 0 1 0 -1 Current*Time 0 0 0 0 0 0 0 0 0 1 0 -1,
      Time 0 0 1 -1 Current*Time 0 0 0 0 0 0 0 0 0 0 1 -1;
   contrast 'Current 1 versus 2' Current 1 -1;
   lsmeans Current*Time / slice=Current;
run;


proc print data=summary1;
run;
