---------------------------------------------------------------
/*
gameid=xxx
itemcode=xxx

update dbo.tUserItem 
	set 
		expirestate = 0 , expiredate = '2012-12-31 01:05:00', 
		upgradestate = 0, upgradecost = 0 
	where gameid = 'SangSang' and itemcode in (103, 101, 102, 100, 200, 300, 400, 5001)
update dbo.tUserItem set expiredate = '2013-01-01 01:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (200)
update dbo.tUserMaster set silverball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set silverball = 1000000 where gameid = 'SangSang'
update dbo.tUserMaster set silverball = 1000000 where gameid = 'DD99'
exec spu_ItemUpgrade 'SangSang', 0, 	1, 	'',		-1		-- 미존재템		> 오류
exec spu_ItemUpgrade 'SangSang', 54, 	1,	'',		-1		-- 미존재템		> 오류
exec spu_ItemUpgrade 'SangSang', 50, 	1,	'',		-1		-- 얼굴변경 	> 오류

exec spu_ItemUpgrade 'SangSang', 200, 	2,	'',		-1		-- 상의(201)
exec spu_ItemUpgrade 'SangSang', 201, 	2,	'',		-1		-- 상의(201)
exec spu_ItemUpgrade 'SangSang', 300, 	2,	'', 	-1		-- 하의(301)
exec spu_ItemUpgrade 'SangSang', 400, 	2,	'', 	-1		-- 배트(401)	
exec spu_ItemUpgrade 'SangSang', 500, 	2,	'', 	-1		-- 안경(501) 	> 오류(강화안됨)
exec spu_ItemUpgrade 'SangSang', 600, 	2,	'', 	-1		-- 날개(601) 	> 오류(강화안됨)
exec spu_ItemUpgrade 'SangSang', 700, 	2,	'', 	-1		-- 꼬리(701) 	> 오류(강화안됨)
exec spu_ItemUpgrade 'SangSang', 800, 	2,	'', 	-1		-- 구장(801) 	> 오류(강화안됨)

exec spu_ItemUpgrade 'SangSang', 5002, 	5,	'DD23', -1		-- 팻(5001) 	> 교배
exec spu_ItemUpgrade 'SangSang', 5001, 	5,	'DD1', 	-1		-- 팻(5001) 	> 교배
exec spu_ItemUpgrade 'SangSang', 5000, 	5,	'DD1', 	-1		-- 팻(5001) 	> 교배
exec spu_ItemUpgrade 'SangSang', 5000, 	5,	'Superman', 	-1		-- 팻(5001) 	> 교배
select * from dbo.tGiftList where gameid = 'Superman' order by idx desc
--select gameid, goldball, silverball from dbo.tUserMaster where gameid in ('SangSang', 'DD1')

exec spu_ItemUpgrade 'superbin', 200, 	2,	'',		-1		-- 상의(201)
update dbo.tUserItem set upgradestate = 10 where gameid = 'superbin' and itemcode = 200
update dbo.tUserMaster set silverball = 629 where gameid = 'superbin'
*/

IF OBJECT_ID ( 'dbo.spu_ItemUpgrade', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemUpgrade;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemUpgrade
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@itemcode_								int,							-- 아이템코드
	@branch_								int,							-- 강화종류(은, 펫)
	@mpetid_								varchar(20),
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
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--자체변경불가템
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int 			set @RESULT_ERROR_UPGRADE_NOBRANCH 		= -60			-- 비지정된 브렌치문.
	declare @RESULT_ERROR_NOT_WEAR				int 			set @RESULT_ERROR_NOT_WEAR 				= -61			-- 미장착된 상태 
	declare @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	int				set @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	= -62			--해제불가부위입니다.


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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE				= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	
	-- 기타 정의값
	declare @ITEM_START_DAY						datetime		set @ITEM_START_DAY						= '2012-01-01'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	declare @SENDER								varchar(20)		set @SENDER								= '교배보상'
	
	
	-- 게임플레이 상태정보
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	
	-- 아이템 분류
	declare @ITEM_UPGRADE_BRANCH_SILVER 		int 			set @ITEM_UPGRADE_BRANCH_SILVER			= 2				-- > 은강화
	declare @ITEM_UPGRADE_BRANCH_PET			int 			set @ITEM_UPGRADE_BRANCH_PET			= 5				-- > 펫강화
	

	-- upgrade state
	declare @ITEM_UPGRADE_SUCCESS				int 			set @ITEM_UPGRADE_SUCCESS				= 1
	declare @ITEM_UPGRADE_FAIL					int 			set @ITEM_UPGRADE_FAIL					= 0

	declare @PET_UPGRADE_B_CLASS				int				set @PET_UPGRADE_B_CLASS				= 2000
	declare @PET_UPGRADE_A_CLASS				int				set @PET_UPGRADE_A_CLASS				= 6000
	
	--declare @PATCH_NOT_END_DATE					datetime		set @PATCH_NOT_END_DATE				= '2013-02-15'	-- 1.30일까지
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)
	declare @commentpet		varchar(80)
	
	declare @upgraderesult	int 			set @upgraderesult = @ITEM_UPGRADE_FAIL
	
	-- 퀘스트용 데이타.
	declare @itemupgradebest				int,
			@itemupgradecnt					int,
			
			@petmatingbest					int,
			@petmatingcnt					int
Begin		
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 아이템을 강화할 수 없습니다.(-1)'
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	declare @ccharacter		int,			@face			int,		@cap				int, 
			@cupper			int,			@cunder			int,		@bat				int, 
			@glasses		int,			@wing			int,		@tail				int,
			@pet			int,
			@stadium		int,
			@goldball		int,			@silverball		int,
			@goldball2		int,			@silverball2	int,
			@silverballpetmy	int,		@silverballpetother	int			--내것과 상대방
	declare @expirestate	int,			@expiredate		datetime,	@upgradestate		int,
			@upgradecost	int,			@lvignore		int			
	declare @itemkind		int,			
			@itemperiod		int,
			@param1			varchar(20),	@param2			varchar(20),
			@param3			varchar(20),	@param4			varchar(20),
			@param5			varchar(20),	@param6			varchar(20),
			@param7			varchar(20),	@param8			varchar(20),
			@itemname 		varchar(256)
	declare @restorechar int
	declare @restorepart int
	set @upgradestate = 0
	set @silverballpetmy = 0
	set @silverballpetother = 0
	--set @upgradecost = 0
	declare @expireend			datetime		set @expireend 			= @ITEM_START_DAY
	declare @petkindmy			int				set @petkindmy			= 1
	declare @petgrademy			int				set @petgrademy			= 1
	declare @petraremy			int				set @petraremy			= 1
	--declare @petreitmy		int				set @petreitmy			= 8000
	declare @petkindother		int				set @petkindother		= 1
	declare @petgradeother		int				set @petgradeother		= 1
	declare @petrareother		int				set @petrareother		= 1
	declare @petreitother		int				set @petreitother		= 8000
	
	declare @rand				int				set @rand 				= 0
	declare @newpet				int 			set @newpet				= -1
	declare @newpetperiod		int 			set @newpetperiod		= 0
	declare @newpetname			varchar(80)
	declare @upgradebase		int				set @upgradebase		= 80
	declare @upgradeitemlv		int 			set @upgradeitemlv		= 1
	declare @itemlv				int 			set @itemlv				= 1
	declare @upgradeitemkind	int 			set @upgradeitemkind	= 80

	declare @petitemupgradebase 	int,
			@petitemupgradestep 	int,
			@normalitemupgradebase 	int,
			@normalitemupgradestep 	int,
			@permanentstep			int
	


	------------------------------------------------
	-- 유저(tUserMaster) > 각파트정보
	--select 'DEBUG 유저정보', * from dbo.tUserMaster where gameid = @gameid
	------------------------------------------------
	select	
			@gameid = gameid,
			@ccharacter = ccharacter,	@face = face,				@cap = cap,
			@cupper = cupper,			@cunder	= cunder,			@bat = bat,
			@glasses = glasses,			@wing = wing,				@tail = tail,
			@pet = pet,
			@stadium = stadium,
			@goldball = goldball,		@silverball = silverball,
			@goldball2 = goldball,		@silverball2 = silverball,	
			@itemupgradebest = itemupgradebest,	@itemupgradecnt = itemupgradecnt,
			@petmatingbest = petmatingbest,		@petmatingcnt = petmatingcnt
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	 
	
	------------------------------------------------
	-- 유저보유템(tUserItem) > 사용기간, 파기상태
	--select 'DEBUG 보유유무', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
	------------------------------------------------
	select @expirestate = expirestate, @expiredate = expiredate, @upgradestate = upgradestate, @upgradecost = upgradecost, @lvignore = lvignore
	from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
	--select 'DEBUG ', case when @expiredate > '2020-01-01' then '영구템' else '기간템' end
	if(isnull(@expiredate, @ITEM_START_DAY) != @ITEM_START_DAY)
		begin
	 		set @expireend = @expiredate
	 	end
	
	
	------------------------------------------------
	-- 아이템(tItemInfo) > 종류
	-- --select 'DEBUG 아이템', * from dbo.tItemInfo where itemcode = @itemcode
	------------------------------------------------
	select 
		@itemkind = kind, 		@itemperiod = period,	
		@param1 = param1, 		@param2 = param2,			@param3 = param3,		
		@param4 = param4,		@param5 = param5, 			@param6 = param6,
		@param7 = param7,		@param8 = param8,
		@itemname = itemname,
		@upgradeitemlv = lv,
		@itemlv = lv,
		@upgradeitemkind = kind
	from dbo.tItemInfo where itemcode = @itemcode

	--select 'DEBUG ',
	--	@ccharacter as 'cchar', 		@face as 'face',				@cap as 'cap',
	--	@cupper as 'cupper',			@cunder	as 'cunder',			@bat as 'bat',
	--	@glasses as 'glasses',			@wing as 'wing',				@tail as 'tail',
	--	@pet as 'pet', 					@stadium as 'stadium',
	--	@expirestate as '만기상태', 		@expiredate as '만기일',
	--	@itemkind as '템종류', 			
	--	@itemperiod as 'period',
	--	@param1 as 'param1', 	 		@param2 as 'param2', 			@param3 as 'param3', 
	--	@param4 as 'param4', 			@param5 as 'param5',  			@param6 as 'param6', 
	--	@param7 as 'param7', 			@param8 as 'param8'
	
	------------------------------------------------
	-- 각 조건별 분기
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 존재하지 않는 아이디 입니다.'
		END
	else if isnull(@itemkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템 자체가 존재하지 않습니다. 확인바랍니다.'
		END
	else if (@itemkind not in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_PET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_CANNT
			set @comment = 'ERROR 강화불가템 부위입니다.' + str(@itemkind)
		END
	else if (@branch_ not in (@ITEM_UPGRADE_BRANCH_SILVER, @ITEM_UPGRADE_BRANCH_PET))
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_NOBRANCH
			set @comment = 'ERROR 강화 분류가 이상합니다.(은강, 펫강만됩니다.)'
		END
	else if (isnull(@expirestate, -444) = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_HAVE
			set @comment = 'ERROR 보유하고 있지 않습니다.'
		END
	else if (@expirestate = @ITEM_EXPIRE_STATE_YES)	
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_EXPIRE
			set @comment = 'ERROR 템이 만기되었습니다.'
		END
	else if (@expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > @expiredate)	
		begin
			set @nResult_ = @RESULT_ERROR_ITEM_EXPIRE
			set @comment = 'ERROR 아이템이 만기되었습니다.'
		
			--유저각파트원복 > 젤하단에서 처리한다.
			--declare @restorepart int declare @param8 varchar(20) set @param8 = 1
			set @restorechar = cast(@param7	as int)
			set @restorepart = cast(@param8	as int)			
			
			
			if(@restorechar = -1)		
				begin
					---------------------------------------------
					--	만기 > 종속관계 없이(-1) > 파트별 > 착용중
					---------------------------------------------						
					if(@itemkind = @ITEM_KIND_CHARACTER and @ccharacter = @itemcode)
						begin
							----select 'DEBUG 캐릭원복(비종속)'
							set @ccharacter = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_CAP and @cap = @itemcode)
						begin
							--select 'DEBUG 착용템 CAP(비종속)'
							set @cap = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UPPER and @cupper = @itemcode)
						begin
							--select 'DEBUG UPPER(비종속)'
							set @cupper = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UNDER and @cunder = @itemcode)
						begin
							--select 'DEBUG UNDER(비종속)'
							set @cunder = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_BAT and @bat = @itemcode)
						begin
							--select 'DEBUG BAT(비종속)'
							set @bat = @restorepart
						end	
					else if(@itemkind = @ITEM_KIND_GLASSES and @glasses = @itemcode)
						begin
							--select 'DEBUG GLASSES(비종속)'
							set @glasses = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_WING and @wing = @itemcode)
						begin
							--select 'DEBUG _WING(비종속)'
							set @wing = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_TAIL and @tail = @itemcode)
						begin
							--select 'DEBUG TAIL(비종속)'
							set @tail = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_STADIUM and @stadium = @itemcode)
						begin
							--select 'DEBUG STADIUM(비종속)'
							set @stadium = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_PET and @pet = @itemcode)
						begin
							--select 'DEBUG PET(비종속)'
							set @pet = @restorepart
						end
				end
			else if(@restorechar = @ccharacter)
				begin						
					-----------------------------------
					-- 만기 > 종속(-1) > 파트별 > 착용중
					--	착용중인 기본캐릭과 만기파트템의 기본이 같으면 초기화
					-----------------------------------
					if(@itemkind = @ITEM_KIND_CHARACTER and @ccharacter = @itemcode)
						begin
							--select 'DEBUG 캐릭원복(종속)'
							set @ccharacter = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_CAP and @cap = @itemcode)
						begin
							--select 'DEBUG 착용템 CAP(종속)'
							set @cap = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UPPER and @cupper = @itemcode)
						begin
							--select 'DEBUG UPPER(종속)'
							set @cupper = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_UNDER and @cunder = @itemcode)
						begin
							--select 'DEBUG UNDER(종속)'
							set @cunder = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_BAT and @bat = @itemcode)
						begin
							--select 'DEBUG BAT(종속)'
							set @bat = @restorepart
						end	
					else if(@itemkind = @ITEM_KIND_GLASSES and @glasses = @itemcode)
						begin
							--select 'DEBUG GLASSES(종속)'
							set @glasses = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_WING and @wing = @itemcode)
						begin
							--select 'DEBUG _WING(종속)'
							set @wing = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_TAIL and @tail = @itemcode)
						begin
							--select 'DEBUG TAIL(종속)'
							set @tail = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_STADIUM and @stadium = @itemcode)
						begin
							--select 'DEBUG STADIUM(종속)'
							set @stadium = @restorepart
						end
					else if(@itemkind = @ITEM_KIND_PET and @pet = @itemcode)
						begin
							--select 'DEBUG PET(종속)'
							set @pet = @restorepart
						end
				end
			-------------------------------------------------
			--	아이템보유를 Expire처리 > expirestate = 1
			-------------------------------------------------
			--select top 20 * from  where gameid = 'SangSang' order by idx desc
			--select 'DEBUG 보유템 만기처리'
			update dbo.tUserItem  set  expirestate = @ITEM_EXPIRE_STATE_YES
			where gameid = @gameid and itemcode = @itemcode

			-------------------------------------------------
			--	로그에 만기처리 기록하기
			-------------------------------------------------
			--select 'DEBUG 만기처리 로그기록하기'
			insert into tMessage(gameid, comment) 
			values(@gameid_,  @itemname + '가 만기가 되었습니다.') 
			
			-------------------------------------------------
			--	아이템 부위 처리하기
			------------------------------------------------- 
			update dbo.tUserMaster
			set
				ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
				pet 		= @pet,			
				stadium		= @stadium
			where gameid = @gameid

		end
	else 	
		BEGIN
			set @nResult_ = @RESULT_SUCCESS	
			
			-------------------------------------------------
			--	아이템 강화파라미터
			-------------------------------------------------
			select top 1 
				@petitemupgradebase 	= petitemupgradebase,
				@petitemupgradestep 	= petitemupgradestep,
				@normalitemupgradebase 	= normalitemupgradebase,
				@normalitemupgradestep 	= normalitemupgradestep,
				@permanentstep			= permanentstep
			from dbo.tItemUpgradeInfo where flag = 1 order by idx desc
			
			-------------------------------------------------
			--	아이템별 > 사용금액 누적 > 1만원당 3% 올려주기 
			-------------------------------------------------
			--select 'DEBUG ', @upgradecost 'upgradecost', ((@upgradecost / 10000) * 3) 'addpercent'
			set @upgradeitemlv = case when @upgradeitemlv < 0 then 0 else @upgradeitemlv end			
			if(@upgradeitemkind = @ITEM_KIND_PET)
				begin
					-- 펫
					-- 50 + (_itemLV) * 30
					-- 00      : 50
					-- 01      : 80
					-- 02      : 110
					set @upgradebase = @petitemupgradebase + (@upgradeitemlv ) * @petitemupgradestep
					
					--select 'DEBUG 펫', @upgradebase
				end
			else
				begin
					-- 일반템
					-- 50 + (_itemlv / 5) * 10  
					-- 01 ~ 04 : 50	<=
					-- 05 ~ 09 : 60	<=
					-- 10 ~ 14 : 70
					-- 15 ~ 19 : 80	<=
					-- 20 ~ 24 : 90
					-- 25 ~ 29 : 100
					-- 30 ~ 34 : 110
					-- 35 ~ 39 : 120 <=
					-- 40 ~ 44 : 130
					-- 45 ~ 49 : 140
					-- 50 ~ 50 : 150
					set @upgradebase = @normalitemupgradebase + (@upgradeitemlv / 5) * @normalitemupgradestep
					
					--select 'DEBUG 아이템', @upgradebase
				end
			
			
			
			
			--select 'DEBUG ', @upgradestate 
			if(@branch_ = @ITEM_UPGRADE_BRANCH_SILVER)
				begin
					-------------------------------------------------------
					-- 	강화 성공, 실패
					-------------------------------------------------------
					--select 'DEBUG ', @upgradecost 'upgradecost', ((@upgradecost / 10000) * 3) 'addpercent'
					set @rand = Convert(int, ceiling(RAND() *  100))
					set @rand = @rand - ((@upgradecost / 10000) * 2)
					if(@upgradestate < 10)
						begin
							set @upgraderesult = @ITEM_UPGRADE_SUCCESS
						end
					else if(@lvignore = 1 or @itemlv < 10)
						begin
							-- 유료 구매자, 렙이 낮은 템
							set @upgraderesult = @ITEM_UPGRADE_SUCCESS
						end
					else if(@upgradestate < 20)
						begin
							if(@rand < 95)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 30)
						begin
							if(@rand < 90)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 40)
						begin
							if(@rand < 85)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 50)
						begin
							if(@rand < 80)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else if(@upgradestate < 60)
						begin
							if(@rand < 75)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
					else 
						begin
							if(@rand < 70)
								begin
									set @upgraderesult = @ITEM_UPGRADE_SUCCESS
								end
							else
								begin
									set @upgraderesult = @ITEM_UPGRADE_FAIL
								end
						end
				
					
					-------------------------------------------------------
					-- 	은강화확률
					-------------------------------------------------------			
					--select 'DEBUG 41'
					--아이템 강화 적용단계에 의해서 실패적용		
					set @comment = 'SUCCESS 은강화확률'
					set @silverball = @silverball - (@upgradestate + 1) * @upgradebase
					
					--퀘스트용
					set @itemupgradebest = case when (@upgradestate + 1) > @itemupgradebest then (@upgradestate + 1)
												else @itemupgradebest end
					set @itemupgradecnt = @itemupgradecnt + 1 
				end			
			else if(@branch_ in (@ITEM_UPGRADE_BRANCH_PET))
				begin
					-------------------------------------------------------
					-- 	펫교배화확률
					-------------------------------------------------------
					set @comment = 'SUCCESS 펫교배확률'
					--select 'DEBUG 51'
					set @upgraderesult = @ITEM_UPGRADE_SUCCESS
					set @silverball = @silverball - (@upgradestate + 1) * @upgradebase
					
					
					set @petmatingbest = case 
												when (@upgradestate + 1) > @petmatingbest then (@upgradestate + 1)
												else @petmatingbest end
					set @petmatingcnt = @petmatingcnt + 1 				
					
					-------------------------------------------------------
					-- 교배신청자
					-------------------------------------------------------
					set @petkindmy 			= convert(int, @param3)
					set @petgrademy 		= convert(int, @param4)
					set @petraremy 			= convert(int, @param5)
					--set @petreitmy 		= convert(int, @param6)
		
					-------------------------------------------------------
					-- 상대신청자
					-------------------------------------------------------
					select 
						@petkindother 		= param3,		
						@petgradeother 		= param4,		
						@petrareother 		= param5, 			
						@petreitother 		= param6
					from dbo.tItemInfo 
					where itemcode = (select pet from dbo.tUserMaster where gameid = @mpetid_)
					
					-- 없으면 최소 20실버가 들어옴
					set @silverballpetmy = 0
					set @silverballpetother = 0
					
					-------------------------------------------------------
					-- 내펫 + 상대펫 > 레어펫만들기
					-- petgrade 1:B, 2:A, 3:S
					-------------------------------------------------------
					if(@petgrademy in (1, 2))
						begin
							declare @val int
							declare @class int
							if(@petgrademy = 1)
								begin
									set @class = @PET_UPGRADE_B_CLASS
								end
							else
								begin
									set @class = @PET_UPGRADE_A_CLASS
								end

							set @val = @upgradestate + @petraremy + @petrareother
							set @rand = Convert(int, ceiling(RAND() * @class) - 1 + 100)	-- 기본 100 이상에서만 나오도록 한다.
							--select 'DEBUG ', @rand, @val
							
							if(@rand < @val)
								begin
									---------------------------
									-- 레어펫
									---------------------------
									select 
										@newpet 		= itemcode,
										@newpetperiod 	= period,
										@newpetname 	= itemname
									from dbo.tItemInfo 
									where kind = @ITEM_KIND_PET and param3 = @petkindmy and param4 = @petgrademy + 1
									--select 'DEBUG 레어펫 나옴'
									

									-- 레어펫이 있으면 취소한다.
									if exists(select * from dbo.tUserItem where gameid = @gameid and itemcode = @newpet)
										begin
											--select 'DEBUG 레어펫 나왔는데 보유했네'
											set @newpet = -1
										end
									
								end
						end
				end		
		END

		
	--select 'DEBUG ', @upgradestate  'upgradestate', @upgraderesult 'upgraderesult', @silverball 'silverball', @goldball 'goldball'		
	---------------------------------------------------------
	-- 골드와 실버가 부족할 경우 정리
	---------------------------------------------------------
	if(@goldball < 0)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR 골드가 부족합니다.'
		end
	else if(@silverball < 0)
		begin
			set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
			set @comment = 'ERROR 실버가 부족합니다.'
		end
	else
		begin
			---------------------------------------------------------
			-- 강화정보정리 > 강화 결과로 정리
			---------------------------------------------------------
			if(@upgraderesult = @ITEM_UPGRADE_SUCCESS)
				begin
					set @upgradestate = @upgradestate + 1
				end
			else
				begin
					-- 떨어지는 것은 방지하고
					--set @upgradestate = @upgradestate - 1
					set @upgradestate = @upgradestate
				end
				
			if(@upgradestate < 0)
				set @upgradestate = 0
				
			---------------------------------------------------------
			-- 펫강화 > 신청자, 등록자
			---------------------------------------------------------
			--if(@branch_ = @ITEM_UPGRADE_BRANCH_PET)
			--	begin
			--		if(@upgraderesult = @ITEM_UPGRADE_SUCCESS)
			--			begin
			--				set @silverballpetmy = 0
			--				set @silverballpetother = 50
			--			end
			--		else
			--			begin
			--				set @silverballpetmy = 100
			--				set @silverballpetother = 25
			--			end
			--	end
				
				
			---------------------------------------------------------
			-- 사용금액 = 골든볼 * 200, 실버볼
			---------------------------------------------------------
			--select 'DEBUG (전)', @upgradecost 'upgradecost', @goldball2 'goldball2', @goldball 'goldball', @silverball2 'silverball2', @silverball 'silverball'
			set @goldball2 = @goldball2 - @goldball
			set @silverball2 = @silverball2 - @silverball
			set @upgradecost = @upgradecost + @goldball2*200 + @silverball2
			--select 'DEBUG (후)', @upgradecost 'upgradecost', @goldball2 'goldball2', @goldball 'goldball', @silverball2 'silverball2', @silverball 'silverball'
			
		end

	--select 'DEBUG ', @upgradestate  'upgradestate', @upgraderesult 'upgraderesult', @silverball 'silverball', @goldball 'goldball'

	------------------------------------------------
	-- 4-1. 각 조건별 분기 > 결과출력
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- 강화가 20강이상이 되면 영구템 기간으로 설정이 된다.
			-- 로그로 기록한다.
			---------------------------------------------------------	
			--select 'DEBUG (전)', upgradestate from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode			
			declare @permanentdate datetime
			declare @expiredate2 datetime
			set @permanentdate = DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)			
			if(@upgradestate >= @permanentstep)
				begin
					set @expiredate2 = @permanentdate
				end
			else
				begin
					set @expiredate2 = @expiredate
				end		
			update dbo.tUserItem 
				set  
					upgradestate = @upgradestate,
					upgradecost = @upgradecost,
					expiredate = @expiredate2
			where gameid = @gameid and itemcode = @itemcode			
			
			if(@expiredate < @permanentdate and  @expiredate2 = @permanentdate)
				begin
					insert into tMessage(gameid, comment) 
					values(@gameid,  @itemname + '가 50년 기간템으로 변경되었습니다.')
				end
			--select 'DEBUG (후)', upgradestate from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode

			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @goldball 'goldball',	@silverball 'silverball', @upgraderesult 'upgraderesult', @upgradestate 'upgradestate', @expiredate2 expireend, @silverballpetmy silverballpetmy, @newpet newpet
			
			
			---------------------------------------------------
			-- 펫강화시 상대방에게 실버지급, 메세지 남기기.
			---------------------------------------------------	
			if(@branch_ = @ITEM_UPGRADE_BRANCH_PET and exists(select * from dbo.tUserMaster where gameid = @mpetid_))
				begin
					-- 직접지급
					--update dbo.tUserMaster
					--set
					--	silverball 	= silverball + @silverballpetother
					--where gameid = @mpetid_					
					--
					--set @commentpet = @gameid + '님과의 펫교배로 +' + ltrim(rtrim(str(@silverballpetother)))+ '의 실버볼을 획득했습니다.'
					--insert into tMessage(gameid, comment) 					
					--values(@mpetid_,  @commentpet)
					
					-- 펫교배로 추가 실버획득(선물로 들어감)
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
					values(@mpetid_, @petreitother, @SENDER, -1);					
				end
			set @silverball = @silverball + @silverballpetmy 
			
			---------------------------------------------------------
			-- 유저정보기록(실패시 실버지급받음)
			---------------------------------------------------------
			--select 'DEBUG (값)', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium'
			--select 'DEBUG (전)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
			
			update dbo.tUserMaster
			set
				--ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
				--cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
				--glasses 		= @glasses,		wing 		= @wing,		tail = @tail,
				--pet 			= @pet,			
				--stadium		= @stadium,
				goldball 		= @goldball,	
				silverball 		= @silverball,
				itemupgradebest = @itemupgradebest,	
				itemupgradecnt 	= @itemupgradecnt,
				petmatingbest 	= @petmatingbest,		
				petmatingcnt 	= @petmatingcnt
			where gameid = @gameid
			--select 'DEBUG (후)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid	
			

			----------------------------------------------------
			-- 레어펫 아이템
			----------------------------------------------------
			if(@newpet != -1)
				begin
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
					values(@gameid, @newpet, 'PetRW', @newpetperiod);
					
					insert into tMessage(gameid, comment) 
					values(@gameid, @newpetname + '펫을 교배를 통해서 획득 하였습니다.')
				end


			---------------------------------------------------------
			-- 강화 로그 기록한다.
			---------------------------------------------------------
			--insert into dbo.tUserItemUpgradeLog(gameid, itemcode, upgradekind, upgraderesult, upgradestate, silverball, goldball) values('SangSang', 101, 1, 1, 1, 100, 200)
			insert into dbo.tUserItemUpgradeLog(gameid,		itemcode,	upgradebranch,		upgraderesult,		upgradestate,		silverball,			goldball) 
			values(								@gameid,	@itemcode,	@branch_,			@upgraderesult,		@upgradestate,		@silverball2,		@goldball2)
			
			
			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			declare @dateid 		varchar(8)
			declare @branchsilver 	int
			declare @branchpet		int
			
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			
			if(@branch_ = @ITEM_UPGRADE_BRANCH_SILVER)
				begin
					set @branchsilver = 1
				end
			else
				begin
					set @branchsilver = 0
				end
						
			
			if(@branch_ = @ITEM_UPGRADE_BRANCH_PET)
				begin
					set @branchpet = 1
				end
			else
				begin
					set @branchpet = 0
				end
			
			if(exists(select top 1 * from dbo.tUserItemUpgradeLogTotal where dateid = @dateid))
				begin
					update dbo.tUserItemUpgradeLogTotal 
						set 
							branchsilver 	= branchsilver + @branchsilver,
							branchpet 		= branchpet + @branchpet,
							
							goldball 		= goldball + @goldball2, 
							silverball 		= silverball + @silverball2, 
							cnt 			= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tUserItemUpgradeLogTotal(dateid, branchsilver, branchpet, goldball, silverball, cnt) 
					values(@dateid, @branchsilver, @branchpet, @goldball2, @silverball2, 1)
				end
				

				
			
		end
	else
		begin 
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment, @goldball 'goldball',	@silverball 'silverball', @upgraderesult 'upgraderesult', @upgradestate 'upgradestate', @expireend expireend, @silverballpetmy silverballpetmy, @newpet newpet
		end

	--select 'DEBUG (완료)', * from dbo.tUserMaster where gameid = @gameid
	------------------------------------------------
	--	3-3. 결과리턴(파트부위 출력)
	------------------------------------------------	
	select * from dbo.tUserMaster where gameid = @gameid	

	----------------------------------------------------
	-- 선물리스트 > 레어펫, 
	----------------------------------------------------
	if(@newpet != -1)
		begin
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid_ and gainstate = 0 
			order by idx desc
		end
	
	set nocount off
End

