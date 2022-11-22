data a;
input name$ gender$ age;
cards;
surya male 24
ravi male 23
sana female 23
;
run;

data b;
input name$ gender$ age;
cards;
surya2 male 24
ravi2 male 23
varshini female 23
;
run;

/* stacking data using datastep
data C;
set a b;
run;*/

/*proc step*/
proc append base=c data=a;
run;
proc append base=c data=a;
run;

/*sorting/grouping data*/
proc sort data=a;
by gender;
run;

proc sort data=b;
by gender;
run;

/*interleaving
 stacking*/
data C;
set a b;
by gender;
run;


