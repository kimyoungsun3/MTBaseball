/*
-- 친구상태를 세팅
-- update dbo.tSystemInfo set rtnflag = 1
update dbo.tUserMaster set condate = getdate(),      rtndate = getdate()     where gameid = 'xxxx3'	-- 활동중.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate()     where gameid = 'xxxx4'	-- 이미요청.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate() - 2 where gameid = 'xxxx5'	-- 장기 > 만기.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate() - 2 where gameid = 'xxxx6'	-- 장기 > 스스로.
exec spu_subFriendList 'xxxx2'

exec spu_subFriendList 'xxxx2'
exec spu_subFriendList 'zzzz26'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_subFriendList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_subFriendList;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_subFriendList
	@gameid_								varchar(20)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 정의값
	------------------------------------------------
	-- 복귀유저 정보.
	declare @MODE_RETURN_STATE_NON				int					set @MODE_RETURN_STATE_NON			= 0 	-- 활동.
	declare @MODE_RETURN_STATE_SENDED			int					set @MODE_RETURN_STATE_SENDED		= 1 	-- 이미요청.
	declare @MODE_RETURN_STATE_LONG				int					set @MODE_RETURN_STATE_LONG			= 2 	-- 장기미접속.

	-- 장기복귀기한.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY				= 30 	-- 몇일간 기한인가?.
	declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= 0 	-- On(1), Off(0)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	-- On(1), Off(0)

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @senddate2		datetime				set @senddate2		= getdate() - 1
	declare @rtnflag		int						set @rtnflag 		= @RETURN_FLAG_OFF

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	--declare @gameid_ varchar(20) set @gameid_ = 'xxxx2'
	DECLARE @tTempTableList TABLE(
		friendid		varchar(20),
		itemcode		int,
		acc1			int,
		acc2			int,
		state			int,
		senddate		datetime,
		ordering		int,
		famelv			int,
		kakaotalkid		varchar(60),
		kakaouserid		varchar(60),
		kakaonickname	varchar(40),
		kakaoprofile	varchar(512),
		kakaomsgblocked	int,
		kakaofriendkind	int,
		helpdate		datetime,
		rentdate		datetime,
		rtnstate		int,
		rtndate			datetime
	);

	----------------------------------------
	-- 서버상태.
	----------------------------------------
	select top 1 @rtnflag = rtnflag from dbo.tSystemInfo order by idx desc

	-- 친구상태, 좋은 동물.
	insert into @tTempTableList
	select
		m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, state, senddate,
		case when senddate <= @senddate2 then 1 else 0 end, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, kakaofriendkind, helpdate, rentdate,
		case
			when condate > getdate() - @RETURN_LIMIT_DAY 	then @MODE_RETURN_STATE_NON
			when rtndate > getdate() - 1 					then @MODE_RETURN_STATE_SENDED
			else 												 @MODE_RETURN_STATE_LONG
		end, rtndate
			from
				(select gameid, anireplistidx, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, condate, rtndate  from dbo.tUserMaster where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_)) as m
	LEFT JOIN
		(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_)) as i
	ON
		m.gameid = i.gameid and m.anireplistidx = i.listidx
	JOIN
		(select friendid, state, senddate, kakaofriendkind, helpdate, rentdate from dbo.tUserFriend where gameid = @gameid_) as f
	ON
		m.gameid = f.friendid
	order by senddate asc, state desc, itemcode desc

	-- 플레그를 꺼버리면
	if(@rtnflag != @RETURN_FLAG_ON)
		begin
			update @tTempTableList set rtnstate = @MODE_RETURN_STATE_NON
		end

	-- 친구 리스트를 갱신
	select * from @tTempTableList order by ordering desc


	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

