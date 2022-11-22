proc sort data=sashelp.shoes out=sortedshoes;
by descending product sales;
run;


data shoerange;
set sashelp.shoes;
if sales LT 100000 then SalesRange="Lower";
else if 100000<sales<200000 then SalesRange="Middle";
else if sales GT 200000 then SalesRange="Upper";
run;

proc freq data=shoerange;
table SalesRange;
run;

proc means data=shoerange maxdec=0;
class salesrange;
var sales;
run;

Q2.;

data lowchol highchol misschol;
set sashelp.heart;
if cholesterol lt 200 then output lowchol;
if cholesterol ge 200 then output highchol;
if cholesterol ="" then output misschol;
run;

proc univariate data=highchol;
run;

proc univariate data=lowchol;
run;

Q3.;
data WORK.TEMP;
Char1='0123456789';
Char2=substr(Char1,3,4);
run;


Q4.;

data one;
revenue2008=1.2;
revenue2009=1.6;
revenue2010=2.0;
run;

data WORK.TWO;
set WORK.ONE;
Total=sum(of Rev:);
run;

Q5.;

data input;
input var1$ var2$;
cards;
a one
a two
b three
c four
a five
;
run;

data one two;
set input;
if var1="a" then output one;
output;
run;
