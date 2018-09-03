use Game4FarmVill3
GO
/*
delete from tFVGiftList where gameid in ('xxxx2')
exec spu_FVCashCostDaily 'xxxx2', '1일째', 3015, 100
exec spu_FVCashCostDaily 'xxxx2', '2일째', 3015, 100


*/
IF OBJECT_ID ( 'dbo.spu_FVCashCostDaily', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashCostDaily;
GO

create procedure dbo.spu_FVCashCostDaily
	@gameid_								varchar(60),		-- 게임아이디
	@cashsender_							varchar(60),
	@cashreward_							int,
	@cashcnt_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @cashsender_ cashsender_

	exec spu_FVSubGiftSend 2, @cashreward_, @cashcnt_, @cashsender_, @gameid_, ''

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


