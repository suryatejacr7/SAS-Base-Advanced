/*Import the Patients.xlsx Excel sheet into SAS (if you haven’t already imported it as a part of earlier code challenges)
Create a new variable called AGEGROUP with the following definition:
 Age less than 18 years (18 including) → '<=18 years'
18 to 65 years (65 including) ='18 to 65 years'
Greater than 65 years → '>65 years'
Create a summary of the frequency report using PROC FREQ and answer the following questions:
How many female patients in the dataset are older than 65 years?
A:1
What percentage of male patients are between 18 to 65 years of age?
A: 85.7% (12 patients)
How many total patients are of age less than 18 years?
A:1*/

FILENAME REFFILE '/home/u60870018/Internshala/Patients (1).xlsx';

PROC IMPORT DATAFILE=REFFILE
DBMS=XLSX
OUT=WORK.PATIENTS REPLACE;
GETNAMES=YES;
RUN;
data patients1;
set patients;
format dob1 date9.;
/*creating a new variable for date of birth*/
dob=compress(cat(month,'/', day,'/', year));
dob1= input(dob, mmddyy10.);
/*calculating the age of patients*/
age = (today()-dob1)/365;
run;
proc sort data= patients1;
by sex;
run;
proc means data = patients1;
var age;
run;
proc means data = patients1;
var age;
by sex;
run;
/*obtain statistical parameters for race*/
proc format;
value agegrp
low-18='<=18 years'
18-65='18 to 65 years'
65-high='>65 years'
;
run;
data patients2;
set patients1;
agegroup = put(age, agegrp.);
run;
proc freq data= patients2 ;
table sex*agegroup / outpct out = agegrpstats;
run;
data agegrpstats1;
set agegrpstats;
value = cat(count, ' (', strip(put(round(pct_row,.1),8.1)), '%)');
rename agegroup = stat;
drop count percent pct_row pct_col;
run;