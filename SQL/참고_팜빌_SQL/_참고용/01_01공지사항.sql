/*
-- ��������
exec spu_FVNotice 1, 0, -1
exec spu_FVNotice 2, 0, -1
exec spu_FVNotice 3, 0, -1
exec spu_FVNotice 5, 0, -1
exec spu_FVNotice 7, 0, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVNotice', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVNotice;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVNotice
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

	-- ��Ż� ���а�
	--declare @SKT 								int				set @SKT								= 1
	--declare @KT 								int				set @KT									= 2
	--declare @LGT 								int				set @LGT								= 3
	--declare @GOOGLE 							int				set @GOOGLE								= 5
	--declare @IPHONE							int				set @IPHONE								= 7



	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	-- �Ϲݺ���
	declare @rand 								int
	declare @communityurl						varchar(128)		set @communityurl		= 'http://www.hungryapp.co.kr/bbs/list.php?bcode=jjayo'

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
	select top 1 *, convert(varchar(19), getdate(), 20) as currentDate, @communityurl communityurl from dbo.tFVNotice
	where market = @market_ and buytype = @buytype_
	order by idx desc

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



