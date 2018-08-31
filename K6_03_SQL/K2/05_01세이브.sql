use Farm
Go
/*
		친구포인트(자동수집).
																			룰렛횟수(20,          21)
                                                                            무료룰렛돌림(-1)      유료룰렛횟수
																			무료룰렛이미돌림(-1)  (돌린횟수 n이상)
         판매수익(0)       보유동물중최고   보유금액        보유VIP         무료룰렛안돌림(1)     유료안돌림 (0)		  황금룰렛(22)      생산수량(30)		목장수익(31)	늑대사냥(32)		플레이타임(33).
userinfo=salemoney;        bestani;	   	    cashcost2		vippoint2		roulette2             roulette2        		  roulettegold2     rkproductcnt2		rkfarmearn2		rkwolfcnt2			rkplaycnt2
		 0:123456789012;   1:500;           10:0;            11:0;          20:-1;                21:1;                   22:1;             30:30;              31:31;          32:32;              33:33;
		 0:123456789012;   1:500;           10:0;            11:0;          20:1;                 21:1;                   22:1;             30:30;              31:31;          32:32;              33:33;

exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '0:0  ;  1:500;  10:0;  11:0;  20:-1;                                              ', 'google22savetest', 8771, -1
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '0:0  ;  1:500;  10:0;  11:0;  20:-1;  21:0;         30:0;   31:0;   32:0;  33:0;  ', 'google22savetest', 8772, -1
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  22:0;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8773, -1
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:0;  22:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8774, -1
select * from dbo.tFVUserData where gameid = 'xxxx@gmail.com' select salemoney, bestani from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

-- 비과금인데 과금한것처럼 데이타 전송
-- update dbo.tUserMaster set cashpoint = 0, vippoint = 0, cashcost = 0 where gameid = 'xxxx@gmail.com'
-- update dbo.tUserMaster set                vippoint2 = 0, cashcost2 = 0 where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVUserUnusualLog2 where gameid = 'xxxx@gmail.com'
update dbo.tUserMaster set randserial = -1 where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '0:123;   1:500;        10:50000;    11:0;      20:-1', 'google22savetest',     8772, -1	-- 캐쉬치트
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '0:456;   1:500;        10:0;        11:50000;  20:-1', 'google22savetest',     8773, -1	-- VIP치트

exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '0:123;   1:500;        10:1234567890123456;    11:0;', 'google22savetest',     8774, -1	-- 캐쉬치트
*/

IF OBJECT_ID ( 'dbo.spu_FVSave2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSave2;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSave2
	@gameid_								varchar(60),				-- 게임아이디
	@phone_									varchar(20),
	@mode_									int,
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
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 세이브값종류
	declare @SAVE_USERINFO_SALEMONEY			int				set @SAVE_USERINFO_SALEMONEY			= 0
	declare @SAVE_USERINFO_BESTANI				int				set @SAVE_USERINFO_BESTANI				= 1
	declare @SAVE_USERINFO_CASHCOST2			int				set @SAVE_USERINFO_CASHCOST2			= 10
	declare @SAVE_USERINFO_VIPPOINT2			int				set @SAVE_USERINFO_VIPPOINT2			= 11
	declare @SAVE_USERINFO_ROULETTE2			int				set @SAVE_USERINFO_ROULETTE2			= 20
	declare @SAVE_USERINFO_ROULETTEPAYCNT2		int				set @SAVE_USERINFO_ROULETTEPAYCNT2		= 21
	declare @SAVE_USERINFO_ROULETTEGOLDCNT2		int				set @SAVE_USERINFO_ROULETTEGOLDCNT2		= 22
	declare @SAVE_USERINFO_PRODUCKCNT2			int				set @SAVE_USERINFO_PRODUCKCNT2			= 30	-- 생산수량(30)
	declare @SAVE_USERINFO_FARMEARN2			int				set @SAVE_USERINFO_FARMEARN2			= 31	-- 목장수익(31)
	declare @SAVE_USERINFO_WOLFCNT2				int				set @SAVE_USERINFO_WOLFCNT2				= 32	-- 늑대사냥(32)
	declare @SAVE_USERINFO_PLAYCNT2				int				set @SAVE_USERINFO_PLAYCNT2				= 33	-- 플레이타임(33).

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '세이브'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @salemoney2				bigint					set @salemoney2		= 0
	declare @bestani2				int						set @bestani2		= 500
	declare @cashcost2				bigint					set @cashcost2		= 0
	declare @vippoint2				int						set @vippoint2		= 0
	declare @roulette2				int						set @roulette2		= -444
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @roulettepaycnt2		int						set @roulettepaycnt2= 0
	declare @roulettegold2			int						set @roulettegold2	= 0
	declare @blockstate				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0

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

	-- 전체랭킹.
	declare @rksalemoney2	bigint					set @rksalemoney2	= 0
	declare @rkproductcnt2	bigint					set @rkproductcnt2	= 0
	declare @rkfarmearn2	bigint					set @rkfarmearn2	= 0
	declare @rkwolfcnt2		bigint					set @rkwolfcnt2		= 0
	declare @rkfriendpoint2	bigint					set @rkfriendpoint2	= 0
	declare @rkroulettecnt2	bigint					set @rkroulettecnt2	= 0
	declare @rkplaycnt2		bigint					set @rkplaycnt2		= 0

	declare @roulloop		int						set @roulloop		= 0
	declare @roulloop2		int						set @roulloop2		= 0
	declare @adidx			int						set @adidx			= 0
	declare @adidxmax		int						set @adidxmax		= 0
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
		@blockstate = blockstate,
		@heartget	= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@cashpoint	= cashpoint,	@vippoint	= vippoint,
		@market		= market,
		@randserial	= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and phone = @phone_
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
									set @salemoney2 	= @info
									set @rksalemoney2	= @info
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
							else if(@kind = @SAVE_USERINFO_ROULETTE2)
								begin
									set @roulette2	 	= @info
								end
							else if(@kind = @SAVE_USERINFO_ROULETTEGOLDCNT2)
								begin
									set @roulettegold2 	= @info
								end
							else if(@kind = @SAVE_USERINFO_ROULETTEPAYCNT2)
								begin
									set @roulettepaycnt2= @info
									set @rkroulettecnt2	= @info
								end
							else if(@kind = @SAVE_USERINFO_PRODUCKCNT2)
								begin
									set @rkproductcnt2	= @info
								end
							else if(@kind = @SAVE_USERINFO_FARMEARN2)
								begin
									set @rkfarmearn2	= @info
								end
							else if(@kind = @SAVE_USERINFO_WOLFCNT2)
								begin
									set @rkwolfcnt2		= @info
								end
							else if(@kind = @SAVE_USERINFO_PLAYCNT2)
								begin
									set @rkplaycnt2		= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. 커서닫기
					close curUserInfo
					Deallocate curUserInfo
					--select 'DEBUG 입력정보(useinfo)', @salemoney2 salemoney2, @bestani2 bestani2, @cashcost2 cashcost2, @vippoint2 vippoint2, @roulette2 roulette2, @roulettepaycnt2 roulettepaycnt2
					--select 'DEBUG (파싱처음)', @rksalemoney2 rksalemoney2, @rkproductcnt2 rkproductcnt2, @rkfarmearn2 rkfarmearn2, @rkwolfcnt2 rkwolfcnt2, @rkfriendpoint2 rkfriendpoint2, @rkroulettecnt2 rkroulettecnt2, @rkplaycnt2 rkplaycnt2
				end


			---------------------------------------------
			-- 치트검사
			---------------------------------------------
			--select 'DEBUG ', @cashpoint cashpoint, @cashcost2 cashcost2, @vippoint vippoint, @vippoint2 vippoint2
			if(@cashpoint = 0 and @cashcost2 >= 50000)
				begin
					--select 'DEBUG > 결정 치트'
					set @comment2 = '결과이상 구매캐쉬(' + ltrim(rtrim(@cashpoint)) + ') 보유결정(' + ltrim(rtrim(@cashcost2)) + ')'
					exec spu_FVSubUnusualRecord2 @gameid_, @comment2
				end
			else if(@vippoint = 0 and @vippoint2 >= 50000)
				begin
					--select 'DEBUG > VIP 치트'
					set @comment2 = '결과이상 구매VIP(' + ltrim(rtrim(@vippoint)) + ') 보유VIP(' + ltrim(rtrim(@vippoint2)) + ')'
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

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			--select 'DEBUG', @rkroulettecnt2 rkroulettecnt2
			update dbo.tUserMaster
				set
					ownercashcost	= @ownercashcost,
					adidx			= case when @adidxmax > @adidx then @adidxmax else @adidx end,
					cashcost2	= case when (@cashcost2 > cashcost2) then @cashcost2 else cashcost2 end,
					vippoint2	= case when (@vippoint2 > vippoint2) then @vippoint2 else vippoint2 end,
					@rkroulettecnt2	= @rkroulettecnt2 + case when (@roulette2 = -1 and roulette = 1)	then  1         else 0             	end,	--대전에 사용되는것.
					roulette		=               	case when (@roulette2 = -1)		   				then -1         else roulette      	end,
					roulettefreecnt	= roulettefreecnt +	case when (@roulette2 = -1 and roulette = 1)	then  1         else 0             	end,
					roulettepaycnt	= roulettepaycnt + 	case when (@roulettepaycnt2 <= 0)  				then  0         else @roulettepaycnt2 end,
					salemoney 	= salemoney + @salemoney2,
					randserial	= @randserial_,
					roulettegoldcnt	= roulettegoldcnt + @roulettegold2,
					bestani		= @bestani2,
					heartget	= @heartget,
					heartcnt	= @heartcnt,
					heartdate	= @heartdate
			where gameid = @gameid_
			--select 'DEBUG', @rkroulettecnt2 rkroulettecnt2

			----------------------------------------------
			-- 통계정보.
			----------------------------------------------
			if(@roulettepaycnt2 > 0)
				begin
					exec spu_FVDayLogInfoStatic @market, 61, @roulettepaycnt2				  -- 일 유료룰렛수
				end

			----------------------------------------------
			-- 5개 단위로 1개 선물 > 버그존재
			----------------------------------------------
			--select @roulloop = roulettepaycnt from dbo.tUserMaster where gameid = @gameid_
			--set @roulloop2 = @roulloop % 5
			--if(@roulettepaycnt2 > 0 and @roulloop > 0 and @roulloop2 = 0)
			--	begin
			--		exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3500, 1, '황금룰렛티켓', @gameid_, ''
			--	end

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
			-- 홀짝 랭킹대전
			----------------------------------------------
			--select 'DEBUG 홀짝 랭킹대전', @rksalemoney2 rksalemoney2, @rkproductcnt2 rkproductcnt2, @rkfarmearn2 rkfarmearn2, @rkwolfcnt2 rkwolfcnt2, @rkfriendpoint2 rkfriendpoint2, @rkroulettecnt2 rkroulettecnt2, @rkplaycnt2 rkplaycnt2
			exec spu_subFVRankDaJun @gameid_, @rksalemoney2, @rkproductcnt2, @rkfarmearn2, @rkwolfcnt2, @rkfriendpoint2, @rkroulettecnt2, @rkplaycnt2
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
			select @heartget2 heartget2, * from dbo.tUserMaster where gameid = @gameid_

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



