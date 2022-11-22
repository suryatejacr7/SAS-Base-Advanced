/* 				Module 1 Assignment
				Solution
				Finding the make and mode of the most expensive European car
				that has a price tag of greater than $150,000
*/


filename cars "/home/u60870018/Internshala/carsasiapipedelimited.txt";
data class;
infile cars dlm="|";
input Make :$12. model :$40. type$ origin$ MSRP;
format MSRP dollar8.;

run;


filename CarsEU "/home/u60870018/Internshala/carseu.xlsx";

proc import datafile=CarsEU
DBMS=xlsx
out=carseu;
getnames=yes;
run;

data find;
set carseu;
*if MSRP>=50000 and origin="Europe";
where MSRP>150000;
run;
proc print;
run;

/*Step 1: Importing pipe delimited data*/
/* filename source '/folders/myshortcuts/myFolders/carsasiapipedelimited.txt'; */
/* data carsasia; */
/* infile source delimiter='|'; */
/* length make $20. model $50.; */
/* input make $ model $ type $ origin $ msrp; */
/* Step 2: apply Dollar format for msrp */
/* format msrp dollar8.; */
/* run; */
/* Step 3: Importing cars from Europe in Excel file */
/* filename reffile '/folders/myshortcuts/myFolders/carseu.xlsx'; */
/* proc import datafile=reffile */
/* dbms=xlsx */
/* out = carseu; */
/* getnames=yes; */
/* run; *//* step 4: find the most expensive EU cars above $150k */
/* data carexp; */
/* set carseu; */
/* where msrp>150000; */
/* run; */
/* proc print ; */
/* run; */