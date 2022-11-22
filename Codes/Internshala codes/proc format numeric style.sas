PROC FORMAT;
    VALUE GENDERCODE
      0 = 'Male'
      1 = 'Female';
    VALUE ATHLETECODE
      0 = 'Non-athlete'
      1 = 'Athlete';
    VALUE SMOKINGCODE
      0 = 'Nonsmoker'
      1 = 'Past smoker'
      2 = 'Current smoker';
RUN;

data sample;
input name$ gender athlete smoking;
cards;
surya 1 0 1 
dark 0 1 0
melon 1 1 1
paris 0 0 0
mango 0 0 1
tango 1 0 0
;
run;

DATA sample_formatted2;
    SET sample;
    FORMAT gender GENDERCODE. athlete ATHLETECODE. smoking SMOKINGCODE.;
RUN;