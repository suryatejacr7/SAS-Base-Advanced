filename code3 "/home/u60870018/Internshala/class.dat";
data codechallenge3;
infile code3;
input name $ 1-5 age $6-7 gender $  @ 17weight;
proc print;
run;
