--SQLQuery1 - Number of Groups AND Students by Directions
USE VPD_311_Import;
GO

SELECT
			[Направление]			=	direction_name,
			[Количество групп]		=	COUNT(group_id),
			[Количество студентов]	=	COUNT(stud_id)
FROM		Directions, Groups, Students
WHERE		direction_id	=	direction
AND			group_id		=	[group]
GROUP BY	direction_name
;

SELECT * FROM Groups;