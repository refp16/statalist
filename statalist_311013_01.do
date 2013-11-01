*------------- begin code --------------
clear
set more off

input obs hosp14  hosp15 hosp16
1   1      5    5 
2   6      9    6
3   8      1    3
4   5      5    5
5   2      2    2
6   2      9    1
7   1      1    1
8   3      1    7
9   3      0    4
end

list

* Reshape to manipulate
reshape long hosp, i(obs) j(hnum)

sort obs hosp hnum // important
gen hosp2 = hosp
by obs: replace hosp2 = . if hosp[_n] == hosp[_n-1]

drop hosp
rename hosp2 hosp

* Take back to original form
reshape wide hosp, i(obs) j(hnum)
list // compare this with original input

*-------------- end code ---------------
