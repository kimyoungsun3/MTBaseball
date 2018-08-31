
-- farm65888
--select * from dbo.tFVUserData2 where gameid = 'farm72977' order by idx desc
--select * from dbo.tFVUserData where gameid = 'farm72977' order by idx desc
-- select * from dbo.tFV
-- 현재 플레이 데이타중 최근것.
-- select * from dbo.tFVUserData2 where gameid = (select top 1 gameid from dbo.tUserMaster where kakaouserid = '91188455545412242' order by idx desc) order by idx desc

-- select * from dbo.tFVUserData2 where gameid = 'farm65888' order by idx desc
-- 창고 레벨 (201), 건초 갯수(210), 창고 보너스 레벨( 221)
-- 전체풀(판매)		: 1491
-- 전체풀(자원풀)	: 1489		(끝판)
-- 처음시작			: 112		(돈 자원 풀풀)
-- 처음시작			: 112		(돈)
-- 처음시작			: 2323		(2040년 창고만 만땅, 초기상태)
-- 작물 단계적 작업 : 2037		(촉4)
-- 작물 단계적 작업 : 2049		(촉15)
-- 작물 단계적 작업 : 2054		(촉20)
-- 작물 단계적 작업 : 2059		(촉25)
-- 작물 단계적 작업 : 2064		(촉30)

/*
declare @tokakaouserid	varchar(60),
		@togameid		varchar(60),
		@fromsavedata	varchar(4096),
		@fromidx		int

set @fromidx		= 2323
set @tokakaouserid	= '91188455545412242'

select @fromsavedata = savedata from dbo.tFVUserData2 where idx = @fromidx
select top 1 @togameid = gameid from dbo.tUserMaster where kakaouserid = @tokakaouserid order by idx desc
select @fromidx fromidx, @togameid gameid
if(not exists(select top 1 * from dbo.tFVUserData where gameid = @togameid))
	insert into dbo.tFVUserData(gameid,   savedata)values(@togameid, @fromsavedata)
else
	update dbo.tFVUserData set savedata = @fromsavedata where gameid = @togameid

*/