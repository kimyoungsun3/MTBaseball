/* 
[��/�����ϱ�]
gameid=xxx
itemcode=xxx

exec spu_GiftSend 'SangSang', 101, 'SangSang', -1, 0, 'adminid', 1		-- �Ⱓ�� ����
exec spu_GiftSend 'SangSang', 6000, 'SangSang', 7, 0, 'adminid', 1		-- �Ҹ��� ����
exec spu_GiftSend 'SangSangxx', 6000, 'SangSang', 7, 0, 'adminid', 1	-- ���̵����
exec spu_GiftSend 'SangSang', 8000, 'SangSang', 7, 0, 'adminid', 1		-- ��ȣ����


exec spu_GiftSend 'superman', 6004, 'SangSang', -1, 0, 'adminid', 1		-- ���ϱ�(500�ǹ�)
exec spu_GiftSend 'superman', 9200, 'SangSang', -1, 0, 'adminid', 1		-- ���ϱ�(50�ǹ�)
exec spu_GiftSend 'superman', 9225, 'SangSang', -1, 0, 'adminid', 1		-- ���ϱ�(30000�ǹ�)
exec spu_GiftSend 'superman', 9300, 'SangSang', -1, 0, 'adminid', 1		-- ���ϱ�(5���)
exec spu_GiftSend 'superman', 9322, 'SangSang', -1, 0, 'adminid', 1		-- ���ϱ�(500���)
exec spu_GiftSend 'superman', 101, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 201, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 301, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 413, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 430, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 501, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 601, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 701, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 5000, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 6000, 'SangSang', -1, 0, 'adminid', 1

*/

IF OBJECT_ID ( 'dbo.spu_GiftSend', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GiftSend;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GiftSend
	@gameid_								varchar(20),																-- ���Ӿ��̵�
	@itemcode_								int,																		-- ������ ������ �ڵ�
	@sendid_								varchar(20),
	@period2_								int,
	@upgradestate2_							int,
	@adminid_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50	-- �������ڵ��ã��

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

	
    
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @itemname		varchar(80)
	declare @itemperiod		int
	
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
		if not exists(select * from dbo.tUserMaster where gameid = @gameid_)
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
				select @nResult_ rtn, 'ERROR ������ ��� ������ ���մϴ�.'
			END
		else if not exists(select * from dbo.[tItemInfo] where itemcode = @itemcode_)
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				select @nResult_ rtn, 'ERROR ������ �ڵ�('+ltrim(str(@itemcode_))+')�� �������� �ʽ��ϴ�.' 
			END
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				select @nResult_ rtn, 'SUCCESS ����ó���Ǿ����ϴ�.'
				
				-- declare @itemcode_ int		set @itemcode_ = 101
				select @itemname = itemname, @itemperiod = period from dbo.tItemInfo where itemcode = @itemcode_
				
				------------------------
				-- -2���̸� ��������
				-- ��Ÿ ����̸� ������ ��¥
				if(@period2_ > 0)
					begin
						set @itemperiod = @period2_
					end
				else
					begin
						set @itemperiod = @itemperiod
					end
				
				
				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2) 
				values(@gameid_ , @itemcode_, '������('+@adminid_+')', @itemperiod, @upgradestate2_);

				insert into tMessage(gameid, comment) 
				values(@gameid_, @itemname + '�� ���� �޾ҽ��ϴ�.')

			end
	END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	--select @nResult_ rtn
End
