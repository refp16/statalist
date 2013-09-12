* ------------------------------ input---------------------------------

clear
input person eventStart str20 eventType
1                  10                  work
1                  14                  lunch
1                  15                  work
1                  16                  work
1                  33                  shopping
1                  34                  shopping
end

*-------------------- what you want---------------------------------

gen dum =1 if eventType == "work"
gen before = sum(dum) -1
replace before = before + 1 if dum == .

egen tot = max(before)
gen after = tot - before - 1
replace after = after + 1 if dum == .

*---------------------clean up-----------------------------
drop dum tot
list
