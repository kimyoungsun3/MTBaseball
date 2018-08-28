/*
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445280',  0, 600, 0, -1	-- ��������.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289', 11, 600, 0, -1	-- �̱���.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289', -1, 600, 0, -1	-- �߸��� ��������ȣ.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 444, 0, -1	-- �߸��� ��������.

exec spu_SeedPlant 'farm1078959', '2506581j3z1t4e126143',  0, 600, 1, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 600, 1, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  2, 601, 1, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  3, 602, 0, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  4, 603, 0, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  5, 604, 0, -1	-- ���� > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  6, 607, 0, -1	-- ��Ʈ > ����.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  7, 605, 0, -1	-- ȸ�� > �Ҹ�(������).
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  8, 606, 0, -1	-- ���� > �Ҹ�(������).
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SeedPlant', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SeedPlant;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SeedPlant
	@gameid_								varchar(20),
	@password_								varchar(20),
	@seedidx_								int,
	@seeditemcode_							int,
	@feeduse_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- �������� �̱��Ż���.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])

	-- ������(����).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0


	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY

	declare @seeditemcodenew	int				set @seeditemcodenew	= -444
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvesttime		int				set @harvesttime		= 99999
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG 1-0 �Է°�', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @seeditemcode_ seeditemcode_

	------------------------------------------------
	--	3-2. ��������.
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@heart			= heart,
		@qtfeeduse		= qtfeeduse
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost

	select
		@seeditemcode	= itemcode
	from dbo.tUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 ����������', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode

	---------------------------------------------
	-- ������ ����.
	---------------------------------------------
	select
		@seeditemcodenew	= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost,
		@harvestcnt			= param1,
		@harvesttime		= param2,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode_
	--select 'DEBUG 1-3 ��������', @seeditemcode_ seeditemcode_, @seeditemcodenew seeditemcodenew, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @harvestcnt harvestcnt, @harvesttime harvesttime, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode = @USERSEED_NEED_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NEED_BUY
			set @comment 	= '�������� �������� ����.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode >= 600 and @seeditemcode <=699)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�̹� ������ �ֽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcodenew = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '���� ������ ��ã�ҽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '���κ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �������� ������ �ɴ´�.'
			--select 'DEBUG ' + @comment

			-- ������ �ɱ�.
			update dbo.tUSerSeed
				set
					itemcode 		= @seeditemcode_,
					seedstartdate	= getdate(),
					seedenddate		= DATEADD(ss, @harvesttime, getdate())
			where gameid = @gameid_ and seedidx = @seedidx_

			-- �������.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- �����ʰ��.
			set @feeduse_ = case
								when @feeduse_ < 0 then (-@feeduse_)
								else @feeduse_
							end

			set @feed 		= @feed - @feeduse_
			set @qtfeeduse 	= @qtfeeduse + @feeduse_

			--set @feed = case when @feed < 0 then 0 else @feed end

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @seeditemcode_, @gamecostsell, @cashcostsell, 0
		END

	--------------------------------------------------------------
	-- ���� �ڵ� ������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-------------------------------------------------------------
			-- �Ϲݰ���� ��ܿ� ����˴ϴ�.
			-------------------------------------------------------------

			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,

				qtfeeduse		= @qtfeeduse
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ����.
			--------------------------------------------------------------
			select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_
		end
	--else
	--	begin
	--		-------------------------------------------------------------
	--		-- �Ϲݰ���� ��ܿ� ����˴ϴ�.
	--		-------------------------------------------------------------
	--	end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



