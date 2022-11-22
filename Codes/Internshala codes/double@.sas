data double;
infile cards delimiter=" " dsd;
input name :$12. ability :$17. power age @@;
cards;
"Surya Teja" "Nature Control" 100000 23 "Sai Krishna" "Speed & Strength" 100000 23 "Ravi Teja" "Transformation" 100000 23
;
*proc print;
run; 