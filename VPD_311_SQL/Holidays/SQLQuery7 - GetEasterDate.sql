USE VPD_311_Import;
SET DATEFIRST 1; -- Понедельник = 1
GO

ALTER FUNCTION GetEasterDate (@year AS SMALLINT) RETURNS DATE
BEGIN
	DECLARE @a	AS SMALLINT		=	@year % 19;
	DECLARE @b	AS SMALLINT		=	@year % 4;
	DECLARE @c	AS SMALLINT		=	@year % 7;
	DECLARE @d	AS SMALLINT		=	(19 * @a + 15) % 30;
	DECLARE @e	AS SMALLINT		=	(2 * @b + 4 * @c + 6 * @d + 6) % 7;
	DECLARE @f	AS SMALLINT		=	@d + @e;

	DECLARE @month AS TINYINT;
	
	--RETURN DATEFROMPARTS
	--	(
	--		@year,
	--		IIF(@f <= 26, 4, 5),
	--		IIF(@f <= 26, @f + 4, @f - 26)
	--	);

	RETURN IIF
	(
		@f > 26,
		DATEFROMPARTS(@year, 5, @f - 26),
		DATEFROMPARTS(@year, 4, @f + 4)
	);
END