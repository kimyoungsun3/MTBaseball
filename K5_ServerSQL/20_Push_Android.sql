/*
--delete from tUserPushAndroid
--select * from tUserPushAndroid order by idx desc
--select * from tUserPushAndroidLog order by idx desc
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 1, '단순제목', '단순내용', -1, -1
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 2, '자랑제목', '자랑내용', 5, -1
exec spu_UserPushMsgAndroid 'guest90586', '5697165c2c6g3u571634', 'guest90586', 3, 'URL제목', 'http://m.naver.com', -1, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserPushMsgAndroid', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserPushMsgAndroid;
GO

create procedure dbo.spu_UserPushMsgAndroid
	@gameid_				varchar(20),
	@password_				varchar(20),
	@receid_				varchar(20),
	@kind_					int,
	@msgtitle_				varchar(512),
	@msgmsg_				varchar(512),
	@gmode_					int,						--현재의 게임모드.
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83

	-- 상수값들. (99)
	declare @PUSH_MODE_MSG						int				set @PUSH_MODE_MSG						= 1
	declare @PUSH_MODE_PEACOCK					int				set @PUSH_MODE_PEACOCK					= 2
	declare @PUSH_MODE_URL						int				set @PUSH_MODE_URL						= 3
	declare @PUSH_MODE_GROUP					int				set @PUSH_MODE_GROUP					= 99	-- 단체발송용


	-- 통신사 구분값
	declare @SKT 							int					set @SKT						= 1
	--declare @KT 							int					set @KT							= 2
	--declare @LGT 							int					set @LGT						= 3
	--declare @GOOGLE 						int					set @GOOGLE						= 5
	--declare @NHN							int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @receid			varchar(20)
	declare @recepushid		varchar(256)
	declare @comment		varchar(512)
	declare @gamecost		int						set @gamecost			= 0
	declare @cashcost		int						set @cashcost			= 0
	declare @feed			int						set @feed				= 0
	declare @heart			int						set @heart				= 0

	declare @recemarket		int						set @recemarket			= @SKT

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid			= gameid,
		@gamecost		= gamecost,
		@cashcost		= cashcost,
		@feed			= feed,
		@heart			= heart
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_

	select
		@receid		= gameid,
		@recemarket	= market,
		@recepushid	= pushid
	from dbo.tUserMaster where gameid = @receid_

	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- 아이디가 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(isnull(@receid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
			set @comment = 'ERROR 상대가 존재하지 않습니다.'
		end
	else if(@kind_ not in (@PUSH_MODE_MSG, @PUSH_MODE_PEACOCK, @PUSH_MODE_URL))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다..'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS Push 정상처리하다.'

			---------------------------------------------------
			-- 전송 기록하기
			---------------------------------------------------
			declare @msgtitle		varchar(512)
			declare @msgmsg			varchar(512)
			declare @msgaction		varchar(512)

			if(@kind_ = @PUSH_MODE_MSG)
				begin
					set @msgtitle	= @msgtitle_
					set @msgmsg		= @msgmsg_
					set @msgaction	= 'LAUNCH'
				end
			else if(@kind_ = @PUSH_MODE_PEACOCK)
				begin
					-- 핸드폰에서 자랑하기로 들어온 경우.
					set @msgtitle	= '[짜요목장이야기]'
					set @msgmsg		= '[' + @gameid + '님이 인사를 했습니다.'
					set @msgaction	= 'LAUNCH'

				end
			else if(@kind_ = @PUSH_MODE_URL)
				begin
					set @msgtitle	= '[짜요목장이야기]'
					set @msgmsg		= '짜릿한 한판승부~~~'
					set @msgaction	= @msgmsg_
				end

			if(@recemarket = @IPHONE)
				begin
					insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)

					-- 토탈 기록하기
					exec spu_DayLogInfoStatic 1, 51, 1				-- 일 push iphone
				end
			else
				begin
					insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)

					-- 토탈 기록하기
					exec spu_DayLogInfoStatic 1, 50, 10				-- 일 push android
				end
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	set nocount off
End

