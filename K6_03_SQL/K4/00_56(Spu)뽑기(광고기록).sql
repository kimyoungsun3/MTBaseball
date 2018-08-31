/*
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 1, 80010,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 2, 80012,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 3, 80013,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 4, 80014,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 4, 80015,  -1,  -1,  -1,  -1

exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 12, 80012,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 13, 80013,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 14, 80014,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 14, 80015,  -1,  -1,  -1,  -1

exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 22, 80012,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 23, 80013,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 24, 80014,  -1,  -1,  -1,  -1
exec spu_FVRoulAdLog 'xxxx2', 'xxxx2', 24, 80015,  -1,  -1,  -1,  -1
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulAdLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulAdLog;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRoulAdLog
	@gameid_								varchar(60),
	@nickname_								varchar(40),
	@mode_									int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@itemcode5_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	declare @IDX_MAX				int 			set @IDX_MAX		= 100

	-- 뽑기 상수.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- 결정뽑기.
	declare @MODE_ROULETTE_GRADE3				int					set @MODE_ROULETTE_GRADE3					= 3		--
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	--
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- 결정뽑기(무료).
	declare @MODE_ROULETTE_GRADE3_FREE			int					set @MODE_ROULETTE_GRADE3_FREE				= 13	--
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	--
	declare @MODE_ROULETTE_GRADE2_TICKET		int					set @MODE_ROULETTE_GRADE2_TICKET			= 22	-- 결정뽑기(티켓).
	declare @MODE_ROULETTE_GRADE3_TICKET		int					set @MODE_ROULETTE_GRADE3_TICKET			= 23	--
	declare @MODE_ROULETTE_GRADE4_TICKET		int					set @MODE_ROULETTE_GRADE4_TICKET			= 24	--

	------------------------------------------------
	--
	------------------------------------------------
	declare @itemcode				int
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @itemlist				varchar(128)
	declare @cnt					int
	declare @mod					int
	declare @mod2					int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	-- 1. 커서 생성
	set @itemlist = ltrim(rtrim(str(@itemcode1_))) + ','
					+ ltrim(rtrim(str(@itemcode2_))) + ','
					+ ltrim(rtrim(str(@itemcode3_))) + ','
					+ ltrim(rtrim(str(@itemcode4_))) + ','
					+ ltrim(rtrim(str(@itemcode5_)))
	--select 'DEBUG ', @itemlist itemlist
	
	-- 모드를 티켓은 정가로 표시해줌.
	set @mode_ = case 
						when ( @mode_ = @MODE_ROULETTE_GRADE2_TICKET ) then @MODE_ROULETTE_GRADE2
						when ( @mode_ = @MODE_ROULETTE_GRADE3_TICKET ) then @MODE_ROULETTE_GRADE3
						when ( @mode_ = @MODE_ROULETTE_GRADE4_TICKET ) then @MODE_ROULETTE_GRADE4
						else											    @mode_
				 end

	declare curTemp Cursor for
	select idx, listidx FROM dbo.fnu_SplitOne(',', @itemlist)

	-- 2. 커서오픈
	open curTemp

	-- 3. 커서 사용
	Fetch next from curTemp into @idx, @itemcode
	while @@Fetch_status = 0
		Begin
			set @mod = @itemcode % 5
			set @mod2 = @itemcode % 10
			-- select 'DEBUG ', @idx idx, @itemcode itemcode, @mod mod, @mod2 mod2
			if(@mod in (2, 3, 4) or (@mod2 = 5 and @itemcode >= 80015 and @itemcode < 80200))
				begin
					--select 'DEBUG > 광고하기', @idx, @itemcode

					----------------------------------------
					-- 아이템 이름을 검색 > 입력.
					----------------------------------------
					select @itemname = itemname from dbo.tFVItemInfo where itemcode = @itemcode

					insert into dbo.tFVUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
					values(                      @gameid_, @nickname_, @itemcode, @mode_, '['+ @itemname +']을 프리미엄 뽑기로 얻었습니다.')

					set @cnt = @cnt + 1
				end
			Fetch next from curTemp into @idx, @itemcode
		end

	-- 4. 커서닫기
	close curTemp
	Deallocate curTemp

	-- 일정개수 이상은 삭제시킴
	select @idx = max(idx) from dbo.tFVUserAdLog
	delete from dbo.tFVUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End