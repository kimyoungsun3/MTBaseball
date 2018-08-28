-----------------------------------------------------------------------
-- exec spu_SchoolScheduleGiftSendNew2 'xxxx2', 1, 1, -1, -1, '메세지'
-- select * from dbo.tSchoolUser where gameid = 'xxxx2'
-----------------------------------------------------------------------
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SchoolScheduleGiftSendNew2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SchoolScheduleGiftSendNew2;
GO

create procedure dbo.spu_SchoolScheduleGiftSendNew2
	@gameid_								varchar(20),
	@backuserrank_							int,
	@backitemcode1_							int,
	@backitemcode2_							int,
	@backitemcode3_							int,
	@message_								varchar(256)
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

	update dbo.tSchoolUser
		set
			backuserrank 	= @backuserrank_,
			backitemcode1	= @backitemcode1_,
			backitemcode2	= @backitemcode2_,
			backitemcode3	= @backitemcode3_
	where gameid = @gameid_

	if(@backitemcode1_ != -1)
		begin
			exec spu_SubGiftSendNew 2, @backitemcode1_, 0, 'SysRank', @gameid_, @message_
		end

	if(@backitemcode2_ != -1)
		begin
			exec spu_SubGiftSendNew 2, @backitemcode2_, 0, 'SysRank', @gameid_, @message_
		end

	if(@backitemcode3_ != -1)
		begin
			exec spu_SubGiftSendNew 2, @backitemcode3_, 0, 'SysRank', @gameid_, @message_
		end

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


