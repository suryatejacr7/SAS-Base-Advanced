data class;
input name $ dob favshrt :$26.;
/*used informat to get the elapsed date. change back into sas default date and 
then convert it*/
informat dob date9.;
cards;
John 25Jan2000 EOD

Peter 02Feb1999 FAQ

Liz 05Dec1997 AKA

Joe 18Jul1989 ASAP

Jill 13Sep1982 DIY

Jack 06Mar1990 EOD
;
run;

proc format;
value $shortcut 
"EOD"= "End of day"

"FAQ" ="Frequently asked question"

"AKA"= "Also known as"

"ASAP"="As soon as possible"

"DIY"="Do it yourself";
run;

data class2;
set class;
format dob is8601da. favshrt shortcut.;
proc print;run;