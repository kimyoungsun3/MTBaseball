﻿-----------------------------------------------------------------------
-- exec sup_FVsubDelFriend 'xxxx2'
-----------------------------------------------------------------------
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.sup_FVsubDelFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.sup_FVsubDelFriend;
GO

create procedure dbo.sup_FVsubDelFriend
	@gameid_				varchar(60)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @sysfriendid	varchar(60)		set @sysfriendid 	= 'farmgirl'
	declare @gameid			varchar(60)		set @gameid			= ''
	declare @friendid		varchar(60)		set @friendid		= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	-- 1. 커서 생성
	declare curUserFriend Cursor for
	select gameid, friendid FROM dbo.tFVUserFriend where gameid = @gameid_

	-- 2. 커서오픈
	open curUserFriend

	-- 3. 커서 사용
	Fetch next from curUserFriend into @gameid, @friendid
	while @@Fetch_status = 0
		Begin
			delete from dbo.tFVUserFriend where gameid = @friendid and friendid = @gameid
			Fetch next from curUserFriend into @gameid, @friendid
		end

	delete from dbo.tFVUserFriend where gameid = @gameid and friendid != @sysfriendid

	-- 4. 커서닫기
	close curUserFriend
	Deallocate curUserFriend

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


