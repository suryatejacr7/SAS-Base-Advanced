data format_IM;
infile cards dlm=" " dsd ;
input @9 name$ 6. @1 age 2. @4 gender$ 4. @22 class$ 6.  ;

cards;
24 male "surya teja22" hunter 
24 male "Sai Krishna412" fisher
;
run;

/* fname lname */

%let sk=Sai Krishna;
%let st=Surya Teja;
%Put ----> &sk;

%macro name(&name1,&name2);
data name;
length name $30;
name="&name1";
name="&name2";
;
run;


%name("Sao" "Surya");
proc print data=name;run;

data date;
input apr ddmmyy10.;
cards;
15/04/2002
;
run;
										/* TEST Q&A's */
/* April 15 2002 saturday question */

data d1;
set date;
format apr mmddyy10.;
qdate=qtr(apr);
run;
proc print data=d1;run;


/* what are the variables going to be present in make cat */

data mydata;
input actual rate product$ region$;
cards;
100 500 shirt koti
;
run;

data makecat(drop=actual rate);
	set mydata(keep= product region rate actual);	
	do i=1 to 5;	
		do j=1 to 12;
			capital+(actual+2000)* (rate/12);
		end;
	end;
run;

/* Transpose the date */

data fishsize;
input Location :$15. Date$ Length1 Weight1 Length2 Weight2;
format Length1 Length2 6.2;
infile cards dlm=" " dsd;
cards;
"Cole Pond" 02JUN95 31 0.25 32 0.30
"Cole Pond" 04AUG95 29 0.23 30 0.25
"Eagle Lake" 02JUN95 32 0.35 32 0.25
"Eagle Lake" 04AUG95 33 0.30 33 0.28
;
run;

/* Right Code */
/* again need to write format cuz it's not considering. in 6.2. 6 is the max length of val and two is no of zeroes added*/
proc transpose data=fishsize out=fishsizemax
prefix=Measurement;
by Location Date;
format Length1 Length2 6.2;
run; 
proc print;run;

data revenue;
input year jan feb mar apr;
format jan feb mar apr;
cards;
2000 1.355.656 922.080 735.955 949.515
2001 1.050.000 1.412.444 1.414.662 1.151.872
2002 1.151.666 1.632.612 1.777.726 1.677.727
;
run;

proc transpose data=revenue out=new;


data temp;
x = 1234567890;
x1 = 1234567890123456;
put x= x1=;
run;

%let b=2;
%let a=3;

%put====> %sysevalf(&a*&b);


proc gchart data=sashelp.class;
vbar3d sex/shape=cylinder width=10;
run;

data name;
infile cards  dsd;
input name :$50.;
cards;
"rama krishna" 
"madan mohan moorthy"
"padmaja"
"bette long chock"
"richard rose yao chen garg"
;
run;

data ext;
set name;
last_name=scan(name,-1);
run;

data format_IM;
infile cards dlm=" " dsd ;
input @9 name$ 6. @1 age 2. @4 gender$ 4. @22 class$ 6.  ;

cards;
24 male "surya teja22" hunter 
24 male "Sai Krishna412" fisher
;
run;

proc report data=format_IM nowd list;
column name age gender;
run;