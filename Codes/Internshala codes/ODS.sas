/*OUTPUT DELIVERY SYSTEM*/
data class;
input name$ gender$ age area$;
cards;
surya SM 24 RAMS
Krish FM 24 BACH
Jai M 26 HYD
Varshi f 23 BEG
Manasa F 24 ALW
;
run;

/* For path we use ODS trace on */
ods trace on;
proc freq data=class;
table name gender area;
run;

ods trace off;

ods output  Freq.Table3.OneWayFreqs=freqdata;
proc freq data=class;
table name gender area age;
run;
ods output close;


ods pdf file="/home/u60870018/Internshala/save.pdf"; /*ods trace on*/
proc means data=class;
var age;
run;
ods pdf close; /*ods trace off*/
	
/* data base lo generate aythad path so takes that to create a usable dataset */
ods output Means.Summary=meandata;
proc means data=class;
var age;
run; 
ODS output close;


/* PROC UNIVARIATE */

ods trace on;
proc univariate data=class;
var age;
run;
ods trace off;

ods output Univariate.age.Moments=uni_moments;
proc univariate data=class;
var age;
run;
ods output off;

/* proc freq data=class; */
/* tables age*area/ out=freqtable2; */
/* run; */

