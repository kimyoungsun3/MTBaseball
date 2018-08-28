/*
update dbo.tUserMaster set boardwrite = getdate() - 0.01 where gameid = 'xxxx2'
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1, 'ģ�߰Խ��Ǳ���', -1		-- �Խ��Ǳ۾���.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 2, -1, '�ϹݰԽ��Ǳ���', -1		-- < ������.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 3, -1, '���װԽ��Ǳ���', -1

-- delete from dbo.tUserBoard where kind = 3 and idx2 > 10
-- select top 10 * from dbo.tUserBoard where kind = 1 order by idx2 desc
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 1, 1, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 2, 1, '', -1					-- �Ϲ�.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 3, 1, '', -1					-- ����.

--���б� �׽�Ʈ.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 0, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 1, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 2, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7456, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7457, '', -1					-- ģ��.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7458, '', -1					-- ģ��.
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserBoard', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserBoard;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_UserBoard
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@kind_									int,
	@page_									int,
	@message_								varchar(256),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- �����ΰ� �̹̺�������.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �Խ��� ���.
	declare @USERBOARD_MODE_WRITE				int				set @USERBOARD_MODE_WRITE				= 1		-- �۾���
	declare @USERBOARD_MODE_READ				int				set @USERBOARD_MODE_READ				= 2		-- �б�

	-- �Խ��� ����.
	declare @USERBOARD_KIND_NORMAL				int				set @USERBOARD_KIND_NORMAL				= 1		-- ģ�߰Խ���(1)
	declare @USERBOARD_KIND_FRIEND				int				set @USERBOARD_KIND_FRIEND				= 2 	-- �ϹݰԽ���(2)
	declare @USERBOARD_KIND_GROUP				int				set @USERBOARD_KIND_GROUP				= 3		-- ���װԽ���(3)

	-- �Խ��� ���μ�
	declare @PAGE_LINE							int				set @PAGE_LINE							= 10

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @idx2			int						set @idx2			= 1
	declare @pagemax		int						set @pagemax		= 1
	declare @page			int						set @page			= 1
	declare @schoolidx		int						set @schoolidx		= -1
	declare @gapminute		int						set @gapminute		= 0
	declare @boardwrite		datetime				set @boardwrite		= getdate()

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @kind_ kind_, @page_ page_, @message_ message_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@schoolidx		= schoolidx,
		@boardwrite		= boardwrite
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	set @gapminute 		= dbo.fnu_GetDatePart('mi', @boardwrite, getdate())
	--select 'DEBUG ��������', @gapminute gapminute, @boardwrite boardwrite, getdate() '����ð�'

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERBOARD_MODE_WRITE, @USERBOARD_MODE_READ) or @kind_ not in (@USERBOARD_KIND_NORMAL, @USERBOARD_KIND_FRIEND, @USERBOARD_KIND_GROUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ in (@USERBOARD_MODE_WRITE) and @gapminute <= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR ���� �ð��� ���ҽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERBOARD_MODE_WRITE)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �۾��� ����.'
			--select 'DEBUG ' + @comment

			---------------------------------------
			-- �ε��� ��ȣ�� �о > �Է�.
			---------------------------------------
			-- ��ī�װ��� �ƽ���ȣ
			select @idx2 = (isnull(max(idx2), 0) + 1)
			from dbo.tUserBoard where kind = @kind_

			-- �Է�
			insert into dbo.tUserBoard( kind,   idx2,  gameid,   message,   schoolidx)
			values(                    @kind_, @idx2, @gameid_, @message_, @schoolidx)

			--select 'DEBUG WRITE', @idx2 idx2

			-- select 'DEBUG �Խ��� �۾� �ð��� ����صд�.'
			update dbo.tUserMaster
				set
					boardwrite	= getdate()
			where gameid = @gameid_
		END
	else if (@mode_ = @USERBOARD_MODE_READ)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ���б� ����.'
			----select 'DEBUG ' + @comment

			---------------------------------------
			-- �ε��� ��ȣ�� �о > �Է�.
			---------------------------------------
			-- ��ī�װ��� �ƽ���ȣ
			select @idx2 = (isnull(max(idx2), 1))
			from dbo.tUserBoard where kind = @kind_

			--select 'DEBUG READ', @idx2 idx2
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR �˼����� ����(-1)'
		end


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- ������ �ƽ�
			set @pagemax	= @idx2 / @PAGE_LINE
			set @pagemax 	= @pagemax + case when (@idx2 % @PAGE_LINE != 0) then 1 else 0 end
			set @page		= case
								when (@page_ <= 0)			then 1
								when (@page_ >  @pagemax)	then @pagemax
								else @page_
							end
			set @idx2		= @idx2 - (@page - 1) * @PAGE_LINE
			--select 'DEBUG ', @idx2 idx2

			--------------------------------------------------------------
			-- �Խ��� ����.
			--------------------------------------------------------------
			DECLARE @tTempTableList TABLE(
				pagemax			int,
				page			int,

				idx				int,
				idx2			int,
				kind			int,
				gameid			varchar(20),
				message			varchar(256),
				writedate		datetime,
				schoolidx		int
			);

			if(@mode_ = @USERBOARD_MODE_WRITE)
				begin
					insert into @tTempTableList
					select top 10 @pagemax pagemax, @page page, idx, idx2, kind, gameid, message, writedate, schoolidx from dbo.tUserBoard
					where kind = @kind_ order by idx desc, idx2 desc
				end
			else
				begin
					insert into @tTempTableList
					select top 10 @pagemax pagemax, @page page, idx, idx2, kind, gameid, message, writedate, schoolidx from dbo.tUserBoard
					where idx2 <= @idx2 and kind = @kind_ order by idx desc, idx2 desc
				end


			-------------------------------------------------------------
			-- �Խ��ǿ� ���� ��ũ �ɱ�.
			-------------------------------------------------------------
			--select b.*, isnull(i.itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2 from
			--	(select gameid, anireplistidx from dbo.tUserMaster where gameid in (select gameid from @tTempTableList)) as m
			--LEFT JOIN
			--	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempTableList)) as i
			--ON
			--	m.gameid = i.gameid and m.anireplistidx = i.listidx
			--JOIN
			--	@tTempTableList b
			--ON
			--	m.gameid = b.gameid

			select b.*, isnull(m.itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaoprofile, kakaonickname from
				(select gameid, anirepitemcode itemcode, anirepacc1 acc1, anirepacc2 acc2, kakaoprofile, kakaonickname from dbo.tUserMaster where gameid in (select gameid from @tTempTableList)) as m
			JOIN
				@tTempTableList b
			ON
				m.gameid = b.gameid
			order by idx desc




		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

