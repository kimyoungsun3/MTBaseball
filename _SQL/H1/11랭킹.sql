/* 
[랭킹]
gameid=xxx
gmode=xxx

update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 0, bttotal = 0 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 1, bttotal = 1 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 0, bttotal = 1 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 50000, memorialpoint = 50000, btwin = 50000, bttotal = 50000 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 1235, memorialpoint = 2345, btwin = 500, bttotal = 240 where gameid = 'SangSang'
exec spu_GameRank 'SangSang', 1, -1
exec spu_GameRank 'SangSang', 2, -1
exec spu_GameRank 'SangSang', 3, -1
--exec spu_GameRank 'SangSang', 4, -1		--현재삭제되어 있음
exec spu_GameRank 'SangSang', 5, -1
select gameid, btwin from dbo.tUserMaster order by btwin desc

declare @v1 int		set @v1 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v2 int		set @v2 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v3 int		set @v3 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v4 int		set @v4 = Convert(int, ceiling(RAND() * 10000) - 1) + @v3
update dbo.tUserMaster set machinepoint = @v1, memorialpoint = @v2, btwin = @v3, bttotal = @v4 where gameid = 'DD99'
DD2, DD4, DD60, DD99
--SELECT Convert(int, ceiling(RAND() * 10000) - 1)

select rank() over(order by win desc, lose asc) as rank, c.ccode, n.cname, win btwin, (lose + win) bttotal, n.cnt, n.gameid  gameid
from 
	dbo.tBattleCountry c 
		join 
	dbo.tBattleCountryClub n
	on c.ccode = n.ccode
where dateid = '201211'

select * from dbo.tBattleCountryClub
*/



IF OBJECT_ID ( 'dbo.spu_GameRank', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GameRank;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GameRank
	@gameid_								varchar(20),					-- 게임아이디
	@mode_									int,
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

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	
	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도


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
	
	-- 게임시작
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	
	-- 모드별 행동력 소모량
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- 게임플레이 상태정보
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- 게임중에 획득하는 레벨경험치, 등급경험치, 획득실버
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 3
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= 10
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= 20

	--랭킹모드.
	declare @RANK_MODE_FRIENDS					int				set @RANK_MODE_FRIENDS					= 3		-- 메뉴(친구)
	declare @RANK_MODE_WORLDTOP10				int				set @RANK_MODE_WORLDTOP10				= 1		-- 메뉴(월드)	
	declare @RANK_MODE_COUNTRY					int				set @RANK_MODE_COUNTRY					= 5		-- 메뉴(나라)
	declare @RANK_MODE_MY						int				set @RANK_MODE_MY						= 2		-- 개인정보
	--declare @RANK_MODE_BATTLE_FRIENDS			int				set @RANK_MODE_BATTLE_FRIENDS			= 4		-- 삭제

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)
	declare @machinepoint	int,
			@memorialpoint	int,
			@bttotal		int,
			@btwin			int,
			@avatar			int,
			@grade			int,
			@lv				int
	declare @picture		varchar(128)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	
	------------------------------------------------
	--	3-2. 랭킹
	------------------------------------------------
	select @gameid = gameid, @machinepoint = machinepoint, @memorialpoint = memorialpoint, @btwin = btwin, @bttotal = bttotal, @avatar = avatar, @picture = picture, @grade = grade, @lv = lv from tUserMaster where gameid = @gameid_
	--select @machinepoint, @memorialpoint, @btwin, @bttotal

	------------------------------------------------
	--	유저존재유무
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 유저가 존재하지 않습니다.'
		END
	else if(@mode_ not in (@RANK_MODE_WORLDTOP10, @RANK_MODE_MY, @RANK_MODE_FRIENDS, @RANK_MODE_COUNTRY))
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 지원하지 않는모드입니다.'
		END
	else if(@mode_ in (@RANK_MODE_WORLDTOP10))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS Top10 랭킹산출'

			select top 10 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where machinepoint > @machinepoint

			select top 10 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where memorialpoint > @memorialpoint

			select top 10 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where btwin > @btwin
		end
	else if(@mode_ in (@RANK_MODE_MY))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS my 랭킹산출'

			--select top 10 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where machinepoint > @machinepoint

			--select top 10 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where memorialpoint > @memorialpoint

			--select top 10 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where btwin > @btwin
		end
	else if(@mode_ in (@RANK_MODE_FRIENDS))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS friend 랭킹산출'

			select rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_

			select rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_

			select rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_
		end
	--else if(@mode_ in (@RANK_MODE_BATTLE_FRIENDS))
	--	begin
	--		set @nResult_ = @RESULT_SUCCESS
	--		select @nResult_ rtn, 'SUCCESS battle friend 랭킹산출'
	--
	--		select -1 as rank , @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture , @grade grade, @lv lv
	--
	--		select -1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv
	--
	--		select rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
	--		where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_
	--	end
	else if(@mode_ in (@RANK_MODE_COUNTRY))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 국가 랭킹산출'
			
			declare @dateid 	varchar(6)
			set @dateid = Convert(varchar(6),Getdate(),112)		-- 201208

			select rank() over(order by win desc, lose asc) as rank, c.ccode, n.cname, win btwin, (lose + win) bttotal, n.cnt, n.gameid  gameid
			from 
				dbo.tBattleCountry c 
					join 
				dbo.tBattleCountryClub n
				on c.ccode = n.ccode
			where dateid = @dateid
		end
	
	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

