/* SAS way of creating, copying, filtering, sorting data and duplicate key */
data class1;
set sashelp.class;
proc sort data=class1 out= sas_class2;
where sex="M";
by age weight ;
run;

/* sequel way */
proc sql;
create table proc_class as select * from sashelp.class
/* where sex="M" */
order by  sex,weight,age; *first var gets first served;
quit;

data onePiece;
length Name $30 DevilFruit $30;
input Name $ DevilFruit$ Haki$;
infile cards delimiter=" " dsd;
cards;
Luffy "Gomu Gomu No Mi" Yes
Ace "Mera Mera No Mi" Yes
"Tony Tony Chopper" "Hito Hito No Mi" No
"Tony Tony Chopper" "Hito Hito No Mi" No
;

/* Duplicate key */
proc sql;
create table sortedOP as select DISTINCT * from onePiece;

/* Transposing data. changing variables into observations & wise versa */
proc transpose data=sortedOP out=transposedData;
var DevilFruit Haki;
id name;
run;
quit;

data change;
length Haki $10;
input sid Name$ Haki$ Available$;
cards;
1 Luffy pre_time No
1 Luffy time_skip Yes
2 Zoro pre_time No
2 Zoro time_skip Yes
4 Sanji pre_time No
3 Jinbei pre_time Yes
3 Jinbei time_skip Yes
4 Sanji time_skip Yes
;
run;

/* Here we need to sort the cards in ascending order for transpose to work
should be same list of variables */
proc sort data=change;
by sid Name;
run;

proc transpose data=change out=t_change;
var available ;
label _NAME_=haki;/*need to change view to column labels*/
id  haki;
by sid name  ; *here we give those variables we wish to retain as it is;
run;

proc print data=t_change noobs n;
run;



