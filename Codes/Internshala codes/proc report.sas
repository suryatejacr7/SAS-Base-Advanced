data report;
input name$ ruleno class$ Final_Marks Full_Marks gender$;
cards;
suryaTeja 114 B 670 1000 m
Krish 202 A 820 1000 m
Jai 143 C 685 1000 m 
varsh 123 B 800 1000 f
mahesh 231 C 612 1000 f
ravi 512 B 600 1000 m
sush 151 A 451 1000 f
;
run;
/*display place lo analysis for numeric to summarise to mean sum max so on, group, order,across is like transpose
,computed-on the fly calculate*/
/* default for analysis is sum */
proc report data=report;
columns name gender ruleno class final_marks full_marks    ;
define name/display;
define gender/group;
define ruleno/display;
define class/display;/* class lo order use chesthe group radu  */
define final_marks/display;
define full_marks/display;
run;

/* expected output */
proc report data=report;
col gender final_marks class;
define gender/group;

define class/group;
define final_marks/analysis mean;
run;