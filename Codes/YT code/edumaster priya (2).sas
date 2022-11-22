 
/* column input method */
/* column position mark chesthe order etla unna ostad */
data col_input;
input name$ 10-22 age 2-4 gender$ 5-9 ;
cards;
 24 male surya teja22
 24 male Sai Krishna
;
run;


/* format input method */ 
/* "@" starting position of variable and length of it "." */
data format_IM;
infile cards dlm=" " dsd ;
input @9 name$ 13. @1 age 2. @3 gender$ 4. @22 class$ 6.  ;

cards;
24 male surya david hunter 
24 male krishna smit fisher
;
run;

title "@petale";
data dog;
input name :$25. second_name$ age ;
cards;
surya tejadsa 23 vakamalladasdadad 24 . aditya adfjashf 23
;
run;

proc print data=dog;run;

title "@petina";
data dog;
input name :$25. second_name$ age @;
cards;
surya tejadsa 23 vakamalladasdadad 24 . aditya adfjashf 23
;
run;

proc print data=dog;run;

/* line skip aytad after given variables ki values assign ayinaka */
title "@@petina";
data dog2;
input name :$25. second_name$ age @@;
cards;
surya tejadsa 23 vakamalladasdadad 24 . aditya adfjashf 23
;
run;

proc print data=dog2;run;

/* named input method */
/* first variable length tiskuntad, leda manam manual ga length name$ 7. eyach */
data out;
name="julla julla1234567891011"; age=20;
name="mahesh1234567823562313111";age=23;
run;


/*infile flowover(default), missover,scanover,dlm,dsd */

/* missover works only when missing value is the last value of the observation*/

data missover;
input name$ age power$;
infile cards missover;
cards;
rundu 23 runner
pandu 24 
pindu 
chandu 24 cook
;
run;

proc print data=missover;run;

/* scanover: variable name place lo kavalsinadi mention cheyali input la */

data scanover;
input name$ @ "24" power$;
cards;
rundu 23 runner
pandu 24 fruit
pindu 23 atta
chandu 24 cook
;
run;

proc print data=scanover;run;


/* format & informat */

data date;
input sdate:ddmmyy10. edate:date9. jdate:julian7. mdate:monyy9.;
/* informat sdate ddmmyy10. edate date9.; */
/* format sdate edate date7.; */
format sdate weekdate30. edate worddate30. jdate weekdate30. mdate date9.;
cards;
22/05/2022 22FEB2077 2077054 feb2077
22-02-2022 02jan2050 2052054 oct-3050
;
run;
proc print;run;

data time;
input stime:time10. etime:time10. ftime:time8. ktime:time8. dtime:datetime20.;
format stime timeampm8. etime timeampm10. ftime timeampm8. ktime time4. dtime:dateampm18.;
cards;
12:30:00pm 16:00:00 2:30 5:40 19may2022:12:40:10pm
1:30:00am 04:00:00 14:30 9:30 22jun2022:2:00:00
;run;

data money;
input salary:comma8. package:dollar16. words:comma16.;
format salary dollar10. package comma16. words words50.;
cards;
7,00,000 $70000000 7,00,00,045
;
run;

/* user defined formats */
/* to save in library */
/* proc format lib=sasuser; */
proc format;
value $gender "M"="Masculine" "F"="Feminine"; *char to char;
value $gen "M"=1 "F"=2; *char to num;
value num 11=11.02 15=15.05; *num to num;
value cate 11-12="lvl1" 13-14="lvl2" 15="lvl3"; *num to char;
;
run;
/* options fmtsearch=(sasuser); we have to use options to get the formatted value */
proc print data=sashelp.class;
format sex $gender. age cate.;
run;

data ad;
set sashelp.class;
format sex $gen. age num.;
run;

/* Dataset options */
/* only doing unique and which idk */
/* here read is used to only read the data and we can open dataset with read pass but  */
/* we cannot del it with read pass. */


data pass(password=hitman read=hit);
input name$ bounty hitman$;
cards;
Vijay 200000 Rax97
Nirav 150000 Agent47
;
run;

/* Creatign Sequence No: */

proc sort data=sashelp.class out=class; by age;run;

data first;
set class;
by age;
if first.age then seq_no=1;
else seq_no+1;
run;
proc print; run;

/* Update */

data k;
input id name$;
cards;
1 surya
3 krs
4 .
;
run;

data s;
input id name$ dog$ num;
cards;
2 noob dog 2
3 krs pilli 3
4 killo pindi 5
;
run;

proc sort data=k;by id name; run;
proc sort data=s;by id name; run;

data doggy;
update k s updatemode=nomissingcheck;
by id ;
run;

/* Modify: doesn't create new dataset whcih intern saves space. */
data s;
modify s;
num=num+10;
run;

/* PROC SQl */

proc sql;
create table surya(Locality char, friend char,Age num,Weight num, House_No num,date num);
insert into surya
values ("KCR Nagar","Anil",21,55,333,305552)
values ("X Road","Krishna",22,100,444,123342);

/* 2ndway */
insert into surya
set Locality="Shivrampally",friend="Ravi", age=23, Weight=71,House_no=555,date=22313
set Locality="Malakpet",Friend="Sushanthi", age=24, Weight=52,House_no=666, date=3132;
quit;

/* Printing using sql; */
proc sql;
select Locality,friend,house_no from surya;
quit;

/* using print */
proc print data=surya;var locality friend house_no;run;

/* creating new table and adding the selected variables into it using PROC SQL */

/* used alias and format also label name */
proc sql;
create table suryas_friends as
select friend "surya's friends name",locality,age,house_no as inthi_no,weight,date format=date9. from surya
where age>=22
order by age;

quit;

/* now with datastep; */

data surya_frds;
set surya(keep= friend age locality house_no);
run;

/*  */
data for_trials;
input Brand :$25. Type :$30. Product :$25.  Size Price  ;
infile cards dlm=" " dsd;
cards;
Puma Clothing "Jeans" 34 3000
Puma Clothing "Tee-Shirt" 40 2000 
Adidas Footwear "Shoes" 9 5000 
Nike Footwear "Shoes" 9.4 3500 
Rebook Accessories "Tennis" 6 1000
Bata "Footwear" Regular 9.2 4000
Li-ning "Bat" "Racquet" 29 6000
"Gunn & Moore" "Bat" "Cricket" 38 5500
"Red Gear" "Electronics" "Keyboard" 40 2200
"Lenovo" "Electronics" "Laptop" 15.6 64000
"MSI" "Electronics" "Laptop" 17 84000
AKG "Electronics" "Headset" 1.5 35000
Adidas "Fitness & Sports" "Bottle" 1000 699
Nike "Fitness & Sports" "Bottle" 1000 800
Nivia "Fitness & Sports" "Leg Pad" 10 400
;
run;

/* adding amount into price. using datastep and proc sql */

data add_amount;
set for_trials;
new_price=price+1000;
run;

proc sql;
create table add_amount2 as 
select *,price+500 as new_price from for_trials;
quit;

/* Using condition in PROC SQL */
/* price can be used before case,no need to use multiple times in cases if it's a single */
/* variable case */
proc sql;
select *, price+case when type="Electronics" then 2500
			   when type="Footwear" then 500
			   when type="Accessories" then 200
			   when type="Fitness & Sports" then price+100
			   else price+250 end as Suryas_Tax
			   from for_trials;
quit;

/* Describes the variables of the table in log window */
proc sql;
describe table for_trials;
quit;

/* Deletes Table */
proc sql;
drop table add_amount2;
quit;

/* Task1: If sex=M,F then change it into male,female in a new variable gender.
and create a new dataset called class */
/* proc print data=sashelp.class;run; used to check variables			 */
proc sql;
create table class as
select*, case when SEX="M" then "Male"
				else "Female" end as Gender from sashelp.class;
				quit;
				
/* priya's way */

proc sql;
create table class2 as
select * from sashelp.class;
alter table class2 add gender char(10);
update class2 set gender= case when sex ="F" then "female"
else "male" end;
quit;

/* ceil,floor,round */

proc sql;
select size as actual_value, int(size) as int, ceil(size) as ceil, floor(size) as floor, round(size) as round
from for_trials;
quit;
    
/* Group by and statistical distributions */
/* without group by, all vals get same output so it's unnecessary */

proc sql;
select sex , count(age) as n_age, mean(age) as avg_age, min(age) as min_age, max(age) as max_age
from sashelp.class
group by sex; 
quit;

/* OPERators */

data t1;
input name$ price life;
cards;
phone 10000 4
car 1000000 20
sofa 25000 10
table 5000 7
;
data t2;
input name$ price life;
cards;
bottle 100 1
charger 1500 4
sofa 30000 10
plate 400 10
;

Title  "UNION ALL ";
proc sql;
select * from t1
union all 
select * from t2;
quit;

Title  "UNION ";
proc sql;
select * from t1
union  
select * from t2;
quit;

Title  "Intersect";
proc sql;
select name from t1
intersect
select name from t2;
quit;

Title "Except";
proc sql;
select * from t1
except 	
select * from t2;
quit;

							/* JOINS */
					

data jdata1;
input name$ id subject :$20. class$;
cards;
surya 114 Science B
Ravi 94 History B
Mahesh 30 Maths A
venkat 123 Physics C
suresh 101 Electronics E
vaibhav 222 Music M
;
run;


data jdata2;
input name :$18. id subject :$20. class$ year year2;
cards;
sushanthi 100 Science B 2016 2015
Naveen 23 Physics C 4015 4024
Ramesh 44 Electronics E 3012 7022
mental 122 Social d 3022 2011
fanta 99 Biology t 2066 5051
vaibhav 222 Music M 4077 1313
;
run;

/* Simple join: used for multiple tables/datesets. matches same values from both the tables. */
/* i.e if j1 table sub values will be taken multiple times if it matches with */
/* j2 table subject values */
Title "simple join";
proc sql;
select * from jdata1,jdata2
where jdata1.subject=jdata2.subject;
quit;

/* Inner join same as simple but can only take two tables at once. */
title "inner join";
proc sql;
select j1.name,j1.subject,j2.name,j2.subject from jdata1 as j1 inner join jdata2 as j2
on j1.subject=j2.subject;
quit;

title "/* Right Join */";
proc sql;
select * from jdata1 as j1 right join jdata2 as j2
on j1.subject=j2.subject;
quit;

title "/* left Join */";
proc sql;
select * from jdata1 as j1 left join jdata2 as j2
on j1.subject=j2.subject;
quit;

title "/* full Join */";
proc sql;
select * from jdata1 as j1 full join jdata2 as j2
on j1.subject=j2.subject;
quit;

title "/* Natural Join */";
proc sql;
select * from jdata1 natural join jdata2;
quit;

title "/* cross Join */";
proc sql;
select * from jdata1 cross join jdata2;
quit;

title "/* Union Join */";
proc sql;
select * from jdata1 union join jdata2;
quit;

title "/* self Join */";
proc sql;
select * from jdata2 
where year>year2;
quit;

/* fill missing numeric vals with numeric vals ~ with char */
data missamma;
input name :$15. age gender$ role$ area :$20.;
cards;
surya 14 male wish ramanthapur
varshini . female . rasoolpura
krishnaveni . female . bachapur
ravina . female cop shivrampelli
sushanthi 41 female . bengulluru
;
run;

proc sql;
select name,coalesce(age,20) as age,gender,coalesce(role,"nOnE") as role,gender,area from missamma;
quit;

/* Distinct function */
proc sql;
select distinct class as unique_j1 from jdata1;
quit;

proc sql;
select count(distinct class) as count_classes from jdata1;
quit;

proc sql;
select count(class) as count_classes from jdata1;
quit;


		/* 						MACROS */
		
/* macros are re-usable codes */
/* can be used globally and local.Depending on where it's declared outside or inside. it differs. */
/* the output is displayed in log */

%let a=sashelp.class;
%put==========> &a;

data m1;
set &a;
run;

proc print data=&a;run;

%let f=20;
%let s=50;
%put==========> %eval(&f+&s);

%let i=2.5;
%let j=5.7;
%put===========> %sysevalf(&i+&j);

/*Local Macro */

%macro print(dset=);
proc print data=&dset;run; 
%mend; 

%print(dset=&a);
%print(dset=sashelp.air);
%print(dset=for_trials);

/* non-positional macro parameters */
%macro sort(old=,new=,byvar=);
proc sort data=&old out=&new;
by &byvar;
run;
%mend;

%sort(old=sashelp.class,byvar=age,new=class);
%sort(new=c2,byvar=type,old=for_trials);

/* positional parameters */

%macro sort(old,new,byvar);
proc sort data=&old out=&new;
by &byvar;
run;
%mend;

%sort(sashelp.class,class,age);
%sort(for_trials,clothes_type,type);


/* Task2: create a new dset for sex m,f and bloodtype a,b,ab,o. */
data blood;
input name$ bloodtype$ age;
cards;
krishna a 24
surya o 24
varshini b 24
ravi o 24
sushanth ab 24
jairam b 27
mittu ab 28
chintu a 10
;
run;

/* using data step */
data male female;
set sashelp.class;
if sex="M" then output male;
else output female;
run;

%macro create(tablename,basetable,whereval,varval);
proc sql;
create table &tablename as select * from &basetable
where &whereval=&varval;
quit;
%mend;

%create(male,sashelp.class,sex,"M");
%create(female,sashelp.class,sex,"F");

%create(a_blood,blood,bloodtype,"a");
%create(b_blood,blood,bloodtype,"b");
%create(ab_blood,blood,bloodtype,"ab");
%create(o_blood,blood,bloodtype,"o");

				/* Multiple Procedures */


%macro condi(cond=,dset=,newdset=,byvar=,tvar=,avar=);

%if &cond=s %then %do;
proc sort data=&dset out=&newdset;
by &byvar;
run;
%end;

%else %if &cond=f %then %do;
proc freq data=&newdset;
by &byvar;
table &tvar;
run;
%end;

%else %if &cond=m %then %do;
proc means data=&newdset;
by &byvar;
var &avar;
run;
%end;

%else %if &cond=p %then %do;
proc print data=&newdset;
run;
%end;
%mend;
/* use first macroline before running mean for age sort and sex sort for freq */
%condi(cond=s,dset=sashelp.class,newdset=class,byvar=age );
%condi(cond=s,dset=sashelp.class,newdset=class,byvar=sex);
%condi(cond=f,newdset=class,byvar=sex,tvar=age);
%condi(cond=m,newdset=class,byvar=age,avar=height);
%condi(cond=p,newdset=class,byvar=gender);

proc print data=sashelp.class;
run;

				/* Looping in Macro */
				
%macro loop(dname=);
%let i=1;
%do %while(&i<=3);
	%let dset2=%scan(&dname,&i);
	proc print data=&dset2;
	run;
	%let i=%eval(&i+1);
	%end;
%mend;

%loop(dname=jdata1 for_trials jdata2);	


		/* Macro interface functions */
		
%let a=this is_surya;

%put %length(&a);
%put ln=%length(&a);
%put index=%index(&a,i);
%put scan=%scan(&a,3);
/* delimeters evali ante str func use cheyali instead of "" */
%put %scan(&a,3,%str(_ ));

/* macro can't recq countw so need to use %sysfunc in such cases, we can
also use for above funcs but not required as they;re recq by macros */
%put %sysfunc(countw(&a));


		/* call symput */
		
/* converts sas val into macro val */

data s2;
a="statistics";
sem=2;
run;

data call;
set s2;
call symput("a",a);
call symputx("semister",sem);
run;

%put=====> &a;
%put=====> &semister;

/* symget */
/* converts macro val to sas val */

data call1;
sem=symget("semister");
run;

/* symexist */
/* if exists returns 1 */
data call1;
sem=symexist("semister");
run;

data call1;
if symexist("semister")=1 then put "val is available";
else put "Doesn't exist" ;
run;

/* same as symexist */
data _null_;
if symglobl("sem") then put "Yes";else put "No";run;

data _null_;
call symdel("semister");
run;

/* call execute: is used to execute macro */
%macro print;
proc print data=sashelp.baseball;run;
%mend;

%print;

data _null_;
call execute("%print");
run;

/* creating macro variables using SQL */

proc sql noprint;
select name into: names separated by ", " from sashelp.class;
quit;
/* separated by remove chestha first name okate ostad */
%put &names;

/* Giving multiple names a variable each  */

proc sql noprint;
select name into: name1 -: name20 from sashelp.class;
quit;

%put &name1 &name12 &name5;

/* Global macro save and call options 
libname surya "/home/u60870018/MyOwnLearnings/Base SAS";
options samstore=surya;
%macro printf/store source;
proc print data=sashelp.class;
run;
%mend;

options sasautos=surya;
%printf;
*/

/* Executes the file with the path name. it's simple and efficient way than copying code. */

%include "/home/u60870018/Internshala/bmi using put().sas";

/* Automatic Macro Variables */

%put _automatic_;

%put &sysdate;

%put &sysver;

%put &sysvlong;

%put &sysuserid;

%put &sysvlong4;

%put &syslast;


						/* GRAPHS */

proc plot data=sashelp.class;
plot name*age; *yaxis*xaxis;
run;

proc plot data=sashelp.class;
plot name*age="$";
run;

proc chart data=sashelp.class;
vbar sex;
run;

/* gchart means graphical chart */
proc gchart data=sashelp.class;
vbar sex;
run;

proc gchart data=sashelp.class;
vbar3d sex/shape=cylinder width=10 patternid=midpoint;
run;

proc gchart data=sashelp.class;
hbar sex;
run; 

proc gchart data=sashelp.class;
hbar3d sex/sumvar=age;
run; 


proc gchart data=sashelp.class;
pie3d age sex;
run; 

proc sgplot data=sashelp.class;
scatter x=name y=age;
run;


proc sgplot data=sashelp.class;
scatter x=name y=age/markerattrs=(symbol=triangle size=10);
run;

data class;
set sashelp.class;
if sex="M" then male=age;
else if sex="F" then female=age;
run;
proc sgplot data=class;
series x=name y=male/lineattrs=(color=gold thickness=4 );
series x=name y=female/lineattrs=(color=cyan thickness=4);
run;

proc sgplot data=sashelp.class;
step x=name y=age;
run;

proc sgplot data=class;
step x=name y=male/lineattrs=(color=gold thickness=4 );
step x=name y=female/lineattrs=(color=cyan thickness=4);
run;

/* this is same as proc means but in a different way */
proc sgplot data=sashelp.class;
vbox age;
run;
