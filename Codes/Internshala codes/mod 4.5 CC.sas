data cars;
set sashelp.cars;
run;

proc sort data=cars;
by make;
run;

dm "clear out";

proc means data=cars;
var msrp;
by make;
output out=meandata;
run;
/*mean max min default _stat_ column lo unthai. so nka manam avi find out cheyadaniki
where lo stat peti mean */
proc sort data=meandata out=most_expensive_mean_msrp;
by descending msrp;
where _stat_="MEAN";
run;

proc sort data=cars;
by make;
run;

dm 'clear out';

proc means data= cars ;
var horsepower;
by make;
output out = meandata;
run;
proc sort data=meandata out = most_powerful_Make_horsepower;
by descending horsepower;
where _stat_= 'MAX';
run;
