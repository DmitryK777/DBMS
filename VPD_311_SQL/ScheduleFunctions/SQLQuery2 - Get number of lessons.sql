--SQLQuery2 - Get number of lessons
USE VPD_311_Import;
GO

CREATE FUNCTION GetNumberOfLessons (@discipline_name NVARCHAR(10)) RETURNS INT
BEGIN
	RETURN (SELECT number_of_lessons FROM Disciplines WHERE discipline_name LIKE @discipline_name);
END