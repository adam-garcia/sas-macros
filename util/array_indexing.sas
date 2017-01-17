%macro arrIndex(n);
    data _null_;
        a0=0;a1=1;a2=2;a3=3;a4=4;a5=5;a6=6;a7=7;a8=8;a9=9;
        array nums[10] a0-a9;
        i = abs(mod(input("&n", best32.) + 1, 10));
        put nums[i];
    run;
%mend;
%arrIndex(-1);

%macro errCode(code);

data _null_;
    array nums[*] num0--num9;
    do i = 0 to 9;

    end;
    a = substr("&code", 2, 1);
    put a;
run;
%mend;
%errCode(1234);



data _null_;
    x=12;
put x best2.;
run;


a1=1;a2=2;a3=3;a4=4;a5=5;a6=6;a7=7;a8=8;a9=9;a10=10;


data _null_;
    a1=1;a2=2;a3=3;a4=4;a5=5;a6=6;a7=7;a8=8;a9=9;a10=10;
    
run;
