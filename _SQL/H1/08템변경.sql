---------------------------------------------------------------
/*
gameid=xxx
itemcode=xxx

exec spu_ItemChange 'SangSang', 54, 	-1		-- 미존재템		> 오류
exec spu_ItemChange 'SangSang', 50, 	-1		-- 얼굴변경 	> 오류
exec spu_ItemChange 'SangSang', 3200, 	-1		-- 락커룸		> 오류
exec spu_ItemChange 'SangSang', 120, 	-1		-- 미보유템 	> 오류
--exec spu_ItemChange 'sangsang', 111, 	-1		-- 템입력 > 기간강제만기
--select * from dbo.tUserItem where gameid = 'SangSang' and itemcode = 111
--update dbo.tUserItem set expiredate = '2012-08-11 11:05:00', expirestate = 1 where gameid = 'SangSang' and itemcode = 111
 
--기간만기
update dbo.tUserMaster set ccharacter = 0, face = 50, cap = 101, cupper = 201, cunder	= 301, bat = 401, glasses = 501, wing = 601, tail = 701, stadium = 801, pet = 5001 where gameid = 'SangSang'
update dbo.tUserItem set expiredate = '2012-08-11 11:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (102, 201, 301, 401, 501, 601, 701, 801, 5001)
--select * From Dbo.Tuseritem Where Gameid = 'sangsang'  and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001) order By Idx asc
exec spu_ItemChange 'SangSang', 101, 	-1		-- 모자(101)
exec spu_ItemChange 'SangSang', 201, 	-1		-- 상의(201)
exec spu_ItemChange 'SangSang', 301, 	-1		-- 하의(301)
exec spu_ItemChange 'SangSang', 401, 	-1		-- 배트(401)
exec spu_ItemChange 'SangSang', 501, 	-1		-- 안경(501)
exec spu_ItemChange 'SangSang', 601, 	-1		-- 날개(601)
exec spu_ItemChange 'SangSang', 701, 	-1		-- 꼬리(701)
exec spu_ItemChange 'SangSang', 801, 	-1		-- 구장(801)
exec spu_ItemChange 'SangSang', 5001, 	-1		-- 팻(5001)
exec spu_ItemChange 'SangSang', 0, 		-1		-- 캐릭터(0)
exec spu_ItemChange 'SangSang', 1, 		-1		-- 캐릭터(1)

exec spu_ItemChange 'SangSangd', 0, 	-1		-- 캐릭터(0)
exec spu_ItemChange 'SangSangd', 1, 	-1		-- 캐릭터(1)


--기간충분
update dbo.tUserMaster set ccharacter = 0, face = 50, cap = 100, cupper = 200, cunder	= 300, bat = 400, glasses = 500, wing = 600, tail = 700, stadium = 800, pet = 5000 where gameid = 'SangSang'
update dbo.tUserItem set expiredate = '2013-09-11 11:05:00', expirestate = 0 where gameid = 'SangSang' and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001)
--select * From Dbo.Tuseritem Where Gameid = 'sangsang'  and itemcode in (101, 201, 301, 401, 501, 601, 701, 801, 5001) order By Idx asc
exec spu_ItemChange 'SangSang', 101, 	-1		-- 모자(101)
exec spu_ItemChange 'SangSang', 201, 	-1		-- 상의(201)
exec spu_ItemChange 'SangSang', 301, 	-1		-- 하의(301)
exec spu_ItemChange 'SangSang', 401, 	-1		-- 배트(401)
exec spu_ItemChange 'SangSang', 501, 	-1		-- 안경(501)
exec spu_ItemChange 'SangSang', 601, 	-1		-- 날개(601)
exec spu_ItemChange 'SangSang', 701, 	-1		-- 꼬리(701)
exec spu_ItemChange 'SangSang', 801, 	-1		-- 구장(801)
exec spu_ItemChange 'SangSang', 5001, 	-1		-- 팻(5001)
exec spu_ItemChange 'SangSang', 0, 		-1		-- 캐릭터(0)
exec spu_ItemChange 'SangSang', 1, 		-1		-- 캐릭터(1)


exec spu_ItemChange 'SangSang', 0, 		-1		-- 캐릭터(0)	> 캐릭터 변경후 변경안됨
exec spu_ItemChange 'SangSang', 123, 	-1		-- 모자(101)
exec spu_ItemChange 'SangSang', 223, 	-1		-- 상의(201)
exec spu_ItemChange 'SangSang', 323, 	-1		-- 하의(301)

exec spu_ItemChange 'SangSang', -101, 	-1		-- 모자(101)
exec spu_ItemChange 'SangSang', -201, 	-1		-- 상의(201)
exec spu_ItemChange 'SangSang', -301, 	-1		-- 하의(301)
exec spu_ItemChange 'SangSang', -401, 	-1		-- 배트(401)
exec spu_ItemChange 'SangSang', -501, 	-1		-- 안경(501)
exec spu_ItemChange 'SangSang', -601, 	-1		-- 날개(601)
exec spu_ItemChange 'SangSang', -701, 	-1		-- 꼬리(701)
exec spu_ItemChange 'SangSang', -801, 	-1		-- 구장(801)
exec spu_ItemChange 'SangSang', -5001, 	-1		-- 팻(5001)
exec spu_ItemChange 'SangSang', -0, 	-1		-- 캐릭터(0)
exec spu_ItemChange 'SangSang', -1, 	-1		-- 캐릭터(1)
*/


IF OBJECT_ID ( 'dbo.spu_ItemChange', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ItemChange;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemChange
	@gameid_								varchar(20),					-- 게임아이디
	@itemcode_								int,							-- 아이템코드
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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102
	
	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	
	-- 변경모드
	declare @ITEM_WEAR_MODE_PUTON						int 	set @ITEM_WEAR_MODE_PUTON		= 1
	declare @ITEM_WEAR_MODE_STRIP						int 	set @ITEM_WEAR_MODE_STRIP		= -1



	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid = @gameid_
	declare @itemcode		int				set @itemcode = @itemcode_
	declare @comment		varchar(80)
	declare @wearmode		int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 아이템을 변경할 수 없습니다.(-1)'
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	BEGIN
		declare @ccharacter		int,			@face			int,		@cap				int, 
				@cupper			int,			@cunder			int,		@bat				int, 
				@glasses		int,			@wing			int,		@tail				int,
				@pet			int,
				@stadium		int
		declare @expirestate	int,			@expiredate		datetime
		declare @itemkind		int,			
				@itemperiod		int,
				@param1			varchar(20),	@param2			varchar(20),
				@param3			varchar(20),	@param4			varchar(20),
				@param5			varchar(20),	@param6			varchar(20),
				@param7			varchar(20),	@param8			varchar(20),
				@itemname 		varchar(20)
		declare @restorechar int
		declare @restorepart int
		declare @customize		varchar(128)
		declare @customize2		varchar(128)
		declare @ccharacterMaster	int,
				@ccharacterPart 	int
		
		------------------------------------------------
		-- 벗기기 모드 추가.
		------------------------------------------------
		if(@itemcode >= 0)
			begin
				--select 'DEBUG 착용모드'
				set @wearmode = @ITEM_WEAR_MODE_PUTON
			end
		else
			begin
				--select 'DEBUG 해제모드'
				set @wearmode = @ITEM_WEAR_MODE_STRIP
				set @itemcode = -@itemcode
			end
		


		------------------------------------------------
		-- 유저(tUserMaster) > 각파트정보
		--select 'DEBUG 유저정보', * from dbo.tUserMaster where gameid = @gameid
		------------------------------------------------
		select	
				@ccharacter = ccharacter,	@face = face,				@cap = cap,
				@cupper = cupper,			@cunder	= cunder,			@bat = bat,
				@glasses = glasses,			@wing = wing,				@tail = tail,
				@pet = pet,
				@stadium = stadium,
				@customize = customize
		from dbo.tUserMaster where gameid = @gameid
		
		
		------------------------------------------------
		-- 유저보유템(tUserItem) > 사용기간, 파기상태
		--select 'DEBUG 보유유무', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		------------------------------------------------
		select @expirestate = expirestate, @expiredate = expiredate
		from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
		
		
		------------------------------------------------
		-- 아이템(tItemInfo) > 종류
		--select 'DEBUG 아이템', * from dbo.tItemInfo where itemcode = @itemcode
		------------------------------------------------
		select
			@itemkind = kind, 		@itemperiod = period,	
			@param1 = param1, 		@param2 = param2,			@param3 = param3,		
			@param4 = param4,		@param5 = param5, 			@param6 = param6,
			@param7 = param7,		@param8 = param8,
			@itemname = itemname,
			@ccharacterMaster = param7,		
			@ccharacterPart = param8
		from dbo.tItemInfo where itemcode = @itemcode	
		
		
		-------------------------------------------------
		-- 아이템 파트가 캐릭터 파트 > 커스터마이징 읽어복원
		-------------------------------------------------
		if(isnull(@ccharacter, -1) != -1)
			begin
				if(isnull(@itemkind, -1) != -1 and @itemkind = @ITEM_KIND_CHARACTER)
					begin
						select @customize2 = customize from dbo.tUserCustomize
						where gameid = @gameid and itemcode = @itemcode
						if(isnull(@customize2, '-1') = '-1')
							begin
								--로그가 누락되었네 ㅎㅎㅎ
								set @customize2 = @ITEM_CHAR_CUSTOMIZE_INIT;
								--insert into dbo.tUserCustomize(gameid, itemcode, customize)
								--values(@gameid, @ccharacter, @ITEM_CHAR_CUSTOMIZE_INIT)
							end
						 
						
						--select 'DEBUG ',  @ccharacter '기존', @customize customize, @itemcode '새것', @customize2 customize2
						set @customize = @customize2 
						
					end
			end

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
		if isnull(@itemkind, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				set @comment = 'ERROR 아이템 자체가 존재하지 않습니다. 확인바랍니다.'
			END
		else if (@itemkind not in (@ITEM_KIND_CHARACTER, @ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_NOCHANGE_KIND
				set @comment = 'ERROR 변경할 수 없는 아이템 부위입니다.' + str(@itemkind)
			END
		else if (@wearmode = @ITEM_WEAR_MODE_STRIP and @itemkind not in (@ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_PET))
			BEGIN
				set @nResult_ = @RESULT_ERROR_ITEM_STRIP_CANNT_KIND
				set @comment = 'ERROR 착용해제 부위는 안경, 날개, 꼬리, 펫만 해제 가능합니다.' + str(@itemkind)
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
								--select 'DEBUG 캐릭원복(비종속)'
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

			end
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				-------------------------------------------------------
				-- 	캐릭터 변경					
				-------------------------------------------------------
				if(@itemkind = @ITEM_KIND_CHARACTER)
					begin
						set @comment = 'SUCCESS 캐릭터 정상변경'

						-- 하단에서 캐릭터 파트부위 정보변경					
						set @ccharacter = @itemcode
						set @face = @param1
						set @cap = @param2
						set @cupper = @param3
						set @cunder = @param4
						--@bat 그대로
						--set @glasses = -1	그대로 2012-09-13일날 모든 파트 그대로 유지
						--set @wing = -1	그대로 2012-09-13일날 모든 파트 그대로 유지
						--set @tail = -1	그대로 2012-09-13일날 모든 파트 그대로 유지
						--@pet 그대로
						--@stadium 그대로
						
					end
				else if(@wearmode = @ITEM_WEAR_MODE_STRIP and @itemkind in (@ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_PET))
					begin						
						if(@itemkind = @ITEM_KIND_GLASSES)
							begin
								set @comment = 'SUCCESS 안경 해제'
								set @glasses = -1
							end
						else if(@itemkind = @ITEM_KIND_WING)
							begin
								set @comment = 'SUCCESS 날개 해제'
								set @wing = -1
							end
						else if(@itemkind = @ITEM_KIND_TAIL)
							begin
								set @comment = 'SUCCESS 꼬리 해제'
								set @tail = -1
							end
						else if(@itemkind = @ITEM_KIND_PET)
							begin
								set @comment = 'SUCCESS 펫 해제'
								set @pet = -1
							end
					end	
				else if(@itemkind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER, @ITEM_KIND_BAT, @ITEM_KIND_GLASSES, @ITEM_KIND_WING, @ITEM_KIND_TAIL, @ITEM_KIND_STADIUM, @ITEM_KIND_PET))
					begin						
						if(@itemkind = @ITEM_KIND_CAP)
							begin
								set @comment = 'SUCCESS 모자 변경'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cap = @itemcode
									end
							end
						else if(@itemkind = @ITEM_KIND_UPPER)
							begin
								set @comment = 'SUCCESS 상의 변경'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cupper = @itemcode
									end
							end
						else if(@itemkind = @ITEM_KIND_UNDER)
							begin
								set @comment = 'SUCCESS 하의 변경'
								if(@ccharacter = @ccharacterMaster)	
									begin
										set @cunder = @itemcode
									end
							end
						else if(@itemkind = @ITEM_KIND_BAT)
							begin
								set @comment = 'SUCCESS 배트 변경'
								set @bat = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_GLASSES)
							begin
								set @comment = 'SUCCESS 안경 변경'
								set @glasses = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_WING)
							begin
								set @comment = 'SUCCESS 날개 변경'
								set @wing = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_TAIL)
							begin
								set @comment = 'SUCCESS 꼬리 변경'
								set @tail = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_STADIUM)
							begin
								set @comment = 'SUCCESS 스타듐 변경'
								set @stadium = @itemcode
							end
						else if(@itemkind = @ITEM_KIND_PET)
							begin
								set @comment = 'SUCCESS 펫 변경'
								set @pet = @itemcode
							end
					end		
				else
					begin
						set @nResult_ = @RESULT_ERROR
						set @comment = 'ERROR 아이템을 변경/해제할수 없습니다.(-2)'
					end
			END

		if(@nResult_ = @RESULT_SUCCESS or @nResult_ = @RESULT_ERROR_ITEM_EXPIRE)
			begin
				---------------------------------------------------------
				-- 코드출력
				---------------------------------------------------------
				select @nResult_ rtn, @comment
				
				---------------------------------------------------------
				-- 유저정보기록
				---------------------------------------------------------
				--select 'DEBUG (값)', @ccharacter 'ccharacter', @face 'face', @cap 'cap', @cupper 'cupper', @cunder 'cunder', @bat 'bat', @glasses 'glasses', @wing 'wing', @tail 'tail', @pet 'pet', @stadium 'stadium'
				--select 'DEBUG (전)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
				
				update dbo.tUserMaster
				set
					ccharacter 	= @ccharacter,	face 		= @face,		cap = @cap,
					cupper 		= @cupper,		cunder		= @cunder,		bat = @bat,
					glasses 	= @glasses,		wing 		= @wing,		tail = @tail,
					pet 		= @pet,			
					stadium		= @stadium,
					customize	= @customize
				where gameid = @gameid
				--select 'DEBUG (후)', ccharacter, face, cap, cupper, cunder, bat, glasses, wing, tail, stadium, pet from dbo.tUserMaster where gameid = @gameid				
			end
		else
			begin 
				select @nResult_ rtn, @comment
			end

	END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--select 'DEBUG (완료)', * from dbo.tUserMaster where gameid = @gameid
			select * from dbo.tUserMaster where gameid = @gameid	
		end
	set nocount off
End

