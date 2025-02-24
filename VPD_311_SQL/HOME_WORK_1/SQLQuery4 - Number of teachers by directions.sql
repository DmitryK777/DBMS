--SQLQuery4 - Number of teachers by directions
USE VPD_311_Import;
GO

SELECT
			[�����������]				=	direction_name,
			[���������� ��������������]	=	COUNT(teacher_id)
FROM		Directions, DisciplinesDirectionsRelation, Disciplines, TeachersDisciplinesRelation, Teachers
WHERE		direction_id								=	direction
AND			DisciplinesDirectionsRelation.discipline	=	discipline_id
AND			discipline_id								=	TeachersDisciplinesRelation.discipline
AND			teacher										= teacher_id
GROUP BY	direction_name