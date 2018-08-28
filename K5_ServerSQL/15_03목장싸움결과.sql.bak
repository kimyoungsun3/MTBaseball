/*
--delete from dbo.tBattleLog where gameid = 'xxxx2'
select * from dbo.tBattleLog where gameid = 'xxxx2' order by idx desc

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 17,  1, 90, 3, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 17, -1, 90, 0, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 62,  1, 90, 2, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 61,  1, 90, 1, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 65,  1, 90, 3, -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniBattleResult', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniBattleResult;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniBattleResult
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@battleidx2_							int,
	@result_								int,
	@playtime_								int,
	@star_									int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- 티켓수량부족.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 소분류.
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.

	-- 선물정보.
	--declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 결과정보.
	declare @BATTLE_RESULT_WIN					int					set @BATTLE_RESULT_WIN				=  1	-- (농장)
	--declare @BATTLE_RESULT_LOSE				int					set @BATTLE_RESULT_LOSE				= -1
	--declare @BATTLE_RESULT_DRAW				int					set @BATTLE_RESULT_DRAW				=  0

	-- 플레그정보.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	--declare @DEFINE_TIME_BASE					int					set @DEFINE_TIME_BASE				= 8000 -- 8초
	--declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- 12개월 * 40년.
	declare @GOLDTICKET_ITEMCODE				int					set @GOLDTICKET_ITEMCODE			= 3000

	-- 상인잠금상태.
	declare @TRADE_STATE_OPEN					int					set @TRADE_STATE_OPEN						= 1	 	-- 상인오픈(1)
	declare @TRADE_STATE_CLOSE					int					set @TRADE_STATE_CLOSE						= -1	-- 상인잠김(-1)

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost 			= 0
	declare @gamecost				int					set @gamecost 			= 0
	declare @heart					int					set @heart 				= 0
	declare @feed					int					set @feed 				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @goldticket				int					set @goldticket			= 0
	declare @goldticketmax			int					set @goldticketmax		= 0
	declare @goldtickettime			datetime			set @goldtickettime		= getdate()
	declare @battleticket			int					set @battleticket		= 0
	declare @battleticketmax		int					set @battleticketmax	= 0
	declare @battletickettime		datetime			set @battletickettime	= getdate()
	declare @battleflag				int					set @battleflag			= @BATTLE_END
	declare @farmidx				int					set @farmidx			= 6900
	declare @star					int					set @star				=  0
	declare @needticket				int					set @needticket			= 4
	declare @tradestate				int					set @tradestate			= @TRADE_STATE_CLOSE

	declare @result					int					set @result				= -444
	declare @reward1				int					set @reward1			= -1
	declare @reward2				int					set @reward2			= -1
	declare @reward3				int					set @reward3			= -1
	declare @reward4				int					set @reward4			= -1
	declare @rewardgoldticket		int					set @rewardgoldticket	= -1
	declare @rewardgamecost			int					set @rewardgamecost		=  0

	declare @rd1					int					set @rd1				= -1
	declare @rd2					int					set @rd2				= -1
	declare @rd3					int					set @rd3				= -1
	declare @rd4					int					set @rd4				= -1
	declare @rdgoldticket			int					set @rdgoldticket		=  0
	declare @rdgamecost				int					set @rdgamecost			=  0

	declare @sendid					varchar(60)			set @sendid				= 'SysBattle'
	declare @rand					int,
			@cnt					int

	declare @listidx1				int					set @listidx1			= -1
	declare @listidx2				int					set @listidx2			= -1
	declare @listidx3				int					set @listidx3			= -1
	declare @listidx4				int					set @listidx4			= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @battleidx2_ battleidx2_, @result_ result_, @playtime_ playtime_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart				= heart,			@feed			= feed,				@fpoint			= fpoint,
		@star			= star,
		@tradestate		= tradestate,
		@battleflag		= battleflag,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	select
		@result			= result,	@farmidx		= farmidx
	from dbo.tBattleLog
	where gameid = @gameid_ and idx2 = @battleidx2_
	--select 'DEBUG 배틀정보', @battleidx2_ battleidx2_, @result result, @farmidx farmidx

	select
		@needticket		= param14,
		@rd1 			= param23, @rd2 		= param24, @rd3 	= param25, @rd4 	= param26,
		@rdgoldticket 	= param27, @rdgamecost 	= param28
	from dbo.tItemInfo
	where itemcode = @farmidx
	--select 'DEBUG 필요수량정보.', @farmidx farmidx, @rd1 rd1, @rd2 rd2, @rd3 rd3, @rd4 rd4, @rdgoldticket rdgoldticket, @rdgamecost rdgamecost

	if(@gameid != '')
		begin
			------------------------------------------------
			-- 티켓 수량 정리.
			------------------------------------------------
			select
				@goldtickettime = rtndate,
				@goldticket		= rtncount
			from dbo.fnu_GetActionTime(@goldtickettime, getdate(), @goldticket, @goldticketmax)
			--select 'DEBUG ', @goldtickettime goldtickettime, @goldticket goldticket, @goldticketmax goldticketmax

			select
				@battletickettime 	= rtndate,
				@battleticket		= rtncount
			from dbo.fnu_GetActionTime(@battletickettime, getdate(), @battleticket, @battleticketmax)
			--select 'DEBUG ', @battletickettime battletickettime, @battleticket battleticket, @battleticketmax battleticketmax
		end

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	--else if(@needticket > @battleticket)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_TICKET_LACK
	--		set @comment 	= 'ERROR 티켓수량이 부족합니다.'
	--		--select 'DEBUG ' + @comment
	--	END
	else if(@battleflag != @BATTLE_READY)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.(미진행중 완료 패스용)'
			--select 'DEBUG ' + @comment
		END
	else if(@result = -444)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.(로고가 없어서 완료 패스용)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.'
			--select 'DEBUG ' + @comment


			if( @result_ = @BATTLE_RESULT_WIN )
				begin
					-- 줄기세포1 ~ 4.
					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward1= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd1, @rd1 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward2= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd2, @rd2 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward3= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd3, @rd3 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward4= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 95, @rd4, @rd4 - 10)
					--select 'DEBUG (전)', @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4

					set @rand  	= Convert(int, ceiling(RAND() * 10000))
					--select 'DEBUG0 (후)', @tradestate tradestate, @rand rand
					set @rand = dbo.fun_GetDealerStateValue( 12,  @tradestate, @rand ) -- 목장배틀 세포수량(12)
					--select 'DEBUG0 (전)', @tradestate tradestate, @rand rand
					--select 'DEBUG ', @rand rand
					if( @rand > 9300 )
						begin
							set @cnt 		= 4
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= @reward3
							set @reward4 	= @reward4
						end
					else if( @rand > 8300 )
						begin
							set @cnt 		= 3
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= @reward3
							set @reward4 	= -1
						end
					else if( @rand > 3000 )
						begin
							set @cnt 		= 2
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= -1
							set @reward4 	= -1
						end
					else
						begin
							set @cnt 		= 1
							set @reward1 	= @reward1
							set @reward2 	= -1
							set @reward3 	= -1
							set @reward4 	= -1
						end
					--select 'DEBUG (후)', @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4

					-- 황금티켓.
					set @rand  	= Convert(int, ceiling(RAND() * 10000))
					if( @rdgoldticket = 1 and @cnt <= 2 and @goldticket < @goldticketmax and @rand > 7000)
						begin
							set @rewardgoldticket = @GOLDTICKET_ITEMCODE
						end
					--select 'DEBUG ', @rewardgoldticket rewardgoldticket

					-- 코인.
					set @rewardgamecost = @rdgamecost + @rdgamecost * (10 + Convert(int, ceiling(RAND() * 20))) / 100
					--select 'DEBUG0 (전)', @tradestate tradestate, @rdgamecost rdgamecost, @rewardgamecost rewardgamecost
					set @rewardgamecost = dbo.fun_GetDealerStateValue( 11,  @tradestate, @rewardgamecost ) -- 목장배틀 코인(11)
					--select 'DEBUG0 (후)', @tradestate tradestate, @rdgamecost rdgamecost, @rewardgamecost rewardgamecost

					--------------------------------------------------
					---- 해당템 -> 선물
					--------------------------------------------------
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward1, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward2, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward3, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward4, 1, @sendid, @gameid_, ''
					------------------------------------------------
					-- 해당템 -> 직접
					------------------------------------------------
					exec spu_SetDirectItem @gameid_, @reward1, 1, @nResult_ = @listidx1 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward2, 1, @nResult_ = @listidx2 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward3, 1, @nResult_ = @listidx3 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward4, 1, @nResult_ = @listidx4 OUTPUT
					if( @rewardgoldticket = @GOLDTICKET_ITEMCODE )
						begin
							set @goldticket = @goldticket + 1
						end
					set @gamecost = @gamecost + @rewardgamecost


					------------------------------------------------
					-- 스타처리해주기.
					------------------------------------------------
					update dbo.tUserFarm
						set
							playcnt = playcnt - 1,
							@star 	= @star + case when ( @star_ > star ) then @star_ - star else    0 end,
							star 	=         case when ( @star_ > star ) then @star_        else star end
					where gameid = @gameid_ and itemcode = @farmidx
					--select 'DEBUG 농장스타', @farmidx farmidx, @star_ star_, @star star

					---------------------------------------------
					-- 배틀티켓 사용량 차감.
					---------------------------------------------
					--set @battleticket = @battleticket - @needticket

					------------------------------------------------
					-- 랭킹대전 정보수집.
					------------------------------------------------
					exec spu_subRankDaJun @gameid_, 0, 0, 1, 0, 0, 0, 0		-- 배틀 포인트
				end
			--else
			--	begin
			--		-- 실패나 기권은 없음
			--		--set @rewardgamecost = 0
			--	end

			----------------------------------
			-- 유저정보갱신.
			----------------------------------

			update dbo.tUserMaster
				set
					star			= @star,
					bkbattlecnt		= bkbattlecnt + case when ( @result_ = @BATTLE_RESULT_WIN ) then 1 else 0 end,
					bgbattlecnt	= bgbattlecnt + case when ( @result_ = @BATTLE_RESULT_WIN ) then 1 else 0 end,
					goldticket		= @goldticket,
					goldtickettime	= @goldtickettime,
					battleticket	= @battleticket,
					battletickettime= @battletickettime,
					battleflag		= @BATTLE_END,
					gamecost		= @gamecost
			where gameid = @gameid_

			----------------------------------
			-- 로고 정보갱신
			----------------------------------
			update dbo.tBattleLog
				set
					result 		= @result_,		playtime	= @playtime_,
					reward1		= @reward1,		reward2		= @reward2,		reward3		= @reward3,
					reward4		= @reward4,		reward5		= @rewardgoldticket,
					rewardgamecost = @rewardgamecost,
					star		= @star_
			where gameid = @gameid_ and idx2 = @battleidx2_


		END


	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket, @goldtickettime goldtickettime, @battletickettime battletickettime, @goldticketmax goldticketmax, @battleticketmax battleticketmax, @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4, @rewardgoldticket rewardgoldticket, @rewardgamecost rewardgamecost, @star star
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@listidx1, @listidx2, @listidx3, @listidx4)

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			--exec spu_GiftList @gameid_
		end
End

