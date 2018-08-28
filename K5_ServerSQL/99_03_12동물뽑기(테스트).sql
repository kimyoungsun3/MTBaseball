use Game4Farmvill5
GO

declare @gameid_								varchar(20),
		@password_								varchar(20),
		@mode									int,
		@friendid_								varchar(20)
declare @dateid8 		varchar(8)
declare @loopmax 		int
declare @curloop		int
declare @famelv			int
declare @cnt			int						set @cnt = 0

set @mode			= 4		-- 일반뽑기(1), 루비뽑기(2), 루비뽑기10(4)
set @loopmax		= 5000

set @famelv			= 1
set @dateid8 		= Convert(varchar(8),Getdate(),112)
set @gameid_		= 'xxxx2'
set @password_		= '049000s1i0n7t8445289'
set @friendid_		= 'xxxx3'
delete from dbo.tRouletteLogTotalMaster where dateid8 = @dateid8	-- 전체뽑기
delete from dbo.tRouletteLogTotalSub where dateid8 = @dateid8		-- 전체뽑기

while(@famelv <= 70)
	begin
		set @curloop 		= 1

		--------------------------------------------------
		-- 	사전데이타 삭제.
		--------------------------------------------------
		delete from dbo.tGiftList where gameid = @gameid_					-- 개인선물
		delete from dbo.tRouletteLogPerson where gameid = @gameid_			-- 개인뽑기

		while(@curloop <= @loopmax)
			begin
				update dbo.tUserMaster set famelv = @famelv, cashcost = 1000000, gamecost = 1000000, heart = 500000, randserial = -1 where gameid = @gameid_

				exec spu_RoulBuyNewTest @gameid_, @password_, @mode, @friendid_, @curloop, -1
				set @curloop = @curloop + 1
				set @cnt = @cnt + 1
			end

		select @famelv famelv
		--exec spu_FarmD 19, 412,-1, -1, -1, -1, -1, -1, -1, -1, '', @dateid8, '', '', '', '', '', '', '', ''				-- 유저 뽑기월서브 통계

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

select 'DEBUG ', @cnt cnt