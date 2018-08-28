/*
update dbo.tUserMaster set trade0 = 0, trade1 = 1, trade2 = 2, trade3 = 3, trade4 = 4, trade5 = 5, trade6 = 6 where gameid = 'xxxx2'
exec spu_TradeChange 'xxxx2', '049000s1i0n7t8445289', '0:0;1:1;2:2;3:3;4:4;5:5;6:6;', -1		-- 기본
exec spu_TradeChange 'xxxx2', '049000s1i0n7t8445289', '0:7;1:8;2:9;3:10;4:11;5:12;6:13;', -1	-- 신규
exec spu_TradeChange 'xxxx2', '049000s1i0n7t8445289', '0:1;1:1;2:1;3:1;4:1;5:1;6:1;', -1		-- 잘못된것.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_TradeChange', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TradeChange;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_TradeChange
	@gameid_								varchar(20),
	@password_								varchar(20),
	@tradeinfo_								varchar(1024),
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
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @trade0				tinyint			set @trade0			= 0
	declare @trade1				tinyint			set @trade1			= 1
	declare @trade2				tinyint			set @trade2			= 2
	declare @trade3				tinyint			set @trade3			= 3
	declare @trade4				tinyint			set @trade4			= 4
	declare @trade5				tinyint			set @trade5			= 5
	declare @trade6				tinyint			set @trade6			= 6

	declare @kind				int,
			@info				int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @tradeinfo_ tradeinfo_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 보유캐쉬
	select
		@gameid 		= gameid,
		@trade0			= trade0,
		@trade1			= trade1,
		@trade2			= trade2,
		@trade3			= trade3,
		@trade4			= trade4,
		@trade5			= trade5,
		@trade6			= trade6
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @trade0 trade0, @trade1 trade1, @trade2 trade2, @trade3 trade3, @trade4 trade4, @trade5 trade5, @trade6 trade6

	------------------------------------------------
	--	3-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 상인변경을 지원합니다.'

			if(LEN(@tradeinfo_) >= 3)
				begin
					-- 1. 커서 생성
					declare curParamInfo Cursor for
					select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @tradeinfo_)

					-- 2. 커서오픈
					open curParamInfo

					-- 3. 커서 사용
					Fetch next from curParamInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = 0)
								begin
									set @trade0 		= case when @info in (0, 7) then @info else 0 end
								end
							else if(@kind = 1)
								begin
									set @trade1 		= case when @info in (1, 8) then @info else 1 end
								end
							else if(@kind = 2)
								begin
									set @trade2 		= case when @info in (2, 9) then @info else 2 end
								end
							else if(@kind = 3)
								begin
									set @trade3 		= case when @info in (3, 10) then @info else 3 end
								end
							else if(@kind = 4)
								begin
									set @trade4 		= case when @info in (4, 11) then @info else 4 end
								end
							else if(@kind = 5)
								begin
									set @trade5 		= case when @info in (5, 12) then @info else 5 end
								end
							else if(@kind = 6)
								begin
									set @trade6 		= case when @info in (6, 13) then @info else 6 end
								end
							Fetch next from curParamInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curParamInfo
					Deallocate curParamInfo
					--select 'DEBUG 입력정보(paraminfo)', @trade0 trade0, @trade1 trade1, @trade2 trade2, @trade3 trade3, @trade4 trade4, @trade5 trade5, @trade6 trade6
				end

		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				trade0			= @trade0,
				trade1			= @trade1,
				trade2			= @trade2,
				trade3			= @trade3,
				trade4			= @trade4,
				trade5			= @trade5,
				trade6			= @trade6
			where gameid = @gameid_

			-- 정보출력.
			select @trade0 trade0, @trade1 trade1, @trade2 trade2, @trade3 trade3, @trade4 trade4, @trade5 trade5, @trade6 trade6
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



