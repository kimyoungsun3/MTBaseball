---------------------------------------------------------------
/*
-- 악세구매
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1	-- 악세(머리)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1402, 1, -1, -1, -1, 7776, -1	-- 악세(머리)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1462, 1, -1, -1, -1, 7777, -1	-- 악세(옆구리)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1463, 1, -1, -1, -1, 7777, -1	-- 악세(옆구리)

-- 동물 > 악세세팅
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445287',  0, 12, 13, 7771, -1	-- 패스워드 잘못.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  1, 99, 99, 7772, -1	-- 없음.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 14, 12, 10, 7773, -1	-- 동물자리에 틀림
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 17, 20, 7774, -1	-- 악세자리에 틀림.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  4, 16, 17, 7775, -1	-- 죽은동물.
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, 20, 7776, -1	-- 하나의 악세로 세팅.

exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, 16, -1, 7777, -1	-- 1번동물에 12번악세를 머리
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, -1, 17, 7778, -1	-- 1번동물에                  13번악세를 옆구리
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  3, 16, 17, 7779, -1	-- 1번동물에 12번악세를 머리, 13번악세를 옆구리
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289',  1, 12, 13, 7770, -1	-- 1번동물에 7번악세를 머리

--delete from dbo.tFVUserItem where gameid = 'xxxx2' and listidx in (33, 34, 35, 36, 37, 38)
--update dbo.tFVUserMaster set randserial = -1, gamecost = 10000, bgacc1listidx = -1, bgacc2listidx = -1 where gameid = 'xxxx2'
--update dbo.tFVUserItem	set acc1 = -1, acc2 = -1, randserial = -1 where gameid = 'xxxx2' and listidx = 19
--update dbo.tFVUserItem	set acc1 = 1400, acc2 = 1460, randserial = -1 where gameid = 'xxxx2' and listidx = 19

---------------------------------------------
-- acc1listidx, acc2listidx 가질수 있는값
---------------------------------------------
-- 교체하기			: >=0 번호
-- 빼기하기			: -1
-- 현상태를 유지	: -2

-- s1. 처음 빈곳 > 악세 둘다 세팅 > 악세 둘다 변경
delete from dbo.tFVUserItem where gameid = 'xxxx2' and listidx in (20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)
exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1402, 1, -1, -1, -1, 7776, -1	 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1461, 1, -1, -1, -1, 7777, -1 exec spu_FVItemBuy 'xxxx2', '049000s1i0n7t8445289', 1462, 1, -1, -1, -1, 7777, -1	-- 악세(옆구리)
update dbo.tFVUserMaster set gamecost = 10000, cashcost = 10000, randserial = -1, bgacc1listidx = -1, bgacc2listidx = -1 where gameid = 'xxxx2'
update dbo.tFVUserItem	set acc1 = -1, acc2 = -1, randserial = -1 where gameid = 'xxxx2' and listidx = 19
update dbo.tFVUserItem	set acc1 = 1403, acc2 = 1463, randserial = -1 where gameid = 'xxxx2' and listidx = 19

exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, 22, 7771, -1	-- 빈곳에 둘다 채우기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 21, 23, 7772, -1	-- 있는곳에 둘다 채우기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -1, 7775, -1	-- 둘대빼기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -2, 7775, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, 21, 7779, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -1, 7773, -1	-- 둘대빼기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -1, 7775, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 20, -1, 7771, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -2, 7774, -1	-- 있는곳에 둘다 채우기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, -1, 7776, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -2, 25, 7777, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, -1, -2, 7776, -1	-- 한쪽만 벗기
exec spu_FVItemAccNew 'xxxx2', '049000s1i0n7t8445289', 19, 27, -1, 7777, -1	-- 한쪽만 벗기

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemAccNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemAccNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVItemAccNew
	@gameid_				varchar(60),
	@password_				varchar(20),
	@anilistidx_			int,
	@acc1listidx_			int,
	@acc2listidx_			int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	--declare @RESULT_ERROR_GAMECOST_LACK		int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	--declare @RESULT_ERROR_CASHCOST_LACK		int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	--declare @RESULT_ERROR_ITEM_LACK			int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	--declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	--declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	--declare @RESULT_ERROR_NOT_FOUND_GIFTID	int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	--declare @RESULT_ERROR_TUTORIAL_ALREADY	int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	--declare @RESULT_ERROR_NOT_FOUND_OTHERID	int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	--declare @RESULT_ERROR_NOT_MATCH			int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	--declare @RESULT_ERROR_DOUBLE_RANDSERIAL	int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	--declare @RESULT_ERROR_MAXCOUNT			int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	--declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	--declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.


	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.

	-- 아이템 획득방법
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	--declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	--declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	--declare @DEFINE_HOW_GET_SEARCH			int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--선물
	--declare @DEFINE_HOW_GET_ROULACC			int					set @DEFINE_HOW_GET_ROULACC					= 9	--액세뽑기
	declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--액세해제

	-- 악세 상태값
	-- 악세 교체 listidx >= 0																							-- 악세교체.
	declare @ACC_STATE_STRIP					int					set @ACC_STATE_STRIP						= -1	-- 악세해제.
	declare @ACC_STATE_KEEP						int					set @ACC_STATE_KEEP							= -2	-- 악세유지.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid				= ''

	declare @aniinvenkind	int				set @aniinvenkind	= -1
	declare @aniitemcode	int				set @aniitemcode	= -444
	declare @anifieldidx	int				set @anifieldidx	= @USERITEM_FIELDIDX_HOSPITAL
	declare @acc1			int				set @acc1			= -1
	declare @acc2			int				set @acc2			= -1
	declare @acc1bg1		int				set @acc1bg1		= -1
	declare @acc2bg1		int				set @acc2bg1		= -1
	declare @acc1bg2		int				set @acc1bg2		= -1
	declare @acc2bg2		int				set @acc2bg2		= -1

	declare @acc1invenkind	int				set @acc1invenkind	= -1
	declare @acc2invenkind	int				set @acc2invenkind	= -1
	declare @acc1itemcode	int				set @acc1itemcode	= -444
	declare @acc2itemcode	int				set @acc2itemcode	= -444

	declare @anireplistidx	int				set @anireplistidx	= 1
	declare @invenaccmax	int
	declare @invencnt 		int				set @invencnt		= 0
	declare @invenkind 		int				set @invenkind		= @USERITEM_INVENKIND_ACC
	declare @bgacc1listidxdel 	int
	declare @bgacc2listidxdel 	int
	declare @bgacc1listidx 	int
	declare @bgacc2listidx 	int
	declare @randserial		varchar(20)		set @randserial		= ''
	declare @listidxnew		int				set @listidxnew		= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @anilistidx_ anilistidx_, @acc1listidx_ acc1listidx_, @acc2listidx_ acc2listidx_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@anireplistidx	= anireplistidx,
		@invenaccmax 	= invenaccmax,
		@bgacc1listidxdel = bgacc1listidxdel,
		@bgacc2listidxdel = bgacc2listidxdel,
		@bgacc1listidx	= bgacc1listidx,
		@bgacc2listidx	= bgacc2listidx,
		@randserial		= randserial
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @anireplistidx anireplistidx, @invenaccmax invenaccmax, @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial randserial

	select
		@aniinvenkind	= invenkind,
		@aniitemcode	= itemcode,
		@anifieldidx	= fieldidx,
		@acc1			= acc1,
		@acc2			= acc2
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @anilistidx_
	--select 'DEBUG 3-2-2 동물정보', @anilistidx_ anilistidx_, @aniinvenkind aniinvenkind, @aniitemcode aniitemcode, @anifieldidx anifieldidx, @acc1 acc1, @acc2 acc2

	select
		@acc1invenkind	= invenkind,
		@acc1itemcode	= itemcode
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc1listidx_
	--select 'DEBUG 3-2-3 악세정보1', @acc1listidx_ acc1listidx_, @acc1invenkind acc1invenkind, @acc1itemcode acc1itemcode

	select
		@acc2invenkind	= invenkind,
		@acc2itemcode	= itemcode
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc2listidx_
	--select 'DEBUG 3-2-4 악세정보1', @acc2listidx_ acc2listidx_, @acc2invenkind acc2invenkind, @acc2itemcode acc2itemcode

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			----select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 액세해제 했습니다.(이미:랜덤씨리어이동일함)'
			--select 'DEBUG ' + @comment
		END
	else if (@acc1listidx_ = @ACC_STATE_KEEP and @acc2listidx_ = @ACC_STATE_KEEP)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 액세를 유지한다.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx		= -1
			----select 'DEBUG ' + @comment
		END
	else if ((@acc1 = -1 and @acc1listidx_ in (@ACC_STATE_STRIP, @ACC_STATE_KEEP)) and (@acc2 = -1 and @acc2listidx_ in (@ACC_STATE_STRIP, @ACC_STATE_KEEP)))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 액세를 없는것을 유지, 뺀다 것은 패스.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx 		= -1
			--select 'DEBUG ' + @comment
		END
	else if ( (@acc1listidx_ = @ACC_STATE_KEEP and @acc2 = -1 and @acc2listidx_ = @ACC_STATE_STRIP)
			or (@acc2listidx_ = @ACC_STATE_KEEP and @acc1 = -1 and @acc1listidx_ = @ACC_STATE_STRIP))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 액세를 없는것을 유지 것은 패스.'

			set @bgacc1listidxdel 	= -1
			set @bgacc2listidxdel 	= -1
			set @bgacc1listidx 		= -1
			set @bgacc2listidx 		= -1
			--select 'DEBUG ' + @comment
		END
	else if (@aniinvenkind != @USERITEM_INVENKIND_ANI or @aniitemcode = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 동물 존재 하지 않습니다.'
			--select 'DEBUG ' + @comment
		END
	else if ((@acc1listidx_ >= 0 and @acc1itemcode < 0) or (@acc2listidx_ >= 0 and @acc2itemcode < 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 교체 악세사리가 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if ((@acc1listidx_ >= 0 and @acc1invenkind != @USERITEM_INVENKIND_ACC) or (@acc2listidx_ >= 0 and @acc2invenkind != @USERITEM_INVENKIND_ACC))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 악세리스트 번호가 아님.'
			--select 'DEBUG ' + @comment
		END
	else if (@acc1listidx_ != -1 and @acc1listidx_ = @acc2listidx_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 악세가 같은 것을 세팅할려고함.'
			--select 'DEBUG ' + @comment
		END
	else if (@anifieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 동물이 병원에 존재함..'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 악세 세팅합니다.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- 액세					-> 수량파악
			--------------------------------------------------------------
			select
				@invencnt = count(*)
			from dbo.tFVUserItem
			where gameid = @gameid_
				and invenkind = @invenkind
				and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
			set @invencnt = @invencnt + case when (@acc1 != -1 and @acc1listidx_ = @ACC_STATE_STRIP) then 1 else 0 end
			set @invencnt = @invencnt + case when (@acc2 != -1 and @acc2listidx_ = @ACC_STATE_STRIP) then 1 else 0 end
			set @invencnt = @invencnt - case when (@acc1 = -1 and @acc1listidx_ >= 0) then 1 else 0 end
			set @invencnt = @invencnt - case when (@acc2 = -1 and @acc2listidx_ >= 0) then 1 else 0 end
			--select 'DEBUG 4-4 액세(4)인벤넣기', @invencnt invencnt, @invenaccmax invenaccmax

			if(@invencnt > @invenaccmax)
				begin
					set @nResult_ = @RESULT_ERROR_INVEN_FULL
					set @comment = 'ERROR 액세 인벤이 풀입니다.'
					--select 'DEBUG ' + @comment, @invenaccmax invenaccmax
				end
			else
				begin
					-----------------------------------------
					-- 1-1. 악세사리 넣어주기.
					-----------------------------------------
					set @acc1bg1 = @acc1
					set @acc2bg1 = @acc2
					set @bgacc1listidxdel = case when (@acc1listidx_ >= 0) then @acc1listidx_ else -1 end
					set @bgacc2listidxdel = case when (@acc2listidx_ >= 0) then @acc2listidx_ else -1 end

					if(@acc1listidx_ >= 0)
						begin
							--select 'DEBUG 머리 악세 세팅(전)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode

							set @acc1 = @acc1itemcode

							delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc1listidx_
							--select 'DEBUG 머리 악세 세팅(후)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode
						end
					else if(@acc1listidx_ = @ACC_STATE_STRIP)
						begin
							--select 'DEBUG 머리 악세 벗기'
							set @acc1 = -1
						end

					if(@acc2listidx_ >= 0)
						begin
							--select 'DEBUG 등, 옆구리 악세 세팅(전)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode

							set @acc2 = @acc2itemcode

							delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @acc2listidx_
							--select 'DEBUG 등, 옆구리 악세 세팅(후)', @acc1 acc1, @acc2 acc2, @acc1itemcode acc1itemcode, @acc2itemcode acc2itemcode
						end
					else if(@acc2listidx_ = @ACC_STATE_STRIP)
						begin
							--select 'DEBUG 등, 옆구리 악세 벗기'
							set @acc2 = -1
						end

					-----------------------------------------
					-- 1-2. 세팅값을 직접 넣어준다.
					-----------------------------------------
					----select 'DEBUG 아이템 받은 것으로 세팅'
					update dbo.tFVUserItem
						set
							acc1 	= @acc1,
							acc2	= @acc2
					where gameid = @gameid_ and listidx = @anilistidx_


					-----------------------------------------
					--	2. 빼기, 교체  > 인벤에 넣어주기.
					-----------------------------------------
					set @acc1bg2 = @acc1
					set @acc2bg2 = @acc2
					set @acc1 = @acc1bg1
					set @acc2 = @acc2bg1

					select @listidxnew = isnull(MAX(listidx), 0) from dbo.tFVUserItem where gameid = @gameid_
					--select 'DEBUG 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew

					--select 'DEBUG 머리 액세검사', @acc1 acc1, @acc1listidx_ acc1listidx_
					set @bgacc1listidx = -1
					if(@acc1 != -1 and @acc1listidx_ != @ACC_STATE_KEEP)
						begin
							set @listidxnew 	= @listidxnew + 1
							set @bgacc1listidx 	= @listidxnew
							--select 'DEBUG  > 머리 액세빼기, 교체', @gameid_ gameid_, @bgacc1listidx bgacc1listidx

							insert into dbo.tFVUserItem(gameid,         listidx, itemcode,  invenkind,  randserial,   gethow)		-- 액세
							values(					 @gameid_, @bgacc1listidx,    @acc1, @invenkind, @randserial_, @DEFINE_HOW_GET_ACCSTRIP)
						end

					--select 'DEBUG 등 액세검사', @acc2 acc2, @acc2listidx_ acc2listidx_
					set @bgacc2listidx = -1
					if(@acc2 != -1 and @acc2listidx_ != @ACC_STATE_KEEP)
						begin
							set @listidxnew 	= @listidxnew + 1
							set @bgacc2listidx 	= @listidxnew
							--select 'DEBUG  > 등 액세빼기, 교체', @gameid_ gameid_, @bgacc2listidx bgacc2listidx

							insert into dbo.tFVUserItem(gameid,         listidx, itemcode,  invenkind,  randserial,   gethow)		-- 액세
							values(					 @gameid_, @bgacc2listidx,    @acc2, @invenkind, @randserial_, @DEFINE_HOW_GET_ACCSTRIP)
						end


					-----------------------------------------
					-- 대표동물에게 악세사리 장착
					-----------------------------------------
					if(@anireplistidx = @anilistidx_)
						begin
							--select 'DEBUG 대표동물 분리', @acc1 acc1, @acc2 acc2, @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial_ randserial_
							update dbo.tFVUserMaster
								set
									anirepacc1		= @acc1,
									anirepacc2		= @acc2,
									bgacc1listidxdel= @bgacc1listidxdel,
									bgacc2listidxdel= @bgacc2listidxdel,
									bgacc1listidx	= @bgacc1listidx,
									bgacc2listidx	= @bgacc2listidx,
									randserial		= @randserial_
							where gameid = @gameid_
						end
					else
						begin
							--select 'DEBUG 일반동물 분리', @bgacc1listidx bgacc1listidx, @bgacc2listidx bgacc2listidx, @randserial_ randserial_
							update dbo.tFVUserMaster
								set
									bgacc1listidxdel= @bgacc1listidxdel,
									bgacc2listidxdel= @bgacc2listidxdel,
									bgacc1listidx	= @bgacc1listidx,
									bgacc2listidx	= @bgacc2listidx,
									randserial		= @randserial_
							where gameid = @gameid_
						end


					set @acc1 = @acc1bg2
					set @acc2 = @acc2bg2
				end
		END

	--------------------------------------------------------------
	-- 결과리턴.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @anilistidx_ anilistidx, @acc1 acc1, @acc2 acc2, @bgacc1listidxdel bgacc1listidxdel, @bgacc2listidxdel bgacc2listidxdel
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 동물 정보 > 안보내줌..
			--select * from dbo.tFVUserItem where gameid = @gameid_ and listidx = @anilistidx_

			-- 액세리스트.
			select * from dbo.tFVUserItem where gameid = @gameid_ and listidx in (@bgacc1listidx, @bgacc2listidx)
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

