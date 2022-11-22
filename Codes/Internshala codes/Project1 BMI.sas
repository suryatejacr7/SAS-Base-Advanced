/*Analyze the data of students by generating a pie chart of their health status (underweight, healthy, overweight or obese)

You have data of students (in Excel sheets) from two different classes (STAT for Statistics and HIST for History) containing their weights data. There is a separate dataset called STUHT (Student Height) containing heights data of all those students from the two classes STAT.

1. Import the data from Excel sheets into SAS (using SAS import wizard or Proc Import) 

2. Stack data from STAT and HIST (you can use either the data step or Proc Append)

3. Merge with the STUDHT dataset (you can use either the data step or Proc SQL)

4. Convert the weight and height into Metric system units using the following formulae:

a. Weight (in US-pounds (lbs)) multiplied by 0.454 is Weight (in Kilograms (kgs))

b. Height (in inches) multiplied by 2.54/100 in Height in Meters

5. Create a variable called BMI from their weight and heights using the formula:

BMI = weight in kilograms/square of the height in meters

6. Apply conditional logic to create a 'STATUS' variable assigning if the students are Underweight, Healthy, Overweight, or Obese based on the following criteria:

a. Underweight, if BMI is less than 18

b. Healthy, if BMI is great than or equal to 18 and less than 20

c. Overweight, if BMI is great than or equal to 20 and less than 22

d. Obese, if BMI is great than or equal to 22

7. Final step is to generate the pie chart on the variable Status;
*/

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

/* creating pie chart for bmi_check dataset variable status*/;
proc chart data=bmi_check;
pie status;
run;
