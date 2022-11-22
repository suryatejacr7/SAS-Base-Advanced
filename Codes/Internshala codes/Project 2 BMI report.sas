/* Step 1: Import  data from excel into SAS */
filename stat "/home/u60870018/Internshala/STAT.xlsx";

proc import datafile=stat
dbms=xlsx 
out=stat;
getnames=yes;
run;

filename studht "/home/u60870018/Internshala/STUDHT.xlsx";

proc import datafile=studht
dbms=xlsx 
out=studht;
getnames=yes;
run;


filename hist "/home/u60870018/Internshala/HIST.xlsx";

proc import datafile=hist
dbms=xlsx 
out=hist;
getnames=yes;
run;


/* Stacking stat and hist files */

data stathist;
set stat hist;
run;

/* Merging studht with stathist*/

proc sort data=stathist;
by name;
run;

proc sort data=studht;
by name;
run;

data statall;
merge stathist studht;
run;

/* Converting weight and height into metric system*/

data BMI_check;
set statall;

weightkg=weight*0.454;
heightm=height*2.54/100;
bmi=weightkg/(heightm*heightm);


if bmi<=18 then status="Underweight";
else if 18 <=bmi<25 then status="Healthy";
else if 25<=bmi<30 then status="Overweight";
else if bmi>=30 then status ="Obese";
run;

/*Project 2 Statement

Create a report of frequency distribution table on the STATUS variable

Using the Students Health data (HIST, STAT, STUDHT datasets), you will have to do the following:

1. Create a frequency distribution table of the gender and status variables, and save the output in a dataset.

2. Concatenate the count and percentage variables to obtain final reportable values. The values should be formatted precisely in this format, where xx is the count and yy.yy is the percentage ----> xx (yy.yy%)

3. Transpose the dataset in such a way that the STATUS variable is transposed across the table.

4. Create a final report with the title "Report of Frequency Table" and the summary statistics obtained above. The
*/
/* step 1 creating freq table*/
proc freq data=bmi_check;
table gender*status/out=freqtable;
run;

/* creating report format; */

data reporttable;
set freqtable;
value=cat(count,'(',round(percent,.01),'%)');
drop count percent;
run;

/* Tranposing status variable */

proc transpose data=reporttable out=tranposed_report;
by gender;
id status;
var value;
run;

/* creating final report */
title "Report of frequency table";
proc print data=tranposed_report (drop=_name_);
run;
