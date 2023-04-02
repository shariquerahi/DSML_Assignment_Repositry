Steps-1
	• Upload the data in SQL QA DB.
	• Then Run the below query to extract the first name, middle name, and last name.
	• Add Last word from Fullname  and email to make Reference1  , below SQL QUERY
	SELECT  NAME,[E-mail address],
	right(rtrim([NAME]),charindex(' ',reverse(rtrim([NAME]))+' ')-1)+''+[E-mail address] AS Reference1
	FROM Temp_DNB_Junk_Data_17May2022 
	

SELECT S#N, [E-mail address],name,
    Ltrim(SubString(name, 1, Isnull(Nullif(CHARINDEX(' ', name), 0), 1000))) AS First_Name 
    ,Ltrim(SUBSTRING(name, CharIndex(' ', name), CASE 
                WHEN (CHARINDEX(' ', name, CHARINDEX(' ', name) + 1) - CHARINDEX(' ', name)) <= 0
                    THEN 0
                ELSE CHARINDEX(' ', name, CHARINDEX(' ', name) + 1) - CHARINDEX(' ', name)
                END)) AS Middle_Name
    ,Ltrim(SUBSTRING(name, Isnull(Nullif(CHARINDEX(' ', name, Charindex(' ', name) + 1), 0), CHARINDEX(' ', name)), CASE 
                WHEN Charindex(' ', name) = 0
                    THEN 0
                ELSE LEN(name)
                END)) AS Last_Name from Temp_DNB_Junk_Data_17May2022


	• Add the Character in Proper format, fist later will be capital and rest small. Below excel formula
	=PROPER(F2)
	https://trumpexcel.com/capitalize-first-letter-excel/
	
	• Add Last word from Fullname  and email to make Reference1  , below SQL QUERY

	Select*,LastWord =right(rtrim([ProjectDescription]),charindex(' ',reverse(rtrim([ProjectDescription]))+' ')-1)
 From@YourTable
	
	From <https://stackoverflow.com/questions/58438406/get-last-word-from-string-in-table> 
	
	SELECT  NAME,[E-mail address],
	right(rtrim([NAME]),charindex(' ',reverse(rtrim([NAME]))+' ')-1)+''+[E-mail address] AS Reference1
	FROM Temp_DNB_Junk_Data_17May2022 
