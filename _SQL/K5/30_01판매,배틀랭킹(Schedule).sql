/*
--------------------------------------------
-- K5_��ŷ����
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1���� ������ ����� �����Ѵ�.
-- ���� ����� ���� 23�� 59�� 59�ʿ� ����
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
-- 1. ���� ���� ��ŷ
--------------------------------------------------------
--select 'DEBUG ', @dateid dateid
-- 1. ��ŷ�� ���� �Ǿ��°�?
if( exists( select top 1 * from dbo.tUserRankMaster where dateid = @dateid ) )
	begin
		set @dateid = @dateid
		--select 'DEBUG ���� ���� ��ŷ ���� �̹���'
	end
else
	begin
		--select 'DEBUG ���� ���� ��ŷ ���� �ϱ�', @dateid dateid
		-- ��ŷ����Ÿ ���
		insert into dbo.tUserRankSub(                           rank,  dateid8, gameid, ttsalecoin, anirepitemcode, kakaonickname)
		select top 1000 rank() over(order by ttsalecoin desc) as rank, @dateid,  gameid, ttsalecoin, anirepitemcode, kakaonickname from dbo.tUserMaster where ttsalecoin > 0 --and deletestate = 0

		-- 1. ��ŷ Ŀ���� �о����.
		declare curUserRanking Cursor for
		select top 1000 rank, gameid from dbo.tUserRankSub where dateid8 = @dateid order by rank asc
		--select 'DEBUG ', rank, gameid from dbo.tUserRankSub where dateid8 = @dateid

		-- 2. Ŀ������
		open curUserRanking

		-- 3. Ŀ�� ���
		Fetch next from curUserRanking into @rank, @gameid
		while @@Fetch_status = 0
			Begin
				----------------------------
				--	< ��ü��ŷ >
				--				���(5000)	�ϲ�(1002)	�ռ�������(3500)	�±��ǲ�(3600)	�ڽ�
				--1				3000		100			2000				2000			���۸���(3705)
				--2				1000		60			1000				1000			���̾�Ʈ(3703)
				--3				800			40			800					800				����(3704)
				--4 ~ 10		500			30			500					500				���(3702)
				--11 ~ 50		100			20			200					200				���(3702)
				--51 ~ 100		50			10			150					150				���(3702)
				--101 ~ 500		30			8			50					50
				--501 ~ 1000	10			6			20					20
				----------------------------

				set @sendid = '���ⷩŷ' + ltrim(rtrim(@rank))
				--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid


				if( @rank <= 1 )
					begin
						--select 'DEBUG > 1������'
						exec spu_SubGiftSendNew 2,  5000, 3000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 100, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 2000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 2000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3705, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 2 )
					begin
						--select 'DEBUG > 2������'
						exec spu_SubGiftSendNew 2,  5000, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 60, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 1000, @sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3703, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 3 )
					begin
						--select 'DEBUG > 3������'
						exec spu_SubGiftSendNew 2,  5000, 800,	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 40, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 800, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 800, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3704, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 10 )
					begin
						--select 'DEBUG > ~ 10������'
						exec spu_SubGiftSendNew 2,  5000, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 30, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 500, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 50 )
					begin
						--select 'DEBUG > ~ 50������'
						exec spu_SubGiftSendNew 2,  5000, 100, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 20, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 200, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 200, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 100 )
					begin
						--select 'DEBUG > ~ 100������'
						exec spu_SubGiftSendNew 2,  5000, 50, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 10, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 150, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 150, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3702, 1, 	@sendid, @gameid, ''
					end
				else if( @rank <= 500 )
					begin
						--select 'DEBUG > ~ 500������'
						exec spu_SubGiftSendNew 2,  5000, 30, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 8, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 50, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 50, 	@sendid, @gameid, ''
					end
				else if( @rank <= 1000 )
					begin
						select 'DEBUG > ~ 1000������'
						exec spu_SubGiftSendNew 2,  5000, 10, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  1002, 6, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3500, 20, 	@sendid, @gameid, ''
						exec spu_SubGiftSendNew 2,  3600, 20, 	@sendid, @gameid, ''
					end

				Fetch next from curUserRanking into @rank, @gameid
			end

		-- 4. Ŀ���ݱ�
		close curUserRanking
		Deallocate curUserRanking

		insert into dbo.tUserRankMaster( dateid )
		values(                         @dateid )
	end

--------------------------------------------------------
-- 2. ���� ��Ʋ ��ŷ
--------------------------------------------------------
if( exists( select top 1 * from dbo.tUserBattleRankMaster where dateid = @dateid ) )
	begin
		set @dateid = @dateid
		--select 'DEBUG ���� ��Ʋ ��ŷ ���� �̹���'
	end
else
	begin
		--select 'DEBUG ���� ��Ʋ ��ŷ ���� �ϱ�', @dateid dateid
		-- ��ŷ����Ÿ ���
		-- > ������ ����Ÿ�� ���� ���͸� �ɾ���ϴµ� ���⼭ �ɷ��������ؼ� ������ �Ⱦ�
		--  (and deletestate = 0)
		insert into dbo.tUserBattleRankSub(                  rank,  dateid8, gameid, trophy, tier, anirepitemcode, kakaonickname)
		select top 1000 rank() over(order by trophy desc) as rank, @dateid,  gameid, trophy, tier, anirepitemcode, kakaonickname from dbo.tUserMaster where trophy > 0

		insert into dbo.tUserBattleRankMaster( dateid )
		values(                               @dateid )

	end

----------------------------------------
--	3. ���� ���ⷩŷ ����Ÿ Ŭ����.
----------------------------------------
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG ���� ���� Ŭ����', @idx idx
		update dbo.tUserMaster
			set
				ttsalecoin = 0
		where ttsalecoin > 0 and idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/