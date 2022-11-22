
data s;
zone="WEST";
Zonal="Jackson Hope";
;
run;

data t;
infile cards dlm=" " dsd;
input emp :$15. age income gender$;
cards;
Farmer 38 1 F
"Jones K" 40 1 F
Simonson 26 1 M
Hazelton 40 1 M
Black 25 3 M
Black 25 3 M
Brown 30 1 M
Black 25 3 M
Ander 20 1 M
Parker 28 3 F
Meyer 21 1 F
LeBlanc 33 1 F
;
run;

proc sort data=t;by gender;run;

data st;
merge s(in=a) t(in=b);
if b;
run;
proc print data=st(rename=(emp=emp name));run;

title color=blue bold "fagadfsggafgavx" ;
footnote color=red bold "Keyboard Mouse";
proc sql;
select zone 'ZONE', zonal 'ZONAL MANAGER',emp 'EMP NAME', age 'AGE',
income 'INCOME', gender 'GENDER'
from st;
quit;

