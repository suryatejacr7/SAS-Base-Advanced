/*                        SAS Macros

  
1. Here is a procedure that produces the frequency summary report for SEX variable in SASHELP.CLASS

Proc freq data=sashelp.class;

Tables sex;

Run;

2. Create macro called myStats with 3 parameters (lib, dsn, statvar) so that this proc can be run on any dataset in any library and any statistical character variable (Eg. Sex, make, origin, etc.)

3. Once the above macro is ready, call this macro to produce a report on SASHELP.CARS and the variable TYPE

4. Lastly, modify the macro myStats so that it can not only create a frequency summary report but also a Means summary report for numeric variables. 

5. Create a summary report of MEANS on variable MSRP for SASHELP.CARS 
*/
%macro MyStats (lib, dsn, statvar);
proc freq data=&lib..&dsn;
tables &statvar;
run;
%mend;
%myStats(sashelp,cars, make type);
%macro MyStats (lib, dsn, proc, stat, statvar);
proc &proc data=&lib..&dsn;
&stat &statvar;
run;
%mend;
%myStats(sashelp,cars,means,var, msrp);
