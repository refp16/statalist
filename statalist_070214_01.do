*------------ begin code ----------------------------

clear all
set more off

*---------- Load example data -----------

use "~/Desktop/grunfeld.dta"
keep if inrange(company, 1, 2)
drop in 1/5

tsset company year, yearly

drop in 7 // company 1, 1946
drop in 31/32 // company 2, 1950-1951

// COMMENT TO FIX ERROR
replace year = . in 3 // company 1, 1942

list, sepby(company)

*------------ Fill in -------------------

// one way
tsfill, full

list, sepby(company)

/*
// another way
tsfill

list, sepby(company)
*/

*------------ end code -------------------------------
