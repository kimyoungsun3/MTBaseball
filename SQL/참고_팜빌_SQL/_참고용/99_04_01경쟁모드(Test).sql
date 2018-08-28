/*
-- 퀘스트 단계정 입력
--exec spu_FVComRewardTest 'guest265', '7808543s0s8r0k746614', 90108, '',  0, -1
--exec spu_FVComRewardTest 'guest266', '5165561g2e5h7y774758', 90108, '',  0, -1
-- update dbo.tFVUserMaster set market = 1 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set market = 5 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set market = 6 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set market = 7 where gameid = 'xxxx2'

declare @comreward	int			set @comreward	= 90370
declare @gameid		varchar(60)	set @gameid		= 'xxxx2'
declare @password	varchar(20)	set @password	= '049000s1i0n7t8445289'
declare @nextcomreward			int					set @nextcomreward		= -1
declare @nextinitpart1			int					set @nextinitpart1		= 0
declare @nextinitpart2			int					set @nextinitpart2		= 0
declare @loop					int					set @loop				= 10

delete from dbo.tFVGiftList where gameid = @gameid
delete from dbo.tFVComReward where gameid = @gameid
-- select count(*) from dbo.tFVItemInfo where category = 901
update dbo.tFVUserMaster set comreward = @comreward where gameid = @gameid
select @comreward = comreward  from dbo.tFVUserMaster where gameid = @gameid
exec spu_FVFarmD 19, 95, @comreward, -1, -1, -1, -1, -1, -1, -1, @gameid, '', '', '', '', '', '', '', '', ''

while(@comreward != -1)
	begin
		-- 1. 초기화.
		update dbo.tFVUserMaster
			set
				cashcost = 0, gamecost = 0, heart = 0,
				bktwolfkillcnt	= 1,	bktsalecoin		= 2,	bkheart			= 3,	bkfeed			= 4,	bktsuccesscnt	= 5,	bktbestfresh	= 6,
				bktbestbarrel	= 7,	bktbestcoin		= 8,	bkbarrel		= 9,	bkcrossnormal	= 10,	bkcrosspremium	= 11
		where gameid = @gameid

		-- 2. 퀘보상.
		exec spu_FVComRewardTest @gameid, @password, @comreward, '',  0, -1

		-- 3. 현재퀘 상태정보.
		select -- @nextcomreward = param8,
				@nextinitpart1 = param9, @nextinitpart2	= param10 from dbo.tFVItemInfo
		where itemcode = @comreward
		select @nextcomreward = comreward from dbo.tFVUserMaster where gameid = @gameid

		select
			@comreward comreward, @nextinitpart1 initpart1, @nextinitpart2 initpart2,
			gameid, cashcost, gamecost, heart, feed, fpoint, comreward,
			bktwolfkillcnt, bktsalecoin, bkheart, bkfeed, bktsuccesscnt, bktbestfresh,
			bktbestbarrel, bktbestcoin, bkbarrel, bkcrossnormal, bkcrosspremium
		from dbo.tFVUserMaster
		where gameid = @gameid

		set @comreward	= @nextcomreward
		set @loop = @loop - 1
		if(@loop < 0)break;
	end
*/
/*
-- 퀘스트 파라미터 검사.
--select itemcode, param8, param11, * from dbo.tFVItemInfo where category = 901
declare @itemcode	int, @checknext int, @checkpre int, @activate int,
		@param1 int, @param2 int, @param3 int, @param4 int, @param5 int,
		@param6 int, @param7 int, @param8 int, @param9 int, @param10 int, @param11 int, @param9b int
declare curQuest Cursor for
select itemcode, param8, param11, activate, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 from dbo.tFVItemInfo where category = 901

-- 2. 커서오픈
open curQuest

-- 3. 커서 사용
Fetch next from curQuest into @itemcode, @checknext, @checkpre, @activate, @param1, @param2, @param3, @param4, @param5, @param6, @param7, @param8, @param9, @param10, @param11
while @@Fetch_status = 0
	Begin
		if(@activate = 1)
			begin
				if(@itemcode + 1 != @checknext)select '다음체킹 error', @itemcode itemcode, @checknext checknext
				if(@itemcode - 1 != @checkpre)select '이전체킹 error', @itemcode itemcode, @checkpre checkpre
				if(@param1 not in (0, 1, 2, 3, 5)) select '보상 error', @itemcode itemcode
				if(@param3 != @param9b) select '조건 error', @itemcode itemcode, @param3 param3, @param9b param9b
			end
		set @param9b = @param9
		Fetch next from curQuest into @itemcode, @checknext, @checkpre, @activate, @param1, @param2, @param3, @param4, @param5, @param6, @param7, @param8, @param9, @param10, @param11
	end

-- 4. 커서닫기
close curQuest
Deallocate curQuest
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVComRewardTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVComRewardTest;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVComRewardTest
	@gameid_								varchar(60),
	@password_								varchar(20),
	@comreward_								int,
	@paraminfo_								varchar(1024),
	@ispass_								int,
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
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	--declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	--declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int			set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	--declare @RESULT_ERROR_NOT_FOUND_GIFTID	int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	--declare @RESULT_ERROR_NOT_SUPPORT_MODE	int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	--declare @RESULT_ERROR_NOT_FOUND_OTHERID	int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	--declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	--declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int			set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	--declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	--declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int			set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	--declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	--declare @MARKET_SKT						int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	--declare @MARKET_GOOGLE					int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 경쟁모드 정의값.
	declare @BKT_WOLF_KILL_CNT					int					set @BKT_WOLF_KILL_CNT						= 1		-- 누적늑대잡이(1)
	declare @BKT_SALE_COIN						int                 set @BKT_SALE_COIN							= 11	-- 누적판매금액(11)
	declare @BKT_HEART 							int                 set @BKT_HEART 								= 12	-- 누적하트획득(12)
	declare @BKT_FEED 							int                 set @BKT_FEED 								= 13	-- 누적건초획득(13)
	declare @BKT_SUCCESS_CNT 					int                 set @BKT_SUCCESS_CNT 						= 14	-- 최고거래성공횟수(14)
	declare @BKT_BEST_FRESH 					int                 set @BKT_BEST_FRESH 						= 15	-- 최고신선도(15)
	declare @BKT_BEST_BARREL 					int                 set @BKT_BEST_BARREL 						= 16	-- 최고배럴(16)
	declare @BKT_BEST 							int                 set @BKT_BEST 								= 17	-- 최고판매금액(17)
	declare @BKT_BARREL							int                 set @BKT_BARREL								= 18	-- 누적배럴(18)
	declare @BKT_CROSS_NORMAL 					int                 set @BKT_CROSS_NORMAL 						= 21	-- 누적일반교배(21)
	declare @BKT_CROSS_PREMIUM 					int                 set @BKT_CROSS_PREMIUM 						= 22	-- 누적프리미엄교배(22)

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE								= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE								= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @USER_LIST_MAX						int					set @USER_LIST_MAX 							= 50

	-- 점프퀘스트
	declare @COMREWARD_CHECK_POINT				int					set @COMREWARD_CHECK_POINT					= 90372
	declare @COMREWARD_NEW_NEXT					int					set @COMREWARD_NEW_NEXT						= 90373
	declare @COMREWARD_OLD_NEXT					int					set @COMREWARD_OLD_NEXT	 					= 90152
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 				varchar(60)			set @gameid			= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @comreward				int					set @comreward			= -1
	declare @market					int					set @market				= @MARKET_IPHONE

	declare @gameyear				int					set @gameyear			= -1
	declare @gamemonth				int					set @gamemonth			= -1
	declare @famelv					int					set @famelv				= -1

	declare @rewardkind				int					set @rewardkind 		= -1
	declare @rewardvalue			int					set @rewardvalue		= 0
	declare @brewardwrite			int					set @brewardwrite		= @BOOL_TRUE

	declare @nextcomreward			int					set @nextcomreward		= -1
	declare @nextinitpart1			int					set @nextinitpart1		= 0
	declare @nextinitpart2			int					set @nextinitpart2		= 0
	declare @brecord				int					set @brecord			= -1
	declare @part1					int					set @part1				= -1
	declare @part2					int					set @part2				= -1

	declare @kind				int,
			@info				int,
											@param20			int,
											@param21			int,
											@param22			int,
											@param23			int,
											@param24			int,
											@param25			int,
											@param26			int,
											@param27			int,
											@param28			int,
											@param29			int
	declare @comment				varchar(512)
	declare @idx2				int			set @idx2 			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @comreward_ comreward_

	------------------------------------------------
	--	3-2. 연산수행(유저정보)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,
		@comreward		= comreward,
		@market			= market,

		@gameyear 		= gameyear,
		@gamemonth 		= gamemonth,
		@famelv 		= famelv
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @comreward comreward, @gameyear gameyear, @gamemonth gamemonth, @famelv famelv

	------------------------------------------------
	--	3-2. 획득리스트와 도감 마스터 일치여부파악.
	-- 		 > 보유템에 존재여부 파악하기.
	------------------------------------------------
	select
		@rewardkind 	= param1,
		@rewardvalue 	= param2,
		@nextcomreward	= param8,
		@nextinitpart1	= param9,
		@nextinitpart2	= param10
	from dbo.tFVItemInfo
	where itemcode = @comreward_ and subcategory = @ITEM_SUBCATEGORY_COMPETITION
	--select 'DEBUG 경쟁모드 마스터', @rewardkind rewardkind, @rewardvalue rewardvalue, @nextcomreward nextcomreward, @nextinitpart1 nextinitpart1, @nextinitpart2 nextinitpart2

	-- iphone은 퀘스트 진행을 돌린다.
	if(@market in (@MARKET_IPHONE) and @comreward_ = @COMREWARD_CHECK_POINT and @nextcomreward = @COMREWARD_NEW_NEXT)
		begin
			set @nextcomreward = @COMREWARD_OLD_NEXT
		end

	------------------------------------------------
	--	메인체킹
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and exists(select top 1 * from dbo.tFVComReward where gameid = @gameid_ and itemcode = @comreward_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment 	= 'DEBUG 이미 지급했다.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and (@rewardkind = -1 or @comreward != @comreward_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '경쟁모드 번호가 존재안한다.'
			--select 'DEBUG ', @comment
		END
	else if(@ispass_ = 1)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG 경쟁모드 패스합니다.'
			--select 'DEBUG ', @comment

			if(@comreward_ = -1)
				begin
					set @brewardwrite 	= @BOOL_FALSE
				end
			else
				begin
					set @brewardwrite 	= @BOOL_TRUE
				end
			set @brecord		= 1
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG 정상지급합니다.'
			--select 'DEBUG ', @comment

			--코인(0)
			--캐쉬(1)
			--하트(2)
			--건초(3)
			--우정포인트(4)
			--아이템코드(5)
			if(@comreward_ = -1)
				begin
					set @brewardwrite = @BOOL_FALSE
					--select 'DEBUG 단순초기화비기록', @rewardvalue
				end
			else if(@rewardkind = 0)
				begin
					set @gamecost = @gamecost + @rewardvalue
					--select 'DEBUG 코인지급', @rewardvalue
				end
			else if(@rewardkind = 1)
				begin
					set @cashcost = @cashcost + @rewardvalue
					--select 'DEBUG 캐쉬지급', @rewardvalue
				end
			else if(@rewardkind = 2)
				begin
					set @heart = @heart + @rewardvalue
					--select 'DEBUG 하트지급', @rewardvalue
				end
			else if(@rewardkind = 3)
				begin
					set @feed = @feed + @rewardvalue
					--select 'DEBUG 건초지급', @rewardvalue
				end
			else if(@rewardkind = 4)
				begin
					set @fpoint = @fpoint + @rewardvalue
					--select 'DEBUG 우정포인트', @rewardvalue
				end
			else if(@rewardkind = 5)
				begin
					if(exists(select top 1 * from dbo.tFVItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 'SysCom', @gameid_, ''				-- 특정아이템 지급
						end
					--select 'DEBUG 아이템코드', @rewardvalue
				end

			set @brecord	= 1
		END

	if(@nResult_ = @RESULT_SUCCESS and @brecord	= 1)
		BEGIN
			--------------------------------------------------------------
			--	보상 기록(위에서 검사함)
			--------------------------------------------------------------
			if(@brewardwrite = @BOOL_TRUE)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tFVComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					insert into dbo.tFVComReward(gameid,   itemcode,           ispass,        gameyear,  gamemonth,  famelv,  idx2)
					values(                   @gameid_, @comreward_, isnull(@ispass_, -1), @gameyear, @gamemonth, @famelv, @idx2)

					delete dbo.tFVComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX
				end

			--------------------------------------------------------------
			--	다음퀘, 다음데이타 초기화
			--------------------------------------------------------------
			set @comreward		= case
										when @comreward_ != -1		then 	@nextcomreward
										else 								@comreward
								  end
			set @part1			= @nextinitpart1
			set @part2			= @nextinitpart2
			--select 'DEBUG ', @part1 part1, @part2 part2

			----------------------------------------------
			-- 입력정보3-2.(param) >
			-- paraminfo=param0;param1;param2;param3;...
			--       0:0;   1:0;   2:0;   3:0;
			----------------------------------------------
			set @param20 		= @INIT_VALUE
			set @param21 		= @INIT_VALUE
			set @param22 		= @INIT_VALUE
			set @param23 		= @INIT_VALUE
			set @param24 		= @INIT_VALUE
			set @param25 		= @INIT_VALUE
			set @param26 		= @INIT_VALUE
			set @param27 		= @INIT_VALUE
			set @param28 		= @INIT_VALUE
			set @param29 		= @INIT_VALUE

			if(LEN(@paraminfo_) >= 3)
				begin
					-- 1. 커서 생성
					declare curParamInfo Cursor for
					select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @paraminfo_)

					-- 2. 커서오픈
					open curParamInfo

					-- 3. 커서 사용
					Fetch next from curParamInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = 0)
								begin
									set @param20 		= @info
								end
							else if(@kind = 1)
								begin
									set @param21 		= @info
								end
							else if(@kind = 2)
								begin
									set @param22 		= @info
								end
							else if(@kind = 3)
								begin
									set @param23 		= @info
								end
							else if(@kind = 4)
								begin
									set @param24 		= @info
								end
							else if(@kind = 5)
								begin
									set @param25 		= @info
								end
							else if(@kind = 6)
								begin
									set @param26 		= @info
								end
							else if(@kind = 7)
								begin
									set @param27 		= @info
								end
							else if(@kind = 8)
								begin
									set @param28 		= @info
								end
							else if(@kind = 9)
								begin
									set @param29 		= @info
								end
							Fetch next from curParamInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curParamInfo
					Deallocate curParamInfo
					--select 'DEBUG 입력정보(useinfo)', @param20 param20, @param21 param21, @param22 param22, @param23 param23, @param24 param24, @param25 param25, @param26 param26, @param27 param27, @param28 param28, @param29 param29
				end
		END




	--select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	정보기록
			--------------------------------------------------------------


			update dbo.tFVUserMaster
				set
					cashcost		= @cashcost,
					gamecost		= @gamecost,
					heart			= @heart,
					feed			= @feed,
					fpoint			= @fpoint,
					comreward		= @comreward,

					-- 파라미터
					param0			= case when (@param20 != @INIT_VALUE) 			then @param20		else param0			end,
					param1			= case when (@param21 != @INIT_VALUE) 			then @param21		else param1			end,
					param2			= case when (@param22 != @INIT_VALUE) 			then @param22		else param2			end,
					param3			= case when (@param23 != @INIT_VALUE) 			then @param23		else param3			end,
					param4			= case when (@param24 != @INIT_VALUE) 			then @param24		else param4			end,
					param5			= case when (@param25 != @INIT_VALUE) 			then @param25		else param5			end,
					param6			= case when (@param26 != @INIT_VALUE) 			then @param26		else param6			end,
					param7			= case when (@param27 != @INIT_VALUE) 			then @param27		else param7			end,
					param8			= case when (@param28 != @INIT_VALUE) 			then @param28		else param8			end,
					param9			= case when (@param29 != @INIT_VALUE) 			then @param29		else param9			end,

					bktwolfkillcnt	= case when @BKT_WOLF_KILL_CNT 	in (@part1, @part2) 	then 0 					else 	bktwolfkillcnt 	end,
					bktsalecoin		= case when @BKT_SALE_COIN 		in (@part1, @part2) 	then 0 					else 	bktsalecoin	 	end,
					bkheart			= case when @BKT_HEART 			in (@part1, @part2) 	then 0 					else 	bkheart 		end,
					bkfeed			= case when @BKT_FEED 			in (@part1, @part2) 	then 0 					else 	bkfeed 			end,
					bktsuccesscnt	= case when @BKT_SUCCESS_CNT 	in (@part1, @part2) 	then 0 					else 	bktsuccesscnt 	end,
					bktbestfresh	= case when @BKT_BEST_FRESH 	in (@part1, @part2) 	then 0 					else 	bktbestfresh 	end,
					bktbestbarrel	= case when @BKT_BEST_BARREL 	in (@part1, @part2) 	then 0 					else 	bktbestbarrel 	end,
					bktbestcoin		= case when @BKT_BEST 			in (@part1, @part2) 	then 0 					else 	bktbestcoin 	end,
					bkbarrel		= case when @BKT_BARREL 		in (@part1, @part2) 	then 0 					else 	bkbarrel 		end,
					bkcrossnormal	= case when @BKT_CROSS_NORMAL 	in (@part1, @part2) 	then 0 					else 	bkcrossnormal 	end,
					bkcrosspremium	= case when @BKT_CROSS_PREMIUM 	in (@part1, @part2) 	then 0 					else 	bkcrosspremium 	end
			where gameid = @gameid_


			--------------------------------------------------------------
			--	유저정보.
			--------------------------------------------------------------
			--select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	선물함.
			--------------------------------------------------------------
			--exec spu_FVGiftList @gameid_

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



