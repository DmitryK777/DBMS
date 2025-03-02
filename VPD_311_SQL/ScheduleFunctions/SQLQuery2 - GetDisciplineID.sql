-- SQLQuery2 - GetDisciplineID.sql
USE VPD_311_Import;
GO

ALTER FUNCTION GetDisciplineID (@discipline_name NVARCHAR(10)) RETURNS INT
BEGIN
	RETURN (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discipline_name);
END