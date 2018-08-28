/*
update dbo.tFVUserMaster set salemoney = 12345678901230 where gameid = 'xxxx'
update dbo.tFVUserMaster set salemoney = 12345678901232 where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set salemoney = 12345678901233 where gameid = 'xxxx3'

exec spu_FVsubFriendRank 'xxxx@gmail.com', 1		-- 랭킹
exec spu_FVsubFriendRank 'xxxx@gmail.com', 0		-- Empty
exec spu_FVsubFriendRank 'xxxx3', 1
exec spu_FVsubFriendRank 'guest90904', 1

exec spu_FVsubFriendRank 'farm1613', 1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVsubFriendRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVsubFriendRank;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVsubFriendRank
	@gameid_								varchar(60),
	@mode_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- 친구상태값.
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : 상호친구

	declare @KAKAO_FRIEND_KIND_MY				int					set @KAKAO_FRIEND_KIND_MY						= 0 		-- 나자신.
	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- 게임친구
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- 카카오친구

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
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	--declare @gameid_ varchar(60) set @gameid_ = 'xxxx@gmail.com'
	DECLARE @tTempTableList TABLE(
		bestani			int,
		salemoney		bigint,
		friendid		varchar(60),

		kakaotalkid		varchar(20),
		kakaouserid		varchar(20),
		kakaomsgblocked	int,
		kakaofriendkind	int,
		helpdate		datetime,
		senddate		datetime,
		rentdate		datetime,
		rtnstate		int,
		rtndate			datetime
	);

	if(@mode_ = 1)
		begin
			-- 친구 리스트를 랭킹

			DECLARE @tTempFriendList TABLE(
				friendid		varchar(60),
				kakaofriendkind	int,
				helpdate		datetime,
				senddate		datetime		default(getdate()),
				rentdate		datetime		default(getdate() - 1)
			);

			---------------------------------
			-- 친구 리스트 + 자기 입력.
			---------------------------------
			insert into @tTempFriendList
			select friendid, kakaofriendkind, helpdate, senddate, rentdate from dbo.tFVUserFriend where gameid = @gameid_ and state = @USERFRIEND_STATE_FRIEND

			insert into @tTempFriendList(friendid, kakaofriendkind) values(@gameid_, @KAKAO_FRIEND_KIND_MY)
			--select 'DEBUG ', * from @tTempFriendList

			---------------------------------
			-- 친구들과 랭킹비교.
			---------------------------------
			insert into @tTempTableList
			select isnull(bestani, 500) bestani, salemoney, m.gameid friendid, kakaotalkid, kakaouserid, kakaomsgblocked, kakaofriendkind, isnull(helpdate, getdate()), isnull(senddate, getdate()), isnull(rentdate, getdate()),
				case
					when condate > getdate() - @RETURN_LIMIT_DAY 	then @MODE_RETURN_STATE_NON
					when rtndate > getdate() - 1 					then @MODE_RETURN_STATE_SENDED
					else 												 @MODE_RETURN_STATE_LONG
				end, rtndate from
				(select gameid, bestani, salemoney, kakaotalkid, kakaouserid, kakaomsgblocked, condate, rtndate from dbo.tFVUserMaster where gameid in (select friendid from @tTempFriendList) and kakaostatus = 1) as m
			JOIN
				(select friendid, kakaofriendkind, helpdate, senddate, rentdate from @tTempFriendList) as f
			ON
				m.gameid = f.friendid

			-- 친구 리스트를 갱신
			select rank() over(order by salemoney desc) as rank, * from @tTempTableList order by salemoney desc

			------------------------------------------------
			--	4-2. 유저정보
			------------------------------------------------
		end
	else
		begin
			-- 친구 리스트를 빈랭킹
			select rank() over(order by salemoney desc) as rank, * from @tTempTableList order by salemoney desc
		end

	set nocount off
End

