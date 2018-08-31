use Game4FarmVill3
GO

/*
exec spu_FVGiftGain 'farm60142592', '2691871m3r2c5r237243', -3,  733181, -1		-- 유제품


exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -1,  1, -1		-- 쪽지받기(삭제)
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3,  2, -1		-- 유제품
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3,  3, -1		-- 코인

exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -5, -1, -1		-- 리스트갱신
*/
IF OBJECT_ID ( 'dbo.spu_FVGiftGain', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGiftGain;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVGiftGain
	@gameid_				varchar(60),						-- 게임아이디
	@password_				varchar(20),						--
	@giftkind_				int,								--  1:메시지
																--  2:선물
																-- -1:메시지삭제
																-- -2:선물삭제
																-- -3:선물받아감
	@idx_					bigint,								-- 선물인덱스
	@nResult_				int					OUTPUT
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

	-- 선물 코드값
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid 		varchar(60)			set @gameid			= ''
	declare @itemcode		int					set @itemcode		= -1
	declare @cnt			bigint				set @cnt			= 0
	declare @giftkind		int					set @giftkind 		= -1
	declare @subcategory 	int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @giftkind_ giftkind_, @idx_ idx_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@cnt		= cnt
	from dbo.tFVGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 3-2-2 선물/쪽지', @giftkind giftkind, @itemcode itemcode, @cnt cnt

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 리스트 갱신.'
			--select 'DEBUG ' + @comment
		END
	else if isnull(@giftkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
			set @comment = 'ERROR 선물, 쪽지 존재자체를 안함'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
			set @comment = 'ERROR 지급 및 삭제되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind_ not in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드값입니다.'
			--select 'DEBUG ' + @comment

		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 메세지 삭제 처리합니다.'
			--select 'DEBUG ' + @comment

			update dbo.tFVGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 삭제 처리합니다.'
			----select 'DEBUG ' + @comment

			update dbo.tFVGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
		END

	------------------------------------------------
	--	3-2. 수량을 리턴해준다.
	------------------------------------------------
	if(@nResult_ != @RESULT_SUCCESS)
		BEGIN
			set @itemcode 	= -1
			set @cnt 		= 0
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off

	--------------------------------------------------------------
	-- 결과
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @itemcode itemcode, @cnt cnt

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

End

