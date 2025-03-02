--SQLQuery8 - INSERT to Schedule for VPD_311
USE VPD_311_Import;
GO

SET DATEFIRST 1; --Первый день недели - Понедельник

DECLARE @group				AS		INT			=	(SELECT group_id			FROM Groups			WHERE group_name		=	'PU_211');
DECLARE @discipline			AS		SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE	N'Объектно%');
DECLARE @number_of_lessons	AS		TINYINT		=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id		=	@discipline);
DECLARE @teacher			AS		SMALLINT	=	(SELECT teacher_id			FROM Teachers		WHERE first_name		=	N'Олег');
DECLARE @start_date			AS		DATE		=	N'2025-03-03';
DECLARE @date				AS		DATE		=	@start_date;
DECLARE @time				AS		TIME(0)		=	N'09:00';

PRINT(@group);
PRINT(@discipline);
PRINT(@number_of_lessons);
PRINT(@teacher);
PRINT(@start_date);
PRINT(@time);
PRINT('============================================================================');

DECLARE @lesson_number		AS		TINYINT		=	0;
WHILE (@lesson_number < @number_of_lessons)
BEGIN
	PRINT(@date);
	PRINT(DATENAME(WEEKDAY, @date));
	PRINT(@lesson_number + 1);
	PRINT(@time);

INSERT Schedule
			([group], discipline, teacher, [date],			[time],		spent)
VALUES		(@group,  @discipline, @teacher, @date,	@time,	IIF(@date < GETDATE(), 1, 0));
	SET @lesson_number = @lesson_number + 1;

------------------------------------------------------------------------------------------

	PRINT(@lesson_number + 1);
	PRINT(DATEADD(MINUTE, 95, @time));

INSERT Schedule
			([group], discipline, teacher, [date], [time], spent)
VALUES		(@group,  @discipline, @teacher, @date,	DATEADD(MINUTE, 95, @time),	IIF(@date < GETDATE(), 1, 0));

	PRINT(@lesson_number + 1);
	PRINT(DATEADD(MINUTE, 190, @time));
	SET @lesson_number = @lesson_number + 1;

	IF @lesson_number % 6 = 0
		SET @date = DATEADD(DAY, 3, @date);
	ELSE
		SET @date = DATEADD(DAY, 2, @date);
END


--SELECT * FROM Schedule;