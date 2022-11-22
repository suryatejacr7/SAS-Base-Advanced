
DATA DS1;
INFILE DATALINES;
INPUT A B C;
DATALINES;
1 2 3
3 4 5
4 5 6
6 7 8
;
RUN;
DATA DS2;
INFILE DATALINES;
INPUT A B D;
DATALINES;
1 3 4
2 . 4
3 4 .
5 7 8
6 . 1
9 5 2
;
RUN;
/*TASK-1*/
DATA DS3; 
SET DS1 DS2; *observatios(rows) increase aythai.variables(cols)will merge;
RUN;
/*TASK-2*/
DATA byA;
SET DS1 DS2;
BY A;
RUN;
/*Addtional Task*/
*second mentioned dataset vals will be prioritized and ds1 vals will be
added if they aren't in ds2;
/*col will be added rows won't increase*/
data with_merge;
merge ds1 ds2;
run; 
/*TASK-3*/
*in double it's taking min obs dataset and second set overiding the 
data of it(ds1) then adding c col to the ds33;
DATA DS33;
SET DS1;
SET DS2;
RUN;
/*TASK-4*/
DATA DS3;
SET DS1;
SET DS2;
BY A;
RUN;
/*TASK-5*/
DATA DS3;
MERGE DS1 DS2;
RUN;
DATA DS3;
MERGE DS1 DS2;
BY A;
RUN;
/*TASK-6*/
DATA DS3;
MERGE DS1(DROP=B) DS2;
BY A;
RUN;
/*TASK-7*/
DATA DS3;
MERGE DS1 DS2(DROP=B);
BY A;
RUN;
/*TASK-8*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=1;
RUN;
/*TASK-9*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF B=1;
RUN;
/*TASK-10*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=1 AND B=1;
RUN;
/*TASK-11*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=1 OR B=1;
RUN;
/*TASK-12*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=1 AND B=0;
RUN;
/*TASK-13*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=0 AND B=1;
RUN;
/*TASK-14*/
DATA DS3;
MERGE DS1(IN=A) DS2(IN=B);
BY A;
IF A=2 OR B=0;
RUN;
/*TASK-15*/
DATA DS3;
UPDATE DS1 DS2;
BY A;
RUN;
/*TASK-16*/
DATA DS3;
MODIFY DS1 DS2;
BY A;
RUN;
