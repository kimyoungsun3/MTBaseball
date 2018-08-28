/*
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  0, 'DD', 	 -1		-- �������� �ʴ� ���

exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, '', 	 -1		-- �˻� : �����˻�
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'gu', 	 -1		-- �˻� : �̿� > 0��
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'AD', 	 -1		-- �˻� : ���� > 0��
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx2', -1		-- �˻� : �̿� > 0��
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx3', -1		-- �˻� : �̿� > 0��
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx4', -1		-- �˻� : �̿� > 0��
exec spu_FVFriend 'xxxx2','049000s1i0n7t8445289',  1, 'xxxx3', -1		-- �˻� : �̿� > 0��

exec spu_FVFriend 'xxx0', '049000s1i0n7t8445289',  2, 'DD', 	 -1		-- ��û : ���� ����
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  2, 'DD',	 -1		-- ��û : ģ�� ����
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289' ,2, 'xxxx2', -1		-- ��û : ģ�� = ��
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  2, '', 	 -1		-- ��û : ģ�� ����
exec spu_FVFriend 'xxxx2','049000s1i0n7t8445289',  2, 'xxxx3', -1		-- ��û : ģ�� �߰�(����߰�����)

exec spu_FVFriend 'xxxx0', '049000s1i0n7t8445289', 3, 'xxxx',  -1		-- ���� : ģ�� ����, ����
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx2', -1		-- ���� : ���� ���� �ȵ�.
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx3', -1		-- ���� : OK(ģ��������� ������)
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx3', -1		-- ���� : OK(��ȣģ��     ������)

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 6, 'xxxx3', -1		-- ���� : ��û�ڰ� ������û(����)
exec spu_FVFriend 'xxxx3', '049000s1i0n7t8445289', 6, 'xxxx2', -1		-- ���� : OK

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 4, '', -1			-- ����Ʈ : ģ�� ����Ʈ(��ȣģ��)

update dbo.tFVUserMaster set market = 5, version = 115  where gameid = 'xxxx2'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 5, 'xxxx3', -1				-- �湮 : ģ���湮.
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 5, 'farm939103838', -1		-- �湮 : ģ���湮.

update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'xxxx2' and friendid = 'xxxx3'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 7, 'xxxx3', -1		-- ��Ʈ : ��Ʈ����, ����Ʈ����.

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 8, 'xxxx', -1		-- ģ�� ��������

-- update dbo.tFVUserMaster set condate = getdate() - 31, rtndate = getdate() - 1 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set condate = getdate() - 31, rtndate = getdate() - 1  where gameid = 'xxxx4'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 9, 'xxxx3', -1		-- ģ�� ���Ϳ�û.(Ȱ��)
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 9, 'xxxx4', -1		-- ģ�� ���Ϳ�û.(ó��, �̹�)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFriend;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVFriend
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(20),
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
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	--declare @RESULT_ERROR_TUTORIAL_ALREADY	int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	--declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	--declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	--declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	--declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	--declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	--declare @RESULT_ERROR_MAXCOUNT			int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.
	declare @RESULT_ERROR_FRIEND_WAIT_MAX		int				set @RESULT_ERROR_FRIEND_WAIT_MAX		= -131			-- ģ�� ��� �ƽ�(���̻� ģ�� ��û�� �� �� �����ϴ�.)
	declare @RESULT_ERROR_FRIEND_AGREE_MAX		int				set @RESULT_ERROR_FRIEND_AGREE_MAX		= -132			-- ģ�� �ƽ�(�� �̻� ģ���� ���� �� �����ϴ�.)
	declare @RESULT_ERROR_ALIVE_USER			int				set @RESULT_ERROR_ALIVE_USER			= -147			-- ���� Ȱ���ϴ� �����Դϴ�.
	declare @RESULT_ERROR_WAIT_RETURN			int				set @RESULT_ERROR_WAIT_RETURN			= -148			-- ��û ������Դϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])

	-- ģ���˻�, �߰�, ����
	declare @USERFRIEND_MODE_SEARCH				int					set	@USERFRIEND_MODE_SEARCH						= 1;
	declare @USERFRIEND_MODE_ADD				int					set	@USERFRIEND_MODE_ADD						= 2;
	declare @USERFRIEND_MODE_DELETE				int					set	@USERFRIEND_MODE_DELETE						= 3;
	declare @USERFRIEND_MODE_MYLIST				int					set	@USERFRIEND_MODE_MYLIST						= 4;
	declare @USERFRIEND_MODE_VISIT				int					set	@USERFRIEND_MODE_VISIT						= 5;
	declare @USERFRIEND_MODE_APPROVE			int					set	@USERFRIEND_MODE_APPROVE					= 6;
	declare @USERFRIEND_MODE_HEARD				int					set	@USERFRIEND_MODE_HEARD						= 7;
	declare @USERFRIEND_MODE_FRIEND_RENT		int					set	@USERFRIEND_MODE_FRIEND_RENT				= 8;
	declare @USERFRIEND_MODE_RETURN_FRIEND		int					set	@USERFRIEND_MODE_RETURN_FRIEND				= 9;

	-- ��⺹�ͱ���.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY							= 30 	-- ���ϰ� �����ΰ�?.
	--declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF							= 0 	-- On(1), Off(0)
	--declare @RETURN_FLAG_ON					int					set @RETURN_FLAG_ON								= 1 	-- On(1), Off(0)

	-- ģ�����°�.
	declare @USERFRIEND_STATE_NON				int					set	@USERFRIEND_STATE_NON						=-2;		-- -2: ����.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: �˻�.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : ģ����û���
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : ģ���������
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : ��ȣģ��

	declare @USERFRIEND_WAIT_MAX				int					set	@USERFRIEND_WAIT_MAX						= 100;		-- ����ģ������ο�
	declare @USERFRIEND_AGREE_MAX				int					set	@USERFRIEND_AGREE_MAX						= 100;		-- ���ģ��.

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- ����ģ��
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- īī��ģ��

	-- ������ or �����ϱ�.
	declare @KAKAO_STATUS_CURRENTING  			int				set @KAKAO_STATUS_CURRENTING			= 1				-- ������� �������
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- �����ϱ��ѻ���
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 0
	declare @version		int						set @version		= 101
	declare @downgrade 		int
	declare @friendid		varchar(60)				set @friendid		= ''
	declare @cnt			int						set @cnt 			= 0
	declare @cnt2			int						set @cnt2 			= 0
	declare @senddate		datetime				set @senddate		= getdate()
	declare @senddate2		datetime				set @senddate2		= getdate() - 1
	declare @rentdate		datetime				set @rentdate		= getdate()
	declare @rentdate2		datetime				set @rentdate2		= getdate() - 1
	declare @subcategory	int
	declare @plusheart		int
	declare @plusfpoint		int
	declare @state			int
	declare @findstate1		int
	declare @findstate2		int

	declare @condate		datetime				set @condate		= getdate()
	declare @rtndate		datetime				set @rtndate		= getdate()

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if (@mode_ not in (@USERFRIEND_MODE_MYLIST, @USERFRIEND_MODE_SEARCH, @USERFRIEND_MODE_ADD, @USERFRIEND_MODE_APPROVE, @USERFRIEND_MODE_DELETE, @USERFRIEND_MODE_VISIT, @USERFRIEND_MODE_HEARD, @USERFRIEND_MODE_FRIEND_RENT, @USERFRIEND_MODE_RETURN_FRIEND))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR �������� �ʴ� ����Դϴ�.'
		END
	else if (@mode_ = @USERFRIEND_MODE_SEARCH)
		BEGIN
			------------------------------------------
			-- �����˻�.
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS �����˻�����Ʈ'

			DECLARE @tTempTable TABLE(
				gameid 			varchar(20),
				anireplistidx	int,
				famelv			int,

				kakaotalkid		varchar(20),
				kakaouserid		varchar(20),
				kakaonickname	varchar(40),
				kakaoprofile	varchar(512),
				kakaomsgblocked	int,
				kakaofriendkind	int,
				helpdate		datetime
			);

			----------------------------------
			-- �����˻�, ���ϵ� �˻�.
			----------------------------------
			if(isnull(@friendid_, '') = '')
				begin
					-- 1. ����
					-- �ӽ� ���̺� �־ > ģ�� ����Ʈ ����.
					select @cnt = max(idx) from dbo.tFVUserMaster

					insert into @tTempTable
					select gameid, anireplistidx, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, @KAKAO_FRIEND_KIND_GAME, getdate() from dbo.tFVUserMaster
					where gameid != @gameid_
						and idx in (Convert(int, ceiling(RAND() * @cnt - 0)),
									Convert(int, ceiling(RAND() * @cnt - 1)),
									Convert(int, ceiling(RAND() * @cnt - 2)),
									Convert(int, ceiling(RAND() * @cnt - 3)),
									Convert(int, ceiling(RAND() * @cnt - 4)),
									Convert(int, ceiling(RAND() * @cnt - 5)),
									Convert(int, ceiling(RAND() * @cnt - 6)),
									Convert(int, ceiling(RAND() * @cnt - 7)),
									Convert(int, ceiling(RAND() * @cnt - 8)),
									Convert(int, ceiling(RAND() * @cnt - 9)),
									Convert(int, ceiling(RAND() * @cnt - 10)),
									Convert(int, ceiling(RAND() * @cnt - 11)),
									Convert(int, ceiling(RAND() * @cnt - 12)),
									Convert(int, ceiling(RAND() * @cnt - 13)),
									Convert(int, ceiling(RAND() * @cnt - 14)),
									Convert(int, ceiling(RAND() * @cnt - 15)),
									Convert(int, ceiling(RAND() * @cnt - 16)),
									Convert(int, ceiling(RAND() * @cnt - 17)),
									Convert(int, ceiling(RAND() * @cnt - 18)),
									Convert(int, ceiling(RAND() * @cnt - 19)),
									Convert(int, ceiling(RAND() * @cnt - 20)))
						and gameid not in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)
						and kakaostatus = @KAKAO_STATUS_CURRENTING		-- ���� ������ �������λ���.

				end
			-- �����˻��� ������ ����
			-- mogly > mogly�� �����ϸ� mogly�� ����, �� mogly, mogly2�� �˻��ϱ⸦ ����.
			--else if(exists(select top 1 * from dbo.tFVUserMaster where gameid != @gameid_ and gameid = @friendid_))
			--	begin
			--		select top 1 * from dbo.tFVUserMaster where gameid = @friendid_
			--	end
			else
				begin
					-- 2. �� '%' ����
					set @friendid_ = @friendid_ + '%'

					insert into @tTempTable
					select top 10 gameid, anireplistidx, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, @KAKAO_FRIEND_KIND_GAME, getdate() from dbo.tFVUserMaster
					where gameid != @gameid_ and gameid like @friendid_
				end


			----------------------------------
			-- ģ�� �������� �������� ��ũ Ȯ��.
			----------------------------------
			select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, '-1' state, '2010-01-01' senddate, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, kakaofriendkind, helpdate from
				@tTempTable as m
			left join
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem   where gameid in (select gameid from @tTempTable)) as i
			on
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			order by state desc, itemcode desc
		END
	else if (@mode_ = @USERFRIEND_MODE_ADD)
		BEGIN
			------------------------------------------
			-- ģ���߰�.
			------------------------------------------
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @cnt  = isnull(count(*), 0) from dbo.tFVUserFriend where gameid = @gameid_ and state in (@USERFRIEND_STATE_PROPOSE_WAIT, @USERFRIEND_STATE_APPROVE_WAIT)
			select @cnt2 = isnull(count(*), 0) from dbo.tFVUserFriend where gameid = @gameid_ and state in (@USERFRIEND_STATE_FRIEND)
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @cnt cnt, @cnt2 cnt2

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ�� ���̵� ã�� �� �����ϴ�.'
				end
			else if(@cnt > @USERFRIEND_WAIT_MAX)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_WAIT_MAX
					select @nResult_ rtn, 'ERROR ���̻� ģ�� ��û�� �� �� �����ϴ�(2).'
				end
			else if(@cnt2 > @USERFRIEND_AGREE_MAX)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_AGREE_MAX
					select @nResult_ rtn, 'ERROR �� �̻� ģ���� ���� �� �����ϴ�(3).'
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ����ģ���߰�'

					------------------------------------------
					-- (��û��) > ģ����û���...
					------------------------------------------
					set @findstate1 = @USERFRIEND_STATE_NON
					select top 1 @findstate1 = state from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_

					if(@findstate1 = @USERFRIEND_STATE_NON)
						begin
							--ģ���߰�
							insert into dbo.tFVUserFriend(gameid,   friendid,   state)
							values(                    @gameid_, @friendid_, @USERFRIEND_STATE_PROPOSE_WAIT)
						end
					else if(@findstate1 = @USERFRIEND_STATE_APPROVE_WAIT)
						begin
							--ģ���߰�
							update dbo.tFVUserFriend
								set
									state = @USERFRIEND_STATE_FRIEND
							where gameid = @gameid_ and friendid = @friendid_
						end

					------------------------------------------
					-- (����)	> @ģ���������...
					------------------------------------------
					set @findstate2 = @USERFRIEND_STATE_NON
					select top 1 @findstate2 = state from dbo.tFVUserFriend where gameid = @friendid_ and friendid = @gameid_

					if(@findstate2 = @USERFRIEND_STATE_NON)
						begin
							insert into dbo.tFVUserFriend(  gameid,   friendid,  state)
							values(                    @friendid_, @gameid_,  @USERFRIEND_STATE_APPROVE_WAIT)
						end
					else if(@findstate2 = @USERFRIEND_STATE_PROPOSE_WAIT)
						begin
							--ģ���߰�
							update dbo.tFVUserFriend
								set
									state = @USERFRIEND_STATE_FRIEND
							where gameid = @friendid_ and friendid = @gameid_
						end

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_

				end
		END
	else if (@mode_ = @USERFRIEND_MODE_DELETE)
		BEGIN
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

			if(@gameid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ���� ģ������Ʈ ����' + @friendid_

					------------------------------------------
					-- ģ������
					------------------------------------------
					delete from dbo.tFVUserFriend where gameid = @gameid_   and friendid = @friendid_
					delete from dbo.tFVUserFriend where gameid = @friendid_ and friendid = @gameid_

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_APPROVE)
		BEGIN
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @state = state        from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_

			if(@gameid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@state not in (@USERFRIEND_STATE_APPROVE_WAIT, @USERFRIEND_STATE_FRIEND))
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR ��û ���� ������� ���� ó�� �� �� �ֽ��ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ�� ����ó��' + @friendid_

					------------------------------------------
					-- ģ������
					------------------------------------------
					update dbo.tFVUserFriend set state = @USERFRIEND_STATE_FRIEND, senddate = getdate() where gameid = @gameid_   and friendid = @friendid_
					update dbo.tFVUserFriend set state = @USERFRIEND_STATE_FRIEND, senddate = getdate() where gameid = @friendid_ and friendid = @gameid_

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_MYLIST)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ����ģ������Ʈ'

			--------------------------------------------------------------
			-- ���� ģ������
			-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_
		END
	else if (@mode_ = @USERFRIEND_MODE_VISIT)
		BEGIN
			-- ģ���� ����
			select @gameid 		= gameid, @market = market, @version = version from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ���� ����'

					---------------------------------------------
					-- ��ģ����ģ�е� �ø���
					---------------------------------------------
					update dbo.tFVUserFriend
						set
						familiar = familiar + 1
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					-- ģ������(����������).
					-- ������ ���� �Ϳ����� �������� > �����·� �״�� �д�
					-- (�׽�Ʈ ������ ������ ���߱Ⱑ ����)
					---------------------------------------------
					set @downgrade = 0
					if(    (@market = @MARKET_SKT    and @version <= 113)
						or (@market = @MARKET_GOOGLE and @version <= 119)
						or (@market = @MARKET_NHN    and @version <= 107)
						or (@market = @MARKET_IPHONE and @version <= 116))
							begin
								set @downgrade = 1
							end

					-- > ������ ������ ������ ������ ���´�.
					select
						*,
						case when (@downgrade = 1 and housestep    >= 7)  then 7  else housestep 	end housestep2,
						case when (@downgrade = 1 and tankstep     >= 23) then 23 else tankstep 	end tankstep2,
						case when (@downgrade = 1 and bottlestep   >= 23) then 23 else bottlestep 	end bottlestep2,
						case when (@downgrade = 1 and pumpstep     >= 23) then 23 else pumpstep 	end pumpstep2,
						case when (@downgrade = 1 and transferstep >= 23) then 23 else transferstep end transferstep2,
						case when (@downgrade = 1 and purestep     >= 23) then 23 else purestep 	end purestep2,
						case when (@downgrade = 1 and freshcoolstep>= 23) then 23 else freshcoolstep end freshcoolstep2
					from dbo.tFVUserMaster where gameid = @friendid_

					---------------------------------------------
					-- ģ����������.
					---------------------------------------------
					select * from dbo.tFVUserItem
					where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI and (fieldidx >= 0 and fieldidx < 9)

					---------------------------------------------
					-- ģ������������.
					---------------------------------------------
					select * from dbo.tFVUserSeed
					where gameid = @friendid_
					order by seedidx asc

				end
		END
	else if (@mode_ = @USERFRIEND_MODE_HEARD)
		BEGIN
			-- ģ���� ����
			select @gameid 		= gameid, @market = market from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state,
				   @senddate 	= senddate from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR ��ȣģ���� �ƴմϴ�.'
				end
			else if(@senddate > @senddate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR ��Ʈ ���� �ð��� ���ҽ��ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ������ ��Ʈ �����ϱ�'

					-------------------------------------
					-- �� īī�� ��Ʈ(O)
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 16, 1

					---------------------------------------------
					-- ģ������ ���� �˾ƿ���.
					---------------------------------------------
					set 	@subcategory	= @ITEM_SUBCATEGORY_COW
					select 	@subcategory 	= subcategory from dbo.tFVItemInfo
					where itemcode = (select top 1 itemcode from dbo.tFVUserItem
									  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
											  and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))

					---------------------------------------------
					-- ģ������ 	> ģ��	 	> ��Ʈ����(3,4,6)
					-- ģ������ 	> �� 		> ��������Ʈ(3,4,6)
					-- ����		 	> �� 		> ��������Ʈ(2,3,3)
					---------------------------------------------
					set @plusheart = case
										when @subcategory = @ITEM_SUBCATEGORY_SHEEP then 5
										when @subcategory = @ITEM_SUBCATEGORY_GOAT	then 4
										else 											 3
									end
					set @plusfpoint = @plusheart


					update dbo.tFVUserMaster
						set
							heart = case
										when (heart 			) > heartmax then heart
										when (heart + @plusheart) > heartmax then heartmax
										else (heart + @plusheart)
									end,
							heartget = heartget + case
														when (heart 			) > heartmax then 0
														when (heart + @plusheart) > heartmax then (heartmax - heart)
														else                                      @plusheart
													end
					where gameid = @friendid_

					update dbo.tFVUserMaster
						set
							fpoint =  case
										when (fpoint 		 	  ) > fpointmax then fpoint
										when (fpoint + @plusfpoint) > fpointmax then fpointmax
										else (fpoint + @plusfpoint)
									end
					where gameid = @gameid_


					---------------------------------------------
					--	��		> ����Ʈ���޳��ڰ���
					-- ��Ʈ ���� �ð� ���� (Ŭ�� 24�ð��� �������� ����)
					-- 1 : 24H = 0.25 : 6H
					-- t - 24 > (t2 - (1 - 0.25) - 24
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							senddate = (getdate() - (1 - 0.25))
					where gameid = @gameid_ and friendid = @friendid_


					---------------------------------------------
					--	��������.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_


					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_FRIEND_RENT)
		BEGIN
			-- ģ���� ����
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state,
				   @rentdate 	= rentdate from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR ��ȣģ���� �ƴմϴ�.'
				end
			else if(@rentdate > @rentdate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR ���������� ���ҽ��ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ������ ����������'

					---------------------------------------------
					-- ģ������ ����������
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							rentdate = getdate()
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					--	��������.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_RETURN_FRIEND)
		BEGIN
			-- ģ���� ����
			select @gameid 		= gameid, @market = market from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid, @condate = condate, @rtndate = rtndate from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ����', @gameid gameid, @friendid friendid, @state state

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR ��ȣģ���� �ƴմϴ�.'
				end
			else if(@condate > (getdate() - @RETURN_LIMIT_DAY))
				begin
					set @nResult_ = @RESULT_ERROR_ALIVE_USER
					select @nResult_ rtn, 'ERROR ���� Ȱ���ϴ� �����Դϴ�.'
				end
			else if(@rtndate >= (getdate() - 1))
				begin
					set @nResult_ = @RESULT_ERROR_WAIT_RETURN
					select @nResult_ rtn, 'ERROR ��û ������Դϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ������ ���� ��û�ϱ�'

					-------------------------------------
					-- ���� ��û��.
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 27, 1

					-------------------------------------
					-- �������� > ��ûģ���� ���� ����
					-------------------------------------
					update dbo.tFVUserMaster
						set
							rtngameid 	= @gameid_,
							rtndate 	= getdate()
					where gameid = @friendid_

					set @plusfpoint = 1
					update dbo.tFVUserMaster
						set
							fpoint =  case
										when (fpoint 		 	  ) > fpointmax then fpoint
										when (fpoint + @plusfpoint) > fpointmax then fpointmax
										else (fpoint + @plusfpoint)
									end
					where gameid = @gameid_

					---------------------------------------------
					--	��������.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR �˼����� ����(-1)'
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

