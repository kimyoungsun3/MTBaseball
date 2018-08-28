/*
exec spu_FVsubFriendRank 'xxxx2', 1
exec spu_FVsubFriendRank 'xxxx2', 0
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
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVsubFriendRank
	@gameid_								varchar(60),
	@mode_									int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- ģ�����°�.
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : ��ȣģ��

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- ����ģ��
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- īī��ģ��
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @sysfriendid	varchar(60)		set @sysfriendid 	= 'farmgirl'
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	--declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
	DECLARE @tTempTableList TABLE(
		friendid		varchar(20),
		itemcode		int,
		acc1			int,
		acc2			int,
		ttsalecoin		int,
		famelv			int,

		kakaotalkid		varchar(20),
		kakaouserid		varchar(20),
		kakaonickname	varchar(40),
		kakaoprofile	varchar(512),
		kakaomsgblocked	int,
		kakaofriendkind	int,
		helpdate		datetime
	);

	if(@mode_ = 1)
		begin
			-- ģ�� ����Ʈ�� ��ŷ

			DECLARE @tTempFriendList TABLE(
				friendid		varchar(20),
				kakaofriendkind	int,
				helpdate		datetime
			);

			---------------------------------
			-- ģ�� ����Ʈ + �ڱ� �Է�.
			---------------------------------
			insert into @tTempFriendList
			select friendid, kakaofriendkind, helpdate from dbo.tFVUserFriend where gameid = @gameid_ and friendid != @sysfriendid and state = @USERFRIEND_STATE_FRIEND

			insert into @tTempFriendList(friendid, kakaofriendkind) values(@gameid_, @KAKAO_FRIEND_KIND_KAKAO)
			--select 'DEBUG ', * from @tTempFriendList

			---------------------------------
			-- ģ����� ��ŷ��.
			---------------------------------
			insert into @tTempTableList
			select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, ttsalecoin, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, kakaofriendkind, isnull(helpdate, getdate()) from
				(select gameid, anireplistidx, ttsalecoin, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked from dbo.tFVUserMaster where gameid in (select friendid from @tTempFriendList)) as m
			LEFT JOIN
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from @tTempFriendList)) as i
			ON
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			JOIN
				(select friendid, kakaofriendkind, helpdate from @tTempFriendList) as f
			ON
				m.gameid = f.friendid

			-- ģ�� ����Ʈ�� ����
			select rank() over(order by ttsalecoin desc) as rank, * from @tTempTableList order by ttsalecoin desc

			------------------------------------------------
			--	4-2. ��������
			------------------------------------------------
		end
	else
		begin
			-- ģ�� ����Ʈ�� ��ŷ
			select rank() over(order by ttsalecoin desc) as rank, * from @tTempTableList order by ttsalecoin desc

		end

	set nocount off
End

