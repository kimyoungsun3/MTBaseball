-- select * from dbo.tFVGiftList where gameid = 'xxxx2' and itemcode in (80015,80025,80035,80045,80055,80065)
-- select * from dbo.tFVGiftList where gameid = 'xxxx2' and itemcode in (80014,80024,80034,80044,80054,80064)
--
-- update dbo.tFVUserMaster set version = 117 where gameid = 'xxxx2'		delete from dbo.tFVGiftList where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set version = 199 where gameid = 'xxxx2'		delete from dbo.tFVGiftList where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set version = 199, market = 7 where gameid = 'xxxx2'		delete from dbo.tFVGiftList where gameid = 'xxxx2'

-- 초기화
declare @gameid_		varchar(60),
		@password_		varchar(20),
		@randserial_	varchar(20),
		@mode			int,
		@dateid8 		varchar(8),
		@loopmax 		int,
		@curloop		int,
		@bestani		int,
		@bestaniend		int,
		@idx			int

set @mode			= 4		-- DC(1), CB(2), BA(3), BAS+(4)
set @loopmax		= 100	--        CB(12),BA(13),BAS+(14)
set @bestani		= 500	-- 500~ 539
set @bestaniend		= 539
set @dateid8 		= Convert(varchar(8),Getdate(),112)
set @gameid_		= 'xxxx2'
set @password_		= '049000s1i0n7t8445289'

while(@bestani <= @bestaniend)
	begin
		set @curloop 		= 1

		--------------------------------------------------
		-- 	사전데이타 삭제.
		--------------------------------------------------
		--delete from dbo.tFVGiftList where gameid = @gameid_					-- 개인선물
		delete from dbo.tFVRouletteLogPerson where gameid = @gameid_		-- 개인뽑기
		delete from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8	-- 전체뽑기
		delete from dbo.tFVRouletteLogTotalSub where dateid8 = @dateid8		-- 전체뽑기

		--update dbo.tFVUserMaster set market = 5 where gameid = @gameid_
		update dbo.tFVUserMaster set bestani = @bestani, tsgrade1cnt = 0, tsgrade2cnt = 0, tsgrade3cnt = 0, tsgrade4cnt = 0 where gameid = @gameid_


		while(@curloop <= @loopmax)
			begin
				update dbo.tFVUserMaster set bestani = @bestani, randserial = -1, ownercashcost = 100, tsgrade2gauage = 0, tsgrade3gauage = 0, tsgrade4gauage = 0, tsgrade2free = 1, tsgrade3free = 1, tsgrade4free = 1 where gameid = @gameid_
				set @randserial_	= @curloop

				exec spu_FVRoulBuy @gameid_, @password_, @mode, 'savedata1', @randserial_, -1
				set @curloop = @curloop + 1

				-------------------------------------------------
				--update dbo.tFVUserMaster set randserial = -1, ownercashcost = 100, tsgrade1cnt = 0, tsgrade2cnt = 0, tsgrade3cnt = 0, tsgrade4cnt = 0, tsgrade2gauage = 0, tsgrade3gauage = 0, tsgrade4gauage = 0, tsgrade2free = 1, tsgrade3free = 1, tsgrade4free = 1 where gameid in ('xxxx2', 'xxxx6')
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289', 1, 'savedata1', 7776, -1			-- D, C
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289', 2, 'savedata2', 7777, -1			-- B, A
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289', 3, 'savedata3', 7778, -1			-- A, S
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289', 4, 'savedata4', 7779, -1			-- A, S (3 + 1)
				--
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289',12, 'savedata12', 7777, -1			-- B, A
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289',13, 'savedata13', 7778, -1			-- A, S
				--exec spu_FVRoulBuyTest 'xxxx2', '049000s1i0n7t8445289',14, 'savedata14', 7779, -1			-- A, S (3 + 1)
				-------------------------------------------------
			end

		select @bestani bestani
		exec spu_FVFarmD 19, 412,-1, -1, -1, -1, -1, -1, -1, -1, '', @dateid8, '', '', '', '', '', '', '', ''				-- 유저 뽑기월서브 통계


		set @bestani = case
							when @bestani <= 500 then 505
							when @bestani <= 505 then 509
							when @bestani <= 509 then 511
							when @bestani <= 511 then 513
							when @bestani <= 513 then 516
							when @bestani <= 516 then 520
							when @bestani <= 520 then 524
							when @bestani <= 524 then 526
							when @bestani <= 526 then 528
							when @bestani <= 528 then 530
							when @bestani <= 530 then 532
							when @bestani <= 532 then 534
							when @bestani <= 534 then 536
							when @bestani <= 536 then 538
							when @bestani <= 538 then 540
							else                      540
						end
	end