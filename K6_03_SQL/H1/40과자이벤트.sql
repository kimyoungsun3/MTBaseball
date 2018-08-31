/*
exec sup_CheckCertNo 'supermano', '1111222233334444'	-- 아이디 존재안함
exec sup_CheckCertNo 'superman7', '1111222233334444'	-- 인증번호 존재안함
exec sup_CheckCertNo 'superman7', 'E72FAB4D490748A7'	-- 처음에는 정상, 나중에는 오류

select top 10 * from dbo.tEventCertNo where certused = 0
exec sup_CheckCertNo 'superman7', '3478D1B0CD4C4AEA'

9AF2CE4034A0460E
7F02D797934045BB
F612E90E82A14BC6
EBDC87F56CF54DFA
F598626B6C254653
05DD08D71BAE4735

exec sup_CheckCertNo 'sususu2', '3478D1B0CD4C4AEA'
exec sup_CheckCertNo 'sususu2', 'HOMERUNLEAGUE013'
*/


IF OBJECT_ID ( 'dbo.sup_CheckCertNo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.sup_CheckCertNo;
GO

create procedure dbo.sup_CheckCertNo
	@gameid_				varchar(20),
	@certno_				varchar(16)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -2
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -3
	declare @RESULT_ERROR_USED_CERTNO			int				set @RESULT_ERROR_USED_CERTNO			= -4
	declare @RESULT_ERROR_USED_ALREADY_GIVE		int				set @RESULT_ERROR_USED_ALREADY_GIVE		= -5

	declare @nResult_							int				set @nResult_							= @RESULT_ERROR

	declare @GIFT_ITEM_CODE						int 			set @GIFT_ITEM_CODE						= 9305	-- 선물(10골드)
	declare @GIFT_ITEM_NAME						varchar(40)		set @GIFT_ITEM_NAME						= '야구야놀자'

	declare @BOJI_NO							varchar(40)		set @BOJI_NO							= 'HOMERUNLEAGUE013'
	declare @BOJI_ITEMCODE						int				set @BOJI_ITEMCODE						= 100

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @certused		int
	declare @comment		varchar(128)
	declare @dateid 		varchar(8)				set @dateid 		= Convert(varchar(8),Getdate(),112)		-- 20120819

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 1-1 ', @gameid_ gameid_, @certno_ certno_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 정보 얻기
	select
		@gameid			= gameid
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG 1-2 ', @gameid gameid


	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(@certno_ = @BOJI_NO)
		begin
			if(isnull(@gameid, '') = '')
				begin
					-- 아이디가 존재하지않는가??
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					set @comment = 'ERROR 아이디를 찾지 못했습니다.'
					--select 'DEBUG 2-1 ', @comment
				end
			else if(exists(select top 1 * from dbo.tEventCertUser where gameid = @gameid_))
				begin
					set @nResult_ = @RESULT_ERROR_USED_ALREADY_GIVE
					set @comment = 'ERROR 봉지를 이미 지급했습니다.'
					--select 'DEBUG 3-1 ', @comment
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS 정상처리하다.(2입력)'
					----select 'DEBUG 5-1 ', @comment

					--------------------------------------
					-- 유저 > 선물로 10Gold지급
					--------------------------------------
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2)
					values(@gameid_ , @GIFT_ITEM_CODE, @GIFT_ITEM_NAME, -1)

					insert into tMessage(gameid, comment)
					values(@gameid_, '초코야놀자 황금뽑기 지급완료(상점 > 황금뽑기)' )

					--------------------------------------
					-- 봉지 지급상태로 변경
					--------------------------------------
					insert into dbo.tEventCertUser(gameid) values(@gameid_)

					---------------------------------------------------
					-- 토탈 기록하기
					---------------------------------------------------
					if(exists(select top 1 * from dbo.tEventCertNoLogTotal where dateid = @dateid))
						begin
							update dbo.tEventCertNoLogTotal
								set
									cnt = cnt + 1
							where dateid = @dateid
						end
					else
						begin
							insert into dbo.tEventCertNoLogTotal(dateid, cnt)
							values(@dateid, 1)
						end
				end
		end
	else
		begin
			-- 인증정보 얻기
			select
				@certused = certused
			from dbo.tEventCertNo where certno = @certno_
			--select 'DEBUG 1-3 ', @certused certused

			if(isnull(@gameid, '') = '')
				begin
					-- 아이디가 존재하지않는가??
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					set @comment = 'ERROR 아이디를 찾지 못했습니다.'
					--select 'DEBUG 2-1 ', @comment
				end
			else if(isnull(@certused, -1) = -1)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_CERTNO
					set @comment = 'ERROR 인증번호가 존재안합니다.'
					--select 'DEBUG 3-1 ', @comment
				end
			else if(isnull(@certused, -1) = 1)
				begin
					set @nResult_ = @RESULT_ERROR_USED_CERTNO
					set @comment = 'ERROR 인증번호가 이미 사용된것입니다.'
					--select 'DEBUG 4-1 ', @comment
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS 정상처리하다.(2입력)'
					----select 'DEBUG 5-1 ', @comment

					--------------------------------------
					-- 유저 > 선물로 10Gold지급
					--------------------------------------
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2)
					values(@gameid_ , @GIFT_ITEM_CODE, @GIFT_ITEM_NAME, -1)

					insert into tMessage(gameid, comment)
					values(@gameid_, '초코야놀자 황금뽑기 지급완료(상점 > 황금뽑기)' )

					--------------------------------------
					-- 인증번호 > 사용상태로 변경(사용여부, 아이디, 사용날짜)
					--------------------------------------
					update dbo.tEventCertNo
						set
							certused 	= 1,
							gameid 		= @gameid,
							usedtime	= getdate()
					where certno = @certno_

					---------------------------------------------------
					-- 토탈 기록하기
					---------------------------------------------------
					if(exists(select top 1 * from dbo.tEventCertNoLogTotal where dateid = @dateid))
						begin
							update dbo.tEventCertNoLogTotal
								set
									cnt = cnt + 1
							where dateid = @dateid
						end
					else
						begin
							insert into dbo.tEventCertNoLogTotal(dateid, cnt)
							values(@dateid, 1)
						end
				end
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	set nocount off
End

