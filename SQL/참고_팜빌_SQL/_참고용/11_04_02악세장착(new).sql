---------------------------------------------------------------
/*
-- �Ǽ�����
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1	-- �Ǽ�(�Ӹ�)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1402, 1, -1, -1, -1, 7776, -1	-- �Ǽ�(�Ӹ�)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1462, 1, -1, -1, -1, 7777, -1	-- �Ǽ�(������)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1463, 1, -1, -1, -1, 7777, -1	-- �Ǽ�(������)

-- ���� > �Ǽ�����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445287',  0, 12, 13, 7771, -1	-- �н����� �߸�.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  1, 99, 99, 7772, -1	-- ����.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 14, 12, 10, 7773, -1	-- �����ڸ��� Ʋ��
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 17, 20, 7774, -1	-- �Ǽ��ڸ��� Ʋ��.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  4, 16, 17, 7775, -1	-- ��������.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, 20, 7776, -1	-- �ϳ��� �Ǽ��� ����.

exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, 16, -1, 7777, -1	-- 1�������� 12���Ǽ��� �Ӹ�
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, -1, 17, 7778, -1	-- 1��������                  13���Ǽ��� ������
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, 16, 17, 7779, -1	-- 1�������� 12���Ǽ��� �Ӹ�, 13���Ǽ��� ������
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  1, 12, 13, 7770, -1	-- 1�������� 7���Ǽ��� �Ӹ�

--delete from dbo.tFVUserItem where gameid = 'xxxx2' and listidx in (33, 34, 35, 36, 37, 38)
--update dbo.tFVUserMaster set randserial = -1, gamecost = 10000, bgacc1listidx = -1, bgacc2listidx = -1 where gameid = 'xxxx2'
--update dbo.tFVUserItem	set acc1 = -1, acc2 = -1, randserial = -1 where gameid = 'xxxx2' and listidx = 19
--update dbo.tFVUserItem	set acc1 = 1400, acc2 = 1460, randserial = -1 where gameid = 'xxxx2' and listidx = 19

---------------------------------------------
-- acc1listidx, acc2listidx ������ �ִ°�
---------------------------------------------
-- ��ü�ϱ�			: >=0 ��ȣ
-- �����ϱ�			: -1
-- �����¸� ����	: -2

-- s1. ó�� ��� > �Ǽ� �Ѵ� ���� > �Ǽ� �Ѵ� ����
delete from dbo.tFVUserItem where gameid = 'xxxx2' and listidx in (20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1402, 1, -1, -1, -1, 7776, -1	 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1461, 1, -1, -1, -1, 7777, -1 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1462, 1, -1, -1, -1, 7777, -1	-- �Ǽ�(������)
update dbo.tFVUserMaster set gamecost = 10000, cashcost = 10000, randserial = -1, bgacc1listidx = -1, bgacc2listidx = -1 where gameid = 'xxxx2'
update dbo.tFVUserItem	set acc1 = -1, acc2 = -1, randserial = -1 where gameid = 'xxxx2' and listidx = 19
update dbo.tFVUserItem	set acc1 = 1403, acc2 = 1463, randserial = -1 where gameid = 'xxxx2' and listidx = 19

exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, 22, 7771, -1	-- ����� �Ѵ� ä���
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 21, 23, 7772, -1	-- �ִ°��� �Ѵ� ä���
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -1, 7775, -1	-- �Ѵ뻩��
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -2, 7775, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, 21, 7779, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -1, 7773, -1	-- �Ѵ뻩��
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -1, 7775, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, -1, 7771, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -2, 7774, -1	-- �ִ°��� �Ѵ� ä���
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -1, 7776, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, 25, 7777, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -2, 7776, -1	-- ���ʸ� ����
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 27, -1, 7777, -1	-- ���ʸ� ����

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemAccNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemAccNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVItemAccNew
	@gameid_				varchar(60),
	@password_				varchar(20),
	@anilistidx_			int,
	@acc1listidx_			int,
	@acc2listidx_			int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	--declare @RESULT_ERROR_GAMECOST_LACK		int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	--declare @RESULT_ERROR_CASHCOST_LACK		int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	--declare @RESULT_ERROR_ITEM_LACK			int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	--declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	--declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	--declare @RESULT_ERROR_NOT_FOUND_GIFTID	int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	--declare @RESULT_ERROR_TUTORIAL_ALREADY	int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	--declare @RESULT_ERROR_NOT_FOUND_OTHERID	int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	--declare @RESULT_ERROR_NOT_MATCH			int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	--declare @RESULT_ERROR_DOUBLE_RANDSERIAL	int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	--declare @RESULT_ERROR_MAXCOUNT			int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	--declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	--declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.


	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	-- ������ ȹ����
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--�⺻
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1	--����
	--declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--����
	--declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--����/�̱�
	--declare @DEFINE_HOW_GET_SEARCH			int					set @DEFINE_HOW_GET_SEARCH					= 4	--�˻�
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--����
	--declare @DEFINE_HOW_GET_ROULACC			int					set @DEFINE_HOW_GET_ROULACC					= 9	--�׼��̱�
	declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--�׼�����

	-- �Ǽ� ���°�
	-- �Ǽ� ��ü listidx >= 0																							-- �Ǽ���ü.
	declare @ACC_STATE_STRIP					int					set @ACC_STATE_STRIP						= -1	-- �Ǽ�����.
	declare @ACC_STATE_KEEP						int					set @ACC_STATE_KEEP							= -2	-- �Ǽ�����.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid				= ''

	declare @aniinvenkind	int				set @aniinvenkind	= -1
	declare @aniitemcode	int				set @aniitemcode	= -444
	declare @anifieldidx	int				set @anifieldidx	= @USERITEM_FIELDIDX_HOSPITAL
	declare @acc1			int				set @acc1			= -1
	declare @acc2			int				set @acc2			= -1
	declare @acc1bg1		int				set @acc1bg1		= -1
	declare @acc2bg1		int				set @acc2bg1		= -1
	declare @acc1bg2		int				set @acc1bg2		= -1
	declare @acc2bg2		int				set @acc2bg2		= -1

	declare @acc1invenkind	int				set @acc1invenkind	= -1
	declare @acc2invenkind	int				set @acc2invenkind	= -1
	declare @acc1itemcode	int				set @acc1itemcode	= -444
	declare @acc2itemcode	int				set @acc2itemcode	= -444

	declare @anireplistidx	int				set @anireplistidx	= 1
	declare @invenaccmax	int
	declare @invencnt 		int				set @invencnt		= 0
	declare @invenkind 		int				set @invenkind		= @USERITEM_INVENKIND_ACC
	declare @bgacc1listidxdel 	int
	declare @bgacc2listidxdel 	int
	declare @bgacc1listidx 	int
	declare @bgacc2listidx 	int
	declare @randserial		varchar(20)		set @randserial		= ''
	declare @listidxnew		int				set @listidxnew		= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @anilistidx_ anilistidx_, @acc1listidx_ acc1listidx_, @acc2listidx_ acc2listidx_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@anireplistidx	= anireplistidx,
		@invenaccmax 	= invenaccmax,
		@bgacc1listidxdel = bgacc1listidxdel,
		@bgacc2listidxdel = bgacc2listidxdel,
		@bgacc1listidx	= bgacc1listidx,
		@bgacc2listidx	= bgacc2listidx,
		@randserial		= randserial
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @anireplistidx anireplistidx, @invenaccmax invenaccmax, @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial randserial

	select
		@aniinvenkind	= invenkind,
		@aniitemcode	= itemcode,
		@anifieldidx	= fieldidx,
		@acc1			= acc1,
		@acc2			= acc2
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @anilistidx_
	--select 'DEBUG 3-2-2 ��������', @anilistidx_ anilistidx_, @aniinvenkind aniinvenkind, @aniitemcode aniitemcode, @anifieldidx anifieldidx, @acc1 acc1, @acc2 acc2

	select
		@acc1invenkind	= invenkind,
		@acc1itemcode	= itemcode
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc1listidx_
	--select 'DEBUG 3-2-3 �Ǽ�����1', @acc1listidx_ acc1listidx_, @acc1invenkind acc1invenkind, @acc1itemcode acc1itemcode

	select
		@acc2invenkind	= invenkind,
		@acc2itemcode	= itemcode
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc2listidx_
	--select 'DEBUG 3-2-4 �Ǽ�����1', @acc2listidx_ acc2listidx_, @acc2invenkind acc2invenkind, @acc2itemcode acc2itemcode

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			----select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �׼����� �߽��ϴ�.(�̹�:�����������̵�����)'
			--select 'DEBUG ' + @comment
		END
	else if (@acc1listidx_ = @ACC_STATE_KEEP and @acc2listidx_ = @ACC_STATE_KEEP)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �׼��� �����Ѵ�.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx		= -1
			----select 'DEBUG ' + @comment
		END
	else if ((@acc1 = -1 and @acc1listidx_ in (@ACC_STATE_STRIP, @ACC_STATE_KEEP)) and (@acc2 = -1 and @acc2listidx_ in (@ACC_STATE_STRIP, @ACC_STATE_KEEP)))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �׼��� ���°��� ����, ���� ���� �н�.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx 		= -1
			--select 'DEBUG ' + @comment
		END
	else if ( (@acc1listidx_ = @ACC_STATE_KEEP and @acc2 = -1 and @acc2listidx_ = @ACC_STATE_STRIP)
			or (@acc2listidx_ = @ACC_STATE_KEEP and @acc1 = -1 and @acc1listidx_ = @ACC_STATE_STRIP))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �׼��� ���°��� ���� ���� �н�.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx 		= -1
			--select 'DEBUG ' + @comment
		END
	else if (@aniinvenkind != @USERITEM_INVENKIND_ANI or @aniitemcode = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR ���� ���� ���� �ʽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ((@acc1listidx_ >= 0 and @acc1itemcode < 0) or (@acc2listidx_ >= 0 and @acc2itemcode < 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR ��ü �Ǽ��縮�� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ((@acc1listidx_ >= 0 and @acc1invenkind != @USERITEM_INVENKIND_ACC) or (@acc2listidx_ >= 0 and @acc2invenkind != @USERITEM_INVENKIND_ACC))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �Ǽ�����Ʈ ��ȣ�� �ƴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@acc1listidx_ != -1 and @acc1listidx_ = @acc2listidx_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �Ǽ��� ���� ���� �����ҷ�����.'
			--select 'DEBUG ' + @comment
		END
	else if (@anifieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR ������ ������ ������..'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �Ǽ� �����մϴ�.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- �׼�					-> �����ľ�
			--------------------------------------------------------------
			select
				@invencnt = count(*)
			from dbo.tFVUserItem
			where gameid = @gameid_
				and invenkind = @invenkind
				and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
			set @invencnt = @invencnt + case when (@acc1 != -1 and @acc1listidx_ = @ACC_STATE_STRIP) then 1 else 0 end
			set @invencnt = @invencnt + case when (@acc2 != -1 and @acc2listidx_ = @ACC_STATE_STRIP) then 1 else 0 end
			set @invencnt = @invencnt - case when (@acc1 = -1 and @acc1listidx_ >= 0) then 1 else 0 end
			set @invencnt = @invencnt - case when (@acc2 = -1 and @acc2listidx_ >= 0) then 1 else 0 end
			--select 'DEBUG 4-4 �׼�(4)�κ��ֱ�', @invencnt invencnt, @invenaccmax invenaccmax

			if(@invencnt > @invenaccmax)
				begin
					set @nResult_ = @RESULT_ERROR_INVEN_FULL
					set @comment = 'ERROR �׼� �κ��� Ǯ�Դϴ�.'
					--select 'DEBUG ' + @comment, @invenaccmax invenaccmax
				end
			else
				begin
					-----------------------------------------
					-- 1-1. �Ǽ��縮 �־��ֱ�.
					-----------------------------------------
					set @acc1bg1 = @acc1
					set @acc2bg1 = @acc2
					set @bgacc1listidxdel = case when (@acc1listidx_ >= 0) then @acc1listidx_ else -1 end
					set @bgacc2listidxdel = case when (@acc2listidx_ >= 0) then @acc2listidx_ else -1 end

					if(@acc1listidx_ >= 0)
						begin
							--select 'DEBUG �Ӹ� �Ǽ� ����(��)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode

							set @acc1 = @acc1itemcode

							delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc1listidx_
							--select 'DEBUG �Ӹ� �Ǽ� ����(��)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode
						end
					else if(@acc1listidx_ = @ACC_STATE_STRIP)
						begin
							--select 'DEBUG �Ӹ� �Ǽ� ����'
							set @acc1 = -1
						end

					if(@acc2listidx_ >= 0)
						begin
							--select 'DEBUG ��, ������ �Ǽ� ����(��)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode

							set @acc2 = @acc2itemcode

							delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc2listidx_
							--select 'DEBUG ��, ������ �Ǽ� ����(��)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode
						end
					else if(@acc2listidx_ = @ACC_STATE_STRIP)
						begin
							--select 'DEBUG ��, ������ �Ǽ� ����'
							set @acc2 = -1
						end

					-----------------------------------------
					-- 1-2. ���ð��� ���� �־��ش�.
					-----------------------------------------
					----select 'DEBUG ������ ���� ������ ����'
					update dbo.tFVUserItem
						set
							acc1 	= @acc1,
							acc2	= @acc2
					where gameid = @gameid_ and listidx = @anilistidx_


					-----------------------------------------
					--	2. ����, ��ü  > �κ��� �־��ֱ�.
					-----------------------------------------
					set @acc1bg2 = @acc1
					set @acc2bg2 = @acc2
					set @acc1 = @acc1bg1
					set @acc2 = @acc2bg1

					select @listidxnew = isnull(MAX(listidx), 0) from dbo.tFVUserItem where gameid = @gameid_
					--select 'DEBUG ���·� ����', @gameid_ gameid_, @listidxnew listidxnew

					--select 'DEBUG �Ӹ� �׼��˻�', @acc1 acc1, @acc1listidx_ acc1listidx_
					set @bgacc1listidx = -1
					if(@acc1 != -1 and @acc1listidx_ != @ACC_STATE_KEEP)
						begin
							set @listidxnew 	= @listidxnew + 1
							set @bgacc1listidx 	= @listidxnew
							--select 'DEBUG  > �Ӹ� �׼�����, ��ü', @gameid_ gameid_, @bgacc1listidx bgacc1listidx

							insert into dbo.tFVUserItem(gameid,         listidx, itemcode,  invenkind,  randserial,   gethow)		-- �׼�
							values(					 @gameid_, @bgacc1listidx,    @acc1, @invenkind, @randserial_, @DEFINE_HOW_GET_ACCSTRIP)
						end

					--select 'DEBUG �� �׼��˻�', @acc2 acc2, @acc2listidx_ acc2listidx_
					set @bgacc2listidx = -1
					if(@acc2 != -1 and @acc2listidx_ != @ACC_STATE_KEEP)
						begin
							set @listidxnew 	= @listidxnew + 1
							set @bgacc2listidx 	= @listidxnew
							--select 'DEBUG  > �� �׼�����, ��ü', @gameid_ gameid_, @bgacc2listidx bgacc2listidx

							insert into dbo.tFVUserItem(gameid,         listidx, itemcode,  invenkind,  randserial,   gethow)		-- �׼�
							values(					 @gameid_, @bgacc2listidx,    @acc2, @invenkind, @randserial_, @DEFINE_HOW_GET_ACCSTRIP)
						end


					-----------------------------------------
					-- ��ǥ�������� �Ǽ��縮 ����
					-----------------------------------------
					if(@anireplistidx = @anilistidx_)
						begin
							--select 'DEBUG ��ǥ���� �и�', @acc1 acc1, @acc2 acc2, @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial_ randserial_
							update dbo.tFVUserMaster
								set
									anirepacc1		= @acc1,
									anirepacc2		= @acc2,
									bgacc1listidxdel= @bgacc1listidxdel,
									bgacc2listidxdel= @bgacc2listidxdel,
									bgacc1listidx	= @bgacc1listidx,
									bgacc2listidx	= @bgacc2listidx,
									randserial		= @randserial_
							where gameid = @gameid_
						end
					else
						begin
							--select 'DEBUG �Ϲݵ��� �и�', @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial_ randserial_
							update dbo.tFVUserMaster
								set
									bgacc1listidxdel= @bgacc1listidxdel,
									bgacc2listidxdel= @bgacc2listidxdel,
									bgacc1listidx	= @bgacc1listidx,
									bgacc2listidx	= @bgacc2listidx,
									randserial		= @randserial_
							where gameid = @gameid_
						end


					set @acc1 = @acc1bg2
					set @acc2 = @acc2bg2
				end
		END

	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @anilistidx_ anilistidx, @acc1 acc1, @acc2 acc2, @bgacc1listidxdel bgacc1listidxdel, @bgacc2listidxdel bgacc2listidxdel
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- ���� ���� > �Ⱥ�����..
			--select * from dbo.tFVUserItem where gameid = @gameid_ and listidx = @anilistidx_

			-- �׼�����Ʈ.
			select * from dbo.tFVUserItem where gameid = @gameid_ and listidx in (@bgacc1listidx, @bgacc2listidx)
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

