/*
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2,  -1,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2,   1,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2, 100,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2, 200,   2,7000,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2,   1,   2,   3,   4,   5

exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 1,  15,  -1,  -1,  -1,  -1	-- �Ϲ�.
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2,  15,  -1,  -1,  -1,  -1 -- �����̾�.
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 3,  15,  -1,  -1,  -1,  -1	-- �ռ�.
*/
use Farm
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

	-- ����̱� ���.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- �Ϲݱ���.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- �����̾�����.
	declare @MODE_COMPOSE						int					set @MODE_COMPOSE							= 3	-- �ռ�.

	------------------------------------------------
	--
	------------------------------------------------
	declare @itemcode				int
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @itemlist				varchar(128)
	declare @cnt					int

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
			--select 'DEBUG ', @idx, @itemcode
			--if((@itemcode >= 8 and @itemcode <= 99) or (@itemcode >= 106 and @itemcode <= 199) or (@itemcode >= 206 and @itemcode <= 299))
			--if((@itemcode >= 8 and @itemcode <= 32) or (@itemcode >= 106 and @itemcode <= 130) or (@itemcode >= 206 and @itemcode <= 230))
			if((@itemcode >= 8 and @itemcode <= 28) or (@itemcode >= 106 and @itemcode <= 126) or (@itemcode >= 206 and @itemcode <= 226))
				begin
					--select 'DEBUG > �����ϱ�', @idx, @itemcode

					----------------------------------------
					-- ������ �̸��� �˻� > �Է�.
					----------------------------------------
					select @itemname = itemname from dbo.tFVItemInfo where itemcode = @itemcode

					if(@mode_ = @MODE_COMPOSE)
						begin
							insert into dbo.tFVUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, '['+ @itemname +']�� �ռ����� ������ϴ�.')
						end
					else if(@mode_ = @MODE_ROULETTE_PREMINUM)
						begin
							insert into dbo.tFVUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, '['+ @itemname +']�� �����̾� ����� ������ϴ�.')
						end
					else
						begin
							insert into dbo.tFVUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, '['+ @itemname +']�� ����� ������ϴ�.')
						end


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