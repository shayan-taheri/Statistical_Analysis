*------------------------------------------------------------------------;
*Example for ANOVA Contrast                                              ; 
*y-----response, a, b---independent variables with 2 levels and 4 levels ;
*------------------------------------------------------------------------;
data contrast;
 input y a b;
 cards;
3 1 1
4 1 2
7 1 3
7 1 4
1 2 1
2 2 2
5 2 3
10 2 4
6 1 1
5 1 2
8 1 3
8 1 4
2 2 1
3 2 2
6 2 3
10 2 4
3 1 1
4 1 2
7 1 3
9 1 4
2 2 1
4 2 2
5 2 3
9 2 4
3 1 1
3 1 2
6 1 3
8 1 4
2 2 1
3 2 2
6 2 3
11 2 4
;
run;


proc means data = contrast mean;
 class b;
 var y;
run;

*----------------------------------------------------------------------- ;
*By looking at the output of the means for 4 levels of factor b          ;
*we can test the following contrasts:                                    ;
*1) group 3 versus group 4                                               ;
*2) the average of groups 1 and 2 versus the average of groups 3 and 4   ;
*3) the average of groups 1, 2 and 3 versus group 4                      ;
*------------------------------------------------------------------------;

proc glm data = contrast;
  class b;
  model y = b/clparm;
  means b /deponly;
  contrast 'Compare 3rd & 4th groups' b 0 0 1 -1;
  contrast 'Compare 1st & 2nd with 3rd & 4th groups' b 1 1 -1 -1;
  contrast 'Compare 1st, 2nd & 3rd grps with 4th groups' b 1 1 1 -3;
  estimate 'Compare 3rd & 4th groups' b 0 0 1 -1;
  estimate 'Compare 1st & 2nd with 3rd & 4th groups' b 1 1 -1 -1;
  estimate 'Compare 1st, 2nd & 3rd grps with 4th groups' b 1 1 1 -3;
run;
quit;

