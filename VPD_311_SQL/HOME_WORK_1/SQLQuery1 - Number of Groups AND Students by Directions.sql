--SQLQuery1 - Number of Groups AND Students by Directions
USE VPD_311_Import;
GO

SELECT
			[�����������]			=	direction_name,
			[���������� �����]		=	COUNT(group_id),
			[���������� ���������]	=	COUNT(stud_id)
FROM		Directions, Groups, Students
WHERE		direction_id	=	direction
AND			group_id		=	[group]
GROUP BY	direction_name
;

SELECT * FROM Groups;