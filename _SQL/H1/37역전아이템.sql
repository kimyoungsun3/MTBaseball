/*

exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', -1, -1		-- ������
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7020, -1		-- ��Ʋ
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7021, -1		-- �̼�
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7022, -1
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7023, -1
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7024, -1

*/

IF OBJECT_ID ( 'dbo.spu_RevMode', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_RevMode;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_RevMode
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@revitemcode_							int,
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
	
	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- ������Ʈ ����.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- �ڽ��� ���̵� �߰�.
	
	declare @BATTLE_REV_ITEM_CODE				int				set @BATTLE_REV_ITEM_CODE		= 7020
	declare @MISSION_REV_ITEM_CODE4				int				set @MISSION_REV_ITEM_CODE4		= 7021
	declare @MISSION_REV_ITEM_CODE7				int				set @MISSION_REV_ITEM_CODE7		= 7022
	declare @MISSION_REV_ITEM_CODE8				int				set @MISSION_REV_ITEM_CODE8		= 7023
	declare @MISSION_REV_ITEM_CODE9				int				set @MISSION_REV_ITEM_CODE9		= 7024
	
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------	
	declare @comment			varchar(512)
	declare @gameid				varchar(20)
	declare @goldball			int
	declare @goldballPrice		int					set @goldballPrice 			= 100
	declare @silverballPrice 	int					set @silverballPrice		= 0
	declare @itemcode			int					
	
	declare @btrevitemcode		int					set @btrevitemcode 			= @BATTLE_REV_ITEM_CODE
	declare @btrevprice			int					set @btrevprice 			= 5
	declare @msrevitemcode4		int					set @msrevitemcode4 		= @MISSION_REV_ITEM_CODE4
	declare @msrevprice4		int					set @msrevprice4 			= 5
	declare @msrevitemcode7		int					set @msrevitemcode7 		= @MISSION_REV_ITEM_CODE7
	declare @msrevprice7		int					set @msrevprice7 			= 7
	declare @msrevitemcode8		int					set @msrevitemcode8 		= @MISSION_REV_ITEM_CODE8
	declare @msrevprice8		int					set @msrevprice8 			= 20
	declare @msrevitemcode9		int					set @msrevitemcode9 		= @MISSION_REV_ITEM_CODE9
	declare @msrevprice9		int					set @msrevprice9 			= 50
	
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
		@gameid		= gameid,
		@goldball	= goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @goldball '�������', @revitemcode_ revitemcode_
	
	------------------------------------------------
	--	3-3-3. ������尡��
	-- �� �������� �����Ѵ�.
	------------------------------------------------
	select top 1  
		@btrevitemcode		= btrevitemcode, 	
		@btrevprice			= btrevprice, 		
		@msrevitemcode4		= msrevitemcode4, 	
		@msrevprice4		= msrevprice4, 		
		@msrevitemcode7		= msrevitemcode7, 	
		@msrevprice7		= msrevprice7, 		
		@msrevitemcode8		= msrevitemcode8, 	
		@msrevprice8		= msrevprice8, 		
		@msrevitemcode9		= msrevitemcode9, 	
		@msrevprice9		= msrevprice9
	from dbo.tRevModeInfo 
	order by idx desc
	--select 'DEBUG 2-1', @btrevitemcode btrevitemcode, @btrevprice btrevprice, @msrevitemcode4 msrevitemcode4, @msrevprice4 msrevprice4, @msrevitemcode7 msrevitemcode7, @msrevprice7 msrevprice7, @msrevitemcode8 msrevitemcode8, @msrevprice8 msrevprice8, @msrevitemcode9 msrevitemcode9, @msrevprice9 msrevprice9

	
	set @itemcode 		= @revitemcode_
	if(@itemcode = @btrevitemcode)
		begin
			set @goldballPrice 	= @btrevprice
			--select 'DEBUG 2-2-1 ��Ʋ����', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode4)
		begin
			set @goldballPrice 	= @msrevprice4 
			--select 'DEBUG 2-2-2 4�̼ǿ���', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode7)
		begin
			set @goldballPrice 	= @msrevprice7 
			--select 'DEBUG 2-2-3 7�̼ǿ���', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode8)
		begin
			set @goldballPrice 	= @msrevprice8 
			--select 'DEBUG 2-2-4 8�̼ǿ���', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode9)
		begin
			set @goldballPrice 	= @msrevprice9 
			--select 'DEBUG 2-2-5 9�̼ǿ���', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else 
		begin
			set @goldballPrice 	= 100 
			--select 'DEBUG 2-2-6 @@@@����', @itemcode itemcode, @goldballPrice goldballPrice
		end
	
	
	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
			--select 'DEBUG 3' + @comment
		END
	else if (@itemcode not in (@BATTLE_REV_ITEM_CODE, @MISSION_REV_ITEM_CODE4, @MISSION_REV_ITEM_CODE7, @MISSION_REV_ITEM_CODE8, @MISSION_REV_ITEM_CODE9))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG 4-0' + @comment
		END
	else if (@goldballPrice <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��ȿ���� �ʴ� ����'
			--select 'DEBUG 4-1' + @comment
		END
	else if (@goldball < @goldballPrice or @goldball <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��纼�� ����'
			--select 'DEBUG 4-2' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���������� ��������'
			
			--select 'DEBUG 5-1 ������(��) > ', @goldball '�������', @goldballPrice goldballPrice			
			set @goldball = @goldball - @goldballPrice
			--select 'DEBUG 5-2(��) > ', @goldball '�������', @goldballPrice goldballPrice			
		end
		

	---------------------------------------------------------
	-- �ڵ����
	---------------------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- ���� ��������
			---------------------------------------------------------
			update dbo.tUserMaster
			set
				goldball		= @goldball
			where gameid = @gameid
			
			---------------------------------------------------------
			-- ���ŷα� ���
			---------------------------------------------------------
			--select 'DEBUG 6 ���������� ���ŷα� ���', goldball '�������', @goldballPrice '�ǸŰ�' from dbo.tUserMaster where gameid = @gameid_
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldballPrice, 0) 
			
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball = goldball + @goldballPrice, 
							silverball = silverball + @silverballPrice, 
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice, @silverballPrice, 1)
				end
				
				
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�2 Master
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyLogTotalMaster where dateid = @dateid))
				begin
					update dbo.tItemBuyLogTotalMaster 
						set 
							goldball 	= goldball + @goldballPrice, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalMaster(dateid, goldball, silverball, cnt)
					values(@dateid, @goldballPrice, @silverballPrice, 1)
				end
			
			---------------------------------------------------------
			-- �����ǹ�, �ν��͸�� �αױ��
			---------------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyPromotionTotal 
						set 
							goldball = goldball + @goldballPrice,
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
					values(@dateid, @itemcode, @goldballPrice, 1)
				end
			
			
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	set nocount off
End

