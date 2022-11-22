data class;
 set sashelp.class;
 where sex="F";
/*proc sql;
insert into CLASS
values("Surya","M",23,1.75,69.0);*/
 weight_in_kg= weight *0.454;
 height_in_meter= height * 2.54/100;
 BMI= weight_in_kg/(height_in_meter*height_in_meter);
 rename weight_in_kg= Weight_KG height_in_meter=Height_Meter Sex=Gender;
* drop Weight Height;
if bmi<=18 then status='Underweight';

else if 18<bmi<=20 then status='Healthy';

else if 20<bmi<=22 then status='Overweight';

else if bmi> 22 then status='Obese';

proc print;
run; 