--################################################################
/*
-- select * from dbo.tGiftList where gameid = 'xxxx2' and giftkind in (1, 2) order by idx desc
-- delete from dbo.tGiftList where gameid = 'xxxx2'

exec spu_SubGiftSendNew 1,    -1, 0, 'SysLogin', 'xxxx2', 'message'			-- 메세지.

exec spu_SubGiftSendNew 2,   101,  1, 'SysLogin', 'xxxx2', ''				-- 나무헬멧.
exec spu_SubGiftSendNew 2,  1500,  1, 'SysLogin', 'xxxx2', ''				-- 나무 헬멧 조각 A.
exec spu_SubGiftSendNew 2,  4000,  1, 'SysLogin', 'xxxx2', ''				-- 나무 조각 랜덤박스
exec spu_SubGiftSendNew 2,  4100,  1, 'SysLogin', 'xxxx2', ''				-- 나무 의상 랜덤박스.
exec spu_SubGiftSendNew 2,  4200,  1, 'SysLogin', 'xxxx2', ''				-- 조언 패키지 박스
exec spu_SubGiftSendNew 2,  4500, 11, 'SysLogin', 'xxxx2', ''				-- 조합 주문서
exec spu_SubGiftSendNew 2,  4501, 11, 'SysLogin', 'xxxx2', ''				-- 초월 주문서
exec spu_SubGiftSendNew 2,  4600, 11, 'SysLogin', 'xxxx2', ''				-- 응원의 소리
exec spu_SubGiftSendNew 2,  4601, 11, 'SysLogin', 'xxxx2', ''				-- 코치의 조언 주문서
exec spu_SubGiftSendNew 2,  4602, 11, 'SysLogin', 'xxxx2', ''				-- 감독의 조언 주문서
exec spu_SubGiftSendNew 2,  5000, 11, 'SysLogin', 'xxxx2', ''				-- 다이아 -> 수량을 인식함 (캐쉬만 그렇게 흘러감.)
exec spu_SubGiftSendNew 2,  5001, 11, 'SysLogin', 'xxxx2', ''				-- 수량인식을 못함
exec spu_SubGiftSendNew 2,  5002, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5003, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5004, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5005, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5006, 11, 'SysLogin', 'xxxx2', ''				--
*/
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SubGiftSendNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SubGiftSendNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SubGiftSendNew
	@kind_									int,
	@itemcode_								int,				-- 선물할 아이템 코드
	@cnt_									bigint,				--
	@adminid_								varchar(20),		--
	@gameid_								varchar(20),		-- 게임아이디
	@message_								varchar(256)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	declare @USER_LOGOLIST_MAX					int					set @USER_LOGOLIST_MAX 						= 200

	-- MT 아이템 소분류
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)


	------------------------------------------------
	declare @idx2			int			set @idx2 			= 0
	declare @bdel			int			set @bdel 			= 0
	declare @subcategory 	int 		set @subcategory	= -1
	declare @multistate		int			set @multistate		= 1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-1-2. 빈것은 리턴
	------------------------------------------------
	if( @kind_ = @GIFTLIST_GIFT_KIND_GIFT and @itemcode_ = -1 )
		begin
			return;
		end

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tGiftList where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	------------------------------------------------
	--	3-3. 해당언어.
	------------------------------------------------
	set @adminid_ = case
						when @adminid_ = 'SysCash' 		then '캐쉬구매'
						when @adminid_ = 'SysCert' 		then '쿠폰선물'
						when @adminid_ = 'SysLevelUp' 	then '레벨업지급'
						when @adminid_ = 'SysLogin' 	then '로그인보상'
						when @adminid_ = 'SysBetRoll' 	then '배팅롤백'
						else @adminid_
					end

	------------------------------------------------
	--	3-4. 캐쉬는 수량을 검사한다.
	------------------------------------------------
	select @subcategory = subcategory, @multistate = multistate from dbo.tItemInfo where itemcode = @itemcode_
	if( @subcategory in ( @ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST ) and @multistate = 0 )
		begin
			--select 'DEBUG 캐쉬 수량 무시하는 놈들임'
			set @cnt_ = 1
		end


	------------------------------------------------
	--	3-4. 선물하기.
	------------------------------------------------
	if(@kind_ = @GIFTLIST_GIFT_KIND_MESSAGE)
		BEGIN
			insert into dbo.tGiftList(gameid,                     giftkind,    giftid,   message,  idx2)
			values(                  @gameid_, @GIFTLIST_GIFT_KIND_MESSAGE, @adminid_, @message_, @idx2);

			set @bdel = 1
		END
	else if(@kind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			-- 특수한 경우에 사용됨.
			insert into dbo.tGiftList(gameid,                         giftkind,   message,  idx2)
			values(                  @gameid_, @GIFTLIST_GIFT_KIND_MESSAGE_DEL, @message_, @idx2);

			set @bdel = 1
		END
	else if(@kind_ = @GIFTLIST_GIFT_KIND_GIFT and @itemcode_ != -1)
		BEGIN
			insert into dbo.tGiftList(gameid,                   giftkind,   itemcode,   cnt,    giftid,   message,  idx2)
			values(                   @gameid_, @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @cnt_, @adminid_, @message_, @idx2);

			set @bdel = 1
		END
	else
		BEGIN
			set @message_ = ''
		END

	if(@bdel = 1)
		begin
			delete dbo.tGiftList
			where gameid = @gameid_
				  and idx2 < @idx2 - @USER_LOGOLIST_MAX
				  and giftkind <= @GIFTLIST_GIFT_KIND_MESSAGE_DEL

			-- 클라이언트 표시는 15일(서버는 30일로 보관) 지난 내용은 스케쥴이 삭제해줌.
			-- 삭제는 모든 데이타를 삭제함(안받은것도 삭제함....)
		end

	------------------------------------------------
	--	3-3. 결과
	------------------------------------------------
	set nocount off
End

