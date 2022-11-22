proc sort data=sashelp.cars out=cars;
by MAKE TYPE ORIGIN descending MSRP;
run;

proc sort data=work.cars nodupkey;
by make type origin;
run;

data expensive_car;
set cars;
keep MAKE TYPE ORIGIN MSRP;
proc print;
run;
