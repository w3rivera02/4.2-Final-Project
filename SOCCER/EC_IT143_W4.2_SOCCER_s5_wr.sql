-- Which countries have won the UEFA Euro?

-- I’m currently working on answering the question:
-- Which countries have won the UEFA Euro?* I’ve found that the euro_summary table contains a winner column 
-- that lists the champion of each tournament year. The next logical step is to select the distinct values from 
-- this column to avoid duplicates and sort them alphabetically. I’m using basic SQL techniques 
-- like SELECT DISTINCT and ORDER BY to keep the results clean and readable, 
-- and I’ve confirmed that each row in the table likely represents a unique tournament year.

SELECT DISTINCT winner
FROM [UEFAEURODB].[dbo].[euro_summary]
ORDER BY winner;
/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_SOCCER_s4_wr.sql
PURPOSE: This script creates a view that returns a distinct, alphabetically sorted list of all countries 
         that have won the UEFA Euro tournament.

MODIFICATION LOG:
Ver      Date        Author         Description
-----   ----------   ------------   -------------------------------------------------------------------------------
1.0     07/25/2025   WRIVERA        1. Created view vw_euro_winners to capture distinct UEFA Euro winners.

RUNTIME: 
Xm Xs

NOTES: 
This view focuses the logic of selecting all unique winners from the euro_summary table.
The purpose of this view is to simplify reuse of this logic in future analysis and reporting.
It supports modular design and allows other views or stored procedures to reference a clean list of winners.

******************************************************************************************************************/

-- Create view to return all distinct UEFA Euro winners
CREATE VIEW dbo.vw_euro_winners AS
SELECT DISTINCT
    winner         -- Country that won the UEFA Euro tournament
FROM
    [UEFAEURODB].[dbo].[euro_summary]
WHERE
    winner IS NOT NULL; 
GO

SELECT winner
FROM dbo.vw_euro_winners
ORDER BY winner;

ALTER TABLE dbo.tbl_euro_winners
ADD id INT IDENTITY(1,1);
IF OBJECT_ID('dbo.tbl_euro_winners', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_euro_winners;

SELECT *
INTO dbo.tbl_euro_winners
FROM dbo.vw_euro_winners;

ALTER TABLE dbo.tbl_euro_winners
ADD CONSTRAINT PK_tbl_euro_winners PRIMARY KEY (id);

ALTER TABLE dbo.tbl_euro_winners
ALTER COLUMN winner NVARCHAR(100) NOT NULL;