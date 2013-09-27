*-------------------------- begin example --------------------------------------
clear
input str2 firm year event
A        1994       2
A        1994       3
A        1994       3
A        1995       1
A         1995      3
A         1996       2
A         1996       4
A         1996       3
A          1997       3
A           1997      3
A           1998       1
A            1998       1
B         1995      3
B         1996       2
B         1996       4
B         1996       3
end

*what you want
sort firm year event
by firm year: keep if event[1] == event[_N] & event == 3

*----------------------- end example -------------------------------------------
