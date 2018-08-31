use Game4FarmVill3
GO
/*
delete from dbo.tFVGiftList where gameid in ('xxxx2', 'xxxx6', 'farm60153115')
update dbo.tFVUserMaster set ownercashcost = 100 where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set randserial = -1, ownercashcost = 100, roulfreetimetotal = 0, roulfreehearttotal = 0, roulcashcosttotal = 0, roulcashcostgauage = 0, roulcashcostfree = 0 where gameid in ('xxxx2', 'xxxx6', 'farm60153115')
update dbo.tFVUserMaster set randserial = -1, roulfreetimedate = '20150514', roulfreetimehour = 16, roulfreeheartdate = '20150514', roulfreeheartcnt = 3 where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set randserial = -1 where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set randserial = -1 where gameid in ('xxxx2', 'xxxx6')

exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 'savedata1', 7771, -1			-- 무료 시간 뽑기 (12, 18, 21).
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 2, 'savedata2', 7772, -1			-- 무료 하트 뽑기
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 3, 'savedata3', 7773, -1			-- 캐쉬뽑기
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 4, 'savedata4', 7774, -1			-- 캐쉬뽑기2

exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289',13, 'savedata12', 7713, -1			-- 캐쉬뽑기  (이벤트 게이지).
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289',14, 'savedata13', 7714, -1			-- 캐쉬뽑기2 (이벤트 게이지).

exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289',22, 'savedata2', 7722, -1			-- 무료티켓.
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289',23, 'savedata3', 7723, -1			-- 캐쉬티켓.
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289',23, 'savedata4', 7724, -1			-- 캐쉬티켓2.
*/

IF OBJECT_ID ( 'dbo.spu_FVRoulBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRoulBuy
	@gameid_								varchar(60),
	@password_								varchar(20),
	@mode_									int,
	@savedata_								varchar(4096),
	@randserial_							varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	declare @RESULT_ERROR_ROULFREE_ALREADY		int				set @RESULT_ERROR_ROULFREE_ALREADY		= -161			-- 시간대별 무료 뽑기를 이미 사용했습니다.
	declare @RESULT_ERROR_ROULFREE_NOT_TIME		int				set @RESULT_ERROR_ROULFREE_NOT_TIME		= -162			-- 무료 뽑기 시간이 아닙니다.
	declare @RESULT_ERROR_HEART_ROUL_3TIME_OVER	int				set @RESULT_ERROR_HEART_ROUL_3TIME_OVER	= -163			-- 무엇인가 이미보상했음.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 뽑기 상수.
	declare @MODE_ROULETTE_FREE_TIME			int					set @MODE_ROULETTE_FREE_TIME				= 1		-- 무료 시간 뽑기 (12, 18, 21).
	declare @MODE_ROULETTE_FREE_HEART			int					set @MODE_ROULETTE_FREE_HEART				= 2		-- 무료 하트 뽑기
	declare @MODE_ROULETTE_CASHCOST				int					set @MODE_ROULETTE_CASHCOST					= 3		-- 캐쉬뽑기
	declare @MODE_ROULETTE_CASHCOST2			int					set @MODE_ROULETTE_CASHCOST2				= 4		-- 캐쉬뽑기2
	declare @MODE_ROULETTE_CASHCOST_FREE		int					set @MODE_ROULETTE_CASHCOST_FREE			= 13	-- 캐쉬뽑기  (이벤트 게이지).
	declare @MODE_ROULETTE_CASHCOST2_FREE		int					set @MODE_ROULETTE_CASHCOST2_FREE			= 14	-- 캐쉬뽑기2 (이벤트 게이지).
	declare @MODE_ROULETTE_FREE_TICKET			int					set @MODE_ROULETTE_FREE_TICKET				= 22	-- 무료티켓.
	declare @MODE_ROULETTE_CASHCOST_TICKET		int					set @MODE_ROULETTE_CASHCOST_TICKET			= 23	-- 캐쉬티켓.
	declare @MODE_ROULETTE_CASHCOST2_TICKET		int					set @MODE_ROULETTE_CASHCOST2_TICKET			= 24	-- 캐쉬티켓2.

	declare @ANIMAL_ONE_CASHCOST				int 				set @ANIMAL_ONE_CASHCOST					= 150
	declare @ANIMAL_FIVE_CASHCOST				int 				set @ANIMAL_FIVE_CASHCOST					= 600

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @comment2				varchar(512)	set @comment2			= ''
	declare @gameid					varchar(60)		set @gameid				= ''
	declare @sendid					varchar(60)		set @sendid				= ''
	declare @ownercashcost			bigint			set @ownercashcost		= 0
	declare @ownercashcost2			bigint			set @ownercashcost2		= 0
	declare @strange				int				set @strange			= -1
	declare @nickname				varchar(40)		set @nickname			= ''
	declare @market					int				set @market				= 1
	declare @randserial				varchar(20)		set @randserial			= ''

	-- 뽑기.
	declare @roulfreetimetotal		int				set @roulfreetimetotal		= 0
	declare @roulfreetimedate		varchar(8)		set @roulfreetimedate		= '20100101'
	declare @roulfreetimehour		int				set @roulfreetimehour		= 0

	declare @roulfreehearttotal		int				set @roulfreehearttotal		= 0
	declare @roulfreeheartdate		varchar(8)		set @roulfreeheartdate		= '20100101'
	declare @roulfreeheartcnt		int				set @roulfreeheartcnt		= 0

	declare @roulcashcosttotal		int				set @roulcashcosttotal		= 0
	declare @roulcashcostgauage		int				set @roulcashcostgauage		= 0
	declare @roulcashcostfree		int				set @roulcashcostfree		= 0
	--declare @roulcashcostfreetotal	int				set @roulcashcostfreetotal	= 0

	declare @roulcashcost2total		int				set @roulcashcost2total		= 0
	declare @roulcashcost2gauage	int				set @roulcashcost2gauage	= 0
	declare @roulcashcost2free		int				set @roulcashcost2free		= 0
	--declare @roulcashcost2freetotal	int				set @roulcashcost2freetotal	= 0

	--declare @roulfreetickettotal	int				set @roulfreetickettotal	= 0
	--declare @roulcashcosttickettotal	int			set @roulcashcosttickettotal= 0
	--declare @roulcashcost2tickettotal	int			set @roulcashcost2tickettotal= 0

	declare @bestani				int
	declare @needcashcost			int				set @needcashcost		= 0
	declare @needgamecost			int				set @needgamecost		= 0
	declare @needheart				int				set @needheart			= 0

	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @pack6					int				set @pack6				= -1
	declare @pack7					int				set @pack7				= -1
	declare @pack8					int				set @pack8				= -1
	declare @pack9					int				set @pack9				= -1
	declare @pack10					int				set @pack10				= -1
	declare @pack11					int				set @pack11				= -1
	declare @pack12					int				set @pack12				= -1
	declare @pack13					int				set @pack13				= -1
	declare @pack14					int				set @pack14				= -1
	declare @pack15					int				set @pack15				= -1
	declare @pack16					int				set @pack16				= -1
	declare @pack17					int				set @pack17				= -1
	declare @pack18					int				set @pack18				= -1
	declare @pack19					int				set @pack19				= -1
	declare @pack20					int				set @pack20				= -1
	declare @pack21					int				set @pack21				= -1
	declare @pack22					int				set @pack22				= -1
	declare @pack23					int				set @pack23				= -1
	declare @pack24					int				set @pack24				= -1
	declare @pack25					int				set @pack25				= -1
	declare @pack26					int				set @pack26				= -1
	declare @pack27					int				set @pack27				= -1
	declare @pack28					int				set @pack28				= -1
	declare @pack29					int				set @pack29				= -1
	declare @pack30					int				set @pack30				= -1
	declare @pack31					int				set @pack31				= -1
	declare @pack32					int				set @pack32				= -1
	declare @pack33					int				set @pack33				= -1
	declare @pack34					int				set @pack34				= -1
	declare @pack35					int				set @pack35				= -1
	declare @pack36					int				set @pack36				= -1
	declare @pack37					int				set @pack37				= -1
	declare @pack38					int				set @pack38				= -1
	declare @pack39					int				set @pack39				= -1
	declare @pack40					int				set @pack40				= -1

	declare @roul1					int				set @roul1				= -1
	declare @roul2					int				set @roul2				= -1
	declare @roul3					int				set @roul3				= -1
	declare @roul4					int				set @roul4				= -1
	declare @roul5					int				set @roul5				= -1

	declare @group1			int,	@group2				int,	@group3			int,	@group4		int,
			@rand			int,	@rand2				int
	declare @cnt					int				set @cnt				= 1

	declare @curdate				datetime		set @curdate		= getdate()
	declare @curhour				int				set @curhour		= -1
	declare @curdate8				varchar(8)		set @curdate8		= '20000102'

	-- 보물할인.
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- 보물보상(보상템).
	declare @checkitemcode			int				set @checkitemcode		= -1
	declare @checkreward			int				set @checkreward		= -1
	declare @checkrewardcnt			int				set @checkrewardcnt		= -1

	-- 보물보상.
	declare @roulrewardflag			int				set @roulrewardflag		= -1
	declare @roulani1				int				set @roulani1			= -1
	declare @roulani2				int				set @roulani2			= -1
	declare @roulani3				int				set @roulani3			= -1
	declare @roulreward1			int				set @roulreward1		= -1
	declare @roulreward2			int				set @roulreward2		= -1
	declare @roulreward3			int				set @roulreward3		= -1
	declare @roulrewardcnt1			int				set @roulrewardcnt1		=  0
	declare @roulrewardcnt2			int				set @roulrewardcnt2		=  0
	declare @roulrewardcnt3			int				set @roulrewardcnt3		=  0
	declare @roulname1				varchar(20)		set @roulname1			= ''
	declare @roulname2				varchar(20)		set @roulname2			= ''
	declare @roulname3				varchar(20)		set @roulname3			= ''

	-- 보물확률상승.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- 보물무료뽑기.
	declare @roulgauageflag			int				set @roulgauageflag			= -1
	declare @PMGAUAGEPOINT			int				set @PMGAUAGEPOINT			= 10
	declare @PMGAUAGEMAX			int				set @PMGAUAGEMAX			= 100
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @randserial_ randserial_, @savedata_ savedata_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 			= gameid,				@nickname 			= nickname,				@market				= market,				@bestani		= bestani,
		@ownercashcost		= ownercashcost,
		@roul1				= bgroul1,				@roul2				= bgroul2,				@roul3				= bgroul3, 				@roul4			= bgroul4,		@roul5			= bgroul5,
		@roulfreetimetotal	= roulfreetimetotal,	@roulfreetimedate	= roulfreetimedate, 	@roulfreetimehour 	= roulfreetimehour,
		@roulfreehearttotal	= roulfreehearttotal,	@roulfreeheartdate	= roulfreeheartdate,	@roulfreeheartcnt	= roulfreeheartcnt,
		@roulcashcosttotal	= roulcashcosttotal,	@roulcashcostgauage	= roulcashcostgauage,	@roulcashcostfree	= roulcashcostfree,
		@roulcashcost2total	= roulcashcost2total,	@roulcashcost2gauage= roulcashcost2gauage,	@roulcashcost2free	= roulcashcost2free,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @nickname nickname, @market market, @bestani bestani, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roulfreetimetotal roulfreetimetotal, @roulfreetimedate roulfreetimedate, @roulfreetimehour roulfreetimehour, @roulfreehearttotal roulfreehearttotal,	@roulfreeheartdate roulfreeheartdate, @roulfreeheartcnt roulfreeheartcnt, @roulcashcosttotal roulcashcosttotal, @roulcashcostgauage roulcashcostgauage, @roulcashcostfree roulcashcostfree, @roulcashcost2total roulcashcost2total, @roulcashcost2gauage roulcashcost2gauage, @roulcashcost2free roulcashcost2free

	------------------------------------------------
	-- 뽑기 이벤트 정보 가져오기.
	------------------------------------------------
	select
		top 1
		-- 보물할인
		@roulsaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end,
		@roulsalevalue	= case when @roulsaleflag = -1 then 0 else roulsalevalue end,

		-- 보물보상 	> 무엇을 뽑으면 결정지급
		@roulrewardflag = case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,
		@roulani1		= roulani1,			@roulani2		= roulani2,			@roulani3		= roulani3,
		@roulreward1	= roulreward1,		@roulreward2	= roulreward2,		@roulreward3	= roulreward3,
		@roulrewardcnt1	= roulrewardcnt1,	@roulrewardcnt2	= roulrewardcnt2,	@roulrewardcnt3	= roulrewardcnt3,
		@roulname1		= roulname1,		@roulname2		= roulname2,		@roulname3		= roulname3,

		-- 보물확률상승 > 특정 시간에 확률상승.
		@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
		@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3,		@roultimetime4	= roultimetime4,

		-- 보물무료뽑기	> 뽑기 x회후에 1회 무료.
		@roulgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,
		@PMGAUAGEPOINT	= pmgauagepoint,
		@PMGAUAGEMAX	= pmgauagemax
	from dbo.tFVSystemRouletteMan
	where roulmarket = @market
	order by idx desc
	--select 'DEBUG ', @roulrewardflag roulrewardflag, @roultimeflag roultimeflag, @roulgauageflag roulgauageflag

	----------------------------------------
	-- 뽑기정보.
	----------------------------------------
	select
		top 1
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3, 	@pack4 = pack4,		@pack5 = pack5,
		@pack6 = pack6,		@pack7= pack7,		@pack8 = pack8, 	@pack9 = pack9,		@pack10 = pack10,

		@pack11 = pack11,	@pack12 = pack12,	@pack13 = pack13, 	@pack14 = pack14,	@pack15 = pack15,
		@pack16 = pack16,	@pack17= pack17,	@pack18 = pack18, 	@pack19 = pack19,	@pack20 = pack20,

		@pack21 = pack21,	@pack22 = pack22,	@pack23 = pack23, 	@pack24 = pack24,	@pack25 = pack25,
		@pack26 = pack26,	@pack27= pack27,	@pack28 = pack28, 	@pack29 = pack29,	@pack30 = pack30,

		@pack31 = pack31,	@pack32 = pack32,	@pack33 = pack33, 	@pack34 = pack34,	@pack35 = pack35,
		@pack36 = pack36,	@pack37= pack37,	@pack38 = pack38, 	@pack39 = pack39,	@pack40 = pack40
	from dbo.tFVSystemRoulette
	where packstate = 1
		  order by newid()
	--select 'DEBUG 뽑기정보', @itemcode itemcode, @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack6 pack6, @pack7 pack7, @pack8 pack8, @pack9 pack9, @pack10 pack10, @pack11 pack11, @pack12 pack12, @pack13 pack13, @pack14 pack14, @pack15 pack15, @pack16 pack16, @pack17 pack17, @pack18 pack18, @pack19 pack19, @pack20 pack20, @pack21 pack21, @pack22 pack22, @pack23 pack23, @pack24 pack24, @pack25 pack25, @pack26 pack26, @pack27 pack27, @pack28 pack28, @pack29 pack29, @pack30 pack30, @pack31 pack31, @pack32 pack32, @pack33 pack33, @pack34 pack34, @pack35 pack35, @pack36 pack36, @pack37 pack37, @pack38 pack38, @pack39 pack39, @pack40 pack40


	-----------------------------------
	-- 시간을 얻어오기.
	-----------------------------------
	set @curhour 	= DATEPART(Hour, Getdate())
	set	@curdate8	= Convert(varchar(8), Getdate(), 112)
	--select 'DEBUG ', @curdate8 curdate8, @curhour curhour

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 코드를 찾을수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@MODE_ROULETTE_FREE_TIME, @MODE_ROULETTE_FREE_HEART, @MODE_ROULETTE_CASHCOST, @MODE_ROULETTE_CASHCOST2,
																				 @MODE_ROULETTE_CASHCOST_FREE, @MODE_ROULETTE_CASHCOST2_FREE,
													  @MODE_ROULETTE_FREE_TICKET, @MODE_ROULETTE_CASHCOST_TICKET, @MODE_ROULETTE_CASHCOST2_TICKET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_FREE_TIME and @curhour not in (12, 18, 21))
		BEGIN
			set @nResult_ = @RESULT_ERROR_ROULFREE_NOT_TIME
			set @comment = 'ERROR 무료 뽑기 시간이 아닙니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_FREE_TIME and @roulfreetimedate = @curdate8 and @roulfreetimehour = @curhour)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ROULFREE_ALREADY
			set @comment = 'ERROR 시간대별 무료 뽑기를 이미 사용했습니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_FREE_HEART and @roulfreeheartdate = @curdate8 and @roulfreeheartcnt >= 3)
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_ROUL_3TIME_OVER
			set @comment = 'ERROR 무료 하트뽑기 1일 3회를 초과할수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (  (@mode_ = @MODE_ROULETTE_CASHCOST_FREE  and @roulcashcostfree <= 0)
			or (@mode_ = @MODE_ROULETTE_CASHCOST2_FREE and @roulcashcost2free <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족하다.'
			--select 'DEBUG ' + @comment

			if(@mode_ = @MODE_ROULETTE_CASHCOST_FREE )
				begin
					set @comment2 = '캐쉬 무료사용 보유수량(' + ltrim(rtrim(@roulcashcostfree)) + ')'
				end
			else
				begin
					set @comment2 = '캐쉬2 무료사용 보유수량(' + ltrim(rtrim(@roulcashcost2free)) + ')'
				end

			--select 'DEBUG **** 이상기록', @comment2 comment2
			exec spu_FVSubUnusualRecord2  @gameid_, @comment2

		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '뽑기 구매하기(2)'

			set @ownercashcost2	= @ownercashcost
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '뽑기 구매하기(1)'
			--select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- 세이브 정보 > 금액빼기.
			-----------------------------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

			------------------------------------------------
			-- 유저 보유 프리미엄 > 누적이벤트.
			------------------------------------------------
			if(@roulgauageflag = 1 and @mode_ in (@MODE_ROULETTE_CASHCOST, @MODE_ROULETTE_CASHCOST2))
				begin
					if(@mode_ = @MODE_ROULETTE_CASHCOST)
						begin
							if(@roulcashcostgauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG 캐쉬 누적'
									set @roulcashcostgauage = @roulcashcostgauage + @PMGAUAGEPOINT
								end

							if(@roulcashcostgauage >= @PMGAUAGEMAX)
								begin
									--select 'DEBUG 캐쉬 무료생성'
									set @roulcashcostgauage = 0										-- 한꺼번에 비워버리자.
									set @roulcashcostfree	= 1
								end
						end
					else if(@mode_ = @MODE_ROULETTE_CASHCOST2)
						begin
							if(@roulcashcost2gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG 캐쉬2 누적'
									set @roulcashcost2gauage = @roulcashcost2gauage + @PMGAUAGEPOINT
								end

							if(@roulcashcost2gauage >= @PMGAUAGEMAX)
								begin
									--select 'DEBUG 캐쉬2 무료생성'
									set @roulcashcost2gauage = 0										-- 한꺼번에 비워버리자.
									set @roulcashcost2free	= 1
								end
						end
				end
			else if(@mode_ = @MODE_ROULETTE_CASHCOST_FREE)
				begin
					--select 'DEBUG 캐쉬 무료사용'
					set @roulcashcostfree	= 0
				end
			else if(@mode_ = @MODE_ROULETTE_CASHCOST2_FREE)
				begin
					--select 'DEBUG 캐쉬2 무료사용'
					set @roulcashcost2free	= 0
				end

			--------------------------------
			-- 랜덤하기.
			--------------------------------
			if(@mode_ in (@MODE_ROULETTE_FREE_TIME, @MODE_ROULETTE_FREE_HEART, @MODE_ROULETTE_FREE_TICKET))
				begin
					set @cnt		= 1
					set @group1 	= 10000
					set @group2		=     0
					set @group3		=     0
					set @group4		=     0
					set @sendid		= 'SysRoul1'
					set @needcashcost	= 0
					set @needgamecost	= 0
					set @needheart		= 0

					--select 'DEBUG 시간/하트/티켓뽑기', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- 시간적용 > 안함.
					--------------------------------
					-- 일일 정보수집.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_FREE_TIME)
						begin
							exec spu_FVDayLogInfoStatic @market, 81, 1			-- 일 무료 시간 뽑기

							set @roulfreetimedate 	= @curdate8
							set @roulfreetimehour 	= @curhour
							--select 'DEBUG 시간뽑기'
						end
					else if(@mode_ = @MODE_ROULETTE_FREE_HEART)
						begin
							exec spu_FVDayLogInfoStatic @market, 82, 1			-- 일 무료 하트 뽑기

							set @needheart			= 100

							if(@roulfreeheartdate != @curdate8)
								begin
									set @roulfreeheartdate 	= @curdate8
									set @roulfreeheartcnt 	= 1
									--select 'DEBUG 하트뽑기 > 일처음'
								end
							else
								begin
									set @roulfreeheartdate 	= @curdate8
									set @roulfreeheartcnt 	= @roulfreeheartcnt + 1
									--select 'DEBUG 하트뽑기 > 일연속'
								end
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 102, 1			-- 일 무료티켓.
							--select 'DEBUG 무료티켓뽑기'
						end
				end
			else if(@mode_ in (@MODE_ROULETTE_CASHCOST, @MODE_ROULETTE_CASHCOST_FREE, @MODE_ROULETTE_CASHCOST_TICKET))
				begin
					set @cnt		= 1
					set @group1 	=     0
					set @group2		=     0
					set @group3		= 10000
					set @group4		=     0
					set @sendid		= 'SysRoul3'
					set @needcashcost	= case when @mode_ = @MODE_ROULETTE_CASHCOST then @ANIMAL_ONE_CASHCOST else 0 end
					set @needgamecost	= 0
					set @needheart		= 0
					--select 'DEBUG 캐쉬/캐쉬무료/캐쉬티켓 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- 시간적용.
					if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3, @roultimetime4))
						begin
							--select 'DEBUG > 적용시간됨'
							set @group3		= @group3 - 250
							set @group4		= @group4 + 200
							--select 'DEBUG 뽑기확률 상승', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
						end

					--------------------------------
					-- 일일 정보수집.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_CASHCOST)
						begin
							exec spu_FVDayLogInfoStatic @market, 83, 1			-- 일 캐쉬뽑기
							--select 'DEBUG 캐쉬 '
						end
					else if(@mode_ = @MODE_ROULETTE_CASHCOST_FREE)
						begin
							exec spu_FVDayLogInfoStatic @market, 93, 1			-- 일 캐쉬뽑기  (이벤트 게이지).
							--select 'DEBUG 캐쉬무료 '
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 103, 1			-- 일 캐쉬티켓.
							--select 'DEBUG 캐쉬티켓 '
						end

				end
			else if(@mode_ in (@MODE_ROULETTE_CASHCOST2, @MODE_ROULETTE_CASHCOST2_FREE, @MODE_ROULETTE_CASHCOST2_TICKET))
				begin
					set @cnt		=     5
					set @group1 	=     0
					set @group2		=     0
					set @group3		= 10000
					set @group4		=     0
					set @sendid		= 'SysRoul4'
					set @needcashcost	= case when @mode_ = @MODE_ROULETTE_CASHCOST2 then @ANIMAL_FIVE_CASHCOST else 0 end
					set @needgamecost	= 0
					set @needheart		= 0
					--select 'DEBUG 캐쉬2/캐쉬2무료/캐쉬2티켓  ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- 시간적용.
					if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3, @roultimetime4))
						begin
							--select 'DEBUG > 적용시간됨'
							set @group3		= @group3 - 250
							set @group4		= @group4 + 200
							--select 'DEBUG 뽑기확률 상승', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
						end

					--------------------------------
					-- 일일 정보수집.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_CASHCOST2)
						begin
							exec spu_FVDayLogInfoStatic @market, 84, 1			-- 일 캐쉬뽑기2
							--select 'DEBUG 캐쉬2  '
						end
					else if(@mode_ = @MODE_ROULETTE_CASHCOST2_FREE)
						begin
							exec spu_FVDayLogInfoStatic @market, 94, 1			-- 일 캐쉬뽑기2 (이벤트 게이지).
							--select 'DEBUG 캐쉬2무료  '
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 104, 1			-- 일 캐쉬티켓2.
							--select 'DEBUG 캐쉬2티켓  '
						end

				end
			--select 'DEBUG ', @cnt cnt, @group1 group1, @group2 group2, @group3 group3, @group4 group4

			------------------------
			-- 구매번호.
			--exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- D, C뽑기 X (1)
			--exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- B, A뽑기 X (1)
			--exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- A, S뽑기 X (1)
			--exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- A, S뽑기 X (3 + 1)
			------------------------
			--select 'DEBUG(전)', @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart
			if(@roulsaleflag = 1 and @roulsalevalue > 0 and @roulsalevalue <= 100)
				begin
					set @needcashcost 	= @needcashcost - @needcashcost * @roulsalevalue / 100
					set @needgamecost 	= @needgamecost - @needgamecost * @roulsalevalue / 100
					set @needheart 		= @needheart - @needheart * @roulsalevalue / 100
				end
			--select 'DEBUG(후)', @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart
			exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart


			------------------------------------
			-- 나오는 수량 한개로 조절
			------------------------------------
			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul1 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul2 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul3 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    105))
			set @roul4 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul5 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																											    @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																											    @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																											    @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			--select 'DEBUG 뽑기(보정1전)', @cnt cnt, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roulfreetimetotal roulfreetimetotal, @roulfreehearttotal roulfreehearttotal, @roulcashcosttotal roulcashcosttotal, @roulcashcost2total roulcashcost2total
			----------------------------------
			-- 개수 제한 하기.
			----------------------------------
			if(@cnt = 1)
				begin
					--set @roul1 		= -1
					set @roul2 			= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 2)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 3)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 4)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					--set @roul4 		= -1
					set @roul5 			= -1
				end
			--select 'DEBUG 뽑기(보정2후)', @cnt cnt, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roulfreetimetotal roulfreetimetotal, @roulfreehearttotal roulfreehearttotal, @roulcashcosttotal roulcashcosttotal


			--------------------------------------------
			-- 1, 5번째에는 좋은것 나오도록 한다.
			-- 10001, 10002, 10003, 10010, 10011, 10012, 10019, 10020, 10021, 10028, 10029, 10030
			-- 10004, 10005, 10006, 10013, 10014, 10015, 10022, 10023, 10024, 10031, 10032, 10033
			--------------------------------------------
			if(@mode_ in (@MODE_ROULETTE_FREE_TIME, @MODE_ROULETTE_FREE_TICKET) and @roulfreetimetotal in (0, 5))
				begin
					--select 'DEBUG 무료 시간 뽑기(보정)'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	10001, 10002, 10003, 10010, 10011, 10012, 10019, 10020, 10021, 10028, 10029, 10030)
				end
			if(@mode_ in (@MODE_ROULETTE_FREE_HEART) and @roulfreehearttotal in (0, 5))
				begin
					--select 'DEBUG 무료 하트 뽑기(보정)2'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	10001, 10002, 10003, 10010, 10011, 10012, 10019, 10020, 10021, 10028, 10029, 10030)
				end
			else if(@mode_ in (@MODE_ROULETTE_CASHCOST, @MODE_ROULETTE_CASHCOST_FREE, @MODE_ROULETTE_CASHCOST_TICKET) and @roulcashcosttotal in (0))
				begin
					--select 'DEBUG 캐쉬뽑기(처음)3'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	10005, 10005, 10005, 10005, 10005, 10014, 10014, 10014, 10014, 10023, 10023, 10023)
				end
			else if(@mode_ in (@MODE_ROULETTE_CASHCOST, @MODE_ROULETTE_CASHCOST_FREE, @MODE_ROULETTE_CASHCOST_TICKET) and @roulcashcosttotal in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG 캐쉬뽑기(보정)3'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	10004, 10005, 10006, 10013, 10014, 10015, 10022, 10023, 10024, 10031, 10032, 10033)
				end
			else if(@mode_ in (@MODE_ROULETTE_CASHCOST2, @MODE_ROULETTE_CASHCOST2_FREE, @MODE_ROULETTE_CASHCOST2_TICKET) and @roulcashcost2total in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG 캐쉬뽑기2(보정3)'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	10004, 10005, 10006, 10013, 10014, 10015, 10022, 10023, 10024, 10031, 10032, 10033)
				end
			--select 'DEBUG 뽑기(2차보정후)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

			--------------------------------------------------------------------
			---- 뽑기를 선물함에 넣어주기.
			--------------------------------------------------------------------
			----select 'DEBUG 뽑기 선물지급(없으면 자동으로 패스됨)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul5, 1, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul4, 1, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul3, 1, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul2, 1, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul1, 1, @sendid, @gameid_, ''


			------------------------------------------------------------------
			-- 이벤트 날짜 > 특정 > 선물지급1
			------------------------------------------------------------------
			if(@roulrewardflag = 1)
				begin
					--select 'DEBUG > 이벤트 기간내'
					if(@roulani1 != -1 and @roulani1 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 특정 보상1'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward1, @roulrewardcnt1, @roulname1, @gameid_, ''
							set @checkitemcode 	= @roulani1
							set @checkreward 	= @roulreward1
							set @checkrewardcnt	= @roulrewardcnt1
						end
					else if(@roulani2 != -1 and @roulani2 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG >  	-> 특정 보상2'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward2, @roulrewardcnt2, @roulname2, @gameid_, ''
							set @checkitemcode 	= @roulani2
							set @checkreward 	= @roulreward2
							set @checkrewardcnt	= @roulrewardcnt2
						end
					else if(@roulani3 != -1 and @roulani3 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 특정 보상3'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward3, @roulrewardcnt3, @roulname3, @gameid_, ''
							set @checkitemcode 	= @roulani3
							set @checkreward 	= @roulreward3
							set @checkrewardcnt	= @roulrewardcnt3
						end
				end

			--------------------------------------------------------------------
			-- 뽑기 광고하기.
			--------------------------------------------------------------------
			exec spu_FVRoulAdLog @gameid_, @nickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5

			--------------------------------------------------------------------
			---- 도감기록하기.
			--------------------------------------------------------------------
			--if(@roul1 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul1
			--	end
			--if(@roul2 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul2
			--	end
			--if(@roul3 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul3
			--	end
			--if(@roul4 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul4
			--	end
			--if(@roul5 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul5
			--	end

			--------------------------------
			-- 뽑기 로그 기록.
			--exec spu_FVUserItemRoulLog 'xxxx2',  1, 10001, 80010,     0, 0, 400, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLog 'xxxx2',  2, 10001, 80010,  2000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLog 'xxxx2',  3, 10001, 80010,  4000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLog 'xxxx2',  4, 10001, 80010, 12000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--
			--exec spu_FVUserItemRoulLog 'xxxx2', 12, 10001, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--exec spu_FVUserItemRoulLog 'xxxx2', 13, 10001, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--exec spu_FVUserItemRoulLog 'xxxx2', 14, 10001, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--------------------------------
			--if(@ownercashcost2 > @ownercashcost - @needcashcost)	--차감용
			--	begin
			--		set @strange = 1
			--		set @comment2 = '보물뽑기 보유(' + ltrim(rtrim(@ownercashcost)) + ') - 비용(' + ltrim(rtrim(@needcashcost)) + ') < 현재비용(' + ltrim(rtrim(@ownercashcost2)) + ')'
			--		--select 'DEBUG **** 이상기록', @comment2 comment2
			--		exec spu_FVSubUnusualRecord2  @gameid_, @comment2
			--	end
			if(@ownercashcost2 > @ownercashcost)	--비차감용
				begin
					set @strange = 1
					set @comment2 = '보물뽑기 보유(' + ltrim(rtrim(@ownercashcost)) + ') < 현재비용(' + ltrim(rtrim(@ownercashcost2)) + ')'
					--select 'DEBUG **** 이상기록', @comment2 comment2
					exec spu_FVSubUnusualRecord2  @gameid_, @comment2
				end
			exec spu_FVUserItemRoulLog @gameid_, @mode_, @bestani, @itemcode, @needcashcost, @needgamecost, @needheart, @roul1, @roul2, @roul3, @roul4, @roul5, @strange, @ownercashcost, @ownercashcost2

			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			--select 'DEBUG update'
			update dbo.tFVUserData
				set
					savedata = @savedata_
			where gameid = @gameid_
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment,
		   @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5,
		   @roulsaleflag roulsaleflag, 		@roulsalevalue roulsalevalue,
		   @roulrewardflag roulrewardflag,	@checkitemcode checkitemcode, 	@checkreward checkreward, @checkrewardcnt checkrewardcnt,
		   @roultimeflag roultimeflag, 		@roultimetime1 roultimetime1,	@roultimetime2 roultimetime2, @roultimetime3 roultimetime3, @roultimetime4 roultimetime4,
		   @roulgauageflag roulgauageflag,
		   @roulfreetimedate roulfreetimedate, @roulfreetimehour roulfreetimehour,
		   @roulfreeheartdate roulfreeheartdate, @roulfreeheartcnt roulfreeheartcnt,
		   @roulcashcostgauage roulcashcostgauage,	@roulcashcostfree roulcashcostfree,
		   @roulcashcost2gauage roulcashcost2gauage,@roulcashcost2free roulcashcost2free


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tFVUserMaster
				set
					randserial		= @randserial_,
					ownercashcost	= @ownercashcost2,

					bgroul1			= @roul1,		bgroul2			= @roul2,			bgroul3			= @roul3,			bgroul4			= @roul4,			bgroul5		= @roul5,
					roulfreetimetotal		= roulfreetimetotal + case when (@mode_ in (@MODE_ROULETTE_FREE_TIME) ) 	then 1 else 0 end,
					roulfreetimedate		= @roulfreetimedate,
					roulfreetimehour		= @roulfreetimehour,

					roulfreehearttotal		= roulfreehearttotal + case when (@mode_ in (@MODE_ROULETTE_FREE_HEART)) 	then 1 else 0 end,
					roulfreeheartdate		= @roulfreeheartdate,
					roulfreeheartcnt		= @roulfreeheartcnt,

					roulcashcosttotal		= roulcashcosttotal + case when (@mode_ in (@MODE_ROULETTE_CASHCOST)) 	then 1 else 0 end,
					roulcashcostgauage 		= @roulcashcostgauage,
					roulcashcostfree		= @roulcashcostfree,
					roulcashcostfreetotal	= roulcashcostfreetotal + case when (@mode_ in (@MODE_ROULETTE_CASHCOST_FREE)) 	then 1 else 0 end,

					roulcashcost2total		= roulcashcost2total + case when (@mode_ in (@MODE_ROULETTE_CASHCOST2)) 	then 1 else 0 end,
					roulcashcost2gauage 	= @roulcashcost2gauage,
					roulcashcost2free		= @roulcashcost2free,
					roulcashcost2freetotal	= roulcashcost2freetotal + case when (@mode_ in (@MODE_ROULETTE_CASHCOST2_FREE)) 	then 1 else 0 end,

					roulfreetickettotal		= roulfreetickettotal + case when (@mode_ in (@MODE_ROULETTE_FREE_TICKET)) 	then 1 else 0 end,
					roulcashcosttickettotal	= roulcashcosttickettotal + case when (@mode_ in (@MODE_ROULETTE_CASHCOST_TICKET)) 	then 1 else 0 end,
					roulcashcost2tickettotal= roulcashcost2tickettotal + case when (@mode_ in (@MODE_ROULETTE_CASHCOST2_TICKET)) 	then 1 else 0 end
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			--select 'DEBUG ', * from dbo.tFVUserMaster where gameid = @gameid_
		end
	set nocount off
End



