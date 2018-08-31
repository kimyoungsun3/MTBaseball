use Game4FarmVill3
Go
/*
-- delete from dbo.tFVFreeCashLog where gameid = 'xxxx2'
select * from dbo.tFVFreeCashLog where gameid = 'xxxx2'

exec spu_FVFreeCash 'xxxx2',  '049000s1i0n7t8445289', 500, 80 , -1
exec spu_FVFreeCash 'xxxx2',  '049000s1i0n7t8445289', 500, 700 , -1

*/

IF OBJECT_ID ( 'dbo.spu_FVFreeCash', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFreeCash;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVFreeCash
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@password_								varchar(20),
	@bestani_								int,
	@cashcost_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @dateid 				varchar(8)				set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @market					int						set @market			= 5

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @bestani_ bestani_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@market		= market
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�ΰ� ����߽��ϴ�.'
			--select 'DEBUG ', @comment

			---------------------------------------------------
			-- �ΰ� ����ϱ�
			---------------------------------------------------
			insert into dbo.tFVFreeCashLog(gameid,   bestani,   cashcost)
			values(                       @gameid_, @bestani_, @cashcost_)

			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			exec spu_FVDayLogInfoStatic @market, 60, @cashcost_			-- �� ���������ݾ�, Ƚ��.

		END

	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



