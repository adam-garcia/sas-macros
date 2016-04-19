%macro rgb2hex(r, g, b);
    data _null_;
        hr = put(put(&r, hex2.), $2.);
        hg = put(put(&g, hex2.), $2.);
        hb = put(put(&b, hex2.), $2.);
        hex = hr||hg||hb;
        put hex=;
    run;
%mend;
