/*
-- select top 20 * from dbo.tFVEventCertNo
-- delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'D832ACF8DC56480F', -1	-- 아이디 존재안함

--delete from dbo.tFVGiftList where gameid in ('farm83837225', 'xxxx2')
--update dbo.tFVUserMaster set eventspot06 = 0 where gameid in ('farm83837225', 'xxxx2')
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'LSYOARPUSSDGG796', -1	-- 쿠폰 이벤트.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'lsYoarpussdgg796', -1	-- 쿠폰 이벤트.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'Lsyoarpussdgg796', -1	-- 쿠폰 이벤트.
exec spu_FVCheckCertNo 'xxxx2',        '049000s1i0n7t8445289', 'LSYOARPUSSDGG796', -1	-- 쿠폰 이벤트x.
exec spu_FVCheckCertNo 'farm83837225', '9164161y5c1d8y944779', 'lsyoarpussdgg796', -1	-- 쿠폰 이벤트.

exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'A1D7EF80D0B44F64', -1	-- 쿠폰 이벤트.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', '7B92619E3AEB468D', -1
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', '3758F8A00A8E4D2D', -1
*/
use Farm
GO


IF OBJECT_ID ( 'dbo.spu_FVCheckCertNo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCheckCertNo;
GO

create procedure dbo.spu_FVCheckCertNo
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@certno_								varchar(16),
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- 쿠폰 번호가 없음.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- 쿠폰은 1인 1매.

	--declare @MARKET_SKT						int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	--declare @MARKET_GOOGLE					int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	--declare @MARKET_IPHONE					int					set @MARKET_IPHONE					= 7

	-------------------------------------------------------------------
	-- [짜요 목장이야기 설문조사]
	-- 기간			: 2014-05-23 00:01 ~ 2014-05-31 23:59
	-- 이벤트 내용 	: 설문조사(1회만 지급함)
	-- 쿠폰번호		: LSYOARPUSSDGG796
	--                lsyoarpussdgg796
	--                Lsyoarpussdgg796
	-- 리워드 		: 부활석 10개 (1205)
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON			= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES			= 1
	declare @EVENT06_START_DAY					datetime			set @EVENT06_START_DAY			= '2014-05-23 00:01'
	declare @EVENT06_END_DAY					datetime			set @EVENT06_END_DAY			= '2014-05-31 23:59'
	declare @EVENT06_CHECK_ITEM					varchar(16)			set @EVENT06_CHECK_ITEM			= 'LSYOARPUSSDGG796'
	declare @EVENT06_REWARD_ITEM				int					set @EVENT06_REWARD_ITEM		= 1205
	declare @EVENT06_REWARD_NAME				varchar(20)			set @EVENT06_REWARD_NAME		= '설문보상'

	declare @EVENT07_KIND_KUPANG				int					set @EVENT07_KIND_KUPANG		= 7		-- 쿠팡에 지급한 5만건.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 1
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1
	declare @kind			int						set @kind			= 0
	declare @comment		varchar(128)			set @comment		= ''
	declare @certno			varchar(16)				set @certno			= ''

	declare @eventspot06	int						set @eventspot06 	= @EVENT_STATE_NON
	declare @curdate		datetime				set @curdate		= getdate()
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @certno_ certno_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 정보 얻기
	select
		@gameid			= gameid,
		@market			= market,
		@eventspot06	= eventspot06
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @market market, @eventspot06 eventspot06

	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	select
		@itemcode1	= itemcode1,
		@itemcode2	= itemcode2,
		@itemcode3	= itemcode3,
		@certno		= certno,
		@kind		= kind
	from dbo.tFVEventCertNo where certno = @certno_
	--select 'DEBUG ', @certno_ certno_, @kind kind

	if(@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 2-1 ', @comment
		end
	else if(@certno_ = @EVENT06_CHECK_ITEM)
		begin
			-- 공통쿠폰 이벤트.
			if(@eventspot06 = @EVENT_STATE_YES)
				begin
					set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD
					set @comment 	= 'SUCCESS 공통쿠폰 정상처리하다(이미지급).'
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 공통쿠폰 정상처리하다(새로지급2).'

					---------------------------------------------------
					-- 유저 > 선물지급(없으면 자동 패스됨)
					---------------------------------------------------
					exec spu_FVSubGiftSend 2, @EVENT06_REWARD_ITEM, @EVENT06_REWARD_COUNT, @EVENT06_REWARD_NAME, @gameid, ''


					--------------------------------------
					-- 인증번호 > 사용상태로 변경
					--------------------------------------
					update dbo.tFVUserMaster
						set
							eventspot06	= @EVENT_STATE_YES
					where gameid = @gameid_

					---------------------------------------------------
					-- 토탈 기록하기
					---------------------------------------------------
					exec spu_FVDayLogInfoStatic @market, 41, 1				-- 일 쿠폰등록수
				end
		end
	else if(@kind >= @EVENT07_KIND_KUPANG and exists(select top 1 * from dbo.tFVEventCertNoBack where gameid = @gameid and kind = @kind))
		begin
			set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD_COUPON
			set @comment 	= 'SUCCESS 1인 1매만 지급됩니다.(이미지급).'
			--select 'DEBUG 3-1 ', @comment
		end
	else if(@certno = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_CERTNO
			set @comment 	= 'ERROR 인증번호가 존재안합니다.(1)'
			--select 'DEBUG 3-1 ', @comment
		end
	else
		begin
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 정상처리하다(새로지급1).'
			--select 'DEBUG 5-1 ', @comment

			--------------------------------------
			-- 유저 > 선물지급(없으면 자동 패스됨)
			--------------------------------------
			if(@itemcode1 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode1, 'SysCert', @gameid, ''
				end

			if(@itemcode2 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode2, 'SysCert', @gameid, ''
				end

			if(@itemcode3 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode3, 'SysCert', @gameid, ''
				end

			--------------------------------------
			-- 인증번호 > 사용상태로 변경(사용여부, 아이디, 사용날짜)
			--------------------------------------
			delete from dbo.tFVEventCertNo where certno = @certno_

			insert into dbo.tFVEventCertNoBack(certno,   gameid,   itemcode1,  itemcode2,  itemcode3,  kind)
			values(                         @certno_, @gameid_, @itemcode1, @itemcode2, @itemcode3, @kind)


			---------------------------------------------------
			-- 토탈 기록하기
			---------------------------------------------------
			exec spu_FVDayLogInfoStatic @market, 41, 1				-- 일 쿠폰등록수
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	set nocount off
End

