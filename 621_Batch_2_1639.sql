USE TENMAID3
GO

--Import the excel sheet to zzMember_SourceTable_XE_1639_08112022_Batch_2

select COUNT(1) from dbo.zzMember_SourceTable_XE_1639_08112022_Batch_2
--50000 rows affected

SELECT D.MemberID
INTO #Member_SourceTable_XE_1639_08112022_Batch2
FROM dbo.zzMember_SourceTable_XE_1639_08112022_Batch_2 D
--(50000 rows affected)
--Temp Table

CREATE UNIQUE CLUSTERED INDEX tmp ON #Member_SourceTable_XE_1639_08112022_Batch2 (MemberId);
GO

SELECT M.MemberId, M.CompanyName, M.DateUpdated, M.UpdatedBy
INTO dbo.zzMember_XE_1639_08112022_Batch2_bckup
FROM Members M
INNER JOIN #Member_SourceTable_XE_1639_08112022_Batch2 W ON W.MemberId = M.MemberId;
--(50000 rows affected)
--Backup Table

CREATE TABLE #WorkerTable
(
    [MemberId] INT PRIMARY KEY
)

WHILE EXISTS (SELECT 1 FROM #Member_SourceTable_XE_1639_08112022_Batch2)

BEGIN

WAITFOR DELAY '00:00:01';

BEGIN TRANSACTION

    INSERT INTO #WorkerTable (MemberId)
    SELECT TOP(1000) MemberId
    FROM #Member_SourceTable_XE_1639_08112022_Batch2;

    UPDATE M
	SET M.CompanyName = 'Premier'
	FROM Members M
	INNER JOIN #WorkerTable NM ON M.MemberID = NM.MemberID

    DELETE S
    FROM #Member_SourceTable_XE_1639_08112022_Batch2 S
    INNER JOIN #WorkerTable W ON S.MemberId = W.MemberId;

    TRUNCATE TABLE #WorkerTable;

--ROLLBACK
COMMIT

END