/*
-- 일반가입
exec spu_UserCreate 'xxxx',    '049000s1i0n7t8445289', '길동1',  '19980101', '01011112221', 'xxxx@gmail.com',     '길동1닉네임', 100, -1
exec spu_UserCreate 'xxxx2',   '049000s1i0n7t8445289', '길동2', '19980102', '01011112222', 'xxxx2@gmail.com',    '길동2닉네임', 100, -1
exec spu_UserCreate 'xxxx3',   '049000s1i0n7t8445289', '길동3', '19980103', '01011112223', 'xxxx3@gmail.com',    '길동3닉네임', 100, -1
exec spu_UserCreate 'xxxx4',   '049000s1i0n7t8445289', '길동4', '19980104', '01011112224', 'xxxx4@gmail.com',    '길동4닉네임', 100, -1
exec spu_UserCreate 'xxxx4',   '049000s1i0n7t8445289', '길동5', '19980105', '01011112225', 'xxxx5@gmail.com',    '길동5닉네임', 100, -1
exec spu_UserCreate 'xxxx5',   '049000s1i0n7t8445289', '길동6', '19980106', '01011112226', 'xxxx6@gmail.com',    '길동6닉네임', 100, -1
exec spu_UserCreate 'xxxx6',   '049000s1i0n7t8445289', '길동7', '19980107', '01011112227', 'xxxx7@gmail.com',    '길동7닉네임', 100, -1
exec spu_UserCreate 'xxxx7',   '049000s1i0n7t8445289', '길동8', '19980108', '01011112228', 'xxxx8@gmail.com',    '길동8닉네임', 100, -1
exec spu_UserCreate 'xxxx8',   '049000s1i0n7t8445289', '길동9', '19980109', '01011112229', 'xxxx9@gmail.com',    '길동9닉네임', 100, -1

-- select * from dbo.tUserBlockLog where gameid = ''
-- select * from dbo.tUserMaster where gameid = ''
-- select * from dbo.tUserItem where gameid = ''

-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)
declare @phone 			varchar(20)
declare @email			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @gameid			= 'mtuser' + CONVERT(varchar(10), @var)
		set @phone			= '010' + ltrim(@var)
		set @email			= @gameid + '@gmail.com'
		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							@gameid,					-- username
							'19980109', 				-- birthday
							@phone, 					-- phone
							@email,						-- email,
							@gameid,					-- nickname
							100,						-- version
							-1
		set @var = @var + 1
	end
*/

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserCreate;
GO

create procedure dbo.spu_UserCreate
	@gameid_				varchar(20),						-- *게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@username_				varchar(60),						-- 홍길동
	@birthday_				varchar(8),							-- 20000801
	@phone_					varchar(60),						-- 01012345678
	@email_					varchar(60),						-- kkk@gmail.com
	@nickname_				varchar(60),						-- 홍길동닉네임
	@version_				int,								-- 클라버젼
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- MT 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT 아이디 생성
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- 생성제한.
	declare @RESULT_ERROR_PHONE_DUPLICATE		int				set @RESULT_ERROR_PHONE_DUPLICATE		= -4
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -5
	declare @RESULT_ERROR_NICKNAME_DUPLICATE	int				set @RESULT_ERROR_NICKNAME_DUPLICATE	= -6

	-- MT 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.


	------------------------------------------------
	--	2-1. 정의된값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	declare @ID_MAX								int					set	@ID_MAX							= 5 -- 한폰당 생성할 수 있는 아이디개수

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- MT 아이템 대분류
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- 장착템(1)

	-- MT 아이템 소분류
	declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- 헬멧(1)
	declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- 상의(2)
	declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- 하의(3)
	declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- 장갑(4)
	declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- 신발(5)
	declare @ITEM_SUBCATEGORY_WEAR_BAT			int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- 방망이(6)
	declare @ITEM_SUBCATEGORY_WEAR_BALL			int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- 색깔공(7)
	declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- 고글(8)
	declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- 손목 아대(9)
	declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD		int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- 팔꿈치 보호대(10)
	declare @ITEM_SUBCATEGORY_WEAR_BELT			int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- 벨트(11)
	declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD		int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- 무릎 보호대(12)
	declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- 양말(13)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

	declare	@regmsg			varchar(1000)	set @regmsg = '가입을 진심으로 축하 합니다.'
	declare @comment		varchar(80)

	declare @gameid			varchar(20)		set @gameid			= ''
	declare @idx			int				set @idx			= -1
	declare @listidx		int
	declare @itemcode		int
	declare @cnt			int

	declare @deldate		datetime		set @deldate		= getdate() - 1
	declare @dateid8 		varchar(8)		set @dateid8 		= Convert(varchar(8),Getdate(),112)
	declare @joincnt		int				set @joincnt		= 0
	declare @cashcost 		int
	declare @loop 			int

	declare @helmetlistidx		int 		set @helmetlistidx 			= 1
	declare @shirtlistidx		int 		set @shirtlistidx			= 2
	declare @pantslistidx		int 		set @pantslistidx			= 3
	declare @gloveslistidx		int 		set @gloveslistidx			= 4
	declare @shoeslistidx		int 		set @shoeslistidx			= 5
	declare @batlistidx			int 		set @batlistidx				= 6
	declare @balllistidx		int 		set @balllistidx			= 7
	declare @gogglelistidx		int 		set @gogglelistidx			= 8
	declare @wristbandlistidx	int 		set @wristbandlistidx		= 9
	declare @elbowpadlistidx	int 		set @elbowpadlistidx		= 10
	declare @beltlistidx		int 		set @beltlistidx			= 11
	declare @kneepadlistidx		int 		set @kneepadlistidx			= 12
	declare @sockslistidx		int 		set @sockslistidx			= 13

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	select 'DEBUG 1-1 입력정보', @gameid_ gameid_, @password_ password_, @username_ username_, @birthday_ birthday_,  @phone_ phone_, @email_ email_, @nickname_ nickname_, @version_ version_

	------------------------------------------------
	-- 핸드폰으로 생성된 아이디기 갯수 파악
	------------------------------------------------
	select
		@joincnt = joincnt
	from tUserPhone where phone = @phone_
	select 'DEBUG 1-2  핸드폰별 가입자:', @phone_ phone_, @joincnt joincnt


	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
		begin
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			select 'DEBUG 2-1', @comment
		end
	else if exists (select top 1 * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = '(생성)아이디가 중복되었습니다.'
			select 'DEBUG 2-2', @comment
		end
	else if(@joincnt >= @ID_MAX)
		begin
			set @nResult_ = @RESULT_ERROR_ID_CREATE_MAX
			set @comment = '생성개수 ' + ltrim(str(@ID_MAX)) + '개까지만(삭제는제외)'
			select 'DEBUG 2-3', @comment
		end
	else if exists (select top 1 * from tUserMaster where email = @email_)
		begin
			set @nResult_ = @RESULT_ERROR_EMAIL_DUPLICATE
			set @comment = '이메일이 중복되었습니다.'
			select 'DEBUG 2-4', @comment
		end
	else if exists (select top 1 * from tUserMaster where nickname = @nickname_)
		begin
			set @nResult_ = @RESULT_ERROR_NICKNAME_DUPLICATE
			set @comment = '닉네임이 중복되었습니다.'
			select 'DEBUG 2-5', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(생성)가입을 축하합니다.'
			select 'DEBUG 3-1', @comment

			-------------------------------------------
			-- 1. 초기 지급 > 없음.
			-------------------------------------------

			-------------------------------------------
			-- 2. 블럭폰 > 가입블럭처리
			-------------------------------------------

			------------------------------------------------
			-- 3. 착용장비 지급...
			------------------------------------------------
			select 'DEBUG 3-4 아이템지급 > 착용템지급'
			set @listidx		= 0
			set @itemcode		= 1

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @helmetlistidx, 	   100,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @shirtlistidx, 	   200,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @pantslistidx, 	   300,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @gloveslistidx, 	   400,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @shoeslistidx, 	   500,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @batlistidx, 	   600,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @balllistidx, 	   700,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @gogglelistidx, 	   800,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @wristbandlistidx, 	900,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @elbowpadlistidx, 	1000,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @beltlistidx, 	    1100,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @kneepadlistidx, 	1200,   1, @USERITEM_INVENKIND_WEAR)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, invenkind)
			values(					 @gameid_, @sockslistidx, 	   1300,   1, @USERITEM_INVENKIND_WEAR)

			---------------------------------------------
			-- 유저 정보 입력하기
			---------------------------------------------
			select 'DEBUG 3-5 유저 정보 입력'
			insert into dbo.tUserMaster(
										gameid, 		password,
										username, 		birthday, 		phone, 		email, 	nickname, 	version,
										helmetlistidx, 	shirtlistidx, 	pantslistidx, 		gloveslistidx, 		shoeslistidx, 	batlistidx,
										balllistidx, 	gogglelistidx, 	wristbandlistidx, 	elbowpadlistidx, 	beltlistidx, 	kneepadlistidx,
										sockslistidx
										)
			values(
										@gameid_, 		@password_,
										@username_, 	@birthday_, 	@phone_, 	@email_, @nickname_, @version_,
										@helmetlistidx, @shirtlistidx, 	@pantslistidx, 		@gloveslistidx,		@shoeslistidx, 	@batlistidx,
										@balllistidx, 	@gogglelistidx,	@wristbandlistidx, 	@elbowpadlistidx, 	@beltlistidx,	@kneepadlistidx,
										@sockslistidx
										)
			------------------------------------
			-- 가입 통계를 작성한다.(일반, 게스트)
			------------------------------------
			select 'DEBUG > 3-7-2 아이디입력방식 생성'
			--exec spu_DayLogInfoStatic 10, 1

			----------------------------------------------
			---- 핸드폰별 가입 카운터
			----------------------------------------------
			if(@joincnt = 0)
				begin
					select 'DEBUG > 3-8 핸드폰별 가입 카운터'
					--exec spu_DayLogInfoStatic 11, 1

					insert into dbo.tUserPhone(phone, joincnt) values(@phone_, 1)
				end
			else
				begin
					update dbo.tUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime

	--최종 결과를 리턴한다.
	set nocount off
End



