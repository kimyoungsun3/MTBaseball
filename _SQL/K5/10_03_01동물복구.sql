/*
-- delete from dbo.tUserItem where gameid = 'xxxx5' and invenkind = 1
exec spu_AniRestore 'xxxx5', '049000s1i0n7t8445289', -1		-- 복구하기.
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniRestore', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniRestore;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniRestore
	@gameid_								varchar(20),
	@password_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- 동물이 살아있다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 부활템 코드번호.
	declare @ITEM_RESTORE_ANIMAL				int				set @ITEM_RESTORE_ANIMAL					= 22

	-- 죽은 or 부활모드.
	declare @USERITEM_MODE_DIE_INIT				int				set @USERITEM_MODE_DIE_INIT					= -1-- 초기상태.

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 			set @USERITEM_INVENKIND_ANI					= 1

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int				set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @famelv				int				set @famelv			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0

	declare @anicnt				int				set	@anicnt			= 0
	declare @fieldidx			int
	declare @listidx			int				set @listidx		= -444
	declare @listidxstart		int
	declare @loop				int				set @loop			= 5
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 보유캐쉬
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@famelv			= famelv
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @famelv famelv

	-- 유저 가축정보.
	select
		@anicnt = count(*)
	from dbo.tUserItem
	where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and diemode = @USERITEM_MODE_DIE_INIT
	--select 'DEBUG 유저 가축정보', @anicnt anicnt

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@anicnt != 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_IS_ALIVE
			set @comment 	= '동물이 살아있다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 복구 합니다.'
			--select 'DEBUG ' + @comment

			select @listidx = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			set @loop = case
							when @famelv < 3 	then 5
							when @famelv < 6 	then 6
							when @famelv < 9 	then 7
							when @famelv < 12 	then 8
							else					   9
						end
			set @fieldidx		= 0
			set @listidxstart 	= @listidx
			----select 'DEBUG 4-1 인벤 새번호', @loop loop, @listidx listidx
			while(@loop > 0)
				begin
					insert into dbo.tUserItem(gameid,   listidx,   itemcode,           cnt, farmnum,  fieldidx,  invenkind,              randserial, upstepmax, gethow)		-- 동물.
					values(					 @gameid_, @listidx, @ITEM_RESTORE_ANIMAL,   1,       0, @fieldidx, @USERITEM_INVENKIND_ANI,          0,         0, @DEFINE_HOW_GET_FREEANIRESTORE)

					set @listidx	= @listidx + 1
					set @fieldidx 	= @fieldidx + 1
					set @loop 		= @loop - 1
				end
		END


	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보(동물)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx >= @listidxstart
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



