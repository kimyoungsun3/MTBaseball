use Game4FarmVill4
Go
/*
		ģ������Ʈ(�ڵ�����).
         �Ǹż���(0)       �����������ְ�   �����ݾ�        ����VIP         �������(30)		�������(31)	������(32)		�÷���Ÿ��(33).
userinfo=salemoney;        bestani;	   	    cashcost2		vippoint2		rkproductcnt2		rkfarmearn2		rkwolfcnt2			rkplaycnt2
		 0:123456789012;   1:500;           10:0;            11:0;          30:30;              31:31;          32:32;              33:33;
		 0:123456789012;   1:500;           10:0;            11:0;          30:30;              31:31;          32:32;              33:33;

exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:0  ;  1:500;  10:0;  11:0;                                ', 'google22savetest', -1, 8771, -1
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:0  ;  1:500;  10:0;  11:0;  30:0;   31:0;   32:0;  33:0;  ', 'google22savetest', -1, 8772, -1
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', -1, 8773, -1
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', -1, 8774, -1
select * from dbo.tFVUserData where gameid = 'xxxx2' select salemoney, bestani from dbo.tFVUserMaster where gameid = 'xxxx2'

-- ������ε� �����Ѱ�ó�� ����Ÿ ����
-- update dbo.tFVUserMaster set cashpoint = 0, vippoint = 0, cashcost = 0 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set                vippoint2 = 0, cashcost2 = 0 where gameid = 'xxxx2'
-- delete from dbo.tFVUserUnusualLog2 where gameid = 'xxxx2'
update dbo.tFVUserMaster set randserial = -1 where gameid = 'xxxx2'
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:123;   1:500;        10:50000;    11:0;    ', 'google22savetest',     -1, 8772, -1	-- ĳ��ġƮ
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:456;   1:500;        10:0;        11:50000;', 'google22savetest',     -1, 8773, -1	-- VIPġƮ

exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:123;   1:500;        10:1234567890123456;    11:0;', 'google22savetest', -1,     8774, -1	-- ĳ��ġƮ
exec spu_FVSave2 'xxxx2',  '049000s1i0n7t8445289', 1, '0:123;   1:500;        10:1234567890123456;    11:0;', 'google22savetest', -7,     8774, -1	-- ĳ��ġƮ(���Ǹ���)

*/

IF OBJECT_ID ( 'dbo.spu_FVSave2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSave2;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSave2
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@userinfo_								varchar(1024),				-- �����ϰ� ���� ����...
	@savedata_								varchar(8000),
	@sid_									int,
	@randserial_							varchar(20),
	@nResult_								int					OUTPUT
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

	-- ���̺� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- ������ ����Ǿ����ϴ�.

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- ���̺갪����
	declare @SAVE_USERINFO_SALEMONEY			int				set @SAVE_USERINFO_SALEMONEY			= 0
	declare @SAVE_USERINFO_BESTANI				int				set @SAVE_USERINFO_BESTANI				= 1
	declare @SAVE_USERINFO_CASHCOST2			int				set @SAVE_USERINFO_CASHCOST2			= 10
	declare @SAVE_USERINFO_VIPPOINT2			int				set @SAVE_USERINFO_VIPPOINT2			= 11
	declare @SAVE_USERINFO_PRODUCKCNT2			int				set @SAVE_USERINFO_PRODUCKCNT2			= 30	-- �������(30)
	declare @SAVE_USERINFO_FARMEARN2			int				set @SAVE_USERINFO_FARMEARN2			= 31	-- �������(31)
	declare @SAVE_USERINFO_WOLFCNT2				int				set @SAVE_USERINFO_WOLFCNT2				= 32	-- ������(32)
	declare @SAVE_USERINFO_PLAYCNT2				int				set @SAVE_USERINFO_PLAYCNT2				= 33	-- �÷���Ÿ��(33).

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '���̺�'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @salemoney2				bigint					set @salemoney2		= 0
	declare @bestani2				int						set @bestani2		= 500
	declare @cashcost2				bigint					set @cashcost2		= 0
	declare @vippoint2				int						set @vippoint2		= 0
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @blockstate				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @savebktime				datetime				set @savebktime 	= getdate()
	declare @idx2 					int 					set @idx2 			= 1
	declare @rebirthdate			datetime				set @rebirthdate 	= getdate()		-- ȯ����.
	declare @sameweek				int						set @sameweek		= 0
	declare @sid					int						set @sid			= 0

	declare @kind					int,
			@info					bigint

	-- �ð�üŷ
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)

	-- ��Ʈ����.
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	--declare @heartcntmax	int						set @heartcntmax	= 400
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'
	declare @cashpoint		int						set @cashpoint		= 0
	declare @vippoint		int						set @vippoint		= 0

	-- ��ü��ŷ.
	declare @rksalemoney2	bigint					set @rksalemoney2	= 0
	declare @rkproductcnt2	bigint					set @rkproductcnt2	= 0
	declare @rkfarmearn2	bigint					set @rkfarmearn2	= 0
	declare @rkwolfcnt2		bigint					set @rkwolfcnt2		= 0
	declare @rkfriendpoint2	bigint					set @rkfriendpoint2	= 0
	declare @rkroulettecnt2	bigint					set @rkroulettecnt2	= 0
	declare @rkplaycnt2		bigint					set @rkplaycnt2		= 0

	declare @roulloop		int						set @roulloop		= 0
	declare @roulloop2		int						set @roulloop2		= 0
	declare @adidx			int						set @adidx			= 0
	declare @adidxmax		int						set @adidxmax		= 0



Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @userinfo_ userinfo_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@adidx		= adidx,
		@blockstate = blockstate,
		@rebirthdate= rebirthdate,
		@heartget	= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@cashpoint	= cashpoint,	@vippoint	= vippoint,
		@market		= market,
		@sid		= sid,
		@randserial	= randserial,
		@savebktime	= savebktime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != -1 and @sid_ != @sid)
		BEGIN
			-- ���� ID�� ���� ������ �ȵ�.
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE
			set @comment 	= '������ ����Ǿ� �ֽ��ϴ�. ��α����մϴ�.'
			--select 'DEBUG ', @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ���̺� ����ó��(���Ͽ�û)'

			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���̺� ����ó��'
			--select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- ���̺� ���� > �ݾ׻���.
			-----------------------------------------------------------------
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

			----------------------------------------------
			-- �������� �ƽ���ȣ.
			----------------------------------------------
			select @adidxmax = max(idx) from dbo.tFVUserAdLog

			---------------------------------------------------
			-- �Ǹż��Ͱ� ��ǥ�������� > �Ľ�.
			---------------------------------------------------
			----select 'DEBUG ', @userinfo_ userinfo_
			if(LEN(@userinfo_) >= 3)
				begin
					-- 1. Ŀ�� ����
					declare curUserInfo Cursor for
					select fieldidx, listidx FROM dbo.fnu_SplitTwoBigint(';', ':', @userinfo_)

					-- 2. Ŀ������
					open curUserInfo

					-- 3. Ŀ�� ���
					Fetch next from curUserInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = @SAVE_USERINFO_SALEMONEY)
								begin
									set @salemoney2 	= @info
									set @rksalemoney2	= @info
								end
							else if(@kind = @SAVE_USERINFO_BESTANI)
								begin
									set @bestani2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_CASHCOST2)
								begin
									set @cashcost2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_VIPPOINT2)
								begin
									set @vippoint2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_PRODUCKCNT2)
								begin
									set @rkproductcnt2	= @info
								end
							else if(@kind = @SAVE_USERINFO_FARMEARN2)
								begin
									set @rkfarmearn2	= @info
								end
							else if(@kind = @SAVE_USERINFO_WOLFCNT2)
								begin
									set @rkwolfcnt2		= @info
								end
							else if(@kind = @SAVE_USERINFO_PLAYCNT2)
								begin
									set @rkplaycnt2		= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. Ŀ���ݱ�
					close curUserInfo
					Deallocate curUserInfo
					--select 'DEBUG �Է�����(useinfo)', @salemoney2 salemoney2, @bestani2 bestani2, @cashcost2 cashcost2, @vippoint2 vippoint2
					--select 'DEBUG (�Ľ�ó��)', @rksalemoney2 rksalemoney2, @rkproductcnt2 rkproductcnt2, @rkfarmearn2 rkfarmearn2, @rkwolfcnt2 rkwolfcnt2, @rkfriendpoint2 rkfriendpoint2, @rkroulettecnt2 rkroulettecnt2, @rkplaycnt2 rkplaycnt2
				end


			---------------------------------------------
			-- ġƮ�˻�
			---------------------------------------------
			--select 'DEBUG ', @cashpoint cashpoint, @cashcost2 cashcost2, @vippoint vippoint, @vippoint2 vippoint2
			if(@cashpoint = 0 and @cashcost2 >= 50000)
				begin
					--select 'DEBUG > ���� ġƮ'
					set @comment2 = '����̻� ����ĳ��(' + ltrim(rtrim(@cashpoint)) + ') ��������(' + ltrim(rtrim(@cashcost2)) + ')'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end
			else if(@vippoint = 0 and @vippoint2 >= 50000)
				begin
					--select 'DEBUG > VIP ġƮ'
					set @comment2 = '����̻� ����VIP(' + ltrim(rtrim(@vippoint)) + ') ����VIP(' + ltrim(rtrim(@vippoint2)) + ')'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end

			---------------------------------------------
			-- ��Ʈ�������۷� �ʱ�ȭ
			---------------------------------------------
			if(@heartdate != @dateid8)
				begin
					--select 'DEBUG �Ϸ� ��¥�� �ٲ� �ʱ�ȭ'
					set @heartdate	= @dateid8
					set @heartcnt = 0
				end
			set @heartget2 = @heartget
			set @heartget = 0


			----------------------------------------------
			-- ���̺� ���� ��� (6�ð�).
			----------------------------------------------
			if(@savebktime < (getdate() - 0.25))
				begin
					--select 'DEBUG ���̺� ���� ���'
					-- ��ȣ�� ����.
					select @idx2 = isnull(max(idx2), 0) + 1
					from dbo.tFVUserDataBackup
					where gameid = @gameid_

					-- ����ϱ�.
					insert into dbo.tFVUserDataBackup(gameid,   idx2,  savedata)
					values(                          @gameid_, @idx2, @savedata_)

					-- ���� ���� �̻��̸� �����ϱ�.
					delete from dbo.tFVUserDataBackup where gameid = @gameid_ and idx2 < @idx2 - 20

					set @savebktime = getdate()
				end


			---------------------------------------------------
			-- ȯ�������� ��.
			-- �� �� ȭ �� �� �� ��
			--                		> �̹��ֿ� ȯ���� ���.
			---------------------------------------------------
			set @sameweek = dbo.fnu_GetSameWeek( @rebirthdate, GETDATE() )

			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					savebktime		= @savebktime,
					ownercashcost	= @ownercashcost,
					adidx			= case when @adidxmax > @adidx then @adidxmax else @adidx end,
					cashcost2	= 			  case when (@cashcost2 > cashcost2) 	then @cashcost2 	else cashcost2 	end,
					vippoint2	= 			  case when (@vippoint2 > vippoint2) 	then @vippoint2 	else vippoint2 	end,
					salemoney 	= salemoney + case when (@sameweek = 1) 			then @salemoney2 	else 0 			end,
					randserial	= @randserial_,
					bestani		= @bestani2,
					heartget	= @heartget,
					heartcnt	= @heartcnt,
					heartdate	= @heartdate
			where gameid = @gameid_

			----------------------------------------------
			-- ���̺� ���� ����.
			----------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserData where gameid = @gameid_))
				begin
					--select 'DEBUG insert'
					insert into dbo.tFVUserData(gameid,   savedata)
					values(                    @gameid_, @savedata_)
				end
			else
				begin
					--select 'DEBUG update'
					update dbo.tFVUserData
						set
							savedate	= getdate(),
							savedata 	= @savedata_
					where gameid = @gameid_

					--select 'DEBUG �α� ���'
					--insert into dbo.tFVUserData2(gameid, savedata) values(@gameid_, @savedata_)
				end

			----------------------------------------------
			-- Ȧ¦ ��ŷ����
			----------------------------------------------
			--select 'DEBUG Ȧ¦ ��ŷ����', @rksalemoney2 rksalemoney2, @rkproductcnt2 rkproductcnt2, @rkfarmearn2 rkfarmearn2, @rkwolfcnt2 rkwolfcnt2, @rkfriendpoint2 rkfriendpoint2, @2, @rkplaycnt2 rkplaycnt2
			exec spu_subFVRankDaJun @gameid_, @rksalemoney2, @rkproductcnt2, @rkfarmearn2, @rkwolfcnt2, @rkfriendpoint2, @rkroulettecnt2, @rkplaycnt2
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			----------------------------------
			-- ��������.
			-- > ��Ʈ������.
			-----------------------------------
			select @heartget2 heartget2, * from dbo.tFVUserMaster where gameid = @gameid_

			------------------------------------------------
			-- ��ŷ����(����Ҷ�).
			------------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			--------------------------------------------------------------
			-- ��������.
			--------------------------------------------------------------
			select top 1 * from dbo.tFVUserAdLog
			where idx > @adidx
			order by idx desc

			--------------------------------------------------------------
			-- ���� ��ü��ŷ (3���� ������ ��ŷ�� ����)
			-- 0 > �Ⱥ�����
			-- 1 > ������
			--------------------------------------------------------------
			if(@mode_ = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end

		END
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



