/*
-- ��������
exec spu_Notice 1, 0, -1
exec spu_Notice 5, 0, -1
exec spu_Notice 6, 0, -1
exec spu_Notice 7, 0, -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_Notice', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Notice;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Notice
	@market_								int,
	@buytype_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �����ΰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	-- �Ϲݺ���
	declare @rand 								int


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS
	select @nResult_ rtn, '��������'

	------------------------------------------------
	--	3-2. �������� üũ
	------------------------------------------------
	select 
		top 1 *, convert(varchar(19), getdate(), 20) as currentDate
	from dbo.tNotice
	where market = @market_ and buytype = @buytype_
	order by idx desc

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



