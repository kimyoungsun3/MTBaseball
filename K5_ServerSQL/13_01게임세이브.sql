/*
--(주의) 빈공백(Tab)으로 사용하면 오류나온다.
userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;boosteruse;albause;wolfappear;wolfkillcnt;albausesecond;albausethird;petcooltime
         0:2013;  1:3;      2:12;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;       44:-1;        45:-1;       46:2;
         0:2015;  1:1;      2:65;     4:2;       10:0;        11:0;       12:390;    13:38150; 30:54;  40:1103;   41:1002;42:-1;     43:2;       44:1002;      45:-1;
aniitem=listidx:anistep,manger,diseasestate; (인벤[O], 필드[O], 병원[X])
		...
		1:5,24,1;		--> 자체분리 	> 4 : 5, 25, 0
		3:5,23,0;
		4:5,25,0;		--> 동물병원 	> 자체필터.
		45:5,25,0;    22:5,25,0;    23:5,20,0;    24:5,25,0;    31:4,26,0;
		32:4,22,0;    33:5,25,0;    34:5,24,0;    35:4,21,0;    36:5,26,0;
		37:5,25,0;    41:5,25,0;    44:5,25,0;
cusitem=listidx:usecnt;
		...
		14:1;
		15:1;
		16:1;			--> 악세사리(자동필터)
paraminfo=param0:value0
		...
		0:0;
		1:0;
		2:0;			--> 파라미터데이타
-- playcoin : 휴발성 데이타로 중간에 저장안함.

update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_GameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.
-- delete from dbo.tUserUnusualLog2
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- 낡은 공포탄(700)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- 아주 작은 백신(800)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- 알바의 귀재(1002)	 3	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- 아주 작은 촉진제(1100)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- 부활석(1200)	 6	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 18	-- 긴급요청 티켓(2100)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 19	-- 일반 교배 티켓(2200)	 99	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- 프리미엄 교배 티켓(2300)	 1	소모품(3)	선물(5)	2014
update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_GameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- 보유 1개 > 1개 정상사용
													'7:2;16:2;9:2;10:2;11:2;18:2;19:2;15:2;',	-- 보유 1개 > 2개 오류필터
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GameSave', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GameSave;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GameSave
	@gameid_								varchar(20),
	@password_								varchar(20),
	@userinfo_								varchar(8000),
	@aniitem_								varchar(8000),
	@cusitem_								varchar(8000),
	@paraminfo_								varchar(8000),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이

	-- 세이브값종류
	declare @SAVE_USERINFO_GAMEYEAR				int					set @SAVE_USERINFO_GAMEYEAR					= 0
	declare @SAVE_USERINFO_MONTH				int					set @SAVE_USERINFO_MONTH					= 1
	declare @SAVE_USERINFO_FRAMETIME			int					set @SAVE_USERINFO_FRAMETIME				= 2
	declare @SAVE_USERINFO_FEVERGAUGE			int					set @SAVE_USERINFO_FEVERGAUGE				= 4
	declare @SAVE_USERINFO_BOTTLELITTLE			int					set @SAVE_USERINFO_BOTTLELITTLE				= 10
	declare @SAVE_USERINFO_BOTTLEFRESH			int					set @SAVE_USERINFO_BOTTLEFRESH				= 11
	declare @SAVE_USERINFO_TANKLITTLE			int					set @SAVE_USERINFO_TANKLITTLE				= 12
	declare @SAVE_USERINFO_TANKFRESH			int					set @SAVE_USERINFO_TANKFRESH				= 13
	declare @SAVE_USERINFO_USEFEED				int					set @SAVE_USERINFO_USEFEED					= 30
	declare @SAVE_USERINFO_BOOSTERUSE			int					set @SAVE_USERINFO_BOOSTERUSE				= 40
	declare @SAVE_USERINFO_ALBAUSE				int					set @SAVE_USERINFO_ALBAUSE					= 41
	declare @SAVE_USERINFO_ALBAUSE_SECOND		int					set @SAVE_USERINFO_ALBAUSE_SECOND			= 44
	declare @SAVE_USERINFO_ALBAUSE_THIRD		int					set @SAVE_USERINFO_ALBAUSE_THIRD			= 45
	declare @SAVE_USERINFO_WOLFAPPEAR			int					set @SAVE_USERINFO_WOLFAPPEAR				= 42
	declare @SAVE_USERINFO_WOLFKILLCNT			int					set @SAVE_USERINFO_WOLFKILLCNT				= 43
	declare @SAVE_USERINFO_PETCOOLTIME			int					set @SAVE_USERINFO_PETCOOLTIME				= 46

	-- 그룹.
	declare @ITEM_REVIVAL_MOTHER				int					set @ITEM_REVIVAL_MOTHER					= 1200	-- 부활석.
	declare @ITEM_COMPOSE_TIME_MOTHER			int					set @ITEM_COMPOSE_TIME_MOTHER				= 1600	-- 합성시간 1시간초기화.
	declare @ITEM_HELPER_MOTHER					int					set @ITEM_HELPER_MOTHER						= 2100	-- 긴급지원.
	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- 일반교배뽑기.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- 프리미엄교배뽑기.


	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- 단계.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- 여물통.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- 질병상태.

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @CHAR_SPLIT_COMMA					varchar(1)			set @CHAR_SPLIT_COMMA						= ','
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 							= 2

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @comment2			varchar(512)
	declare @kind				int,
			@info				int,
			@listidx			int,
			@strdata			varchar(40)

	declare @gameid 			varchar(20)	set @gameid			= ''
	declare @gamecost			int,
			@cashcost			int,
			@feed				int,		@feeduse2			int,
			@heart				int,

			@gameyear			int,		@gameyear2			int,
			@gamemonth			int,		@gamemonth2			int,
			@frametime			int,		@frametime2			int,
			@fevergauge			int,		@fevergauge2		int,
			@bottlelittle		int,		@bottlelittle2		int,	@bottlelittlemax 	int,
			@bottlefresh		int,		@bottlefresh2		int,
			@tanklittle			int,		@tanklittle2		int,	@tanklittlemax		int,
			@tankfresh			int,		@tankfresh2			int,
											@boosteruse2		int,
											@albause2			int,
											@albausesecond2		int,
											@albausethird2		int,
											@petcooltime2		int,
											@wolfappear2		int,
			@bktwolfkillcnt		int,		@wolfkillcnt2		int,

											@param20			int,
											@param21			int,
											@param22			int,
											@param23			int,
											@param24			int,
											@param25			int,
											@param26			int,
											@param27			int,
											@param28			int,
											@param29			int,

			@tankstep			int,
			@bottlestep			int

	set @gamecost 		= 0
	set @cashcost 		= 0
	set @feed			= 0
	set @heart			= 0
	set @bktwolfkillcnt	= 0

	declare 								@stranistep2		varchar(40),
											@strmanger2			varchar(40),
											@strdiseasestate2	varchar(40),
											@listidx2			int,
											@usecnt2			int,
											@cusitemcode		int,
											@cusitemname		varchar(40),
											@cusowncnt			int,
			@data				varchar(40),@data2				varchar(40),
			@pos1	 			int, 		@pos2	 			int,	@pos3	 			int,
			@strlen				int

	declare @idx2				int

	-- 보물로 늘어난 정보.
	declare @tsskillbottlelittle	int				set @tsskillbottlelittle 	= 0 	-- 양동이.
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @userinfo_ userinfo_, @aniitem_ aniitem_, @cusitem_ cusitem_


	------------------------------------------------
	--	유저정보.
	------------------------------------------------
	select
		@gameid 		= gameid,		@gamecost		= gamecost,		@cashcost		= cashcost,
		@feed			= feed,			@heart			= heart,

		@gameyear		= gameyear,		@gamemonth		= gamemonth,
		@frametime		= frametime,	@fevergauge		= fevergauge,
		@bottlelittle	= bottlelittle,	@bottlefresh	= bottlefresh,	@tsskillbottlelittle = tsskillbottlelittle,
		@tanklittle		= tanklittle,	@tankfresh		= tankfresh,

		@bottlestep		= bottlestep,	@tankstep		= tankstep,

		@bktwolfkillcnt	= bktwolfkillcnt
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @gamecost gamecost, @feed feed, @gameyear gameyear, @gamemonth gamemonth, @frametime frametime, @fevergauge fevergauge, @bottlelittle bottlelittle, @bottlefresh bottlefresh, @tanklittle tanklittle, @tankfresh tankfresh

	------------------------------------------------
	-- 양동이, 탱크 > 우유량Max
	-- 양동이는 보물로 확장됨.
	------------------------------------------------
	select
		@bottlelittlemax	= param5 + @tsskillbottlelittle
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE and param1 = @bottlestep

	select
		@tanklittlemax		= param5 * 30
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TANK and param1 = @tankstep

	--select 'DEBUG 양동이MAX, 탱크MAX ', @bottlestep bottlestep, @bottlelittlemax bottlelittlemax, @tankstep tankstep, @tanklittlemax tanklittlemax


	------------------------------------------------
	-- 입력정보1 (useinfo).
	-- userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;
    --          0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:3;
	------------------------------------------------
	set @gameyear2 		= @INIT_VALUE
	set @gamemonth2 	= @INIT_VALUE
	set @frametime2		= @INIT_VALUE
	set @fevergauge2	= @INIT_VALUE
	set @bottlelittle2	= @INIT_VALUE
	set @bottlefresh2	= @INIT_VALUE
	set @tanklittle2	= @INIT_VALUE
	set @tankfresh2		= @INIT_VALUE
	set @feeduse2		= @INIT_VALUE
	set @boosteruse2	= @INIT_VALUE
	set @albause2		= -1
	set @albausesecond2	= -1
	set @albausethird2	= -1
	set @petcooltime2	= 0
	set @wolfappear2	= @INIT_VALUE
	set @wolfkillcnt2	= 0


	if(LEN(@userinfo_) >= 3)
		begin
			-- 1. 커서 생성
			declare curUserInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @userinfo_)

			-- 2. 커서오픈
			open curUserInfo

			-- 3. 커서 사용
			Fetch next from curUserInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					if(@kind = @SAVE_USERINFO_GAMEYEAR)
						begin
							set @gameyear2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_MONTH)
						begin
							set @gamemonth2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FRAMETIME)
						begin
							set @frametime2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FEVERGAUGE)
						begin
							set @fevergauge2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLELITTLE)
						begin
							set @bottlelittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLEFRESH)
						begin
							set @bottlefresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKLITTLE)
						begin
							set @tanklittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKFRESH)
						begin
							set @tankfresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_USEFEED)
						begin
							set @feeduse2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_BOOSTERUSE)
						begin
							set @boosteruse2	= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE)
						begin
							set @albause2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE_SECOND)
						begin
							set @albausesecond2	= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE_THIRD)
						begin
							set @albausethird2	= @info
						end
					else if(@kind = @SAVE_USERINFO_PETCOOLTIME)
						begin
							set @petcooltime2	= @info
						end
					else if(@kind = @SAVE_USERINFO_WOLFAPPEAR)
						begin
							set @wolfappear2	= @info
						end
					else if(@kind = @SAVE_USERINFO_WOLFKILLCNT)
						begin
							set @wolfkillcnt2	= @info
						end
					Fetch next from curUserInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curUserInfo
			Deallocate curUserInfo
			--select 'DEBUG 입력정보(useinfo)', @gameyear2 gameyear2, @gamemonth2 gamemonth2, @frametime2 frametime2, @fevergauge2 fevergauge2, @bottlelittle2 bottlelittle2, @bottlefresh2 bottlefresh2, @tanklittle2 tanklittle2, @tankfresh2 tankfresh2, @feeduse2 feeduse2, @boosteruse2 boosteruse2, @albause2 albause2, @wolfappear2 wolfappear2, @wolfkillcnt2 wolfkillcnt2
		end

	------------------------------------------------
	-- 입력정보2.(aniitem) > 하단에서 세팅.
	------------------------------------------------

	------------------------------------------------
	-- 입력정보3.(cusitem) > 하단에서 세팅.
	------------------------------------------------

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
			--select 'DEBUG 입력정보(paraminfo)', @param20 param20, @param21 param21, @param22 param22, @param23 param23, @param24 param24, @param25 param25, @param26 param26, @param27 param27, @param28 param28, @param29 param29
		end

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment comment
		END
	else if(@gameyear2 = @INIT_VALUE 		or @gamemonth2 = @INIT_VALUE	or @frametime2 = @INIT_VALUE 	or @fevergauge2 = @INIT_VALUE
			or @bottlelittle2 = @INIT_VALUE 	or @bottlefresh2 = @INIT_VALUE	or @tanklittle2	= @INIT_VALUE	or @tankfresh2	= @INIT_VALUE	or @feeduse2		= @INIT_VALUE
			--or @boosteruse2 = @INIT_VALUE		or @albause2 = @INIT_VALUE		or @wolfappear2 = @INIT_VALUE 	or @wolfkillcnt2= 0
			)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	=  '파라미터 오류(1) 유저정보오류 > 그냥 저장안하고패스.'
			--select 'DEBUG ', @comment comment
		END
	else if(@gameyear != @gameyear2 or @gamemonth != @gamemonth2 or @frametime > @frametime2)
		BEGIN
			--set @nResult_ 	= @RESULT_ERROR_PARAMETER
			--set @comment 	=  '파라미터 오류(2) 날짜오류.'
			--select 'DEBUG ', @comment comment, @gameyear gameyear, @gameyear2 gameyear2, @gamemonth gamemonth, @gamemonth2 gamemonth2, @frametime frametime, @frametime2 frametime2


			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '저장오류 패스합니다.'
			select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
			return;
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '정보를 저장합니다(1).'
			--select 'DEBUG ', @comment comment

			----------------------------------------------
			-- 유저정보저장, 거래정보.(보정만하기.)
			----------------------------------------------
			-- 프레임타임(0 -> 70), 시간이 뒤로는 못간다.
			set @frametime = case
								when @frametime2 < 0 then 0
								when @frametime2 > 70 then 70
								else @frametime2
							end
			-- 피버검사.
			set @fevergauge		= case when (@fevergauge2 < 0 or @fevergauge2 >= 5) then 0 else @fevergauge2 end
			--select 'DEBUG 피버(후)', @frametime frametime, @frametime2 frametime2, @fevergauge fevergauge, @fevergauge2 fevergauge2

			-- 사용 사료.
			set @feed = @feed - case when (@feeduse2 < 0) then (-@feeduse2) else @feeduse2 end
			set @feed = case when @feed < 0 then 0 else @feed end
			--select 'DEBUG 사용 사료(후)', @feed feed, @feeduse2 feeduse2

			--select 'DEBUG 양동이, 탱크(전)', @bottlelittle bottlelittle, @bottlelittle2 bottlelittle2,	@bottlelittlemax bottlelittlemax, @bottlefresh bottlefresh, 	@bottlefresh2 bottlefresh2, @tanklittle tanklittle, 	@tanklittle2 tanklittle2, 		@tanklittlemax tanklittlemax, @tankfresh tankfresh,		@tankfresh2 tankfresh2
			-- 우유 양동이, 탱크.
			set @bottlelittle	= case
									when (@bottlelittle2 < 0) 						then 0
									when (@bottlelittle2 > @bottlelittlemax) 		then @bottlelittlemax
									else @bottlelittle2
								  end
			set @bottlefresh	= case
									when (@bottlefresh2 < 0)						then 0
									when (@bottlefresh2 > @bottlelittlemax * 300)	then @bottlelittlemax * 300
									else @bottlefresh2
								  end
			set @tanklittle		= case
									when (@tanklittle2 < 0)							then 0
									when (@tanklittle2 > @tanklittlemax)	 		then @tanklittlemax
									else @tanklittle2
								  end
			set @tankfresh		= case
									when (@tankfresh2 < 0)							then 0
									when (@tankfresh2 > @tanklittlemax * 300) 		then @tanklittlemax * 300
									else @tankfresh2
								  end

			--set @bottlelittle	= case when (@bottlelittle2 < 0 or (@bottlelittle2 > @bottlelittlemax)) 	then 0 	else @bottlelittle2 end
			--set @bottlefresh	= case when (@bottlefresh2 < 0 	or (@bottlefresh2 > @bottlelittlemax * 300))then 0 	else @bottlefresh2 	end
			--set @tanklittle	= case when (@tanklittle2 < 0 	or (@tanklittle2 > @tanklittlemax))	 		then 0 	else @tanklittle2 	end
			--set @tankfresh	= case when (@tankfresh2 < 0 	or (@tankfresh2 > @tanklittlemax * 300)) 	then 0	else @tankfresh2 	end
			--select 'DEBUG 양동이, 탱크(후)', @bottlelittle bottlelittle, @bottlelittle2 bottlelittle2,	@bottlelittlemax bottlelittlemax, @bottlefresh bottlefresh, 	@bottlefresh2 bottlefresh2, @tanklittle tanklittle, 	@tanklittle2 tanklittle2, 		@tanklittlemax tanklittlemax, @tankfresh tankfresh,		@tankfresh2 tankfresh2

			-- 소모템 정보검사.
			--set @boosteruse2	= case when (@boosteruse2 not in(-1, 1100, 1101, 1102)) then -1 else @boosteruse2 	end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @boosteruse2 and subcategory = @ITEM_SUBCATEGORY_BOOSTER))
				begin
					set @boosteruse2 = -1
				end
			--set @albause2		= case when (@albause2 not in(-1, 1000, 1001, 1002)) 	then -1 else @albause2 		end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albause2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albause2 = -1
				end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albausesecond2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albausesecond2 = -1
				end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albausethird2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albausethird2 = -1
				end
			--set @wolfappear2 	= case when (@wolfappear2 not in(-1, 0, 1, 2, 3, 4, 5)) 				then -1 else @wolfappear2 	end
			set @wolfkillcnt2 = case when @wolfkillcnt2 not in(0, 1, 2, 3)	 							then  0 else @wolfkillcnt2 	end
			set @bktwolfkillcnt	= @bktwolfkillcnt + @wolfkillcnt2

			----------------------------------------------
			-- 동물정보.
			----------------------------------------------
			if(LEN(@aniitem_) >= 7)
				begin
				----------------------------------------------
				-- 내부번호를 보고 필드번호세팅
				----------------------------------------------
				-- 1. 커서 생성
				declare curAniItem Cursor for
				select * FROM dbo.fnu_SplitTwoStr(';', ':', @aniitem_)

				-- 2. 커서오픈
				open curAniItem

				-- 3. 커서 사용
				Fetch next from curAniItem into @listidx2, @data2
				while @@Fetch_status = 0
					Begin
						set @strlen = LEN(@data2)
						set @pos1 	= 0
						set @pos2 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos1)
						set @pos3 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos2 + 1)
						set @stranistep2		= SUBSTRING(@data2, @pos1    , @pos2 - @pos1)
						set @strmanger2			= SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1)
						set @strdiseasestate2	= SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
						--select 'DEBUG ', @data2 data2, @strlen strlen, @pos1 pos1, @pos2 pos2, @pos3 pos3, SUBSTRING(@data2, @pos1    , @pos2 - @pos1), SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1), SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
						--select 'DEBUG ', @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2
						if(Isnumeric(@stranistep2) = 1 and Isnumeric(@strmanger2) = 1 and Isnumeric(@strdiseasestate2) = 1)
							begin
								--select 'DEBUG 동물정보저장 (문자열 > 정상처리).', @listidx2 listidx2, @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2

								-- 창고, 필드 	> 갱신
								-- 병원			> 패스
								update dbo.tUserItem
									set
										anistep 		= @stranistep2,
										manger			= @strmanger2,
										diseasestate	= @strdiseasestate2
								from dbo.tUserItem
								where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_ANI and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
							end
						Fetch next from curAniItem into @listidx2, @data2
					end

				-- 4. 커서닫기
				close curAniItem
				Deallocate curAniItem
			end

			----------------------------------------------
			-- 소모템 사용정보. > [1:2]
			----------------------------------------------
			if(LEN(@cusitem_) >= 3)
				begin
					-- 1. 커서 생성
					declare curCusItem Cursor for
					-- fieldidx	-> @listidx2
					-- listidx	-> @usecnt2
					select * FROM dbo.fnu_SplitTwo(';', ':', @cusitem_)

					-- 2. 커서오픈
					open curCusItem

					-- 3. 커서 사용
					Fetch next from curCusItem into @listidx2, @usecnt2
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG 소모템', @listidx2 listidx2, @usecnt2 usecnt2

							----------------------------------------------
							-- 음수대역은 양수로 바꾼다.(조작자방지)
							----------------------------------------------
							set @usecnt2 		= case when @usecnt2 < 0 then (-@usecnt2) else @usecnt2 end

							if(@usecnt2 > 0)
								begin
									----------------------------------------------
									-- 음수로 내려가는 것은 그대로 두자 (차후에 분석용으로 허용해둔다.)
									-- update >     find > @updatecnt	= @updatecnt + 1
									-- update > not find >
									-- 이방법을 응용한다.
									----------------------------------------------
									set @cusowncnt		= 0
									set @cusitemcode	= -1
									select
											@cusitemcode 	= itemcode,
											@cusowncnt		= cnt
									from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME
									--select 'DEBUG 아이템 소모 검사.', @gameid_ gameid_, @listidx2 listidx2, @cusitemcode cusitemcode, @cusowncnt cusowncnt, @usecnt2 usecnt2

									if(@cusitemcode = -1)
										begin
											--select 'DEBUG 없어 > 패스'
											set @cusitemcode	= -1
										end
									else if(@cusitemcode in (@ITEM_REVIVAL_MOTHER, @ITEM_COMPOSE_TIME_MOTHER, @ITEM_HELPER_MOTHER, @ITEM_ROULETTE_NOR_MOTHER, @ITEM_ROULETTE_PRE_MOTHER))
										begin
											--select 'DEBUG 부활, 긴급, 일반, 프리미엄교배, 합성시간 > 그때 차감 >(패스)'
											set @cusitemcode	= -1
										end
									else
										begin
											--select 'DEBUG 일반 소모템 > 총알, 백신, 알바, 촉진제(수량감소)'
											update dbo.tUserItem
												set
													cnt 			= case
																			when ((cnt - @usecnt2) < 0) then 0
																			else (cnt - @usecnt2)
																	  end
											from dbo.tUserItem
											where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME

											--------------------------------------------------
											-- 템을 보유하고 있지 않는데 사용을 했다면 필터 대상임.
											--------------------------------------------------
											--select 'DEBUG ', @listidx2 listidx2, @usecnt2 usecnt2, @cusowncnt cusowncnt, (@cusowncnt - @usecnt2) gapcha, @cusitemcode cusitemcode
											if((@cusowncnt - @usecnt2) < 0)
												begin
													-- 허용량 이상 검사.
													--select 'DEBUG 소모템을 허용량 이상 사용함'
													select @cusitemname = itemname from dbo.tItemInfo where itemcode = @cusitemcode
													set @comment2 = '(저장미필터중)' + @cusitemname + '(' +ltrim(rtrim(str(@cusitemcode)))+') 보유:'+ltrim(rtrim(str(@cusowncnt)))+' 사용:'+ltrim(rtrim(str(@usecnt2)))
													exec spu_SubUnusualRecord2 @gameid_, @comment2
												end
										end
								end
							Fetch next from curCusItem into @listidx2, @usecnt2
						end

					-- 4. 커서닫기
					close curCusItem
					Deallocate curCusItem

				end
		END


	select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--select 'DEBUG 유저 정보저장'
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					feed			= @feed,

					--gameyear		= @gameyear,
					--gamemonth		= @gamemonth,
					frametime		= @frametime,
					fevergauge		= @fevergauge,
					bottlelittle	= @bottlelittle,
					bottlefresh		= @bottlefresh,
					tanklittle		= @tanklittle,
					tankfresh		= @tankfresh,

					boosteruse 		= @boosteruse2,
					albause 		= @albause2,
					albausesecond 	= @albausesecond2,
					albausethird	= @albausethird2,
					wolfappear 		= @wolfappear2,
					--bottlestep	= @bottlestep,
					--tankstep		= @tankstep,
					petcooltime		= @petcooltime2,

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

					bktwolfkillcnt	= @bktwolfkillcnt
			where gameid = @gameid_

			------------------------------------------------
			-- 세이브정보저장.
			------------------------------------------------
			--클러스터 인덱스를 이용.
			set @idx2 = 0
			select top 1 @idx2 = isnull(idx2, 1) from dbo.tUserSaveLog where gameid = @gameid_ order by idx desc
			set @idx2 = @idx2 + 1

			insert into dbo.tUserSaveLog(
										idx2,
										gameid, 		gameyear, 			gamemonth, 			frametime,
										fevergauge, 	bottlelittle, 		bottlefresh, 		tanklittle,		tankfresh,
										feeduse,		boosteruse,			albause,			wolfappear,		wolfkillcnt,
										albausesecond,	albausethird,
										userinfo,		aniitem,			cusitem
			)
			values(
										@idx2,
										@gameid_, 		@gameyear2, 		@gamemonth2, 		@frametime2,
										@fevergauge2, 	@bottlelittle2, 	@bottlefresh2, 		@tanklittle2,	@tankfresh2,
										@feeduse2,		@boosteruse2,		@albause2,			@wolfappear2,	@wolfkillcnt2,
										@albausesecond2,@albausethird2,
										@userinfo_,		@aniitem_,			@cusitem_
			)
			delete from dbo.tUserSaveLog where gameid = @gameid_ and idx2 < @idx2 - @USER_LOG_MAX

			--select * from dbo.tUserMaster where gameid = @gameid_
		END


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



