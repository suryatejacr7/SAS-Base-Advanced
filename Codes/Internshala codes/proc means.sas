data class;
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

proc means data=sashelp.class maxdec=2  nonobs;
var weight;
class weight;
run;

proc means data=class;
var age;
run;

proc format;
    value $drivetrain_fmt
	"All" = "All-wheel Drive (AWD)"
	"Front" = "Front-wheel Drive (FWD)"
	"Rear" = "Rear-wheel Drive (RWD)";
run;
 
proc means data=sashelp.cars;
    class drivetrain;
    var invoice;
    format drivetrain $drivetrain_fmt.;
run;

/* Proc Univariate for additional statistical reports */

proc univariate data=class;
var age;
run;

