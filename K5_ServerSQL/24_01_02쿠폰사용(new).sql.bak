/*
delete from dbo.tGiftList where gameid in ( 'xxxx2', 'xxxx3' )
delete from dbo.tEventCertNoBack where gameid in ( 'xxxx2', 'xxxx3' )
select top 20 * from dbo.tEventCertNo
select top 20 * from dbo.tEventCertNoBack

-- 1인형 쿠폰.
exec sup_CheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'PERSON1', -1	-- 1회용쿠폰.
exec sup_CheckCertNo 'xxxx3', '049000s1i0n7t8445289', 'PERSON1', -1	-- 1회용쿠폰 -> 재사용
exec sup_CheckCertNo 'xxxx3', '049000s1i0n7t8445289', 'PERSON2', -1	-- 1회용쿠폰 -> 다른것

exec sup_CheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'ZZAYO2016FB', -1	-- 공용쿠폰.
exec sup_CheckCertNo 'xxxx3', '049000s1i0n7t8445289', 'ZZAYO2016FB', -1
exec sup_CheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'COMMON2', -1	-- 공용쿠폰 -> 기간만기.
exec sup_CheckCertNo 'xxxx3', '049000s1i0n7t8445289', 'COMMON2', -1

*/
use Game4Farmvill5
GO


IF OBJECT_ID ( 'dbo.sup_CheckCertNo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.sup_CheckCertNo;
GO

create procedure dbo.sup_CheckCertNo
	@gameid_								varchar(20),					-- 게임아이디
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

	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- 쿠폰 번호가 없음.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- 쿠폰은 1인 1매.
	declare @RESULT_ERROR_TIME_PASSED			int				set @RESULT_ERROR_TIME_PASSED			= -160			-- 시간이 지났습니다.

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- 쿠폰의 종류.
	declare @CERTNO_MAINKIND_ONEBYONE			int				set	@CERTNO_MAINKIND_ONEBYONE			= 1	--  1인형(1)
	declare @CERTNO_MAINKIND_COMMON				int				set	@CERTNO_MAINKIND_COMMON				= 2	-- 공용형(2)

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)			set @comment		= ''
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @market			int						set @market			= 1

	declare @certno			varchar(16)				set @certno			= ''
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1
	declare @cnt1			int						set @cnt1			= 0
	declare @cnt2			int						set @cnt2			= 0
	declare @cnt3			int						set @cnt3			= 0
	declare @mainkind		int						set @mainkind		= 1
	declare @kind			int						set @kind			= 1
	declare @startdate		datetime				set @startdate		= getdate() - 1
	declare @enddate		datetime				set @enddate		= getdate() - 1
	declare @curdate		datetime				set @curdate		= getdate()

	declare @gameidused		varchar(20)				set @gameidused		= ''
	declare @certnoused		varchar(16)				set @certnoused		= ''
	declare @mainkindused	int						set @mainkindused	= 1


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
		@gameid		= gameid,		@market		= market
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @market market

	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	select
		@certno		= certno,
		@mainkind	= mainkind,		@kind	= kind,
		@itemcode1	= itemcode1,	@cnt1	= cnt1,
		@itemcode2	= itemcode2,	@cnt2	= cnt2,
		@itemcode3	= itemcode3,	@cnt3	= cnt3,
		@startdate	= startdate, 	@enddate= enddate
	from dbo.tEventCertNo where certno = @certno_
	--select 'DEBUG (미사용정보)', @certno certno, @mainkind mainkind, @kind kind, @itemcode1 itemcode1, @cnt1 cnt1, @itemcode2 itemcode2, @cnt2 cnt2, @itemcode3 itemcode3, @cnt3 cnt3, @startdate startdate, @enddate enddate

	-- 사용정보에서 검색.
	select
		@gameidused		= gameid,
		@certnoused		= certno,
		@mainkindused 	= mainkind
	from dbo.tEventCertNoBack where certno = @certno_
	--select 'DEBUG (사용정보)', @certnoused certnoused, @mainkindused mainkindused

	if( @gameid = '' )
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 2-1 ', @comment
		end
	else if( @mainkindused = @CERTNO_MAINKIND_ONEBYONE and @certnoused != '' )
		begin
			set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD_COUPON
			set @comment 	= 'ERROR 이미 사용한 쿠폰입니다.(1인용 1)'
			--select 'DEBUG 3-1 ', @comment
		end
	else if( @mainkindused = @CERTNO_MAINKIND_COMMON and @certnoused != '' and @gameidused = @gameid_ )
		begin
			set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD
			set @comment 	= 'SUCCESS 이미 사용한 쿠폰입니다.(공용형 2)'
			--select 'DEBUG 3-1 ', @comment
		end
	else if( exists ( select top 1 * from dbo.tEventCertNoBack where certno = @certno_ and gameid = @gameid_ ) )
		begin
			set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD
			set @comment 	= 'SUCCESS 이미 사용한 쿠폰입니다.(공용형 2)(2)'
			--select 'DEBUG 3-1 ', @comment
		end
	else if( @certno = '' )
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_CERTNO
			set @comment 	= 'ERROR 쿠폰번호가 존재안합니다.'
			--select 'DEBUG 3-1 ', @comment
		end
	else if( @curdate < @startdate or @curdate > @enddate )
		begin
			set @nResult_ 	= @RESULT_ERROR_TIME_PASSED
			set @comment 	= 'SUCCESS 기간이 지났습니다.'
			--select 'DEBUG 3-1 ', @comment
		end
	else
		begin
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 정상지급했습니다.'
			--select 'DEBUG 5-1 ', @comment

			--------------------------------------
			-- 유저 > 선물지급(없으면 자동 패스됨)
			--------------------------------------
			if(@itemcode1 != -1)
				begin
					--select 'DEBUG 선물1', @itemcode1 itemcode1, @cnt1 cnt1
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @itemcode1, @cnt1, 'SysCert', @gameid_, ''
				end

			if(@itemcode2 != -1)
				begin
					--select 'DEBUG 선물2', @itemcode2 itemcode2, @cnt2 cnt2
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @itemcode2, @cnt2, 'SysCert', @gameid_, ''
				end

			if(@itemcode3 != -1)
				begin
					--select 'DEBUG 선물3', @itemcode3 itemcode3, @cnt3 cnt3
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @itemcode3, @cnt3, 'SysCert', @gameid_, ''
				end

			--------------------------------------
			-- 1인형은 지급후에 삭제해버림.
			--------------------------------------
			if( @mainkind = @CERTNO_MAINKIND_ONEBYONE )
				begin
					delete from dbo.tEventCertNo where certno = @certno_
				end

			--------------------------------------
			-- 인증번호 > 사용상태로 변경(사용여부, 아이디, 사용날짜)
			--------------------------------------
			insert into dbo.tEventCertNoBack(certno,   gameid,   itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3,  mainkind,  kind)
			values(                         @certno_, @gameid_, @itemcode1, @cnt1, @itemcode2, @cnt2, @itemcode3, @cnt3, @mainkind, @kind)

			---------------------------------------------------
			-- 토탈 기록하기
			---------------------------------------------------
			exec spu_DayLogInfoStatic @market, 41, 1				-- 일 쿠폰등록수
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
			exec spu_GiftList @gameid_
		end

	set nocount off
End

