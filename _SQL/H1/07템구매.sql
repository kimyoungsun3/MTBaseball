---------------------------------------------------------------
/* 
gameid=xxx
itemcode=xxx

select * from dbo.tItemInfo
select * from dbo.tUserMaster where gameid = 'SangSang'
update dbo.tUserMaster set goldball = 1, silverball = 1 where gameid = 'SangSang'
update dbo.tUserMaster set goldball = 100000, silverball = 100000 where gameid = 'SangSang'

exec spu_ItemBuy 'SangSang', 54, 	'', 	-1		-- 미존재템		> 오류
exec spu_ItemBuy 'SangSang', 50, 	'', 	-1		-- 얼굴구매		> 오류
exec spu_ItemBuy 'SangSang', 3200, 	'', 	-1		-- 락커룸		> 오류
exec spu_ItemBuy 'SangSang', 101, 	'', 	-1		-- 일반템 실버부족
exec spu_ItemBuy 'SangSang', 1, 	'', 	-1		-- 일반템 골드부족
select * from dbo.tUserItem where gameid = 'SangSang' and itemcode in (0)
exec spu_ItemBuy 'SangSang', 0, 	'', 	-1		-- 캐릭터영구템 > 이미보유

--select * from dbo.tUserItem where gameid = 'SangSang' order by idx desc
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (1, 51, 123, 223, 323, 52, 146, 246, 346, 53, 149, 249, 349)
exec spu_ItemBuy 'SangSang', 	'', 1, 		'', 	0, -1		-- 캐릭터영구템 > 
exec spu_ItemBuy 'SangSang', 	'', 2, 		'', 	0, -1		-- 캐릭터영구템 > 
exec spu_ItemBuy 'SangSang', 	'', 3, 		'', 	0, -1		-- 캐릭터영구템 > 
exec spu_ItemBuy 'Sangm', 		'', 3, 		'', 	0, -1		-- 캐릭터영구템 > 
exec spu_ItemBuy 'Sangm', 		'', 802, 	'', 	0, -1		-- 구장(802)
exec spu_ItemBuy 'superfast', 	'', 3, 		'', 	0, -1		-- 캐릭터영구템 > 
exec spu_ItemBuy 'superfast', 	'', 802, 	'', 	0, -1		-- 구장(802)

--select * from dbo.tItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01'
--select * from dbo.tItemBuyLog where gameid = 'SangSang' order by idx desc
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001)
--delete from dbo.tUserItem where gameid = 'SangSang' and itemcode in (102, 202, 302, 402, 502, 602, 702, 802, 5002)
exec spu_ItemBuy 'SangSang', '', 102, 	'', 	0,    -1		-- 모자(102)
exec spu_ItemBuy 'SangSang', '', 202, 	'', 	0,    -1		-- 상의(202)
exec spu_ItemBuy 'SangSang', '', 302, 	'', 	0,    -1		-- 하의(302)
exec spu_ItemBuy 'SangSang', '', 402, 	'', 	0,    -1		-- 배트(402)
exec spu_ItemBuy 'SangSang', '', 502, 	'', 	0,    -1		-- 안경(502)
exec spu_ItemBuy 'SangSang', '', 602, 	'', 	0,    -1		-- 날개(602)
exec spu_ItemBuy 'SangSang', '', 702, 	'', 	0,    -1		-- 꼬리(702)
exec spu_ItemBuy 'SangSang', '', 802, 	'', 	0,    -1		-- 구장(802)
exec spu_ItemBuy 'SangSang', '', 1200, 	'1.003',0,    -1		-- 커스터마이징(1200)
exec spu_ItemBuy 'SangSang', '', 5002, 	'', 	0,    -1		-- 팻(5002)
exec spu_ItemBuy 'SangSang', '', 6000, 	'', 	0,    -1		-- 배틀템(6000)
exec spu_ItemBuy 'SangSang', '', 6001, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6002, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6003, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6004, 	'', 	0,    -1

exec spu_ItemBuy 'SangSang', '', 101, 	'', 	0,    -1		-- 모자(102)
exec spu_ItemBuy 'SangSang', '', 202, 	'', 	0,    -1		-- 상의(202)
exec spu_ItemBuy 'SangSang', '', 301, 	'', 	0,    -1		-- 하의(302)
exec spu_ItemBuy 'SangSang', '', 401, 	'', 	0,    -1		-- 배트(402)
exec spu_ItemBuy 'SangSang', '', 501, 	'', 	0,    -1		-- 안경(502)
exec spu_ItemBuy 'SangSang', '', 601, 	'', 	0,    -1		-- 날개(602)
exec spu_ItemBuy 'SangSang', '', 701, 	'', 	0,    -1		-- 꼬리(702)
exec spu_ItemBuy 'SangSang', '', 801, 	'', 	0,    -1		-- 구장(802)
exec spu_ItemBuy 'SangSang', '', 1200, 	'1.003',0,    -1		-- 커스터마이징(1200)
exec spu_ItemBuy 'SangSang', '', 5001, 	'', 	0,    -1		-- 팻(5002)
exec spu_ItemBuy 'SangSang', '', 6000, 	'', 	0,    -1		-- 배틀템(6000)
exec spu_ItemBuy 'SangSang', '', 6001, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6002, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6003, 	'', 	0,    -1
exec spu_ItemBuy 'SangSang', '', 6004, 	'', 	0,    -1


--delete from dbo.tUserItem where gameid = 'guest74193' and itemcode in (101, 102, 103)
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						103, 	'', 	1,    -1	-- 렙제무시
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '6171581y8p3m1s151744',	101, 	'', 	1,    -1	-- 렙제무시
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						102, 	'', 	1,    -1	-- 렙제무시
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'
exec spu_ItemBuy 'guest74193', '',						104, 	'', 	0,    -1	-- 기존
select goldball, silverball from dbo.tUserMaster where gameid = 'guest74193'


*/


IF OBJECT_ID ( 'dbo.spu_ItemBuy', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemBuy;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemBuy
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					-- 지금은 사용안함(웹버젼에서는 사용)
	@itemcode_								int,							-- 아이템코드
	@customize_								varchar(128),					-- 커스터마이즈
	@lvignore_								int,							-- 렙제무시
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------	
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2			
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3
	
	-- 로그인 오류. 
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17			
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	                                                                                                         			
	-- 게임중에 부족.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--행동력이 부족하다.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--실버가 부족하다.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--코인잉 부족하다.

	-- 아이템 구매, 변경.                                                                                                   			
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--업그레이드를 할수 없다.						
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--업그레이드 실패.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--아이템이 만기 되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------	
	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 구매처코드
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- 시스템 체킹
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- 선물가져가기
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1
	
	-- 아이템파트이름
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- 판매템아님
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102

	-- 기타 정의값
	declare @ITEM_START_DAY						datetime		set @ITEM_START_DAY						= '2012-01-01'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'
	declare @ITEM_LV_IGNORE_NON					int				set @ITEM_LV_IGNORE_NON					= 0				-- 렙제있음
	declare @ITEM_LV_IGNORE_YES					int				set @ITEM_LV_IGNORE_YES					= 1				-- 렙제무시후 영구템


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid = @gameid_
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	BEGIN
		declare @goldball		int,			@silverball		int,	
				@ccharacter		int,			@face			int,		@cap				int, 
				@cupper			int,			@cunder			int,		@bat				int, 
				@glasses		int,			@wing			int,		@tail				int,
				@pet			int,
				@stadium		int,
				@customize 		varchar(128)
		declare @expirestate	int,			@expiredate		datetime
		declare @itemkind		int,			@goldballPrice	int,		@silverballPrice	int,
				@itemperiod		int,			@sale			int,
				@param1			varchar(20),	@param2			varchar(20),
				@param3			varchar(20),	@param4			varchar(20),
				@param5			varchar(20),	@param6			varchar(20),
				@param7			varchar(20),	@param8			varchar(20),
				@itemname		varchar(256)
		declare @itemcount		int	
		declare @itemcount1		int				set @itemcount1 = 0
		declare @itemcount2		int				set @itemcount2 = 0
		declare @itemcount3		int				set @itemcount3 = 0
		declare @itemcount4		int				set @itemcount4 = 0
		declare @itemcount5		int				set @itemcount5 = 0
		declare @expiredate2	datetime
		declare @expireend		datetime		set @expireend = @ITEM_START_DAY
		declare @lv					int,
				@goldballPriceLV	int,
				@itemcodeLV			int
		


		------------------------------------------------
		-- 유저(tUserMaster) > 보유 실버볼, 골든볼, 각파트정보
		-- select 'DEBUG (처음)', * from dbo.tUserMaster where gameid = @gameid
		------------------------------------------------
		-- select * from dbo.tUserMaster where gameid = 'SangSang'
		------------------------------------------------
		if(@password_ = '')
			begin
				-- 패스워드 없는 경우
				select	@goldball = goldball,		@silverball = silverball,
						@ccharacter = ccharacter,	@face = face,				@cap = cap,
						@cupper = cupper,			@cunder	= cunder,			@bat = bat,
						@glasses = glasses,			@wing = wing,				@tail = tail,
						@pet = pet,
						@stadium = stadium,
						@customize = customize
				from dbo.tUserMaster where gameid = @gameid
			end
		else
			begin
				-- 패스워드가 있는 경우
				select	@goldball = goldball,		@silverball = silverball,
						@ccharacter = ccharacter,	@face = face,				@cap = cap,
						@cupper = cupper,			@cunder	= cunder,			@bat = bat,
						@glasses = glasses,			@wing = wing,				@tail = tail,
						@pet = pet,
						@stadium = stadium,
						@customize = customize
				from dbo.tUserMaster where gameid = @gameid and password = @password_
			end
		
		
		
		
		------------------------------------------------
		-- 유저보유템(tUserItem) > 사용기간, 파기상태
		------------------------------------------------
		-- select * from dbo.tUserItem where gameid = 'SangSang' and itemcode = 0
		------------------------------------------------
		select  @expirestate = expirestate, @expiredate = expiredate
		from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		if(isnull(@expiredate, @ITEM_START_DAY) != @ITEM_START_DAY)
			begin
		 		set @expireend = @expiredate
		 	end
		
		
		------------------------------------------------
		-- 아이템(tItemInfo) > 종류, 가격, 영구템, 할인률(2000 -> 1600)
		-- 세일은 이미 적용된 상태이다.
		-- select * from dbo.tItemInfo where itemcode = 0
		------------------------------------------------
		select 
			@itemkind = kind, 			@itemcount = param1, 			@itemperiod = period,	
			@lv	= lv,
			@goldballPrice = goldball, 	@silverballPrice = silverball, 	
			@sale = sale,
			@itemname = itemname,
			@param1 = param1, 			@param2 = param2,				@param3 = param3,		
			@param4 = param4,			@param5 = param5, 				@param6 = param6,
			@param7 = param7,			@param8 = param8
		from dbo.tItemInfo where itemcode = @itemcode
		
		-- 세일을 적용하자.
		if(@sale > 0 and @sale <= 100)
			begin
				if(@goldballPrice > 0)
					begin
						set @goldballPrice = @goldballPrice * (100 - @sale) / 100
					end
				else if(@silverballPrice > 0)
					begin
						set @silverballPrice = @silverballPrice * (100 - @sale) / 100
					end
			end
			
		------------------------------------------------------------
		-- 렙제 무시 아이템을 적용 받을 경우
		-- 영구템을 기본으로 변경된다.
		-- > 실버가격은 무시한다.
		-- > 골드 가격은 누적된다.
		------------------------------------------------------------
		set @goldballPriceLV = 0
		if(@lvignore_ = @ITEM_LV_IGNORE_YES)
			begin
				set @itemperiod = @ITEM_PERIOD_PERMANENT
				set @silverballPrice = 0			
				if(@lv < 10)
					begin
						set @goldballPriceLV 	= 20
						set @itemcodeLV			= 7005
					end
				else if(@lv < 20)
					begin
						set @goldballPriceLV 	= 30
						set @itemcodeLV			= 7006
					end
				else if(@lv < 35)
					begin
						set @goldballPriceLV 	= 50
						set @itemcodeLV			= 7007
					end
				else
					begin
						set @goldballPriceLV 	= 99
						set @itemcodeLV			= 7008
					end
			end
		else
			begin
				set @lvignore_ = @ITEM_LV_IGNORE_NON
			end
		

		--select 'DEBUG ',
		--	@goldball as 'gb', 				@silverball as 'sb', 			
		--	@ccharacter as 'cchar', 		@face as 'face',				@cap as 'cap',
		--	@cupper as 'cupper',			@cunder	as 'cunder',			@bat as 'bat',
		--	@glasses as 'glasses',			@wing as 'wing',				@tail as 'tail',
		--	@pet as 'pet', 					@stadium as 'stadium',
		--	@expirestate as '만기', 		@expiredate as '만기일',
		--	@itemkind as '템종류', 			@goldballPrice as 'gbP', 		@silverballPrice as 'sbP',
		--	@itemperiod as 'period',
		--	@param1 as 'param1', 	 		@param2 as 'param2', 			@param3 as 'param3', 
		--	@param4 as 'param4', 			@param5 as 'param5',  			@param6 as 'param6', 
		--	@param7 as 'param7', 			@param8 as 'param8',
		--	@itemname as 'itemname'
		

		if isnull(@itemkind, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				set @comment = 'ERROR 아이템이 존재 안함'
			END
		else if @itemkind in (@ITEM_KIND_FACE)
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOSALE_KIND
				set @comment = 'ERROR Face는 별도로 구매할수 없음'
			END
		else if @itemkind not in (@ITEM_KIND_CHARACTER, @ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET, @ITEM_KIND_BATTLEITEM, @ITEM_KIND_CUSTOMIZE)
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOSALE_KIND
				set @comment = 'ERROR 현재판매하지 않는 아이템 kind:' + str(@itemkind)
			END
		else if (@silverballPrice > 0 and @silverballPrice > @silverball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
				set @comment = 'ERROR 실버볼부족 보유실버:' + ltrim(str(@silverball)) + ' 판매가:' + ltrim(str(@silverballPrice))
			END
		else if (@goldballPrice > 0 and @goldballPrice > @goldball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
				set @comment = 'ERROR 골든볼부족 보유골드:' + ltrim(str(@goldball)) + ' 판매가:' + ltrim(str(@goldballPrice))
			END
		else if (@goldballPriceLV > 0 and (@goldballPrice + @goldballPriceLV) > @goldball)
			BEGIN
				set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
				set @comment = 'ERROR 골든볼부족 보유골드:' + ltrim(str(@goldball)) + ' 렙무시판매가:' + ltrim(str(@goldballPriceLV))
			END
		else if (@itemperiod = @ITEM_PERIOD_PERMANENT and isnull(@expirestate, -444) != -444)
			BEGIN
				-- 무제한템 and 템이 존재
				set @nResult_ = @RESULT_ERROR_ITEM_PERMANENT_ALREADY
				set @comment = 'ERROR 영구템으로 보유중'
			END
		else if (@silverballPrice <= 0 and @goldballPrice <= 0 and @goldballPriceLV <= 0)
			BEGIN
				set @nResult_ = @RESULT_ERROR
				set @comment = 'ERROR 판매가격 골드와 실버가 0은 판매불가입니다.(관리자문의)'
			END
		else 	
			BEGIN
				------------------------------------------------------
				--	가격을 확인해서 차감해두기
				------------------------------------------------------
				set @nResult_ = @RESULT_SUCCESS	
				--select 'DEBUG 전', @silverball as 'silverball', @silverballPrice as 'sbp', @goldball as 'goldball', @goldballPrice as 'gbp'
				if (@silverballPrice > 0)
					begin
						set @silverball = @silverball - @silverballPrice
					end
				if (@goldballPrice > 0)
					begin
						set @goldball = @goldball - @goldballPrice
					end	
				if (@goldballPriceLV > 0)
					begin
						set @goldball = @goldball - @goldballPriceLV
					end	
					
				--select 'DEBUG 후', @silverball as 'silverball', @silverballPrice as 'sbp', @goldball as 'goldball', @goldballPrice as 'gbp'				
				
				
				-------------------------------------------------------
				-- 아이템이 소모성인가?
				-- 6000 ~ 6004(소모성)
				-- 201(착용:7:기존), 5000(늑대팻:-1:기존)				
				-- declare @itemcode int	set @itemcode = 201	declare @gameid varchar(20)		set @gameid='SangSang'			
				-------------------------------------------------------
				if(@itemkind = @ITEM_KIND_CHARACTER)
					begin
						set @comment = 'SUCCESS 캐릭터 정상구매'
						-- 하단에서 캐릭터 파트부위 정보변경					
						set @ccharacter = @itemcode
						set @face = @param1
						set @cap = @param2
						set @cupper = @param3
						set @cunder = @param4
						--set @glasses = -1	 	2012-09-13일날 모든 파트 그대로 유지
						--set @wing = -1		2012-09-13일날 모든 파트 그대로 유지
						--set @tail = -1		2012-09-13일날 모든 파트 그대로 유지
						--set @pet = -1			
						
						
						------------------------------------------------
						-- 가입시 커스터 마이징 정보를 입력한다.							
						------------------------------------------------
						insert into dbo.tUserCustomize(gameid, itemcode, customize)
						values(@gameid_, @ccharacter, @ITEM_CHAR_CUSTOMIZE_INIT)
						
						
						--select 'DEBUG 아이템 유저 테이블에 각 파트별 아이템 입력'
						-- 캐릭터 파트별 지급하기, 장착
						set @expiredate2 = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
						set @expireend = @expiredate2
						
						insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @ccharacter, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @face, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cap, @expiredate2, @lvignore_)
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cupper, @expiredate2, @lvignore_)						
						
						insert into tUserItem(gameid, itemcode, expiredate, lvignore)
						values(@gameid, @cunder, @expiredate2, @lvignore_)
						
						--insert into tUserItem(gameid, itemcode, expiredate)
						--values(@gameid, @bat, @expiredate2)						
						--insert into tUserItem(gameid, itemcode, expiredate)
						--values(@gameid, @stadium, @expiredate2)
						
						-- 하단에서 구매로그 기록

					end
				else if(@itemkind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
					begin
						
						if(@itemkind = @ITEM_KIND_CAP)
							begin
								set @comment = 'SUCCESS 모자 구매'
								set @cap = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_UPPER)
							begin
								set @comment = 'SUCCESS 상의 구매'
								set @cupper = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_UNDER)
							begin
								set @comment = 'SUCCESS 하의 구매'
								set @cunder = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_BAT)
							begin
								set @comment = 'SUCCESS 배트 구매'
								set @bat = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_GLASSES)
							begin
								set @comment = 'SUCCESS 안경 구매'
								set @glasses = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_WING)
							begin
								set @comment = 'SUCCESS 날개 구매'
								set @wing = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_TAIL)
							begin
								set @comment = 'SUCCESS 꼬리 구매'
								set @tail = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_STADIUM)
							begin
								set @comment = 'SUCCESS 스타듐 구매'
								set @stadium = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_PET)
							begin
								set @comment = 'SUCCESS 펫 구매'
								set @pet = @itemcode
							end
						
						
						-- 유저아이템 테이블에 아이템 존재유무 파악
						--select 'DEBUG 착용'
						if(isnull(@expirestate, -444) = -444)
							begin
								set @comment = @comment + '(신규구매)'
								--select 'DEBUG 신규입력'
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select 'DEBUG 신규기간(dd):' + str(@itemperiod)
										set @expireend = DATEADD(dd, @itemperiod, getdate())
										insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
										values(@gameid, @itemcode, @expireend, @lvignore_)
									end
								else
									begin
										--select 'DEBUG 신규영구(yy):' + str(@itemperiod)
										set @expireend = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, lvignore)
										values(@gameid, @itemcode, @expireend, @lvignore_)
									end
							end
						else
							begin
								set @comment = @comment + '(기간연장)'
								--select 'DEBUG 템존재 > 날짜업그레이드'
								--select 'DEBUG 전', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG 템존재 > 날짜업기간(dd):' + str(@itemperiod)
										DECLARE @tItemExpire TABLE(
											expiredate datetime
										);
										
										update dbo.tUserItem
										set
											lvignore	= case when (@lvignore_ = @ITEM_LV_IGNORE_YES) then @ITEM_LV_IGNORE_YES else @ITEM_LV_IGNORE_NON end,
											expirestate = 0,											
											expiredate 	= case 
															when getdate() > expiredate then DATEADD(dd, @itemperiod, getdate())
															else DATEADD(dd, @itemperiod, expiredate)
														end
											OUTPUT INSERTED.expiredate into @tItemExpire
										where gameid = @gameid and itemcode = @itemcode	
										
										select @expireend = expiredate from @tItemExpire
									end
								--else
								--	begin
								--		--select '  > DEBUG 템존재 > 날짜업기간(yy):' + str(@itemperiod) + ' > 의미없어 패스'
								--		-- 의미가 없어서 패스
								--	end
								--select 'DEBUG 후', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
							end	
					end
				else if(@itemkind = @ITEM_KIND_BATTLEITEM)
					begin
						set @comment = 'SUCCESS 배틀 소모성 아이템 정상지급'
						
						-- declare @itemcode int set @itemcode = 6000
						if(@itemcode = 6000)
							begin
								set @itemcount1 = @itemcount
							end
						else if(@itemcode = 6001)
							begin
								set @itemcount2 = @itemcount
							end
						else if(@itemcode = 6002)
							begin
								set @itemcount3 = @itemcount
							end
						else if(@itemcode = 6003)
							begin
								set @itemcount4 = @itemcount
							end
						else if(@itemcode = 6004)
							begin
								set @itemcount5 = @itemcount
							end			

					end
				else if(@itemkind = @ITEM_KIND_CUSTOMIZE)
					begin
						set @comment = 'SUCCESS 커스터마이징를 변경했습니다.'
						set @customize = @customize_

						------------------------------------------------
						-- 가입시 커스터 마이징 정보를 변경						
						------------------------------------------------						
						update dbo.tUserCustomize
							set
								customize = @customize_
						where gameid = @gameid and itemcode = @ccharacter
					end
				else 
					begin
						set @nResult_ = @RESULT_ERROR
						set @comment = 'ERROR 아이템구매 알수없는 오류'
					end
			END
	END
	
	
	
	---------------------------------------
	-- 구매 성공시 가격 반영
	---------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @expireend expireend
			
			---------------------------------------------------------
			-- 유저정보기록
			---------------------------------------------------------
			--select 'DEBUG (전)', @goldball 'goldball', @silverball 'silverball', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium',  @itemcount1 'itemcount1', @itemcount2 'itemcount2', @itemcount3 'itemcount3', @itemcount4 'itemcount4', @itemcount5 'itemcount5'
			
			update dbo.tUserMaster
			set
				goldball 	= @goldball,	silverball 	= @silverball,
				ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
				pet 		= @pet,			
				stadium		= @stadium,
				customize	= @customize,
				bttem1cnt = bttem1cnt + @itemcount1,
				bttem2cnt = bttem2cnt + @itemcount2,
				bttem3cnt = bttem3cnt + @itemcount3,
				bttem4cnt = bttem4cnt + @itemcount4,
				bttem5cnt = bttem5cnt + @itemcount5
			where gameid = @gameid
			--select 'DEBUG (후)', goldball, silverball, ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, pet, stadium,  bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- 구매로그 기록
			---------------------------------------------------------
			--insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) values('SangSang45', 1, 0, 91)
			--select 'DEBUG 구매로그 기록'
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldballPrice, @silverballPrice) 
			
			
			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball 	= goldball + @goldballPrice + @goldballPriceLV, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice + @goldballPriceLV, @silverballPrice, 1)
				end
				
			---------------------------------------------------
			-- 토탈로그 기록하기2 Master
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyLogTotalMaster where dateid = @dateid))
				begin
					update dbo.tItemBuyLogTotalMaster 
						set 
							goldball 	= goldball + @goldballPrice + @goldballPriceLV, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalMaster(dateid, goldball, silverball, cnt)
					values(@dateid, @goldballPrice + @goldballPriceLV, @silverballPrice, 1)
				end
				
				
			---------------------------------------------------------
			-- 렙제무시 구매로그 기록
			---------------------------------------------------------
			if(@lvignore_ = @ITEM_LV_IGNORE_YES)
				begin
					insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
					values(@gameid, @itemcodeLV, @goldballPriceLV, 0) 
										
					---------------------------------------------------------
					-- 렙제무시 > 프로모션에 기록하기
					---------------------------------------------------------
					if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcodeLV))
						begin
							update dbo.tItemBuyPromotionTotal 
								set 
									goldball = goldball + @goldballPriceLV,
									cnt = cnt + 1
							where dateid = @dateid and itemcode = @itemcodeLV
						end
					else
						begin
							insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
							values(@dateid, @itemcodeLV, @goldballPriceLV, 1)
						end
					
				end

		end
	else
		begin
			select @nResult_ rtn, @comment, @expireend expireend
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select * from dbo.tUserMaster where gameid = @gameid
			--select 'DEBUG (완료)', * from dbo.tUserMaster where gameid = @gameid
		end
	set nocount off
End

