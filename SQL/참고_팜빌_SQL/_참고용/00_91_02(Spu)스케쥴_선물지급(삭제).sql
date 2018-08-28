-----------------------------------------------------------------------
-- exec spu_FVSchoolScheduleGiftSend 'xxxx2', 1, 1, -1, -1, -1, -1, -1
-----------------------------------------------------------------------
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSchoolScheduleGiftSend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSchoolScheduleGiftSend;
GO

create procedure dbo.spu_FVSchoolScheduleGiftSend
	@gameid_								varchar(60),
	@userrank_								int,
	@itemcode_								int,
	@acc1_									int,
	@acc2_									int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	update dbo.tFVSchoolUser
		set
			userrank 	= @userrank_,
			itemcode	= @itemcode_,
			acc1		= @acc1_,
			acc2		= @acc2_,
			itemcode1 	= @itemcode1_,
			itemcode2 	= @itemcode2_,
			itemcode3 	= @itemcode3_
	where gameid = @gameid_

	if(@itemcode1_ != -1)
		begin
			exec spu_FVSubGiftSend 2, @itemcode1_, 'SysRank', @gameid_, ''
		end

	if(@itemcode2_ != -1)
		begin
			exec spu_FVSubGiftSend 2, @itemcode2_, 'SysRank', @gameid_, ''
		end
	if(@itemcode3_ != -1)
		begin
			exec spu_FVSubGiftSend 2, @itemcode3_, 'SysRank', @gameid_, ''
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


