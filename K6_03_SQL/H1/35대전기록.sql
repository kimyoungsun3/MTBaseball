/* �Է°�
gameid=xxx

exec spu_BTRecord 'pjstime', '37993721339797757114', -1
*/

IF OBJECT_ID ( 'dbo.spu_BTRecord', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_BTRecord;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_BTRecord
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
	                 
			
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 		varchar(20)
	declare @comment		varchar(512)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid = gameid 
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- ���̵� ���������ʴ°�??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
			
		end
	else	
		BEGIN
			set @nResult_ = @RESULT_SUCCESS	
			set @comment = '�˻��߽��ϴ�.'
		end
		
	
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �� -> ���
			------------------------------------------------------------
			select u2.avatar, u2.picture, u2.ccode, u2.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from 
				(select top 20 * from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc) as bt
					join
				(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster 
					where gameid in 
						(select top 20 btgameid from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc)) as u2
				on bt.btgameid = u2.gameid
				
			------------------------------------------------------------
			-- �� <- ���(�����Ѱ͵�)
			------------------------------------------------------------				
			select u2.avatar, u2.picture, u2.ccode, bt.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from 
				(select top 20 * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc) as bt
					join
				(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster 
					where gameid in 
						(select top 20 gameid from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc)) as u2
				on bt.gameid = u2.gameid
		end

	set nocount off
End



