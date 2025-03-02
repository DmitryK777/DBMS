-- SQLQuery0 - Check
USE VPD_311_Import;
SET DATEFIRST 1;
GO

--EXEC sp_SelectSchedule;
--EXEC sp_SelectScheduleForGroup N'VPD_311';

EXEC sp_SetScheduleForSemistacionar N'VPD_311', N'%UML%', N'2024-08-25', N'12:00', N'Ковтун', 7;
EXEC sp_SelectScheduleForGroup N'VPD_311';
--EXEC sp_SelectDisciplineForGroup N'VPD_311', N'Объектно%';