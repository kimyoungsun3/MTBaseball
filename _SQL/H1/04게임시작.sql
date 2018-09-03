---------------------------------------------------------------
/* 
[�������ӽ���/�����]
gameid=xxx
gmode=GAME_MODE_TRAIN

select * from dbo.tUserMaster where gameid = 'SangSang'
exec spu_GameStart 'SangSang', 1, -1, -1, -1, -1, -1, -1			--�������
exec spu_GameStart 'SangSang', 2, -1, -1, -1, -1, -1, -1			--�ӽŸ��
exec spu_GameStart 'SangSang', 3, -1, -1, -1, -1, -1, -1			--�ϱ���
exec spu_GameStart 'SangSang', 4, -1, -1, -1, -1, -1, -1			--�ҿ���(��ɻ���)
exec spu_GameStart 'SangSang', 5,  1,  0,  1,  0,  1, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  1,  1,  1,  1,  1, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  0,  0, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  1,  0,  0,  0,  0, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  0,  1,  0,  0,  0, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  0,  0,  1,  0,  0, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  1,  0, -1			--��Ʋ���
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  0,  0, -1			--��Ʋ���
exec spu_GameStart 'superman6', 6,  0,  0,  0,  0,  0, -1			--������Ʈ
exec spu_GameStart 'SangSang', 6,  1,  1,  1,  1,  1, -1			--������Ʈ
exec spu_GameStart 'sususu', 6,  1,  1,  1,  1,  1, -1			--������Ʈ
update dbo.tUserMaster set actioncount = actionmax, btflag = 0, btflag2 = 0, bttem1cnt = 1, bttem2cnt = 1, bttem3cnt = 1, bttem4cnt = 1, bttem5cnt = 1, silverball = 1000 where gameid = 'SangSang'



exec spu_GameStart 'SangSang1', 2, -1, -1, -1, -1, -1, -1			--�ӽŸ��
*/

IF OBJECT_ID ( 'dbo.spu_GameStart', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GameStart;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GameStart
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@gmode_									int,
	@bttem1chk_								int,
	@bttem2chk_								int,
	@bttem3chk_								int,
	@bttem4chk_								int,
	@bttem5chk_								int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------	
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2			
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3
	
	-- �α��� ����. 
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17			
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	                                                                                                         			
	-- �����߿� ����.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--�ൿ���� �����ϴ�.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--������ �����ϴ�.

	-- ������ ����, ����.                                                                                                   			
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--���׷��̵带 �Ҽ� ����.						
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--���׷��̵� ����.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--�������� ���� �Ǿ���.

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������


	-- ���°�.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- ������
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- �������¾ƴ�
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- ��������

	-- ����ó�ڵ�
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- �ý��� üŷ
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- ������������
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1
	
	-- ���ӽ���
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
	-- ��庰 �ൿ�� �Ҹ�
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- Ÿ���� ����
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 2�п� �Ѱ��� ä����
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40�п� �ѹ���
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- ģ����Ŀ��ǹ� 20M�п� �Ѱ��� ä����
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @silverball		int
	declare @bttem1cnt		int
	declare @bttem2cnt		int
	declare @bttem3cnt		int
	declare @bttem4cnt		int
	declare @bttem5cnt		int
	
	--������ ������ ���̺��� �о�������� ���� ���� �ʵ��� �ϱ����ؼ� ���������ص�
	declare @bttem1price	int									set @bttem1price						= 70
	declare @bttem2price	int									set @bttem2price						= 90
	declare @bttem3price	int									set @bttem3price						= 110
	declare @bttem4price	int									set @bttem4price						= 120
	declare @bttem5price	int									set @bttem5price						= 5
	
	--���׹̳� �����̿�� ������ �ð�
	declare @actionfreedate		datetime
	
	-- �ð�üŷ
	declare @dateid10 		varchar(10) 						set @dateid10 							= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @market			int									set @market								= 1
	

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����Ÿ �о����
	select 
		@market = market,
		@actioncount = actioncount, @actionmax = actionmax, @actiontime = actiontime,
		@actionfreedate = actionfreedate,
		@bttem1cnt = bttem1cnt, 
		@bttem2cnt = bttem2cnt, 
		@bttem3cnt = bttem3cnt, 
		@bttem4cnt = bttem4cnt, 
		@bttem5cnt = bttem5cnt, 
		@silverball = silverball
	from dbo.tUserMaster where gameid = @gameid_

	
	------------------------------------------------
	--	������������
	------------------------------------------------
	if isnull(@silverball, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR ������ �������� �ʽ��ϴ�.'
			return
		END


	------------------------------------------------
	--	(��Ʋ)��� ��üũ
	-- ������Ʈ���� ��üũ 
	------------------------------------------------
	IF(@gmode_ in (@GAME_MODE_BATTLE))
		begin
			--select 'DEBUG (��Ʋ)��� ��üũ'
			
			-- ��Ʋ������ üŷ and ��Ʋ������ �����ϸ� ����, ������ �ǹ�����
			if(@bttem1chk_ = 1)
				begin 
					if(@bttem1cnt > 0)
						begin
							--select 'DEBUG ��Ʋ1�� ���� > ��������:' + str(@bttem1cnt)
							set @bttem1cnt = @bttem1cnt - 1
						end
					else
						begin
							--select 'DEBUG ��Ʋ1�� ���� > �ǹ�����:' + str(@silverball)
							set @silverball = @silverball - @bttem1price;
						end
				end
				
			if(@bttem2chk_ = 1)
				begin 
					if(@bttem2cnt > 0)
						begin
							--select 'DEBUG ��Ʋ2�� ���� > ��������:' + str(@bttem2cnt)
							set @bttem2cnt = @bttem2cnt - 1
						end
					else
						begin
							--select 'DEBUG ��Ʋ2�� ���� > �ǹ�����:' + str(@silverball)
							set @silverball = @silverball - @bttem2price;
						end
				end
				
			if(@bttem3chk_ = 1)
				begin 
					if(@bttem3cnt > 0)
						begin
							--select 'DEBUG ��Ʋ3�� ���� > ��������:' + str(@bttem3cnt)
							set @bttem3cnt = @bttem3cnt - 1
						end
					else
						begin
							--select 'DEBUG ��Ʋ3�� ���� > �ǹ�����:' + str(@silverball)
							set @silverball = @silverball - @bttem3price;
						end
				end
				
			if(@bttem4chk_ = 1)
				begin 
					if(@bttem4cnt > 0)
						begin
							--select 'DEBUG ��Ʋ4�� ���� > ��������:' + str(@bttem4cnt)
							set @bttem4cnt = @bttem4cnt - 1
						end
					else
						begin
							--select 'DEBUG ��Ʋ4�� ���� > �ǹ�����:' + str(@silverball)
							set @silverball = @silverball - @bttem4price;
						end
				end
				
			if(@bttem5chk_ = 1)
				begin 
					if(@bttem5cnt > 0)
						begin
							--select 'DEBUG ��Ʋ5�� ���� > ��������:' + str(@bttem5cnt)
							set @bttem5cnt = @bttem5cnt - 1
						end
					else
						begin
							--select 'DEBUG ��Ʋ3�� ���� > �ǹ�����:' + str(@silverball)
							set @silverball = @silverball - @bttem5price;
						end
				end
			 
		end
	

	-----------------------------------------------
	--	�ൿ�� > �þ �ð��ΰ�? �˻� > ����
	-----------------------------------------------
	-- select * from tUserMaster where gameid = 'SangSang'
	--set @actionmax = 25				
	--set @actiontime = '2012-08-02 13:00'		
	--set @gameid_ = 'SangSang'
	--set @gmode_ = @GAME_MODE_TRAINING
	--set @actioncount = 0 		
	--exec spu_GameStart 'SangSang', 1, -1			--�������

	declare @nActPerMin bigint,
			@nActCount int, 					
			@dActTime datetime
	set @nActPerMin = @LOOP_TIME_ACTION						-- �ൿ�� 2�п� �Ѱ��� ä����
	set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
	set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
	set @actioncount = @actioncount + @nActCount
	set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
	--select 'DEBUG �ൿġ����', @actiontime '���Žð���', getdate() '����ð�', @nActCount '�߰��ൿġ', @actioncount '�����ൿġ(�ð���)', @actionmax '�ൿġ�ƽ���', @dActTime '���Žð�'
	
	
	-----------------------------------------------
	--	������ ���׹̳� ���� �̿�Ⱓ�ΰ�?
	-----------------------------------------------		
	if(@actionfreedate >= getdate())
		begin
			--select 'DEBUG ��¥�� ���� ���� �ִ�.'
			set @actioncount = @actionmax
		end
	
	-----------------------------------------------
	--	���� �����ϱ�
	-----------------------------------------------		
	if(@actioncount > 0)
		begin
			--select 'DEBUG ������', * from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
			set
				actioncount		= @actioncount,			-- �ൿ�� ����
				actiontime		= @dActTime
			where gameid = @gameid_
			--select 'DEBUG ������', * from dbo.tUserMaster where gameid = @gameid_	
		end
		
	
	-----------------------------------------------
	--	���� �ൿġ ��庰 ����
	-----------------------------------------------		
	-- (���� �ൿġ ���Ӹ�带 �����ؼ� �ൿġ ��)				
	
	
	IF (@gmode_ in (@GAME_MODE_BATTLE) and @silverball < 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
			select @nResult_ rtn, 'ERROR �ǹ�����:' + str(@silverball)
		END
	ELSE IF (((@gmode_ = @GAME_MODE_TRAINING 
		or @gmode_ = @GAME_MODE_MACHINE 
		or @gmode_ = @GAME_MODE_MEMORISE 
		or @gmode_ = @GAME_MODE_SOUL) and @actioncount < @GAME_MODE_SINGLE_ACTION)
		or (@gmode_ = @GAME_MODE_BATTLE and @actioncount < @GAME_MODE_BATTLE_ACTION)
		or (@gmode_ = @GAME_MODE_SPRINT and @actioncount < @GAME_MODE_BATTLE_ACTION))
		BEGIN	
			set @nResult_ = @RESULT_ERROR_ACTION_LACK
			select @nResult_ rtn, 'ERROR �ൿġ����:' + str(@actioncount)
		END
	ELSE
		BEGIN	
			-- ��� �ڵ弼��
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS �ൿġ���:' + str(@actioncount)
			
			--�ൿġ -3����, ��Ʋ ����+1				
			--select 'DEBUG ��', actioncount, trainflag, machineflag, memorialflag, soulflag, bttotal, btflag, btflag2, bttem1chk, bttem2chk, bttem3chk, bttem4chk, bttem5chk, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, silverball from dbo.tUserMaster where gameid = @gameid_
			if(@gmode_ not in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
				begin
					--select ' DEBUG �̱� �ൿġ ����(-3), ������ > �̱��÷��� Ȱ��ȭ'
					
					update dbo.tUserMaster 
						set
						actioncount		= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_SINGLE_ACTION end,
						trainflag		= case @gmode_ when @GAME_MODE_TRAINING then @GAME_STATE_PLAYING else trainflag end,
						machineflag		= case @gmode_ when @GAME_MODE_MACHINE then @GAME_STATE_PLAYING else machineflag end,
						memorialflag	= case @gmode_ when @GAME_MODE_MEMORISE then @GAME_STATE_PLAYING else memorialflag end,
						soulflag		= case @gmode_ when @GAME_MODE_SOUL then @GAME_STATE_PLAYING else soulflag end
					where gameid = @gameid_
				end
			else
				begin
					--select ' DEBUG ��Ʋ �ൿġ ����(-5), ��Ʋ���� +1, ���Ӹ�� �÷��� GAME_STATE_END > GAME_STATE_PLAYING'
					if(@gmode_ in (@GAME_MODE_BATTLE))
						begin
							update dbo.tUserMaster 
								set
								actioncount	= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_BATTLE_ACTION end,
								bttotal	= bttotal + 1,
								btflag		= case @gmode_ when @GAME_MODE_BATTLE then @GAME_STATE_PLAYING else btflag end,
								bttem1chk = @bttem1chk_,
								bttem2chk = @bttem2chk_,
								bttem3chk = @bttem3chk_,
								bttem4chk = @bttem4chk_,
								bttem5chk = @bttem5chk_,
		
								bttem1cnt = @bttem1cnt,
								bttem2cnt = @bttem2cnt,
								bttem3cnt = @bttem3cnt,
								bttem4cnt = @bttem4cnt,
								bttem5cnt = @bttem5cnt,
								silverball = @silverball
							where gameid = @gameid_
						end
					else
						begin
							update dbo.tUserMaster 
								set
								actioncount	= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_BATTLE_ACTION end,
								bttotal		= bttotal + 1,
								btflag2		= case @gmode_ when @GAME_MODE_SPRINT then @GAME_STATE_PLAYING else btflag2 end
							where gameid = @gameid_
						end
					
					-- �������� üŷ�� �Ǿ� ������ ��밳���� ��������.
					if(@bttem1chk_ = 1 or @bttem2chk_ = 1 or @bttem3chk_ = 1 or @bttem4chk_ = 1 or @bttem5chk_ = 1)
						begin
							---------------------------------------------------
							-- ��Ż�α� ����ϱ�
							---------------------------------------------------
							declare @dateid varchar(8)
							set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
							if(exists(select top 1 * from dbo.tBattleItemUseTotal where dateid = @dateid))
								begin
									update dbo.tBattleItemUseTotal 
										set 
											bttem1cnt = bttem1cnt + @bttem1chk_, 
											bttem2cnt = bttem2cnt + @bttem2chk_, 
											bttem3cnt = bttem3cnt + @bttem3chk_, 
											bttem4cnt = bttem4cnt + @bttem4chk_, 
											bttem5cnt = bttem5cnt + @bttem5chk_,
											playcnt = playcnt + 1
									where dateid = @dateid
								end
							else
								begin
									insert into dbo.tBattleItemUseTotal(dateid, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, playcnt) 
									values(@dateid, @bttem1chk_, @bttem2chk_, @bttem3chk_, @bttem4chk_, @bttem5chk_, 1)
								end
						end
						
					
				end
			--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select 'DEBUG ��', actioncount, trainflag, machineflag, memorialflag, soulflag, bttotal, btflag, btflag2, bttem1chk, bttem2chk, bttem3chk, bttem4chk, bttem5chk, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, silverball from dbo.tUserMaster where gameid = @gameid_
			--if(���ӽ����̻��� != GAME_STATE_END)			
			--	�߰��� ������ �������Ƿ� �г�Ƽ ����? > �̱��� ������ ���� ����(������ �������)		

			--���Ӹ�� �÷��� GAME_STATE_END > GAME_STATE_PLAYING
			
			
			-----------------------------------------------------------------
			-- �÷��� ī���
			----------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market))
				begin
					insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 0, 1)
				end
			else
				begin
					update dbo.tStaticTime
						set
							playcnt = playcnt + 1
					where dateid10 = @dateid10 and market = @market 
				end
		END
	
	-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	select * from dbo.tUserMaster where gameid = @gameid_
	

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	--select @nResult_ rtn
End

