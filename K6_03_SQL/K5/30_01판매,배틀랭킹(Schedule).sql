/*
--------------------------------------------
-- K5_랭킹보상
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 유저 정보를 1주일 단위로 백업을 진행한다.
-- 매주 토요일 시작 23시 59분 59초에 시작
---------------------------------------------
-- use GameMTBaseball
-- GO
-- delete from dbo.tUserBattleRankMaster 	delete from dbo.tUserBattleRankSub 	delete from dbo.tUserRankMaster 	delete from dbo.tUserRankSub
-- update dbo.tUserMaster set ttsalecoin = 11 where gameid = 'xxxx' update dbo.tUserMaster set ttsalecoin = 12 where gameid = 'xxxx2' update dbo.tUserMaster set ttsalecoin = 13 where gameid = 'xxxx3'
-- select ttsalecoin, kakaonickname from dbo.tUserMaster where ttsalecoin > 0
-- select * from dbo.tUserRankSub where dateid8 = '20160405'  select * from dbo.tUserBattleRankSub where dateid8 = '20160405'


declare @dateid			varchar(8),
		@idx			int,
		@gameid 		varchar(20),
		@ttsalecoin		int,
		@rank			int,
		@trophy			int,
		@tier			int,
		@sendid 		varchar(20)

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @idx 		= -1


--------------------------------------------------------
-- 1. 유저 매출 랭킹
--------------------------------------------------------
--select 'DEBUG ', @dateid dateid
-- 1. 랭킹이 산출 되었는가?
if( exists( select top 1 * from dbo.tUserRankMaster where dateid = @dateid ) )
	begin
		set @dateid = @dateid
		--select 'DEBUG 유저 매출 랭킹 산출 이미함'
	end
else
	begin
		--select 'DEBUG 유저 매출 랭킹 산출 하기', @dateid dateid
		-- 랭킹데이타 백업
		insert into dbo.tUserRankSub(                           rank,  dateid8, gameid, ttsalecoin, anirepitemcode, kakaonickname)
		select top 1000 rank() over(order by ttsalecoin desc) as rank, @dateid,  gameid, ttsalecoin, anirepitemcode, kakaonickname from dbo.tUserMaster where ttsalecoin > 0 --and deletestate = 0

		-- 1. 랭킹 커서로 읽어오기.
		declare curUserRanking Cursor for
		select top 1000 rank, gameid from dbo.tUserRankSub where dateid8 = @dateid order by rank asc
		--select 'DEBUG ', rank, gameid from dbo.tUserRankSub where dateid8 = @dateid

		-- 2. 커서오픈
		open curUserRanking

		-- 3. 커서 사용
		Fetch next from curUserRanking into @rank, @gameid
		while @@Fetch_status = 0
			Begin
				----------------------------
				--	< 전체랭킹 >
				--				루비(5000)	일꾼(1002)	합성의훈장(3500)	승급의꽃(3600)	박스
				--1				3000		100			2000				2000			슈퍼마법(3705)
				--2				1000		60			1000				1000			자이언트(3703)
				--3				800			40			800					800				마법(3704)
				--4 ~ 10		500			30			500					500				골드(3702)
				--11 ~ 50		100			20			200					200				골드(3702)
				--51 ~ 100		50			10			150					150				골드(3702)
				--101 ~ 500		30			8			50					50
				--501 ~ 1000	10			6			20					20
				----------------------------

				set @sendid = '매출랭킹' + ltrim(rtrim(@rank))
				--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid


				if( @rank <= 1 )
					begin
						--select 'DEBUG > 1위지급'
						exec spu_SubGiftSendNew 2,  5000, 3000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 100, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 2000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 2000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3705, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 2 )
					begin
						--select 'DEBUG > 2위지급'
						exec spu_SubGiftSendNew 2,  5000, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 60, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3703, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 3 )
					begin
						--select 'DEBUG > 3위지급'
						exec spu_SubGiftSendNew 2,  5000, 800,	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 40, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 800, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 800, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3704, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 10 )
					begin
						--select 'DEBUG > ~ 10위지급'
						exec spu_SubGiftSendNew 2,  5000, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 30, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 50 )
					begin
						--select 'DEBUG > ~ 50위지급'
						exec spu_SubGiftSendNew 2,  5000, 100, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 20, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 200, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 200, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 100 )
					begin
						--select 'DEBUG > ~ 100위지급'
						exec spu_SubGiftSendNew 2,  5000, 50, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 10, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 150, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 150, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 500 )
					begin
						--select 'DEBUG > ~ 500위지급'
						exec spu_SubGiftSendNew 2,  5000, 30, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 8, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 50, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 50, 	@sendid, @gameid, ''
					end
				else if( @rank <= 1000 )
					begin
						select 'DEBUG > ~ 1000위지급'
						exec spu_SubGiftSendNew 2,  5000, 10, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 6, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 20, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 20, 	@sendid, @gameid, ''
					end

				Fetch next from curUserRanking into @rank, @gameid
			end

		-- 4. 커서닫기
		close curUserRanking
		Deallocate curUserRanking

		insert into dbo.tUserRankMaster( dateid )
		values(                         @dateid )
	end

--------------------------------------------------------
-- 2. 유저 배틀 랭킹
--------------------------------------------------------
if( exists( select top 1 * from dbo.tUserBattleRankMaster where dateid = @dateid ) )
	begin
		set @dateid = @dateid
		--select 'DEBUG 유저 배틀 랭킹 산출 이미함'
	end
else
	begin
		--select 'DEBUG 유저 배틀 랭킹 산출 하기', @dateid dateid
		-- 랭킹데이타 백업
		-- > 삭제된 데이타를 원래 필터를 걸어야하는데 여기서 걸러내기위해서 억지로 안씀
		--  (and deletestate = 0)
		insert into dbo.tUserBattleRankSub(                  rank,  dateid8, gameid, trophy, tier, anirepitemcode, kakaonickname)
		select top 1000 rank() over(order by trophy desc) as rank, @dateid,  gameid, trophy, tier, anirepitemcode, kakaonickname from dbo.tUserMaster where trophy > 0

		insert into dbo.tUserBattleRankMaster( dateid )
		values(                               @dateid )

	end

----------------------------------------
--	3. 유저 매출랭킹 데이타 클리어.
----------------------------------------
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG 유저 정보 클리어', @idx idx
		update dbo.tUserMaster
			set
				ttsalecoin = 0
		where ttsalecoin > 0 and idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/