use Farm
Go
/*


exec spu_FVServerTime 'xxxx@gmail.com',  '01022223331', -1			-- ��������
*/

IF OBJECT_ID ( 'dbo.spu_FVServerTime', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVServerTime;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVServerTime
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@phone_									varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '�����ð�'
	declare @curdate				datetime				set @curdate		= getdate()
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS
	--select 'DEBUG �Է�����', @gameid_ gameid_, @phone_ phone_, @curdate curdate

	select @nResult_ rtn, @comment comment, @curdate curdate

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



