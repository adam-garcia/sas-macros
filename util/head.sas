%macro head(ds=&syslast, n=10);
    proc print data=&ds (obs=&n);
    run;
%mend;