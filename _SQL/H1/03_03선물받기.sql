---------------------------------------------------------------
/* 
[�����ޱ�]
idx=1
--��������Ʈ
select a.idx idx2, gameid, gainstate, gaindate, giftid, giftdate, a.period2, b.* from 
	(select top 20 * from dbo.tGiftList order by giftdate desc) a  
	INNER JOIN 
	dbo.tItemInfo b 
	ON a.itemcode = b.itemcode 


update dbo.tGiftList set gainstate = 0 where idx in(16, 17, 18, 19, 20, 21)
exec spu_GiftGain 16, 1		-- �Ⱓ��(7��)
exec spu_GiftGain 16, 1		-- �̹� �����Ѱ�
exec spu_GiftGain 1000, 1	-- �������� �ʴ°�
exec spu_GiftGain 17, 1		-- �Ⱓ��(7��)+a
exec spu_GiftGain 18, 1		-- �Ⱓ��(����)
exec spu_GiftGain 19, 1		-- �Ⱓ��(����)
exec spu_GiftGain 20, 1		-- �Ҹ���(��Ʋ)
exec spu_GiftGain 21, 1		-- �Ҹ���(��Ʋ)

exec spu_GiftGain 3917, 1	

select gameid, goldball, silverball from dbo.tUserMaster where gameid = 'superman'
exec spu_GiftGain 43139, 1	-- ���ϱ�(5���)(9300)
exec spu_GiftGain 43138, 1	-- ���ϱ�(500�ǹ�)(9200)
exec spu_GiftGain 43142, 1	-- �ڵ�Ÿ�� 3(6004)
*/

IF OBJECT_ID ( 'dbo.spu_GiftGain', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GiftGain;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GiftGain
	@idx_									int,							-- �����ε���
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
	
	-- ��������Ʈ�̸�
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- �Ǹ��۾ƴ�
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- �ǸŹ���� �ٸ�
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	--declare @DAY_PLUS_TIME						bigint			set @DAY_PLUS_TIME 						= 24*60*60

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
	

	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	--- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			--- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�
	
    
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	BEGIN
		-- declare @idx_ int set @idx_ = 1
		declare @comment		varchar(80)
		declare @plussb 		int 		set @plussb = 0
		declare @plusgb 		int 		set @plusgb = 0
		declare @silverball		int
		declare @goldball		int
		declare @gameid			varchar(20),
				@itemcode		int,
				@gainstate		int,
				@period2		int,
				@upgradestate2	int
		declare @nparam1		int			set @nparam1	= 0
		declare @nparam2		int			set @nparam2	= 0
		
		-- ������ ����
		select @gameid = gameid, @itemcode = itemcode , @gainstate = gainstate, @period2 = period2, @upgradestate2 = upgradestate2 from dbo.tGiftList where idx = @idx_
		
		-- ���� ���� �о����
		select 
			@silverball = silverball,
			@goldball = goldball
		from dbo.tUserMaster where gameid = @gameid
		

		if isnull(@itemcode, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
				set @comment = 'ERROR ���������� ������ü�� ����'
			END
		else if @gainstate = @GAINSTATE_YES
			BEGIN
				set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
				set @comment = 'ERROR �������� �̹� �����߽��ϴ�.' 
			END
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				set @comment = 'SUCCESS ���� ���� ó���մϴ�.'

				-- �������� �Ҹ��ΰ�?
				-- select * from dbo.tUserItem where gameid = 'SangSang' order by idx desc
				-- 6000 ~ 6004(�Ҹ�)
				-- 201(����:7:����), 5000(������:-1:����)
				-- declare @itemcode int	set @itemcode = 201	declare @gameid varchar(20)		set @gameid='SangSang'
				declare @itemkind	int
				declare @itemcount	int		
				declare @itemperiod int
				declare @itemupgrade int
				declare @itemcount1	int		set @itemcount1 = 0
				declare @itemcount2	int		set @itemcount2 = 0
				declare @itemcount3	int		set @itemcount3 = 0
				declare @itemcount4	int		set @itemcount4 = 0
				declare @itemcount5	int		set @itemcount5 = 0

				---------------------------------------------
				-- ������ �Ⱓ�� ���� �����.
				---------------------------------------------
				--select @itemkind = kind, @itemcount = param1, @itemperiod = period from dbo.tItemInfo where itemcode = @itemcode
				select 
					@itemkind = kind, 
					@itemcount = param1
				from dbo.tItemInfo where itemcode = @itemcode				
				
				set @itemperiod = @period2
				set @itemupgrade = @upgradestate2
				
				
				if(@itemkind not in(@ITEM_KIND_BATTLEITEM, @ITEM_KIND_SYSTEMETC, @ITEM_KIND_PETREWARD, @ITEM_KIND_GIFTGOLDBALL, @ITEM_KIND_CONGRATULATE_BALL))
					begin
						-- ���������� ���̺� ������ �������� �ľ�
						--select 'DEBUG ����'
						if not exists(select * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode)
							begin
								------------------------------------------------------
								-- 20�� �̻��̸� ���������� �ٲ��.
								------------------------------------------------------
								if(@itemupgrade >= 20)
									begin
										set @itemperiod = @ITEM_PERIOD_PERMANENT
									end
							
								------------------------------------------------------
								--select ' > DEBUG �ű��Է�'
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG �űԱⰣ(dd):' + str(@itemperiod)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, upgradestate)
										values(@gameid, @itemcode, DATEADD(dd, @itemperiod, getdate()), @itemupgrade)
									end
								else
									begin
										--select '  > DEBUG �űԿ���(yy):' + str(@itemperiod)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, upgradestate)
										values(@gameid, @itemcode, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY), @itemupgrade)
									end
							end
						else
							begin
								--select ' > DEBUG ������ > ��¥���׷��̵�'
								--select ' DEBUG ��', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG ������ > ��¥���Ⱓ(dd):' + str(@itemperiod)
										update dbo.tUserItem
											set
										expirestate = 0,
										expiredate = case 
														when @itemupgrade >= 20 		then DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
														when getdate() > expiredate 	then DATEADD(dd, @itemperiod, getdate())
														else DATEADD(dd, @itemperiod, expiredate)
													end,
										upgradestate = case
														when @itemupgrade > upgradestate then @itemupgrade
														else upgradestate
													end
										where gameid = @gameid and itemcode = @itemcode										
									end
								--else
								--	begin
								--		--select '  > DEBUG ������ > ��¥���Ⱓ(yy):' + str(@itemperiod) + ' > �ǹ̾��� �н�'
								--		-- �ǹ̰� ��� �н�
								--	end
								--select ' DEBUG ��', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
							end	
					end
				else if(@itemkind = @ITEM_KIND_PETREWARD)
					begin
						set @plussb = isnull(@itemcount, 0)
						
						if(@plussb < 0)
							begin 
								set @plussb = 20
							end
						else if(@plussb > 80)
							begin 
								set @plussb = 80
							end
						
						set @silverball = @silverball + @plussb
							
						update dbo.tUserMaster
						set
							silverball = @silverball 
						where gameid = @gameid
					end
				else if(@itemkind = @ITEM_KIND_GIFTGOLDBALL)
					begin
						set @plusgb = isnull(@itemcount, 0)
						
						if(@plusgb < 0)
							begin 
								set @plusgb = 20
							end
						else if(@plusgb > 1320)
							begin 
								set @plusgb = 1320
							end
						set @goldball = @goldball + @plusgb
							
						update dbo.tUserMaster
						set
							goldball = @goldball
						where gameid = @gameid
					end
				else if(@itemkind = @ITEM_KIND_CONGRATULATE_BALL)
					begin
						------------------------------------
						-- ���ϱ�(�ǹ�)
						-- ����Ÿ�� �������̶� ���������� ��ȯ�ϴ� �κи� �ʿ��ؼ� ���⼭ �޴´�.
						------------------------------------
						select 
							@nparam1 = param1, 	
							@nparam2 = param2
						from dbo.tItemInfo where itemcode = @itemcode
						
						------------------------------------
						-- ���ϱ�(�ǹ�)
						------------------------------------
						set @plussb = isnull(@nparam1, 0)						
						if(@plussb < 0)
							begin 
								set @plussb = 0
							end
						else if(@plussb > 30000)
							begin 
								set @plussb = 30000
							end
						set @silverball = @silverball + @plussb
							
						------------------------------------
						-- ���ϱ�(���)
						------------------------------------
						set @plusgb = isnull(@nparam2, 0)
						if(@plusgb < 0)
							begin 
								set @plusgb = 0
							end
						else if(@plusgb > 500)
							begin 
								set @plusgb = 500
							end
						set @goldball = @goldball + @plusgb
							
						update dbo.tUserMaster
						set
							silverball = @silverball,
							goldball = @goldball
						where gameid = @gameid
					end
				else
					begin
						-- declare @itemcode int set @itemcode = 6000
						if(@itemcode = 6000)
							begin
								set @itemcount1 = @itemcount
							end
						else if(@itemcode = 6001)
							begin
								set @itemcount2 = @itemcount
							end
						else if(@itemcode = 6002)
							begin
								set @itemcount3 = @itemcount
							end
						else if(@itemcode = 6003)
							begin
								set @itemcount4 = @itemcount
							end
						else if(@itemcode = 6004)
							begin
								set @itemcount5 = @itemcount
							end
			
						--select 'DEBUG ��Ʋ �Ҹ�', @itemcount1, @itemcount2, @itemcount3, @itemcount4, @itemcount5

						update dbo.tUserMaster
						set
							bttem1cnt = bttem1cnt + @itemcount1,
							bttem2cnt = bttem2cnt + @itemcount2,
							bttem3cnt = bttem3cnt + @itemcount3,
							bttem4cnt = bttem4cnt + @itemcount4,
							bttem5cnt = bttem5cnt + @itemcount5
						where gameid = @gameid
						--select 'DEBUG ��Ʋ �Ҹ�', bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
					end

				-- ������ ������ ���·� �����д�.
				update dbo.tGiftList 
				set 
					gainstate = @GAINSTATE_YES,
					gaindate = getdate()
				where idx = @idx_
			END
	END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, * from dbo.tUserMaster where gameid = @gameid
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @silverball silverball, @goldball goldball, 0 bttem1cnt, 0 bttem2cnt, 0 bttem3cnt, 0 bttem4cnt, 0 bttem5cnt
		end
	
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- ���� ���� ������ ����	
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select itemcode, convert(varchar(19), expiredate, 20) as expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			select itemcode, expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			from dbo.tUserItem where gameid = @gameid and expirestate = @ITEM_EXPIRE_STATE_NO
		
			-- ���� ��ȭ�� �̺��� ������(��ȭǥ�ÿ� ����ϱ� ���ؼ�)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select itemcode, upgradestate from dbo.tUserItem where gameid = @gameid and expirestate = @ITEM_EXPIRE_STATE_YES and upgradestate > 0
			
			
			-- ���� ����Ʈ ����
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid and gainstate = @GAINSTATE_NON 
			order by idx desc
		
		end
End

