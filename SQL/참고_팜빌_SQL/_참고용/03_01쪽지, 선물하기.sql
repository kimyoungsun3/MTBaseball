--################################################################
/*
-- 쪽지, 선물 기록하기(데일리 보상)
-- 200개까지만 기록하고 나머지는 삭제됨.
Exec Spu_Subgiftsend 1, -1, 'syslogin', 'xxxx', 'message'		-- ?????? ????
exec spu_FVSubGiftSend 2,  1, 'SysLogin', 'xxxx', ''				-- 특정아이템 지급

exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'xxxx6', ''				-- 젖소
exec spu_FVSubGiftSend 2,   100, 'SysLogin', 'xxxx6', ''				-- 양
exec spu_FVSubGiftSend 2,   200, 'SysLogin', 'xxxx6', ''				-- 산양
exec spu_FVSubGiftSend 2,   700, 'SysLogin', 'xxxx6', ''				-- 총알
exec spu_FVSubGiftSend 2,   800, 'SysLogin', 'xxxx6', ''				-- 치료제
exec spu_FVSubGiftSend 2,   900, 'SysLogin', 'xxxx6', ''				-- 건초
exec spu_FVSubGiftSend 2,  1000, 'SysLogin', 'xxxx6', ''				-- 일꾼
exec spu_FVSubGiftSend 2,  1100, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1200, 'SysLogin', 'xxxx6', ''				-- 부활석
exec spu_FVSubGiftSend 2,  1400, 'SysLogin', 'xxxx6', ''				-- 가축 악세사리
exec spu_FVSubGiftSend 2,  1900, 'SysLogin', 'xxxx6', ''				-- 우정포인트
exec spu_FVSubGiftSend 2,  2000, 'SysLogin', 'xxxx6', ''				-- 하트
exec spu_FVSubGiftSend 2,  5000, 'SysLogin', 'xxxx6', ''				-- 캐쉬선물
exec spu_FVSubGiftSend 2,  5100, 'SysLogin', 'xxxx6', ''				-- 코인선물
exec spu_FVSubGiftSend 2,  5200, 'SysLogin', 'xxxx6', ''				-- 뽑기
exec spu_FVSubGiftSend 2,  5300, 'SysLogin', 'xxxx6', ''				-- 대회
exec spu_FVSubGiftSend 1,    -1, 'SysLogin', 'xxxx6', 'message'		-- 메세지.
exec spu_FVSubGiftSend 2,  2200, 'SysLogin', 'xxxx6', ''				-- 상인100프로만족
exec spu_FVSubGiftSend 2,  2100, 'SysLogin', 'xxxx6', ''				-- 긴급요청티켓
exec spu_FVSubGiftSend 2,  2200, 'SysLogin', 'xxxx6', ''				-- 일반교배뽑기
exec spu_FVSubGiftSend 2,  2201, 'SysLogin', 'xxxx6', ''				-- 일반교배뽑기
exec spu_FVSubGiftSend 2,  2202, 'SysLogin', 'xxxx6', ''				-- 일반교배뽑기
exec spu_FVSubGiftSend 2,  2207, 'SysLogin', 'xxxx6', ''				-- 일반교배뽑기
exec spu_FVSubGiftSend 2,  2300, 'SysLogin', 'xxxx6', ''				-- 프리미엄교배뽑기
exec spu_FVSubGiftSend 2,  2307, 'SysLogin', 'xxxx6', ''				-- 프리미엄교배뽑기

exec spu_FVSubGiftSend 2,  100004, 'SysLogin', 'xxxx6', ''			-- 펫(6)
exec spu_FVSubGiftSend 2,  100008, 'SysLogin', 'xxxx6', ''			-- 펫(1)
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
	@adminid_								varchar(20),		--
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
	declare @country	int			set @country 	= 1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	--클러스터 인덱스를 이용.
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tFVGiftList where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	if(@kind_ = @GIFTLIST_GIFT_KIND_MESSAGE)
		BEGIN
			set @adminid_  = case
								when @adminid_ = 'roulhear' 	then '교배하트보상'
								when @adminid_ = 'KakaoInv' 	then '초대 보상'
								when (isnull(@adminid_, '') = '') then 'PictoSoft'
								else								  @adminid_
							end

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
			select @country = country from dbo.tFVUserMaster where gameid = @gameid_
			if(@country = 1)
				begin
					set @adminid_ = case
										when @adminid_ = 'SysCash' 		then '캐쉬선물'
										when @adminid_ = 'SysCert' 		then '쿠폰선물'
										when @adminid_ = 'SysRoul' 		then '교배지급'
										when @adminid_ = 'SysCom' 		then '퀘스트지급'
										when @adminid_ = 'SysRank' 		then '랭킹보상'
										when @adminid_ = 'SysLogin' 	then '로그인보상'
										when @adminid_ = 'DailyReward' 	then '출석보상'
										when @adminid_ = 'roulhear' 	then '교배하트보상'
										when @adminid_ = 'SysDogam' 	then '도감보상'
										when @adminid_ = 'SysTut' 		then '튜토리얼보상'
										when @adminid_ = 'SysHarvest' 	then '농장수확물'
										when @adminid_ = 'SysEpi' 		then '대회보상'
										when @adminid_ = 'SysTrade' 	then '상인보상'
										when @adminid_ = 'SysPack' 		then '패키지구매'
										when @adminid_ = 'KakaoInv' 	then '초대 보상'
										when @adminid_ = 'SysHelp' 		then '친구도움'
										when @adminid_ = 'SysHelp2' 	then '친구도움보상'
										when @adminid_ = 'SysAcc' 		then '액세서리뽑기'
										when @adminid_ = 'OpenEvent'	then '오픈이벤트'
										when @adminid_ = 'LvUpEvent'	then '레벨업이벤트'
										when @adminid_ = 'SpotChild'	then '어린이날보상'
										when @adminid_ = 'SpotSuka'		then '석가탄신보상'
										when @adminid_ = 'Compose'		then '합성지급'
										when @adminid_ = 'FarmBuy'		then '목장구매보상'
										when @adminid_ = 'SysBabau'		then '행운의보상'
										else @adminid_
									end
				end

			insert into dbo.tFVGiftList(gameid, giftkind, itemcode, giftid, message, idx2)
			values(@gameid_, @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @adminid_, @message_, @idx2);

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

