use Farm
Go
/*

select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
select * from dbo.tFVUserData
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 0, 1, '', 'skt11savetest',    -1			-- 세이브모드. (랭킹없음)
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 1, '', 'skt11savetest',    -1			-- 세이브모드. (랭킹있음)
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '', 'google22savetest', -1			-- 세이브모드.
select * from dbo.tFVUserData where gameid = 'xxxx@gmail.com' and market in (1, 5)


         판매금액          보유동물중최고   보유금액        보유VIP         무료룰렛       유료룰렛횟수(없으면0, 있으면 1이상)
userinfo=salemoney;        bestani;	   	    cashcost2		vippoint2		roulette2      roulettepaycnt2
		   0:123;          1:500;           10:0;           11:0;           20:-1;          21:0;                                         <= 클라전송
		 100:123;          1:500;           10:0;           11:0;           20:-1;          21:1;                                          <= 추출용

exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;         20:-1;          21:0;', 'google22savetest',  -1		-- 누적방식
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;         20:-1;          21:1;', 'google22savetest',  -1		-- 토탈방식
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '0:0;1:500;10:0;11:0;', 'google22savetest',  -1

select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;   20:-1', 'google22savetest',  -1		-- 누적방식
select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
update dbo.tUserMaster set savebktime = getdate() - 10 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'google22savetest',  -1		-- 토탈방식
select salemoney2 from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save11',  -1
update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save12',  -1
update dbo.tUserMaster set savebktime = getdate() - 1 where gameid = 'PC14DAE9EC6A77'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;   20:-1;', 'save13',  -1
select * from dbo.tFVUserDataBackup where gameid = 'xxxx@gmail.com' order by idx2 desc


*/

IF OBJECT_ID ( 'dbo.spu_FVSave3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSave3;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSave3
	@gameid_								varchar(60),				-- 게임아이디
	@phone_									varchar(20),
	@mode_									int,
	@market_								int,
	@userinfo_								varchar(1024),				-- 전달하고 싶은 값들...
	@savedata_								varchar(4096),
	@nResult_								int					OUTPUT
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

	-- 세이브 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 세이브값종류
	declare @SAVE_USERINFO_SALEMONEY			int				set @SAVE_USERINFO_SALEMONEY			= 0
	declare @SAVE_USERINFO_BESTANI				int				set @SAVE_USERINFO_BESTANI				= 1
	declare @SAVE_USERINFO_CASHCOST2			int				set @SAVE_USERINFO_CASHCOST2			= 10
	declare @SAVE_USERINFO_VIPPOINT2			int				set @SAVE_USERINFO_VIPPOINT2			= 11
	declare @SAVE_USERINFO_ROULETTE2			int				set @SAVE_USERINFO_ROULETTE2			= 20
	declare @SAVE_USERINFO_ROULETTEPAYCNT2		int				set @SAVE_USERINFO_ROULETTEPAYCNT2		= 21
	--declare @SAVE_USERINFO_SALEMONEY3			int				set @SAVE_USERINFO_SALEMONEY3			= 100
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '세이브'

	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @phone 					varchar(20)
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @savebktime				datetime				set @savebktime 	= getdate()
	declare @idx2 					int 					set @idx2 			= 1

	declare @kind					int,
			@info					bigint
	declare @salemoney2				bigint					set @salemoney2		= 0
	declare @salemode				int						set @salemode		= 3
	declare @bestani2				int						set @bestani2		= 500
	declare @cashcost2				bigint					set @cashcost2		= 0
	declare @vippoint2				int						set @vippoint2		= 0
	declare @roulette2				int						set @roulette2		= -444
	declare @roulettepaycnt2		int						set @roulettepaycnt2= 0

	declare @userrankview			int						set @userrankview	= -1 -- 안보임(-1), 보임(1)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @phone_ phone_, @savedata_ savedata_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@savebktime		= savebktime
	from dbo.tUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG 유저정보', @gameid gameid, @savebktime savebktime

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			----select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '세이브 정상처리'
			----select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- 세이브 정보 > 금액빼기.
			-----------------------------------------------------------------
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

			---------------------------------------------------
			-- 판매수익과 대표동물저장 > 파싱.
			---------------------------------------------------
			----select 'DEBUG ', @userinfo_ userinfo_
			if(LEN(@userinfo_) >= 3)
				begin
					-- 1. 커서 생성
					declare curUserInfo Cursor for
					select fieldidx, listidx FROM dbo.fnu_SplitTwoBigint(';', ':', @userinfo_)

					-- 2. 커서오픈
					open curUserInfo

					-- 3. 커서 사용
					Fetch next from curUserInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = @SAVE_USERINFO_SALEMONEY)
								begin
									set @salemode		= 2
									set @salemoney2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_BESTANI)
								begin
									set @bestani2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_CASHCOST2)
								begin
									set @cashcost2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_VIPPOINT2)
								begin
									set @vippoint2	 	= @info
								end
							--else if(@kind = @SAVE_USERINFO_SALEMONEY3)
							--	begin
							--		set @salemode		= 3
							--		set @salemoney2	 	= @info
							--	end
							else if(@kind = @SAVE_USERINFO_ROULETTE2)
								begin
									set @roulette2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_ROULETTEPAYCNT2)
								begin
									set @roulettepaycnt2= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curUserInfo
					Deallocate curUserInfo
					--select 'DEBUG 입력정보(useinfo)', @salemoney2 salemoney2, @bestani2 bestani2, @cashcost2 cashcost2, @vippoint2 vippoint2
				end

			----------------------------------------------
			-- 세이브 정보 백업 (6시간).
			----------------------------------------------
			if(@savebktime < (getdate() - 0.25))
				begin
					--select 'DEBUG 세이브 정보 백업'
					-- 번호를 업기.
					select @idx2 = isnull(max(idx2), 0) + 1
					from dbo.tFVUserDataBackup
					where gameid = @gameid_ and market = @market_

					-- 기록하기.
					insert into dbo.tFVUserDataBackup(gameid,   market,  idx2,  savedata)
					values(                          @gameid_, @market_, @idx2, @savedata_)

					-- 일정 수량 이상이면 삭제하기.
					delete from dbo.tFVUserDataBackup where gameid = @gameid_ and market = @market_ and idx2 < @idx2 - 20

					set @savebktime = getdate()
				end


			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tUserMaster
				set
					savebktime		= @savebktime,
					ownercashcost	= @ownercashcost,
					salemoney2 	= case
									when (@salemode = 2) then (salemoney2 + @salemoney2)
									when (@salemode = 3) then (             @salemoney2)
									else                       salemoney2
								  end,
					bestani			= @bestani2,
					cashcost2		=               	case when (@cashcost2 > cashcost2) then @cashcost2 else cashcost2     	end,
					vippoint2		=               	case when (@vippoint2 > vippoint2) then @vippoint2 else vippoint2     	end,
					roulette		=               	case when (@roulette2 = -1)		   				then -1         else roulette      	end,
					roulettefreecnt	= roulettefreecnt +	case when (@roulette2 = -1 and roulette = 1)	then  1         else 0             	end,
					roulettepaycnt	= roulettepaycnt + 	case when (@roulettepaycnt2 <= 0)  				then  0         else @roulettepaycnt2 end
			from dbo.tUserMaster
			where gameid = @gameid_

			----------------------------------------------
			-- 통계정보.
			----------------------------------------------
			if(@roulettepaycnt2 > 0)
				begin
					exec spu_FVDayLogInfoStatic @market_, 61, @roulettepaycnt2				  -- 일 유료룰렛수
				end

			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserData where gameid = @gameid_ and market = @market_))
				begin
					insert into dbo.tFVUserData(gameid,   market,  savedata)
					values(                    @gameid_, @market_, @savedata_)
				end
			else
				begin
					update dbo.tFVUserData
						set
							savedata = @savedata_
					where gameid = @gameid_ and market = @market_
				end

		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			----------------------------------------------
			-- 랭킹보기?
			---------------------------------------------
			select @userrankview = userrankview from dbo.tFVUserRankView where idx = 1

			--------------------------------------------------------------
			-- 유저 전체랭킹
			-- 0 > 안보여줌
			-- 1 > 보여줌
			--------------------------------------------------------------
			if(@mode_ = 1 and @userrankview = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end


		END
	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



