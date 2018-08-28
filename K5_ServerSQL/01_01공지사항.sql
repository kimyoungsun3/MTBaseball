/*
-- 공지사항
exec spu_Notice 1, 0, -1
exec spu_Notice 5, 0, -1
exec spu_Notice 6, 0, -1
exec spu_Notice 7, 0, -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_Notice', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Notice;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Notice
	@market_								int,
	@buytype_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 디파인값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	-- 일반변수
	declare @rand 								int


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS
	select @nResult_ rtn, '공지사항'

	------------------------------------------------
	--	3-2. 공지사항 체크
	------------------------------------------------
	select 
		top 1 *, convert(varchar(19), getdate(), 20) as currentDate
	from dbo.tNotice
	where market = @market_ and buytype = @buytype_
	order by idx desc

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



