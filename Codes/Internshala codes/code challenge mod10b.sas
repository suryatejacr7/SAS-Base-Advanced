data test;
	length course $20.;
	input course $;
	cards;

Statistics#102012

Mathematics#30211

Biology#291

History#22133

;
run;

data test1;
	set test;
	x=findc(course, '#');
	coursename=substr(course, 1, x-1);
	courseno=substr(course, x+1);
run;