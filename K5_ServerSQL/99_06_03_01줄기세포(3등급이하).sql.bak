use Game4Farmvill5
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- 영선핸드폰
--set @kakaouserid = '91188455545412245'	--기철
--set @kakaouserid = '88470968441492992'	-- 임과장폰
--set @kakaouserid = '91188455545412246'	-- 보람


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.', @gameid, @kakaostatus, @deletestate
	end
select 'DEBUG ', @gameid, @kakaostatus, @deletestate
--delete from dbo.tGiftList where gameid = @gameid
--delete from dbo.tUserItem where gameid = @gameid and invenkind = 1040
--update dbo.tUserItem set upcnt = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0 where gameid = @gameid and invenkind = 1

-- 1. 정보 읽어서 선물하기.
declare curAnimal Cursor for
select itemcode from dbo.tItemInfo where category = 1040 and grade < 3

-- 2. 커서오픈
open curAnimal

-- 3. 커서 사용
Fetch next from curAnimal into @itemcode
while @@Fetch_status = 0
	Begin
		--exec spu_SubGiftSendNew 2, @itemcode,  1, '테스트선물', @gameid, ''
		exec spu_SetDirectItem @gameid, @itemcode, 1, -1
		Fetch next from curAnimal into @itemcode
	end

-- 4. 커서닫기
close curAnimal
Deallocate curAnimal

