---------------------------------------------------------------
/*
-- 동물 판매.
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:65;2:69;', -1	-- 소(인벤 -1)
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:5;2:7;', -1	-- 총알
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:42;2:45;', -1	-- 줄기세포.
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '', -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ItemSellListSet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemSellListSet;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemSellListSet
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

	-- 기타오류
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @goldticket		int				set @goldticket	= 0
	declare @battleticket	int				set @battleticket= 0
	declare @anireplistidx	int				set @anireplistidx	= 1

	declare @kind			int
	declare @info			int
	declare @totalsellcost	int				set @totalsellcost	= 0
	declare @sellcost		int				set @sellcost		= 0
	declare @cnt 			int				set @cnt			= 0
	declare @itemcode 		int				set @itemcode 		= -1
	declare @loop			int				set @loop			= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost 		= cashcost,			@gamecost		= gamecost,			@heart			= heart,			@feed			= feed,
		@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@anireplistidx	= anireplistidx
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if( LEN(@listset_) < 4 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR 파라미터 오류입니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 판매 처리합니다.'

			------------------------------------------------------------------
			-- 정보보기.
			------------------------------------------------------------------
			-- 1. 커서 생성
			declare curUpgradeInfo Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. 커서오픈
			open curUpgradeInfo

			-- 3. 커서 사용
			Fetch next from curUpgradeInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					set @itemcode 		= -1
					set @sellcost		= 0
					set @cnt			= 0

					select @itemcode = itemcode, @cnt = cnt from dbo.tUserItem where gameid = @gameid_ and listidx = @info
					select @sellcost = sellcost from dbo.tItemInfo where itemcode = @itemcode
					--select 'DEBUG ', @itemcode itemcode, @cnt cnt, @sellcost sellcost

					if( @itemcode != -1 )
						begin
							exec spu_DeleteUserItemBackup 1, @gameid_, @info

							if(@anireplistidx = @info)
								begin
									set @anireplistidx = -444
								end

							set @totalsellcost = @totalsellcost + @sellcost * @cnt
							--select 'DEBUG ', @loop loop, @totalsellcost totalsellcost, @cnt cnt, @sellcost sellcost
						end

					set @loop = @loop + 1
					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curUpgradeInfo
			Deallocate curUpgradeInfo


			set @gamecost = @gamecost + @totalsellcost
		END

	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 아이템을 직접 넣어줌
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					gamecost		= @gamecost,
					anirepitemcode 	= case when (@anireplistidx = -444) then  1 else anirepitemcode end,
					anirepacc1	 	= case when (@anireplistidx = -444) then -1 else anirepacc1 end,
					anirepacc2 		= case when (@anireplistidx = -444) then -1 else anirepacc1 end
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

