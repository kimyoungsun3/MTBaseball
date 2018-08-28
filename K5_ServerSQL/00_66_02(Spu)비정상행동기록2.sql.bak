/*
exec spu_SubUnusualRecord2  'xxxx2', '결과치트Test'
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SubUnusualRecord2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SubUnusualRecord2;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SubUnusualRecord2
	@gameid_								varchar(20),		-- 게임아이디
	@comment_								varchar(512)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @comment_ comment_

	insert into dbo.tUserUnusualLog2(gameid, comment) values(@gameid_, @comment_)

	------------------------------------------------
	set nocount off
End

