--SQLQuery3 - GetTeacherID
USE VPD_311_Import;
GO

ALTER FUNCTION GetTeacherID (@last_name NVARCHAR(50)) RETURNS SMALLINT
BEGIN
	RETURN (SELECT teacher_id FROM Teachers WHERE last_name = @last_name);
END