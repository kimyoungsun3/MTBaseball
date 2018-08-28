---------------------------------------------------------------
/*
-- 보물 스롯을 장착.
exec spu_RoulTreasureWear 'xxxx2', '049000s1i0n7t8445289',  '1:72;2:73;3:74;4:-1;5:-1;', -1
exec spu_RoulTreasureWear 'xxxx2', '049000s1i0n7t8445289',  '1:54;2:-1;3:-1;4:-1;5:-1;', -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_RoulTreasureWear', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulTreasureWear;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RoulTreasureWear
	@gameid_								varchar(20),
	@password_								varchar(20),
	@listset_								varchar(256),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_TREASURE			int				set @ITEM_MAINCATEGORY_TREASURE	 		= 1200	-- 보물(1200)

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid				varchar(20)		set @gameid				= ''
	declare @tslistidx1			int				set @tslistidx1			= -1
	declare @tslistidx2			int				set @tslistidx2			= -1
	declare @tslistidx3			int				set @tslistidx3			= -1
	declare @tslistidx4			int				set @tslistidx4			= -1
	declare @tslistidx5			int				set @tslistidx5			= -1

	declare @kind				int,
			@info				int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 	= gameid,
		@tslistidx1 = tslistidx1,	@tslistidx2 = tslistidx2,	@tslistidx3 = tslistidx3,	@tslistidx4 = tslistidx4,
		@tslistidx5 = tslistidx5
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @tslistidx1 tslistidx1, @tslistidx2 tslistidx2, @tslistidx3 tslistidx3, @tslistidx4 tslistidx4, @tslistidx5 tslistidx5

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 퀵슬롯 세팅합니다.'


			if( LEN( @listset_ ) >= 4 )
				begin
					-- 1. 커서 생성
					declare curUserInfo Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

					-- 2. 커서오픈
					open curUserInfo

					-- 3. 커서 사용
					Fetch next from curUserInfo into @kind, @info
					while @@Fetch_status = 0
						Begin

							if ( @info != -1 and exists( select top 1 * from dbo.tItemInfo
														where itemcode in ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @info )
															  and category = @ITEM_MAINCATEGORY_TREASURE ) )
								begin
									--select 'DEBUG 유지.', @kind kind, @info info
									set @info = @info
								end
							else
								begin
									--select 'DEBUG 클리어', @kind kind, @info info
									set @info = -1
								end


							if(@kind = 1)
								begin
									set @tslistidx1 		= @info
								end
							else if(@kind = 2)
								begin
									set @tslistidx2 		= @info
								end
							else if(@kind = 3)
								begin
									set @tslistidx3		 	= @info
								end
							else if(@kind = 4)
								begin
									set @tslistidx4 		= @info
								end
							else if(@kind = 5)
								begin
									set @tslistidx5 		= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curUserInfo
					Deallocate curUserInfo

					--------------------------------------------------------------
					-- 슬롯세팅.
					--------------------------------------------------------------
					update dbo.tUserMaster
						set
							tslistidx1 	= @tslistidx1,	tslistidx2 	= @tslistidx2,	tslistidx3 	= @tslistidx3,	tslistidx4 	= @tslistidx4,
							tslistidx5 	= @tslistidx5
					where gameid = @gameid_

					--------------------------------------------------------------
					-- 보물 장착템효과 세팅
					-- 저장된 정보로 하니까 여기서해야함...
					--------------------------------------------------------------
					exec spu_TSWearEffect @gameid_
				end

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @tslistidx1 tslistidx1, @tslistidx2 tslistidx2, @tslistidx3 tslistidx3, @tslistidx4 tslistidx4, @tslistidx5 tslistidx5

	set nocount off
End

