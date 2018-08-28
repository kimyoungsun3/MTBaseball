/*
update dbo.tFVUserMaster set resultcopy= 0, cashcopy = 0, blockstate = 0 where gameid = 'xxxx2'
exec spu_FVSubUnusualRecord2  'xxxx2', 0, '결과치트Test'
select resultcopy, cashcopy, blockstate from dbo.tFVUserMaster where gameid = 'xxxx2'
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSubUnusualRecord2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSubUnusualRecord2;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSubUnusualRecord2
	@gameid_								varchar(60),		-- 게임아이디
	@resultcopy_							int,
	@comment_								varchar(512)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	declare @BLOCK_RESULTCOPY_MAX				int					set @BLOCK_RESULTCOPY_MAX			= 20
	declare @BLOCK_CASHCOPY_MAX					int					set @BLOCK_CASHCOPY_MAX				= 2

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @resultcopy		int			set @resultcopy		= -444
	declare @cashcopy		int			set @cashcopy		= -444

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @resultcopy_ resultcopy_, @comment_ comment_
	select
		@resultcopy = resultcopy,
		@cashcopy	= cashcopy
	from dbo.tFVUserMaster
	where gameid = @gameid_

	--select 'DEBUG ', @resultcopy resultcopy, @cashcopy cashcopy

	if(@resultcopy != -444 and @resultcopy_ >= 0)
		BEGIN
			set @resultcopy = @resultcopy + @resultcopy_
			--select 'DEBUG ', @resultcopy resultcopy, @cashcopy cashcopy

			--if(@resultcopy >= @BLOCK_RESULTCOPY_MAX or @cashcopy >= @BLOCK_CASHCOPY_MAX)
			--	begin
			--		--select 'DEBUG 치트 많아서 > 블럭 처리함.'
			--		update dbo.tFVUserMaster
			--			set
			--				blockstate		= @BLOCK_STATE_YES,
			--				resultcopy 		= 0,
			--				cashcopy		= 0
			--		where gameid = @gameid_
            --
			--		set @comment_ = @comment_ + '(블럭됨)'
			--	end
			--else
			--	begin
			--		--select 'DEBUG 치트 들어와서 > 기록함.'
			--		update dbo.tFVUserMaster
			--			set
			--				resultcopy 		= @resultcopy,
			--				cashcopy		= @cashcopy
			--		where gameid = @gameid_
			--	end

			insert into dbo.tFVUserUnusualLog2(gameid, comment) values(@gameid_, @comment_)
		END

	------------------------------------------------
	set nocount off
End

