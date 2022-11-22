					/* Double Tables */

DATA price(keep=type model msrp) features(drop=type model msrp);
set sashelp.cars;
if msrp>20000 then output price;
else output features;
run;

					/* Using _N_ */
					
data line_number;
set price;
/* if _N_>=10 and _N_<20; */
if 10<=_N_<20;
run;



					/* SAS OBS & Firstobs option */

data obser;
set price(obs=20);
run;					

data ad;
set price(obs=15 firstobs=5); *additional ga 5th di add aytad so total 11obs unthai;
run;


					/* dupout */
/* creates a separate table of duplicate values. */
proc import datafile="/home/u60870018/MyOwnLearnings/Learnera/excel files/customer_details.xlsx"
dbms=xlsx replace
out=customer_details;
run;

/*Here, I removed counter column from dataset for nodup result */
proc sort data=customer_details out=nocounter(drop=counter);
by country;
run;

proc sort data=nocounter nodup /*nodupkey*/ out=sorted dupout=duplicates;
by _all_;
run;


					/*Proc Freq nopercent nocum */

/* data dog;set sashelp.cars;rename model=Sai_Krishna_Moddal;run; */

proc freq data=customer_details (rename =(city="Sai_Krishna_Moddal"n));
table "Sai_Krishna_Moddal"n /nopercent nocum;
run;

					/* 2D freq report */
					/*  norow nocol */
					
proc freq data=customer_details;
table country*city/ nopercent norow nocol;
run;                                 
proc freq data=customer_details;
table country*city;
run;  
					/* Transposed drop, prefix, suffix */
					
proc sort data=customer_details out=sorted_cdetails nodupkey;
by contactname;
run;

proc transpose data=sorted_cdetails prefix=trans_ suffix=_done out=t_cdetails (drop=_:);
by contactname;
id country city;
var transaction_amount;
run;

					/* Proc Content */
				/*VARNUM TO GET THE VARIABLE NAME AS IT IS IN TABLE I.E MAKE MODEL*/
PROC CONTENTS DATA=SASHELP.CARS VARNUM;
RUN;


/* COMPRESS FUNC WHICH REMOVES SPACES AND ALSO CHARS */

DATA COMP;
NAME="JAI  LAVA   KUSHa9999";
COMPRESSED=COMPRESS(NAME);*check SS for more options n details;
specificletter=compress(name,"L");
MODIFIER1=COMPRESS(NAME,"a","i"); /*i is a modifier to ignore upper+lower cases of char*/
mod2=compress(name,"","d"); *d is mod for removing digits;
RUN;
				    
				     /*FUNCTIONS*/
					
/* concatenate  */
										
data cat;
f="Surya";
m="Teja";
l="Yamagari";
pipe=f||m||" "||l;
cat=cat(":",f,m,l);
catx=catx("-",f,m,l);
run;

/* substr */

data substrvals;
input no $1-24;
datalines;
4447461231321
4561212315656
6874564561237
5745645645645
564456897894723
;
run;

data substr;
set substrvals;
substr(no,2,7)="--///--#";
run;

/* tranwrd : replace specific word string with another*/

data tranwrd;
monk="Monkey D Luffy punches celestial dragon. Luffy is badass.";
changed=(tranwrd(monk,"Luffy","SURYA"));
run;
proc print data=tranwrd;run;

/* Translate: to change letters in the word to another 
 first comes changing letter then replace letter*/

data translate;
monk="Monkey D Luffy punches celestial dragon. Luffy is badass.";
changed=translate(monk,"p""a","f""z"); /*single di working anthe. veredi chudali*/
run;
proc print data=translate;run;

data forlist;
length site $50;
input name$ port site;
datalines;
Amazon 244 www.amazon.in
Flipkart 433 www.flipkart.com
OU 121 https://www.osmania.ac.in/
YT 4444 www.youtube.com
Animix 143 www.animixplay.com
;
run;

data findlistindex;
set forlist;
search=index(site,".in");
if search>0 then output;
run;

/* prxmatch: find string,num,digits almost all check SS */

data prxmatch;
set forlist;
flag=prxmatch("/^a/i",name); /*i is insensitive search*/
run;

data forprx;

input baboba $;
cards;

"maxy 2213123154"
"MANTRA my number is 8889997776"
;
run;

data mobile_search;
set forprx;
mobile_number=substr(baboba,prxmatch("/\d{10}/",baboba),10);
run;

						/* DATe */
					
						
data date;
format current_date next_date date9.; /*for converting number of days to date9 format*/
current_date=today();
day=day(current_date);
week_of_the_year=week(current_date);
weekday_of_the_month=weekday(current_date);
month=month(current_date);
year=year(current_date);
quarter=qtr(current_date);

next_date=mdy(12,23,2012);
run;
proc print data=date;run;
/* 				 */
/* 				intnx: increments a date, datetime value given by a time interval and  */
/* 				returns a date,time or datetime value */

data intnx;
format first_visit second_visit third_visit date9.;
first_visit="10DEC2021"d;
second_visit=intnx("day",first_visit,20);
third_visit=intnx("day",second_visit,20);
run;

*here s is same day check SS for more details;
data intnx2;
format start_date end_date date9.;
start_date="05MAY2022"d;
end_date=intnx('month',start_date,3,"s"); 
run;

/* intck is somewhat ~ to tnx but it gives out no of days,weeks,months
so on */

data intck;
format start_date end_date admission_date application_date discharge_date current_date date10.;
admission_date="05MAY2022"d;
current_date=today();
application_date ="4MAY2022"d;
discharge_date="24MAY2022"d;
days_hospitalized=intck("days",admission_date,discharge_date);
start_date="29MAY2022"d;
end_date="1feb2023"d;
check=intck('month',start_date,end_date,"c");
check2=intck('month',start_date,end_date);
run;

				/* Exporting a file  */

*before exporting we need to run the code as it is temporary dataset,
to export from lib we first need to create lib and then export it. lib.cat
and just change csv to xls xlsx also in dbms;

proc export data=cat
outfile="/home/u60870018/MyOwnLearnings/Learnera/codes/cat.csv"
dbms=csv replace;
run;

					/* PROC SQL */

proc sql;
select type,make,
count(*) as count_of_obs,
freq(type) as freq_of_obs,
n(type) as n_of_obs,
min(invoice) as min_invoice,
max(invoice) as max_invoice,
avg(invoice) as avg_invoice,
mean(invoice) as mean_invoice,
range(invoice) as range_invoice,
std(invoice) as std_invoice,
sum(invoice) as sum_invoice
from sashelp.cars
group by 1,2;
quit;

				
				/* JOINS */
				
data personal_info;
input name$ sex$ age;
cards;
manas m 23
ravi m 24
sushanth m 23
mahesh m 30
sureka f 22
luffy m 23
robin f 25
nami f 24
;
run;


data physical_info;
input char_name$ height weight;
cards;
nami 167 55
robin 173 57
mahesh 140 60
sanji 176 75
zoro 178 80
usopp 185 76
;
run;

/* left join */
title "Left Join";
proc sql;
select a.*,
b.height,
b.weight
from personal_info as a
left join physical_info as b 
on a.name=b.char_name;
quit;

/* right join */
title "Right Join";
proc sql;
select a.*,
b.height,
b.weight
from personal_info as a
right join physical_info as b 
on a.name=b.char_name;
quit;

/* inner join */
title "Inner Join";
proc sql;
select a.*,
b.height,
b.weight
from personal_info as a
inner join physical_info as b 
on a.name=b.char_name;
quit;

/* full join */
title "Full Join";
proc sql;
select a.*,
b.height,
b.weight
from personal_info as a
full join physical_info as b 
on a.name=b.char_name;
quit;
/*  */
/* Cross join */
title "Cross Join";
proc sql;
create table crossy as
select a.*,
b.height,
b.weight
from personal_info as a
cross join physical_info as b ;
quit;

							/* LOOPS */

data x2table;

do tab4= 4 to 40 by 4; 
output;
end;
run;	

/* ex:2 */
title "Age limit for hostel rooms";
data basedo;
set sashelp.class;
format stay category $30.;

if age<=12 then do
fee="5k";
stay="not allowed";
category="Kid";
end;

else do;
fee="10K";
stay="Allowed";
category="Teenage";
end;
run;
proc print data=basedo;run;

			/* 		do while			 */

data loop1;
x=2;
do while (x<10);
output;
x+2;
end;
run;	

				/* do until */
				
data loop2;
x=2;
do until(x>10);
output;
x+2;
end;
run;			

					/* MACROS */
			
%macro type_summary(car_type);
proc sql;
create table  &car_type._summary as
select type,origin,
count(*) as no_of_obs,
max(invoice) as max_invoice,
sum(invoice) as sum_invoice
from sashelp.cars
where upcase(type)="&car_type."
group by 1,2;
quit;
%mend;

%type_summary(SUV);
			
%let fn=227;
%let sn=773;

data sum;
sum=&fn + &sn;
run;	


/* functions in macros		 */

%let op=%str(One Piece%'s Treasure);

%put------>&op;

/* also works to get the symbol */
%let dp=%str(proc freq;run;);
%put=======>&dp;

/* trailing & leading spaces */

%let tl=%str(  dog go);
%put-=--> &tl;

/* eval for numeric operators */

%let a=20;
%let b=10;
%let z= %eval(&a+&b);
%put =======> &z;
 
/*  sysfunc for sas functions */

%let name= surya teja;
%let print= %sysfunc(substr(&name,1,5));
%put=====>&print;


				/* Options to debug SAS macros */

/* options mprint it prints the entire programs. */
/* then mlogic which is used for logic of the program how it's getting executed */
/* symbolgen tells only what variable is what in the macro paramenter dog(var1,var2) */



					/* ARRAYS */

data forarray;
input name$ day1$ day2$ day3$ day4$ day5$;
cards;
surya p p p p p 
kris a a a a a
rav a p a p p
sus p a p p p
ani a a a p p
;
run;

data forarray1;
input name$ f1 f2 f3 ;
cards;
surya 533 300 231
ani 250 133 122
kris 141 544 333
sus 555 334 512
rav 241 551 512
;
run;

data forarray2;
input name$ f1 f2 f3 ;
cards;
surya 533 . 231
ani 250 133 122
kris 141 544 
sus 555 . 512
rav  . 551 512
;
run;

/* IN attribute in array */
data test;
set forarray;
array x(5) Day1-Day5;
if 'a' in x then ever_absent="YES";else ever_absent="NO";
if 'p' in x then ever_present="YES";else ever_present="NO";
run;

/* of att in array */

data test1;
set forarray1;
/* array speed(3) f1-f3; */
array speed(*) _numeric_;
highspeed=max(of speed(*));
lowspeed=min(of speed(*));
run;

data test2;
set forarray2;
array dot(*) _numeric_;
do i=1 to dim(x);
if missing(x(i)) then i=0;
end;run;
Line #
Line 506, Column 8/home/u60870018/MyOwnLearnings/Learnera/codes/Learnera.sasUTF-8
/* IN attribute in array */ 
data test; 
set forarray; 
array x(5) Day1-Day5; 
if 'a' in x then ever_absent="YES";else ever_absent="NO"; 
if 'p' in x then ever_present="YES";else ever_present="NO"; 
run; 
 
/* of att in array */ 
 
data test1; 
set forarray1; 
/* array speed(3) f1-f3; */ 
array speed(*) _numeric_; 
highspeed=max(of speed(*)); 
lowspeed=min(of speed(*)); 
run; 
 
/*  do loop and dim which basically is a func to declare length */
data test2 (drop=i); 
set forarray2; 
array dot(*) _numeric_; 
do i=1 to dim(dot); 
if missing(dot(i)) then dot(i)=0; 
end;
run; 

/* proc compare */
proc compare b=forarray1 compare=forarray2;run;


/* exporting data as a pdf file */

ods pdf file="/home/u60870018/MyOwnLearnings/Learnera/codes/fun.pdf";
data ds1;
length name $20.;
input name age sex$ skill ;
infile datalines delimiter=" " dsd;
datalines;
"sai krishna reddy" 24 m 50
"jayaram reddy" 26 m 100
"surya teja" 24 m 999
;
run;

proc sql ;
select *,case when skill<=50 then "NOOB"
		when skill>=100 then "Professional"
		end as category
		from work.ds1;
		quit;
ods pdf close;

/* Reverse the values */

data rev;
set ds1(keep=name);
reversed=reverse(name);
run;
proc print;

/* missing columns del */

data miss;
input name$ age;
cards;
adithi 33
. . 
dd 22
;
run;
data miss1;
set miss;
missings=missing(catS(of _all_)); *here there is no missing col so rale ega;
if missings=1 then delete;
run;

/* Leading zeroes add  */

data leadzeros;
input id;cards;
23
2345
51512
223
;
run;

data leadzeroes1;
set leadzeros;
id2=put(id,z10.);
run;
