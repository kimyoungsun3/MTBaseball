---------------------------------------------------------------
/* 
gameid=xxx
itemcode=xxx

select * from dbo.tItemInfo
select * from dbo.tUserMaster where gameid = 'SangSang'
update dbo.tUserMaster set goldball = 1, silverball = 1 where gameid = 'SangSang'
update dbo.tUserMaster set goldball = 100000, silverball = 100000 where gameid = 'SangSang'

exec spu_ItemBuy 'SangSang', 54, 	'', 	-1		-- ��������		> ����
exec spu_ItemBuy 'SangSang', 50, 	'', 	-1		-- �󱼱���		> ����
exec spu_ItemBuy 'SangSang', 3200, 	'', 	-1		-- ��Ŀ��		> ����
exec spu_ItemBuy 'SangSang', 101, 	'', 	-1		-- �Ϲ��� �ǹ�����
exec spu_ItemBuy 'SangSang', 1, 	'', 	-1		-- �Ϲ��� ������
select * from dbo.tUserItem where gameid = 'SangSang' and itemcode in (0)
exec spu_ItemBuy 'SangSang', 0, 	'', 	-1		-- ĳ���Ϳ����� > �̹̺���

--select * from dbo.tUserItem where gameid = 'SangSang' order by idx desc
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (1, 51, 123, 223, 323, 52, 146, 246, 346, 53, 149, 249, 349)
exec spu_ItemBuy 'SangSang', 	'', 1, 		'', 	0, -1		-- ĳ���Ϳ����� > 
exec spu_ItemBuy 'SangSang', 	'', 2, 		'', 	0, -1		-- ĳ���Ϳ����� > 
exec spu_ItemBuy 'SangSang', 	'', 3, 		'', 	0, -1		-- ĳ���Ϳ����� > 
exec spu_ItemBuy 'Sangm', 		'', 3, 		'', 	0, -1		-- ĳ���Ϳ����� > 
exec spu_ItemBuy 'Sangm', 		'', 802, 	'', 	0, -1		-- ����(802)
exec spu_ItemBuy 'superfast', 	'', 3, 		'', 	0, -1		-- ĳ���Ϳ����� > 
exec spu_ItemBuy 'superfast', 	'', 802, 	'', 	0, -1		-- ����(802)

--select * from dbo.tItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01'
--select * from dbo.tItemBuyLog where gameid = 'SangSang' order by idx desc
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001)
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (102, 202, 302, 402, 502, 602, 702, 802, 5002)
exec spu_ItemBuy 'SangSang', '', 102, 	'', 	0,    -1		-- ����(102)
exec spu_ItemBuy 'SangSang', '', 202, 	'', 	0,    -1		-- ����(202)
exec spu_ItemBuy 'SangSang', '', 302, 	'', 	0,    -1		-- ����(302)
exec spu_ItemBuy 'SangSang', '', 402, 	'', 	0,    -1		-- ��Ʈ(402)
exec spu_ItemBuy 'SangSang', '', 502, 	'', 	0,    -1		-- �Ȱ�(502)
exec spu_ItemBuy 'SangSang', '', 602, 	'', 	0,    -1		-- ����(602)
exec spu_ItemBuy 'SangSang', '', 702, 	'', 	0,    -1		-- ����(702)
exec spu_ItemBuy 'SangSang', '', 802, 	'', 	0,    -1		-- ����(802)
exec spu_ItemBuy 'SangSang', '', 1200, 	'1.003',0,    -1		-- Ŀ���͸���¡(1200)
exec spu_ItemBuy 'SangSang', '', 5002, 	'', 	0,    -1		-- ��(5002)
exec spu_ItemBuy 'SangSang', '', 6000, 	'', 	0,    -1		-- ��Ʋ��(6000)
exec spu_ItemBuy 'SangSang', '', 6001, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6002, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6003, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6004, 	'', 	0,    -1

exec spu_ItemBuy 'SangSang', '', 101, 	'', 	0,    -1		-- ����(102)
exec spu_ItemBuy 'SangSang', '', 202, 	'', 	0,    -1		-- ����(202)
exec spu_ItemBuy 'SangSang', '', 301, 	'', 	0,    -1		-- ����(302)
exec spu_ItemBuy 'SangSang', '', 401, 	'', 	0,    -1		-- ��Ʈ(402)
exec spu_ItemBuy 'SangSang', '', 501, 	'', 	0,    -1		-- �Ȱ�(502)
exec spu_ItemBuy 'SangSang', '', 601, 	'', 	0,    -1		-- ����(602)
exec spu_ItemBuy 'SangSang', '', 701, 	'', 	0,    -1		-- ����(702)
exec spu_ItemBuy 'SangSang', '', 801, 	'', 	0,    -1		-- ����(802)
exec spu_ItemBuy 'SangSang', '', 1200, 	'1.003',0,    -1		-- Ŀ���͸���¡(1200)
exec spu_ItemBuy 'SangSang', '', 5001, 	'', 	0,    -1		-- ��(5002)
exec spu_ItemBuy 'SangSang', '', 6000, 	'', 	0,    -1		-- ��Ʋ��(6000)
exec spu_ItemBuy 'SangSang', '', 6001, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6002, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6003, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6004, 	'', 	0,    -1


--delete from dbo.tUserItem where gameid = 'guest74193' and itemcode in (101, 102, 103)
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						103, 	'', 	1,    -1	-- ��������
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '6171581y8p3m1s151744',	101, 	'', 	1,    -1	-- ��������
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						102, 	'', 	1,    -1	-- ��������
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						104, 	'', 	0,    -1	-- ����
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'


*/


IF OBJECT_ID ( 'dbo.spu_ItemBuy', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemBuy;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemBuy
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ������ ������(������������ ���)
	@itemcode_								int,							-- �������ڵ�
	@customize_								varchar(128),					-- Ŀ���͸�����
	@lvignore_								int,							-- ��������
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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- �ǸŹ���� �ٸ�
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102

	-- ��Ÿ ���ǰ�
	declare @ITEM_START_DAY						datetime		set @ITEM_START_DAY						= '2012-01-01'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'
	declare @ITEM_LV_IGNORE_NON					int				set @ITEM_LV_IGNORE_NON					= 0				-- ��������
	declare @ITEM_LV_IGNORE_YES					int				set @ITEM_LV_IGNORE_YES					= 1				-- ���������� ������


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid = @gameid_
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)

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
		declare @goldball		int,			@silverball		int,	
				@ccharacter		int,			@face			int,		@cap				int, 
				@cupper			int,			@cunder			int,		@bat				int, 
				@glasses		int,			@wing			int,		@tail				int,
				@pet			int,
				@stadium		int,
				@customize 		varchar(128)
		declare @expirestate	int,			@expiredate		datetime
		declare @itemkind		int,			@goldballPrice	int,		@silverballPrice	int,
				@itemperiod		int,			@sale			int,
				@param1			varchar(20),	@param2			varchar(20),
				@param3			varchar(20),	@param4			varchar(20),
				@param5			varchar(20),	@param6			varchar(20),
				@param7			varchar(20),	@param8			varchar(20),
				@itemname		varchar(256)
		declare @itemcount		int	
		declare @itemcount1		int				set @itemcount1 = 0
		declare @itemcount2		int				set @itemcount2 = 0
		declare @itemcount3		int				set @itemcount3 = 0
		declare @itemcount4		int				set @itemcount4 = 0
		declare @itemcount5		int				set @itemcount5 = 0
		declare @expiredate2	datetime
		declare @expireend		datetime		set @expireend = @ITEM_START_DAY
		declare @lv					int,
				@goldballPriceLV	int,
				@itemcodeLV			int
		


		------------------------------------------------
		-- ����(tUserMaster) > ���� �ǹ���, ��纼, ����Ʈ����
		-- select 'DEBUG (ó��)', * from dbo.tUserMaster where gameid = @gameid
		------------------------------------------------
		-- select * from dbo.tUserMaster where gameid = 'SangSang'
		------------------------------------------------
		if(@password_ = '')
			begin
				-- �н����� ���� ���
				select	@goldball = goldball,		@silverball = silverball,
						@ccharacter = ccharacter,	@face = face,				@cap = cap,
						@cupper = cupper,			@cunder	= cunder,			@bat = bat,
						@glasses = glasses,			@wing = wing,				@tail = tail,
						@pet = pet,
						@stadium = stadium,
						@customize = customize
				from dbo.tUserMaster where gameid = @gameid
			end
		else
			begin
				-- �н����尡 �ִ� ���
				select	@goldball = goldball,		@silverball = silverball,
						@ccharacter = ccharacter,	@face = face,				@cap = cap,
						@cupper = cupper,			@cunder	= cunder,			@bat = bat,
						@glasses = glasses,			@wing = wing,				@tail = tail,
						@pet = pet,
						@stadium = stadium,
						@customize = customize
				from dbo.tUserMaster where gameid = @gameid and password = @password_
			end
		
		
		
		
		------------------------------------------------
		-- ����������(tUserItem) > ���Ⱓ, �ı����
		------------------------------------------------
		-- select * from dbo.tUserItem where gameid = 'SangSang' and itemcode = 0
		------------------------------------------------
		select  @expirestate = expirestate, @expiredate = expiredate
		from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		if(isnull(@expiredate, @ITEM_START_DAY) != @ITEM_START_DAY)
			begin
		 		set @expireend = @expiredate
		 	end
		
		
		------------------------------------------------
		-- ������(tItemInfo) > ����, ����, ������, ���η�(2000 -> 1600)
		-- ������ �̹� ����� �����̴�.
		-- select * from dbo.tItemInfo where itemcode = 0
		------------------------------------------------
		select 
			@itemkind = kind, 			@itemcount = param1, 			@itemperiod = period,	
			@lv	= lv,
			@goldballPrice = goldball, 	@silverballPrice = silverball, 	
			@sale = sale,
			@itemname = itemname,
			@param1 = param1, 			@param2 = param2,				@param3 = param3,		
			@param4 = param4,			@param5 = param5, 				@param6 = param6,
			@param7 = param7,			@param8 = param8
		from dbo.tItemInfo where itemcode = @itemcode
		
		-- ������ ��������.
		if(@sale > 0 and @sale <= 100)
			begin
				if(@goldballPrice > 0)
					begin
						set @goldballPrice = @goldballPrice * (100 - @sale) / 100
					end
				else if(@silverballPrice > 0)
					begin
						set @silverballPrice = @silverballPrice * (100 - @sale) / 100
					end
			end
			
		------------------------------------------------------------
		-- ���� ���� �������� ���� ���� ���
		-- �������� �⺻���� ����ȴ�.
		-- > �ǹ������� �����Ѵ�.
		-- > ��� ������ �����ȴ�.
		------------------------------------------------------------
		set @goldballPriceLV = 0
		if(@lvignore_ = @ITEM_LV_IGNORE_YES)
			begin
				set @itemperiod = @ITEM_PERIOD_PERMANENT
				set @silverballPrice = 0			
				if(@lv < 10)
					begin
						set @goldballPriceLV 	= 20
						set @itemcodeLV			= 7005
					end
				else if(@lv < 20)
					begin
						set @goldballPriceLV 	= 30
						set @itemcodeLV			= 7006
					end
				else if(@lv < 35)
					begin
						set @goldballPriceLV 	= 50
						set @itemcodeLV			= 7007
					end
				else
					begin
						set @goldballPriceLV 	= 99
						set @itemcodeLV			= 7008
					end
			end
		else
			begin
				set @lvignore_ = @ITEM_LV_IGNORE_NON
			end
		

		--select 'DEBUG ',
		--	@goldball as 'gb', 				@silverball as 'sb', 			
		--	@ccharacter as 'cchar', 		@face as 'face',				@cap as 'cap',
		--	@cupper as 'cupper',			@cunder	as 'cunder',			@bat as 'bat',
		--	@glasses as 'glasses',			@wing as 'wing',				@tail as 'tail',
		--	@pet as 'pet', 					@stadium as 'stadium',
		--	@expirestate as '����', 		@expiredate as '������',
		--	@itemkind as '������', 			@goldballPrice as 'gbP', 		@silverballPrice as 'sbP',
		--	@itemperiod as 'period',
		--	@param1 as 'param1', 	 		@param2 as 'param2', 			@param3 as 'param3', 
		--	@param4 as 'param4', 			@param5 as 'param5',  			@param6 as 'param6', 
		--	@param7 as 'param7', 			@param8 as 'param8',
		--	@itemname as 'itemname'
		

		if isnull(@itemkind, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				set @comment = 'ERROR �������� ���� ����'
			END
		else if @itemkind in (@ITEM_KIND_FACE)
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOSALE_KIND
				set @comment = 'ERROR Face�� ������ �����Ҽ� ����'
			END
		else if @itemkind not in (@ITEM_KIND_CHARACTER, @ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET, @ITEM_KIND_BATTLEITEM, @ITEM_KIND_CUSTOMIZE)
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOSALE_KIND
				set @comment = 'ERROR �����Ǹ����� �ʴ� ������ kind:' + str(@itemkind)
			END
		else if (@silverballPrice > 0 and @silverballPrice > @silverball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
				set @comment = 'ERROR �ǹ������� �����ǹ�:' + ltrim(str(@silverball)) + ' �ǸŰ�:' + ltrim(str(@silverballPrice))
			END
		else if (@goldballPrice > 0 and @goldballPrice > @goldball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
				set @comment = 'ERROR ��纼���� �������:' + ltrim(str(@goldball)) + ' �ǸŰ�:' + ltrim(str(@goldballPrice))
			END
		else if (@goldballPriceLV > 0 and (@goldballPrice + @goldballPriceLV) > @goldball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
				set @comment = 'ERROR ��纼���� �������:' + ltrim(str(@goldball)) + ' �������ǸŰ�:' + ltrim(str(@goldballPriceLV))
			END
		else if (@itemperiod = @ITEM_PERIOD_PERMANENT and isnull(@expirestate, -444) != -444)
			BEGIN
				-- �������� and ���� ����
				set @nResult_ = @RESULT_ERROR_ITEM_PERMANENT_ALREADY
				set @comment = 'ERROR ���������� ������'
			END
		else if (@silverballPrice <= 0 and @goldballPrice <= 0 and @goldballPriceLV <= 0)
			BEGIN
				set @nResult_ = @RESULT_ERROR
				set @comment = 'ERROR �ǸŰ��� ���� �ǹ��� 0�� �ǸźҰ��Դϴ�.(�����ڹ���)'
			END
		else 	
			BEGIN
				------------------------------------------------------
				--	������ Ȯ���ؼ� �����صα�
				------------------------------------------------------
				set @nResult_ = @RESULT_SUCCESS	
				--select 'DEBUG ��', @silverball as 'silverball', @silverballPrice as 'sbp', @goldball as 'goldball', @goldballPrice as 'gbp'
				if (@silverballPrice > 0)
					begin
						set @silverball = @silverball - @silverballPrice
					end
				if (@goldballPrice > 0)
					begin
						set @goldball = @goldball - @goldballPrice
					end	
				if (@goldballPriceLV > 0)
					begin
						set @goldball = @goldball - @goldballPriceLV
					end	
					
				--select 'DEBUG ��', @silverball as 'silverball', @silverballPrice as 'sbp', @goldball as 'goldball', @goldballPrice as 'gbp'				
				
				
				-------------------------------------------------------
				-- �������� �Ҹ��ΰ�?
				-- 6000 ~ 6004(�Ҹ�)
				-- 201(����:7:����), 5000(������:-1:����)				
				-- declare @itemcode int	set @itemcode = 201	declare @gameid varchar(20)		set @gameid='SangSang'			
				-------------------------------------------------------
				if(@itemkind = @ITEM_KIND_CHARACTER)
					begin
						set @comment = 'SUCCESS ĳ���� ���󱸸�'
						-- �ϴܿ��� ĳ���� ��Ʈ���� ��������					
						set @ccharacter = @itemcode
						set @face = @param1
						set @cap = @param2
						set @cupper = @param3
						set @cunder = @param4
						--set @glasses = -1	 	2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--set @wing = -1		2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--set @tail = -1		2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--set @pet = -1			
						
						
						------------------------------------------------
						-- ���Խ� Ŀ���� ����¡ ������ �Է��Ѵ�.							
						------------------------------------------------
						insert into dbo.tUserCustomize(gameid, itemcode, customize)
						values(@gameid_, @ccharacter, @ITEM_CHAR_CUSTOMIZE_INIT)
						
						
						--select 'DEBUG ������ ���� ���̺� �� ��Ʈ�� ������ �Է�'
						-- ĳ���� ��Ʈ�� �����ϱ�, ����
						set @expiredate2 = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
						set @expireend = @expiredate2
						
						insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @ccharacter, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @face, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cap, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cupper, @expiredate2, @lvignore_)						
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cunder, @expiredate2, @lvignore_)
						
						--insert into tUserItem(gameid, itemcode, expiredate)
						--values(@gameid, @bat, @expiredate2)						
						--insert into tUserItem(gameid, itemcode, expiredate)
						--values(@gameid, @stadium, @expiredate2)
						
						-- �ϴܿ��� ���ŷα� ���

					end
				else if(@itemkind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
					begin
						
						if(@itemkind = @ITEM_KIND_CAP)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @cap = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_UPPER)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @cupper = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_UNDER)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @cunder = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_BAT)
							begin
								set @comment = 'SUCCESS ��Ʈ ����'
								set @bat = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_GLASSES)
							begin
								set @comment = 'SUCCESS �Ȱ� ����'
								set @glasses = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_WING)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @wing = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_TAIL)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @tail = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_STADIUM)
							begin
								set @comment = 'SUCCESS ��Ÿ�� ����'
								set @stadium = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_PET)
							begin
								set @comment = 'SUCCESS �� ����'
								set @pet = @itemcode
							end
						
						
						-- ���������� ���̺� ������ �������� �ľ�
						--select 'DEBUG ����'
						if(isnull(@expirestate, -444) = -444)
							begin
								set @comment = @comment + '(�űԱ���)'
								--select 'DEBUG �ű��Է�'
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select 'DEBUG �űԱⰣ(dd):' + str(@itemperiod)
										set @expireend = DATEADD(dd, @itemperiod, getdate())
										insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
										values(@gameid, @itemcode, @expireend, @lvignore_)
									end
								else
									begin
										--select 'DEBUG �űԿ���(yy):' + str(@itemperiod)
										set @expireend = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
										values(@gameid, @itemcode, @expireend, @lvignore_)
									end
							end
						else
							begin
								set @comment = @comment + '(�Ⱓ����)'
								--select 'DEBUG ������ > ��¥���׷��̵�'
								--select 'DEBUG ��', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG ������ > ��¥���Ⱓ(dd):' + str(@itemperiod)
										DECLARE @tItemExpire TABLE(
											expiredate datetime
										);
										
										update dbo.tUserItem
										set
											lvignore	= case when (@lvignore_ = @ITEM_LV_IGNORE_YES) then @ITEM_LV_IGNORE_YES else @ITEM_LV_IGNORE_NON end,
											expirestate = 0,											
											expiredate 	= case 
															when getdate() > expiredate then DATEADD(dd, @itemperiod, getdate())
															else DATEADD(dd, @itemperiod, expiredate)
														end
											OUTPUT INSERTED.expiredate into @tItemExpire
										where gameid = @gameid and itemcode = @itemcode	
										
										select @expireend = expiredate from @tItemExpire
									end
								--else
								--	begin
								--		--select '  > DEBUG ������ > ��¥���Ⱓ(yy):' + str(@itemperiod) + ' > �ǹ̾��� �н�'
								--		-- �ǹ̰� ��� �н�
								--	end
								--select 'DEBUG ��', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
							end	
					end
				else if(@itemkind = @ITEM_KIND_BATTLEITEM)
					begin
						set @comment = 'SUCCESS ��Ʋ �Ҹ� ������ ��������'
						
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

					end
				else if(@itemkind = @ITEM_KIND_CUSTOMIZE)
					begin
						set @comment = 'SUCCESS Ŀ���͸���¡�� �����߽��ϴ�.'
						set @customize = @customize_

						------------------------------------------------
						-- ���Խ� Ŀ���� ����¡ ������ ����						
						------------------------------------------------						
						update dbo.tUserCustomize
							set
								customize = @customize_
						where gameid = @gameid and itemcode = @ccharacter
					end
				else 
					begin
						set @nResult_ = @RESULT_ERROR
						set @comment = 'ERROR �����۱��� �˼����� ����'
					end
			END
	END
	
	
	
	---------------------------------------
	-- ���� ������ ���� �ݿ�
	---------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @expireend expireend
			
			---------------------------------------------------------
			-- �����������
			---------------------------------------------------------
			--select 'DEBUG (��)', @goldball 'goldball', @silverball 'silverball', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium',  @itemcount1 'itemcount1', @itemcount2 'itemcount2', @itemcount3 'itemcount3', @itemcount4 'itemcount4', @itemcount5 'itemcount5'
			
			update dbo.tUserMaster
			set
				goldball 	= @goldball,	silverball 	= @silverball,
				ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
				pet 		= @pet,			
				stadium		= @stadium,
				customize	= @customize,
				bttem1cnt = bttem1cnt + @itemcount1,
				bttem2cnt = bttem2cnt + @itemcount2,
				bttem3cnt = bttem3cnt + @itemcount3,
				bttem4cnt = bttem4cnt + @itemcount4,
				bttem5cnt = bttem5cnt + @itemcount5
			where gameid = @gameid
			--select 'DEBUG (��)', goldball, silverball, ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, pet, stadium,  bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- ���ŷα� ���
			---------------------------------------------------------
			--insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) values('SangSang45', 1, 0, 91)
			--select 'DEBUG ���ŷα� ���'
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldballPrice, @silverballPrice) 
			
			
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball 	= goldball + @goldballPrice + @goldballPriceLV, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice + @goldballPriceLV, @silverballPrice, 1)
				end
				
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�2 Master
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyLogTotalMaster where dateid = @dateid))
				begin
					update dbo.tItemBuyLogTotalMaster 
						set 
							goldball 	= goldball + @goldballPrice + @goldballPriceLV, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalMaster(dateid, goldball, silverball, cnt)
					values(@dateid, @goldballPrice + @goldballPriceLV, @silverballPrice, 1)
				end
				
				
			---------------------------------------------------------
			-- �������� ���ŷα� ���
			---------------------------------------------------------
			if(@lvignore_ = @ITEM_LV_IGNORE_YES)
				begin
					insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
					values(@gameid, @itemcodeLV, @goldballPriceLV, 0) 
										
					---------------------------------------------------------
					-- �������� > ���θ�ǿ� ����ϱ�
					---------------------------------------------------------
					if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcodeLV))
						begin
							update dbo.tItemBuyPromotionTotal 
								set 
									goldball = goldball + @goldballPriceLV,
									cnt = cnt + 1
							where dateid = @dateid and itemcode = @itemcodeLV
						end
					else
						begin
							insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
							values(@dateid, @itemcodeLV, @goldballPriceLV, 1)
						end
					
				end

		end
	else
		begin
			select @nResult_ rtn, @comment, @expireend expireend
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select * from dbo.tUserMaster where gameid = @gameid
			--select 'DEBUG (�Ϸ�)', * from dbo.tUserMaster where gameid = @gameid
		end
	set nocount off
End

