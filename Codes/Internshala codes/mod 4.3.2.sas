proc chart data=sashelp.cars;
vbar make/discrete sumvar=msrp type=mean;
run;quit;