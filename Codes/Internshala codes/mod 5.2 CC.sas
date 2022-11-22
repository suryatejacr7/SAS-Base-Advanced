%let mylib=sashelp;
%let mydsn=cars;
%let list= make model origin msrp;
Proc print data = &mylib..&mydsn;
Var &list;
Run;
%let mylib=sashelp;
%let mydsn=class;
%let list= name sex weight height;
Proc print data = &mylib..&mydsn;
Var &list;
Run;
/*
The code to print specific variables from a dataset in a library is this:
Proc print data = &mylib..&mydsn;

Var &list;
Run;
Create macro variables and assign values as follows:
Mylib -> sashelp

Mydsn -> cars

List of variables -> make model origin msrp

 

Run the code to obtain the report output
 

Do the steps 2,3 for the following:
Mylib -> sashelp

Mydsn -> class

List of variables -> name sex weight height*/