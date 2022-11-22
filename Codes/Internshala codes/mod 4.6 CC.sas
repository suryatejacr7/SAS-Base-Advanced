ods trace on;
proc univariate data=sashelp.class;
var age;
run;
ods trace off;


ods trace on;
ods Output Univariate.age.Quantiles=Quantiles;
proc univariate data=sashelp.class;
var age;
run;
ods trace OFF;
