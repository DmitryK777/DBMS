--SQLQuery2 - Number Of Teachers by Disciplines
USE VPD_311_Import;
GO

SELECT
			[Дисциплина]					=	discipline_name,
			[Количество преподавателей]		=	COUNT(teacher_id)
FROM		Disciplines, TeachersDisciplinesRelation, Teachers
WHERE		discipline_id	=	discipline
AND			teacher		=	teacher_id
GROUP BY	discipline_name