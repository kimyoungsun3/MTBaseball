---------------------------------------------------------------
/*
gameid=xxx
itemcode=xxx

exec spu_ItemChange 'SangSang', 54, 	-1		-- ��������		> ����
exec spu_ItemChange 'SangSang', 50, 	-1		-- �󱼺��� 	> ����
exec spu_ItemChange 'SangSang', 3200, 	-1		-- ��Ŀ��		> ����
exec spu_ItemChange 'SangSang', 120, 	-1		-- �̺����� 	> ����
--exec spu_ItemChange 'sangsang', 111, 	-1		-- ���Է� > �Ⱓ��������
--select * from dbo.tUserItem where gameid = 'SangSang' and itemcode = 111
--update dbo.tUserItem set expiredate = '2012-08-11 11:05:00', expirestate = 1 where gameid = 'SangSang' and itemcode = 111
 
--�Ⱓ����
update dbo.tUserMaster set ccharacter = 0, face = 50, cap = 101, cupper = 201, cunder	= 301, bat = 401, glasses = 501, wing = 601, tail = 701, stadium = 801, pet = 5001 where gameid = 'SangSang'
update dbo.tUserItem set expiredate = '2012-08-11 11:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (102, 201, 301, 401, 501, 601, 701, 801, 5001)
--select * From Dbo.Tuseritem Where Gameid = 'sangsang'  and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001) order By Idx asc
exec spu_ItemChange 'SangSang', 101, 	-1		-- ����(101)
exec spu_ItemChange 'SangSang', 201, 	-1		-- ����(201)
exec spu_ItemChange 'SangSang', 301, 	-1		-- ����(301)
exec spu_ItemChange 'SangSang', 401, 	-1		-- ��Ʈ(401)
exec spu_ItemChange 'SangSang', 501, 	-1		-- �Ȱ�(501)
exec spu_ItemChange 'SangSang', 601, 	-1		-- ����(601)
exec spu_ItemChange 'SangSang', 701, 	-1		-- ����(701)
exec spu_ItemChange 'SangSang', 801, 	-1		-- ����(801)
exec spu_ItemChange 'SangSang', 5001, 	-1		-- ��(5001)
exec spu_ItemChange 'SangSang', 0, 		-1		-- ĳ����(0)
exec spu_ItemChange 'SangSang', 1, 		-1		-- ĳ����(1)

exec spu_ItemChange 'SangSangd', 0, 	-1		-- ĳ����(0)
exec spu_ItemChange 'SangSangd', 1, 	-1		-- ĳ����(1)


--�Ⱓ���
update dbo.tUserMaster set ccharacter = 0, face = 50, cap = 100, cupper = 200, cunder	= 300, bat = 400, glasses = 500, wing = 600, tail = 700, stadium = 800, pet = 5000 where gameid = 'SangSang'
update dbo.tUserItem set expiredate = '2013-09-11 11:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001)
--select * From Dbo.Tuseritem Where Gameid = 'sangsang'  and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001) order By Idx asc
exec spu_ItemChange 'SangSang', 101, 	-1		-- ����(101)
exec spu_ItemChange 'SangSang', 201, 	-1		-- ����(201)
exec spu_ItemChange 'SangSang', 301, 	-1		-- ����(301)
exec spu_ItemChange 'SangSang', 401, 	-1		-- ��Ʈ(401)
exec spu_ItemChange 'SangSang', 501, 	-1		-- �Ȱ�(501)
exec spu_ItemChange 'SangSang', 601, 	-1		-- ����(601)
exec spu_ItemChange 'SangSang', 701, 	-1		-- ����(701)
exec spu_ItemChange 'SangSang', 801, 	-1		-- ����(801)
exec spu_ItemChange 'SangSang', 5001, 	-1		-- ��(5001)
exec spu_ItemChange 'SangSang', 0, 		-1		-- ĳ����(0)
exec spu_ItemChange 'SangSang', 1, 		-1		-- ĳ����(1)


exec spu_ItemChange 'SangSang', 0, 		-1		-- ĳ����(0)	> ĳ���� ������ ����ȵ�
exec spu_ItemChange 'SangSang', 123, 	-1		-- ����(101)
exec spu_ItemChange 'SangSang', 223, 	-1		-- ����(201)
exec spu_ItemChange 'SangSang', 323, 	-1		-- ����(301)

exec spu_ItemChange 'SangSang', -101, 	-1		-- ����(101)
exec spu_ItemChange 'SangSang', -201, 	-1		-- ����(201)
exec spu_ItemChange 'SangSang', -301, 	-1		-- ����(301)
exec spu_ItemChange 'SangSang', -401, 	-1		-- ��Ʈ(401)
exec spu_ItemChange 'SangSang', -501, 	-1		-- �Ȱ�(501)
exec spu_ItemChange 'SangSang', -601, 	-1		-- ����(601)
exec spu_ItemChange 'SangSang', -701, 	-1		-- ����(701)
exec spu_ItemChange 'SangSang', -801, 	-1		-- ����(801)
exec spu_ItemChange 'SangSang', -5001, 	-1		-- ��(5001)
exec spu_ItemChange 'SangSang', -0, 	-1		-- ĳ����(0)
exec spu_ItemChange 'SangSang', -1, 	-1		-- ĳ����(1)
*/


IF OBJECT_ID ( 'dbo.spu_ItemChange', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemChange;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemChange
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@itemcode_								int,							-- �������ڵ�
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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- �ǸŹ���� �ٸ�
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
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	
	-- ������
	declare @ITEM_WEAR_MODE_PUTON						int 	set @ITEM_WEAR_MODE_PUTON		= 1
	declare @ITEM_WEAR_MODE_STRIP						int 	set @ITEM_WEAR_MODE_STRIP		= -1



	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid = @gameid_
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)
	declare @wearmode		int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �������� ������ �� �����ϴ�.(-1)'
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	BEGIN
		declare @ccharacter		int,			@face			int,		@cap				int, 
				@cupper			int,			@cunder			int,		@bat				int, 
				@glasses		int,			@wing			int,		@tail				int,
				@pet			int,
				@stadium		int
		declare @expirestate	int,			@expiredate		datetime
		declare @itemkind		int,			
				@itemperiod		int,
				@param1			varchar(20),	@param2			varchar(20),
				@param3			varchar(20),	@param4			varchar(20),
				@param5			varchar(20),	@param6			varchar(20),
				@param7			varchar(20),	@param8			varchar(20),
				@itemname 		varchar(20)
		declare @restorechar int
		declare @restorepart int
		declare @customize		varchar(128)
		declare @customize2		varchar(128)
		declare @ccharacterMaster	int,
				@ccharacterPart 	int
		
		------------------------------------------------
		-- ����� ��� �߰�.
		------------------------------------------------
		if(@itemcode >= 0)
			begin
				--select 'DEBUG ������'
				set @wearmode = @ITEM_WEAR_MODE_PUTON
			end
		else
			begin
				--select 'DEBUG �������'
				set @wearmode = @ITEM_WEAR_MODE_STRIP
				set @itemcode = -@itemcode
			end
		


		------------------------------------------------
		-- ����(tUserMaster) > ����Ʈ����
		--select 'DEBUG ��������', * from dbo.tUserMaster where gameid = @gameid
		------------------------------------------------
		select	
				@ccharacter = ccharacter,	@face = face,				@cap = cap,
				@cupper = cupper,			@cunder	= cunder,			@bat = bat,
				@glasses = glasses,			@wing = wing,				@tail = tail,
				@pet = pet,
				@stadium = stadium,
				@customize = customize
		from dbo.tUserMaster where gameid = @gameid
		
		
		------------------------------------------------
		-- ����������(tUserItem) > ���Ⱓ, �ı����
		--select 'DEBUG ��������', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		------------------------------------------------
		select @expirestate = expirestate, @expiredate = expiredate
		from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		
		
		------------------------------------------------
		-- ������(tItemInfo) > ����
		--select 'DEBUG ������', * from dbo.tItemInfo where itemcode = @itemcode
		------------------------------------------------
		select
			@itemkind = kind, 		@itemperiod = period,	
			@param1 = param1, 		@param2 = param2,			@param3 = param3,		
			@param4 = param4,		@param5 = param5, 			@param6 = param6,
			@param7 = param7,		@param8 = param8,
			@itemname = itemname,
			@ccharacterMaster = param7,		
			@ccharacterPart = param8
		from dbo.tItemInfo where itemcode = @itemcode	
		
		
		-------------------------------------------------
		-- ������ ��Ʈ�� ĳ���� ��Ʈ > Ŀ���͸���¡ �о��
		-------------------------------------------------
		if(isnull(@ccharacter, -1) != -1)
			begin
				if(isnull(@itemkind, -1) != -1 and @itemkind = @ITEM_KIND_CHARACTER)
					begin
						select @customize2 = customize from dbo.tUserCustomize
						where gameid = @gameid and itemcode = @itemcode
						if(isnull(@customize2, '-1') = '-1')
							begin
								--�αװ� �����Ǿ��� ������
								set @customize2 = @ITEM_CHAR_CUSTOMIZE_INIT;
								--insert into dbo.tUserCustomize(gameid, itemcode, customize)
								--values(@gameid, @ccharacter, @ITEM_CHAR_CUSTOMIZE_INIT)
							end
						 
						
						--select 'DEBUG ',  @ccharacter '����', @customize customize, @itemcode '����', @customize2 customize2
						set @customize = @customize2 
						
					end
			end

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
		if isnull(@itemkind, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				set @comment = 'ERROR ������ ��ü�� �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.'
			END
		else if (@itemkind not in (@ITEM_KIND_CHARACTER, @ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOCHANGE_KIND
				set @comment = 'ERROR ������ �� ���� ������ �����Դϴ�.' + str(@itemkind)
			END
		else if (@wearmode = @ITEM_WEAR_MODE_STRIP and @itemkind not in (@ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_PET))
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_STRIP_CANNT_KIND
				set @comment = 'ERROR �������� ������ �Ȱ�, ����, ����, �길 ���� �����մϴ�.' + str(@itemkind)
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
								--select 'DEBUG ĳ������(������)'
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

			end
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				-------------------------------------------------------
				-- 	ĳ���� ����					
				-------------------------------------------------------
				if(@itemkind = @ITEM_KIND_CHARACTER)
					begin
						set @comment = 'SUCCESS ĳ���� ���󺯰�'

						-- �ϴܿ��� ĳ���� ��Ʈ���� ��������					
						set @ccharacter = @itemcode
						set @face = @param1
						set @cap = @param2
						set @cupper = @param3
						set @cunder = @param4
						--@bat �״��
						--set @glasses = -1	�״�� 2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--set @wing = -1	�״�� 2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--set @tail = -1	�״�� 2012-09-13�ϳ� ��� ��Ʈ �״�� ����
						--@pet �״��
						--@stadium �״��
						
					end
				else if(@wearmode = @ITEM_WEAR_MODE_STRIP and @itemkind in (@ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_PET))
					begin						
						if(@itemkind = @ITEM_KIND_GLASSES)
							begin
								set @comment = 'SUCCESS �Ȱ� ����'
								set @glasses = -1
							end
						else if(@itemkind = @ITEM_KIND_WING)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @wing = -1
							end
						else if(@itemkind = @ITEM_KIND_TAIL)
							begin
								set @comment = 'SUCCESS ���� ����'
								set @tail = -1
							end
						else if(@itemkind = @ITEM_KIND_PET)
							begin
								set @comment = 'SUCCESS �� ����'
								set @pet = -1
							end
					end	
				else if(@itemkind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
					begin						
						if(@itemkind = @ITEM_KIND_CAP)
							begin
								set @comment = 'SUCCESS ���� ����'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cap = @itemcode
									end
							end
						else if(@itemkind = @ITEM_KIND_UPPER)
							begin
								set @comment = 'SUCCESS ���� ����'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cupper = @itemcode
									end
							end
						else if(@itemkind = @ITEM_KIND_UNDER)
							begin
								set @comment = 'SUCCESS ���� ����'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cunder = @itemcode
									end
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
					end		
				else
					begin
						set @nResult_ = @RESULT_ERROR
						set @comment = 'ERROR �������� ����/�����Ҽ� �����ϴ�.(-2)'
					end
			END

		if(@nResult_ = @RESULT_SUCCESS or @nResult_ = @RESULT_ERROR_ITEM_EXPIRE)
			begin
				---------------------------------------------------------
				-- �ڵ����
				---------------------------------------------------------
				select @nResult_ rtn, @comment
				
				---------------------------------------------------------
				-- �����������
				---------------------------------------------------------
				--select 'DEBUG (��)', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium'
				--select 'DEBUG (��)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
				
				update dbo.tUserMaster
				set
					ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
					cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
					glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
					pet 		= @pet,			
					stadium		= @stadium,
					customize	= @customize
				where gameid = @gameid
				--select 'DEBUG (��)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
			end
		else
			begin 
				select @nResult_ rtn, @comment
			end

	END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--select 'DEBUG (�Ϸ�)', * from dbo.tUserMaster where gameid = @gameid
			select * from dbo.tUserMaster where gameid = @gameid	
		end
	set nocount off
End

