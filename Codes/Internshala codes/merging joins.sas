data a;
input name$ gender$ age ;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data b;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;

/*Pre-sorting. So, that merge can take the values */
proc sort data=a;
by name;
run;
proc sort data=b;
by name;
run;

/*merging a b by variable name
if no by statement then sas automatically takes the common variable and merges.
second dataset variable values will be overided if changes are made in it.
i.e. if surya age ni 24 to 23 chesnam in b so it considered b var values only.:D*/

data mergec;
merge a b;
by name;
proc print;
run;


/*Merging data using Joins*/

data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;
title "A";
proc print data=classa; run;
data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;
title "B";
proc print data=classb; run;
/*merging using inner join
and is used for inner which tells sas to get common data from both a & b*/

proc sort data=classa;
by name;run;
proc sort data=classb;
by name;run;

Title "inner";
data inner;
merge classa(in=a) classb(in=b);
by name;
if a and b;
proc print;
run;

/*Full Join*/

data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;

proc sort data=classa;
by name ;run;
proc sort data=classb;
by name;run;

title "Full";
data fulljoin;
merge classa(in=a) classb(in=b);
by name ;
if a or b;
proc print;
run;


/*Left join */

data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;

proc sort data=classa;
by name ;run;
proc sort data=classb;
by name;run;

title "left";
data leftjoin;
merge classa(in=a) classb(in=b);
by name ;
if a ;
proc print;
run;

/* Right Join */


data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;

proc sort data=classa;
by name ;run;
proc sort data=classb;
by name;run;

title "right";
data rightjoin;
merge classa(in=a) classb(in=b);
by name ;
if  b;
proc print;
run;

/* Far Left and Far Right*/

data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;
proc sort data=classa;
by name ;run;
proc sort data=classb;
by name;run;

title"farleft";
data farleft;
merge classa(in=a) classb(in=b);
by name ;
if  a and not b;
proc print;
run;

data classa;
input name$ gender$ age;
cards;
surya male 24
krishna male 24
ravi male 23
sushanth male 23
mahesh male 23
;
run;

data classb;
input name$ age residence$;
cards;
surya 23 NYC
ravi 23 london
sushanth 23 USA
jai 26 Dubai
krishna 12 Miami
das 22 france
;
run;

proc sort data=classa;
by name ;run;
proc sort data=classb;
by name;run;

Title "Farright";
data farright;
merge classa(in=a) classb(in=b);
by name ;
if  b and not a;
proc print;
run;