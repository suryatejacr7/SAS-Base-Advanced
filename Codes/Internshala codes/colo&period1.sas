data cls ;
infile cards dlm=","  dsd ;
input name $13. gender $ age height weight locality :$43.;
*if locality="Kompally" then delete;
cards;
"Surya,Teja",Ma le,23,175,69,Ramanthapuram
"Sai,Krishna",Male,23,180,150,Kompally
"Jai,Ram",Male,23,172,120,Ramanthapuram
;
run;

data cls2 ;
infile cards dlm=" "  dsd ;
input name :$13. gender $ age height weight locality :$43.;
*if locality="Kompally" then delete;
cards;
"Surya Teja" "Ma le" 23 175 69 Ramanthapuram
"Sai Krishna" Male 23 180 150 Kompally
"Jai Ram" Male 23 172 120 Ramanthapuram
;

proc print data=cls; 
run;
proc print data=cls2;
run;