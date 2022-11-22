data class ;
input name :$28. anime$ power :$30. strength Rating AGE;
infile cards  delimiter=" " dsd;
cards;
Saitama OPM "Super-Human" 100000 9.5 28
"Son Goku" DBZ "Super-Human" 1000000 8 42
"Monkey D Luffy" OP "Devil-Fruit" 10000 10 22
"Light Yagami" DN "Death Note" 100 8.5 20
"Uzumaki Naruto" NARUTO "Nine Tails Fox" 20000 8.8 38
Meliodas SDS "Demon" 100000 7.6 3500
"Surya Teja" "TOS" "Infinity" 10000000000 10 24
"Lelouch vi Britannia" CG "Absolute Obedience" 500 8 28
"Kurosaki Ichigo" BLEACH "Shinigami" 10000 7.4 27
"Asta Staria" BC "Anti-Magic" 100000 8.8 20
"Gon Freecss" HxH "Nen" 15000 9 16
;

run;
data class2; *this is how to rename;
set work.class (rename=(name=NAME Rating=RATING strength=STRENGTH Power=POWER aNime=ANIME));
run;
title "Okay-Okay Anime";
proc print data=class2 noobs;
%let a= 1000 ; 
%let best=8;
%let kid=20;
where strength>&a and rating>&best;
/* overrides first where clause */
where rating<8;
run;

title j=c bcolor=bisque color=cornflowerblue  "BEST ANIME" font='Brush';
proc print data=class2;
where rating>&best;
run;

proc sort data=class2 out=age_wise;
by descending age;
run;

title j=c bcolor=bisque color=cornflowerblue  "Age-Wise" font='serif';
proc print data=age_wise;
where age<30;
run;
/* Nested Macro */
%let a=10;
%let b=a;
%put--------->&&&b;


%let watch=anime;
%let anime=OnePiece;
%let OnePiece=MonkeyDLuffy;
%let MonkeyDLuffy=GodOfSun;

%put -------->&watch;
%put -------->&&&watch;
%put -------->&&&&&&&watch;
%put -------->&&&&&&&&&&&&&&&watch;

							/*MACRO CALL */
							
							
%macro funcSurya(lib,dsn,statvar);
proc means data=&lib..&dsn;
var &statvar;
run;
proc print data=&lib..&dsn;
run;
%mend;

%funcSurya(WORK,CLASS,rating);
%funcSurya(WORK,CLASS,strength);

data trial;
upp="Surya";
run;

%let name= Surya Teja
%let uppercase=%upcase(surya);
%put ======> &uppercase;
/* proc print data=trial; */
/* var &uppercase(); */
/* run;                 */

%let lowcase=%lowcase(&name);
%put ========> &lowcase;

%let substr=%substr(&name,1,5);
%put ========> &substr;

%let length=%length(&name);
%put ========> &length;

%let c=2;
%let d=3;
%let eval=%eval(&c+&d);
%let sysevalf=%sysevalf(2.4+2.4); *this is for decimal and complex numeric vals;
%put ========> &eval next &sysevalf;
