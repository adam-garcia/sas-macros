%macro where(ds=&syslast, cond=1 eq 1);
    proc print data=&ds;
        where &cond;
    run;
%mend;
