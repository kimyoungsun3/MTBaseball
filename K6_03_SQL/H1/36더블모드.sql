/*
exec spu_DoubleMode 'SangSangx', '7575970askeie1595312', -1
exec spu_DoubleMode 'SangSang', '7575970askeie1595312', -1
exec spu_DoubleMode 'guest134', '3495365l5q8c1u355253', -1

*/

IF OBJECT_ID ( 'dbo.spu_DoubleMode', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_DoubleMode;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_DoubleMode
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
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------	
	-- DoublePowerMode(�α���, ������)
	declare @doubleitemcode					int
	declare @doublepriceinfo				int
	declare @doubleperiodinfo				int
	declare @doublepowerinfo				int
	declare @doubledegreeinfo				int
	
	declare @comment			varchar(512)		
	declare @gameid				varchar(20)
	declare @goldball			int
	declare	@doubledate			datetime
	declare @goldballPrice		int					set @goldballPrice 			= 100
	declare @silverballPrice 	int					set @silverballPrice		= 0
	declare @itemcode			int
	
	
	
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
		@goldball	= goldball,
		@doubledate = doubledate
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	------------------------------------------------
	--	3-3-3. �����尡��
	------------------------------------------------
	select top 1  
		@doubleitemcode		= doubleitemcode,
		@doublepriceinfo	= doublepriceinfo,	
		@doubleperiodinfo	= doubleperiodinfo,
		
		@doublepowerinfo 	= doublepowerinfo,
		@doubledegreeinfo 	= doubledegreeinfo
	from dbo.tDoubleModeInfo 
	order by idx desc
	
	set @itemcode 		= @doubleitemcode
	set @goldballPrice 	= @doublepriceinfo 
	
	
	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@goldball < @goldballPrice)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��纼�� ����'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ������ �ð�����'
			
			
			--select 'DEBUG (��) > ', @doubledate doubledate, @goldball goldball			
			-- ��¥ ����
			if(@doubledate < getdate())
				begin
					--select 'DEBUG ���ڰ� ���� ���� ����'
					set @doubledate = getdate()
				end
			else
				begin
					--select 'DEBUG ��¥�� ���� ���� �ִ�.'
					set @doubledate = @doubledate
				end
				
			set @doubledate = DATEADD(dd, @doubleperiodinfo, @doubledate)			
			set @goldball = @goldball - @goldballPrice
			

			--select 'DEBUG (��) > ', @doubledate doubledate, @goldball goldball
			
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
				doubledate 		= @doubledate,
				doublepower		= @doublepowerinfo,
				doubledegree	= @doubledegreeinfo,
				goldball		= @goldball
			where gameid = @gameid
			
			---------------------------------------------------------
			-- ���ŷα� ���
			---------------------------------------------------------
			--select 'DEBUG ���ŷα� ���'
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
				
			
			---------------------------------------------------------
			-- ����ǹ�, �ν��͸�� �αױ��
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

