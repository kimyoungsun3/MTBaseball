---------------------------------------------------------------
/*
----------------------------------------
-- 뽑기동물/보물 (뽑기).
----------------------------------------
delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind in (1, 1200, 1040)
exec spu_SetDirectItemNew 'xxxx2', 1, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 4, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 7, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 10, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 13, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 16, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 20, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 26, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 220, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 224, 1, 3, -1
exec spu_SetDirectItemNew 'xxxx2', 120010, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120011, 1, 3, -1		exec spu_SetDirectItemNew 'xxxx2', 120012, 1, 3, -1		exec spu_SetDirectItemNew 'xxxx2', 120013, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120014, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120015, 1, 3, -1		-- 뽑기보물.
update dbo.tUserMaster set randserial = -1 where gameid = 'xxxx2'

-- 동물분해.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:25;', 										 '7771', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:34;3:26;4:27;5:28;6:29;7:30;8:31;9:32;10:33;', '7772', -1


-- 보물분해.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 2, '1:35;', 										 '7773', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 2, '1:36;2:37;3:38;4:39;5:40;', 					 '7774', -1

----------------------------------------
--상점구매동물(1), 지원동물(17).
----------------------------------------
delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind in (1, 1200, 1040)
exec spu_SetDirectItemNew 'xxxx2', 1, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1
exec spu_SetDirectItemNew 'xxxx2', 22, 1, 17, -1	exec spu_SetDirectItemNew 'xxxx2', 22, 1, 17, -1
update dbo.tUserMaster set randserial = -1 where gameid = 'xxxx2'

-- 동물분해.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:25;', '7781', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:26;', '7782', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:27;2:28;2:29;', '7783', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:30;', '7785', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:31;', '7786', -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ApartItemcode', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ApartItemcode;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ApartItemcode
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@listset_				varchar(256),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int					set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.

	-- 분해모드.
	declare @MODE_APART_ANIMAL					int					set @MODE_APART_ANIMAL						= 1		-- 동물분해.
	declare @MODE_APART_TREASURE				int					set @MODE_APART_TREASURE					= 2		-- 보물분해.

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	declare @DEFINE_HOW_GET_ANIMAL_APART		int					set @DEFINE_HOW_GET_ANIMAL_APART			= 15	-- 동물분해.
	declare @DEFINE_HOW_GET_TREASURE_APART		int					set @DEFINE_HOW_GET_TREASURE_APART			= 16	-- 보물분해.
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.

	-- 기타상수.
	declare @GIVE_STEMCELL_DONT					int					set @GIVE_STEMCELL_DONT						= -1	-- 세포지급하지마라.
	declare @GIVE_STEMCELL_GIVE					int					set @GIVE_STEMCELL_GIVE						=  1	-- 세포지급.
	declare @APARY_BUY_CNT_MAX					int					set @APARY_BUY_CNT_MAX						= 2000	-- 코인 이상이면 세포하나준다.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- 유저정보.
	declare @cashcost		int				set @cashcost		= 0
	declare @gamecost		int				set @gamecost		= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'

	declare @invenkind		int				set @invenkind		= -1
	declare @sendgethow		int				set @sendgethow	 	= @DEFINE_HOW_GET_ANIMAL_APART
	declare @senditemcode	int				set @senditemcode	= -1
	declare @gradeorg		int				set @gradeorg	 	= -1
	declare @grade			int				set @grade	 		= -1
	declare @rtnlistidx 	int				set @rtnlistidx		= -1
	declare @cnt			int				set @cnt	 		= 0
	declare @delmode		int				set @delmode	 	= 4
	declare @apartbuycnt	int				set @apartbuycnt	= 0
	declare @gethow			int				set @gethow			= @DEFINE_HOW_GET_BUY
	declare @itemcode		int				set @itemcode		= -1
	declare @givestemcell	int				set @givestemcell	= @GIVE_STEMCELL_GIVE
	declare @needgamecost	int
	declare @needcashcost	int
	declare @plusgamecost	int				set @plusgamecost	= 0
	declare @sellgamecost	int				set @sellgamecost	= 0
	declare @tstrigger		int				set @tstrigger		= 1

	declare @kind			int
	declare @info			int
	declare @loopidx		int
	declare @loopmax		int
	declare @bgroul1		int				set @bgroul1	 	= -1
	declare @bgroul2		int				set @bgroul2	 	= -1
	declare @bgroul3		int				set @bgroul3	 	= -1
	declare @bgroul4		int				set @bgroul4	 	= -1
	declare @bgroul5		int				set @bgroul5	 	= -1
	declare @bgroul6		int				set @bgroul6	 	= -1
	declare @bgroul7		int				set @bgroul7	 	= -1
	declare @bgroul8		int				set @bgroul8	 	= -1
	declare @bgroul9		int				set @bgroul9	 	= -1
	declare @bgroul10		int				set @bgroul10	 	= -1
	declare @bgroul11		int				set @bgroul11	 	= -1
	declare @bgroul12		int				set @bgroul12	 	= -1
	declare @bgroul13		int				set @bgroul13	 	= -1
	declare @bgroul14		int				set @bgroul14	 	= -1
	declare @bgroul15		int				set @bgroul15	 	= -1
	declare @bgroul16		int				set @bgroul16	 	= -1
	declare @bgroul17		int				set @bgroul17	 	= -1
	declare @bgroul18		int				set @bgroul18	 	= -1
	declare @bgroul19		int				set @bgroul19	 	= -1
	declare @bgroul20		int				set @bgroul20	 	= -1
	declare @apartcnt		int				set @apartcnt	 	= 0
Begin
	------------------------------------------------
	--	3-1. 초기화.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listset_ listset_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 	= gameid,		@cashcost	= cashcost, 	@gamecost	= gamecost, 	@apartbuycnt= apartbuycnt,
		@bgroul1 	= bgroul1,		@bgroul2 	= bgroul2,		@bgroul3 	= bgroul3,		@bgroul4 = bgroul4,		@bgroul5 = bgroul5,
		@bgroul6 	= bgroul6,		@bgroul7 	= bgroul7,		@bgroul8 	= bgroul8,		@bgroul9 = bgroul9,		@bgroul10= bgroul10,
		@bgroul11 	= bgroul11,		@bgroul12 	= bgroul12,		@bgroul13 	= bgroul13,		@bgroul14 = bgroul14,	@bgroul15 = bgroul15,
		@bgroul16 	= bgroul16,		@bgroul17 	= bgroul17,		@bgroul18 	= bgroul18,		@bgroul19 = bgroul19,	@bgroul20= bgroul20,
		@randserial	= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @randserial randserial

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ not in (@MODE_APART_ANIMAL, @MODE_APART_TREASURE ) )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( LEN( @listset_ ) < 3 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment 	= 'ERROR 리스트 번호를 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 분해했습니다.(동일)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 분해했습니다.'
			--select 'DEBUG ' + @comment

			-- 인벤의 정보.
			if( @mode_ = @MODE_APART_ANIMAL )
				begin
					set @invenkind 	= @USERITEM_INVENKIND_ANI
					set @sendgethow	= @DEFINE_HOW_GET_ANIMAL_APART
					set @delmode	= 4
					--select 'DEBUG 동물분해', @mode_ mode_, @invenkind invenkind, @sendgethow sendgethow
				end
			else
				begin
					set @invenkind = @USERITEM_INVENKIND_TREASURE
					set @sendgethow	= @DEFINE_HOW_GET_TREASURE_APART
					set @delmode	= 5
					--select 'DEBUG 보물분해', @mode_ mode_, @invenkind invenkind, @sendgethow sendgethow
				end

			-- 리스트 번호 초기화.
			set @bgroul1	 	= -1
			set @bgroul2	 	= -1
			set @bgroul3	 	= -1
			set @bgroul4	 	= -1
			set @bgroul5	 	= -1
			set @bgroul6	 	= -1
			set @bgroul7	 	= -1
			set @bgroul8	 	= -1
			set @bgroul9	 	= -1
			set @bgroul10	 	= -1
			set @bgroul11	 	= -1
			set @bgroul12	 	= -1
			set @bgroul13	 	= -1
			set @bgroul14	 	= -1
			set @bgroul15	 	= -1
			set @bgroul16	 	= -1
			set @bgroul17	 	= -1
			set @bgroul18	 	= -1
			set @bgroul19	 	= -1
			set @bgroul20	 	= -1

			------------------------------------------------------------------
			-- 강화변경해주기.
			------------------------------------------------------------------
			-- 1. 커서 생성
			declare curApartItemcode Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. 커서오픈
			open curApartItemcode

			-- 3. 커서 사용
			Fetch next from curApartItemcode into @kind, @info
			while @@Fetch_status = 0
				Begin
					-- 정보분해하기전 초기화.
					set @senditemcode	= -1
					set @grade			= -1
					set @gradeorg		= -1
					set @itemcode		= -1
					set @rtnlistidx		= -1
					set @gethow			= @DEFINE_HOW_GET_BUY
					set @sellgamecost	= 0
					set @tstrigger		= 1

					-- 보유한 템을 확인해보자.
					select @itemcode = itemcode, @gethow = gethow from dbo.tUserItem
					where gameid = @gameid_ and listidx = @info and invenkind = @invenkind

					-- 동물/보물 -> 등급분해
					select
						@gradeorg		= grade,
						@needgamecost 	= gamecost,
						@needcashcost 	= cashcost,
						@sellgamecost	= sellcost,
						@tstrigger		= param5
					from dbo.tItemInfo where itemcode = @itemcode
					--select 'DEBUG > 동물, 보물 등급.', @kind kind, @info listidx, @gradeorg gradeorg, @itemcode itemcode, @gethow gethow, @needgamecost needgamecost, @needcashcost needcashcost

					if( @itemcode != -1 and @gradeorg != -1 )
						begin
							set @apartcnt = @apartcnt + 1
							--------------------------------------
							--> 사용한 동물 or 보물 분해 삭제
							--------------------------------------
							exec spu_DeleteUserItemBackup @delmode, @gameid_, @info
							--select 'DEBUG > 동물, 보물 삭제함(백업후)'

							---------------------------------
							-- 보물 보유효과 세팅.
							-- 보물중에 보유템(2)
							-- 분해흘 하면 제거하는 부분 안에서 재연산 해서 제로로 만들어줌...
							---------------------------------
							if( @mode_ = @MODE_APART_TREASURE and @tstrigger = 2 )
								begin
									exec spu_TSRetentionEffect @gameid_, @itemcode
								end

							------------------------------------------------------------------
							-- 동물구매
							--		> xx원 일정 금액 이상 구매시 바꿔줌
							-- 동물지원
							--		> 지원필터.
							------------------------------------------------------------------
							set @givestemcell = @GIVE_STEMCELL_GIVE
							if( @gethow = @DEFINE_HOW_GET_BUY )
								begin
									set @apartbuycnt = @apartbuycnt + case
																			when ( @needcashcost > 0  ) then 99999
																			when ( @needgamecost <= 0 ) then 0
																			else						     @needgamecost
																	  end
									--select 'DEBUG  > 구매동물', @apartbuycnt apartbuycnt, @needcashcost needcashcost, @needgamecost needgamecost

									if( @apartbuycnt >= @APARY_BUY_CNT_MAX )
										begin
											--select 'DEBUG  > 루프맥스라서 지급'
											set @givestemcell 	= @GIVE_STEMCELL_GIVE
											set @apartbuycnt	= 0
										end
									else
										begin
											--select 'DEBUG  > 아직부족이라서 미지급'
											set @givestemcell 	= @GIVE_STEMCELL_DONT
											set @plusgamecost 	= @plusgamecost + @sellgamecost * 80 / 100
										end

								end
							else if( @gethow = @DEFINE_HOW_GET_FREEANIRESTORE )
								begin
									--select 'DEBUG  > 지원동물(그냥패스)'
									set @givestemcell 	= @GIVE_STEMCELL_DONT
									set @plusgamecost 	= 1
								end
							--else
							--	begin
							--		set @givestemcell = @GIVE_STEMCELL_GIVE
							--	end
							--select 'DEBUG  > 지급상태', @givestemcell givestemcell



							--------------------------------------
							-- 등급에 따른 세포 지급.
							-- 	동물 0 1 2 3 4 5 6 7 8 9 10
							--       1 1 2 2 2 2 2 2 2 2 2
							--  보물   1 2 3 4 5 6
							--         1 1 2 2 2 2
							--------------------------------------
							--select 'DEBUG 지급'
							set @grade 		= dbo.fun_GetApartGrade(@mode_, @gradeorg)
							set @loopidx	= 0
							set @loopmax	= 1
							if (@mode_ = @MODE_APART_ANIMAL and @gradeorg >= 2 )
								begin
									set @loopmax = 2
								end
							else if (@mode_ = @MODE_APART_TREASURE and @gradeorg >= 3 )
								begin
									set @loopmax = 2
								end


							--------------------------------------
							-- 지급할 세포등급 추출
							--	> 해당세포 찾아
							--	> 넣어주기.
							--------------------------------------
							while( @givestemcell = @GIVE_STEMCELL_GIVE and @loopidx < @loopmax)
								begin
									set @cnt 		= @cnt + 1
									set @loopidx	= @loopidx + 1

									select @senditemcode = itemcode from dbo.tItemInfo
									where subcategory = @ITEM_SUBCATEGORY_STEMCELL and grade = @grade
									order by newid()
									--select 'DEBUG > 지급세포지급.', @grade grade, @senditemcode senditemcode

									--> 줄기세포 넣어주기.
									exec spu_SetDirectItemNew @gameid_, @senditemcode, 1, @sendgethow, @rtn_ = @rtnlistidx OUTPUT
									--select 'DEBUG > 지급세포지급.', @gameid_ gameid_, @grade grade, @senditemcode senditemcode, @sendgethow sendgethow, @rtnlistidx rtnlistidx

									if( @cnt = 1 )
										begin
											set @bgroul1 = @rtnlistidx
										end
									else if( @cnt = 2 )
										begin
											set @bgroul2 = @rtnlistidx
										end
									else if( @cnt = 3 )
										begin
											set @bgroul3 = @rtnlistidx
										end
									else if( @cnt = 4 )
										begin
											set @bgroul4 = @rtnlistidx
										end
									else if( @cnt = 5 )
										begin
											set @bgroul5 = @rtnlistidx
										end
									else if( @cnt = 6 )
										begin
											set @bgroul6 = @rtnlistidx
										end
									else if( @cnt = 7 )
										begin
											set @bgroul7 = @rtnlistidx
										end
									else if( @cnt = 8 )
										begin
											set @bgroul8 = @rtnlistidx
										end
									else if( @cnt = 9 )
										begin
											set @bgroul9 = @rtnlistidx
										end
									else if( @cnt = 10 )
										begin
											set @bgroul10 = @rtnlistidx
										end
									else if( @cnt = 11 )
										begin
											set @bgroul11 = @rtnlistidx
										end
									else if( @cnt = 12 )
										begin
											set @bgroul12 = @rtnlistidx
										end
									else if( @cnt = 13 )
										begin
											set @bgroul13 = @rtnlistidx
										end
									else if( @cnt = 14 )
										begin
											set @bgroul14 = @rtnlistidx
										end
									else if( @cnt = 15 )
										begin
											set @bgroul15 = @rtnlistidx
										end
									else if( @cnt = 16 )
										begin
											set @bgroul16 = @rtnlistidx
										end
									else if( @cnt = 17 )
										begin
											set @bgroul17 = @rtnlistidx
										end
									else if( @cnt = 18 )
										begin
											set @bgroul18 = @rtnlistidx
										end
									else if( @cnt = 19 )
										begin
											set @bgroul19 = @rtnlistidx
										end
									else if( @cnt = 20 )
										begin
											set @bgroul20 = @rtnlistidx
										end
								end
						end

					Fetch next from curApartItemcode into @kind, @info
				end
			-- 4. 커서닫기
			close curApartItemcode
			Deallocate curApartItemcode

			if( @cnt >= 1 or @plusgamecost > 0)
				begin
					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
						set
							gamecost	= @gamecost + @plusgamecost,
							bkapartani	= bkapartani + 	case when (@mode_ = @MODE_APART_ANIMAL) 	then @apartcnt else 0 end,
							bkapartts	= bkapartts + 	case when (@mode_ = @MODE_APART_TREASURE) 	then @apartcnt else 0 end,
							bgroul1 	= @bgroul1,		bgroul2 = @bgroul2,		bgroul3 = @bgroul3,		bgroul4 = @bgroul4,		bgroul5 = @bgroul5,
							bgroul6 	= @bgroul6,		bgroul7 = @bgroul7,		bgroul8 = @bgroul8,		bgroul9 = @bgroul9,		bgroul10= @bgroul10,
							bgroul11 	= @bgroul11,	bgroul12 = @bgroul12,	bgroul13 = @bgroul13,	bgroul14 = @bgroul14,	bgroul15 = @bgroul15,
							bgroul16 	= @bgroul16,	bgroul17 = @bgroul17,	bgroul18 = @bgroul18,	bgroul19 = @bgroul19,	bgroul20= @bgroul20,
							apartbuycnt = isnull(@apartbuycnt, 0),
							randserial	= @randserial_
					where gameid = @gameid_
				end
			else
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR 리스트 번호를 찾을 수 없습니다.(2)'
					--select 'DEBUG ' + @comment
				end
		END



	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @plusgamecost plusgamecost, @cnt apartcnt
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@bgroul1, @bgroul2, @bgroul3, @bgroul4, @bgroul5, @bgroul6, @bgroul7, @bgroul8, @bgroul9, @bgroul10, @bgroul11, @bgroul12, @bgroul13, @bgroul14, @bgroul15, @bgroul16, @bgroul17, @bgroul18, @bgroul19, @bgroul20)
		end
	set nocount off
End

