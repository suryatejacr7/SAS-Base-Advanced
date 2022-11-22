/*
			Module 2 Assignment
			Solution
			Finding the cheapest European SUV car that gives the highest
			mileage (miles per gallon of fuel)
*/

libname source " /home/u60870018/Internshala";

/* proc print data=source.carsusa; */
/* run; */


proc import file="/home/u60870018/Internshala/carsmpg.xlsx"
out=carsmileage
dbms=xlsx
replace;
run;

data CARSASIA;
set sashelp.cars;
where origin="Asia";
run;

data CARSUSA;
set sashelp.cars;
where origin="USA";
run;

data carseu;
set sashelp.cars;
where origin="europe";
run; 

proc sort data=source.carsusa;
by type;
run;
proc sort data=carsasia;
by Type;
run;
proc sort data=carsusa;
by Type;
run;

/* just to check the count of the dataset. direct ga source.carsusa petina ochestad*/
data carsusa;
set source.carsusa;
run;

data allorigins;
set sashelp.cars;
run;

data stackedcars;
set allorigins carsusa;
/* by type; */
run;
proc sort data=stackedcars;
by make model;
run;
proc sort data=carsmileage;
by make model;
run;

data highestmileage;
merge stackedcars carsmileage;
by make model;
run;

proc sql;
create table cheap_and_best as select * from highestmileage
/* order by msrp,  mpg_highway desc; */
quit;
proc sort data=cheap_and_best;
by msrp descending mpg_city descending mpg_highway;
where origin="Europe" and Type="SUV";
run;
proc print data=cheap_and_best;
run;

/* Step 1: import US cars */
libname source '/folders/myshortcuts/myFolders';
data carsusa;
set source.carsusa;
run;
/* Step 2: MPG data from Excel file */
proc import datafile= '/folders/myshortcuts/myFolders/carsmpg.xlsx'
out=carsmpg
dbms=xlsx;
getnames=yes;
run;
/* Step 3: stack all cars data into one */
data cars;
set carsusa carseu carsasia;
make=strip(make);
model=strip(model);
run;
data carsmpg;
set carsmpg;
make=strip(make);
model=strip(model);
run;
proc sort data=cars;
by make model;
proc sort data=carsmpg;
by make model;
run;
/* step 4: merge mileage data */
data carsmerge;
merge cars carsmpg;
by make model;
run;
/* finding the cheapest European SUV with highest mileage */
proc sort data=carsmerge out=carschoice;
by msrp descending mpg_highway;
where origin='Europe' and type ='SUV';
run;
proc print ;
run;

