data class;

length course $20.;

input course $;

cards;

Statistics#1020

Mathematics#3021

Biology#2910

History#2213

;

run;

data class1;
set class;
*year= substr(course,indexc(course,'#')+1,4);
reverse2=(reverse(course));
strip=strip(reverse(course));
substr=substr(strip(reverse(course)),1,4);
year=reverse(substr(strip(reverse(course)),1,4));
run;