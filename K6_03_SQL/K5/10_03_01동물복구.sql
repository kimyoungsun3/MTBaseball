/*
-- delete from dbo.tUserItem where gameid = 'xxxx5' and invenkind = 1
exec spu_AniRestore 'xxxx5', '049000s1i0n7t8445289', -1		-- �����ϱ�.
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniRestore', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniRestore;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniRestore
	@gameid_								varchar(20),
	@password_								varchar(20),
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
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- ������ ����ִ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ��Ȱ�� �ڵ��ȣ.
	declare @ITEM_RESTORE_ANIMAL				int				set @ITEM_RESTORE_ANIMAL					= 22

	-- ���� or ��Ȱ���.
	declare @USERITEM_MODE_DIE_INIT				int				set @USERITEM_MODE_DIE_INIT					= -1-- �ʱ����.

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 			set @USERITEM_INVENKIND_ANI					= 1

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int				set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--���ẹ��.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @famelv				int				set @famelv			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0

	declare @anicnt				int				set	@anicnt			= 0
	declare @fieldidx			int
	declare @listidx			int				set @listidx		= -444
	declare @listidxstart		int
	declare @loop				int				set @loop			= 5
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����ĳ��
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@famelv			= famelv
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @famelv famelv

	-- ���� ��������.
	select
		@anicnt = count(*)
	from dbo.tUserItem
	where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and diemode = @USERITEM_MODE_DIE_INIT
	--select 'DEBUG ���� ��������', @anicnt anicnt

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@anicnt != 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_IS_ALIVE
			set @comment 	= '������ ����ִ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� �մϴ�.'
			--select 'DEBUG ' + @comment

			select @listidx = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			set @loop = case
							when @famelv < 3 	then 5
							when @famelv < 6 	then 6
							when @famelv < 9 	then 7
							when @famelv < 12 	then 8
							else					   9
						end
			set @fieldidx		= 0
			set @listidxstart 	= @listidx
			----select 'DEBUG 4-1 �κ� ����ȣ', @loop loop, @listidx listidx
			while(@loop > 0)
				begin
					insert into dbo.tUserItem(gameid,   listidx,   itemcode,           cnt, farmnum,  fieldidx,  invenkind,              randserial, upstepmax, gethow)		-- ����.
					values(					 @gameid_, @listidx, @ITEM_RESTORE_ANIMAL,   1,       0, @fieldidx, @USERITEM_INVENKIND_ANI,          0,         0, @DEFINE_HOW_GET_FREEANIRESTORE)

					set @listidx	= @listidx + 1
					set @fieldidx 	= @fieldidx + 1
					set @loop 		= @loop - 1
				end
		END


	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ����(����)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx >= @listidxstart
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



