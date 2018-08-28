use Game4Farmvill5
GO

-- ���������ϱ�.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- �����ڵ���
--set @kakaouserid = '91188455545412245'	--��ö
--set @kakaouserid = '88470968441492992'	-- �Ӱ�����
--set @kakaouserid = '91188455545412246'	-- ����


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.', @gameid, @kakaostatus, @deletestate
	end
--delete from dbo.tBattleLog where gameid = @gameid

select
	gameid,
	i.itemcode, i.itemname,
	case when result = -1 then '��(-1)' when result = 1 then '��(1)' when result = 0 then '���۸�(0)' else '��' end '���',
	playtime, star,
	enemydesc,
	anidesc1, anidesc2, anidesc3,--anidesc4, anidesc5,
	ts1name, ts2name, ts3name, ts4name, ts5name
	from dbo.tBattleLog b
		JOIN
		dbo.tItemInfo i
		ON b.farmidx = i.itemcode
where gameid = @gameid
	  -- and result != 0 -- ��(-1), ��(1), ���۸��ѵ���Ÿ(0)
order by i.itemcode desc, b.idx desc
