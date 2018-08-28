use Farm
GO

declare @gameid_								varchar(60),
		@password_								varchar(20),
		@randserial_							varchar(20),
		@mode									int,
		@friendid_								varchar(20)
declare @dateid8 		varchar(8)
declare @loopmax 		int
declare @curloop		int
declare @famelv			int
declare @idx			int


set @mode			= 1		-- 일반교배(1), 프리미엄교배(2)
set @loopmax		= 1000

-- update dbo.tFVUserMaster set market = 5, version = 119 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set market = 5, version = 120 where gameid = 'xxxx2'

set @famelv			= 1
set @dateid8 		= Convert(varchar(8),Getdate(),112)
set @gameid_		= 'xxxx2'
set @password_		= '049000s1i0n7t8445289'
set @friendid_		= 'xxxx3'
delete from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8	-- 전체뽑기
delete from dbo.tFVRouletteLogTotalSub where dateid8 = @dateid8		-- 전체뽑기

while(@famelv <= 70)
	begin
		set @curloop 		= 1

		--------------------------------------------------
		-- 	사전데이타 삭제.
		--------------------------------------------------
		delete from dbo.tFVGiftList where gameid = @gameid_					-- 개인선물
		delete from dbo.tFVRouletteLogPerson where gameid = @gameid_			-- 개인뽑기

		while(@curloop <= @loopmax)
			begin
				update dbo.tFVUserMaster set famelv = @famelv, cashcost = 1000000, gamecost = 1000000, heart = 500000, randserial = -1 where gameid = @gameid_

				select top 1 @idx = idx from dbo.tFVSystemRoulette where famelvmin <= @famelv and @famelv <= famelvmax and packstate = 1 order by newid()

				set @randserial_	= @curloop

				exec spu_FVRoulBuyTest @gameid_, @password_, @idx, @randserial_, @mode, @friendid_, -1
				set @curloop = @curloop + 1
			end

		select @famelv famelv
		exec spu_FVFarmD 19, 412,-1, -1, -1, -1, -1, -1, -1, -1, '', @dateid8, '', '', '', '', '', '', '', ''				-- 유저 뽑기월서브 통계

		set @famelv = case
							when @famelv <=  1 then  6
							when @famelv <=  6 then 11
							when @famelv <= 11 then 14
							when @famelv <= 14 then 20
							when @famelv <= 20 then 26
							when @famelv <= 26 then 31
							when @famelv <= 31 then 37
							when @famelv <= 37 then 43
							when @famelv <= 43 then 48
							when @famelv <= 48 then 50
							when @famelv <= 53 then 58
							when @famelv <= 58 then 60
							when @famelv <= 63 then 68
							when @famelv <= 68 then 70
							else 					99
					end
	end




/*
-- 획득 동물을 넣어보기.
declare @dateid8 	varchar(8)		set @dateid8 	= Convert(varchar(8),Getdate(),112)
declare @gameid		varchar(60)		set @gameid		= 'farm939085910'
declare @itemcode	int				set @itemcode	= -1

-- 1. 커서 생성
declare curRoulInsert Cursor for
select itemcode from dbo.tFVRouletteLogTotalSub where dateid8 = @dateid8

-- 2. 커서오픈.
open curRoulInsert

-- 3. 커서 사용
Fetch next from curRoulInsert into @itemcode
while @@Fetch_status = 0
	Begin
		exec spu_FVSubGiftSend 2,     @itemcode, 'SysLogin', @gameid, ''
		Fetch next from curRoulInsert into @itemcode
	end

-- 4. 커서닫기
close curRoulInsert
Deallocate curRoulInsert
*/

