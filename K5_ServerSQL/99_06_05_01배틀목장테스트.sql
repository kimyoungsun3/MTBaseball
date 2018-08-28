use GameMTBaseball
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60),
		@password		varchar(20),
		@battleticket	int,
		@battleidx2		int,
		@listidx		int,
		@listset		varchar(40),
		@itemcode		int,
		@playcnt		int
declare @gameid			varchar(20) 	set @gameid		= ''
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- 영선핸드폰

-- 초기화.
--update dbo.tUserMaster set battleticket = battleticketmax where gameid = (select top 1 gameid from dbo.tUserMaster where kakaouserid = @kakaouserid order by idx desc)
--update dbo.tUserFarm set playcnt = 10 where gameid = (select top 1 gameid from dbo.tUserMaster where kakaouserid = @kakaouserid order by idx desc)

-- 유저정보 읽어오기.
select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @password = password, @battleticket 	= battleticket, @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end


-- 동물리스트 정보 읽어오기.
select top 1 @listidx = listidx from dbo.tUserItem where gameid = @gameid and invenkind = 1
set @listset = '0:' + ltrim(rtrim(str(@listidx))) + ';'
select 'DEBUG ', @gameid gameid, @password password, @battleticket battleticket, @listidx listidx, @listset listset
select 'DEBUG ', itemcode, playcnt from dbo.tUserFarm where gameid = @gameid and buystate = 1 and playcnt > 0

-- 1. 정보 읽어서 선물하기.
declare curFarmList Cursor for
select itemcode, playcnt from dbo.tUserFarm
where gameid = @gameid and buystate = 1 and playcnt > 0
order by itemcode asc

-- 2. 커서오픈
open curFarmList

-- 3. 커서 사용
Fetch next from curFarmList into @itemcode, @playcnt
while @@Fetch_status = 0
	Begin
		select 'DEBUG step1', @itemcode itemcode, @playcnt playcnt, @battleticket battleticket
		while( @playcnt > 0 )
			begin
				select 'DEBUG step2', @itemcode itemcode, @playcnt playcnt, @battleticket battleticket

				-- 배틀시작.
				exec spu_AniBattleStart @gameid, @password, @itemcode, @listset, -1

				-- 번호.
				set @battleidx2 = 1
				select @battleidx2 = isnull( max( idx2 ), 0 ) from dbo.tBattleLog where gameid = @gameid
				--select 'DEBUG step2', @battleidx2 battleidx2

				-- 배틀완료 결과.
				exec spu_AniBattleResult @gameid, @password, @battleidx2,  1, 90, 3, -1


				-- 수량검사.
				set @battleticket 	= @battleticket - 4
				set @playcnt		= @playcnt - 1
				if( @battleticket < 4 )
					begin
						select 'DEBUG 종료'
						return;
					end
			end

		Fetch next from curFarmList into @itemcode, @playcnt
	end

-- 4. 커서닫기
close curFarmList
Deallocate curFarmList

