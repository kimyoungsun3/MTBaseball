--################################################################
/*
-- select * from dbo.tGiftList where gameid = 'xxxx2' and giftkind in (1, 2) order by idx desc
-- delete from dbo.tGiftList where gameid = 'xxxx2'

exec spu_SubGiftSendNew 1,    -1, 0, 'SysLogin', 'xxxx2', 'message'			-- 메세지.

exec spu_SubGiftSendNew 2,     1,  1, 'SysLogin', 'xxxx2', ''				-- 젖소.
exec spu_SubGiftSendNew 2,   100,  1, 'SysLogin', 'xxxx2', ''				-- 양.
exec spu_SubGiftSendNew 2,   200,  1, 'SysLogin', 'xxxx2', ''				-- 산양.
exec spu_SubGiftSendNew 2,   700, 11, 'SysLogin', 'xxxx2', ''				-- 총알.
exec spu_SubGiftSendNew 2,   701, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   702, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   703, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   703, 0 , 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   800, 11, 'SysLogin', 'xxxx2', ''				-- 백신.
exec spu_SubGiftSendNew 2,   801, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   802, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   803, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   803,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,   900, 11, 'SysLogin', 'xxxx2', ''				-- 건초.
exec spu_SubGiftSendNew 2,   900,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1000, 11, 'SysLogin', 'xxxx2', ''				-- 일꾼.
exec spu_SubGiftSendNew 2,  1001, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1002, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1003, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1003,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1100, 11, 'SysLogin', 'xxxx2', ''				-- 촉진제.
exec spu_SubGiftSendNew 2,  1101, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1102, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1103, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1104, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1104,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1200, 11, 'SysLogin', 'xxxx2', ''				-- 부활석.
exec spu_SubGiftSendNew 2,  1201, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1201,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1600, 11, 'SysLogin', 'xxxx2', ''				-- 합성시간단축.
exec spu_SubGiftSendNew 2,  1601, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1602,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1900, 11, 'SysLogin', 'xxxx2', ''				-- 우정포인트.
exec spu_SubGiftSendNew 2,  1901, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1902,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1909, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  1909,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2000, 11, 'SysLogin', 'xxxx2', ''				-- 하트.
exec spu_SubGiftSendNew 2,  2001, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2002,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2006, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2006,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2100, 11, 'SysLogin', 'xxxx2', ''				-- 긴급요청티켓.
exec spu_SubGiftSendNew 2,  2101, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2101,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2200, 11, 'SysLogin', 'xxxx2', ''				-- 일반교배뽑기.
exec spu_SubGiftSendNew 2,  2201, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2202,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2300, 11, 'SysLogin', 'xxxx2', ''				-- 프리미엄교배뽑기.
exec spu_SubGiftSendNew 2,  2301, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  2302,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5000, 11, 'SysLogin', 'xxxx2', ''				-- 캐쉬선물
exec spu_SubGiftSendNew 2,  5001, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5002,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5006, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5006,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5100, 11, 'SysLogin', 'xxxx2', ''				-- 코인선물.
exec spu_SubGiftSendNew 2,  5101, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5102,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5109,  0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  5109, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  100000, 0, 'SysLogin', 'xxxx2', ''				-- 펫.
exec spu_SubGiftSendNew 2,  100005, 0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  3000,  0, 'SysLogin', 'xxxx2', ''				-- 황금티켓.
exec spu_SubGiftSendNew 2,  3000, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,  3100,  0, 'SysLogin', 'xxxx2', ''				-- 싸움티켓.
exec spu_SubGiftSendNew 2,  3100, 11, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104000,  1, 'SysLogin', 'xxxx2', ''				-- 줄기세포.
exec spu_SubGiftSendNew 2,104001,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104002,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104003,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104004,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104005,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,104006,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,120010,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120011,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,120013,  1, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,2500,    1, 'SysLogin', 'xxxx2', ''				-- 보물일반 티켓.
exec spu_SubGiftSendNew 2,2501,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,2600,    1, 'SysLogin', 'xxxx2', ''				-- 보물프리미엄 티켓.
exec spu_SubGiftSendNew 2,2601,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3500,    1, 'SysLogin', 'xxxx2', ''				-- 합성의 훈장
exec spu_SubGiftSendNew 2,3500,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3600,    1, 'SysLogin', 'xxxx2', ''				-- 승급의 꽃
exec spu_SubGiftSendNew 2,3600,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3700,    1, 'SysLogin', 'xxxx2', ''				-- 유저배틀박스
exec spu_SubGiftSendNew 2,3701,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3702,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3703,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3704,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3705,    0, 'SysLogin', 'xxxx2', ''				--
exec spu_SubGiftSendNew 2,3800,    1, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_SubGiftSendNew 2,3900,   99, 'SysLogin', 'xxxx2', ''				-- 캐쉬포인트.
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
	select @country = country from dbo.tUserMaster where gameid = @gameid_
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
								when @adminid_ = 'SysBattle'	then '싸움보상'
								when @adminid_ = 'SysRoul1'		then '일반동물교배'
								when @adminid_ = 'SysRoul2'		then '프리미엄교배'
								when @adminid_ = 'SysRoul4'		then '프리미엄교배10'
								when @adminid_ = 'SysTreasure1'	then '일반보물'
								when @adminid_ = 'SysTreasure2'	then '프리미엄보물'
								when @adminid_ = 'SysTreasure4'	then '프리미엄보물10'
								else @adminid_
							end
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

