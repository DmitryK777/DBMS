-- Number of lessons by directions
USE VPD_311_Import;
GO

SELECT
			[�����������]			=	direction_name,
			[���������� �������]	=	COUNT(lesson_id)
FROM		Directions, DisciplinesDirectionsRelation, Disciplines, Schedule
WHERE		direction_id								=	direction
AND			DisciplinesDirectionsRelation.discipline	=	discipline_id
AND			discipline_id								=	Schedule.discipline
GROUP BY	direction_name