options validvarname=upcase;
data a1;
infile cards dlm=" " dsd ;
input name :$40. food :$40. price duration$ 
toppings :$20. toppings_price;
cards;
"Jai Ram" "Veg-manchurian Fried Rice" 60 40M . .
"Surya Teja" "Chicken Noodles" 60 50M Manchuria 10
"Sai Krishna" "veg-Manchurian Fried Rice" 60 30M . .
;
run;
proc sort data=a1;by toppings_price;run;
data total_bill;
set a1;
if name="Jai Ram" then price=30;
else if name="Sai Krishna" then price=30;
retain total 0;
total=sum(total,price);
total_bill=sum(total,toppings_price);
run;

proc sort data=total_bill(keep=total_bill)out=final ;
by descending total_bill;
run;
data f;
set final(obs=1);
run;

/*finding most spent*/
proc sql;
create table most_spent as select max(price) as most_spent
from total_bill;
quit;

/*who ate fast*/
data fast(keep=name Duration);
set a1;
time=int(scan(duration,1,"M"));
if time<=30  ;
run;

Title "Total Amount Paid";
proc print data=f;run;
Title"Most Spent";
proc print data=most_spent;run;
Title"Who Ate Fast";
proc print data=fast;run;


