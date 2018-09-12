--################################################################
--	관리지행동 기록
-- exec spu_AdminActionBlock 'blackm', 'sususu', '선물을 지급했다.'
-- select * from dbo.tMessageAdmin order by idx desc
-- select * from dbo.tUserBlockLog order by idx desc
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AdminActionBlock', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AdminActionBlock;
GO

create procedure dbo.spu_AdminActionBlock
	@adminid_								varchar(20),
	@gameid_								varchar(20),
	@comment_								varchar(512)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as

Begin
	set nocount on

	insert into dbo.tMessageAdmin(adminid,   gameid,   comment)
	values(                      @adminid_, @gameid_, @comment_)

	insert into dbo.tUserBlockLog(gameid,   comment)
	values(                      @gameid_, @comment_)

	set nocount off
End

