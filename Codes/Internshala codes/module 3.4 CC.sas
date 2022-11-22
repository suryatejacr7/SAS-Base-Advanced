libname source "/home/u60870018/Internshala";
proc sort data=source.patients out=patient;
by id;
run;
proc sort data=source.measure out=measure;
by id;
run;

DATA innerjoin;
merge patient(in=a) measure(in=b);
by id;
if a and b;
run; 

data fulljoin;
merge patient(in=a) measure(in=b);
by id;
if a or b;
run;

data leftjoin;
merge patient(in=a) measure(in=b);
by id;
if a ;
run;

data rightjoin;
merge patient(in=a) measure(in=b);
by id;
if  b;
run;

data farright;
merge patient(in=a) measure(in=b);
by id;
if b and not a;
run;

data farleft;
merge patient(in=a) measure(in=b);
by id;
if  a and not b;
run;

data innerjoin fulljoin leftouter rightouter farleft farright;
merge patient(in=A) measure(in=B);
by id;
if A and B then output innerjoin;
if A or B then output fulljoin;
if A then output leftouter;
if B then output rightouter;
if A and not b then output farleft;
if B and not a then output farright;
run;