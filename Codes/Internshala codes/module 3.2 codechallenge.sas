data CARSASIA;
set sashelp.cars;
where origin="Asia";
run;
data CARSUSA;
set sashelp.cars;
where origin="USA";
run;

proc sort data=carsasia;
by Type;
run;
proc sort data=carsusa;
by Type;
run;

data final;
set carsasia carsusa;
by type;
run;