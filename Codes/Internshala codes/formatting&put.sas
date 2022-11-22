data salary ;
input id name$ salary ;

format salary dollar18.2 id ssn11.;

dog=put(salary,dollar18.2);
cat=put( id,ssn11.);cards;
17 Surya 789456123
24 Krishna 46513675
44 Mahesh 54522215
;

run;	

data bonus;
input name$ bonus salary dob;
informat bonus dollar6. dob date7.;
cards;
Surya $40000 612353 23Feb98
Krishna $12441 443234 29Feb 16
Doggi $12122 12144122 12May23
;
run;
