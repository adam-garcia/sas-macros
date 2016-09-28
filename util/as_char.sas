%macro as_char(v);
    call symput('vl', vlength(v));
    _v = input(v, $&vl..);
    drop v;
    rename _v = v;
%mend as_char;
