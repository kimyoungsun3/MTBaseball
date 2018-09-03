use Game4FarmVill3
Go
/*
         보유동물중최고(1)보유금액(10)  보유VIP(11)  최고거래상인(50)		환생횟수		이벤트참여
userinfo=bestani;	   	  cashcost2		vippoint2	 bestdealer2			newstart2		eventrank2
		 1:10001;         10:0;         11:0;        50:1;					99:1;
		 1:10001;         10:50000;     11:0;        50:2;					99:2;
		 1:10001;         10:0;         11:50000;    50:3;					99:3;

update dbo.tFVUserMaster set randserial = -1, bestdealer = 0 where gameid in ('xxxx2')
exec spu_FVSave3 'xxxx2',  '049000s1i0n7t8445289', 1, 0, '1:10001;         10:1;         11:2;        50:3;  ', 'google21savetest', 8771, -1
exec spu_FVSave3 'xxxx2',  '049000s1i0n7t8445289', 1, 1, '1:10002;         10:11;        11:12;       50:13;  ', 'google22savetest', 8772, -1
select * from dbo.tFVUserData where gameid = 'xxxx2' select bestani from dbo.tFVUserMaster where gameid = 'xxxx2'

-- 비과금인데 과금한것처럼 데이타 전송
-- update dbo.tFVUserMaster set cashpoint = 0, vippoint  = 0, cashcost  = 0 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set                vippoint2 = 0, cashcost2 = 0 where gameid = 'xxxx2'
-- delete from dbo.tFVUserUnusualLog2 where gameid = 'xxxx2'
update dbo.tFVUserMaster set randserial = -1, newstart = 0 where gameid = 'xxxx2'
exec spu_FVSave3 'xxxx2',  '049000s1i0n7t8445289', 1, 0, '1:10001;         10:50000;     11:0;        50:1; 99:1;', 'google23savetest',     8772, -1	-- 캐쉬치트
exec spu_FVSave3 'xxxx2',  '049000s1i0n7t8445289', 1, 1, '1:10001;         10:0;         11:50000;    50:1; 99:2;', 'google24savetest',     8773, -1	-- VIP치트

*/

IF OBJECT_ID ( 'dbo.spu_FVSave3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSave3;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSave3
	@gameid_								varchar(60),				-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@researchpoint_							int,
	@userinfo_								varchar(1024),				-- 전달하고 싶은 값들...
	@savedata_								varchar(4096),
	@randserial_							varchar(20),
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
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int				set	@BLOCK_STATE_NO						= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1	-- 블럭상태

	-- 세이브값종류
	declare @SAVE_USERINFO_BESTANI				int				set @SAVE_USERINFO_BESTANI				= 1
	declare @SAVE_USERINFO_CASHCOST2			int				set @SAVE_USERINFO_CASHCOST2			= 10
	declare @SAVE_USERINFO_VIPPOINT2			int				set @SAVE_USERINFO_VIPPOINT2			= 11
	declare @SAVE_USERINFO_BESTDEALER2			int				set @SAVE_USERINFO_BESTDEALER2			= 50
	declare @SAVE_USERINFO_NEWSTART2			int				set @SAVE_USERINFO_NEWSTART2			= 99

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '세이브'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @bestani2				int						set @bestani2		= 10001
	declare @cashcost2				bigint					set @cashcost2		= 0
	declare @vippoint2				int						set @vippoint2		= 0
	declare @bestdealer2			int						set @bestdealer2	= 0
	declare @newstart2				int						set @newstart2		= 0
	declare @newstart				int						set @newstart		= 0
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @blockstate				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @ownercashcostdb		bigint					set @ownercashcostdb= 0
	declare @savebktime				datetime				set @savebktime 	= getdate()
	declare @idx2 					int 					set @idx2 			= 1

	declare @kind					int,
			@info					bigint

	-- 시간체킹
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)

	-- 하트전송.
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	--declare @heartcntmax	int						set @heartcntmax	= 400
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'
	declare @cashpoint		int						set @cashpoint		= 0
	declare @vippoint		int						set @vippoint		= 0

	declare @roulloop		int						set @roulloop		= 0
	declare @roulloop2		int						set @roulloop2		= 0
	declare @adidx			int						set @adidx			= 0
	declare @adidxmax		int						set @adidxmax		= 0
	declare @tmp			int						set @tmp 			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @userinfo_ userinfo_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@adidx		= adidx,
		@blockstate = blockstate,	@ownercashcostdb= ownercashcost,
		@heartget	= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@cashpoint	= cashpoint,	@vippoint	= vippoint,		@newstart	= newstart,
		@market		= market,
		@randserial	= randserial,
		@savebktime	= savebktime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 세이브 정상처리(동일요청)'

			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '세이브 정상처리'
			--select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- 세이브 정보 > 금액빼기.
			-----------------------------------------------------------------
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

			----------------------------------------------
			-- 보물광고 맥스번호.
			----------------------------------------------
			select @adidxmax = max(idx) from dbo.tFVUserAdLog

			---------------------------------------------------
			-- 판매수익과 대표동물저장 > 파싱.
			---------------------------------------------------
			--select 'DEBUG ', @userinfo_ userinfo_
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
							if(@kind = @SAVE_USERINFO_BESTANI)
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
							else if(@kind = @SAVE_USERINFO_BESTDEALER2)
								begin
									set @bestdealer2 	= @info
								end
							else if(@kind = @SAVE_USERINFO_NEWSTART2)
								begin
									set @newstart2 	= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curUserInfo
					Deallocate curUserInfo
					--select 'DEBUG 입력정보(useinfo) ', @bestani2 bestani2, @cashcost2 cashcost2, @vippoint2 vippoint2, @bestdealer2 bestdealer2, @newstart2 newstart2
				end

			---------------------------------------------
			-- 환생을 감지
			-- 현재의 환생값 > 저장된값을 넘으면 > 환생중...
			---------------------------------------------
			if(@newstart2 > @newstart)
				begin
					-- 이벤트 시작일 & 환생 랭킹 이벤트 시작
					--select 'DEBUG 환생중...'
					--select 'DEBUG ', idx, * from dbo.tFVLevelUpReward where idx in (select top 1 idx from dbo.tFVLevelUpReward where gameid = @gameid_ order by idx desc)

					update dbo.tFVLevelUpReward
						set
							writedate = '2001-01-01'
					where idx in (select top 1 idx from dbo.tFVLevelUpReward where gameid = @gameid_ order by idx desc)
				end


			---------------------------------------------
			-- 치트검사
			---------------------------------------------
			--select 'DEBUG ', @cashpoint cashpoint, @cashcost2 cashcost2, @vippoint vippoint, @vippoint2 vippoint2
			if(@ownercashcost > @ownercashcostdb + 100)
				begin
					--select 'DEBUG > ownercashcost 치트'
					set @tmp = @ownercashcost - @ownercashcostdb
					set @comment2 = '<font color=red>저장이상 보유캐쉬(' + ltrim(rtrim(@ownercashcostdb)) + ') 전송캐쉬(' + ltrim(rtrim(@ownercashcost)) + ') -> (' + ltrim(rtrim(@tmp)) + ')</font>'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end
			else if(@cashpoint = 0 and @cashcost2 >= 50000)
				begin
					--select 'DEBUG > 결정 치트'
					set @comment2 = '<font color=red>저장이상 구매캐쉬(' + ltrim(rtrim(@cashpoint)) + ')인데 보유캐쉬(' + ltrim(rtrim(@cashcost2)) + ') -> 어떻게</font>'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end
			else if(@vippoint = 0 and @vippoint2 >= 50000)
				begin
					--select 'DEBUG > VIP 치트'
					set @comment2 = '<font color=red>저장이상 구매VIP(' + ltrim(rtrim(@vippoint)) + ') 보유VIP(' + ltrim(rtrim(@vippoint2)) + ')</font>'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end

			---------------------------------------------
			-- 하트일일전송량 초기화
			---------------------------------------------
			if(@heartdate != @dateid8)
				begin
					--select 'DEBUG 하루 날짜가 바뀌어서 초기화'
					set @heartdate	= @dateid8
					set @heartcnt = 0
				end
			set @heartget2 = @heartget
			set @heartget = 0


			----------------------------------------------
			-- 세이브 정보 백업 (6시간).
			----------------------------------------------
			if(@savebktime < (getdate() - 0.25))
				begin
					--select 'DEBUG 세이브 정보 백업'
					-- 번호를 업기.
					select @idx2 = isnull(max(idx2), 0) + 1
					from dbo.tFVUserDataBackup
					where gameid = @gameid_

					-- 기록하기.
					insert into dbo.tFVUserDataBackup(gameid,   idx2,  savedata)
					values(                          @gameid_, @idx2, @savedata_)

					-- 일정 수량 이상이면 삭제하기.
					delete from dbo.tFVUserDataBackup where gameid = @gameid_ and idx2 < @idx2 - 20

					set @savebktime = getdate()
				end

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					savebktime		= @savebktime,
					ownercashcost	= @ownercashcost,
					adidx			= case when @adidxmax > @adidx then @adidxmax else @adidx end,
					cashcost2		= case when (@cashcost2 > cashcost2) 	then @cashcost2 	else cashcost2 end,
					vippoint2		= case when (@vippoint2 > vippoint2) 	then @vippoint2 	else vippoint2 end,
					bestdealer		= case when (@bestdealer2 > bestdealer) then @bestdealer2 	else bestdealer end,
					newstart		= case when (@newstart2 > newstart) 	then @newstart2 	else newstart end,
					researchpoint	= researchpoint + @researchpoint_,
					randserial		= @randserial_,
					bestani			= @bestani2,
					heartget		= @heartget,
					heartcnt		= @heartcnt,
					heartdate		= @heartdate
			where gameid = @gameid_


			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserData where gameid = @gameid_))
				begin
					--select 'DEBUG insert'
					insert into dbo.tFVUserData(gameid,   savedata)
					values(                    @gameid_, @savedata_)
				end
			else
				begin
					--select 'DEBUG update'
					update dbo.tFVUserData
						set
							savedata = @savedata_
					where gameid = @gameid_

					--select 'DEBUG 로그 기록'
					--insert into dbo.tFVUserData2(gameid, savedata) values(@gameid_, @savedata_)
				end

			----------------------------------------------
			-- 랭킹대전
			----------------------------------------------
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			----------------------------------
			-- 유저정보.
			-- > 하트받은량.
			-----------------------------------
			select @heartget2 heartget2, * from dbo.tFVUserMaster where gameid = @gameid_

			------------------------------------------------
			-- 랭킹정보(결산할때).
			------------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			--------------------------------------------------------------
			-- 광고정보.
			--------------------------------------------------------------
			select top 1 * from dbo.tFVUserAdLog
			where idx > @adidx
			order by idx desc

			--------------------------------------------------------------
			-- 유저 전체랭킹 (3가지 종류의 랭킹이 있음)
			-- 0 > 안보여줌
			-- 1 > 보여줌
			--------------------------------------------------------------
			if(@mode_ = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end

		END
	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



