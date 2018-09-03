use Game4FarmVill4
Go
/*
exec spu_FVRankInfo 'xxxx2', '049000s1i0n7t8445289', -1

*/

IF OBJECT_ID ( 'dbo.spu_FVRankInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRankInfo;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRankInfo
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
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
	--	2-2. ���°�
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 				varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '��ŷ������ ����ó��'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			--	��ŷ�������(��ü).
			------------------------------------------------
			if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8))
				begin
					select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8
				end
			else
				begin
					select
						@dateid8 rkdateid8,
						0 rkteam1, 		0 rkteam0, 		0 rkreward,
						0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
						0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
				end


			if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b))
				begin
					select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b
				end
			else
				begin
					select top 1 * from dbo.tFVRankDaJun where rkdateid8 < @dateid8b order by rkdateid8 desc
					--select
					--	@dateid8b rkdateid8,
					--	0 rkteam1, 		0 rkteam0, 		0 rkreward,
					--	0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
					--	0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
				end

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



