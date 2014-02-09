*------------------- begin code ---------------------------

clear all
set more off

*-------------------- example data ----------

input ///
ID     str12  Date            Ret       
1       "July00"         0.05            
1       "Aug00"         0.04
1       "Sept00"         0.07
1       "Oct00"        -0.08
1       "Nov00"         -0.02
1       "Dec00"          0.05
1       "Jan01"          0.03
1       "Feb01"          0.02
1       "March01"        0.01
1       "April01"       -0.04
1       "May01"         -0.03
1       "June01"        -0.02
1       "July01"        -0.01
1       "Aug01"          0.05
1       "Sept01"         0.06
1       "Oct01"          0.07
1       "Nov01"          0.08
1       "Dec01"        -0.10
end

gen dt = date(Date, "M20Y")
format %td dt

gen yr = year(dt)
drop dt

list, separator(0)

*---------------------- compute returns --------

// one way
bysort ID yr: egen yearendret = total(Ret)

// another way
collapse (sum) yearendret=Ret, by(ID yr)

*-----------------end code -----------------------------
