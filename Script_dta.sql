------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
USE Test_DB
GO
--Import the excel sheet to dbo.zzMember_SourceTable_XE1016_22062021

select COUNT(1) from dbo.zzMember_SourceTable_XE1016_22062021
--83 rows affected

SELECT D.MemberID,D.Reference1
INTO #Member_SourceTable_XE1016_22062021
FROM dbo.zzMember_SourceTable_XE1016_22062021 D
--(83 rows affected)
--Temp Table

CREATE UNIQUE CLUSTERED INDEX tmp ON #Member_SourceTable_XE1016_22062021 (MemberId);
GO

SELECT M.MemberId, M.Reference1, M.DateUpdated, M.UpdatedBy
INTO dbo.zzMember_BackUp_XE1016_22062021
FROM MMBRS M
INNER JOIN #Member_SourceTable_XE1016_22062021 W ON W.MemberId = M.MemberId;
--(76 rows affected)
--Backup Table

CREATE TABLE #WorkerTable
(
    [MemberId] INT PRIMARY KEY,
	[Reference1] NVARCHAR(255) NULL
)

WHILE EXISTS (SELECT 1 FROM #Member_SourceTable_XE1016_22062021)

BEGIN

WAITFOR DELAY '00:00:01';

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberId,Reference1)
    SELECT TOP(1000) MemberId,Reference1
    FROM #Member_SourceTable_XE1016_22062021;

    UPDATE M
	SET M.Reference1 = NM.Reference1,
	M.DateUpdated = getdate(),
	M.UpdatedBy = 168
	FROM MMBRS M
	INNER JOIN #WorkerTable NM ON M.MemberID = NM.MemberID

    DELETE S
    FROM #Member_SourceTable_XE1016_22062021 S
    INNER JOIN #WorkerTable W ON S.MemberId = W.MemberId;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
USE Test_DB
GO

SELECT *
INTO [zzJobBriefMethods_Backup_XE1000_09062021]
FROM JBM_Test
--Backup Table

SELECT COUNT(1) FROM JBM_Test
--16

BEGIN TRAN

INSERT INTO [JBM_Test] (BriefMethodID, BriefMethodName, OrderID,IsActive) Values(20,'Video call', 17,1)

COMMIT

SELECT COUNT(1) FROM JBM_Test
---17
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
USE Test_DB
GO

--Import the excel sheet to dbo.zzTbl_MemberBenefitJobs_SourceTable_XE1007_20210615

select COUNT(1) from dbo.zzTbl_MemberBenefitJobs_SourceTable_XE1007_20210615
--81 rows affected

select COUNT(1) from dbo.MBJ_Test
-- 363446

BEGIN TRANSACTION

INSERT INTO MBJ_Test(JobID,MemberBenefitID,VendorBranchID)
SELECT JobID,MemberBenefitID,VendorBranchID from dbo.zzTbl_MemberBenefitJobs_SourceTable_XE1007_20210615

COMMIT
--ROLLBACK

select COUNT(1) from dbo.MBJ_Test
-- 363527
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
USE Test_DB
GO

--Import the excel sheet to dbo.zzMember_TempTable_XE1019_23062021

select count(1) from dbo.zzMember_TempTable_XE1019_23062021
--10 rows selected

SELECT M.MemberID
INTO #Member_SourceTable_XE1019_InActive
FROM Members M
INNER JOIN dbo.zzMember_TempTable_XE1019_23062021 D ON M.MemberID = D.MemberID
--Temp Table
--(10 rows affected)

SELECT M.*
INTO dbo.zzMember_SourceTable_XE1019_23062021
FROM Members M
INNER JOIN dbo.zzMember_TempTable_XE1019_23062021 D ON M.MemberID = D.MemberID
--10 rows
--Backup for Members

--(10 rows affected)


CREATE UNIQUE CLUSTERED INDEX tmp ON #Member_SourceTable_XE1019_InActive (MemberId);
GO

CREATE TABLE #WorkerTable
(
    [MemberId] INT PRIMARY KEY
)

WHILE EXISTS (SELECT 1 FROM #Member_SourceTable_XE1019_InActive)

BEGIN

WAITFOR DELAY '00:00:01';

DECLARE @MembershipStatusID int = 1
DECLARE @DateUpdated datetime = getdate()
DECLARE @UpdatedBy Int = 168

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberId)
    SELECT TOP(500) MemberId
    FROM #Member_SourceTable_XE1019_InActive;

	UPDATE M
	SET M.MembershipStatusID = @MembershipStatusID,
		M.DateUpdated = @DateUpdated,
		M.UpdatedBy = @UpdatedBy
	FROM Members M
	INNER JOIN #WorkerTable NM ON M.MemberID = NM.MemberID
	
DELETE S
    FROM #Member_SourceTable_XE1019_InActive S
    INNER JOIN #WorkerTable W ON S.MemberId = W.MemberId;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
USE Test_DB
GO

--Import the excel sheet to dbo.zzJobs_SourceTable_Sep_XE_1150_09092021

select COUNT(1) from dbo.zzJobs_SourceTable_Sep_XE_1150_09092021
--102 rows affected

SELECT D.JobID
INTO #Jobs_SourceTable_Sep_XE1150
FROM dbo.zzJobs_SourceTable_Sep_XE_1150_09092021 D
--(102 rows affected)
--Temp Table
 
SELECT J.*
INTO dbo.zzJobs_BackUp_Sep_XE1150_08092021
FROM Jobs J
INNER JOIN #Jobs_SourceTable_Sep_XE1150 W ON W.JobID = J.JobID;
--(102 rows affected)
--Backup Table

CREATE UNIQUE CLUSTERED INDEX tmp ON #Jobs_SourceTable_Sep_XE1150 (JobID);
GO

CREATE TABLE #WorkerTable
(
    [JobID] INT PRIMARY KEY
)

WHILE EXISTS (SELECT 1 FROM #Jobs_SourceTable_Sep_XE1150)

BEGIN

WAITFOR DELAY '00:00:01';

DECLARE @JobStatusID int = 0
DECLARE @JobWorkStatusID int = 0
DECLARE @CloseInfo int = 0
DECLARE @ClosedBy int = 168
DECLARE @ClosedByEmpHistoryID int = 20470
DECLARE @ClosedFor int = 7781
DECLARE @ClosedForEmpHistoryID int = 40856
DECLARE @ClosedDate datetime = getdate()

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (JobID)
    SELECT TOP(500) JobID
    FROM #Jobs_SourceTable_Sep_XE1150;
	
	UPDATE J
	SET J.ClosedDate = @ClosedDate,
	J.JobStatusID = @JobStatusID,
	J.JobWorkStatusID = @JobWorkStatusID,
	J.CloseInfo = @CloseInfo,
	J.ClosedBy = @ClosedBy,
	J.ClosedByEmpHistoryID = @ClosedByEmpHistoryID,
	J.ClosedFor = @ClosedFor,
	J.ClosedForEmpHistoryID = @ClosedForEmpHistoryID
	FROM Jobs J
	INNER JOIN #WorkerTable NM ON J.JobID = NM.JobID

    DELETE S
    FROM #Jobs_SourceTable_Sep_XE1150 S
    INNER JOIN #WorkerTable W ON S.JobID = W.JobID;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
USE Test_DB
GO

--Import the excel sheet to dbo.zzMember_TempTable_XE1219_20211110

select count(1) from dbo.zzMember_TempTable_XE1219_20211110
--283 rows selected

SELECT M.MemberID
INTO #Member_SourceTable_XE1219_Active
FROM MMBRS M
INNER JOIN dbo.zzMember_TempTable_XE1219_20211110 D ON M.MemberID = D.MemberID
--Temp Table
--(283 rows affected)

SELECT M.*
INTO dbo.zzMember_SourceTable_XE1219_20211110
FROM MMBRS M
INNER JOIN dbo.zzMember_TempTable_XE1219_20211110 D ON M.MemberID = D.MemberID
--283 rows
--Backup for MMBRS


SELECT MJ.*
INTO dbo.zzMemberJoiningDetails_SourceTable_XE1219_20211110
FROM MMBRS_Joining MJ
INNER JOIN dbo.zzMember_TempTable_XE1219_20211110 D ON MJ.MemberID = D.MemberID
--283 rows
--Backup for MMBRS_Joining

CREATE UNIQUE CLUSTERED INDEX tmp ON #Member_SourceTable_XE1219_Active (MemberId);
GO

CREATE TABLE #WorkerTable
(
    [MemberId] INT PRIMARY KEY
)

WHILE EXISTS (SELECT 1 FROM #Member_SourceTable_XE1219_Active)

BEGIN

WAITFOR DELAY '00:00:01';

DECLARE @MembershipStatusID int = 2
DECLARE @DateUpdated datetime = getdate()
DECLARE @UpdatedBy Int = 168
DECLARE @MembershipLength Int = 36158
DECLARE @RenewalDate datetime = '2121-10-20 00:00:00.000'
DECLARE @DateofCancellation datetime = NULL
DECLARE @RenewalDue datetime = '2121-10-20 00:00:00.000'

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberId)
    SELECT TOP(500) MemberId
    FROM #Member_SourceTable_XE1219_Active;

	UPDATE M
	SET M.MembershipStatusID = @MembershipStatusID,
		M.DateUpdated = @DateUpdated,
		M.UpdatedBy = @UpdatedBy
	FROM MMBRS M
	INNER JOIN #WorkerTable NM ON M.MemberID = NM.MemberID
				
	
	UPDATE MJ
	SET MJ.MembershipLength = @MembershipLength,
		MJ.RenewalDate = @RenewalDate,
		MJ.RenewalDue = @RenewalDue,
		MJ.DateOfCancellation =  @DateofCancellation,
		MJ.DateUpdated = @DateUpdated,
		MJ.UpdatedBy = @UpdatedBy
	FROM MMBRS_Joining MJ
	INNER JOIN #WorkerTable NM ON MJ.MemberID = NM.MemberID
					

    DELETE S
    FROM #Member_SourceTable_XE1219_Active S
    INNER JOIN #WorkerTable W ON S.MemberId = W.MemberId;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
USE Test_DB
GO

SELECT M.*
INTO dbo.zzMember_BackUp_Jan_XE1293_25012022
FROM MMBRS M
Where MemberID in (6129972,6128202)

SELECT AM.*
INTO dbo.zzAdditionalMember_BackUp_Jan_XE1293_25012022
FROM MMBRS_Add AM
WHERE AdditionalMemberID=493225

DECLARE @DateUpdated datetime = getdate()
DECLARE @UpdatedBy Int = 168
Declare @PrimaryID Int=6129972

BEGIN TRANSACTION

Update MMBRS set 
PrimaryID=@PrimaryID, 
DateUpdated=@DateUpdated,
UpdatedBy=@UpdatedBy, 
CitiUniqueID='84449415_40006156554_ANCEN' 
where MemberID=6128202

--ROLLBACK
COMMIT

BEGIN TRANSACTION

Update MMBRS_Add set MemberID=@PrimaryID 
WHERE AdditionalMemberID=493225

--ROLLBACK
COMMIT
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
---Script to cancel jobs
USE Test_DB
GO
--Import the excel sheet to dbo.zzJobs_TempTable_XE1377_20220330
select * from dbo.zzJobs_TempTable_XE1377_20220330
-- 474 rows selected

SELECT J.*
INTO dbo.zzJobs_SourceTable_XE1377_20220330
FROM Jobs J
INNER JOIN dbo.zzJobs_TempTable_XE1377_20220330 D ON J.JobID = D.JobID
--474 rows
--Backup for Jobs

DECLARE @res int

--EXEC tm3_sJob_CancelJob @JobID,@Status,@ReasonForCancelID,@OtherCancelReason,@CancelJobs,@EmployeeID,@ReturnCode

EXEC tm3_sJob_CancelJob  10267744,100, 0, '', '', 168, @res
EXEC tm3_sJob_CancelJob  10269012,100, 0, '', '', 168, @res
EXEC tm3_sJob_CancelJob  10266145,100, 0, '', '', 168, @res

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------Mask (Red_Act)  MBRS
USE Test_DB
GO

--Import the excel sheet to dbo.zzMember_TempTable_XE1652_14112022

select count(*) from dbo.zzMember_TempTable_XE1652_14112022
-- 50 rows selected

SELECT M.MemberID
INTO #Member_SourceTable_XE_1652_14112022
FROM MBRS M
INNER JOIN dbo.zzMember_TempTable_XE1652_14112022 D ON M.MemberID = D.MemberID
--Temp Table

SELECT M.*
INTO dbo.zzMember_SourceTable_XE_1652_14112022
FROM MBRS M
INNER JOIN dbo.zzMember_TempTable_XE1652_14112022 D ON M.MemberID = D.MemberID
------50
--Backup for MBRS

SELECT MJ.*
INTO dbo.zzMemberJoiningDetails_SourceTable_XE_1652_14112022
FROM MBRS_JOINING MJ
INNER JOIN dbo.zzMember_TempTable_XE1652_14112022 D ON MJ.MemberID = D.MemberID
-----49
--Backup for MBRS_JOINING

SELECT MC.*
INTO dbo.zzMemberContactDetails_SourceTable_XE_1652_14112022
FROM MBRS_ContactDetails MC
INNER JOIN dbo.zzMember_TempTable_XE1652_14112022 D ON MC.MemberID = D.MemberID
-----72
--Backup for MBRS_ContactDetails

SELECT MA.*
INTO dbo.zzMemberAddresses_SourceTable_XE_1652_14112022
FROM MemberAddresses MA
INNER JOIN dbo.zzMember_TempTable_XE1652_14112022 D ON MA.MemberID = D.MemberID
----47
--Backup for MemberAddresses

CREATE UNIQUE CLUSTERED INDEX tmp ON #Member_SourceTable_XE_1652_14112022 (MemberId);
GO

CREATE TABLE #WorkerTable
(
    [MemberId] INT PRIMARY KEY
)

WHILE EXISTS (SELECT 1 FROM #Member_SourceTable_XE_1652_14112022)

BEGIN

WAITFOR DELAY '00:00:01';

DECLARE @Firstname nvarchar(50) = '******'
DECLARE @Surname nvarchar(50) = '******'
DECLARE @PrimaryMobile nvarchar(10) = '********'
DECLARE @PrimaryEmail nvarchar(10) = '********'
DECLARE @MembershipStatusID int = 1
DECLARE @Name nvarchar(10) = '********'
DECLARE @EmailOrPhone varchar(10) = '********'
DECLARE @HouseNumber varchar(10) = '********'
DECLARE @HouseName varchar(10) = '********'
DECLARE @Street1 varchar(10) = '********'
DECLARE @Street2 varchar(10) = '********'
DECLARE @City varchar(10) = '********'
DECLARE @State varchar(10) = '********'
DECLARE @PostCode varchar(10) = '********'
DECLARE @Country varchar(2) = '**'
DECLARE @DateUpdated datetime = getdate()
DECLARE @UpdatedBy Int = 168

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberId)
    SELECT TOP(500) MemberId
    FROM #Member_SourceTable_XE_1652_14112022;

	UPDATE M
	SET M.[Firstname] = @Firstname,
	    M.[Surname]  = @Surname,
	    M.[Name] = @Name,
		M.MembershipStatusID = @MembershipStatusID,
		M.PrimaryMobile = @PrimaryMobile, 
		M.PrimaryEmail = @PrimaryEmail, 
		M.DateUpdated = @DateUpdated,
		M.UpdatedBy = @UpdatedBy
	FROM MBRS M
	INNER JOIN #WorkerTable NM ON M.MemberID = NM.MemberID
				
	
	UPDATE MJ
	SET MJ.DateOfCancellation =  @DateUpdated,
		MJ.DateUpdated = @DateUpdated,
		MJ.UpdatedBy = @UpdatedBy
	FROM MBRS_JOINING MJ
	INNER JOIN #WorkerTable NM ON MJ.MemberID = NM.MemberID
					
									
	UPDATE MC
	SET MC.[Value] = @EmailOrPhone,
		MC.PrimaryContact = 0,
		MC.DateUpdated = @DateUpdated, 
		MC.UpdatedBy = @UpdatedBy 
	FROM MBRS_ContactDetails MC
	INNER JOIN #WorkerTable NM ON MC.MemberID = NM.MemberID
	
	
	UPDATE MA
	SET MA.HouseNumber = @HouseNumber,
		MA.HouseName = @HouseName ,
		MA.Street1 = @Street1,
		MA.Street2 = @Street2,		
		MA.City = @City,
		MA.[State] = @State,
		MA.PostCode = @PostCode,
		MA.ISO_CountryID = @Country,
		MA.IsPrimary =0,								
		MA.DateUpdated=@DateUpdated,
		MA.Updatedby=@UpdatedBy 
	FROM MemberAddresses MA
	INNER JOIN #WorkerTable NM ON MA.MemberID = NM.MemberID

    DELETE S
    FROM #Member_SourceTable_XE_1652_14112022 S
    INNER JOIN #WorkerTable W ON S.MemberId = W.MemberId;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


USE Test_DB
GO

--Import the excel sheet to dbo.zztm5_MemberAlert_SourceTable_XE1845_20032023
select COUNT(1) from dbo.zztm5_MemberAlert_SourceTable_XE1845_20032023
--20 rows affected

SELECT D.MemberID
INTO #tm5_MemberAlert_SourceTable_XE1845
FROM dbo.zztm5_MemberAlert_SourceTable_XE1845_20032023 D
--(20 rows affected)
--Temp Table



CREATE UNIQUE CLUSTERED INDEX tmp ON #tm5_MemberAlert_SourceTable_XE1845 (MemberID);
GO

CREATE TABLE #WorkerTable
(
    [MemberID] INT PRIMARY KEY,
	[AlertTypeID] INT NULL,
	[Priority] [int] NULL,
	[Email] [nvarchar](max) NULL,
	[AlertContent] nvarchar(4000) NULL,
	[DateCreated] DateTime NULL,
	[DateUpdated] DateTime NULL,
	[CreatedBy] INT NULL,
	[UpdatedBy] INT NULL,
	[JobAlertEmpID] [nvarchar](max) NULL
)

WHILE EXISTS (SELECT 1 FROM #tm5_MemberAlert_SourceTable_XE1845)

BEGIN

WAITFOR DELAY '00:00:01';

DECLARE @AlertContent nvarchar(4000) = 'Testing Job Alert'

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberID,AlertTypeID, Priority, Email, AlertContent, DateCreated, DateUpdated, CreatedBy, UpdatedBy, JobAlertEmpID)
    SELECT TOP(1000) MemberID, 4, 0, 'AnikoTanczos@tengroup.com', @AlertContent, getDate(), getDate(), 168, 168, '7244'
    FROM #tm5_MemberAlert_SourceTable_XE1845;

	INSERT INTO Tbl_MemberAlertDetails (MemberID,AlertTypeID, Priority, Email, AlertContent, DateCreated, DateUpdated, CreatedBy, UpdatedBy, JobAlertEmpID)
	SELECT TOP(1000) W.MemberID, W.AlertTypeID, W.Priority, W.Email, W.AlertContent, W.DateCreated, W.DateUpdated, W.CreatedBy, W.UpdatedBy,W.JobAlertEmpID
	FROM #WorkerTable W
	

    DELETE S
    FROM #tm5_MemberAlert_SourceTable_XE1845 S
    INNER JOIN #WorkerTable W ON S.MemberID = W.MemberID;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------

