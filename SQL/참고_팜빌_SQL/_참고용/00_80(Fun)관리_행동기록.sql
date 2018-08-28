--################################################################
--	관리지행동 기록
-- exec spu_FVAdminAction 'blackm', 'sususu', '선물을 지급했다.'
-- select * from dbo.tFVMessageAdmin order by idx desc
--################################################################
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAdminAction', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAdminAction;
GO

create procedure dbo.spu_FVAdminAction
	@adminid_								varchar(60),
	@gameid_								varchar(60),
	@comment_								varchar(1024)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as

Begin
	set nocount on

	insert into dbo.tFVMessageAdmin(adminid, gameid, comment)
	values(@adminid_, @gameid_, @comment_)

	set nocount off
End