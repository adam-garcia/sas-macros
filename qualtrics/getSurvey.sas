/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Get Qualtrics Survey
 * Utility macro for pulling survey data using the Qualtrics REST API
 * Dependencies:
 *    - Python 2.7
 *    - Qualtrics Developer API Key
 *    - 
 * Options:
 *    - svid     Qualtrics Survey ID
 *               <string>::required
 *               https://api.qualtrics.com/docs/parameters#finding-qualtrics-ids
 *    - out      Output dataset
 *               <string>
 *               default = survey_in
 *    - labels   Use data value labels
 *               true | false
 *               default is false
 *    - fmt      Output file format
 *               csv | csv2013 | json | jsonp
 *               default = csv2013
 *    - api      Qualtrics API Token
 *               <string>
 *               default = yY5QbazXQlChrgOAcx5peVQQ5t8TBNO0rNQg6ihb
\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%let adam = yY5QbazXQlChrgOAcx5peVQQ5t8TBNO0rNQg6ihb;
%let py = c:/code/sas-macros/qualtrics/getSurvey.py;
%macro getSurvey(svid, out=survey_in, labels=false, fmt=csv2013, api=yY5QbazXQlChrgOAcx5peVQQ5t8TBNO0rNQg6ihb);

    %if &svid= %then %do;
        %put ERROR: You must supply the SurveyID parameter to macro getSurvey. ;
        %put NOTE:  For more information, visit;
        %put NOTE:  https://api.qualtrics.com/docs/parameters#finding-qualtrics-ids;
        %return;
    %end;

    filename opts temp;
    %let fname = %sysfunc(pathname(opts));
    %let dirname =  %sysfunc(pathname(work));

    data _null_;
        call symput('optsFile', tranwrd("&fname", "\", "/"));
        workdir = tranwrd(
            tranwrd("&dirname", "\", "/"),
            " ", "\ ");
        file opts;
        put '{';
            put '"surveyID":"' "&svid" '",';
            put '"useLabels":"' "&labels" '",';
            put '"format":"' "&fmt" '",';
            put '"apiToken":"' "&&api" '"';
        put '}';
    run;
    * x "python &py -i '&optsFile'";
%mend;
%getSurvey(SV_0BB1UiBAW86d7Zr);



%let subl = C:/'Program Files'/'Sublime Text 3'/sublime_text.exe;
x '"' "&subl" '"' "&fname";

proc datasets; delete a; run; quit;

