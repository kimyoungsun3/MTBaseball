--################################################################
--	관리지행동 기록
-- exec spu_AdminAction 'blackm', 'sususu', '선물을 지급했다.'
-- select * from dbo.tMessageAdmin order by idx desc
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AdminAction', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AdminAction;
GO

create procedure dbo.spu_AdminAction
	@adminid_								varchar(20),
	@gameid_								varchar(20),
	@comment_								varchar(1024)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as

Begin
	set nocount on

	insert into dbo.tMessageAdmin(adminid,   gameid,   comment)
	values(                      @adminid_, @gameid_, @comment_)

	set nocount off
End