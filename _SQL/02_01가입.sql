/*
-- �Ϲݰ���
exec spu_UserCreate 'xxxx',    '049000s1i0n7t8445289', '�浿1',  '19980101', '01011112221', 'xxxx@gmail.com',     '�浿1�г���', 100, -1
exec spu_UserCreate 'xxxx2',   '049000s1i0n7t8445289', '�浿2', '19980102', '01011112222', 'xxxx2@gmail.com',    '�浿2�г���', 100, -1
exec spu_UserCreate 'xxxx3',   '049000s1i0n7t8445289', '�浿3', '19980103', '01011112223', 'xxxx3@gmail.com',    '�浿3�г���', 100, -1
exec spu_UserCreate 'xxxx4',   '049000s1i0n7t8445289', '�浿4', '19980104', '01011112224', 'xxxx4@gmail.com',    '�浿4�г���', 100, -1
exec spu_UserCreate 'xxxx4',   '049000s1i0n7t8445289', '�浿5', '19980105', '01011112225', 'xxxx5@gmail.com',    '�浿5�г���', 100, -1
exec spu_UserCreate 'xxxx5',   '049000s1i0n7t8445289', '�浿6', '19980106', '01011112226', 'xxxx6@gmail.com',    '�浿6�г���', 100, -1
exec spu_UserCreate 'xxxx6',   '049000s1i0n7t8445289', '�浿7', '19980107', '01011112227', 'xxxx7@gmail.com',    '�浿7�г���', 100, -1
exec spu_UserCreate 'xxxx7',   '049000s1i0n7t8445289', '�浿8', '19980108', '01011112228', 'xxxx8@gmail.com',    '�浿8�г���', 100, -1
exec spu_UserCreate 'xxxx8',   '049000s1i0n7t8445289', '�浿9', '19980109', '01011112229', 'xxxx9@gmail.com',    '�浿9�г���', 100, -1
exec spu_UserCreate 'xxxx9',   '049000s1i0n7t8445289', '�浿1', '19980101', '01011112221', 'xxxx1@gmail.com',    '�浿1�г���', 100, -1
exec spu_UserCreate 'xxxx10',  '049000s1i0n7t8445289', '�浿10','19980109', '01011112230', 'xxxx10@gmail.com',   '�浿10�г���',100, -1

-- select * from dbo.tUserBlockLog where gameid = ''
-- select * from dbo.tUserMaster where gameid = ''
-- select * from dbo.tUserItem where gameid = ''

-- guest���� (������ 5���� �Է��ϱ� )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)
declare @phone 			varchar(20)
declare @email			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @gameid			= 'mtuser' + CONVERT(varchar(10), @var)
		set @phone			= '010' + ltrim(@var)
		set @email			= @gameid + '@gmail.com'
		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							@gameid,					-- username
							'19980109', 				-- birthday
							@phone, 					-- phone
							@email,						-- email,
							@gameid,					-- nickname
							100,						-- version
							-1
		set @var = @var + 1
	end
*/

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserCreate;
GO

create procedure dbo.spu_UserCreate
	@gameid_				varchar(20),						-- *���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@username_				varchar(60),						-- ȫ�浿
	@birthday_				varchar(8),							-- 20000801
	@phone_					varchar(60),						-- 01012345678
	@email_					varchar(60),						-- kkk@gmail.com
	@nickname_				varchar(60),						-- ȫ�浿�г���
	@version_				int,								-- Ŭ�����
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- MT �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT ���̵� ����
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- ��������.
	declare @RESULT_ERROR_PHONE_DUPLICATE		int				set @RESULT_ERROR_PHONE_DUPLICATE		= -4
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -5
	declare @RESULT_ERROR_NICKNAME_DUPLICATE	int				set @RESULT_ERROR_NICKNAME_DUPLICATE	= -6

	-- MT �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.


	------------------------------------------------
	--	2-1. ���ǵȰ�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	declare @ID_MAX								int					set	@ID_MAX							= 5 -- ������ ������ �� �ִ� ���̵𰳼�

	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- MT ������ ��з�
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- ������(1)

	-- MT ������ �Һз�
	declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- ���(1)
	declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- ����(2)
	declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- ����(3)
	declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- �尩(4)
	declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- �Ź�(5)
	declare @ITEM_SUBCATEGORY_WEAR_BAT			int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- �����(6)
	declare @ITEM_SUBCATEGORY_WEAR_BALL			int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- �����(7)
	declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- ���(8)
	declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- �ո� �ƴ�(9)
	declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD		int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- �Ȳ�ġ ��ȣ��(10)
	declare @ITEM_SUBCATEGORY_WEAR_BELT			int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- ��Ʈ(11)
	declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD		int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- ���� ��ȣ��(12)
	declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- �縻(13)

	-- ������ �⺻ listidx. (Ŭ��� ���� 1~ 13���� �����ϱ�� �����Ƿ� �������ּ���)
	declare @BASE_HELMET_LISTIDX				int 				set @BASE_HELMET_LISTIDX					= 1
	declare @BASE_SHIRT_LISTIDX					int 				set @BASE_SHIRT_LISTIDX						= 2
	declare @BASE_PANTS_LISTIDX					int 				set @BASE_PANTS_LISTIDX						= 3
	declare @BASE_GLOVES_LISTIDX				int 				set @BASE_GLOVES_LISTIDX					= 4
	declare @BASE_SHOES_LISTIDX					int 				set @BASE_SHOES_LISTIDX						= 5
	declare @BASE_BAT_LISTIDX					int 				set @BASE_BAT_LISTIDX						= 6
	declare @BASE_BALL_LISTIDX					int 				set @BASE_BALL_LISTIDX						= 7
	declare @BASE_GOGGLE_LISTIDX				int 				set @BASE_GOGGLE_LISTIDX					= 8
	declare @BASE_WRISTBAND_LISTIDX				int 				set @BASE_WRISTBAND_LISTIDX					= 9
	declare @BASE_ELBOWPAD_LISTIDX				int 				set @BASE_ELBOWPAD_LISTIDX					= 10
	declare @BASE_BELT_LISTIDX					int 				set @BASE_BELT_LISTIDX						= 11
	declare @BASE_KNEEPAD_LISTIDX				int 				set @BASE_KNEEPAD_LISTIDX					= 12
	declare @BASE_SOCKS_LISTIDX					int 				set @BASE_SOCKS_LISTIDX						= 13

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------

	declare	@regmsg			varchar(1000)	set @regmsg = '������ �������� ���� �մϴ�.'
	declare @comment		varchar(80)

	declare @gameid			varchar(20)		set @gameid			= ''
	declare @idx			int				set @idx			= -1
	declare @listidx		int
	declare @itemcode		int
	declare @cnt			int

	declare @deldate		datetime		set @deldate		= getdate() - 1
	declare @dateid8 		varchar(8)		set @dateid8 		= Convert(varchar(8),Getdate(),112)
	declare @joincnt		int				set @joincnt		= 0
	declare @cashcost 		int
	declare @loop 			int

	declare @helmetlistidx		int 		set @helmetlistidx 			= @BASE_HELMET_LISTIDX
	declare @shirtlistidx		int 		set @shirtlistidx			= @BASE_SHIRT_LISTIDX
	declare @pantslistidx		int 		set @pantslistidx			= @BASE_PANTS_LISTIDX
	declare @gloveslistidx		int 		set @gloveslistidx			= @BASE_GLOVES_LISTIDX
	declare @shoeslistidx		int 		set @shoeslistidx			= @BASE_SHOES_LISTIDX
	declare @batlistidx			int 		set @batlistidx				= @BASE_BAT_LISTIDX
	declare @balllistidx		int 		set @balllistidx			= @BASE_BALL_LISTIDX
	declare @gogglelistidx		int 		set @gogglelistidx			= @BASE_GOGGLE_LISTIDX
	declare @wristbandlistidx	int 		set @wristbandlistidx		= @BASE_WRISTBAND_LISTIDX
	declare @elbowpadlistidx	int 		set @elbowpadlistidx		= @BASE_ELBOWPAD_LISTIDX
	declare @beltlistidx		int 		set @beltlistidx			= @BASE_BELT_LISTIDX
	declare @kneepadlistidx		int 		set @kneepadlistidx			= @BASE_KNEEPAD_LISTIDX
	declare @sockslistidx		int 		set @sockslistidx			= @BASE_SOCKS_LISTIDX

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1-1 �Է�����', @gameid_ gameid_, @password_ password_, @username_ username_, @birthday_ birthday_,  @phone_ phone_, @email_ email_, @nickname_ nickname_, @version_ version_

	------------------------------------------------
	-- �ڵ������� ������ ���̵�� ���� �ľ�
	------------------------------------------------
	select
		@joincnt = joincnt
	from tUserPhone where phone = @phone_
	--select 'DEBUG 1-2  �ڵ����� ������:', @phone_ phone_, @joincnt joincnt


	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
		begin
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG 2-1', @comment
		end
	else if( LEN( @gameid_ ) <= 4)
		begin
			set @nResult_ = @RESULT_ERROR
			set @comment = '��������� 4�ڸ� ���ϴ� ����� �ȵ˴ϴ�..'
			--select 'DEBUG 2-4', @comment
		end
	else if exists (select top 1 * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = '(����)���̵� �ߺ��Ǿ����ϴ�.'
			--select 'DEBUG 2-2', @comment
		end
	else if(@joincnt >= @ID_MAX)
		begin
			set @nResult_ = @RESULT_ERROR_ID_CREATE_MAX
			set @comment = '�������� ' + ltrim(str(@ID_MAX)) + '��������(����������)'
			--select 'DEBUG 2-3', @comment
		end
	else if exists (select top 1 * from tUserMaster where email = @email_)
		begin
			set @nResult_ = @RESULT_ERROR_EMAIL_DUPLICATE
			set @comment = '�̸����� �ߺ��Ǿ����ϴ�.'
			--select 'DEBUG 2-4', @comment
		end
	else if exists (select top 1 * from tUserMaster where nickname = @nickname_)
		begin
			set @nResult_ = @RESULT_ERROR_NICKNAME_DUPLICATE
			set @comment = '�г����� �ߺ��Ǿ����ϴ�.'
			--select 'DEBUG 2-5', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(����)������ �����մϴ�.'
			--select 'DEBUG 3-1', @comment

			-------------------------------------------
			-- 1. �ʱ� ���� > ����.
			-------------------------------------------

			-------------------------------------------
			-- 2. ���� > ���Ժ�ó��
			-------------------------------------------

			------------------------------------------------
			-- 3. ������� ����...
			------------------------------------------------
			--select 'DEBUG 3-4 ���������� > ����������'
			set @listidx		= 0
			set @itemcode		= 1

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @helmetlistidx,     100,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @shirtlistidx, 	   200,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @pantslistidx, 	   300,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @gloveslistidx, 	   400,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @shoeslistidx, 	   500,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @batlistidx, 	   600,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @balllistidx, 	   700,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @gogglelistidx, 	   800,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @wristbandlistidx,  900,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @elbowpadlistidx,  1000,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @beltlistidx, 	  1100,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @kneepadlistidx,   1200,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @sockslistidx, 	  1300,   1, @USERITEM_INVENKIND_WEAR)

			---------------------------------------------
			-- ���� ���� �Է��ϱ�
			---------------------------------------------
			--select 'DEBUG 3-5 ���� ���� �Է�'
			insert into dbo.tUserMaster(
										gameid, 		password,
										username, 		birthday, 		phone, 		email, 	nickname, 	version,
										helmetlistidx, 	shirtlistidx, 	pantslistidx, 		gloveslistidx, 		shoeslistidx, 	batlistidx,
										balllistidx, 	gogglelistidx, 	wristbandlistidx, 	elbowpadlistidx, 	beltlistidx, 	kneepadlistidx,
										sockslistidx
										)
			values(
										@gameid_, 		@password_,
										@username_, 	@birthday_, 	@phone_, 	@email_, @nickname_, @version_,
										@helmetlistidx, @shirtlistidx, 	@pantslistidx, 		@gloveslistidx,		@shoeslistidx, 	@batlistidx,
										@balllistidx, 	@gogglelistidx,	@wristbandlistidx, 	@elbowpadlistidx, 	@beltlistidx,	@kneepadlistidx,
										@sockslistidx
										)
			------------------------------------
			-- ���� ��踦 �ۼ��Ѵ�.(�Ϲ�, �Խ�Ʈ)
			------------------------------------
			--select 'DEBUG > 3-7-2 ���̵��Է¹�� ����'
			exec spu_DayLogInfoStatic 11, 1             -- �� ����ũ ����(O)

			----------------------------------------------
			---- �ڵ����� ���� ī����
			----------------------------------------------
			if(@joincnt = 0)
				begin
					--select 'DEBUG > 3-8 �ڵ����� ���� ī����'
					--exec spu_DayLogInfoStatic 11, 1

					insert into dbo.tUserPhone(phone, joincnt) values(@phone_, 1)
				end
			else
				begin
					update dbo.tUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime

	--���� ����� �����Ѵ�.
	set nocount off
End



