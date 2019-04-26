
*--------------------------------------------------------;    
*Two-way ANOVA Model                                     ;
*For Detergent and Temperature Data                      ;
*There are two types of detergent: Supper and Best       ;
*and water temperatures are Hot, Warm, and Cold.         ;
*The response Y(i, j, k) is the dirt removed from load   ;
*k using detergent i and temperature j                   ; 
*------------------------------------------------------- ;

data AA;
   input deterg $ temp $ dirt;
   datalines;
Super   Cold  4
Super   Cold  5
Super   Cold  6
Super   Cold  5 
Super   Warm  7
Super   Warm  9
Super   Warm  8
Super   Warm  12
Super   Hot   10
Super   Hot   12
Super   Hot   11
Super   Hot   9
Best     Cold  6 
Best     Cold  6 
Best     Cold  4 
Best     Cold  4 
Best     Warm  13
Best     Warm  15
Best     Warm  12
Best     Warm  12 
Best     Hot   12
Best     Hot   13
Best     Hot   10
Best     Hot   13
;
run;

options nodate nonumber;
proc print; run;

*ANOVA model with detergent and temperature interaction;

proc glm data=aa;
   class temp deterg;
   model dirt=deterg temp deterg*temp / ss1;
run;


*ANOVA model without detergent and temperature interaction;

proc glm data=aa;
   class temp deterg;
   model dirt=deterg temp / ss1;
run;

*--------------------------------------------------------------;
*Test detergent effect and temperature effect using contrast   ;
*--------------------------------------------------------------;
Proc GLM data =AA; 
Class deterg temp; 
Model dirt=deterg temp  deterg*temp/ ss1;
CONTRAST 'Detergent: Supper vs Best'  deterg  1 -1;  
CONTRAST 'Temperature: Cold vs Hot'   temp    1 -1   0;
CONTRAST 'Temperature: Cold vs Warm'  temp    1  0  -1;
CONTRAST 'Temperature: Warm vs Hot'   temp    0  1  -1;
title '2-Way ANOVA For Test Detergent and Teperature Effects'; 
run;

*-----------------------------------------------------------------;
*Test temperature effect for different detergent (Supper or Best) ;
*-----------------------------------------------------------------;

data AA1; set aa;
if deterg="Super";
run;

Proc GLM data =AA1; 
Class deterg temp; 
Model dirt=temp / ss1;
CONTRAST 'Super detergent: Cold vs Warm' temp   1 -1  0;
CONTRAST 'Super detergent: Cold vs Hot'  temp   1  0 -1;
CONTRAST 'Super detergent: Warm vs Hot'  temp   0  1 -1;
Title "Two-Way ANOVA For Test Temperature Effect for Super Detergent";
run;

data AA2; set aa;
if deterg="Best";
run;

Proc GLM data =AA2; 
Class deterg temp; 
Model dirt= temp / ss1;
CONTRAST 'Best detergent: Cold vs Warm' temp   1 -1  0;
CONTRAST 'Best detergent: Cold vs Hot'  temp   1  0 -1;
CONTRAST 'Best detergent: Warm vs Hot'  temp   0  1 -1;
Title "Two-Way ANOVA For Test Temperature Effect for Best Detergent";
run;
