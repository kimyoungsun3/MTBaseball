/*
gameid=xxx

-- ����, ����Ÿ��, ��� ���� ����
update dbo.tUserMaster set bttem1cnt = 0, bttem2cnt = 0, bttem3cnt = 0, bttem4cnt = 0, bttem5cnt = 0  where gameid = 'SangSang'
update dbo.tUserMaster set coin = 0, goldball = 0, silverball = 0, coindate = '2014-08-12 12:00:00' where gameid = 'SangSang'
exec spu_Roulette 'SangSang', '7575970askeie1595312', -1

-- ���� = 1
declare @val int set @val = 0 while @val < 10 begin
	update dbo.tUserMaster set coin = 1, goldball = 10, silverball = 0, coindate = '2014-08-12 12:00:00' where gameid = 'SangSang'
	exec spu_Roulette 'SangSang', '7575970askeie1595312', -1
	set @val = @val + 1 
end

-- ���� = 0, ����Ÿ�� = 1 > coin
update dbo.tUserMaster set coin = 0, goldball = 0, silverball = 0, coindate = '2010-08-12 12:00:00' where gameid = 'SangSang'
exec spu_Roulette 'SangSang', '7575970askeie1595312', -1

-- ��尡 2�̻�
declare @val int set @val = 0 while @val < 30 begin
	update dbo.tUserMaster set coin = 0, goldball = 100, silverball = 0, coindate = '2014-08-12 12:00:00' where gameid = 'SangSang'
	exec spu_Roulette 'SangSang', '7575970askeie1595312', -1
	set @val = @val + 1 
end

declare @val int set @val = 0 while @val < 3000 begin
	exec spu_Roulette 'guest74134', '2608869z3l0f4r484841', -1
	set @val = @val + 1 
end
select coindate from dbo.tUserMaster where gameid = 'guest74134'
update dbo.tUserMaster set coindate = getdate() - 1 where gameid = 'guest74134'

*/

IF OBJECT_ID ( 'dbo.spu_Roulette', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Roulette;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------ 
create procedure dbo.spu_Roulette
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- �������� �̹� �����߽��ϴ�.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--��ü����Ұ���

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------	
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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE				= 22		-- �ǸŹ���� �ٸ�
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102
	
	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- �������� �����ΰ� ���� ���.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;

	declare @COIN_GOLDBALL_CUSTOME				int				set @COIN_GOLDBALL_CUSTOME				= 2
	
	-- Ÿ���� ����
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)
	
	-- Open Event
	--declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-01-17'	-- 1.16�ϱ���
	--declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	--declare @GOLDBALLGIVE_OPEN_EVENT01	int				set @GOLDBALLGIVE_OPEN_EVENT01		= 1
	--declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	--declare @COINGIVE_OPEN_EVENT01		int				set @COINGIVE_OPEN_EVENT01			= 3
	--
	--declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-01-21'	-- 1.20�ϱ���
	--declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	--declare @GOLDBALLGIVE_OPEN_EVENT01		int				set @GOLDBALLGIVE_OPEN_EVENT01	= 1
	--declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	--declare @COINGIVE_OPEN_EVENT01			int				set @COINGIVE_OPEN_EVENT01		= 10
	-- SKT ��õ���� ~ 2013-01-30
	declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-02-04'	-- 1.30�ϱ���
	declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	declare @GOLDBALLGIVE_OPEN_EVENT01		int				set @GOLDBALLGIVE_OPEN_EVENT01		= 1
	declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	declare @COINGIVE_OPEN_EVENT01			int				set @COINGIVE_OPEN_EVENT01			= 3

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid = @gameid_
	declare @comment		varchar(80)
	declare @coinresult		int				set @coinresult = -1
	declare @coinvalue		int				set @coinvalue = 0

	declare @coin			int
	declare @coindate		datetime
	declare @goldball		int
	declare @silverball		int
	declare @itemcode		int				set @itemcode = -1
	declare @rand			int
	declare @bttem1cnt		int
	declare @bttem2cnt		int
	declare @bttem3cnt		int
	declare @bttem4cnt		int
	declare @bttem5cnt		int
	declare @period 		int
	declare @upgradestate2	int 			set @upgradestate2	= 0
	
	--�α׿� ����
	declare @logdateid 		varchar(8)		set @logdateid			= Convert(varchar(8),Getdate(),112)		-- 20120819
	declare @loggoldball	int				set @loggoldball		= 0
	declare @logsilverball 	int				set @logsilverball		= 0
	declare @logitemcode	int				set @logitemcode		= -1
	declare @logitemcodecnt int				set @logitemcodecnt		= 0
	declare @logcomment		varchar(128)		
	declare @logitemname	varchar(40)
	
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �˼����� ����(-1)'
	


	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	--���� ������ �о����
	select 
		@coin = coin, 				@coindate = coindate, 
		@goldball = goldball, 		@silverball = silverball,
		@bttem1cnt = bttem1cnt, 	@bttem2cnt = bttem2cnt,
		@bttem3cnt = bttem3cnt, 	@bttem4cnt = bttem4cnt,
		@bttem5cnt = bttem5cnt
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @coin 'coin', @coindate 'coindate', @goldball 'goldball', @silverball 'silverball'



	-----------------------------------------------
	--	�������� > �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)
	-----------------------------------------------
	declare @nCointPerMin bigint,
			@nCoinCount int,
			@nCoinGive int
	set @nCointPerMin = @LOOP_TIME_COIN
	set @nCoinCount = datediff(s, @coindate, getdate())/@nCointPerMin
	set @coindate = DATEADD(s, @nCoinCount*@nCointPerMin, @coindate)
	set @nCoinGive = @COINGIVE_NORMAL
	if(getdate() < @OPEN_EVENT01_END)
		begin
			set @nCoinGive = @COINGIVE_OPEN_EVENT01
		end
		
	if(@coin < @nCoinGive)
		begin
			--------------------------------
			-- ������ ���� ����
			--------------------------------
			set @coin = @coin + case when @nCoinCount > 0 then @nCoinGive else 0 end
			set @coin = case when @coin > @nCoinGive then @nCoinGive when @coin < 0 then 0 else @coin end
		end
	--else
	--	begin
	--		--------------------------------------
	--		-- ������Ʈ�� �߰�ȹ��� ���� > �״�� ����
	--		--------------------------------------
	--	end
	--select 'DEBUG ����(��)', @coin 'coin', @coindate 'coindate', @goldball 'goldball', @silverball 'silverball'
	
	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if isnull(@coin, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR
			set @comment = 'ERROR �˼����� ����(-2)'
		END
	else if (@coin <= 0 and @goldball < 2)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��纼�� ����'
		END
	else if (@coin > 0)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���μҺ� > �ǹ�, ��Ʋ���� ȹ��'
			
			-------------------------------------------
			-- @��������, +�ǹ�, ��Ʋ�� ����
			-- [�ý��� ��ȹ��]
			-------------------------------------------
			set @coin = @coin - 1
			
			--�����ڵ尪
			set @rand = Convert(int, ceiling(RAND() * 100))
			if(@rand <= 40)
				begin
					set @coinvalue	= 50
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
				end
			else if(@rand <= 60)
				begin
					set @coinvalue	= 100
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
				end
			else if(@rand <= 65)
				begin
					set @coinvalue	= 200
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
				end
			else if(@rand <= 66)
				begin
					set @coinvalue	 = 500
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
				end
			else if(@rand <= 73)
				begin
					set @coinvalue	= 1
					set @coinresult = @COIN_RESULT_BATTLE_ITEM1
					set @bttem1cnt = @bttem1cnt + @coinvalue
				end
			else if(@rand <= 80)
				begin
					set @coinvalue = 1
					set @coinresult = @COIN_RESULT_BATTLE_ITEM2
					set @bttem2cnt = @bttem2cnt + @coinvalue
				end
			else if(@rand <= 87)
				begin
					set @coinvalue = 1
					set @coinresult = @COIN_RESULT_BATTLE_ITEM3
					set @bttem3cnt = @bttem3cnt + @coinvalue
				end
			else if(@rand <= 94)
				begin
					set @coinvalue = 1
					set @coinresult = @COIN_RESULT_BATTLE_ITEM4
					set @bttem4cnt = @bttem4cnt + @coinvalue
				end
			else if(@rand <= 100)
				begin
					set @coinvalue = 1
					set @coinresult = @COIN_RESULT_BATTLE_ITEM5
					set @bttem5cnt = @bttem5cnt + @coinvalue
				end
			else
				begin
					set @coinvalue	= 50
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
				end
		END
	else if (@goldball >= 2)
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��纼�Һ� > �ǹ�, ��Ʋ, ��Ʈ���� ȹ��'

			-------------------------------------------
			-- @��������, +�ǹ�, ��Ʈ��, ��Ʋ������
			-- [�ý��� ��ȹ��]
			-------------------------------------------
			set @goldball = @goldball - @COIN_GOLDBALL_CUSTOME
			set @coinvalue = 1
			set @coinresult = @COIN_RESULT_PERIOD_ITEM
			
			set @loggoldball = @COIN_GOLDBALL_CUSTOME

			--�����ڵ尪
			set @rand = Convert(int, ceiling(RAND() * 1000))
			if(@rand <= 500)
				begin
					set @coinvalue	= 200*2
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
					
					set @logsilverball 	= @coinvalue
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ' + ltrim(rtrim(str(@coinvalue))) + ' �ǹ��� ȯ��'
				end
			else if(@rand <= 650)
				begin
					set @coinvalue	= 500*2
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
					
					set @logsilverball 	= @coinvalue
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ' + ltrim(rtrim(str(@coinvalue))) + ' �ǹ��� ȯ��'
				end
			else if(@rand <= 720)						--��Ʋ�� ���ޱ���	
				begin
					set @coinvalue	= 3*2
					set @coinresult = @COIN_RESULT_BATTLE_ITEM1
					set @bttem1cnt = @bttem1cnt + @coinvalue
					
					set @logitemcode 	= 6000
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ��Ʋ[����] ' + ltrim(rtrim(str(@coinvalue))) + '�� ȯ��'
				end
			else if(@rand <= 780)
				begin
					set @coinvalue = 3*2
					set @coinresult = @COIN_RESULT_BATTLE_ITEM2
					set @bttem2cnt = @bttem2cnt + @coinvalue
					
					set @logitemcode 	= 6001
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ��Ʋ[������] ' + ltrim(rtrim(str(@coinvalue))) + '�� ȯ��'
				end
			else if(@rand <= 840)
				begin
					set @coinvalue = 3*2
					set @coinresult = @COIN_RESULT_BATTLE_ITEM3
					set @bttem3cnt = @bttem3cnt + @coinvalue
					
					set @logitemcode 	= 6002
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ��Ʋ[���ݰ�ȭ] ' + ltrim(rtrim(str(@coinvalue))) + '�� ȯ��'
				end
			else if(@rand <= 890)
				begin
					set @coinvalue = 3*2
					set @coinresult = @COIN_RESULT_BATTLE_ITEM4
					set @bttem4cnt = @bttem4cnt + @coinvalue
					
					set @logitemcode 	= 6003
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ��Ʋ[��Ȯ��] ' + ltrim(rtrim(str(@coinvalue))) + '�� ȯ��'
				end
			else if(@rand <= 940)
				begin
					set @coinvalue = 100
					set @coinresult = @COIN_RESULT_BATTLE_ITEM5
					set @bttem5cnt = @bttem5cnt + @coinvalue
					
					set @logitemcode 	= 6004
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ��Ʋ[�ڵ�Ÿ��] ' + ltrim(rtrim(str(@coinvalue))) + '�� ȯ��'
				end
			else if(@rand <= 1000)
				begin
					declare @branch int
					set @branch = 0
					if(@rand <= 950)
						begin
							set @branch = 0
						end
					else if(@rand <= 960)
						begin
							set @branch = 1
						end
					else if(@rand <= 970)
						begin
							set @branch = 2
						end
					else if(@rand <= 977)
						begin
							set @branch = 3
						end
					else if(@rand <= 984)
						begin
							set @branch = 4
						end
					else if(@rand <= 991)
						begin
							set @branch = 5
						end
					else if(@rand <= 994)
						begin
							set @branch = 6
						end
					else if(@rand <= 997)
						begin
							set @branch = 7
						end
					else if(@rand <= 998)
						begin
							-- Ư���� ���� �������� ����
							set @branch = 1000
						end
					else
						begin
							set @branch = 100
						end
						
					----------------------------------------------------------------------
					--	ĳ����, �Ϲ��� ������ ����
					----------------------------------------------------------------------
					if(@branch = 1000)
						begin
							-- Ư���� ĳ������ ����
							select top 1 @itemcode = itemcode, @logitemname = itemname from dbo.tItemInfo 
							where kind = @ITEM_KIND_BAT
							and goldball > 0 and goldball < 500
							and sex = 255										
							and itemcode not in (
								153, 154, 156, 157, 161, 162, 163, 164,
								253, 254, 256, 257, 261, 262, 263, 264,
								353, 354, 356, 357, 361, 362, 363, 364, 
								455, 456, 457, 458, 459, 460, 461, 462)
							order by newid()
							
						end
					else
						begin
							-- �Ϲ� ������� ����
							select top 1 @itemcode = itemcode, @logitemname = itemname from dbo.tItemInfo 
							where kind = @ITEM_KIND_BAT
							and silverball > 0 and silverball < (2000 + 500*@branch)
							and sex = 255			--and sex != 0
							and itemcode not in (
								153, 154, 156, 157, 161, 162, 163, 164,
								253, 254, 256, 257, 261, 262, 263, 264,
								353, 354, 356, 357, 361, 362, 363, 364, 
								455, 456, 457, 458, 459, 460, 461, 462)
							order by newid()
						end
					
					 
					set @logitemcode 	= @itemcode
					set @logitemcodecnt = 1
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ������[' + @logitemname + '] 1�� ȯ��'	
					
					----------------------------------
					-- ��ȭ�� ���� Ȯ��
					----------------------------------
					set @rand = Convert(int, ceiling(RAND() * 100))
					if(@rand <= 80)
						begin
							set @upgradestate2	= ( 0 + Convert(int, ceiling(RAND() *  3)) - 1)
						end
					else if(@rand <= 95)
						begin
							set @upgradestate2	= ( 2 + Convert(int, ceiling(RAND() *  3)) - 1)
						end
					else
						begin
							set @upgradestate2	= ( 4 + Convert(int, ceiling(RAND() *  3)) - 1)
						end
						
						
					if(@upgradestate2 > 0)
						begin
							set @logcomment = @logcomment + ' ' + ltrim(rtrim(str(@upgradestate2))) + '��ȭ��'
						end		
				end
			else
				begin
					set @coinvalue	= 200
					set @coinresult = @COIN_RESULT_SILVER_ITEM
					set @silverball = @silverball + @coinvalue
					
					set @logsilverball 	= @coinvalue
					set @logcomment		= ltrim(rtrim(str(@loggoldball))) + '��� -> ' + ltrim(rtrim(str(@coinvalue))) + ' �ǹ��� ȯ��'
				end

		end
		

	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @coinresult 'coinresult', @coinvalue 'coinvalue', @itemcode 'itemcode', @upgradestate2 upgradestate2
			
			---------------------------------------------------------
			-- �����������
			---------------------------------------------------------
			--select 'DEBUG (��)', coin, coindate, goldball, silverball, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			update dbo.tUserMaster
			set
				coin			= @coin,				-- ���� ����
				coindate		= @coindate,
				goldball		= @goldball,
				silverball		= @silverball,
				bttem1cnt 		= @bttem1cnt, 	
				bttem2cnt 		= @bttem2cnt,
				bttem3cnt 		= @bttem3cnt, 	
				bttem4cnt 		= @bttem4cnt,
				bttem5cnt 		= @bttem5cnt
			where gameid = @gameid
			
			--select 'DEBUG (��)', coin, coindate, goldball, silverball, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- ������ ������ ó���Ѵ�.
			---------------------------------------------------------
			if(@itemcode != -1)
				begin
					--select 'DEBUG �������޵�' + str(@itemcode)
					select @period = period from dbo.tItemInfo where itemcode = @itemcode
					
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
					values(@gameid , @itemcode, '�귿����', @period, @upgradestate2)
					
				end
			
			---------------------------------------------------------
			-- �α� ����ϱ�
			---------------------------------------------------------	
			if(@loggoldball = @COIN_GOLDBALL_CUSTOME)
				begin
					-- ������
					if(exists(select top 1 * from dbo.tRouletteLogTotalMaster where dateid = @logdateid and goldballkind = @COIN_GOLDBALL_CUSTOME))
						begin
							update dbo.tRouletteLogTotalMaster 
								set 
									goldball = goldball + @loggoldball, 
									silverball = silverball + @logsilverball, 
									itemcodecnt = itemcodecnt + @logitemcodecnt,
									cnt = cnt + 1
							 where dateid = @logdateid and goldballkind = @COIN_GOLDBALL_CUSTOME
						end
					else
						begin
							insert into dbo.tRouletteLogTotalMaster(dateid, goldball, silverball, itemcodecnt, cnt, goldballkind) 
							values(@logdateid, @loggoldball, @logsilverball, @logitemcodecnt, 1, @COIN_GOLDBALL_CUSTOME)
						end
						
					-- ����
					if(exists(select top 1 * from dbo.tRouletteLogTotalSub where dateid = @logdateid and silverball = @logsilverball and itemcode = @logitemcode and goldballkind = @COIN_GOLDBALL_CUSTOME))
						begin
							update dbo.tRouletteLogTotalSub 
								set 
									goldball = goldball + @loggoldball, 
									cnt = cnt + 1
							 where dateid = @logdateid and silverball = @logsilverball and itemcode = @logitemcode and goldballkind = @COIN_GOLDBALL_CUSTOME
						end
					else
						begin
							insert into dbo.tRouletteLogTotalSub(dateid, goldball, silverball, itemcode, cnt, comment, goldballkind)  
							values(@logdateid, @loggoldball, @logsilverball, @logitemcode, 1, @logcomment, @COIN_GOLDBALL_CUSTOME)
						end
						
					-- ����
					insert into dbo.tRouletteLogPerson(gameid, goldball, silverball, itemcode, comment)  
					values(@gameid_, @loggoldball, @logsilverball,  @logitemcode, @logcomment)
				end
			
			 
			 
		end
	else
		begin 
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @coinresult 'coinresult', @coinvalue 'coinvalue', @itemcode 'itemcode', @upgradestate2 upgradestate2
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	if(@itemcode != -1)
		begin
			------------------------------------------------
			--	4-3. ��������Ʈ
			------------------------------------------------
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList where gameid = @gameid and gainstate = 0 
			order by idx desc
		end
	
	set nocount off
End

