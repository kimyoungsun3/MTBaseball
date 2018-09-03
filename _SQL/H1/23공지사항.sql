/* 
exec spu_Notice 1, -1
exec spu_Notice 2, -1
exec spu_Notice 3, -1
exec spu_Notice 5, -1
exec spu_Notice 7, -1
*/

IF OBJECT_ID ( 'dbo.spu_Notice', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Notice;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Notice
	@market_								int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------	
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @dateid 							varchar(6) 		set @dateid = Convert(varchar(6),Getdate(),112)		-- 201208

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS	
	select @nResult_ rtn, '�������� �˸�'
	
	------------------------------------------------
	--	3-3. �������� üũ
	-- 50:50 �����, ������Ż
	------------------------------------------------
	declare @rand int	
	set @rand = Convert(int, ceiling(RAND() * 2))
	
	if(@rand = 1)
		begin
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate, isnull(branchurl, '') branchurl, isnull(facebookurl, '') facebookurl, adurl adurl, adfile adfile from dbo.tNotice 
			where market = @market_
			order by idx desc
		end
	else
		begin
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate, isnull(branchurl, '') branchurl, isnull(facebookurl, '') facebookurl, adurl2 adurl, adfile2 adfile from dbo.tNotice 
			where market = @market_
			order by idx desc
		end

	---------------------------------------
	-- ���� ��ŷ����
	---------------------------------------
	select top 8 rank() over(order by win desc, lose asc) as rank, ccode, win btwin, (lose + win) bttotal
		from dbo.tBattleCountry 
		where dateid = @dateid

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



