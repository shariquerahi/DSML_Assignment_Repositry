DNB_Test Project



select ID, Name,Ltrim(SubString(Name,1,Isnull(Nullif(CHARINDEX(' ',Name),0),1000))) As FirstName,
(Select  Upper(LEFT(FirstName, 1)) + lower(SUBSTRING(FirstName, 2, len(FirstName)))) as 'FirstName_2',
Ltrim(SUBSTRING(Name,CharIndex(' ',Name),
CAse When (CHARINDEX(' ',Name,CHARINDEX(' ',Name)+1)-CHARINDEX(' ',Name))<=0 then 0
else CHARINDEX(' ',Name,CHARINDEX(' ',Name)+1)-CHARINDEX(' ',Name) end )) as MiddleName,
(Select  Upper(LEFT(MiddleName, 1)) + lower(SUBSTRING(MiddleName, 2, len(MiddleName)))) as 'MiddleName2',
LTRIM(RIGHT(REPLACE([Name],' ',REPLICATE(' ',100)),100)) as last_name,(Select  Upper(LEFT(last_name, 1)) + lower(SUBSTRING(last_name, 2, len(last_name)))) AS 'LastNmae2',
TelePh_Num,Email_Address,last_name+Email_Address AS 'Reference1'
,Customer_Place,Programme,Customer_Level,OrgCode,Org_Name,Org_Nave_Niva3,Org_Nave_Niva4,Private_Banker_Ref2,Private_Banker,OrgNavnNiva4_KA
,(Select  Upper(LEFT(FirstName, 1)) + lower(SUBSTRING(FirstName, 2, len(FirstName)))) as Name2 

From Tem_11092021_DNB_TEST121121 order by ID

Select FirstName, Upper(LEFT(FirstName, 1)) + lower(SUBSTRING(FirstName, 2, len(FirstName))) as Name2 
from Tem_11092021_DNB_TEST121121

Select ID,Name, Ltrim(SubString(Name,1,Isnull(Nullif(CHARINDEX(' ',Name),0),1000))) As FirstName,

Ltrim(SUBSTRING(Name,CharIndex(' ',Name),

CAse When (CHARINDEX(' ',Name,CHARINDEX(' ',Name)+1)-CHARINDEX(' ',Name))<=0 then 0

else CHARINDEX(' ',Name,CHARINDEX(' ',Name)+1)-CHARINDEX(' ',Name) end )) as MiddleName,

Ltrim(SUBSTRING(Name,Isnull(Nullif(CHARINDEX(' ',Name,Charindex(' ',Name)+1),0),CHARINDEX(' ',Name)),

Case when Charindex(' ',Name)=0 then 0 else LEN(Name) end)) as LastName

 from Tem_11092021_DNB_TEST121121 where ID IN

SELECT id AS ID2, name
    ,Ltrim(SubString(name, 1, Isnull(Nullif(CHARINDEX(' ', name), 0), 1000))) AS First_Name 
    ,Ltrim(SUBSTRING(name, CharIndex(' ', name), CASE 
                WHEN (CHARINDEX(' ', name, CHARINDEX(' ', name) + 1) - CHARINDEX(' ', name)) <= 0
                    THEN 0
                ELSE CHARINDEX(' ', name, CHARINDEX(' ', name) + 1) - CHARINDEX(' ', name)
                END)) AS Middle_Name
    ,Ltrim(SUBSTRING(name, Isnull(Nullif(CHARINDEX(' ', name, Charindex(' ', name) + 1), 0), CHARINDEX(' ', name)), CASE 
                WHEN Charindex(' ', name) = 0
                    THEN 0
                ELSE LEN(name)
                END)) AS Last_Name,
(Select  Upper(LEFT(last_name, 1)) + lower(SUBSTRING(last_name, 2, len(last_name)))) AS 'LastNmae'
FROM Tem_11092021_DNB_TEST121121 order by ID
