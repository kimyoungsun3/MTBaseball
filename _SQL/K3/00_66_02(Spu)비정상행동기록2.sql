/*
update dbo.tFVUserMaster set logwrite2 =  1 where gameid = 'xxxx2'
exec spu_FVSubUnusualRecord2  'xxxx2', '기록하기'
update dbo.tFVUserMaster set logwrite2 = -1 where gameid = 'xxxx2'
exec spu_FVSubUnusualRecord2  'xxxx2', '기록안함'

exec spu_FVSubUnusualRecord2  'xxxx2', '결과치트Test'
select * from dbo.tFVUserMaster where gameid = 'xxxx2'
*/
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_FVSubUnusualRecord2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSubUnusualRecord2;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSubUnusualRecord2
	@gameid_								varchar(60),		-- 게임아이디
	@comment_								varchar(512)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @logwrite2		int			set @logwrite2		= 1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @comment_ comment_
	select @logwrite2 = logwrite2 from dbo.tFVUserMaster where gameid = @gameid_

	if(@logwrite2 = 1)
		begin
			insert into dbo.tFVUserUnusualLog2(gameid, comment) values(@gameid_, @comment_)
		end

	------------------------------------------------
	set nocount off
End

