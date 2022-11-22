/*Demographics (DM)- Domain*/

libname raw "D:\CS\SAS\mine\Raw";

options validvarname=upcase;
data demographics;
set raw.dm;
studyid=strip(study);
domain="DM";
usubjid=studyid||"/"||strip(site)||"/"||strip(put(subject,best.));
subjid=strip(put(subject,best.));
siteid=strip(site);
invnam=invnam;
brthdtc=birth;
sex=sex;
race=race;
ethinic=ethinicity;
country=country;
run;


/*RFSTDTC RFENDTC*/
proc sort data=raw.ex out=exposure(keep=study subject startdate);
where study <>" " and subject <> .;
by study subject startdate;
run;

Data start(rename=(startdate=RFSTDTC)) end(rename=(startdate=RFENDTC));
set exposure;
by study subject startdate;
if first.subject then output start;
if last.subject then output end;
run;

proc sort data=demographics;
by study subject;run;

proc sort data=start;
by study subject;run;

proc sort data=end;
by study subject;run;

/*Merging with treatment date variables*/

data demographics2;
merge demographics(in=indm) start(in=instart) end(in=inend);
by study subject;
if indm;
dob=input(birth,yymmdd10.);
trtsdt=input(rfstdtc,is8601DA.);
age=(trtsdt-dob)/365.25;
ageu="years";
RFXSTDTC=RFSTDTC;
RFXEndtc=rfendtc;
format dob trtsdt e8601Da.;
run;

/*for RFICDTC*/

data inform1;
set raw.inform;
keep study subject collection_date;
rename collection_date=RFICDTC;
run;

/*for RFPENDTC and changing subjid to subject for merging*/
/*from subject visit dataset*/

proc sort data=raw.sv out=sv1(keep=study subjid enddate);
by study subjid enddate;
run;

/*taking last date from enddate values*/

data pendt(rename=(subjid=subject enddate=RFPENDTC));
set sv1;
by study subjid enddate;
if last.subjid;
run;

/*DTHDTC DTHDFL/DS*/

data death;
set raw.ds;
if upcase(term)="death" then do;
DTHDTC=collection_date;
Dthfl="Y";
end;
else do;
DTHDTC="";
dthfl="";
end;
keep study subject dthdtc dthfl;
run;

PROC SORT DATA=Demographics2;BY STUDY SUBJECT;RUN;

PROC SORT DATA=INFORM1;BY STUDY SUBJECT;RUN;

PROC SORT DATA=PENDT;BY STUDY SUBJECT;RUN;

PROC SORT DATA=DEATH;BY STUDY SUBJECT;RUN;

data dm3;
merge demographics2(in=indm) inform1 pendt death;
by study subject;
if indm;
run;

/*for TRTARM*/

proc sort data=raw.trtarm out=arm;
by study subject;
run;

data arm(drop=trt);
set arm;
by study subject;
if first.subject;
run;

/*DMDTC DMDY*/

PROC SORT DATA=RAW.DMDTC OUT=DMDTC;
BY STUDY SUBJECT;
RUN;

PROC SORT DATA=DM3;
BY STUDY SUBJECT;
RUN;

PROC SORT DATA=ARM;
BY STUDY SUBJECT;
RUN;
PROC SORT DATA=DMDTC;
BY STUDY SUBJECT;
RUN;

DATA DM4;
MERGE DM3(IN=INDM3) ARM DMDTC;
BY STUDY SUBJECT;
ACTARMCD=ARMCD;
ACTARM=ARM;

/*DMDY*/

IF DMDTC GE TRTSDT THEN DMDY=(DMDTC-TRTSDT)+1;
ELSE IF DMDTC LT TRTSDT THEN DMDY=(DMDTC-TRTSDT);
RUN;
