USE master;
GO

CREATE DATABASE ACADEMY
ON
(
	NAME		= ACADEMY,
	FILENAME	= 'D:\MS SQL Server\MSSQL16.TEW_SQLEXPRESS\MSSQL\DATA\ACADEMY.mdf',
	SIZE		= 8MB,
	MAXSIZE		= 500MB,
	FILEGROWTH	= 8MB
)

LOG ON
(
	NAME		= ACADEMY_LOG,
	FILENAME	= 'D:\MS SQL Server\MSSQL16.TEW_SQLEXPRESS\MSSQL\DATA\ACADEMY.ldf',
	SIZE		= 8MB,
	MAXSIZE		= 500MB,
	FILEGROWTH	= 8MB
)
GO

USE ACADEMY;
GO

CREATE TABLE Directions
(
	direction_id	TINYINT			PRIMARY KEY,
	direction_name	NVARCHAR(150)	NOT NULL
);



CREATE TABLE Groups
(
	group_id	INT				PRIMARY KEY,
	group_name	NVARCHAR(24)	NOT NULL,
	direction	TINYINT			NOT NULL,
	CONSTRAINT FK_Groups_Directions FOREIGN KEY(direction) REFERENCES Directions(direction_id)
);



CREATE TABLE Disciplines
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(150)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);



CREATE TABLE RequiredDisciplines
(
	discipline				SMALLINT,
	required_discipline		SMALLINT,
	PRIMARY KEY (discipline, required_discipline),
	CONSTRAINT FK_RD_Discipline_to_Discipline	FOREIGN KEY(discipline)				REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_RD_Required_to_Discipline		FOREIGN KEY(required_discipline)	REFERENCES Disciplines(discipline_id)
);



CREATE TABLE DisciplinesDirectionRalation
(
	discipline		SMALLINT,
	direction		TINYINT,
	PRIMARY KEY (discipline, direction),
	CONSTRAINT FK_DDR_Discipline		FOREIGN KEY(discipline)		REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DDR_Directions		FOREIGN KEY(direction)		REFERENCES Directions(direction_id)
);



CREATE TABLE Teachers
(
	teacher_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(50)	NOT NULL,
	first_name		NVARCHAR(50)	NOT NULL,
	middle_name		NVARCHAR(50)	NULL,
	birth_date		DATE			NOT NULL,
	work_since		DATE			NOT NULL
);



CREATE TABLE ReachersDisciplinesRelation
(
	teacher		INT,
	discipline	SMALLINT,
	PRIMARY KEY (teacher, discipline),
	CONSTRAINT FK_TDR_Teachers		FOREIGN KEY(teacher)	REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_TDR_Disciplines	FOREIGN KEY(discipline)	REFERENCES Disciplines(discipline_id)
);



CREATE TABLE Students
(
	student_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(50)	NOT NULL,
	first_name		NVARCHAR(50)	NOT NULL,
	middle_name		NVARCHAR(50)	NULL,
	birth_date		DATE			NOT NULL,
	[group]			INT				NULL,
	CONSTRAINT FK_Students_Groups FOREIGN KEY([group]) REFERENCES Groups(group_id)
);



CREATE TABLE Schedule
(
	lesson_id	BIGINT		PRIMARY KEY,
	[date]		DATE		NOT NULL,
	[time]		TIME		NOT NULL,
	[group]		INT			NOT NULL	CONSTRAINT	 FK_Schedule_Groups			FOREIGN KEY	REFERENCES Groups(group_id),
	discipline	SMALLINT	NOT NULL	CONSTRAINT	 FK_Schedule_Disciplines	FOREIGN KEY	REFERENCES Disciplines(discipline_id),
	teacher		INT			NOT NULL	CONSTRAINT	 FK_Schedule_Teachers		FOREIGN KEY	REFERENCES Teachers(teacher_id),
	spent		BIT			NOT NULL
);



CREATE TABLE Grades		-- Оценки
(
	PRIMARY KEY (student, lesson), -- Составной первичный ключ
	student		INT			CONSTRAINT FK_Grades_Students	FOREIGN KEY 	REFERENCES Students(student_id),
	lesson		BIGINT		CONSTRAINT FK_Grades_Schedule	FOREIGN KEY 	REFERENCES Schedule(lesson_id),
	present		BIT			NOT NULL,
	grade_1		TINYINT		CONSTRAINT CK_Grades_1	CHECK (grade_1 > 0 AND grade_1 <= 12),
	grade_2		TINYINT		CONSTRAINT CK_Grades_2	CHECK (grade_2 > 0 AND grade_2 <= 12)
);



CREATE TABLE Exams
(
	PRIMARY KEY (student, discipline), -- Составной первичный ключ
	student			INT			CONSTRAINT FK_Exams_Students		FOREIGN KEY 	REFERENCES Students(student_id),
	discipline		SMALLINT	CONSTRAINT FK_Exams_Disciplines		FOREIGN KEY 	REFERENCES Disciplines(discipline_id),
	grade			TINYINT		CONSTRAINT CK_Exams	CHECK (grade > 0 AND grade <= 12),
);