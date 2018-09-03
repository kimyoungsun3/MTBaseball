/*
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 1, 80010,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2, 80012,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 3, 80013,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 4, 80014,  -1,  -1,  -1,  -1
*/
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulAdLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulAdLog;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRoulAdLog
	@gameid_								varchar(60),
	@nickname_								varchar(40),
	@mode_									int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@itemcode5_								int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--
	------------------------------------------------
	declare @IDX_MAX				int 			set @IDX_MAX		= 100

	-- �̱� ���.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- �Ϲݻ̱�.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- �����̱�.
	declare @MODE_ROULETTE_GRADE3				int					set @MODE_ROULETTE_GRADE3					= 3		--
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	--
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- �����̱�(����).
	declare @MODE_ROULETTE_GRADE3_FREE			int					set @MODE_ROULETTE_GRADE3_FREE				= 13	--
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	--

	------------------------------------------------
	--
	------------------------------------------------
	declare @itemcode				int
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @itemlist				varchar(128)
	declare @cnt					int
	declare @mod					int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	-- 1. Ŀ�� ����
	set @itemlist = ltrim(rtrim(str(@itemcode1_))) + ','
					+ ltrim(rtrim(str(@itemcode2_))) + ','
					+ ltrim(rtrim(str(@itemcode3_))) + ','
					+ ltrim(rtrim(str(@itemcode4_))) + ','
					+ ltrim(rtrim(str(@itemcode5_)))

	--select 'DEBUG ', @itemlist itemlist

	declare curTemp Cursor for
	select idx, listidx FROM dbo.fnu_SplitOne(',', @itemlist)

	-- 2. Ŀ������
	open curTemp

	-- 3. Ŀ�� ���
	Fetch next from curTemp into @idx, @itemcode
	while @@Fetch_status = 0
		Begin
			--select 'DEBUG ', @idx idx, @itemcode itemcode

			set @mod = @itemcode % 5
			if(@mod in (2, 3, 4))
				begin
					----select 'DEBUG > �����ϱ�', @idx, @itemcode

					----------------------------------------
					-- ������ �̸��� �˻� > �Է�.
					----------------------------------------
					select @itemname = itemname from dbo.tFVItemInfo where itemcode = @itemcode

					insert into dbo.tFVUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
					values(                      @gameid_, @nickname_, @itemcode, @mode_, '['+ @itemname +']�� �����̾� �̱�� ������ϴ�.')


					set @cnt = @cnt + 1
				end
			Fetch next from curTemp into @idx, @itemcode
		end

	-- 4. Ŀ���ݱ�
	close curTemp
	Deallocate curTemp

	-- �������� �̻��� ������Ŵ
	select @idx = max(idx) from dbo.tFVUserAdLog
	delete from dbo.tFVUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End