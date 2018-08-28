/*
-- select * from dbo.tFVUserFriend where gameid = 'xxxx2'
-- select * from dbo.tFVKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 ��û
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- �Ҽ����ޱ�.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- ��������.
-- update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  19, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 19, -1

exec spu_FVKakaoFriendHelp 'xxxx', '049000s1i0n7t8445289', 'xxxx2',  18, -1
exec spu_FVKakaoFriendHelp 'xxxx4', '049000s1i0n7t8445289', 'xxxx2', 18, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendHelp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendHelp;
GO

create procedure dbo.spu_FVKakaoFriendHelp
	@gameid_				varchar(60),
	@password_				varchar(20),
	@friendid_				varchar(20),
	@listidx_				int,
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @friendid			varchar(60)		set @friendid			= ''
	declare @listidx			int				set @listidx			= -1
	declare @helpdaycnt			int				set @helpdaycnt			= 99999
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @friendid_ friendid_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid 			= gameid,
		@market				= market
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ������', @gameid gameid

	select
		@friendid 			= gameid
	from dbo.tFVUserMaster
	where gameid = @friendid_
	--select 'DEBUG 1-2 ģ������', @friendid friendid

	select
		@helpdaycnt = datediff(d, helpdate, getdate())
	from dbo.tFVUserFriend
	where gameid = @gameid_ and friendid = @friendid_
	--select 'DEBUG 1-3 ģ����û��', @helpdaycnt helpdaycnt

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid = '' or @friendid = '' or @gameid = @friendid or @helpdaycnt = 99999)
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 2' + @comment
		end
	else if (@helpdaycnt < 1)
		begin
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR �ð��� �����ֽ��ϴ�.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'ģ������ �����ฦ ��û�߽��ϴ�.'
			--select 'DEBUG 4-1', @comment
			-------------------------------------
			-- �� īī�� ������ģ����(O)
			-------------------------------------
			exec spu_FVDayLogInfoStatic @market, 17, 1

			--------------------------------------------
			-- [��û] ��ŷ�ϱ�.
			--------------------------------------------
			--select 'DEBUG 4-2 [��û]����'
			update dbo.tFVUserFriend
				set
					helpdate = getdate()
			where gameid = @gameid_ and friendid = @friendid_

			--------------------------------------------
			-- [���] ��ŷ�ϱ�.
			--------------------------------------------
			if(not exists(select top 1 * from dbo.tFVKakaoHelpWait where gameid = @friendid_ and friendid = @gameid_ and listidx = @listidx_))
				begin
					--select 'DEBUG 4-3-1 [���]���'
					insert into dbo.tFVKakaoHelpWait(gameid,     friendid,   listidx)
					values(                    	  @friendid_, @gameid_,   @listidx_)
				end
			else
				begin
					--select 'DEBUG 4-3-1 [���]����'
					update dbo.tFVKakaoHelpWait
						set
							helpdate = getdate()
					where gameid = @friendid_ and friendid = @gameid_ and listidx = @listidx_
				end
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ģ������
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_
		end


	--���� ����� �����Ѵ�.
	set nocount off
End



