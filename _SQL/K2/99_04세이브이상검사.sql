
-- farm65888
--select * from dbo.tFVUserData2 where gameid = 'farm72977' order by idx desc
--select * from dbo.tFVUserData where gameid = 'farm72977' order by idx desc
-- select * from dbo.tFV
-- ���� �÷��� ����Ÿ�� �ֱٰ�.
-- select * from dbo.tFVUserData2 where gameid = (select top 1 gameid from dbo.tUserMaster where kakaouserid = '91188455545412242' order by idx desc) order by idx desc

-- select * from dbo.tFVUserData2 where gameid = 'farm65888' order by idx desc
-- â�� ���� (201), ���� ����(210), â�� ���ʽ� ����( 221)
-- ��üǮ(�Ǹ�)		: 1491
-- ��üǮ(�ڿ�Ǯ)	: 1489		(����)
-- ó������			: 112		(�� �ڿ� ǮǮ)
-- ó������			: 112		(��)
-- ó������			: 2323		(2040�� â�� ����, �ʱ����)
-- �۹� �ܰ��� �۾� : 2037		(��4)
-- �۹� �ܰ��� �۾� : 2049		(��15)
-- �۹� �ܰ��� �۾� : 2054		(��20)
-- �۹� �ܰ��� �۾� : 2059		(��25)
-- �۹� �ܰ��� �۾� : 2064		(��30)

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