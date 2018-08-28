/*
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	 100,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	 200,   2,7000,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 1,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �Ϲ�.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 	-- �����̾�.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 4,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �����̾�10+1.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 3,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �ռ�.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',100,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �±�.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 1000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �Ϲ�.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 	-- �����̾�.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 4000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �����̾�10+1.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 5000,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �귿.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 3500,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �귿.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 2300,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �귿.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 5100,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �귿.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 3600,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- �귿.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_RoulAdLogNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulAdLogNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_RoulAdLogNew
	@gameid_								varchar(20),
	@nickname_								varchar(40),
	@mode_									int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@itemcode5_								int,
	@itemcode6_								int,
	@itemcode7_								int,
	@itemcode8_								int,
	@itemcode9_								int,
	@itemcode10_							int,
	@itemcode11_							int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--
	------------------------------------------------
	declare @IDX_MAX							int 				set @IDX_MAX								= 100

	-- ����̱� ���.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- �Ϲݻ̱�.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- ���̱�.
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	-- ���̱� 10 + 1.
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- ���̱�			(����).
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	-- ���̱� 10 + 1	(����).
	declare @MODE_ROULETTE_GRADE1_TICKET		int					set @MODE_ROULETTE_GRADE1_TICKET			= 21	-- �Ϲݻ̱�			(Ƽ��).
	declare @MODE_ROULETTE_GRADE2_TICKET		int					set @MODE_ROULETTE_GRADE2_TICKET			= 22	-- ���̱�			(Ƽ��).
	declare @MODE_ROULETTE_GRADE4_TICKET		int					set @MODE_ROULETTE_GRADE4_TICKET			= 24	-- ���̱� 10 + 1 	(Ƽ��).

	declare @MODE_COMPOSE						int					set @MODE_COMPOSE							= 3		-- �ռ�.
	declare @MODE_PROMOTE						int					set @MODE_PROMOTE							= 100	-- �±�.
	declare @MODE_WHEEL							int					set @MODE_WHEEL								= 101

	-- �����̱� ���.
	declare @MODE_TREASURE_GRADE1				int					set @MODE_TREASURE_GRADE1					= 1 * 1000	-- �Ϲݻ̱�.
	declare @MODE_TREASURE_GRADE2				int					set @MODE_TREASURE_GRADE2					= 2 * 1000	-- ���̱�.
	declare @MODE_TREASURE_GRADE4				int					set @MODE_TREASURE_GRADE4					= 4 * 1000 	-- ���̱� 10 + 1.
	declare @MODE_TREASURE_GRADE2_FREE			int					set @MODE_TREASURE_GRADE2_FREE				= 12* 1000	-- ���̱�			(����).
	declare @MODE_TREASURE_GRADE4_FREE			int					set @MODE_TREASURE_GRADE4_FREE				= 14* 1000	-- ���̱� 10 + 1	(����).
	declare @MODE_TREASURE_GRADE1_TICKET		int					set @MODE_TREASURE_GRADE1_TICKET			= 21* 1000	-- �Ϲݻ̱�			(Ƽ��).
	declare @MODE_TREASURE_GRADE2_TICKET		int					set @MODE_TREASURE_GRADE2_TICKET			= 22* 1000	-- ���̱�			(Ƽ��).
	declare @MODE_TREASURE_GRADE4_TICKET		int					set @MODE_TREASURE_GRADE4_TICKET			= 24* 1000	-- ���̱� 10 + 1 	(Ƽ��).

	-- �귿



	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	--����(1)
	declare @ITEM_MAINCATEGORY_TREASURE			int					set @ITEM_MAINCATEGORY_TREASURE	 			= 1200	-- ����(1200)
	------------------------------------------------
	--
	------------------------------------------------
	declare @itemcode				int
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @itemlist				varchar(128)
	declare @cnt					int

	declare @category				int
	declare @grade					int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	-- 1. Ŀ�� ����
	set @itemlist =   ltrim(rtrim(str(@itemcode1_))) + ','
					+ ltrim(rtrim(str(@itemcode2_))) + ','
					+ ltrim(rtrim(str(@itemcode3_))) + ','
					+ ltrim(rtrim(str(@itemcode4_))) + ','
					+ ltrim(rtrim(str(@itemcode5_))) + ','
					+ ltrim(rtrim(str(@itemcode6_))) + ','
					+ ltrim(rtrim(str(@itemcode7_))) + ','
					+ ltrim(rtrim(str(@itemcode8_))) + ','
					+ ltrim(rtrim(str(@itemcode9_))) + ','
					+ ltrim(rtrim(str(@itemcode10_)))+ ','
					+ ltrim(rtrim(str(@itemcode11_)))

	--select 'DEBUG ', @itemlist itemlist

	declare curTemp Cursor for
	select idx, listidx FROM dbo.fnu_SplitOne(',', @itemlist)

	-- 2. Ŀ������
	open curTemp

	-- 3. Ŀ�� ���
	Fetch next from curTemp into @idx, @itemcode
	while @@Fetch_status = 0
		Begin
			--select 'DEBUG ', @idx, @itemcode
			if( @itemcode = -1 )
				begin
					set @itemcode = @itemcode
				end
			else if(    ( @itemcode >= 13     and @itemcode <= 99     )
				or ( @itemcode >= 109    and @itemcode <= 199    )
				or ( @itemcode >= 206    and @itemcode <= 299    )
				or ( @itemcode >= 120010 and @itemcode <= 120999 )
				or ( @mode_ = @MODE_WHEEL                         )
				)
				begin

					----------------------------------------
					-- ������ �̸��� �˻� > �Է�.
					-- []�� ����� �����ϼ���.~ -> NGUI UI_Lablel���� ������ ����� �ƻ��ϰ� ����.
					-- ������ : [xxxx2]���� [xxxx]�� �����̾� ����� ������ϴ�.
					-- ��  �� : {xxxx2}���� xxxx�� [ff00ff]�����̾� ����[-]�� ������ϴ�.
					----------------------------------------
					select
						@category 	= category,
						@grade 		= grade,
						@itemname 	= itemname
					from dbo.tItemInfo
					where itemcode = @itemcode
					--select 'DEBUG > �����ϱ�', @idx idx, @itemcode itemcode, @category category, @itemname itemname, @grade grade

					if(    ( @category = @ITEM_MAINCATEGORY_ANI 		and @grade < 4 )	-- ���� -> Ȳ��(4) �̸��� �н�.
						or ( @category = @ITEM_MAINCATEGORY_TREASURE 	and @grade < 5 ) )	-- ���� -> ����(5) �̸��� �н�.
						begin
							--select 'DEBUG ����� ���� �н�'
							set @cnt = @cnt
						end
					else if(@mode_ = @MODE_COMPOSE)
						begin
							--select 'DEBUG �ռ�'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�ռ�[-]���� ������ϴ�.')
						end
					else if(@mode_ = @MODE_PROMOTE)
						begin
							--select 'DEBUG �±�'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�±�[-]���� ������ϴ�.')
						end

					-- ����.
					else if(@mode_ in ( @MODE_ROULETTE_GRADE1,                             @MODE_ROULETTE_GRADE1_TICKET ))
						begin
							--select 'DEBUG �Ϲݱ���'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� ����� ������ϴ�.')
						end
					else if(@mode_ in ( @MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE2_FREE, @MODE_ROULETTE_GRADE2_TICKET ))
						begin
							--select 'DEBUG ��������'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�����̾� ����[-]�� ������ϴ�.')
						end
					else if(@mode_ in ( @MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE4_FREE, @MODE_ROULETTE_GRADE4_TICKET ))
						begin
							----select 'DEBUG �������� 10+1'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�����̾� ����10+1[-]�� ������ϴ�.')
						end

					-- ����.
					else if(@mode_ in ( @MODE_TREASURE_GRADE1,                             @MODE_TREASURE_GRADE1_TICKET ))
						begin
							----select 'DEBUG �Ϲݺ���'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� �����̱�� ������ϴ�.')
						end
					else if(@mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE, @MODE_TREASURE_GRADE2_TICKET ))
						begin
							--select 'DEBUG ��������'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�����̾� �����̱�[-]�� ������ϴ�.')
						end
					else if(@mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE, @MODE_TREASURE_GRADE4_TICKET ))
						begin
							--select 'DEBUG �������� 10+1'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]�����̾� �����̱�10+1[-]�� ������ϴ�.')
						end

					-- �귿.
					else if(@mode_ in ( @MODE_WHEEL ))
						begin
							--select 'DEBUG Ȳ�ݷ귿'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '���� {'+ @itemname +'}�� [ff00ff]Ȳ�ݷ귿[-]���� ������ϴ�.')
						end



					set @cnt = @cnt + 1
				end
			Fetch next from curTemp into @idx, @itemcode
		end

	-- 4. Ŀ���ݱ�
	close curTemp
	Deallocate curTemp

	-- �������� �̻��� ������Ŵ
	select @idx = max(idx) from dbo.tUserAdLog
	delete from dbo.tUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End