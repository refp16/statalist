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

* Compute x
gen x = sh1/sh2
drop sh*

*Compute sum of x
bysort ind: egen xsum = total(x)

*----------------------- What you want (I think) -------------------------------

tempfile main
save "`main'"

rename (area x) =0
joinby ind using "`main'"

gen dif = abs(x-x0)

* ------------------ Rest of computations for locational Gini ------------------

* Only need one pair (.,.) so (j,k) is considered duplicate of (k,j). Drop one.
drop if area > area0 
* Correct for industries that appear only in one area.
by ind: replace dif = x if _N==1 
* Drop pairs (j,j) unless industry appears only in one area.
by ind: drop if (area == area0) & (_N>1)

* Compute the double sum
collapse (mean) xsum (sum) tot=dif, by(ind)

* Compute numerator
gen numerator = 1/(`N'-1) * tot
 
* Compute Locational Gini Coefficient
gen G = numerator/xsum
list





