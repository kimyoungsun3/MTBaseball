use Farm
Go
/*

select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
select * from dbo.tFVUserData
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 0, 1, '', 'skt11savetest',    -1			-- ���̺���. (��ŷ����)
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 1, '', 'skt11savetest',    -1			-- ���̺���. (��ŷ����)
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '', 'google22savetest', -1			-- ���̺���.
select * from dbo.tFVUserData where gameid = 'xxxx@gmail.com' and market in (1, 5)


         �Ǹűݾ�          �����������ְ�   �����ݾ�        ����VIP         ����귿       ����귿Ƚ��(������0, ������ 1�̻�)
userinfo=salemoney;        bestani;	   	    cashcost2		vippoint2		roulette2      roulettepaycnt2
		   0:123;          1:500;           10:0;           11:0;           20:-1;          21:0;                                         <= Ŭ������
		 100:123;          1:500;           10:0;           11:0;           20:-1;          21:1;                                          <= �����

exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;         20:-1;          21:0;', 'google22savetest',  -1		-- �������
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;         20:-1;          21:1;', 'google22savetest',  -1		-- ��Ż���
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '0:0;1:500;10:0;11:0;', 'google22savetest',  -1

select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;   20:-1', 'google22savetest',  -1		-- �������
select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
update dbo.tUserMaster set savebktime = getdate() - 10 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'google22savetest',  -1		-- ��Ż���
select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save11',  -1
update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save12',  -1
update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'PC14DAE9EC6A77'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save13',  -1
select * from dbo.tFVUserDataBackup where gameid = 'xxxx@gmail.com' order by idx2 desc


*/

IF OBJECT_ID ( 'dbo.spu_FVSave3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSave3;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSave3
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@phone_									varchar(20),
	@mode_									int,
	@market_								int,
	@userinfo_								varchar(1024),				-- �����ϰ� ���� ����...
	@savedata_								varchar(4096),
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
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ���̺갪����
	declare @SAVE_USERINFO_SALEMONEY			int				set @SAVE_USERINFO_SALEMONEY			= 0
	declare @SAVE_USERINFO_BESTANI				int				set @SAVE_USERINFO_BESTANI				= 1
	declare @SAVE_USERINFO_CASHCOST2			int				set @SAVE_USERINFO_CASHCOST2			= 10
	declare @SAVE_USERINFO_VIPPOINT2			int				set @SAVE_USERINFO_VIPPOINT2			= 11
	declare @SAVE_USERINFO_ROULETTE2			int				set @SAVE_USERINFO_ROULETTE2			= 20
	declare @SAVE_USERINFO_ROULETTEPAYCNT2		int				set @SAVE_USERINFO_ROULETTEPAYCNT2		= 21
	--declare @SAVE_USERINFO_SALEMONEY3			int				set @SAVE_USERINFO_SALEMONEY3			= 100
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '���̺�'

	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @phone 					varchar(20)
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @savebktime				datetime				set @savebktime 	= getdate()
	declare @idx2 					int 					set @idx2 			= 1

	declare @kind					int,
			@info					bigint
	declare @salemoney2				bigint					set @salemoney2		= 0
	declare @salemode				int						set @salemode		= 3
	declare @bestani2				int						set @bestani2		= 500
	declare @cashcost2				bigint					set @cashcost2		= 0
	declare @vippoint2				int						set @vippoint2		= 0
	declare @roulette2				int						set @roulette2		= -444
	declare @roulettepaycnt2		int						set @roulettepaycnt2= 0

	declare @userrankview			int						set @userrankview	= -1 -- �Ⱥ���(-1), ����(1)
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @phone_ phone_, @savedata_ savedata_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@savebktime		= savebktime
	from dbo.tUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ��������', @gameid gameid, @savebktime savebktime

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			----select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���̺� ����ó��'
			----select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- ���̺� ���� > �ݾ׻���.
			-----------------------------------------------------------------
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

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
									set @salemode		= 2
									set @salemoney2	 	= @info
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
							--else if(@kind = @SAVE_USERINFO_SALEMONEY3)
							--	begin
							--		set @salemode		= 3
							--		set @salemoney2	 	= @info
							--	end
							else if(@kind = @SAVE_USERINFO_ROULETTE2)
								begin
									set @roulette2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_ROULETTEPAYCNT2)
								begin
									set @roulettepaycnt2= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. Ŀ���ݱ�
					close curUserInfo
					Deallocate curUserInfo
					--select 'DEBUG �Է�����(useinfo)', @salemoney2 salemoney2, @bestani2 bestani2, @cashcost2 cashcost2, @vippoint2 vippoint2
				end

			----------------------------------------------
			-- ���̺� ���� ��� (6�ð�).
			----------------------------------------------
			if(@savebktime < (getdate() - 0.25))
				begin
					--select 'DEBUG ���̺� ���� ���'
					-- ��ȣ�� ����.
					select @idx2 = isnull(max(idx2), 0) + 1
					from dbo.tFVUserDataBackup
					where gameid = @gameid_ and market = @market_

					-- ����ϱ�.
					insert into dbo.tFVUserDataBackup(gameid,   market,  idx2,  savedata)
					values(                          @gameid_, @market_, @idx2, @savedata_)

					-- ���� ���� �̻��̸� �����ϱ�.
					delete from dbo.tFVUserDataBackup where gameid = @gameid_ and market = @market_ and idx2 < @idx2 - 20

					set @savebktime = getdate()
				end


			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tUserMaster
				set
					savebktime		= @savebktime,
					ownercashcost	= @ownercashcost,
					salemoney2 	= case
									when (@salemode = 2) then (salemoney2 + @salemoney2)
									when (@salemode = 3) then (             @salemoney2)
									else                       salemoney2
								  end,
					bestani			= @bestani2,
					cashcost2		=               	case when (@cashcost2 > cashcost2) then @cashcost2 else cashcost2     	end,
					vippoint2		=               	case when (@vippoint2 > vippoint2) then @vippoint2 else vippoint2     	end,
					roulette		=               	case when (@roulette2 = -1)		   				then -1         else roulette      	end,
					roulettefreecnt	= roulettefreecnt +	case when (@roulette2 = -1 and roulette = 1)	then  1         else 0             	end,
					roulettepaycnt	= roulettepaycnt + 	case when (@roulettepaycnt2 <= 0)  				then  0         else @roulettepaycnt2 end
			from dbo.tUserMaster
			where gameid = @gameid_

			----------------------------------------------
			-- �������.
			----------------------------------------------
			if(@roulettepaycnt2 > 0)
				begin
					exec spu_FVDayLogInfoStatic @market_, 61, @roulettepaycnt2				  -- �� ����귿��
				end

			----------------------------------------------
			-- ���̺� ���� ����.
			----------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserData where gameid = @gameid_ and market = @market_))
				begin
					insert into dbo.tFVUserData(gameid,   market,  savedata)
					values(                    @gameid_, @market_, @savedata_)
				end
			else
				begin
					update dbo.tFVUserData
						set
							savedata = @savedata_
					where gameid = @gameid_ and market = @market_
				end

		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			----------------------------------------------
			-- ��ŷ����?
			---------------------------------------------
			select @userrankview = userrankview from dbo.tFVUserRankView where idx = 1

			--------------------------------------------------------------
			-- ���� ��ü��ŷ
			-- 0 > �Ⱥ�����
			-- 1 > ������
			--------------------------------------------------------------
			if(@mode_ = 1 and @userrankview = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end


		END
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



