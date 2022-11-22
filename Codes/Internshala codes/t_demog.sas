filename demog "/home/u60870018/Internshala/demog.xls";

proc import datafile=demog
dbms=xls
out=demog;
getnames=yes;
run;

data demog1;
set demog;
format dob1 date9.; 
dob=compress(cat(month,"/",day,"/",year));
dob1=input(dob,mmddyy10.);
age=(diagdt-dob1)/365.242;
output;
trt=2;
output;
run;

/* Evaluating statistical paramets for age variable */
proc sort data=demog1;
by trt;
run;

proc means data=demog1 noprint;
var age;
output out=agestats;
by trt;
run;

data agestats;
set agestats;
length value $10.;
ord=1;
if _stat_="N" then do; subord=1; value=strip(put(age,8.)); end;
else if _stat_="MEAN" then do; subord=3; value=strip(put(age,8.1)); end;
else if _stat_="STD" then do; subord=3; value=strip(put(age,8.2)); end;
else if _stat_="MIN" then do; subord=4; value=strip(put(age,8.1)); end;
else if _stat_="MAX" then do;  subord=5; value=strip(put(age,8.1)); end;

rename _stat_=stat;
drop age _freq_ _type_;
run;
/* obtaining statistical parameters for gender variable */

proc format;
value sexC
1="Male"
2="Female";
run;

data demog2;
set demog1;
sex=put(gender,sexC.);
run;


proc freq data=demog2 noprint;
table trt*sex /outpct out=genderstats;
run;

data genderstats;
set genderstats;
ord=2;
if sex="Male" then subord=1;
else subord=2;
value=cat(count," (",strip(put(round(pct_row,.1),8.1)),"%)");
rename sex=stat;
drop pct_row pct_col count percent;
run;
/* obtaining race stat */
proc format;
value races
1="White"
2="Black"
3="Hispanic"
4="Asian"
5="Other"
;
run;

data demog3;
set demog2;
raceC=put(race,races.);
run;

proc freq data=demog3 noprint;
table trt*raceC /outpct out=racestats;
run;

data racestats;
set racestats;
ord=3;
if raceC="Asian" then subord=1;
else if raceC="Black" then subord=2;
else if raceC="Hispanic" then subord=3;
else if raceC="White" then subord=4;
else if raceC="Other" then subord=5;
value=cat(count," (",strip(put(round(pct_row,.1),8.1)),"%)");
rename raceC=stat;
drop count percent pct_row pct_col;
run;


/* stacking all three stats */

data allstats;
set agestats genderstats racestats;
run;

/* Transposing data by treatment groups*/

proc sort data=allstats;
by ord subord stat;
run;

proc transpose data=allstats  out=tr_allstats (drop=_NAME_) prefix=_;
var value;
id trt;
by ord subord stat;
run;


data finalstats;
length stat $30.;
set tr_allstats;
by ord subord;
output;
if first.ord then do;
	if ord=1 then stat="Age (Years)";
	if ord=2 then stat="Gender";
	if ord=3 then stat="Race";
	subord=0;
	_0="";
	_1="";
	_2="";
	output;
	end;
proc sql noprint;
select count(*) into:placebo from demog1 where trt=0;
select count(*) into:active from demog1 where trt=1;
select count(*) into:total from demog1 where trt=2;
quit;

%let placebo=&placebo;
%let active=&active;
%let total=&total;

/* Generating final report */
title "Table 1.1";
Title2 "Demographic and Baseline Characteristics by Treatment Group";
title3 "Randomized Population";	
footnote "Note: Percentages are based on the number of non-missing values in each
treatment group";

proc report data=finalstats split="^";
cols ord subord stat _0 _1 _2;
define ord/noprint order;
define subord/noprint order;
define stat/display width=50 "" ;
define _0 / display width=30 "Placebo ^ (N=&placebo)";
define _1 / display width=30 "Active Treatment ^ (N=&active)" ;
define _2 / display width=30 "All Patients ^(N=&total)" ;
run;

