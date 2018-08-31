/*
exec spu_AdminAction 'blackm', 'sangsang', '선물지급', -1
*/

IF OBJECT_ID ( 'dbo.spu_AdminAction', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_AdminAction;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AdminAction
	@adminid_								varchar(20),
	@gameid_								varchar(20),
	@comment_								varchar(1024)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	
	
Begin
	set nocount on

	insert into tMessageAdmin(adminid, gameid, comment) 
	values(@adminid_, @gameid_, @comment_)
	
	set nocount off
End

