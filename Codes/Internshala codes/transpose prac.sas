data cd;
input name$ age power$ ability$;
cards;
surya 23 yes lucky
surya 23 no infinite
dragon 24 no road
dragon 23 yes  weather 
dra 23 no catch

faran 24 no 23
dra 23 yes doggo
faran 52 yes play
; run;

proc sort data=cd;
by name ;
run;
proc transpose data=cd out=map;
var ability ;
id power;
by name;
run;