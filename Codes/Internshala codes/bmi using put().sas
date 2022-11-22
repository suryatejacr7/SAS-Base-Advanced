/*Proc Formats. Changing the incoming data into more meaningful
and formated/altered data*/
proc format;
value report
low-18.5="Under Weight"
18.5-25="Healthy"
25.0-30="Overweight"
30-high="Obese";
run;

data weight;
input name :$16. gender :$25. weight height;
infile cards delimiter=" " dsd;
cards;
"Surya Teja" "Sigma Male" 70 1.73736
Varshini "Sigma Female" 57 1.55448
"Sharath Babu" "Just Male" 70 1.76784
"Sai Krishna" Both(FM) 90 1.79832
Sushanth Both(FM) 54 1.6764
"Ravi Teja" "Beta Male" 70 1.76784
"Sai Chaitanya" "Beta Male" 95 1.8034
Ravali Female 54 1.58496
"Devika" "Female" 60 1.6764
mahesh male 57 1.55448
;
run;

/*using put()*/
data weight2;
SET weight;
bmi= weight/(height*height);
status=put(bmi,report.);
proc print;
run;

/* using format*/	
data weight3;
SET weight;
bmi= weight/(height*height);
format BMI report.; /*here used status as a variable name to take bmi value
from weight2 dataset.*/
proc print;
run;