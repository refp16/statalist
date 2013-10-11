/*
Based on:

MEASURING AGGLOMERATION: AN EXPLORATORY SPATIAL ANALYSIS APPROACH APPLIED TO
THE CASE OF PARIS AND ITS SURROUNDING.
Rachel Guillain and Julie Le Gallo.
www.real.illinois.edu/d-paper/06/06-t-10.pdf?
*/

*----------------------------- input -------------------------------------------
clear 

input area       ind             sh2  sh1
1                1               0.7  0.70
1                2               0.7  0.15
1                3               0.7  0.05
1                4               0.7  0.10
1                5               0.7  1
2                1               0.2  0.20
2                2               0.2  0.25
2                3               0.2  0.95
2                4               0.2  0.90
3                1               0.1  0.10
3                2               0.1  0.60
end
list, sepby(area)

/*
ind: industry
sh1: Area i's share of employment in industry m
sh2: Area i's share of total employment 

Notice industry 1 is distributed identically to that of total employment and 
that industry 5 is totally concentrated in area 1. Therefore, Gini should be 
0 and 0.5, for the respective industries.
*/

*--------------- Preliminary computations for locational Gini ------------------

* Number of areas (assume area coding starts at 1 and has no jumps)
summarize area, mean
local N = r(max)

* Compute X
gen x = sh1/sh2
drop sh*
list, sepby(area)

*----------------------- What you want (I think) -------------------------------

* Prepare data for subtractions
fillin area ind
drop _fillin 
list, sepby(area)

sort ind x
list, sepby(ind)

* Subtractions (should do N-1 loops)
local K = `N'-1
forvalues i = 1/`K' {
	by ind: gen xp`i' = abs(x[_n] - x[_n+`i'])
	if (`i' == 1) {
	    * Correct for industry that appears only in one area.
	    by ind: replace xp`i' = x if x[2] == . 
    }
}
list, sepby(ind)

* Compute the double sum
egen subtot = rowtotal(xp*)
by ind: egen tot = total(subtot)
list, sepby(ind)

* ------------------ Rest of computations for locational Gini ------------------

*Compute sum of x
by ind: egen xsum = total(x)
list, sepby(ind)

* Drop unnecessary
by ind: keep if _n == 1
drop area xp* subtot
list

* Compute numerator
gen numerator = 1/(`N'-1) * tot

* Compute Locational Gini Coefficient
gen G = numerator/xsum
list
