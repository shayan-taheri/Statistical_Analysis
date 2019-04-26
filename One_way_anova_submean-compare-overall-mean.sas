
***************************************************************************;
*Compare sub-mean with overall mean via contrast                           ;
*Let n1, n2, n3, n4 be sample sizes for groups 1, 2, 3, and 4              ;
*n=n1+n2+n3+n4=total sample size                                           ;
*contrast is defines as                                                    ;
* 1-n1/n, -n2/n, -n3/n, -n4/n is the contrast for group 1 versus overall   ;
***************************************************************************;
 
data test;
 input y a b;
 cards;
3  1 1
4  1 2
7  1 3
7  1 4
1  2 1
2  2 2
5  2 3
10 2 4
6  1 1
5  1 2
8  1 3
8  1 4
2  2 1
3  2 2
6  2 3
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

proc print; run;

proc glm data = test;
  class b;
  model y = b;
  means b /deponly; 
  contrast 'Compare 1st group mean with overall mean' b   0.75  -0.25 -0.25  -0.25;
  contrast 'Compare 2nd group mean with overall mean' b  -0.25   0.75 -0.25  -0.25;
  contrast 'Compare 3rd group mean with overall mean' b  -0.25  -0.25  0.75  -0.25;
  contrast 'Compare 4th group mean with overall mean' b  -0.25  -0.25 -0.25   0.75;
run;
quit;


