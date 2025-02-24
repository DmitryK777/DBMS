--SQLQuery3 - Number Of Disciplines for Teachers
USE VPD_311_Import;
GO

SELECT
			[Преподаватель]				=	last_name + ' ' + first_name + ' ' + middle_name,
			[Количество дисциплин]		=	COUNT(discipline_id)
FROM		Teachers, TeachersDisciplinesRelation, Disciplines
WHERE		teacher_id		=	teacher
AND			discipline	=	discipline_id
GROUP BY	last_name + ' ' + first_name + ' ' + middle_name