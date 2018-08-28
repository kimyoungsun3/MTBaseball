--################################################################
/*
-- update dbo.tFVUserMaster set concode = 82 where gameid = 'xxxx@gmail.com'
-- 쪽지, 선물 기록하기(데일리 보상)
-- 200개까지만 기록하고 나머지는 삭제됨.
exec spu_FVSubGiftSend 1,   -1,   0, 'SysCoup', 'xxxx@gmail.com', 'message'			-- ?????? ????
exec spu_FVSubGiftSend 2, 3000,  10, 'SysCoup', 'xxxx@gmail.com', ''					-- 유제품
exec spu_FVSubGiftSend 2, 3100, 100, 'SysCoup', 'xxxx@gmail.com', ''					-- 코인

select * from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
*/
--################################################################
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSubGiftSend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSubGiftSend;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSubGiftSend
	@kind_									int,
	@itemcode_								int,				-- 선물할 아이템 코드
	@cnt_									bigint,				--
	@adminid_								varchar(60),		--
	@gameid_								varchar(60),		-- 게임아이디
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


	declare @USER_GIFTLIST_MAX					int					set @USER_GIFTLIST_MAX 						= 1000
	------------------------------------------------
	declare @idx2		int			set @idx2 		= 0
	declare @bdel		int			set @bdel 		= 0
	declare @concode	int			set @concode	= 82

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @kind_ kind_, @itemcode_ itemcode_, @cnt_ cnt_, @adminid_ adminid_, @gameid_ gameid_, @message_ message_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	--클러스터 인덱스를 이용.
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tFVGiftList where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	------------------------------------------------
	--	3-1. 해당언어.
	------------------------------------------------
	select @concode = concode from dbo.tFVUserMaster where gameid = @gameid_
	set @adminid_ = case
						when (@adminid_ = 'SysCoup' and @concode = 82) 		then '쿠폰보상'
						when (@adminid_ = 'SysCoup' and @concode = 81) 		then 'Reward'
						when (@adminid_ = 'SysCoup' and @concode =  1) 		then 'Reward'
						when (@adminid_ = 'SysCoup') 						then '쿠폰보상'
						when (@adminid_ = 'SysDaily' and @concode = 82) 	then '1일보상'
						when (@adminid_ = 'SysDaily' and @concode = 81) 	then 'Daily'
						when (@adminid_ = 'SysDaily' and @concode =  1) 	then 'Daily'
						when (@adminid_ = 'SysDaily') 						then '1일보상'
						when (@adminid_ = 'NewID' and @concode = 82)	 	then '정착지원금'
						when (@adminid_ = 'NewID' and @concode = 81) 		then 'Grant'
						when (@adminid_ = 'NewID' and @concode =  1) 		then 'Grant'
						when (@adminid_ = 'NewID') 							then 'Grant'
						else @adminid_
					end

	if(@kind_ = @GIFTLIST_GIFT_KIND_MESSAGE)
		BEGIN
			--set @adminid_  = case
			--					when @adminid_ = 'roulhear' 	then '교배하트보상'
			--					when (isnull(@adminid_, '') = '') then 'sangsang'
			--					else								  @adminid_
			--				end

			insert into dbo.tFVGiftList(gameid, giftkind, giftid, message, idx2)
			values(@gameid_, @GIFTLIST_GIFT_KIND_MESSAGE, @adminid_, @message_, @idx2);

			set @bdel = 1
		END
	else if(@kind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			-- 특수한 경우에 사용됨.
			insert into dbo.tFVGiftList(gameid, giftkind, message, idx2)
			values(@gameid_, @GIFTLIST_GIFT_KIND_MESSAGE_DEL, @message_, @idx2);

			set @bdel = 1
		END
	else if(@kind_ = @GIFTLIST_GIFT_KIND_GIFT and @itemcode_ != -1)
		BEGIN


			insert into dbo.tFVGiftList(gameid,   giftkind,                 itemcode,    cnt,    giftid,   message,   idx2)
			values(                    @gameid_, @GIFTLIST_GIFT_KIND_GIFT, @itemcode_,  @cnt_, @adminid_, @message_, @idx2);

			set @bdel = 1
		END
	else
		BEGIN
			set @message_ = ''
		END

	if(@bdel = 1)
		begin
			delete dbo.tFVGiftList
			where gameid = @gameid_
				  and idx2 < @idx2 - @USER_GIFTLIST_MAX
				  and giftkind <= @GIFTLIST_GIFT_KIND_MESSAGE_DEL
		end

	------------------------------------------------
	--	3-3. 결과
	------------------------------------------------
	set nocount off
End

