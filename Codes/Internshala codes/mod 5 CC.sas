/*Module 4 Assignment 
Solution
Create a SAS Macro that generates reports of the frequency 
distribution table on the Cars data.*/

%macro myStat(var1,var2);
/*step 1: Creating the freq. distribution table*/
proc freq data=carsmerge noprint;
tables &var1*&var2 / out=myFreqtable norow nocol nopercent;
run;
/*Step 2: format report values*/
data myfreqtable1;
set myfreqtable;
value = cat(count,'(',round(percent,.01),'%)');
drop count percent;
run;
/*Step 3: transpose origin var*/
proc transpose data=myFreqtable1 out = t_myfreq;
by &var1;
id &var2;
var value;
run;
title 'Report of Frequency Count and Percentage';
proc print data=t_myfreq (drop=_name_);
run;
%mend;
%myStat(make,origin);
%myStat(make,type);