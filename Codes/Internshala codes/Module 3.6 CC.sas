libname source "/home/u60870018/Internshala";

proc sort data=source.tests out=test;
by subjid;
proc print;
run;


proc transpose data=test out=transtest;
var test1 test2;
id test;
by subjid;
proc print;
run;
