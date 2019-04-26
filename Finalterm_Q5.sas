* Statistical Analysis -- Final Project: Question 5;

* ------------------------------------------------------------------------------;
* An experiment on decision making: 5 Executives and 3 Methods                  ;
* Methods: Utility, Worry, and Comp                                       ;
* The maximum risk premium for avoidance of uncertainty (payment for insurance) ;
* Stating the degree of confidence for quantification of the risk premium       ;
* Scale: 0 (No Confidence) to 20 (Highest Confidence)                           ;
* Approximately normally distribution for confidence scales                     ;
* (a) ANOVA Table?                                                              ;
* (b) Test for the equality of confidence ratings among the 3 methods?          ;
* (c) Test for the equality of confidence ratings among the 5 executives?       ;
* (d) Test for the equality of confidence ratings among any pair of methods?    ;
* (e) Test for the equality of confidence ratings among any pair of executives? ;
* ------------------------------------------------------------------------------;

data Exp_DM;
   input Executive $ Method $ ConfDeg;
   datalines;
Exe1 Utility 1.3
Exe1 Worry 4.8
Exe1 Comp 9.2

Exe2 Utility 2.5
Exe2 Worry 6.9
Exe2 Comp 14.4

Exe3 Utility 7.2
Exe3 Worry 9.1
Exe3 Comp 16.5

Exe4 Utility 6.8
Exe4 Worry 13.2
Exe4 Comp 17.6

Exe5 Utility 12.6
Exe5 Worry 13.6
Exe5 Comp 15.5
;
run;

proc print; run;

* The ANOVA model with the "Executive" and "Method" interaction;

proc glm data=Exp_DM;
   class Method Executive;
   model ConfDeg=Executive Method Executive*Method / ss1;
run;


* The ANOVA model without the "Executive" and "Method" interaction;

proc glm data=Exp_DM;
   class Method Executive;
   model ConfDeg=Executive Method / ss1;
run;

Proc GLM data =Exp_DM; 
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry Vs. Comp'  Method  -4 -0.56 4.56;
title 'ANOVA Test on the Equality of Confidence Ratings among Three Methods';
run;

Proc GLM data =Exp_DM; 
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Executive: Exe1 Vs. Exe2 Vs. Exe3 Vs. Exe4 Vs. Exe5'  Executive  -4.98 -2.15 0.86 2.45 3.82;
title 'ANOVA Test on the Equality of Confidence Ratings among Five Executives';
run;

Proc GLM data =Exp_DM; 
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
title 'ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)';
run;

Proc GLM data =Exp_DM; 
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Executive: Exe1 Vs. Exe2'  Executive  1 -1 0 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe3'  Executive  1 0 -1 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe4'  Executive  1 0 0 -1 0;
CONTRAST 'Executive: Exe1 Vs. Exe5'  Executive  1 0 0 0 -1;
CONTRAST 'Executive: Exe2 Vs. Exe3'  Executive  0 1 -1 0 0;
CONTRAST 'Executive: Exe2 Vs. Exe4'  Executive  0 1 0 -1 0;
CONTRAST 'Executive: Exe2 Vs. Exe5'  Executive  0 1 0 0 -1;
CONTRAST 'Executive: Exe3 Vs. Exe4'  Executive  0 0 1 -1 0;
CONTRAST 'Executive: Exe3 Vs. Exe5'  Executive  0 0 1 0 -1;
CONTRAST 'Executive: Exe4 Vs. Exe5'  Executive  0 0 0 1 -1;
title 'ANOVA Test on the Equality of Confidence Ratings among Five Executives (Pairwise)';
run;

data PD1; set Exp_DM;
if Executive="Exe1";
run;

Proc GLM data =PD1;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
Title "For Exe1: ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)";
run;

data PD2; set Exp_DM;
if Executive="Exe2";
run;

Proc GLM data =PD2;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
Title "For Exe2: ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)";
run;

data PD3; set Exp_DM;
if Executive="Exe3";
run;

Proc GLM data =PD3;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
Title "For Exe3: ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)";
run;

data PD4; set Exp_DM;
if Executive="Exe4";
run;

Proc GLM data =PD4;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
Title "For Exe4: ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)";
run;

data PD5; set Exp_DM;
if Executive="Exe5";
run;

Proc GLM data =PD5;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Method: Utility Vs. Worry'  Method 1 -1 0;
CONTRAST 'Method: Utility Vs. Comp'  Method 1 0 -1;
CONTRAST 'Method: Worry Vs. Comp'  Method 0 1 -1;
Title "For Exe5: ANOVA Test on the Equality of Confidence Ratings among Three Methods (Pairwise)";
run;

data PE1; set Exp_DM;
if Method="Utility";
run;

Proc GLM data =PE1;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Executive: Exe1 Vs. Exe2'  Executive  1 -1 0 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe3'  Executive  1 0 -1 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe4'  Executive  1 0 0 -1 0;
CONTRAST 'Executive: Exe1 Vs. Exe5'  Executive  1 0 0 0 -1;
CONTRAST 'Executive: Exe2 Vs. Exe3'  Executive  0 1 -1 0 0;
CONTRAST 'Executive: Exe2 Vs. Exe4'  Executive  0 1 0 -1 0;
CONTRAST 'Executive: Exe2 Vs. Exe5'  Executive  0 1 0 0 -1;
CONTRAST 'Executive: Exe3 Vs. Exe4'  Executive  0 0 1 -1 0;
CONTRAST 'Executive: Exe3 Vs. Exe5'  Executive  0 0 1 0 -1;
CONTRAST 'Executive: Exe4 Vs. Exe5'  Executive  0 0 0 1 -1;
title 'For Utility: ANOVA Test on the Equality of Confidence Ratings among Five Executives (Pairwise)';
run;

data PE2; set Exp_DM;
if Method="Worry";
run;

Proc GLM data =PE2;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Executive: Exe1 Vs. Exe2'  Executive  1 -1 0 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe3'  Executive  1 0 -1 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe4'  Executive  1 0 0 -1 0;
CONTRAST 'Executive: Exe1 Vs. Exe5'  Executive  1 0 0 0 -1;
CONTRAST 'Executive: Exe2 Vs. Exe3'  Executive  0 1 -1 0 0;
CONTRAST 'Executive: Exe2 Vs. Exe4'  Executive  0 1 0 -1 0;
CONTRAST 'Executive: Exe2 Vs. Exe5'  Executive  0 1 0 0 -1;
CONTRAST 'Executive: Exe3 Vs. Exe4'  Executive  0 0 1 -1 0;
CONTRAST 'Executive: Exe3 Vs. Exe5'  Executive  0 0 1 0 -1;
CONTRAST 'Executive: Exe4 Vs. Exe5'  Executive  0 0 0 1 -1;
title 'For Worry: ANOVA Test on the Equality of Confidence Ratings among Five Executives (Pairwise)';
run;

data PE3; set Exp_DM;
if Method="Comp";
run;

Proc GLM data =PE3;
class Method Executive;
model ConfDeg=Executive Method / ss1;
CONTRAST 'Executive: Exe1 Vs. Exe2'  Executive  1 -1 0 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe3'  Executive  1 0 -1 0 0;
CONTRAST 'Executive: Exe1 Vs. Exe4'  Executive  1 0 0 -1 0;
CONTRAST 'Executive: Exe1 Vs. Exe5'  Executive  1 0 0 0 -1;
CONTRAST 'Executive: Exe2 Vs. Exe3'  Executive  0 1 -1 0 0;
CONTRAST 'Executive: Exe2 Vs. Exe4'  Executive  0 1 0 -1 0;
CONTRAST 'Executive: Exe2 Vs. Exe5'  Executive  0 1 0 0 -1;
CONTRAST 'Executive: Exe3 Vs. Exe4'  Executive  0 0 1 -1 0;
CONTRAST 'Executive: Exe3 Vs. Exe5'  Executive  0 0 1 0 -1;
CONTRAST 'Executive: Exe4 Vs. Exe5'  Executive  0 0 0 1 -1;
title 'For Comp: ANOVA Test on the Equality of Confidence Ratings among Five Executives (Pairwise)';
run;
