filename patients "/home/u60870018/Internshala/Patients.xlsx";
proc import datafile=patients
dbms=xlsx
out=patients;
getnames=yes;
run;

data patients1;
set patients;
format dob1 date9.;
dob =compress(cat(month,"/",day,"/",year));
dob1=input(dob,mmddyy10.);

/* calculating the age of patients */

Age= floor((today()-dob1)/365); /*Returns the largest integer less than or equal to a numeric value expression.*/


run;