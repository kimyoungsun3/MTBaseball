/*
delete from dbo.tGiftList where gameid = 'xxxx2'
exec spu_RoulTreasureBuyNewTest 'xxxx2', '049000s1i0n7t8445289', 1, 7721, -1			-- 일반뽑기
exec spu_RoulTreasureBuyNewTest 'xxxx2', '049000s1i0n7t8445289', 2, 7723, -1			-- 루비뽑기
exec spu_RoulTreasureBuyNewTest 'xxxx2', '049000s1i0n7t8445289', 4, 7725, -1			-- 루비뽑기 10 + 1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_RoulTreasureBuyNewTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulTreasureBuyNewTest;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RoulTreasureBuyNewTest
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					--
	@mode_									int,
	@randserial_							varchar(20),					--
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
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_TREASURE			int					set @ITEM_MAINCATEGORY_TREASURE				= 1200	-- 보물.

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 보물뽑기 상수.
	declare @MODE_TREASURE_GRADE1				int					set @MODE_TREASURE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_TREASURE_GRADE2				int					set @MODE_TREASURE_GRADE2					= 2		-- 루비뽑기.
	declare @MODE_TREASURE_GRADE4				int					set @MODE_TREASURE_GRADE4					= 4	   	-- 루비뽑기 10 + 1.
	declare @MODE_TREASURE_GRADE2_FREE			int					set @MODE_TREASURE_GRADE2_FREE				= 12	-- 루비뽑기			(무료).
	declare @MODE_TREASURE_GRADE4_FREE			int					set @MODE_TREASURE_GRADE4_FREE				= 14	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_TREASURE_GRADE1_TICKET		int					set @MODE_TREASURE_GRADE1_TICKET			= 21	-- 일반뽑기			(티켓).
	declare @MODE_TREASURE_GRADE2_TICKET		int					set @MODE_TREASURE_GRADE2_TICKET			= 22	-- 루비뽑기			(티켓).
	declare @MODE_TREASURE_GRADE4_TICKET		int					set @MODE_TREASURE_GRADE4_TICKET			= 24	-- 루비뽑기 10 + 1 	(티켓).

	declare @ITEM_TREASURE_NOR_MOTHER			int					set @ITEM_TREASURE_NOR_MOTHER				= 2500	-- 일반보물뽑기.
	declare @ITEM_TREASURE_PRE_MOTHER			int					set @ITEM_TREASURE_PRE_MOTHER				= 2600	-- 프리미엄보물뽑기.

	-- 보물뽑기 가격 파라미터.
	declare @MODE_TREASURE_GRADE1_GAMECOST		int					set @MODE_TREASURE_GRADE1_GAMECOST			= 100
	declare @MODE_TREASURE_GRADE1_HEART			int					set @MODE_TREASURE_GRADE1_HEART				= 101
	declare @MODE_TREASURE_GRADE2_CASHCOST		int	 				set @MODE_TREASURE_GRADE2_CASHCOST			= 102
	declare @MODE_TREASURE_GRADE4_CASHCOST		int					set @MODE_TREASURE_GRADE4_CASHCOST			= 103


	-- 동물뽑기 오픈스템
	declare @OPEN_STEP							int					set @OPEN_STEP								= 0		-- 0 처음오픈.
																														-- 1 업그레이드.
																														-- 2 업그레이드.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid					varchar(20)		set @gameid				= ''
	declare @kakaonickname			varchar(40)		set @kakaonickname		= ''
	declare @market					int				set @market				= 1
	declare @cashcost				int				set @cashcost			= 0
	declare @gamecost				int				set @gamecost 			= 0
	declare @heart					int				set @heart 				= 0
	declare @feed					int				set @feed 				= 0
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @famelv					int
	declare @gameyear				int				set @gameyear			= 2013
	declare @gamemonth				int				set @gamemonth			= 3

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
	declare @pack41					int				set @pack41				= -1
	declare @pack42					int				set @pack42				= -1
	declare @pack43					int				set @pack43				= -1
	declare @pack44					int				set @pack44				= -1
	declare @pack45					int				set @pack45				= -1
	declare @pack46					int				set @pack46				= -1
	declare @pack47					int				set @pack47				= -1
	declare @pack48					int				set @pack48				= -1
	declare @pack49					int				set @pack49				= -1
	declare @pack50					int				set @pack50				= -1

	declare @roul1					int				set @roul1				= -1
	declare @roul2					int				set @roul2				= -1
	declare @roul3					int				set @roul3				= -1
	declare @roul4					int				set @roul4				= -1
	declare @roul5					int				set @roul5				= -1
	declare @roul6					int				set @roul6				= -1
	declare @roul7					int				set @roul7				= -1
	declare @roul8					int				set @roul8				= -1
	declare @roul9					int				set @roul9				= -1
	declare @roul10					int				set @roul10				= -1
	declare @roul11					int				set @roul11				= -1

	declare @group1			int,	@group2			int,		@group3			int,	@group4		int,	@group5		int,
			@rand			int,	@rand2			int,		@rand3			int,
			@tsgrade1cnt	int,	@tsgrade2cnt	int,		@tsgrade4cnt	int,
									@tsgrade2gauage	int,	@tsgrade4gauage		int,
			@cnt					int,
			@tmp					int

	declare @norcnt					int				set @norcnt				= 0
	declare @precnt					int				set @precnt				= 0

	declare @curdate				datetime		set @curdate		= getdate()
	declare @famelvmin 				int 			set @famelvmin 			= 1			-- 로그인(9렙) > 거래후(10렙) 뽑기는 9렙을 적용해준다. ㅠㅠ
	declare @famelvmax 				int 			set @famelvmax 			= 10
	declare @curhour				int				set @curhour			= -1
	declare @sendid					varchar(60)		set @sendid				= ''

	-- 가격정보.
	declare @tsgrade1gamecost		int				set @tsgrade1gamecost	= 400
	declare @tsgrade1heart			int				set @tsgrade1heart		= 60
	declare @tsgrade2cashcost		int				set @tsgrade2cashcost	= 300
	declare @tsgrade4cashcost		int				set @tsgrade4cashcost	= 3000
	declare @needgamecost			int				set @needgamecost		= 0
	declare @needheart				int				set @needheart			= 0
	declare @needcashcost			int				set @needcashcost		= 0

	-- 보물할인.
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- PM보물보상(보상템).
	declare @checkani				int				set @checkani			= -1
	declare @checkreward			int				set @checkreward		= -1
	declare @checkrewardcnt			int				set @checkrewardcnt		=  0

	-- PM보물보상.
	declare @strmarket				varchar(40)
	declare @roulflag				int				set @roulflag			= -1
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

	-- PM확률상승.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- PM무료보물.
	declare @pmgauageflag			int				set @pmgauageflag			= -1
	declare @PMGAUAGEPOINT			int				set @PMGAUAGEPOINT			= 10
	declare @PMGAUAGEMAX			int				set @PMGAUAGEMAX			= 100
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,		@kakaonickname 	= kakaonickname,	@market		= market,
		@cashcost		= cashcost,		@gamecost		= gamecost,			@heart		= heart,		@feed		= feed,
		@famelv			= famelv,		@gameyear		= gameyear,			@gamemonth	= gamemonth,

		@roul1			= bgroul1,		@roul2			= bgroul2,			@roul3		= bgroul3,		@roul4		= bgroul4,		@roul5		= bgroul5,
		@roul6			= bgroul6,		@roul7			= bgroul7,			@roul8		= bgroul8,		@roul9		= bgroul9,		@roul10		= bgroul10,
		@roul11			= bgroul11,

		@tsgrade1cnt	= tsgrade1cnt,	@tsgrade2cnt	= tsgrade2cnt,		@tsgrade4cnt	= tsgrade4cnt,
										@tsgrade2gauage= tsgrade2gauage,	@tsgrade4gauage= tsgrade4gauage,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @tsgrade1cnt tsgrade1cnt, @tsgrade2cnt tsgrade2cnt, @tsgrade2gauage tsgrade2gauage, @tsgrade4cnt tsgrade4cnt, @tsgrade4gauage tsgrade4gauage, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roul6 roul6, @roul7 roul7, @roul8 roul8, @roul9 roul9, @roul10 roul10, @roul11 roul11

	------------------------------------------------
	-- 뽑기 이벤트 정보 가져오기.
	------------------------------------------------
	set @strmarket = '%' + ltrim(rtrim(str(@market))) + '%'
	select
		top 1
		-- 1. 할인
		@roulsaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end,
		@roulsalevalue	= case when @roulsaleflag = -1 then 0 else roulsalevalue end,

		-- 2. 보상 -> 무엇을 뽑으면 템지급
		@roulflag 		= case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,
		@roulani1		= roulani1,			@roulani2		= roulani2,			@roulani3		= roulani3,
		@roulreward1	= roulreward1,		@roulreward2	= roulreward2,		@roulreward3	= roulreward3,
		@roulrewardcnt1	= roulrewardcnt1,	@roulrewardcnt2	= roulrewardcnt2,	@roulrewardcnt3	= roulrewardcnt3,
		@roulname1		= roulname1,		@roulname2		= roulname2,		@roulname3		= roulname3,

		-- 3. 확률상승 > 특정 시간에 확률상승.
		@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
		@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3,		@roultimetime4	= roultimetime4,

		-- 4. 게이지	> 뽑기 x회후에 1회 무료.
		@pmgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,
		@PMGAUAGEPOINT	= pmgauagepoint,
		@PMGAUAGEMAX	= pmgauagemax
	from dbo.tSystemTreasureMan
	where roulmarket like @strmarket
	order by idx desc
	--select 'DEBUG ', @roulsaleflag roulsaleflag, @roulflag roulflag, @roultimeflag roultimeflag, @pmgauageflag pmgauageflag

	------------------------------------------------
	-- 뽑기 모드 재정의.
	-- MODE_TREASURE_GRADE1 -> 							  MODE_TREASURE_GRADE1_TICKET
	-- MODE_TREASURE_GRADE2	-> MODE_TREASURE_GRADE2_FREE, MODE_TREASURE_GRADE2_TICKET
	-- MODE_TREASURE_GRADE4	-> MODE_TREASURE_GRADE4_FREE, MODE_TREASURE_GRADE4_TICKET
	------------------------------------------------
	if( @gameid != '' )
		begin
			if(@mode_ = @MODE_TREASURE_GRADE1)
				begin
					------------------------
					--1. 게이지 -> 없음.
					--2. 티켓.
					------------------------
					select @norcnt = cnt from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @ITEM_TREASURE_NOR_MOTHER
					--select 'DEBUG 일반보물뽑기', @norcnt norcnt

					if( @norcnt >= 1 )
						begin
							--select 'DEBUG 일반보물티켓뽑기(모드변경) > 가격없음'
							set @mode_ = @MODE_TREASURE_GRADE1_TICKET
						end
				end
			else if( @mode_ = @MODE_TREASURE_GRADE2 )
				begin
					------------------------
					--1. 게이지
					--2. 티켓.
					------------------------
					select @precnt = cnt from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @ITEM_TREASURE_PRE_MOTHER
					--select 'DEBUG 루비뽑기', @precnt precnt, @tsgrade2gauage tsgrade2gauage

					if( @tsgrade2gauage >= @PMGAUAGEMAX )
						begin
							--select 'DEBUG 루비뽑기게이지(모드변경) > 가격없음'
							set @mode_ = @MODE_TREASURE_GRADE2_FREE
						end
					else if( @precnt >= 1 )
						begin
							--select 'DEBUG 루비뽑기티켓(모드변경) > 가격없음'
							set @mode_ = @MODE_TREASURE_GRADE2_TICKET
						end
				end
			else if(@mode_ = @MODE_TREASURE_GRADE4)
				begin
					------------------------
					--1. 게이지
					--2. 티켓 -> 없음.
					------------------------
					if( @tsgrade4gauage >= @PMGAUAGEMAX )
						begin
							--select 'DEBUG 루비뽑기10+1게이지(모드변경) > 가격없음'
							set @mode_ = @MODE_TREASURE_GRADE4_FREE
						end
					--else if( @precnt >= 1 )
					--	begin
					--		--select 'DEBUG 루비뽑기10+1티켓(모드변경) **** 존재안함'
					--		set @mode_ = @MODE_TREASURE_GRADE4_TICKET
					--	end
				end
		end


	------------------------------------------------
	-- 가격정보 (위의 순서 다음에 반드시 와야함).
	------------------------------------------------
	select @tsgrade1gamecost 	= dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_GAMECOST, @famelv),
		   @tsgrade1heart 		= dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_HEART, 	@famelv),
		   @tsgrade2cashcost	= dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE2_CASHCOST, @famelv),
		   @tsgrade4cashcost	= dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE4_CASHCOST, @famelv)
	--select 'DEBUG ', @tsgrade1gamecost tsgrade1gamecost, @tsgrade1heart tsgrade1heart, @tsgrade2cashcost tsgrade2cashcost, @tsgrade4cashcost tsgrade4cashcost

	if( @mode_ = @MODE_TREASURE_GRADE1 )
		begin
			set @needgamecost	= @tsgrade1gamecost
			set @needheart		= @tsgrade1heart
			--select 'DEBUG 일반뽑기'
		end
	else if( @mode_ = @MODE_TREASURE_GRADE2 )
		begin
			set @needcashcost	= @tsgrade2cashcost
			--select 'DEBUG 루비1뽑기'
		end
	else if( @mode_ = @MODE_TREASURE_GRADE4 )
		begin
			set @needcashcost	= @tsgrade4cashcost
			--select 'DEBUG 루비10+1뽑기'
		end
	--select 'DEBUG (전)', @cashcost cashcost, @needcashcost needcashcost, @gamecost gamecost, @needgamecost needgamecost, @heart heart, @needheart needheart
	if(@roulsaleflag = 1 and @roulsalevalue > 0 and @roulsalevalue <= 100)
		begin
			set @needcashcost 	= @needcashcost - @needcashcost * @roulsalevalue / 100
			--set @needgamecost = @needgamecost - @needgamecost * @roulsalevalue / 100
			--set @needheart 	= @needheart    - @needheart    * @roulsalevalue / 100
		end
	--select 'DEBUG (후)', @cashcost cashcost, @needcashcost needcashcost, @gamecost gamecost, @needgamecost needgamecost, @heart heart, @needheart needheart


	----------------------------------------
	-- 뽑기정보.
	----------------------------------------
	select
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3, 	@pack4 = pack4,		@pack5 = pack5,
		@pack6 = pack6,		@pack7 = pack7,		@pack8 = pack8, 	@pack9 = pack9,		@pack10 = pack10,

		@pack11 = pack11,	@pack12= pack12,	@pack13 = pack13, 	@pack14 = pack14,	@pack15 = pack15,
		@pack16 = pack16,	@pack17= pack17,	@pack18 = pack18, 	@pack19 = pack19,	@pack20 = pack20,

		@pack21 = pack21,	@pack22= pack22,	@pack23 = pack23, 	@pack24 = pack24,	@pack25 = pack25,
		@pack26 = pack26,	@pack27= pack27,	@pack28 = pack28, 	@pack29 = pack29,	@pack30 = pack30,

		@pack31 = pack31,	@pack32= pack32,	@pack33 = pack33, 	@pack34 = pack34,	@pack35 = pack35,
		@pack36 = pack36,	@pack37= pack37,	@pack38 = pack38, 	@pack39 = pack39,	@pack40 = pack40,

		@pack41 = pack41,	@pack42= pack42,	@pack43 = pack43, 	@pack44 = pack44,	@pack45 = pack45,
		@pack46 = pack46,	@pack47= pack47,	@pack48 = pack48, 	@pack49 = pack49,	@pack50 = pack50
	from dbo.tSystemTreasure
	where famelvmin <= @famelv
		  and @famelv <= famelvmax
		  and packstate = 1
		  order by newid()
	--select 'DEBUG 뽑기정보', @itemcode itemcode, @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack6 pack6, @pack7 pack7, @pack8 pack8, @pack9 pack9, @pack10 pack10, @pack11 pack11, @pack12 pack12, @pack13 pack13, @pack14 pack14, @pack15 pack15, @pack16 pack16, @pack17 pack17, @pack18 pack18, @pack19 pack19, @pack20 pack20, @pack21 pack21, @pack22 pack22, @pack23 pack23, @pack24 pack24, @pack25 pack25, @pack26 pack26, @pack27 pack27, @pack28 pack28, @pack29 pack29, @pack30 pack30, @pack31 pack31, @pack32 pack32, @pack33 pack33, @pack34 pack34, @pack35 pack35, @pack36 pack36, @pack37 pack37, @pack38 pack38, @pack39 pack39, @pack40 pack40

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
	else if (@mode_ not in (@MODE_TREASURE_GRADE1, 		  @MODE_TREASURE_GRADE2, 		@MODE_TREASURE_GRADE4,
														  @MODE_TREASURE_GRADE2_FREE, 	@MODE_TREASURE_GRADE4_FREE,
							@MODE_TREASURE_GRADE1_TICKET, @MODE_TREASURE_GRADE2_TICKET, @MODE_TREASURE_GRADE4_TICKET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_TREASURE_GRADE1 and @gamecost < @needgamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 게임코인이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_TREASURE_GRADE1 and @heart < @needheart )
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR 하트이 부족하다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE4 ) and @cashcost < @needcashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 루비가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '보물뽑기 구매하기(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '보물뽑기 구매하기(1)'
			--select 'DEBUG ', @comment

			------------------------------------------------
			-- 1. 뽑기 -> 금액차감
			--    시간을 얻어오기.
			------------------------------------------------
			set @cashcost 	= @cashcost - @needcashcost
			set @gamecost 	= @gamecost - @needgamecost
			set @heart		= @heart - @needheart
			set @curhour 	= DATEPART(Hour, getdate())
			set @cnt		= 1
			--select 'DEBUG ', @mode_ mode_, @cashcost cashcost, @needcashcost needcashcost, @gamecost gamecost, @needgamecost needgamecost, @heart heart, @needheart needheart

			------------------------------------------------
			-- 2. 게이지 누적이벤트
			------------------------------------------------
			if(@pmgauageflag = 1 and @mode_ in ( @MODE_TREASURE_GRADE2, 		@MODE_TREASURE_GRADE4,
												 @MODE_TREASURE_GRADE2_TICKET, 	@MODE_TREASURE_GRADE4_TICKET))
				begin
					--select 'DEBUG 프리미엄 누적 이벤트중', @mode_ mode_
					if(@mode_ in (@MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_TICKET))
						begin
							if(@tsgrade2gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG 프리미엄 누적'
									set @tsgrade2gauage = @tsgrade2gauage + @PMGAUAGEPOINT
								end
						end
					else if(@mode_ in (@MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_TICKET))
						begin
							if(@tsgrade4gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG 프리미엄4 누적'
									set @tsgrade4gauage = @tsgrade4gauage + @PMGAUAGEPOINT
								end
						end
				end

			--------------------------------
			-- 3. 각그룹별 정리.
			--------------------------------
			if( @mode_ in ( @MODE_TREASURE_GRADE1, @MODE_TREASURE_GRADE1_TICKET ) )
				begin
					set @group1 	= 8000
					set @group2		= 2000
					set @group3		=    0
					set @group4		=    0
					set @group5		=    0
					set @sendid		= 'SysRoul1'
					set @cnt		= 1
					set @tsgrade1cnt= @tsgrade1cnt + 1
					--select 'DEBUG 일반보물뽑기 누적', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt

					--------------------------------
					-- 시간적용 > 안함.
					--------------------------------

					--------------------------------
					-- 일일 정보수집.
					-- 구매로그 기록학.
					--------------------------------
					exec spu_DayLogInfoStatic @market, 71, 1			-- 일 일반뽑기
					exec spu_DayLogInfoStatic @market, 20, @needheart	-- 일 하트사용수
					exec spu_UserItemBuyLogNew @gameid_, @itemcode, @needgamecost, @needcashcost, @needheart

					--------------------------------
					-- 게이지 	-> 클리어
					-- 티켓 	-> 수량감소
					--------------------------------
					if( @mode_ = @MODE_TREASURE_GRADE1_TICKET )
						begin
							--select 'DEBUG 일반보물티켓 > 수량감소'
							update dbo.tUserItem
								set cnt = cnt - 1
							where gameid = @gameid_ and itemcode = @ITEM_TREASURE_NOR_MOTHER
						end

				end
			else if(@mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE , @MODE_TREASURE_GRADE2_TICKET ) )
				begin
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 8000
					set @group4		= 1800
					set @group5		=  200
					set @sendid		= 'SysRoul2'
					set @cnt		= 1
					set @tsgrade2cnt= @tsgrade2cnt + 1
					--select 'DEBUG 프리미엄보물 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt

					--------------------------------
					-- 시간적용.
					--------------------------------
					if( @roultimeflag = 1 and @curhour in (@roultimetime1, @roultimetime2, @roultimetime3, @roultimetime4))
						begin
							set @group3		= @group3 - 250
							set @group4		= @group4 + 200
							set @group5		= @group5 +  50
							--select 'DEBUG 뽑기확률 상승', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3, @roultimetime4 roultimetime4
						end

					--------------------------------
					-- 일일 정보수집.
					-- 구매로그 기록학.
					--------------------------------
					exec spu_DayLogInfoStatic @market, 72, 1			-- 일 프리미엄
					exec spu_UserItemBuyLogNew @gameid_, @itemcode, @needgamecost, @needcashcost, 0

					--------------------------------
					-- 게이지 	-> 클리어
					-- 티켓 	-> 수량감소
					--------------------------------
					--if( @mode_ = @MODE_TREASURE_GRADE2 )
					--	begin
					--	end
					--else
					if( @mode_ = @MODE_TREASURE_GRADE2_FREE )
						begin
							--select 'DEBUG 프리미엄게이지 > 클리어'
							set @tsgrade2gauage	= 0
						end
					else if( @mode_ = @MODE_TREASURE_GRADE2_TICKET )
						begin
							--select 'DEBUG 프리미엄티켓 > 수량감소'
							update dbo.tUserItem
								set cnt = cnt - 1
							where gameid = @gameid_ and itemcode = @ITEM_TREASURE_PRE_MOTHER
						end
				end
			else if(@mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE , @MODE_TREASURE_GRADE4_TICKET ) )
				begin
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 7000
					set @group4		= 2800
					set @group5		=  200
					set @sendid		= 'SysRoul4'
					set @cnt		= 11
					set @tsgrade4cnt	= @tsgrade4cnt + 1
					--select 'DEBUG 프리미엄4 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt

					--------------------------------
					-- 시간적용.
					--------------------------------
					if( @roultimeflag = 1 and @curhour in (@roultimetime1, @roultimetime2, @roultimetime3, @roultimetime4))
						begin
							set @group3		= @group3 - 250
							set @group4		= @group4 + 200
							set @group5		= @group5 +  50
							--select 'DEBUG 프리미엄4 뽑기확률 상승', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3, @roultimetime4 roultimetime4
						end

					--------------------------------
					-- 일일 정보수집.
					-- 구매로그 기록학.
					--------------------------------
					exec spu_DayLogInfoStatic @market, 73, 1			-- 일 프리미엄4
					exec spu_UserItemBuyLogNew @gameid_, @itemcode, @needgamecost, @needcashcost, 0

					--------------------------------
					-- 게이지 	-> 클리어
					-- 티켓 	-> 수량감소
					--------------------------------
					--if( @mode_ = @MODE_TREASURE_GRADE4 )
					--	begin
					--	end
					--else
					if( @mode_ = @MODE_TREASURE_GRADE4_FREE )
						begin
							--select 'DEBUG 프리미엄4게이지 > 클리어'
							set @tsgrade4gauage	= 0
						end
					--else if( @mode_ = @MODE_TREASURE_GRADE4_TICKET )
					--	begin
					--	end
				end

			------------------------------------
			-- 뽑기 > 나오는 수량 한개로 조절
			------------------------------------
			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul1 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul2 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul3 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul4 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul5 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul6 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul7 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul8 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul9 		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul10		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul11		= dbo.fnu_GetCrossRandomNew(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10, @pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20, @pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30, @pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40, @pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			----------------------------------
			-- 개수 제한 하기.
			----------------------------------
			if(@cnt != 11)
				begin
					--set @roul1 		= -1
					set @roul2 			= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
					set @roul6 			= -1
					set @roul7 			= -1
					set @roul8 			= -1
					set @roul9 			= -1
					set @roul10 		= -1
					set @roul11 		= -1
				end
			--select 'DEBUG 뽑기(보정2전)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roul6 roul6, @roul7 roul7, @roul8 roul8, @roul9 roul9, @roul10 roul10, @roul11 roul11

			----------------------------------------------
			---- 캐쉬를 지른 사람은 확률이 상승하게 설정. -> x
			----------------------------------------------

			--------------------------------------------
			-- 템을 보정해둔다.
			--------------------------------------------
			if( @mode_ in ( @MODE_TREASURE_GRADE1, @MODE_TREASURE_GRADE1_TICKET ) and @tsgrade1cnt in (1, 5) )
				begin
					--select 'DEBUG 일반 보정 -> 0, 1'
					--set @rand 	= Convert(int, ceiling(RAND() * 100))
					--set @rand2 	= Convert(int, ceiling(RAND() * 100))
					select @roul1 = itemcode from dbo.tItemInfo
					where category = @ITEM_MAINCATEGORY_TREASURE
						  and grade in ( 1, 2 )
						  and houselv <= @OPEN_STEP
						  order by newid()
				end
			else if( @mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE, @MODE_TREASURE_GRADE2_TICKET ) and ( @tsgrade2cnt in (1, 2, 5) or ( @tsgrade2cnt >= 10 and @tsgrade2cnt % 10 = 5 ) ) )
				begin
					--select 'DEBUG 프리 보정 -> 2, 3, 4'
					--set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 10000))
					if( @rand2 < 8000)
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 3 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end
					else if( @rand2 < 9800)
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 4 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end
					else if( @rand2 < 9980)
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 5 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end
					else
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 6 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end

				end
			else if( @mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE, @MODE_TREASURE_GRADE4_TICKET ) )
				begin
					--select 'DEBUG 프리4 보정 -> 2, 3, 4, 5, 6 '
					--set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 10000))
					if( @rand2 < 9800)
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 5 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end
					else
						begin
							select @roul1 = itemcode from dbo.tItemInfo
							where category = @ITEM_MAINCATEGORY_TREASURE
								  and grade in ( 5, 6 )
								  and houselv <= @OPEN_STEP
								  order by newid()
						end

				end
			--select 'DEBUG 뽑기(보정2후)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roul6 roul6, @roul7 roul7, @roul8 roul8, @roul9 roul9, @roul10 roul10, @roul11 roul11


			--------------------------------------------------------------------
			---- 보물뽑기를 선물함에 넣어주기.
			--------------------------------------------------------------------
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul1, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul2, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul3, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul4, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul5, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul6, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul7, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul8, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul9, 0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul11,0, 'SysRoul', @gameid_, ''
			--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roul10,0, 'SysRoul', @gameid_, ''


			--------------------------------------------------------------------
			---- 이벤트 날짜 > 특정보물 > 선물지급1
			--------------------------------------------------------------------
			--if(@roulflag = 1)
			--	begin
			--		--select 'DEBUG > 이벤트 기간내'
			--		if(@roulani1 in (@roul1, @roul2, @roul3, @roul4, @roul5, @roul6, @roul7, @roul8, @roul9, @roul10, @roul11))
			--			begin
			--				--select 'DEBUG > 	-> 특정보물 보상1'
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roulreward1, @roulrewardcnt1, @roulname1, @gameid_, ''
			--				set @checkani 		= @roulani1
			--				set @checkreward 	= @roulreward1
			--				set @checkrewardcnt	= @roulrewardcnt1
			--			end
			--		else if(@roulani2 in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG >  	-> 특정보물 보상2'
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roulreward2, @roulrewardcnt2, @roulname2, @gameid_, ''
			--				set @checkani 		= @roulani2
			--				set @checkreward 	= @roulreward2
			--				set @checkrewardcnt	= @roulrewardcnt2
			--			end
			--		else if(@roulani3 in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG > 	-> 특정보물 보상3'
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @roulreward3, @roulrewardcnt3, @roulname3, @gameid_, ''
			--				set @checkani 		= @roulani3
			--				set @checkreward 	= @roulreward3
			--				set @checkrewardcnt	= @roulrewardcnt3
			--			end
			--	end

			--------------------------------------------------------------------
			---- 보물 광고하기. > 겸용으로 사용한다.
			--------------------------------------------------------------------
			--set @tmp = @mode_* 1000
			--exec spu_RoulAdLogNew @gameid_, @kakaonickname, @tmp, @roul1, @roul2, @roul3, @roul4, @roul5, @roul6, @roul7, @roul8, @roul9, @roul10, @roul11


			--------------------------------
			-- 뽑기 로그 기록.
			--------------------------------
			exec spu_UserItemTreasureLogNew @gameid_, @mode_, @famelv, @itemcode, @needcashcost, @needgamecost, @needheart, @roul1, @roul2, @roul3, @roul4, @roul5, @roul6, @roul7, @roul8, @roul9, @roul10, @roul11, @gameyear, @gamemonth
		END

	--------------------------------------------------
	----	3-3. 결과리턴
	--------------------------------------------------
	--select @nResult_ rtn, @comment comment,
	--	   @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed,
	--	   @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @roul6 roul6, @roul7 roul7, @roul8 roul8, @roul9 roul9, @roul10 roul10, @roul11 roul11,
	--	   @tsgrade1cnt tsgrade1cnt, @tsgrade2cnt tsgrade2cnt, @tsgrade4cnt tsgrade4cnt,
	--	                             @tsgrade2gauage tsgrade2gauage, @tsgrade4gauage tsgrade4gauage,
	--	   @checkani checkani, @checkreward checkreward, @checkrewardcnt checkrewardcnt

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					randserial	= @randserial_,
					cashcost	= @cashcost,		gamecost	= @gamecost,	heart		= @heart,	feed		= @feed,
					bgroul1		= @roul1,			bgroul2		= @roul2,		bgroul3		= @roul3,	bgroul4		= @roul4,	bgroul5		= @roul5,		bgroul6		= @roul6,			bgroul7		= @roul7,		bgroul8		= @roul8,	bgroul9		= @roul9,	bgroul10	= @roul10,		bgroul11		= @roul11,
					tsgrade1cnt= @tsgrade1cnt,		tsgrade2cnt	= @tsgrade2cnt,tsgrade4cnt= @tsgrade4cnt,
													tsgrade2gauage	= @tsgrade2gauage,	tsgrade4gauage	= @tsgrade4gauage
			where gameid = @gameid_

			----------------------------------------------------------------
			---- 선물/쪽지 리스트 정보
			----------------------------------------------------------------
			--exec spu_GiftList @gameid_

			-----------------------------------------------
			---- 보물뽑기가격.
			-----------------------------------------------
			--select @tsgrade1gamecost tsgrade1gamecost, @tsgrade1heart tsgrade1heart, @tsgrade2cashcost tsgrade2cashcost, @tsgrade4cashcost tsgrade4cashcost
            --
			--select
			--	top 1 *,
			--	case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end tsupgradesaleflag2,
			--	case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
			--	case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
			--	case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
			--	case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			--from dbo.tSystemTreasureMan
			--where roulmarket like @strmarket
			--order by idx desc
		end

	set nocount off
End



