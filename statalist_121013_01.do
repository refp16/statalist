*---------------------------- input --------------------------------------------
clear

input str8 grade
"A"
"A *"
"A *-"
"A *+"
"B"
"B *"
"B *-"
"B *+"
end

*----------------------------- what you want -----------------------------------

* Method 1: Match and use everything after the first substring (i.e. literal)
generate str8 newgrade = regexs(2) if regexm(grade, "^([A-Z]?)(.*)" )

* Method 2: Replace only the "A-Z" literals with a blank.
generate str8 newgrade2 = ""
replace newgrade2 = trim(regexr(grade, "^[A-Z]?", ""))

*Both methods generate a new variable with a leading blank. Method 2 deletes
*it using -trim-.

*-------------------------------------------------------------------------------
