data salary;
input name$ quarter$ salary;
cards;
surya q1 240000
surya q2 240000
surya q3 250000
krish q1 200000
krish q2 200000
krish q3 220000
mahesh q1 200000
mahesh q2 203000
mahesh q3 200000
;
run;

proc sort data=salary;
by name;
run;

data total_salary;
set salary;
by name;
retain totalsalary 0;
totalsalary=totalsalary+salary;
if first.name then totalsalary=salary;
if last.name then bonus= totalsalary* .10;/*bonus sal of 10% from totalsal*/
run;


data have;
input FullName $30.;
datalines;
George W. Bush
George W Bush
George Bush
;

data want;
set have;
call scan(fullname, -1, position, length);
firstname=substr(fullname,1,position-1);
last=scan(fullname,-1,' ') ;
keep firstname last fullname;
run;