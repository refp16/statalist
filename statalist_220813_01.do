* ----- create input --------
clear
input IDnumber str20 state gdp
1 "alabama" 232
2 "alaska" 145
3 "texas" 160
4 "washington" 250
5 "wyoming" 210
end

list

* ------- what you want -------
sort gdp
gen diff1 = abs(gdp - gdp[_n-1])
gen diff2 = abs(gdp - gdp[_n+1])

gen IDclosest = IDnumber[_n-1] if diff1 < diff2
replace IDclosest = IDnumber[_n+1] if IDclosest == .

* ------ clean database -------
drop diff*

sort IDnumber
list
