proc report data=sashelp.cars;
cols Make Type Origin MSRP=summsrp MSRP=meanmsrp ;
define Make/group left style(header)={just=right};
define type/group;
define origin/group ;
define summsrp/ analysis sum "Sum Retail Price" ;
define meanmsrp/ analysis mean "Mean Retail Price";
title1 j=L c=aquamarine f=algerian h=10 bold  "SURYA TEJA man";
footnote bc=black c=gold  h=20 "@_@ Ramanthapur Selfie Star Sharath Babu ^+^";
 run;


proc format;
value $origin "Asia"="Grey" "USA"="Pink";
run;
proc print data=sashelp.cars;
var make type origin/style(data)={backgroundcolor=$origin.};
run;