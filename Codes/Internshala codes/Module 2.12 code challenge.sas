data class;	
set sashelp.cars;
length units $25;
where make="Acura";
mileage=mpg_highway;
units="Miles per gallon";
output;
kpl_highway=mpg_highway*0.425144;
mileage=kpl_highway;
units="Kilometer per liter";
output;
keep make model type origin  mileage units;
run;	

/*data class2;
set sashelp.cars;
run;*/