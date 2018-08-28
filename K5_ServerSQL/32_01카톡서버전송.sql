/*
-- select * from dbo.tCashLogKakaoSend				select kakaosend, cashcost, cash, market, kakaogameid, kakaouk, * from dbo.tCashLog order by idx asc
-- update dbo.tCashLogKakaoSend set checkidx = 0	update dbo.tCashLog set kakaosend = -1, kakaogameid = '88258263875124913' where gameid = 'xxxx2' and kakaosend = 1
-- update dbo.tCashLogKakaoSend set checkidx = 0	update dbo.tCashLog set kakaosend = -1 where gameid = 'guest180' and kakaosend = 1
exec spu_KakaoPayment 1, -1,  '', '', -1							-- 검색
exec spu_KakaoPayment 2, 131, '128, 129, 130, 131', '127', -1		-- 전송완료
exec spu_KakaoPayment 2, 136, '132, 133, 134, 135, 136', '', -1
exec spu_KakaoPayment 2, 138, '137, 138', '', -1
exec spu_KakaoPayment 2,  -1, '', '', -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_KakaoPayment', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_KakaoPayment;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_KakaoPayment
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(1024),
	@paramerr_								varchar(1024),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 친구검색, 추가, 삭제
	declare @KAKAO_MODE_LIST					int					set	@KAKAO_MODE_LIST						= 1;
	declare @KAKAO_MODE_SENDED					int					set	@KAKAO_MODE_SENDED						= 2;

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @cnt			int						set @cnt 			= 0
	declare @senddate		datetime				set @senddate		= getdate()


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if (@mode_ not in (@KAKAO_MODE_LIST, @KAKAO_MODE_SENDED))
		BEGIN
			set @nResult_ 	= -1
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		END
	else if (@mode_ = @KAKAO_MODE_LIST)
		BEGIN
			------------------------------------------
			-- 유저검색.
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 검색리스트'

			----------------------------------
			-- 데이타 검색.
			----------------------------------
			select top 50 * from dbo.tCashLog
			where idx > isnull((select top 1 checkidx from dbo.tCashLogKakaoSend order by checkidx desc), 0)
			and kakaosend = -1
			order by idx asc
		END
	else if (@mode_ = @KAKAO_MODE_SENDED)
		BEGIN
			------------------------------------------
			-- .
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 반영완료.'

			------------------------------------------
			-- .
			------------------------------------------
			-- 2-1. 마킹하기.
			if(@paramint_ = -1 or LEN(@paramstr_) < 1)
				begin
					-- 패스용.
					set @paramint_ = -1
				end
			else
				begin
					if(not exists(select top 1 * from dbo.tCashLogKakaoSend))
						begin
							insert into dbo.tCashLogKakaoSend(checkidx) values(@paramint_)
						end
					else
						begin
							update dbo.tCashLogKakaoSend set checkidx = @paramint_
						end

					-- 2-2. (문자열을 sql 작동하기.
					EXECUTE('update dbo.tCashLog set kakaosend = 1 where idx in (' + @paramstr_ + ')')
				end

			if(LEN(@paramerr_) >= 1)
				begin
					-- 2-2. (문자열을 sql 작동하기.
					EXECUTE('update dbo.tCashLog set kakaosend = -444 where idx in (' + @paramerr_ + ')')
				end

		END
	else
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 알수없는 오류(-1)'
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

