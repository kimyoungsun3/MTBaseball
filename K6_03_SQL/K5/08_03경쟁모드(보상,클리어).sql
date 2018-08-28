/*
-- update dbo.tItemInfo set param8 = 90373 where category = 901 and itemcode = 90372
--paraminfo=param0:value0;param1:value1;
delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90100, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;', -1, -1	-- 단순초기화.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;', -1, -1	-- 코인 > 다음퀘로 자동진행.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;', -1, -1	-- 캐쉬
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;', -1, -1	-- 하트
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;', -1, -1	-- 건초
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;', -1, -1	-- 우정포인트
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;', -1, -1	-- 아이템코드
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;', -1, -1	--

exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;',  1, -1	-- 단순초기화.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;',  1, -1	-- 코인 > 다음퀘로 자동진행.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;',  1, -1	-- 캐쉬
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;',  1, -1	-- 하트
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;',  1, -1	-- 건초
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;',  1, -1	-- 우정포인트
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;',  1, -1	-- 아이템코드
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;',  1, -1	--


delete from dbo.tComReward where gameid = 'xxxx2'
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90378, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;', -1, -1	-- 누적늑대잡고(1) > 최고신선도 클리어(15)	정상
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;', -1, -1	-- 최고신선도(15)  > 누적판매금액(11)

exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;',  1, -1	-- 누적늑대잡고(1) > 최고신선도 클리어(15)	패스
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;',  1, -1	-- 최고신선도(15)  > 누적판매금액(11)


update dbo.tUserMaster set comreward = 90200, version = 109 where gameid = 'xxxx2' 	delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90200, version = 110 where gameid = 'xxxx2' 	delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90200, '0:0;1:1;', -1, -1	-- 동물지급

update dbo.tUserMaster set comreward = 90221 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90221, '0:0;1:1;', -1, -1

update dbo.tUserMaster set comreward = 90241 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90241, '0:0;1:1;', -1, -1

update dbo.tUserMaster set comreward = 90258 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90258, '0:0;1:1;', -1, -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ComReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ComReward;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ComReward
	@gameid_								varchar(20),
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

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

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

	declare @BKT_TSGRADE1_CNT 					int                 set @BKT_TSGRADE1_CNT 						= 23	--임시일반보물뽑기(23).
	declare @BKT_TSGRADE2_CNT 					int                 set @BKT_TSGRADE2_CNT 						= 24	--임시프림보물뽑기(24).
	declare @BKT_TSUP_CNT 						int                 set @BKT_TSUP_CNT 							= 25	--임시보물강화횟수(25).
	declare @BKT_BATTLE_CNT 					int                 set @BKT_BATTLE_CNT 						= 26	--임시배틀참여횟수(26).
	declare @BKT_ANI_UP_CNT						int                 set @BKT_ANI_UP_CNT 						= 27	--임시동물강화(27).
	declare @BKT_APART_ANI						int                 set @BKT_APART_ANI 							= 28	--임시동물분해(28).
	declare @BKT_APART_TS						int                 set @BKT_APART_TS 							= 29	--임시보물분해(29).
	declare @BKT_COMPOSE_CNT					int                 set @BKT_COMPOSE_CNT						= 20	--임시동물합성(20).

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE								= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE								= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @USER_LIST_MAX						int					set @USER_LIST_MAX 							= 50

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 				varchar(20)			set @gameid			= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @comreward				int					set @comreward			= -1
	declare @version				int					set @version			= -1

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

	declare @kind					int,
			@info					int,
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
	declare @idx2					int			set @idx2 			= 0
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
		@version 		= version,

		@gameyear 		= gameyear,
		@gamemonth 		= gamemonth,
		@famelv 		= famelv
	from dbo.tUserMaster
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
	from dbo.tItemInfo
	where itemcode = @comreward_ and subcategory = @ITEM_SUBCATEGORY_COMPETITION
	--select 'DEBUG 경쟁모드 마스터', @rewardkind rewardkind, @rewardvalue rewardvalue, @nextcomreward nextcomreward, @nextinitpart1 nextinitpart1, @nextinitpart2 nextinitpart2


	------------------------------------------------
	--	메인체킹
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and exists(select top 1 * from dbo.tComReward where gameid = @gameid_ and itemcode = @comreward_))
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
					-------------------------------------------------
					-- 버젼이 낮아서 발생한 문제.
					-------------------------------------------------
					if( @version <= 109 )
						begin
							--select 'DEBUG 퀘스트 가로채기(전)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
							if( @comreward_ = 90200 and @rewardvalue = 104 )
								begin
									set @rewardvalue = 105
									--select 'DEBUG 퀘스트 가로채기 (후)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
							else if( @comreward_ = 90241 and @rewardvalue = 205 )
								begin
									set @rewardvalue = 207
									--select 'DEBUG 퀘스트 가로채기 (후)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
							else if( @comreward_ = 90258 and @rewardvalue = 206 )
								begin
									set @rewardvalue = 211
									--select 'DEBUG 퀘스트 가로채기 (후)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
						end

					-------------------------------------------------
					-- 아이템 지급.
					-------------------------------------------------
					if(exists(select top 1 * from dbo.tItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 0, 'SysCom', @gameid_, ''				-- 특정아이템 지급
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
					select @idx2 = isnull(max(idx2), 1) from dbo.tComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					insert into dbo.tComReward(gameid,   itemcode,           ispass,        gameyear,  gamemonth,  famelv,  idx2)
					values(                   @gameid_, @comreward_, isnull(@ispass_, -1), @gameyear, @gamemonth, @famelv, @idx2)

					delete dbo.tComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX
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
			--select 'DEBUG ', @comreward comreward, @part1 part1, @part2 part2

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




	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	정보기록
			--------------------------------------------------------------
			update dbo.tUserMaster
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
					bkcrosspremium	= case when @BKT_CROSS_PREMIUM 	in (@part1, @part2) 	then 0 					else 	bkcrosspremium 	end,

					bktsgrade1cnt	= case when @BKT_TSGRADE1_CNT 	in (@part1, @part2) 	then 0 					else 	bktsgrade1cnt 	end,
					bktsgrade2cnt	= case when @BKT_TSGRADE2_CNT 	in (@part1, @part2) 	then 0 					else 	bktsgrade2cnt 	end,
					bktsupcnt		= case when @BKT_TSUP_CNT 		in (@part1, @part2) 	then 0 					else 	bktsupcnt 		end,
					bkbattlecnt		= case when @BKT_BATTLE_CNT 	in (@part1, @part2) 	then 0 					else 	bkbattlecnt 	end,
					bkaniupcnt		= case when @BKT_ANI_UP_CNT 	in (@part1, @part2) 	then 0 					else 	bkaniupcnt 		end,

					bkapartani		= case when @BKT_APART_ANI	 	in (@part1, @part2) 	then 0 					else 	bkapartani 		end,
					bkapartts		= case when @BKT_APART_TS	 	in (@part1, @part2) 	then 0 					else 	bkapartts 		end,
					bkcomposecnt	= case when @BKT_COMPOSE_CNT 	in (@part1, @part2) 	then 0 					else 	bkcomposecnt 	end


			where gameid = @gameid_


			--------------------------------------------------------------
			--	유저정보.
			--------------------------------------------------------------
			select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	선물함.
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



