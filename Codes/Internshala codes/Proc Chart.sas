data forChart;
input name$ gender$ age weight;
cards;
Surya Male 24 68
Krish Male 23 70
Mani Female 24 59
Varsh Female 23 55
doggo Male 7 50
;
run;

proc chart data=forChart;
vbar gender;
hbar gender;
pie gender;
run;

proc plot data=forchart;
plot age * weight;
run;

/* Here we need to use discrete as the values are numeric 
with no discrete sas thinks num variable is a continuous no*/
proc chart data=forChart;
vbar age/discrete;
hbar age/discrete;
run;


data class;
input name$ gender$ courseno Subject$ age;
cards;
surya M 707 Math 24
Ravi M 232 Science 24
Rahul M 512 Math  34
mani f 232 Science 13
koros M 212 Math 32
Ballu M 623 Science 31
Katri F 455 Social 24
velen F 444 Social 34
lucy F 232 Science 21
;
run;

proc chart data=class;
/*
Here, subject is base, grouped courseno so that particular no ppl whose subject is same
will represent in chart, Subgrp emo * place la gender peti, chart chupistad. 2F in science
as 2Female present from no 232 and 1m. summaryvariable is just for y-axis instead of freq
mean is avg of age. just so we need to kknow, default type is sum*/
vbar courseno/discrete group=subject subgroup=gender sumvar=age type=mean;
run;

/* similarly, hbar can be done */
proc plot data=class;
plot age*courseno ="=";
run;

