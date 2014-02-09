clear all
set more off

local sitestub "http://www2.census.gov/census_2010/04-Summary_File_1/"
local states Alabama Alaska
local statesabb al ak

local targetdir "~/Desktop/data/"

local n : word count `states'

forvalues i = 1/`n' {
    local a : word `i' of `states'
	local b : word `i' of `statesabb'
	
	display `"`sitestub'`a'/`b'2010.sf1.zip"' 
	copy `"`sitestub'`a'/`b'2010.sf1.zip"'  `targetdir'
	
	display `"`targetdir'`b'2010.sf1.zip"'
	unzipfile `"`targetdir'`b'2010.sf1.zip"'
}


http://www2.census.gov/census_2010/04-Summary_File_1/STATE/STATE-ABBREVIATION-2010.sf1.zip
Alabama	AL
Alaska	AK
Arizona	AZ
Arkansas	AR
California	CA
Colorado	CO
Connecticut	CT
Delaware	DE
Florida	FL
Georgia	GA
Hawaii	HI
Idaho	ID
Illinois	IL
Indiana	IN
Iowa	IA
Kansas	KS
Kentucky	KY
Louisiana	LA
Maine	ME
Maryland	MD
Massachusetts	MA
Michigan	MI
Minnesota	MN
Mississippi	MS
Missouri	MO
Montana	MT
Nebraska	NE
Nevada	NV
New Hampshire	NH
New Jersey	NJ
New Mexico	NM
New York	NY
North Carolina	NC
North Dakota	ND
Ohio	OH
Oklahoma	OK
Oregon	OR
Pennsylvania	PA
Rhode Island	RI
South Carolina	SC
South Dakota	SD
Tennessee	TN
Texas	TX
Utah	UT
Vermont	VT
Virginia	VA
Washington	WA
West Virginia	WV
Wisconsin	WI
Wyoming	WY
Commonwealth/Territory:	Abbreviation:
American Samoa	AS
District of Columbia	DC
Federated States of Micronesia	FM
Guam	GU
Marshall Islands	MH
Northern Mariana Islands	MP
Palau	PW
Puerto Rico	PR
Virgin Islands	VI
Military "State":	Abbreviation:
Armed Forces Africa	AE
Armed Forces Americas	AA
Armed Forces Canada	AE
Armed Forces Europe	AE
Armed Forces Middle East	AE
Armed Forces Pacific	AP
