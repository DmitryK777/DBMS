-- SetAllDaysOFF
USE VPD_311_Import;
SET DATEFIRST 1;
GO

ALTER PROCEDURE sp_SetAllDaysOFF @year	AS SMALLINT

AS
BEGIN

	EXEC sp_SetDaysOFF N'���%', @year;
	EXEC sp_SetDaysOFF N'23%', @year;
	EXEC sp_SetDaysOFF N'8%', @year;
	EXEC sp_SetDaysOFF N'���%', @year;
	EXEC sp_SetDaysOFF N'���%', @year;
	EXEC sp_SetDaysOFF N'���%', @year;

END