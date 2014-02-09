*---------------- begin code ----------------------

clear all
set more off

* --------------- input data ----------------------
input ///
str20 provname    provcode    str2 lic    str1 atecosec   str1 atecosec2002    numcontrib
AGRIGENTO              84                       AG           A                 A                     100
AGRIGENTO              84                       AG           A                 B                      50
AGRIGENTO              84                       AG           B                 C                      12
AGRIGENTO              84                       AG           C                 D                      79
AGRIGENTO              84                       AG           O                 P                      34
AGRIGENTO              84                       AG           P                 Q                       0
AGRIGENTO              84                       AG           Z                 Z                       1
ALESSANDRIA            6                        AL           A                 A                      29
ALESSANDRIA            6                        AL           A                 B                      12
ALESSANDRIA            6                        AL           B                 C                       0
ALESSANDRIA            6                        AL           C                 D                       5
end

replace numcontrib = .a if provname == "ALESSANDRIA"

list, sepby(provname)


*----------------- your solution -----------------

/*
generate dnumcontrib = 1 if numcontrib == .a

list, sepby(provname)

collapse (sum) *numcontrib, by(provname atecosec)
replace numcontrib = .a if dnumcontrib == 2

list, sepby(provname)
*/

*--------------- alternative solution ------------

bysort provname atecosec: gen countmiss = sum(numcontrib == .a)
by provname atecosec: gen countall = _n

collapse (sum) numcontrib (last) countmiss countall, by(provname atecosec)
replace numcontrib = .a if countmiss == countall
drop count*

list, sepby(provname)

*---------------- end code ------------------------

/*
* This doesn't work
mvencode numcontrib, mv(.a=0)
collapse (sum) numcontrib, by(provname atecosec)
mvdecode numcontrib, mv(0=.a)

list, sepby(provname)
*/
