data class;
input state $ ;

input fname :$10. lname :$10. gender $ age weight;
cards;
TS
suryateja yamagari sigmamale 23 80
AP 
krishna reddymale female 23 141
AP
jai ram male 25 132
;

proc print;
run;