
-- 퀘스트 단계정 입력
--exec spu_ComRewardTest 'guest265', '7808543s0s8r0k746614', 90108, '',  0, -1
--exec spu_ComRewardTest 'guest266', '5165561g2e5h7y774758', 90108, '',  0, -1
-- update dbo.tUserMaster set market = 1 where gameid = 'xxxx2'
-- update dbo.tUserMaster set market = 5 where gameid = 'xxxx2'
-- update dbo.tUserMaster set market = 6 where gameid = 'xxxx2'
-- update dbo.tUserMaster set market = 7 where gameid = 'xxxx2'

declare @comreward	int			set @comreward	= 90648
declare @gameid		varchar(20)	set @gameid		= 'xxxx2'
declare @password	varchar(20)	set @password	= '049000s1i0n7t8445289'
declare @nextcomreward			int					set @nextcomreward		= -1
declare @nextinitpart1			int					set @nextinitpart1		= 0
declare @nextinitpart2			int					set @nextinitpart2		= 0
declare @loop					int					set @loop				= 100

delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tComReward where gameid = @gameid
-- select count(*) from dbo.tItemInfo where category = 901
update dbo.tUserMaster set comreward = @comreward where gameid = @gameid
select @comreward = comreward  from dbo.tUserMaster where gameid = @gameid
exec spu_FarmD 19, 95, @comreward, -1, -1, -1, -1, -1, -1, -1, @gameid, '', '', '', '', '', '', '', '', ''


DECLARE @tItemExpire TABLE(
	comreward		int,	initpart1		int, initpart2		int,
	gameid			varchar(60),
	cashcost		int,	gamecost		int, heart			int, feed			int,
	fpoint			int,	bktwolfkillcnt	int, bktsalecoin	int,
	bkheart			int,	bkfeed			int, bktsuccesscnt	int, bktbestfresh	int,
	bktbestbarrel	int, 	bktbestcoin		int, bkbarrel		int, bkcrossnormal	int, bkcrosspremium	int,
	bktsgrade1cnt	int,	bktsgrade2cnt	int, bktsupcnt		int, bkbattlecnt	int, bkaniupcnt	int
);

while(@comreward != -1)
	begin
		-- 1. 초기화.
		update dbo.tUserMaster
			set
				cashcost = 0, gamecost = 0, heart = 0,
				bktwolfkillcnt	= 1,	bktsalecoin		= 2,	bkheart			= 3,	bkfeed			= 4,	bktsuccesscnt	= 5,	bktbestfresh	= 6,
				bktbestbarrel	= 7,	bktbestcoin		= 8,	bkbarrel		= 9,	bkcrossnormal	= 10,	bkcrosspremium	= 11,
				bktsgrade1cnt	= 12,	bktsgrade2cnt	= 13,	bktsupcnt		= 14,	bkbattlecnt		= 15,	bkaniupcnt		= 16,
				bkapartani		= 17, 	bkapartts		= 18, 	bkcomposecnt	= 19
		where gameid = @gameid

		-- 2. 퀘보상.
		exec spu_ComRewardTest @gameid, @password, @comreward, '',  0, -1

		-- 3. 현재퀘 상태정보.
		select -- @nextcomreward = param8,
				@nextinitpart1 = param9, @nextinitpart2	= param10 from dbo.tItemInfo
		where itemcode = @comreward
		select @nextcomreward = comreward from dbo.tUserMaster where gameid = @gameid

		insert into @tItemExpire
		select
			@comreward comreward, @nextinitpart1 initpart1, @nextinitpart2 initpart2,
			gameid, cashcost, gamecost, heart, feed, fpoint,
			bktwolfkillcnt, bktsalecoin, bkheart, bkfeed, bktsuccesscnt, bktbestfresh,
			bktbestbarrel, bktbestcoin, bkbarrel, bkcrossnormal, bkcrosspremium,
			bktsgrade1cnt,	bktsgrade2cnt, bktsupcnt, bkbattlecnt, bkaniupcnt
		from dbo.tUserMaster
		where gameid = @gameid

		set @comreward	= @nextcomreward
		set @loop = @loop - 1
		if(@loop < 0)break;
	end

select * from @tItemExpire order by comreward asc
