/*
--delete from tUserPushAndroid
--select * from tUserPushAndroid order by idx desc
--select * from tUserPushAndroidLog order by idx desc
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 1, '�ܼ�����', '�ܼ�����', -1, -1
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 3, 'URL����', 'http://m.naver.com', -1, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserPushMsgAndroid', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserPushMsgAndroid;
GO

create procedure dbo.spu_UserPushMsgAndroid
	@gameid_				varchar(20),
	@password_				varchar(20),
	@receid_				varchar(20),
	@kind_					int,
	@msgtitle_				varchar(512),
	@msgmsg_				varchar(512),
	@gmode_					int,						--������ ���Ӹ��.
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83

	-- �������. (99)
	declare @PUSH_MODE_MSG						int				set @PUSH_MODE_MSG						= 1
	declare @PUSH_MODE_PEACOCK					int				set @PUSH_MODE_PEACOCK					= 2
	declare @PUSH_MODE_URL						int				set @PUSH_MODE_URL						= 3
	declare @PUSH_MODE_GROUP					int				set @PUSH_MODE_GROUP					= 99	-- ��ü�߼ۿ�


	-- ��Ż� ���а�
	declare @SKT 							int					set @SKT						= 1
	--declare @KT 							int					set @KT							= 2
	--declare @LGT 							int					set @LGT						= 3
	--declare @GOOGLE 						int					set @GOOGLE						= 5
	--declare @NHN							int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @receid			varchar(20)
	declare @recepushid		varchar(256)
	declare @comment		varchar(512)
	declare @gamecost		int						set @gamecost			= 0
	declare @cashcost		int						set @cashcost			= 0
	declare @feed			int						set @feed				= 0
	declare @heart			int						set @heart				= 0

	declare @recemarket		int						set @recemarket			= @SKT

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid			= gameid,
		@gamecost		= gamecost,
		@cashcost		= cashcost,
		@feed			= feed,
		@heart			= heart
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_

	select
		@receid		= gameid,
		@recemarket	= market,
		@recepushid	= pushid
	from dbo.tUserMaster where gameid = @receid_

	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- ���̵� ���������ʴ°�??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(isnull(@receid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
			set @comment = 'ERROR ��밡 �������� �ʽ��ϴ�.'
		end
	else if(@kind_ not in (@PUSH_MODE_MSG, @PUSH_MODE_PEACOCK, @PUSH_MODE_URL))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�..'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS Push ����ó���ϴ�.'

			---------------------------------------------------
			-- ���� ����ϱ�
			---------------------------------------------------
			declare @msgtitle		varchar(512)
			declare @msgmsg			varchar(512)
			declare @msgaction		varchar(512)

			if(@kind_ = @PUSH_MODE_MSG)
				begin
					set @msgtitle	= @msgtitle_
					set @msgmsg		= @msgmsg_
					set @msgaction	= 'LAUNCH'
				end
			else if(@kind_ = @PUSH_MODE_PEACOCK)
				begin
					-- �ڵ������� �ڶ��ϱ�� ���� ���.
					set @msgtitle	= '[¥������̾߱�]'
					set @msgmsg		= '[' + @gameid + '���� �λ縦 �߽��ϴ�.'
					set @msgaction	= 'LAUNCH'

				end
			else if(@kind_ = @PUSH_MODE_URL)
				begin
					set @msgtitle	= '[¥������̾߱�]'
					set @msgmsg		= '¥���� ���ǽº�~~~'
					set @msgaction	= @msgmsg_
				end

			if(@recemarket = @IPHONE)
				begin
					insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)

					-- ��Ż ����ϱ�
					exec spu_DayLogInfoStatic 1, 51, 1				-- �� push iphone
				end
			else
				begin
					insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)

					-- ��Ż ����ϱ�
					exec spu_DayLogInfoStatic 1, 50, 10				-- �� push android
				end
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	set nocount off
End

