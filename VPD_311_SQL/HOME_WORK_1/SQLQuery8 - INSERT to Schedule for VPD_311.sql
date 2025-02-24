--SQLQuery8 - INSERT to Schedule for VPD_311
USE VPD_311_Import;
GO

SET DATEFIRST 1; --Первый день недели - Понедельник

DECLARE @group					AS		INT			=	(SELECT group_id			FROM Groups			WHERE group_name		=	'VPD_311');

DECLARE @discipline_C			AS		SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE	N'Процедурное%');
DECLARE @discipline_H_PC		AS		SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE	N'Hardware-PC');
DECLARE @discipline_W			AS		SMALLINT	=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE	N'Администрирование Windows');

DECLARE @number_of_lessons_C	AS		TINYINT		=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id		=	@discipline_C);
DECLARE @number_of_lessons_H_PC	AS		TINYINT		=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id		=	@discipline_H_PC);
DECLARE @number_of_lessons_W	AS		TINYINT		=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id		=	@discipline_W);
DECLARE @number_of_lessons		AS		TINYINT = @number_of_lessons_C + @number_of_lessons_H_PC + @number_of_lessons_W;

DECLARE @teacher				AS		SMALLINT	=	(SELECT teacher_id			FROM Teachers		WHERE first_name		=	N'Олег');
DECLARE @start_date				AS		DATE		=	N'2023-09-17';
DECLARE @date					AS		DATE		=	@start_date;
DECLARE @time					AS		TIME(0)		=	N'12:00';

PRINT(@group);
--PRINT(@discipline);
--PRINT(@number_of_lessons);
PRINT(@teacher);
PRINT(@start_date);
PRINT(@time);
PRINT('============================================================================');

DECLARE @lesson_number		AS		TINYINT		=	0;
DECLARE @lesson_number_C	AS		TINYINT		=	0;
DECLARE @lesson_number_H_PC	AS		TINYINT		=	0;
DECLARE @lesson_number_W	AS		TINYINT		=	0;

WHILE (@lesson_number < @number_of_lessons)
BEGIN
	PRINT(@date);
	PRINT(DATENAME(WEEKDAY, @date));
	PRINT(@lesson_number + 1);
	PRINT(@time);

INSERT Schedule
			([group], discipline, teacher, [date],	[time],		spent)
VALUES		(@group,  @discipline, @teacher, @date,	@time,	IIF(@date < GETDATE(), 1, 0));
	SET @lesson_number = @lesson_number + 1;

------------------------------------------------------------------------------------------

	PRINT(@lesson_number + 1);
	PRINT(DATEADD(MINUTE, 95, @time));

INSERT Schedule
			([group], discipline, teacher, [date], [time],						spent)
VALUES		(@group,  @discipline, @teacher, @date,	DATEADD(MINUTE, 95, @time),	IIF(@date < GETDATE(), 1, 0));

	PRINT(@lesson_number + 1);
	PRINT(DATEADD(MINUTE, 190, @time));
	SET @lesson_number = @lesson_number + 1;

------------------------------------------------------------------------------------------

INSERT Schedule
			([group], discipline, teacher, [date], [time],							spent)
VALUES		(@group,  @discipline, @teacher, @date,	DATEADD(MINUTE, 190, @time),	IIF(@date < GETDATE(), 1, 0));
	SET @lesson_number = @lesson_number + 1;
	PRINT('--------------------------------------------------------------------------');
	SET @date = DATEADD(WEEK, 1, @date);
END


--SELECT * FROM Schedule;