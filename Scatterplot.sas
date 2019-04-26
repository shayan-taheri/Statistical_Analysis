
*Example of Scatterplot using SAS;

data scatter; input id x y;
cards;
1 12 7.7
2 15 8.1
3 35 6.9
4 21 8.2
5 20 8.6
6 17 8.3
7 19 9.4
8 46 7.8
9 20 8.3
10 25 5.2
11 39 6.4
12 25 7.9
13 30  8
14 27 6.1
15 29 8.6
;
run;


proc print; run;


ods html style=journal;
ods graphics on;
SYMBOL1 V=dot C=black I=none;
TITLE 'Plot of the Data';
PROC GPLOT DATA=scatter;
     PLOT y*x;
RUN; 
QUIT;
ods html close;
ods graphics off;


data sct; input x y z $;
cards;
1 2 A
2 4 A
5 4 A
2 7 B
3 2 B
2 3 B
5 2 B
;
run;

ods html style=journal;
ods graphics on;
SYMBOL1 V=circle  C=black I=none;
TITLE 'Simple Scatterplot';
PROC GPLOT DATA=sct;
     PLOT x*y;
RUN; 
QUIT;
ods html close;
ods graphics off;



ods html style=journal;
ods graphics on;
SYMBOL1 V=circle C=black I=none;
SYMBOL2 V=star   C=red   I=none;
TITLE 'Scatterplot - Different Symbols';
PROC GPLOT DATA=sct;
     PLOT x*y=z;
RUN; 
QUIT;
ods html close;
ods graphics off;

