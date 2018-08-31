---------------------------------------------------------------
/*
gameid=xxx
itemcode=xxx

update dbo.tUserItem 
	set 
		expirestate = 0 , expiredate = '2012-12-31 01:05:00', 
		upgradestate = 0, upgradecost = 0 
	where gameid = 'SangSang' and itemcode in (103, 101, 102, 100, 200, 300, 400, 5001)
update dbo.tUserItem set expiredate = '2013-01-01 01:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (200)
update dbo.tUserMaster set silverball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set silverball = 1000000 where gameid = 'SangSang'
update dbo.tUserMaster set silverball = 1000000 where gameid = 'DD99'
exec spu_ItemUpgrade 'SangSang', 0, 	1, 	'',		-1		-- ��������		> ����
exec spu_ItemUpgrade 'SangSang', 54, 	1,	'',		-1		-- ��������		> ����
exec spu_ItemUpgrade 'SangSang', 50, 	1,	'',		-1		-- �󱼺��� 	> ����

exec spu_ItemUpgrade 'SangSang', 200, 	2,	'',		-1		-- ����(201)
exec spu_ItemUpgrade 'SangSang', 201, 	2,	'',		-1		-- ����(201)
exec spu_ItemUpgrade 'SangSang', 300, 	2,	'', 	-1		-- ����(301)
exec spu_ItemUpgrade 'SangSang', 400, 	2,	'', 	-1		-- ��Ʈ(401)	
exec spu_ItemUpgrade 'SangSang', 500, 	2,	'', 	-1		-- �Ȱ�(501) 	> ����(��ȭ�ȵ�)
exec spu_ItemUpgrade 'SangSang', 600, 	2,	'', 	-1		-- ����(601) 	> ����(��ȭ�ȵ�)
exec spu_ItemUpgrade 'SangSang', 700, 	2,	'', 	-1		-- ����(701) 	> ����(��ȭ�ȵ�)
exec spu_ItemUpgrade 'SangSang', 800, 	2,	'', 	-1		-- ����(801) 	> ����(��ȭ�ȵ�)

exec spu_ItemUpgrade 'SangSang', 5002, 	5,	'DD23', -1		-- ��(5001) 	> ����
exec spu_ItemUpgrade 'SangSang', 5001, 	5,	'DD1', 	-1		-- ��(5001) 	> ����
exec spu_ItemUpgrade 'SangSang', 5000, 	5,	'DD1', 	-1		-- ��(5001) 	> ����
exec spu_ItemUpgrade 'SangSang', 5000, 	5,	'Superman', 	-1		-- ��(5001) 	> ����
select * from dbo.tGiftList where gameid = 'Superman' order by idx desc
--select gameid, goldball, silverball from dbo.tUserMaster where gameid in ('SangSang', 'DD1')

exec spu_ItemUpgrade 'superbin', 200, 	2,	'',		-1		-- ����(201)
update dbo.tUserItem set upgradestate = 10 where gameid = 'superbin' and itemcode = 200
update dbo.tUserMaster set silverball = 629 where gameid = 'superbin'
*/

IF OBJECT_ID ( 'dbo.spu_ItemUpgrade', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemUpgrade;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemUpgrade
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@itemcode_								int,							-- �������ڵ�
	@branch_								int,							-- ��ȭ����(��, ��)
	@mpetid_								varchar(20),
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
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int 			set @RESULT_ERROR_UPGRADE_NOBRANCH 		= -60			-- �������� �귻ġ��.
	declare @RESULT_ERROR_NOT_WEAR				int 			set @RESULT_ERROR_NOT_WEAR 				= -61			-- �������� ���� 
	declare @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	int				set @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	= -62			--�����Ұ������Դϴ�.


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
	
	-- ��Ÿ ���ǰ�
	declare @ITEM_START_DAY						datetime		set @ITEM_START_DAY						= '2012-01-01'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�
	declare @SENDER								varchar(20)		set @SENDER								= '���躸��'
	
	
	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	
	-- ������ �з�
	declare @ITEM_UPGRADE_BRANCH_SILVER 		int 			set @ITEM_UPGRADE_BRANCH_SILVER			= 2				-- > ����ȭ
	declare @ITEM_UPGRADE_BRANCH_PET			int 			set @ITEM_UPGRADE_BRANCH_PET			= 5				-- > �갭ȭ
	

	-- upgrade state
	declare @ITEM_UPGRADE_SUCCESS				int 			set @ITEM_UPGRADE_SUCCESS				= 1
	declare @ITEM_UPGRADE_FAIL					int 			set @ITEM_UPGRADE_FAIL					= 0

	declare @PET_UPGRADE_B_CLASS				int				set @PET_UPGRADE_B_CLASS				= 2000
	declare @PET_UPGRADE_A_CLASS				int				set @PET_UPGRADE_A_CLASS				= 6000
	
	--declare @PATCH_NOT_END_DATE					datetime		set @PATCH_NOT_END_DATE				= '2013-02-15'	-- 1.30�ϱ���
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)
	declare @commentpet		varchar(80)
	
	declare @upgraderesult	int 			set @upgraderesult = @ITEM_UPGRADE_FAIL
	
	-- ����Ʈ�� ����Ÿ.
	declare @itemupgradebest				int,
			@itemupgradecnt					int,
			
			@petmatingbest					int,
			@petmatingcnt					int
Begin		
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �������� ��ȭ�� �� �����ϴ�.(-1)'
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	declare @ccharacter		int,			@face			int,		@cap				int, 
			@cupper			int,			@cunder			int,		@bat				int, 
			@glasses		int,			@wing			int,		@tail				int,
			@pet			int,
			@stadium		int,
			@goldball		int,			@silverball		int,
			@goldball2		int,			@silverball2	int,
			@silverballpetmy	int,		@silverballpetother	int			--���Ͱ� ����
	declare @expirestate	int,			@expiredate		datetime,	@upgradestate		int,
			@upgradecost	int,			@lvignore		int			
	declare @itemkind		int,			
			@itemperiod		int,
			@param1			varchar(20),	@param2			varchar(20),
			@param3			varchar(20),	@param4			varchar(20),
			@param5			varchar(20),	@param6			varchar(20),
			@param7			varchar(20),	@param8			varchar(20),
			@itemname 		varchar(256)
	declare @restorechar int
	declare @restorepart int
	set @upgradestate = 0
	set @silverballpetmy = 0
	set @silverballpetother = 0
	--set @upgradecost = 0
	declare @expireend			datetime		set @expireend 			= @ITEM_START_DAY
	declare @petkindmy			int				set @petkindmy			= 1
	declare @petgrademy			int				set @petgrademy			= 1
	declare @petraremy			int				set @petraremy			= 1
	--declare @petreitmy		int				set @petreitmy			= 8000
	declare @petkindother		int				set @petkindother		= 1
	declare @petgradeother		int				set @petgradeother		= 1
	declare @petrareother		int				set @petrareother		= 1
	declare @petreitother		int				set @petreitother		= 8000
	
	declare @rand				int				set @rand 				= 0
	declare @newpet				int 			set @newpet				= -1
	declare @newpetperiod		int 			set @newpetperiod		= 0
	declare @newpetname			varchar(80)
	declare @upgradebase		int				set @upgradebase		= 80
	declare @upgradeitemlv		int 			set @upgradeitemlv		= 1
	declare @itemlv				int 			set @itemlv				= 1
	declare @upgradeitemkind	int 			set @upgradeitemkind	= 80

	declare @petitemupgradebase 	int,
			@petitemupgradestep 	int,
			@normalitemupgradebase 	int,
			@normalitemupgradestep 	int,
			@permanentstep			int
	


	------------------------------------------------
	-- ����(tUserMaster) > ����Ʈ����
	--select 'DEBUG ��������', * from dbo.tUserMaster where gameid = @gameid
	------------------------------------------------
	select	
			@gameid = gameid,
			@ccharacter = ccharacter,	@face = face,				@cap = cap,
			@cupper = cupper,			@cunder	= cunder,			@bat = bat,
			@glasses = glasses,			@wing = wing,				@tail = tail,
			@pet = pet,
			@stadium = stadium,
			@goldball = goldball,		@silverball = silverball,
			@goldball2 = goldball,		@silverball2 = silverball,	
			@itemupgradebest = itemupgradebest,	@itemupgradecnt = itemupgradecnt,
			@petmatingbest = petmatingbest,		@petmatingcnt = petmatingcnt
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	 
	
	------------------------------------------------
	-- ����������(tUserItem) > ���Ⱓ, �ı����
	--select 'DEBUG ��������', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
	------------------------------------------------
	select @expirestate = expirestate, @expiredate = expiredate, @upgradestate = upgradestate, @upgradecost = upgradecost, @lvignore = lvignore
	from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
	--select 'DEBUG ', case when @expiredate > '2020-01-01' then '������' else '�Ⱓ��' end
	if(isnull(@expiredate, @ITEM_START_DAY) != @ITEM_START_DAY)
		begin
	 		set @expireend = @expiredate
	 	end
	
	
	------------------------------------------------
	-- ������(tItemInfo) > ����
	-- --select 'DEBUG ������', * from dbo.tItemInfo where itemcode = @itemcode
	------------------------------------------------
	select 
		@itemkind = kind, 		@itemperiod = period,	
		@param1 = param1, 		@param2 = param2,			@param3 = param3,		
		@param4 = param4,		@param5 = param5, 			@param6 = param6,
		@param7 = param7,		@param8 = param8,
		@itemname = itemname,
		@upgradeitemlv = lv,
		@itemlv = lv,
		@upgradeitemkind = kind
	from dbo.tItemInfo where itemcode = @itemcode

	--select 'DEBUG ',
	--	@ccharacter as 'cchar', 		@face as 'face',				@cap as 'cap',
	--	@cupper as 'cupper',			@cunder	as 'cunder',			@bat as 'bat',
	--	@glasses as 'glasses',			@wing as 'wing',				@tail as 'tail',
	--	@pet as 'pet', 					@stadium as 'stadium',
	--	@expirestate as '�������', 		@expiredate as '������',
	--	@itemkind as '������', 			
	--	@itemperiod as 'period',
	--	@param1 as 'param1', 	 		@param2 as 'param2', 			@param3 as 'param3', 
	--	@param4 as 'param4', 			@param5 as 'param5',  			@param6 as 'param6', 
	--	@param7 as 'param7', 			@param8 as 'param8'
	
	------------------------------------------------
	-- �� ���Ǻ� �б�
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR �������� �ʴ� ���̵� �Դϴ�.'
		END
	else if isnull(@itemkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR ������ ��ü�� �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.'
		END
	else if (@itemkind not in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_PET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_CANNT
			set @comment = 'ERROR ��ȭ�Ұ��� �����Դϴ�.' + str(@itemkind)
		END
	else if (@branch_ not in (@ITEM_UPGRADE_BRANCH_SILVER, @ITEM_UPGRADE_BRANCH_PET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_NOBRANCH
			set @comment = 'ERROR ��ȭ �з��� �̻��մϴ�.(����, �갭���˴ϴ�.)'
		END
	else if (isnull(@expirestate, -444) = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_HAVE
			set @comment = 'ERROR �����ϰ� ���� �ʽ��ϴ�.'
		END
	else if (@expirestate = @ITEM_EXPIRE_STATE_YES)	
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_EXPIRE
			set @comment = 'ERROR ���� ����Ǿ����ϴ�.'
		END
	else if (@expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > @expiredate)	
		begin
			set @nResult_ = @RESULT_ERROR_ITEM_EXPIRE
			set @comment = 'ERROR �������� ����Ǿ����ϴ�.'
		
			--��������Ʈ���� > ���ϴܿ��� ó���Ѵ�.
			--declare @restorepart int declare @param8 varchar(20) set @param8 = 1
			set @restorechar = cast(@param7	as int)
			set @restorepart = cast(@param8	as int)			
			
			
			if(@restorechar = -1)		
				begin
					---------------------------------------------
					--	���� > ���Ӱ��� ����(-1) > ��Ʈ�� > ������
					---------------------------------------------						
					if(@itemkind = @ITEM_KIND_CHARACTER and @ccharacter = @itemcode)
						begin
							----select 'DEBUG ĳ������(������)'
							set @ccharacter = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_CAP and @cap = @itemcode)
						begin
							--select 'DEBUG ������ CAP(������)'
							set @cap = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UPPER and @cupper = @itemcode)
						begin
							--select 'DEBUG UPPER(������)'
							set @cupper = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UNDER and @cunder = @itemcode)
						begin
							--select 'DEBUG UNDER(������)'
							set @cunder = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_BAT and @bat = @itemcode)
						begin
							--select 'DEBUG BAT(������)'
							set @bat = @restorepart
						end	
					else if(@itemkind = @ITEM_KIND_GLASSES and @glasses = @itemcode)
						begin
							--select 'DEBUG GLASSES(������)'
							set @glasses = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_WING and @wing = @itemcode)
						begin
							--select 'DEBUG _WING(������)'
							set @wing = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_TAIL and @tail = @itemcode)
						begin
							--select 'DEBUG TAIL(������)'
							set @tail = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_STADIUM and @stadium = @itemcode)
						begin
							--select 'DEBUG STADIUM(������)'
							set @stadium = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_PET and @pet = @itemcode)
						begin
							--select 'DEBUG PET(������)'
							set @pet = @restorepart
						end
				end
			else if(@restorechar = @ccharacter)
				begin						
					-----------------------------------
					-- ���� > ����(-1) > ��Ʈ�� > ������
					--	�������� �⺻ĳ���� ������Ʈ���� �⺻�� ������ �ʱ�ȭ
					-----------------------------------
					if(@itemkind = @ITEM_KIND_CHARACTER and @ccharacter = @itemcode)
						begin
							--select 'DEBUG ĳ������(����)'
							set @ccharacter = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_CAP and @cap = @itemcode)
						begin
							--select 'DEBUG ������ CAP(����)'
							set @cap = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UPPER and @cupper = @itemcode)
						begin
							--select 'DEBUG UPPER(����)'
							set @cupper = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UNDER and @cunder = @itemcode)
						begin
							--select 'DEBUG UNDER(����)'
							set @cunder = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_BAT and @bat = @itemcode)
						begin
							--select 'DEBUG BAT(����)'
							set @bat = @restorepart
						end	
					else if(@itemkind = @ITEM_KIND_GLASSES and @glasses = @itemcode)
						begin
							--select 'DEBUG GLASSES(����)'
							set @glasses = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_WING and @wing = @itemcode)
						begin
							--select 'DEBUG _WING(����)'
							set @wing = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_TAIL and @tail = @itemcode)
						begin
							--select 'DEBUG TAIL(����)'
							set @tail = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_STADIUM and @stadium = @itemcode)
						begin
							--select 'DEBUG STADIUM(����)'
							set @stadium = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_PET and @pet = @itemcode)
						begin
							--select 'DEBUG PET(����)'
							set @pet = @restorepart
						end
				end
			-------------------------------------------------
			--	�����ۺ����� Expireó�� > expirestate = 1
			-------------------------------------------------
			--select top 20 * from  where gameid = 'SangSang' order by idx desc
			--select 'DEBUG ������ ����ó��'
			update dbo.tUserItem  set  expirestate = @ITEM_EXPIRE_STATE_YES
			where gameid = @gameid and itemcode = @itemcode

			-------------------------------------------------
			--	�α׿� ����ó�� ����ϱ�
			-------------------------------------------------
			--select 'DEBUG ����ó�� �αױ���ϱ�'
			insert into tMessage(gameid, comment) 
			values(@gameid_,  @itemname + '�� ���Ⱑ �Ǿ����ϴ�.') 
			
			-------------------------------------------------
			--	������ ���� ó���ϱ�
			------------------------------------------------- 
			update dbo.tUserMaster
			set
				ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
				pet 		= @pet,			
				stadium		= @stadium
			where gameid = @gameid

		end
	else 	
		BEGIN
			set @nResult_ = @RESULT_SUCCESS	
			
			-------------------------------------------------
			--	������ ��ȭ�Ķ����
			-------------------------------------------------
			select top 1 
				@petitemupgradebase 	= petitemupgradebase,
				@petitemupgradestep 	= petitemupgradestep,
				@normalitemupgradebase 	= normalitemupgradebase,
				@normalitemupgradestep 	= normalitemupgradestep,
				@permanentstep			= permanentstep
			from dbo.tItemUpgradeInfo where flag = 1 order by idx desc
			
			-------------------------------------------------
			--	�����ۺ� > ���ݾ� ���� > 1������ 3% �÷��ֱ� 
			-------------------------------------------------
			--select 'DEBUG ', @upgradecost 'upgradecost', ((@upgradecost / 10000) * 3) 'addpercent'
			set @upgradeitemlv = case when @upgradeitemlv < 0 then 0 else @upgradeitemlv end			
			if(@upgradeitemkind = @ITEM_KIND_PET)
				begin
					-- ��
					-- 50 + (_itemLV) * 30
					-- 00      : 50
					-- 01      : 80
					-- 02      : 110
					set @upgradebase = @petitemupgradebase + (@upgradeitemlv ) * @petitemupgradestep
					
					--select 'DEBUG ��', @upgradebase
				end
			else
				begin
					-- �Ϲ���
					-- 50 + (_itemlv / 5) * 10  
					-- 01 ~ 04 : 50	<=
					-- 05 ~ 09 : 60	<=
					-- 10 ~ 14 : 70
					-- 15 ~ 19 : 80	<=
					-- 20 ~ 24 : 90
					-- 25 ~ 29 : 100
					-- 30 ~ 34 : 110
					-- 35 ~ 39 : 120 <=
					-- 40 ~ 44 : 130
					-- 45 ~ 49 : 140
					-- 50 ~ 50 : 150
					set @upgradebase = @normalitemupgradebase + (@upgradeitemlv / 5) * @normalitemupgradestep
					
					--select 'DEBUG ������', @upgradebase
				end
			
			
			
			
			--select 'DEBUG ', @upgradestate 
			if(@branch_ = @ITEM_UPGRADE_BRANCH_SILVER)
				begin
					-------------------------------------------------------
					-- 	��ȭ ����, ����
					-------------------------------------------------------
					--select 'DEBUG ', @upgradecost 'upgradecost', ((@upgradecost / 10000) * 3) 'addpercent'
					set @rand = Convert(int, ceiling(RAND() *  100))
					set @rand = @rand - ((@upgradecost / 10000) * 2)
					if(@upgradestate < 10)
						begin
							set @upgraderesult = @ITEM_UPGRADE_SUCCESS
						end
					else if(@lvignore = 1 or @itemlv < 10)
						begin
							-- ���� ������, ���� ���� ��
							set @upgraderesult = @ITEM_UPGRADE_SUCCESS
						end
					else if(@upgradestate < 20)
						begin
							if(@rand < 95)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 30)
						begin
							if(@rand < 90)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 40)
						begin
							if(@rand < 85)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 50)
						begin
							if(@rand < 80)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 60)
						begin
							if(@rand < 75)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else 
						begin
							if(@rand < 70)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
				
					
					-------------------------------------------------------
					-- 	����ȭȮ��
					-------------------------------------------------------			
					--select 'DEBUG 41'
					--������ ��ȭ ����ܰ迡 ���ؼ� ��������		
					set @comment = 'SUCCESS ����ȭȮ��'
					set @silverball = @silverball - (@upgradestate + 1) * @upgradebase
					
					--����Ʈ��
					set @itemupgradebest = case when (@upgradestate + 1) > @itemupgradebest then (@upgradestate + 1)
												else @itemupgradebest end
					set @itemupgradecnt = @itemupgradecnt + 1 
				end			
			else if(@branch_ in (@ITEM_UPGRADE_BRANCH_PET))
				begin
					-------------------------------------------------------
					-- 	�걳��ȭȮ��
					-------------------------------------------------------
					set @comment = 'SUCCESS �걳��Ȯ��'
					--select 'DEBUG 51'
					set @upgraderesult = @ITEM_UPGRADE_SUCCESS
					set @silverball = @silverball - (@upgradestate + 1) * @upgradebase
					
					
					set @petmatingbest = case 
												when (@upgradestate + 1) > @petmatingbest then (@upgradestate + 1)
												else @petmatingbest end
					set @petmatingcnt = @petmatingcnt + 1 				
					
					-------------------------------------------------------
					-- �����û��
					-------------------------------------------------------
					set @petkindmy 			= convert(int, @param3)
					set @petgrademy 		= convert(int, @param4)
					set @petraremy 			= convert(int, @param5)
					--set @petreitmy 		= convert(int, @param6)
		
					-------------------------------------------------------
					-- ����û��
					-------------------------------------------------------
					select 
						@petkindother 		= param3,		
						@petgradeother 		= param4,		
						@petrareother 		= param5, 			
						@petreitother 		= param6
					from dbo.tItemInfo 
					where itemcode = (select pet from dbo.tUserMaster where gameid = @mpetid_)
					
					-- ������ �ּ� 20�ǹ��� ����
					set @silverballpetmy = 0
					set @silverballpetother = 0
					
					-------------------------------------------------------
					-- ���� + ����� > �����길���
					-- petgrade 1:B, 2:A, 3:S
					-------------------------------------------------------
					if(@petgrademy in (1, 2))
						begin
							declare @val int
							declare @class int
							if(@petgrademy = 1)
								begin
									set @class = @PET_UPGRADE_B_CLASS
								end
							else
								begin
									set @class = @PET_UPGRADE_A_CLASS
								end

							set @val = @upgradestate + @petraremy + @petrareother
							set @rand = Convert(int, ceiling(RAND() * @class) - 1 + 100)	-- �⺻ 100 �̻󿡼��� �������� �Ѵ�.
							--select 'DEBUG ', @rand, @val
							
							if(@rand < @val)
								begin
									---------------------------
									-- ������
									---------------------------
									select 
										@newpet 		= itemcode,
										@newpetperiod 	= period,
										@newpetname 	= itemname
									from dbo.tItemInfo 
									where kind = @ITEM_KIND_PET and param3 = @petkindmy and param4 = @petgrademy + 1
									--select 'DEBUG ������ ����'
									

									-- �������� ������ ����Ѵ�.
									if exists(select * from dbo.tUserItem where gameid = @gameid and itemcode = @newpet)
										begin
											--select 'DEBUG ������ ���Դµ� �����߳�'
											set @newpet = -1
										end
									
								end
						end
				end		
		END

		
	--select 'DEBUG ', @upgradestate  'upgradestate', @upgraderesult 'upgraderesult', @silverball 'silverball', @goldball 'goldball'		
	---------------------------------------------------------
	-- ���� �ǹ��� ������ ��� ����
	---------------------------------------------------------
	if(@goldball < 0)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��尡 �����մϴ�.'
		end
	else if(@silverball < 0)
		begin
			set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
			set @comment = 'ERROR �ǹ��� �����մϴ�.'
		end
	else
		begin
			---------------------------------------------------------
			-- ��ȭ�������� > ��ȭ ����� ����
			---------------------------------------------------------
			if(@upgraderesult = @ITEM_UPGRADE_SUCCESS)
				begin
					set @upgradestate = @upgradestate + 1
				end
			else
				begin
					-- �������� ���� �����ϰ�
					--set @upgradestate = @upgradestate - 1
					set @upgradestate = @upgradestate
				end
				
			if(@upgradestate < 0)
				set @upgradestate = 0
				
			---------------------------------------------------------
			-- �갭ȭ > ��û��, �����
			---------------------------------------------------------
			--if(@branch_ = @ITEM_UPGRADE_BRANCH_PET)
			--	begin
			--		if(@upgraderesult = @ITEM_UPGRADE_SUCCESS)
			--			begin
			--				set @silverballpetmy = 0
			--				set @silverballpetother = 50
			--			end
			--		else
			--			begin
			--				set @silverballpetmy = 100
			--				set @silverballpetother = 25
			--			end
			--	end
				
				
			---------------------------------------------------------
			-- ���ݾ� = ��纼 * 200, �ǹ���
			---------------------------------------------------------
			--select 'DEBUG (��)', @upgradecost 'upgradecost', @goldball2 'goldball2', @goldball 'goldball', @silverball2 'silverball2', @silverball 'silverball'
			set @goldball2 = @goldball2 - @goldball
			set @silverball2 = @silverball2 - @silverball
			set @upgradecost = @upgradecost + @goldball2*200 + @silverball2
			--select 'DEBUG (��)', @upgradecost 'upgradecost', @goldball2 'goldball2', @goldball 'goldball', @silverball2 'silverball2', @silverball 'silverball'
			
		end

	--select 'DEBUG ', @upgradestate  'upgradestate', @upgraderesult 'upgraderesult', @silverball 'silverball', @goldball 'goldball'

	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- ��ȭ�� 20���̻��� �Ǹ� ������ �Ⱓ���� ������ �ȴ�.
			-- �α׷� ����Ѵ�.
			---------------------------------------------------------	
			--select 'DEBUG (��)', upgradestate from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode			
			declare @permanentdate datetime
			declare @expiredate2 datetime
			set @permanentdate = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)			
			if(@upgradestate >= @permanentstep)
				begin
					set @expiredate2 = @permanentdate
				end
			else
				begin
					set @expiredate2 = @expiredate
				end		
			update dbo.tUserItem 
				set  
					upgradestate = @upgradestate,
					upgradecost = @upgradecost,
					expiredate = @expiredate2
			where gameid = @gameid and itemcode = @itemcode			
			
			if(@expiredate < @permanentdate and  @expiredate2 = @permanentdate)
				begin
					insert into tMessage(gameid, comment) 
					values(@gameid,  @itemname + '�� 50�� �Ⱓ������ ����Ǿ����ϴ�.')
				end
			--select 'DEBUG (��)', upgradestate from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode

			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @goldball 'goldball',	@silverball 'silverball', @upgraderesult 'upgraderesult', @upgradestate 'upgradestate', @expiredate2 expireend, @silverballpetmy silverballpetmy, @newpet newpet
			
			
			---------------------------------------------------
			-- �갭ȭ�� ���濡�� �ǹ�����, �޼��� �����.
			---------------------------------------------------	
			if(@branch_ = @ITEM_UPGRADE_BRANCH_PET and exists(select * from dbo.tUserMaster where gameid = @mpetid_))
				begin
					-- ��������
					--update dbo.tUserMaster
					--set
					--	silverball 	= silverball + @silverballpetother
					--where gameid = @mpetid_					
					--
					--set @commentpet = @gameid + '�԰��� �걳��� +' + ltrim(rtrim(str(@silverballpetother)))+ '�� �ǹ����� ȹ���߽��ϴ�.'
					--insert into tMessage(gameid, comment) 					
					--values(@mpetid_,  @commentpet)
					
					-- �걳��� �߰� �ǹ�ȹ��(������ ��)
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
					values(@mpetid_, @petreitother, @SENDER, -1);					
				end
			set @silverball = @silverball + @silverballpetmy 
			
			---------------------------------------------------------
			-- �����������(���н� �ǹ����޹���)
			---------------------------------------------------------
			--select 'DEBUG (��)', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium'
			--select 'DEBUG (��)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
			
			update dbo.tUserMaster
			set
				--ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				--cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				--glasses 		= @glasses,		wing 		= @wing,		tail = @tail,
				--pet 			= @pet,			
				--stadium		= @stadium,
				goldball 		= @goldball,	
				silverball 		= @silverball,
				itemupgradebest = @itemupgradebest,	
				itemupgradecnt 	= @itemupgradecnt,
				petmatingbest 	= @petmatingbest,		
				petmatingcnt 	= @petmatingcnt
			where gameid = @gameid
			--select 'DEBUG (��)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid	
			

			----------------------------------------------------
			-- ������ ������
			----------------------------------------------------
			if(@newpet != -1)
				begin
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
					values(@gameid, @newpet, 'PetRW', @newpetperiod);
					
					insert into tMessage(gameid, comment) 
					values(@gameid, @newpetname + '���� ���踦 ���ؼ� ȹ�� �Ͽ����ϴ�.')
				end


			---------------------------------------------------------
			-- ��ȭ �α� ����Ѵ�.
			---------------------------------------------------------
			--insert into dbo.tUserItemUpgradeLog(gameid, itemcode, upgradekind, upgraderesult, upgradestate, silverball, goldball) values('SangSang', 101, 1, 1, 1, 100, 200)
			insert into dbo.tUserItemUpgradeLog(gameid,		itemcode,	upgradebranch,		upgraderesult,		upgradestate,		silverball,			goldball) 
			values(								@gameid,	@itemcode,	@branch_,			@upgraderesult,		@upgradestate,		@silverball2,		@goldball2)
			
			
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			declare @dateid 		varchar(8)
			declare @branchsilver 	int
			declare @branchpet		int
			
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			
			if(@branch_ = @ITEM_UPGRADE_BRANCH_SILVER)
				begin
					set @branchsilver = 1
				end
			else
				begin
					set @branchsilver = 0
				end
						
			
			if(@branch_ = @ITEM_UPGRADE_BRANCH_PET)
				begin
					set @branchpet = 1
				end
			else
				begin
					set @branchpet = 0
				end
			
			if(exists(select top 1 * from dbo.tUserItemUpgradeLogTotal where dateid = @dateid))
				begin
					update dbo.tUserItemUpgradeLogTotal 
						set 
							branchsilver 	= branchsilver + @branchsilver,
							branchpet 		= branchpet + @branchpet,
							
							goldball 		= goldball + @goldball2, 
							silverball 		= silverball + @silverball2, 
							cnt 			= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tUserItemUpgradeLogTotal(dateid, branchsilver, branchpet, goldball, silverball, cnt) 
					values(@dateid, @branchsilver, @branchpet, @goldball2, @silverball2, 1)
				end
				

				
			
		end
	else
		begin 
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @goldball 'goldball',	@silverball 'silverball', @upgraderesult 'upgraderesult', @upgradestate 'upgradestate', @expireend expireend, @silverballpetmy silverballpetmy, @newpet newpet
		end

	--select 'DEBUG (�Ϸ�)', * from dbo.tUserMaster where gameid = @gameid
	------------------------------------------------
	--	3-3. �������(��Ʈ���� ���)
	------------------------------------------------	
	select * from dbo.tUserMaster where gameid = @gameid	

	----------------------------------------------------
	-- ��������Ʈ > ������, 
	----------------------------------------------------
	if(@newpet != -1)
		begin
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid_ and gainstate = 0 
			order by idx desc
		end
	
	set nocount off
End

