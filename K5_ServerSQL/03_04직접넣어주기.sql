---------------------------------------------------------------
/*
exec spu_SetDirectItem 'xxxx2',      1, 1, -1	-- 동물(16)
exec spu_SetDirectItem 'xxxx2',     17, 1, -1	--     (96)
exec spu_SetDirectItem 'xxxx2',     24, 1, -1	--     (80)
exec spu_SetDirectItem 'xxxx2',    700, 1, -1	-- 총알
exec spu_SetDirectItem 'xxxx2',    800, 1, -1	-- 백신
exec spu_SetDirectItem 'xxxx2',   1002, 1, -1	-- 일꾼
exec spu_SetDirectItem 'xxxx2',   1103, 1, -1	-- 촉진제
exec spu_SetDirectItem 'xxxx2',   1200, 1, -1	-- 부활석
exec spu_SetDirectItem 'xxxx2',   2100, 1, -1	-- 긴급요청티켓

exec spu_SetDirectItem 'xxxx2',    900, 1, -1	-- 건초
exec spu_SetDirectItem 'xxxx2',   1900, 1, -1	-- 우정포인트
exec spu_SetDirectItem 'xxxx2',   2000, 1, -1	-- 하트
exec spu_SetDirectItem 'xxxx2',   5000, 1, -1	-- 캐쉬
exec spu_SetDirectItem 'xxxx2',   5100, 1, -1	-- 코인
exec spu_SetDirectItem 'xxxx2',   2200, 1, -1	-- 일반교배티켓
exec spu_SetDirectItem 'xxxx2',   2300, 1, -1	-- 프리미엄교배뽑기
exec spu_SetDirectItem 'xxxx2',   3000, 1, -1	-- 황금티켓
exec spu_SetDirectItem 'xxxx2',   3100, 1, -1	-- 싸움티켓
exec spu_SetDirectItem 'xxxx2', 104000, 1, -1	-- 줄기세포.
exec spu_SetDirectItem 'xxxx2', 120010, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'xxxx2', 100000, 1, -1	-- 펫선물(6).
exec spu_SetDirectItem 'xxxx2',     -1, 1, -1	-- empty

declare @rtnlistidx int
set @rtnlistidx = -1
exec spu_SetDirectItem 'xxxx2', 104000, 1, @nResult_ = @rtnlistidx OUTPUT	-- 줄기세포 -> 인벤
select @rtnlistidx rtnlistidx


declare @rtnlistidx int
set @rtnlistidx = -1
exec spu_SetDirectItem 'xxxx2', 900, 1, @nResult_ = @rtnlistidx OUTPUT		-- 건초 -> 다이렉트
select @rtnlistidx rtnlistidx

declare @rtnlistidx int
set @rtnlistidx = -1
exec spu_SetDirectItem 'xxxx2',   -1, 1, @nResult_ = @rtnlistidx OUTPUT		-- empty -> 다이렉트
select @rtnlistidx rtnlistidx
*/
use Game4Farmvill5
GO
------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------

IF OBJECT_ID ( 'dbo.spu_SetDirectItem', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SetDirectItem;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SetDirectItem
	@gameid_				varchar(20),
	@itemcode_				int,
	@sendcnt_				int,
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
AS
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 아이템 소종류
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])	0
	--declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 백신	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ALBA			int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_COMPOSE_TIME	int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- 우정포인트(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_NOR	int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- 일반교배뽑기티켓(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_PRE	int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- 프리미엄교배뽑기티켓(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_TREASURE_NOR	int					set @ITEM_SUBCATEGORY_TREASURE_NOR			= 25 -- 일반 보물 뽑기티켓
	--declare @ITEM_SUBCATEGORY_TREASURE_PRE	int					set @ITEM_SUBCATEGORY_TREASURE_PRE			= 26 -- 프리미엄 보물 뽑기티켓
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- 황금티켓.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- 싸움티켓.
	--declare @ITEM_SUBCATEGORY_STEMCELL		int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_DIRECT				int					set @DEFINE_HOW_GET_DIRECT					= 13--direct

	-- 펫기타 정보
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6		-- 업그레이드 맥스.
	declare @USERITEM_TREASURE_UPGRADE_MAX		int					set @USERITEM_TREASURE_UPGRADE_MAX			= 7		-- max강화.

	-- 특수템.
	--declare @ITEM_ZCP_PIECE_MOTHER			int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- 짜요쿠폰조각.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- 짜요쿠폰.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid			= @gameid_
	declare @subcategory 	int
	declare @buyamount		int				set @buyamount		= @sendcnt_
	declare @invenkind		int
	declare @itemcode		int				set @itemcode		= @itemcode_
	declare @cnt			int				set @cnt			= 0
	declare @upstepmax		int				set @upstepmax		= 16

	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxpet 	int				set @listidxpet		= -1
	declare @petupgradeinit	int				set @petupgradeinit	=  1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 1-1 입력값', @gameid_ gameid_, @itemcode_ itemcode_, @sendcnt_ sendcnt_
	if(@itemcode = -1)
		begin
			set @nResult_ = -1
			return
		end

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@subcategory 	= subcategory,
		@buyamount 		= buyamount,
		@upstepmax		= param30
	from dbo.tItemInfo where itemcode = @itemcode
	--select 'DEBUG 1-4 ', @subcategory subcategory, @buyamount buyamount, @sendcnt_ sendcnt_

	set @buyamount = case when(@sendcnt_ > 0) then @sendcnt_ else @buyamount end
	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
	--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @invenkind invenkind, @listidxnew listidxnew

	if(@invenkind = @USERITEM_INVENKIND_ANI)
		begin
			--------------------------------------------------------------
			-- 소,양,산양			-> 동물 아이템
			--------------------------------------------------------------
			-- 해당아이템 인벤에 지급
			insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt, farmnum,  fieldidx,  invenkind,  upstepmax, gethow)
			values(					 @gameid_, @listidxnew, @itemcode,   1,       0,        -1, @invenkind, @upstepmax, @DEFINE_HOW_GET_DIRECT)

			-- 도감기록
			exec spu_DogamListLog @gameid_, @itemcode

			-- 변경된 아이템 리스트인덱스
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_TICKET_MOTHER )
		begin
			--------------------------------------------------------------
			-- 짜요쿠폰 (60일 만기일).
			--------------------------------------------------------------
			--select 'DEBUG 짜요쿠폰 insert', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
			insert into dbo.tUserItem(gameid,       listidx,  itemcode,        cnt, expirekind,     expiredate,  invenkind,  gethow)
			values(					 @gameid_,  @listidxnew, @itemcode, @buyamount,          1, getdate() + 60, @invenkind, @DEFINE_HOW_GET_DIRECT)

			-- 변경된 아이템 리스트인덱스
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
		begin
			--------------------------------------------------------------
			-- 대표소모템 변경.
			--------------------------------------------------------------
			set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

			select
				@listidxcust = listidx
			from dbo.tUserItem
			where gameid = @gameid_ and itemcode = @itemcode
			--select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

			if(@listidxcust = -1)
				begin
					--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

					insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
					values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_DIRECT)

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

					update dbo.tUserItem
						set
							cnt = cnt + @buyamount
					where gameid = @gameid_ and listidx = @listidxcust

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxcust
				end
		end
	else if(@invenkind = @USERITEM_INVENKIND_STEMCELL)
		begin
			--------------------------------------------------------------
			-- 줄기세포					-> 줄기세포 아이템
			--------------------------------------------------------------
			insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,  gethow)		-- 악세
			values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @DEFINE_HOW_GET_DIRECT)

			-- 변경된 아이템 리스트인덱스
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_TREASURE)
		begin
			insert into dbo.tUserItem(gameid,      listidx,  itemcode,  invenkind,                      upstepmax, gethow)
			values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @USERITEM_TREASURE_UPGRADE_MAX, @DEFINE_HOW_GET_DIRECT)

			-- 변경된 아이템 리스트인덱스
			set @listidxrtn	= @listidxnew

			---------------------------------
			-- 보물 보유효과 세팅.
			---------------------------------
			exec spu_TSRetentionEffect @gameid_, @itemcode
		end


	else if(@invenkind = @USERITEM_INVENKIND_PET)
		begin
			--------------------------------------------------------------
			-- 펫					-> 펫 아이템
			--------------------------------------------------------------
			--select 'DEBUG 4-4-2 선물 > 펫인벤으로 이동, 이벤 지급 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

			select
				@listidxpet = listidx
			from dbo.tUserItem
			where gameid = @gameid_ and itemcode = @itemcode
			--select 'DEBUG >', @listidxpet listidxpet

			select
				@petupgradeinit		= param5
			from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
			--select 'DEBUG >', @petupgradeinit petupgradeinit

			if(@listidxpet = -1)
				begin
					--select 'DEBUG 펫 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
					insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,       petupgrade,      gethow)		-- 펫
					values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_DIRECT)

					-- 펫도감기록.
					exec spu_DogamListPetLog @gameid_, @itemcode

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					--select 'DEBUG 펫 업그레이드', @gameid_ gameid_, @listidxpet listidxpet

					update dbo.tUserItem
						set
							petupgrade = case
											when (petupgrade + 1 >= @USERITEM_PET_UPGRADE_MAX) then @USERITEM_PET_UPGRADE_MAX
											else													petupgrade + 1
										end
					where gameid = @gameid_ and listidx = @listidxpet

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxpet
				end
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
		begin
			--select 'DEBUG 4-5-1 cashcost(캐시)	-> 바로적용'
			update dbo.tUserMaster
				set
					cashcost = cashcost + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
		begin
			--select 'DEBUG 4-5-2 gamecost(코인)	-> 바로적용'
			update dbo.tUserMaster
				set
					gamecost = gamecost + @buyamount
			where gameid = @gameid_

		end
	else if(@subcategory = @ITEM_SUBCATEGORY_FPOINT)
		begin
			--select 'DEBUG 4-5-3 우정포인트 -> 바로적용'
			update dbo.tUserMaster
				set
					fpoint = fpoint + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_GOLDTICKET)
		begin
			--select 'DEBUG 4-6 황금티켓  -> 바로적용'
			update dbo.tUserMaster
				set
					goldticket = goldticket + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_BATTLETICKET)
		begin
			--select 'DEBUG 4-6 배틀티켓  -> 바로적용'
			update dbo.tUserMaster
				set
					battleticket = battleticket + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
		begin
			--select 'DEBUG 4-6 하트  -> 바로적용'
			update dbo.tUserMaster
				set
					heart = heart + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
		begin
			--select 'DEBUG 4-6 건초  -> 바로적용'
			update dbo.tUserMaster
				set
					feed = feed + @buyamount
			where gameid = @gameid_
		end
	else
		begin
			set @listidxrtn = @listidxrtn
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off

	set @nResult_ = @listidxrtn
END
