filename target "/home/u60870018/Internshala/classpipedelimited.txt";
data codeChallenge2;
infile target delimiter="|";
input name$ gender$ age weight bmx;
run;