data ckass;
input name$ gender$ age weight area$;
cards;
Surya M 24 69 HYD
Krish M 24 88 BACH
Jai M 26 77 HYD
Varsh F 23 52 BEG
Manasa . 24 67 ALW
Nidhi F 23 45 LH
Nani M 13 66 BACH
Sai M 23 61 HYD
;
run;
/* he said we can't apply on purely numeric values like age */
proc freq data=ckass;
table area;
run;



proc freq data=ckass;
table age;
run;