* ----------------------- begin code -----------------------

clear all
set more off

* Input fake databases (including -dum- variable)
input str1 company year size rat
A                  2012        140                    0.2
B                  2011        200                   0.4
C                  2010        300                    0.2
D                  2010        160                    0.5
end

gen dum = 1

tempfile samp
save "`samp'"

clear all
input str4 company year size rat
X                  2012        150                    0.19
XX                  2012        150                    0.20
XXX                  2012        150                    0.22
XXXX                  2012        150                    0.195
Y                  2010        280                   0.9
YY                  2010        280                   0.9
Z                  2012        50                      0.01
ZZ                  2010        300                    0.2
T                  2011        200                   0.95
U                  2010        300                    0.10
end

gen dum = 1

tempfile pop
save "`pop'"


* Main process
tempfile result
local lowlimit .8
local highlimit 1.2

quietly {
	forvalues i = 1/4 { // 4 is # observations in sample file
	  use "`samp'" in `i', clear
	  rename (company year size rat) =0
	  joinby dum using "`pop'"
	  drop dum
	  
	  keep if year0 == year // compare companies with same year only
	  keep if inrange(size, `lowlimit'*size0, `highlimit'*size0)
	  
	  gen ratdif = abs(rat0 - rat)
	  * Ties in -ratdif- are broken alphabetically by -company- name
	  isid ratdif company, sort
	  capture keep in 1/3
	  
	  if (`i' == 1) save "`result'"
	  else {
		append using "`result'"
		save "`result'", replace
	  }
	  
	}

}

* Check and reshape
use "`result'", clear
isid company0 ratdif company, sort
list, sepby(company0)

keep company* 
list, sepby(company0)

by company0: gen id = _n
reshape wide company, i(company0) j(id)
list, separator(0)

*------------------------- end code ------------------------

