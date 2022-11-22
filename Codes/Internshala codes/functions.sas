data class;
length name $30.;
infile cards dlm=" " dsd;
input name$ gender$ ability$;
cards;
Surya Male Fly
drax Female speed
west Male power
"surya slark dendi?pudge" . .
;
run;

data class2;
set work.class;
upcase= upcase(name);
lowcase=lowcase(name);
propcase=propcase(name);
nameability= cat(name,ability);
substring=substr(nameability,6,9);
length_NA= length(nameability);
*now using trim function, We can negate the trailing spaces;
*there is no spaces. So, they all look same;
trim=cat(trim(name),ability);
left_trim=cat(trim(left((name))),ability);
strip=cat(strip(name),ability);
/* Considers first letters occurance in a value and gives out its index. before index*/
index=index(name,"dg");
/* considers word rest is same */
indexw=indexw(name,"pudge");
/* experiment to check index and extract word */
subs=substr(name,indexw,indexw+5);
scan=scan(name,3); *scans words;
scan2= scan(name,3,"? ");
scan3=scan(name,2," ");*inside quotations are delimeters including space;
left=left(name); *print la kanipiyad. output data la ostad;
right=right(name);
run;
proc print;run;

data test ;
a="Pokemon                 Unite";
b=compress(a);
compress_letters=compress(a,"t"); *removes letters;
c=compbl(a);
length_compress=length(b);
length_compbl=length(c);
*proc print;
run;
