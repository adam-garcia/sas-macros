%macro head(d=&syslast, n=25, at=1);
data _null_;
    n = &n + &at - 1;
    call symput('n', n);
run;
proc print data=&d (obs=&n firstobs=&at);
    title "First &n observations of dataset &d";
run;
%mend;