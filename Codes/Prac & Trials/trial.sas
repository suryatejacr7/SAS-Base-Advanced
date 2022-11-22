data forscan;
x="tom and jerry @ butcher @ sala @ and beach @ theend";
xs=scan(x,2,"@");
run;
data trial;
infile cards delimiter=" " dsd;
input CMCAT :$15. age studyid work :$35.;
datalines;
surya 24 7 "Clinical SAS Developer"
krishna 24 15 "SAS coder"
Ram 27 23 "clinical SAS Developer"
;
run;

data mango;
input studyid Issue$ timing CMCAT$;
cards;
222 fever 1800 dorod
223 fever 1200 dorod1
515 mental 5124 dorod2
151 legpain 14 dorod3
512 mental 1000 dorod4
;
run;

proc sort data=mango nodup;
by timing;
run;  

proc transpose data=mango out=t_mango;
by timing; 
var issue;
id CMCAT;
run;

proc sort data=trial;
by cmcat;
run;
proc sort data=mango;
by cmcat;
run;
data u_merge;
merge trial mango;
by cmcat;
run;
data u_set;
set trial mango;
run;

libname Surya "D:\CS\SAS\Mine\Codes\Internshala codes";

data date1;
infile cards missover;
input d1 d2 d3 d4 d5 d6 d7;
informat d3 d4:ddmmyy10. d7:julian10.; 
format d1 d2 d3 :date9. d4:ddmmyyp10. d5:worddate20. 
d6:weekdate30. d7:weekdate24.; 
cards;
22223 312313 20-07-2022 22:03:2077 55555 666666 2022036
. . 22.03.22
;
run;
 

data time1;
infile cards missover;
input t1 t2 t3;
informat t1 t2 :time10. t3:datetime20.;
format t1:timeampm10. t2:datetime20. t3:dateampm20.;
cards;
12:34 1:30:03 04:16pm
456462 22:00pm 20jul2022:12:41:02pm
;
run;

data money1;
input m1 m2 m3 m4 m5;
informat m1 m2:comma7. m3:dollar10. m4:comma10.2;
format m1 m2:dollar8. m3:comma15. m4:dollar10.2 m5:words45.;
cards;
20000 76000 $49,87,46,489 2141414 1050000
;run;


proc format library=sasuser;
value $gender 'M'='Male' 'F'='Female';
value age_group 11="Elevens" 12="Twelve" 13="Thirteen" 14="Fourteen" 15="Fifteen"
16="Sixteen";
value weight_group 50-100="Normal" 100-150="Normal+";
value height_group 20-50=50 51-100=100;
run;

proc print data=sashelp.class;
format sex $gender. age $age_group.;
run;

/*global options*/
options fmtsearch=(sasuser);
options center validvarname=upcase;
data change;
set sashelp.class;
format sex $gender. age age_group.;
format weight weight_group. height height_group. ;
run;

options center number ls=100 ps=150;
title;
proc print data=sashelp.citiqtr;
run;
 
option nocaps;
data class2(label="using dataoptions");
set sashelp.class;
label name=peru and goutram age=vayassu sex=sri & pursh lingam;
where sex="M";
rename sex=Gender;
run;
 
data dpg(password=doggo read=doggy);
input name$;
cards;
doggo
;
run;
data dd;
x="dog";
y=soundex(x);
run;


Mean is the avg value of numeric values. sum of the terms/no of the terms.

Median is the middle/center value. If even digits then it takes
two mid values>adds it>then divides by 2.

data mea;
x=250;
y=100;
z1=int(mean(x,y,150));
z=median(x,20,20,10);
mini=min(x,y,10,.);
maxi=max(x,y,10);
rangei=range(x,y,6,.);
vari=var(2,5,12);
nmiss=nmiss(.,.,.23,.,414,.); *returns missing values;
nippu=n(.,.,313,4145,15,515,.);*returns non-missing values;
X = coalesce(42, .);*Returns the first non-missing value from a list of numeric arguments.;
Z = coalescec ('sas', 'stansys', 'krishna',".");
*Returns the first non-missing value from a list of character arguments.;
run;

Data ds;
X = coalescec(' ', 'hello');
Y = coalescec (' ', 'goodbye', 'hello');
Z = coalescec ('sas', 'stansys', 'krishna');
Run;
Data lg1;
   input x @@;
   a=lag1(x);
   b=lag2(x);
   c=lag3(x);
   d=lag5(x);
   datalines;
1 2 3 4 5 6
;
Run;

DATA SEARCH_NUM;
INPUT STRING $60.;
dg = ANYDIGIT(STRING);
DATALINES;
This line has a 56 in it
two numbers 123 and 456 in this line
No digits here
;
Run;

DATA EN;
INPUT STRING $60.;
START = ANYDIGIT(STRING);
END = ANYSPACE(STRING,START);
rev=reverse(string);
START1 = ANYDIgIT(rev);
END1 = ANYSPACE(rev,start1);
/*IF START NE 0 THEN NUM = INPUT(SUBSTR(STRING,START,END-START),9.);*/
if start ne 0 then num2=reverse(input(SUBSTR(rev,START1,END1-start1),9.));
DATALINES;
This line has a 56 in it
two numbers 123 555 456 in this line
No digits here
;
Run;

Data ds12;
x1=ROUND(2.4);
x2=ROUND(2.5);
x3=ROUND(2.8);
X4=ROUND(-2.4);
X5=ROUND(-2.45);
Run;

Data ds2;
Infile datalines;
Input id name$ sal;
Datalines;
0016 abc 60000
002 def 45000
003 xyz 50000
;
Run;
Data nc/*(drop=id rename=(id1=id))*/;
Set ds2;
id1=put(id, $5.);
Run;

DATA DS24;
THANKSGIVING_2012=HOLIDAY (' HALLOWEEN  ', 2022);
Format THANKSGIVING_2012 date9. ;
RUN;
Data Ret1;
Input Id Prod$ Sales;
Datalines;
101 Pen 230
102 Pencil 320
103 Book 210
104 Pen 210
105 Book 180
106 Pencil 310
;
Run;
Data Ret2;
Set Ret1;
Retain total;
total=sum(total,sales);
Run;

proc sql;
select *,sum(sales) as total_sales from ret1;
quit;

Data Ret3;
Retain col;
Set Ret1;
col+1;
Run;


Data ds;
Set sashelp.class;
Run;
Proc sort data=ds;
By sex;
Run;

option mprint;
Data ds2;
Set ds;
By sex;
Retain cum_ht 0;
If first.sex=1 then cum_ht=height;
Else cum_ht+height;
Run;

Data ds3(DROP=Y);
Set ds;
By sex;
Retain x 0 y 0;
If sex='F' then x=x+height;
Else y=y+height;
If y > 0 then x=y;
Run;

Data ds4;
Set ds;
By sex;
Retain x 0;
x=x+height;
If first.sex=1 then do;
x=height+0;
End;
Run;

Data ds1;
Infile datalines;
Input id name$ sex$ age sal;
Datalines;
001 abc m 23 45000 
002 def f 34 67000 
003 mno m 21 36000 
004 "xyz" f 27 45000 
; 
Run;


Data ds2;
Input id name$ sex$ age sal;
Datalines;
001 "abc" m 23 45000 
002 def f 34 67000 
003 mno m 21 36000 
004 xyz f 27 45000 
; 
Run;

/* informat and format dates*/
data work.ds;
    date_string = "31-12-2020";
    date_number = input(date_string, DDMMYY10.);
    date_number_format = date_number;
    output;
 
    date_string = "4APR2021";
    date_number = input(date_string, DATE9.);
    date_number_format = date_number;
    output;
 
    date_string = "2017-08-31";
    date_number = input(date_string, YYMMDD10.);
    date_number_format = date_number;
    output;
 
    date_string = "25/05/2021";
    date_number = input(date_string, DDMMYY10.);
    date_number_format = date_number;
    output;
 
    date_string = "06/28/2021";
    date_number = input(date_string, MMDDYY10.);
    date_number_format = date_number;
    output;
 
    format date_number_format date9.;
run;


proc sql;
    select date_string,
        input(date_string, date9.) as date_number,
	input(date_string, date9.) as date_number_format format=ddmmyy10.
    from work.ds;
quit;

%let date_number = %sysfunc(inputn(31DEC2020, date9.));
%put &amp;=date_number.;

%let date_number = %sysfunc(inputn(31-12-2020, ddmmyy10.));
%put &amp;=date_number.;


/*Given an unsorted dataset,*/
/*how to read the last observation to a new data set?*/

data dragon;
input name$;
cards;
dragon
sabo
kuma
ivanko
;
run;


data last_dragon;
set dragon end=last;
if last;
run;

/*Question:?Differnce b/w sum function and using g+h operator?*/

data mydata;
input x y z;
cards;
33 3 3
24 3 4
24 3 4
. 3 2
23 . 3
54 4 .
35 4 2
;
run;

data mydata2;
set mydata;
a=sum(x,y,z);
p=x+y+z;
run;

/*Question:?What would be the result of following SAS function*/
/*(given that 31 Dec, 2000 is Sunday)?*/
data tiktok;
Weeks = intck(eweekf,f31dec2000Œd,f01jan2001Œd);
Years = intck(eyearf,f31dec2000Œd,f01jan2001Œd);
Months = intck(emonthf,f31dec2000Œd,f01jan2001Œd);
run;

data forscan;
x="tom and jerry @ butcher @ sala @ and beach @ theend";
xs1=scan(x,4,"@");
xs=scan(x,5,"@");
run;
