/*
-----------------------------------------------------
select * from dbo.fnu_GetSingleGameResult( 0, -1, 0)	-- 아무것도 선택안함.
select * from dbo.fnu_GetSingleGameResult( 1, -1, 0)

select * from dbo.fnu_GetSingleGameResult( 0, 0, 100)
select * from dbo.fnu_GetSingleGameResult( 1, 0, 100)	--> 100

select * from dbo.fnu_GetSingleGameResult( 0, 1, 100)
select * from dbo.fnu_GetSingleGameResult( 1, 1, 100)	--> 100

-----------------------------------------------------
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetSingleGameResult', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetSingleGameResult;
GO

CREATE FUNCTION dbo.fnu_GetSingleGameResult(
	@ltselect_ 		int,
	@select_ 		int,
	@cnt_ 			int
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			rselect		int,
			rcnt		int
		)
AS
BEGIN
	-- 플레그정보.
	declare @RESULT_SELECT_NON					int					set @RESULT_SELECT_NON				= -1
	declare @RESULT_SELECT_LOSE					int					set @RESULT_SELECT_LOSE				=  0
	declare @RESULT_SELECT_WIN					int					set @RESULT_SELECT_WIN				=  1

	if( @select_ = @RESULT_SELECT_NON )
		begin
			insert @SPLIT_TABLE_TEMP (rselect,            rcnt)
			values (                  @RESULT_SELECT_NON, 0)
		end
	else if( @select_ = @ltselect_ )
		begin
			insert @SPLIT_TABLE_TEMP (rselect,            rcnt)
			values (                  @RESULT_SELECT_WIN, @cnt_)
		end
	else
		begin
			insert @SPLIT_TABLE_TEMP (rselect,            rcnt)
			values (                  @RESULT_SELECT_LOSE, 0)
		end
	RETURN
END