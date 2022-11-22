data class;
input name$ gender$ age;
cards;
surya male 24
surya male 26
krishna female 23
ravi male 23
sushanth female 23
;
run;


proc sort data=class out=sortclass nodupkey;
by name  gender ; /*sushanth name will print last due to sus hehe.
 1st card line is taken.*/
run;