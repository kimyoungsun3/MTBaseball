use Game4FarmVill4
GO

declare @kakaouserid	varchar(60),
		@gameid			varchar(60),
		@itemcode		int,
		@category		int,
		@cnt			int
set @kakaouserid	= '91188455545412242'	-- PC
--set @kakaouserid	= '91188455545412249'	-- PC 선훈
--set @kakaouserid	= '88255137081585760'	-- 만종이폰
--set @kakaouserid	= '88812599272546640'	-- 최정기
--set @kakaouserid	= '88141973561720689'	-- 준식
--set @kakaouserid	= '90396051283528689'	-- 임진혁
--set @kakaouserid	= '88294959671580064'	-- 김태민
--set @kakaouserid	= '88072204762769425'	-- 최창규
--set @kakaouserid	= '92064568193308403'	-- 박인규
--set @kakaouserid	= '88114671263625504'	-- 김선훈
--set @kakaouserid	= '88103356826892544'	-- 이대표
--set @kakaouserid	= '88258263875124913'	-- 핸드폰

select top 1 @gameid = gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid order by idx desc
delete from dbo.tFVGiftList where gameid = @gameid


declare curUserFarmTech Cursor for
--select itemcode, category from dbo.tFVItemInfo where category in (60, 30) order by itemcode desc
select itemcode, category from dbo.tFVItemInfo where category in (60) order by itemcode desc
--select itemcode, category from dbo.tFVItemInfo where category in (30) order by itemcode asc


-- 2. 커서오픈
open curUserFarmTech

-- 3. 커서 사용
Fetch next from curUserFarmTech into @itemcode, @category
while @@Fetch_status = 0
	Begin

		if(@category = 60)
			begin
				--exec spu_FVSubGiftSend 2, @itemcode,  1, 'blackm', @gameid, ''
				exec spu_FVSubGiftSend 2, @itemcode, 20, 'blackm', @gameid, ''
			end
		else if(@category = 30)
			begin
				exec spu_FVSubGiftSend 2, @itemcode, 1000, 'blackm', @gameid, ''
			end

		Fetch next from curUserFarmTech into @itemcode, @category
	end
	-- 4. 커서닫기
close curUserFarmTech
Deallocate curUserFarmTech

exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''			-- VIP포인트
exec spu_FVSubGiftSend 2, 3700, 500000, 'blackm', @gameid, ''			-- 별
exec spu_FVSubGiftSend 2, 3400, 500000, 'blackm', @gameid, ''			-- 건초
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''			-- 결정
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
