/*
update dbo.tUserMaster set mboardstate = 0 where gameid = 'xxxx2'
exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289', 1, -1, '', -1		-- 게시판 추천 글쓰기
exec spu_ChangeInfo 'supermani', '049000s1i0n7t8445289', 1, -1, '', -1	-- 게시판 추천 글쓰기(iPhone 미지급)

exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289', 11, -1, '', -1		-- 푸쉬승인/거절

--select kakaomsgblocked from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_ChangeInfo 'xxxx2', '049000s1i0n7t8445289', 12, -1, '', -1		-- 카카오 메세지 자기것 거부
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ChangeInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ChangeInfo;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ChangeInfo
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(256),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	--declare @MARKET_SKT						int					set @MARKET_SKT						= 1
	--declare @MARKET_GOOGLE					int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 유저 정보 변경모드.
	declare @USERMASTER_CHANGEINOF_MODE_BOARDWRITE		int		set @USERMASTER_CHANGEINOF_MODE_BOARDWRITE		= 1
	declare @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW	int		set @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW	= 11		-- 카카오톡 푸쉬.
	declare @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED	int		set @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED	= 12		-- 카카오톡 메세지블럭.

	-- 보드에 글쓰기.
	declare @BOARD_STATE_NON					int				set @BOARD_STATE_NON				= 0
	declare @BOARD_STATE_REWARD					int				set @BOARD_STATE_REWARD				= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int				set @BOARD_STATE_REWARD_GAMECOST	= 600

	--카톡 메세지 블럭.
	declare @KAKAO_MESSAGE_ALLOW 				int				set @KAKAO_MESSAGE_ALLOW						= -1		-- 카카오 메세지 발송가능.
	declare @KAKAO_MESSAGE_BLOCK 				int				set @KAKAO_MESSAGE_BLOCK						=  1		-- 카카오 메세지 불가능.

	-- Yes/No
	-- 체킹
	declare @INFOMATION_NO						int				set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int				set @INFOMATION_YES					=  1

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)

	declare @gameid			varchar(20)				set @gameid			= ''
	declare @gamecost		int						set @gamecost		= 0
	declare @market			int						set @market			= 0

	declare @mboardstate	int						set @mboardstate	= @BOARD_STATE_REWARD


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @paramint_ paramint_, @paramstr_ paramstr_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select

		@gameid 		= gameid,		@market			= market,		@gamecost		= gamecost,
		@mboardstate	= mboardstate
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @gamecost gamecost, @mboardstate mboardstate

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERMASTER_CHANGEINOF_MODE_BOARDWRITE, @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW, @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERMASTER_CHANGEINOF_MODE_BOARDWRITE)
		BEGIN
			------------------------------------------
			-- 구매모드.
			------------------------------------------
			if(@mboardstate = @BOARD_STATE_REWARD)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD
					set @comment 	= 'SUCCESS 이미보상 했습니다.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 보상성공.'
					--select 'DEBUG ' + @comment

					---------------------------------------------
					-- 보상처리.
					-- iPhone은 보상이 없음.
					---------------------------------------------
					if(@market = @MARKET_IPHONE)
						begin
							set @BOARD_STATE_REWARD_GAMECOST = 0
						end

					update dbo.tUserMaster
						set
							gamecost 	= gamecost + @BOARD_STATE_REWARD_GAMECOST,
							mboardstate = @BOARD_STATE_REWARD
					where gameid = @gameid_
				END
		END
	else if (@mode_ = @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 변경하였습니다.'
			--select 'DEBUG ' + @comment

			update dbo.tUserMaster
				set
					kkopushallow	= case
											when kkopushallow = @INFOMATION_NO then @INFOMATION_YES
											else									@INFOMATION_NO
									  end
			where gameid = @gameid_
		END
	else if (@mode_ = @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 변경하였습니다.'
			--select 'DEBUG ' + @comment

			update dbo.tUserMaster
				set
					kakaomsgblocked	= case
											when kakaomsgblocked = @KAKAO_MESSAGE_ALLOW then @KAKAO_MESSAGE_BLOCK
											else											 @KAKAO_MESSAGE_ALLOW
									  end
			where gameid = @gameid_
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR 알수없는 오류(-1)'
		end


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 정보.
			--------------------------------------------------------------
			select @BOARD_STATE_REWARD_GAMECOST mboardreward, * from dbo.tUserMaster
			where gameid = @gameid_
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

