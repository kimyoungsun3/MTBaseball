use Game4Farmvill5
GO


-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @mode			int				
declare @deletestate	int				set @deletestate= -1
declare @rs				int	
declare @loop			int				set @loop		=  0

set @kakaouserid	= '91188455545412243'	-- PC
set @mode			= 1 -- 일반(1), 캐쉬(2), 캐쉬10(4)


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus, @password = password from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end

while(@loop < 100)
	begin
		set @rs =  Convert(int, ceiling(RAND() *    100000))
		exec spu_RoulBuyNew @gameid, @password, 1, '', @rs, -1			-- 일반뽑기
		set @loop = @loop + 1
	end


/*
declare @gameid			varchar(20) 	set @gameid		= 'farm283891'
select i.grade, count(*) cnt from 
	( select * from dbo.tItemInfo )i 
		join 
	(select * from dbo.tUserItem where gameid = @gameid and invenkind = 1 ) u
		on i.itemcode = u.itemcode
group by i.grade
order by i.grade asc

delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind = 1 and itemcode != 227
*/