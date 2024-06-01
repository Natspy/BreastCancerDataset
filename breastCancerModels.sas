/* test */
proc freq data=WORK.breastcancerdataset;
table Chemotherapy;
run;

proc means data=WORK.breastcancerdataset;
var 'Age at Diagnosis'n;
run;

/* Obróbka danych przed modelowaniem */
data daty;
input data;
informat data ddmmyy.;
cards;
1.01.1977
1.01.2005
;

data WORK.breastcancerdataset_m;
    set WORK.breastcancerdataset;

    /* Convert SAS date to character date in dd/mm/yyyy format */
    Entry_date_char_temp = put(Entry_date, ddmmyy10.);
    End_of_time_char_temp = put(End_of_time, ddmmyy10.);
    Date_died_char_temp = put(Date_died, ddmmyy10.);

    /* Replace slashes with spaces */
    Entry_date_char = tranwrd(Entry_date_char_temp, '/', ' ');
    End_of_time_char = tranwrd(End_of_time_char_temp, '/', ' ');
    Date_died_char = tranwrd(Date_died_char_temp, '/', ' ');
    
    /* Drop temporary variables */
    drop Entry_date_char_temp End_of_time_char_temp Date_died_char_temp;
run;

data WORK.breastcancerdataset_m;
set WORK.breastcancerdataset_m;
length date_died_ $10;
if Date_died_char="31 12 2099" then Date_died_="";
else Date_died_=Date_died_char;
run;

data WORK.breastcancerdataset_m;
set WORK.breastcancerdataset_m;
entry_date_n=input(Entry_date_char, ddmmyy10.);
time_n=input(End_of_time_char, ddmmyy10.);
date_died_n=input(Date_died_, ddmmyy10.);
run;

data WORK.breastcancerdataset_m;
set WORK.breastcancerdataset_m;
if 'Age at Diagnosis'n<34 then age_c=1;
if 34<='Age at Diagnosis'n<45 then age_c=2;
if 45<='Age at Diagnosis'n<57 then age_c=3;
if 'Age at Diagnosis'n>=57 then age_c=4;
run;

data WORK.breastcancerdataset_m;
set WORK.breastcancerdataset_m;
if 'Tumor Size'n<25 then tumor_size_c=1;
if 25<='Tumor Size'n<50 then tumor_size_c=2;
if 50<='Tumor Size'n<75 then tumor_size_c=3;
if 'Tumor Size'n>=75 then tumor_size_c=4;
run;

proc freq data=WORK.breastcancerdataset_m;
table
age_c;
run;

data WORK.breastcancerdataset_model;
set WORK.breastcancerdataset_m;
if date_died_n^=. then do;
t=date_died_n-entry_date_n;
c=1;
end;
if date_died_n=. then do;
t=16437-entry_date_n;
c=0;
end;
run;

/* model nieparametryczny - estymacja parametrów tablic trwania ¿ycia*/

/* metod¹ tradycyjna */
proc lifetest data=WORK.breastcancerdataset_model method=lt plots=(s,h,p);
time t*c(0);
run;

/* metod¹ tradycyjna - strata age*/
proc lifetest data=WORK.breastcancerdataset_model method=lt plots=(s,h);
time t*c(0);
strata age_c;
run;

/* metod¹ Kaplana-Meiera */
proc lifetest data=WORK.breastcancerdataset_model method=pl plots=(s, ls, lls);
time t*c(0);
run;

/* metod¹ Kaplana-Meiera w grupach wyznaczonych przez zmienn¹ 'age'*/
proc lifetest data=WORK.breastcancerdataset_model method=pl plots=(s);
time t*c(0);
strata age_c;
run;

/* model parametryczny */

/* Estymacja parametrów modelu wyk³adniczego bez zmiennych objaœniaj¹cych */
proc lifereg data=WORK.breastcancerdataset_model;
model t*c(0)= /dist=exponential;
run;

/* Estymacja parametrów modelu Weibulla bez zmiennych objaœniaj¹cych */
proc lifereg data=WORK.breastcancerdataset_model;
model t*c(0)= /dist=weibull;
run;

/* Estymacja parametrów modelu wyk³adniczego ze zmiennymi objaœniaj¹cymi */
proc lifereg data=WORK.breastcancerdataset_model;
class 'Type of Breast Surgery'n 'Cellularity'n 'Chemotherapy'n
'Radio Therapy'n tumor_size_c 'Tumor Stage'n 'Hormone Therapy'n
'Relapse Free Status'n 'Pam50 + Claudin-low subtype'n age_c
'Cancer Type Detailed'n 'Tumor Other Histologic Subtype'n;
model t*c(0)='Type of Breast Surgery'n 'Cellularity'n 'Chemotherapy'n
'Radio Therapy'n tumor_size_c 'Tumor Stage'n 'Hormone Therapy'n
'Relapse Free Status'n 'Pam50 + Claudin-low subtype'n age_c
'Cancer Type Detailed'n 'Tumor Other Histologic Subtype'n /dist=exponential;
run;

/* Estymacja parametrów modelu Weibulla ze zmiennymi objaœniaj¹cymi */
proc lifereg data=WORK.breastcancerdataset_model;
class 'Type of Breast Surgery'n 'Cellularity'n 'Chemotherapy'n
'Radio Therapy'n tumor_size_c 'Tumor Stage'n 'Hormone Therapy'n
'Relapse Free Status'n 'Pam50 + Claudin-low subtype'n age_c
'Cancer Type Detailed'n 'Tumor Other Histologic Subtype'n;
model t*c(0)='Type of Breast Surgery'n 'Cellularity'n 'Chemotherapy'n
'Radio Therapy'n tumor_size_c 'Tumor Stage'n 'Hormone Therapy'n
'Relapse Free Status'n 'Pam50 + Claudin-low subtype'n age_c
'Cancer Type Detailed'n 'Tumor Other Histologic Subtype'n / dist=weibull;
run;

