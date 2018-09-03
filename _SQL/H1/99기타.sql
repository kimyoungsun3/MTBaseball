/*
---------------------------------------------
--  ĳ���ͺ� Ŀ���͸���¡ ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserGoogleBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserGoogleBuyLog;
GO
create table dbo.tUserGoogleBuyLog(
	idx			int 					IDENTITY(1, 1),

	gameid		varchar(20),
	buydate		datetime				default(getdate()),
	buypoint	int						default(0),

	-- Constraint
	CONSTRAINT pk_tUserGoogleBuyLog_gameid	PRIMARY KEY(gameid)
)
--4945	tjdwowns2			2916780002XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	1584	99000	2013-08-28 23:29:59.597	 GOOGLE ��(����,�ڵ���) / ���� / �ϰ�����
--4944	tjdwowns2			6067891113XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	1584	99000	2013-08-28 23:25:20.443	 GOOGLE ��(����,�ڵ���) / ���� / �ϰ�����
-- insert into dbo.tUserGoogleBuyLog(gameid) values(@gameid_)
-- update dbo.tUserGoogleBuyLog set buypoint = buypoint + 10 where gameid = @gameid_
-- select * from dbo.tUserGoogleBuyLog where gameid = @gameid_

if(@market_ in (@MARKET_GOOGLE, MARKET_GOOGLE2))
	begin
		if(select top 1 * from dbo.tUserGoogleBuyLog where gameid = @gameid_)
			begin
				insert into dbo.tUserGoogleBuyLog(gameid) values(@gameid_)
			end
		else
			begin
				declare @buydate 		datetime,
						@buypointmin 	int,
						@buypoint	 	int	
						@buypointplus 	int,					
						@cashpoint		int

				select @buydate = buydate, @buypoint = buypoint from dbo.tUserGoogleBuyLog where gameid = @gameid_ 
				set @buypointmin 	= datediff(s, @buydate, getdate())/60				
				set @buypointplus	= 0
				select 'DEBUG ', @buydate '������', getdate()'������', @buypointmin '���͹�Ÿ��', @buypoint buypoint

				set @cashpoint = CASE 
									WHEN (@cash_ =  1500) then 1
									WHEN (@cash_ =  5000) then 5
									WHEN (@cash_ =  9900) then 9
									WHEN (@cash_ = 29000) then 29
									WHEN (@cash_ = 50000) then 59
									WHEN (@cash_ = 99000) then 99
									ELSE 100 
								END
				set @buypointplus = CASE 
										WHEN (@buypointmin <= 0) then 100
										WHEN (@buypointmin <= 5) then 80
										WHEN (@buypointmin <= 10) then 60
										WHEN (@buypointmin <= 20) then 40
										WHEN (@buypointmin <= 40) then 20
										WHEN (@buypointmin <= 60) then 10
										ELSE 0 
									END
				select 'DEBUG ', @cashpoint cashpoint, @buypointplus buypointplus

				if(@buypoint + @buypointplus > 18000)
					begin
						-- ���� �ڵ������� �Ȱ� ��(''�� ����)
						-- �� �ڵ������(''�� ����)
						-- �� ���̵�üŷ
					end
			end	
	end
*/

/*
---------------------------------------------
-- �̺�Ʈ �������̺�
---------------------------------------------
create table dbo.tEventCertUser(
	idx			int				identity(1, 1),

	gameid		varchar(20),
	usedtime	datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertUser_idx	PRIMARY KEY(idx)
)

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertUser_gameid')
    DROP INDEX tEventCertUser.idx_tEventCertUser_gameid
GO
CREATE INDEX idx_tEventCertUser_gameid ON tEventCertUser (gameid)
GO
-- select * from dbo.tEventCertUser where gameid = 'xxxx'
-- delete from dbo.tEventCertUser where gameid = 'sususu2'
*/





/*
-- select * from dbo.tCashLog order by writedate desc

-- alter table dbo.tCashLog add ikind			varchar(256)
-- update dbo.tCashLog set ikind = '' where ikind is null
-- alter table dbo.tCashLog add idata			varchar(4096)
-- update dbo.tCashLog set idata = acode where idata is null
-- alter table dbo.tCashLog add idata2			varchar(4096)
-- update dbo.tCashLog set idata2 = acode where idata2 is null
*/



/*
---------------------------------------------
-- 	���� ���� ���
---------------------------------------------
IF OBJECT_ID (N'dbo.tSMSRecommend', N'U') IS NOT NULL
	DROP TABLE dbo.tSMSRecommend;
GO

create table dbo.tSMSRecommend(
	idx				int				identity(1, 1),
	comment			varchar(512),
	url				varchar(512),
	writedate		datetime		default(getdate()),
	gamekind		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tSMSRecommend_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tSMSRecommend add gamekind			int				default(1)
-- update dbo.tSMSRecommend set gamekind = 1 where gamekind is null
-- select top 1 * from dbo.tSMSRecommend order by idx desc

*/

/*
--delete from dbo.tCashTotal where idx in (1283, 1282, 1281, 1280, 1279, 1278)
update dbo.tCashTotal
	set
		cashkind = 99000
where idx = 1275

update dbo.tCashTotal
	set
		cashkind = 50000
where idx = 1274

update dbo.tCashTotal
	set
		cashkind = 29000
where idx = 1276

*/

/*
select * from dbo.tCashLog where market = 7
select * from dbo.tCashTotal where market = 7

-- 1-1. ���� ����
declare @idx 		int
declare @cash		int
declare @writedate 	datetime
declare @dateid		varchar(8)

-- 2-1. Ŀ�� ����
declare curCashLog Cursor for
select idx, cash, writedate from dbo.tCashLog where market = 7

-- 2-2. Ŀ������
open curCashLog

-- 2-3. Ŀ�� ���
Fetch next from curCashLog into @idx, @cash, @writedate
while @@Fetch_status = 0
	Begin
		set @dateid = convert(varchar(8), @writedate, 112)
		--select @dateid
		if(@cash = 199)
			begin
				select '199 -> 1500', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 1500
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 1500
				where dateid = @dateid and cashkind = @cash
			end
		else if(@cash = 499)
			begin
				select '499 -> 5000', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 5000
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 5000
				where dateid = @dateid and cashkind = @cash
			end
		else if(@cash = 899)
			begin
				select '899 -> 9900', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 9900
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 9900
				where dateid = @dateid and cashkind = @cash
			end
		else if(@cash = 2699)
			begin
				select '2699 -> 29000', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 29000
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 29000
				where dateid = @dateid and cashkind = @cash
			end
		else if(@cash = 4599)
			begin
				select '4599 -> 50000', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 50000
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 50000
				where dateid = @dateid and cashkind = @cash
			end
		else if(@cash = 8999)
			begin
				select '8999 -> 99000', * from dbo.tCashLog where idx = @idx
				select * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash

				update dbo.tCashLog
					set
						cash = 99000
				where idx = @idx

				update dbo.tCashTotal
					set
						cash = cash - @cash + 99000
				where dateid = @dateid and cashkind = @cash
			end
		Fetch next from curCashLog into @idx, @cash, @writedate
	end

-- 2-4. Ŀ���ݱ�
close curCashLog
Deallocate curCashLog
*/

/*
A0CC56794DA74C4A
0ED0422B7C1141D1
271FE60A65A3424C
143CD873198B441E
6B3285DE317E4EBF
9B06B6E50E924A13
5380B3523F9B4561
24B41389B8004F55



select top 50 * from dbo.tEventCertNo order by idx desc
declare @noloop 	int
declare @nomax 		int
declare @newid		uniqueidentifier
declare @newid2		varchar(256)
declare @certno		varchar(16)

set @noloop 	= 1
set @nomax 		= 10

while(@noloop < @nomax)
	begin
		-- ������ȣ ���� > [-] ���� > 16�ڸ���(�˾Ƽ� ©���� ������)
		SET @newid = NEWID()
		set @newid2 = replace(@newid, '-', '')
		SET @certno = @newid2
		--select @newid, @newid2, @certno
		--80D9B780-5F99-4AE9-A59C-08301077285F	80D9B7805F994AE9A59C08301077285F	80D9B7805F994AE9

		-- ������ȣ �ߺ��ΰ�?
		if(not exists(select top 1 * from dbo.tEventCertNo where certno = @certno))
			begin
				insert into dbo.tEventCertNo(certno) values(@certno)
			end
		else
			begin
				select '�ߺ�:' + @certno
			end

		set @noloop = @noloop + 1
	end
*/

----------------------------------------------------------------

/*
select * from dbo.tUserPushiPhone
select * from dbo.tUserPushAndroid
*/

/*
select top 10 * from dbo.tTotoUser where totoid = 143
select top 10 * from dbo.tTotoUser where totoid in (123, 124, 125, 126)

select silverball, * from dbo.tUserMaster where gameid in (select gameid from dbo.tTotoUser where totoid in (123, 124, 125, 126))
--select top 10 * from dbo.tTotoUser where totoid = 18
update dbo.tTotoUser
	set
		chalresult1 = -1, chalresult2 = -1,
		chalstate	= 1,
		givedate	= null
where  totoid in (123, 124, 125, 126)

update dbo.tTotoUser
	set
		chalresult1 = -1, chalresult2 = -1,
		chalstate	= 1,
		givedate	= null
where  totoid in (124)

*/

/*

select top 10 * from dbo.tUserMaster order by condate desc

select COUNT(*) from dbo.tUserMaster where condate > '2013-03-20'


select getdate(), dateadd(d, 1, getdate()), dateadd(d, -1, getdate())
select COUNT(*) from dbo.tUserMaster where condate > dateadd(d, -7, getdate())
select * from dbo.tUserMaster where condate > dateadd(d, -7, getdate())

exec spu_HomerunD 19, 6000, -1, 701, -1, -1, -1, -1, -1, -1, 'blackm', '', '', '', ''

*/

/*
--delete from dbo.tTotoUser where totoid = 17
exec sup_TotoRegister 'guest74466', '3357091y7k5m7v257919', 17, 2, 1000,  2, 1, -1
exec sup_TotoRegister 'guest74465', '6802007e8t4h0p462444', 17, 2, 1000,  2, 2, -1
exec sup_TotoRegister 'guest74464', '8598023k6z3i4f689522', 17, 2, 1000,  2, 3, -1
exec sup_TotoRegister 'guest74463', '0056861i7j2a2r443821', 17, 2, 1000,  2, 4, -1

exec spu_TotoCheck 17
*/

/*
declare @gameid_ varchar(20)
set @gameid_ = 'sususu'

			select
				m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
				isnull(chalstate, -1) chalstate,
				isnull(u.chalmode, -1) chalmode, isnull(u.chalbat, -1) chalbat,
				isnull(chalsb, -1) chalsb,

				--isnull(chalcountry, -1) chalcountry,
				case when (isnull(chalresult1, -1) = 0 or isnull(chalresult2, -1) = 0) then -1 else isnull(chalcountry, -1) end chalcountry,

				isnull(chalpoint, -1) chalpoint,
				isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
				--, u.*
					from
						dbo.tTotoMaster m
							LEFT OUTER JOIN
						(select * from dbo.tTotoUser where gameid = @gameid_) u
							on m.totoid = u.totoid
								where active = 1
				order by chalmode1give asc, totodate asc
*/

/*
select * from dbo.tUserMaster where ccode > 10
update dbo.tUserMaster set ccode = 2 where ccode > 10
select * from dbo.tBattleCountry where ccode > 10 and dateid = '201303'
delete from dbo.tBattleCountry where ccode > 10 and dateid = '201303'
*/

/*
declare @loop int set @loop = 1
while @loop < 7
	begin
		exec spu_BattleSearch 'superman7', '', 5, 0, -1			--���Ӱ˻� ������ > �ٸ������� ����
		--exec spu_BattleSearch 'superman7', '', 5, 1, -1			--���Ӱ˻� ������ > ó������
		--exec spu_BattleSearch 'superman7', 'superman', 5, 0, -1	--���Ӱ˻� ������ �ٸ������� ����		-- �˻� > ������ �ٸ������˻�(©����� ���� �־� Ȯ����)
		--exec spu_BattleSearch 'superman7', 'superman', 5, 1, -1	--���Ӱ˻� ������ > ó������			-- �˻� > ������ ó������(©����� ���� �־� Ȯ����)

		--exec spu_BattleSearch 'superman7', 'mogly', 5, 0, -1		-- ����ó��
		--exec spu_BattleSearch 'superman7', 'mogly', 5, 1, -1
		set @loop = @loop + 1
	end
*/

/*
alter table dbo.tActionInfo add plussilverball			int				default(0)
update dbo.tActionInfo set plussilverball = 0
*/


/*
alter table dbo.tTotoMaster add chalmode1winsb	int				default(0)
alter table dbo.tTotoMaster add chalmode2winsb	int				default(0)

update dbo.tTotoMaster set chalmode1winsb = 0
update dbo.tTotoMaster set chalmode2winsb = 0

--------------------------------------------
-- 1-1. ���� ����
-- select * from dbo.tTotoMaster
-- select m.totoid, isnull(m.victcountry, -1), isnull(m.victpoint, -1), u.chalmode, u.chalsb, u.chalcountry, u.chalpoint from dbo.tTotoMaster m join dbo.tTotoUser u on m.totoid = u.totoid order by totoid desc
declare @totoid				int
declare @victcountry		int
declare @victpoint			int
declare @chalmode			int
declare @chalsb				int
declare @chalcountry		int
declare @chalpoint			int


-- 2-1. Ŀ�� ����
declare curTotoWinsb Cursor for
select m.totoid, isnull(m.victcountry, -1), isnull(m.victpoint, -1), u.chalmode, u.chalsb, u.chalcountry, u.chalpoint
from dbo.tTotoMaster m join dbo.tTotoUser u
	on m.totoid = u.totoid

-- 2-2. Ŀ������
open curTotoWinsb

-- 2-3. Ŀ�� ���
Fetch next from curTotoWinsb into @totoid, @victcountry, @victpoint, @chalmode, @chalsb, @chalcountry, @chalpoint
while @@Fetch_status = 0
	Begin
		if(@victcountry != -1 and @victcountry = @chalcountry)
			begin
				update dbo.tTotoMaster
					set
						chalmode1winsb = chalmode1winsb + (case when @chalmode = 1 then @chalsb*2 else 0 end),
						chalmode2winsb = chalmode2winsb + (case when (@chalmode = 2 and (@chalpoint >= @victpoint and @chalpoint <= @victpoint + 2)) then @chalsb*4 else 0 end)
				where totoid = @totoid
			end
		Fetch next from curTotoWinsb into @totoid, @victcountry, @victpoint, @chalmode, @chalsb, @chalcountry, @chalpoint
	end

-- 2-4. Ŀ���ݱ�
close curTotoWinsb
Deallocate curTotoWinsb

*/

/*
alter table dbo.tTotoMaster add chalmode1sb	int				default(0)
alter table dbo.tTotoMaster add chalmode2sb	int				default(0)

update dbo.tTotoMaster set chalmode1sb = 0
update dbo.tTotoMaster set chalmode2sb = 0

--------------------------------------------
-- 1-1. ���� ����
-- select * from dbo.tTotoMaster
-- select totoid, sum(chalsb) from dbo.tTotoUser group by totoid
declare @totoid				int
declare @chalmode			int
declare @chalsb				int


-- 2-1. Ŀ�� ����
declare curTotoBat Cursor for
select totoid, chalmode, chalsb from dbo.tTotoUser

-- 2-2. Ŀ������
open curTotoBat

-- 2-3. Ŀ�� ���
Fetch next from curTotoBat into @totoid, @chalmode, @chalsb
while @@Fetch_status = 0
	Begin
		update dbo.tTotoMaster
			set
				chalmode1sb = chalmode1sb + (case when @chalmode = 1 then @chalsb else 0 end),
				chalmode2sb = chalmode2sb + (case when @chalmode = 2 then @chalsb else 0 end)
		where totoid = @totoid
		Fetch next from curTotoBat into @totoid, @chalmode, @chalsb
	end

-- 2-4. Ŀ���ݱ�
close curTotoBat
Deallocate curTotoBat
*/

/*
-- ���ݱ�������
select m.gameid, m.regdate '���ʵ����', m.condate '�ֱ�������', c.cash '���űݾ�', c.writedate '������'
from dbo.tUserMaster m join dbo.tCashLog c on m.gameid = c.gameid
order by gameid desc, c.writedate asc


-- 3�� 4��(��) ~ 10��(��) ���� ���� ����� �ִ� ���� �� ���� ����
-- �̰��� ������, �÷��� Ƚ��.(�ش� �Ⱓ �ٿ�ε��� �� ���� �ٿ�ε��� ����)
--n ID ������ �ƴ� ����ȣ �������� ������ �� �÷��� Ƚ�� ���� ��Ź�帳�ϴ�.
--n �ش� �м��� ������� ���� �庮�� ���� �м� �� ������ �÷� ������
select count(*) from dbo.tBattleLog
where gameid in (select gameid from dbo.tCashLog where writedate > '2013-03-04')
	and writedate > '2013-03-04'

select count(*) from dbo.tBattleLog
where writedate > '2013-03-04'


-- ���� ���� ���� ī��Ʈ
n ���� ���� �������� ��Ī �������� ���� ���� ���� �߻��� ������ ������
�ο��� ī����
���� �ο�
24 9
25 2
select lv, count(*) from dbo.tUserMaster
group by lv
order by 1

select grade, count(*) from dbo.tUserMaster
group by grade
order by 1


-- ��ü �̿��� �� ���� ���� ��� ������ �������� ���� ������/�ʰ���������
n ���� ��շ��� ���� ���� ������ �� �ֵ��� ������ ����
�������� ��� : 17
17�̻� : 2074
17�̸� : 36637
select avg(lv) from dbo.tUserMaster
where gameid in (select gameid from dbo.tCashLog)
select count(lv) from dbo.tUserMaster where lv >= 17
select count(lv) from dbo.tUserMaster where lv < 17

*/
/*
-- ������ ������ ���� ����
exec spu_UserCreate 'supermani', '049000s1i0n7t8445289', 'supermani@naver.com', 7, 0, 2, 1, 'ukukukuk', 100, '01011112217', '089c5cfc3ff57d1aca53be9df1d8d47c02601fb2820caef4b5a0db92909f292c', -1

exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 1, '�ܼ�����', '�ܼ����� http://m.naver.com', -1, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 3, 'URL����', 'http://m.naver.com', -1, -1

select * from dbo.tUserPushiPhone
select * from dbo.tUserPushiPhoneLog
*/
/*
---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhone;
GO

create table dbo.tUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)

---- Push�Է��ϱ�
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhoneLog;
GO

create table dbo.tUserPushiPhoneLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)


*/


/*
update dbo.tMessage
	set
		newmsg = 1
where gameid = @gameid_ and idx = 1
*/

/*
alter table dbo.tMessage add newmsg		int					default(1)
update dbo.tMessage set newmsg = 1

----------------------------------------------------------------------------------
declare @gameid_		varchar(20)
declare @newmsg			int
set @gameid_	= 'sususu'
set @newmsg		= 1

select top 10 sendid, comment, idx, convert(varchar(16), writedate, 20) as writedate, newmsg from dbo.tMessage
where gameid = @gameid_  order by idx desc

select top 1 @newmsg = newmsg from dbo.tMessage where gameid = @gameid_ order by idx desc
if(@newmsg = 1)
	begin
		--select 'DEBUG 10-1 �޼��� ���°� ����'
		update dbo.tMessage
			set
				newmsg = 0
		where idx in (select top 10 idx from dbo.tMessage where gameid = @gameid_ and newmsg = 1 order by idx desc)
	end

*/
/*
-----------------------------------------------------------------------------------
declare @gameid_ varchar(20)
set @gameid_ = 'superman'
select
	m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
	isnull(chalstate, -1) chalstate,
	isnull(u.chalmode, -1) chalmode, isnull(chalsb, -1) chalsb, isnull(chalcountry, -1) chalcountry, isnull(chalpoint, -1) chalpoint,
	isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
	--, u.*
		from
			dbo.tTotoMaster m
				LEFT OUTER JOIN
			(select * from dbo.tTotoUser where gameid = @gameid_) u
				on m.totoid = u.totoid
					where active = 1
order by chalmode1give asc, totodate asc

-----------------------------------------------------------------------------------
--declare @gameid_ varchar(20)
set @gameid_ = 'superman7'
select
	m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
	isnull(chalstate, -1) chalstate,
	isnull(u.chalmode, -1) chalmode, isnull(chalsb, -1) chalsb, isnull(chalcountry, -1) chalcountry, isnull(chalpoint, -1) chalpoint,
	isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
	--, u.*
		from
			dbo.tTotoMaster m
				LEFT OUTER JOIN
			(select * from dbo.tTotoUser where gameid = @gameid_) u
				on m.totoid = u.totoid
					where active = 1
order by chalmode1give asc, totodate asc

-----------------------------------------------------------------------------------
--declare @gameid_ varchar(20)
set @gameid_ = 'superman6'
select
	m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
	isnull(chalstate, -1) chalstate,
	isnull(u.chalmode, -1) chalmode, isnull(chalsb, -1) chalsb, isnull(chalcountry, -1) chalcountry, isnull(chalpoint, -1) chalpoint,
	isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
	--, u.*
		from
			dbo.tTotoMaster m
				LEFT OUTER JOIN
			(select * from dbo.tTotoUser where gameid = @gameid_) u
				on m.totoid = u.totoid
					where active = 1
order by chalmode1give asc, totodate asc
*/


/*
---------------------------------------------
-- TotoMaster ������
---------------------------------------------
IF OBJECT_ID (N'dbo.tTotoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tTotoMaster;
GO

create table dbo.tTotoMaster(
	idx			int				identity(1, 1),

	totoid		int,
	totodate	varchar(16),
	totoday		int,

	title		varchar(128),
	acountry	int,
	bcountry	int,
	apoint		int					default(-1),		-- ���������� ȹ���� ����
	bpoint		int					default(-1),
	writedate	datetime			default(getdate()),

	active		int					default(-1),
	victcountry	int					default(-1),		-- ȹ���� ������ �������� �¸��� ����
	victpoint	int					default(-1),

	chalmode1cnt	int				default(0),
	chalmode2cnt	int				default(0),
	chalmode1give	int				default(-1),
	chalmode2give	int				default(-1),
	chalmode1wincnt	int				default(0),
	chalmode2wincnt	int				default(0),

	givedate	datetime,

	-- Constraint
	CONSTRAINT	pk_tTotoMaster_idx	PRIMARY KEY(idx)
)
--
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoMaster_totodate')
    DROP INDEX tTotoMaster.idx_tTotoMaster_totodate
GO
CREATE INDEX idx_tTotoMaster_totodate ON tTotoMaster (totodate)
GO

-- ToToid�� �˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoMaster_totoid')
    DROP INDEX tTotoMaster.idx_tTotoMaster_totoid
GO
CREATE INDEX idx_tTotoMaster_totoid ON tTotoMaster (totoid)
GO

-- select top 100 * from dbo.tTotoMaster order by totodate asc
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(1, '2013-02-25 13:30', 1, 'B�� ȣ�� : �븸', 2, 3)
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(2, '2013-02-25 19:00', 2, 'A�� �Ϻ� : �����', 2, 3)
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(3, '2013-02-25 20:30', 3, 'B�� ���ѹα� : �״�����', 2, 3)
-- update dbo.tTotoMaster
--	set
--		totodate 	= '2013-02-25 16:00',
--		totoday 	= 1,
--		title		= 'B�� ���ѹα� : �״�����',
--		acountry	= 2,
--		bcountry	= 3,
--		apoint		= 1,
--		bpoint		= 0,
--
--		active		= 1,
--		victcountry	= 2,
--		victpoint	= 1,		-- 1 -> 1 ~ 3
--	where totoid = 1
-- update dbo.tTotoMaster set active = -1 where totoid = 1
-- ����

---------------------------------------------
-- Toto ���� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tTotoUser', N'U') IS NOT NULL
	DROP TABLE dbo.tTotoUser;
GO

create table dbo.tTotoUser(
	idx				int				identity(1, 1),

	gameid		varchar(20),
	totoid		int,

	chalmode	int					default(1),
	chalbat		int					default(2),
	chalsb		int					default(500),
	chalcountry	int					default(-1),
	chalpoint	int					default(-1),
	writedate	datetime			default(getdate()),

	chalresult1	int					default(-1),
	chalresult2	int					default(-1),
	chalstate	int					default(-1),

	givedate	datetime,

	-- Constraint
	CONSTRAINT	pk_tTotoUser_idx	PRIMARY KEY(idx)
)
--
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoUser_gameid_totoid')
    DROP INDEX tTotoUser.idx_tTotoUser_gameid_totoid
GO
CREATE INDEX idx_tTotoUser_gameid_totoid ON tTotoUser (gameid, totoid)
GO
-- ������ Ŭ����
-- update dbo.tTotoMaster set chalmode1cnt = 0, chalmode2cnt = 0, chalmode1give = -1, chalmode2give = -1, chalmode1wincnt = 0, chalmode2wincnt = 0, givedate = null
-- delete from dbo.tMessage where gameid in ( 'superman6', 'superman7')

-- select top 100 * from dbo.tTotoUser order by idx desc
-- select * from dbo.tTotoUser where gameid = 'superman' order by idx desc
-- select top 100 * from dbo.tTotoUser where totoid = 1 order by idx desc
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  1,    1,        2,       500,    12,          -1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman2', 1,    2,        4,       500,    12,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman3', 1,    1,        2,       500,    13,          -1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman5', 1,    2,        4,       500,    13,          10)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  2,    2,        4,       500,    2,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  3,    2,        4,       500,    2,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  4,    2,        4,       500,    2,           1)
--select gameid, silverball from dbo.tUserMaster where gameid in ('superman', 'superman2', 'superman3', 'superman5')
--select top 2 * from dbo.tMessage where gameid = 'superman' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman2' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman3' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman5' order by idx desc
-- delete from dbo.tTotoUser where idx = 1		-- ������ ������ ���� ����
-- ����
-- select * from dbo.tTotoUser where totoid = 1 > Cursor
-- update dbo.tTotoUser set chalresult1 = 1, chalstate = 2, givedate = getdate() where idx = 1
-- update dbo.tTotoUser set chalresult2 = 2, chalstate = 2, givedate = getdate() where idx = 1
*/
/*
alter table dbo.tActionInfo add plusgoldball			int				default(0)
update dbo.tActionInfo set plusgoldball = 0
*/
/*
--�̺�Ʈ ����
--��Ʋ�� �� 9�� ����
declare @gameid varchar(20)			set @gameid = 'chanchau22'
declare @loop int					set @loop = 0

while(@loop < 3)
	begin
		exec spu_GiftSend @gameid, 6000, 'SangSang', -1, 0, 'adminid', 1
		exec spu_GiftSend @gameid, 6001, 'SangSang', -1, 0, 'adminid', 1
		exec spu_GiftSend @gameid, 6002, 'SangSang', -1, 0, 'adminid', 1
		exec spu_GiftSend @gameid, 6003, 'SangSang', -1, 0, 'adminid', 1
		exec spu_GiftSend @gameid, 6004, 'SangSang', -1, 0, 'adminid', 1
		set @loop = @loop + 1
	end
*/

/*
---------------------------------------------
--  ���� > 1ȸ�� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPayEvent', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPayEvent;
GO

create table dbo.tUserPayEvent(
	idx			int 				IDENTITY(1, 1),

	phone		varchar(20),
	market		int,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPayEvent_idx	PRIMARY KEY(idx)
)
-- phone, market
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPayEvent_phone_market')
    DROP INDEX tUserPayEventEvent.idx_tUserPayEvent_phone_market
GO
CREATE INDEX idx_tUserPayEvent_phone_market ON tUserPayEvent(phone, market)
GO

-- select * from dbo.tUserPayEvent where phone = '01022223333' and market = 3
-- insert into dbo.tUserPayEvent(phone, market) values('01022223333', 3)
-- select * from dbo.tUserPayEvent where phone = '01022223333'
-- delete from dbo.tUserPayEvent where idx = 1
*/


/*

select gameid, sum(silverball)/2 silverball from dbo.tUserItemUpgradeLog
where upgraderesult = 0 and silverball > 0
group by gameid
order by 1 desc

select gameid, silverball from dbo.tUserMaster
	where gameid in
	(select gameid from dbo.tUserItemUpgradeLog
	where upgraderesult = 0 and silverball > 0
	group by gameid)
order by 1 desc

--------------------------------------------
-- 1-1. ���� ����
declare @gameid 				varchar(20)
declare @silverball				int


-- 2-1. Ŀ�� ����
declare curItemUpgradeFailCost Cursor for
select gameid, sum(silverball)/2 silverball from dbo.tUserItemUpgradeLog
where upgraderesult = 0 and silverball > 0
group by gameid


-- 2-2. Ŀ������
open curItemUpgradeFailCost

-- 2-3. Ŀ�� ���
Fetch next from curItemUpgradeFailCost into @gameid, @silverball
while @@Fetch_status = 0
	Begin
		if(@silverball > 0)
			begin
				insert into tMessage(gameid, comment)
				values(@gameid, '��ȭ�� ������ �ǹ����� '+ltrim(rtrim(str(@silverball)))+' ������ ��Ƚ��ϴ�.')

				-- ���� ������ ����ϱ�
				update dbo.tUserMaster
					set
						silverball = silverball + @silverball
				where gameid = @gameid
			end

		Fetch next from curItemUpgradeFailCost into @gameid, @silverball
	end

-- 2-4. Ŀ���ݱ�
close curItemUpgradeFailCost
Deallocate curItemUpgradeFailCost

*/


/*
----------------------------------------------------
-- ������ �̺�Ʈ
-- ��Ʋ 5���� �˻� > �ش��������� �ǹ��� ����
----------------------------------------------------
--declare @sd varchar(16)		set @sd = '2013-02-14 21:00'
--declare @ed varchar(10)		set @ed = '2013-02-15'
declare @sd varchar(16)		set @sd = '2013-02-18 21:00'
declare @ed varchar(10)		set @ed = '2013-02-19'
select gameid, phone from dbo.tUserMaster where gameid in (
	select distinct gameid from dbo.tBattleLog where winstreak >= 5 and writedate >= @sd and writedate <= @ed )

-- 3000 SilverBall ����
update dbo.tUserMaster
	set
		silverball = silverball + 3000
where gameid in (select distinct gameid from dbo.tBattleLog where winstreak >= 5 and writedate >= @sd and writedate <= @ed )

-- ����
insert into tMessage(gameid, comment)
select distinct gameid, '��Ʋ 5���� �޼����� 3000�ǹ� �����ص�Ƚ��ϴ�.' from dbo.tBattleLog where winstreak >= 5 and writedate >= @sd and writedate <= @ed

*/


/*
---------------------------------------------
--  �α��� > ���ᰡ����(1ȸ���Ը�)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPay', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPay;
GO

create table dbo.tUserPay(
	idx			int 				IDENTITY(1, 1),

	phone		varchar(20),
	market		int,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPay_idx	PRIMARY KEY(idx)
)
-- phone, market
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPay_phone_market')
    DROP INDEX tUserPay.idx_tUserPay_phone_market
GO
CREATE INDEX idx_tUserPay_phone_market ON tUserPay(phone, market)
GO

-- select * from dbo.tUserPay where phone = '01022223333' and market = 1
-- insert into dbo.tUserPay(phone, market) values('01022223333', 1)
-- select * from dbo.tUserPay where phone = '01022223333'
-- delete from dbo.tUserPay where idx = 1
*/
/*

----------------------------------------------------
-- ����� �̺�Ʈ(��ü)
-- �̺�Ʈ ���� : �߷�Ÿ�ε��� �̺�Ʈ
-- �̺�Ʈ �Ⱓ : 2013�� 2�� 13�� ~ 18�� ����(�������� 19�� ���� ����)
-- �̺�Ʈ ���� : ���� �����ϸ� ������ 100% ����
-- ���� ��û���� : ���� �����ڰԿ� �Ҹ��� ������ 5�� ����(���� �������� 1���� �Ǵ� ���� �ٸ��� Ư�� ������ 5����)
----------------------------------------------------

---------------------------------------------
--  �α��� �̺�Ʈ
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tEventMaster;
GO

create table dbo.tEventMaster(
	idx			int 				IDENTITY(1, 1),

	gameid		varchar(20),
	dateid		varchar(8),
	eventcode	int,
	comment		varchar(128),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tEventMaster_idx	PRIMARY KEY(idx)
)
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventMaster_gameid_dateid_eventcode')
    DROP INDEX tEventMaster.idx_tEventMaster_gameid_dateid_eventcode
GO
CREATE INDEX idx_tEventMaster_gameid_dateid_eventcode ON tEventMaster(gameid, dateid, eventcode)
GO

-- select * from dbo.tEventMaster where gameid = 'superman' and dateid = '20130213' and eventcode = 1
-- insert into dbo.tEventMaster(gameid, dateid, eventcode, comment) values('Superman', '20130213', 1, '�߷�Ÿ�ε��� �̺�Ʈ')
-- insert into dbo.tEventMaster(gameid, dateid, eventcode, comment) values('Superman2', '20130213', 1, '�߷�Ÿ�ε��� �̺�Ʈ')
-- insert into dbo.tEventMaster(gameid, dateid, eventcode, comment) values('Superman', '20130214', 1, '�߷�Ÿ�ε��� �̺�Ʈ')
-- declare @dateid 	varchar(8) set @dateid = Convert(varchar(8),Getdate(),112)	-- 20120809
-- set @rand = Convert(int, ceiling(RAND() *  100))
--
--declare @loop int set @loop = 1
--declare @rand int
--
--while @loop < 100
--	begin
--		set @rand = 6000 + Convert(int, ceiling(RAND() *  5)) - 1
--		select @rand
--		set @loop = @loop + 1
--	end
-- update dbo.tEventMaster set dateid = '20130212' where idx = 1

*/


/*
select * from dbo.tUserBlockPhone where idx = 11
delete from  dbo.tUserBlockPhone where idx = 11
*/
/*
update dbo.tUserMaster
set machinepoint = 0
where gameid = 'hello16boy'
select top 10 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster

select top 10 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster

select top 10 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster

*/
/*
---------------------------------------------
--  ��Ʋ�α� ���¡ �α� ���
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLogBlock', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLogBlock;
GO

create table dbo.tBattleLogBlock(
	idxOrder	bigint, 									-- �׳��ε���
	idx			bigint,										-- �ε��� > ��������
	gameid		varchar(20), 								-- ���̵�
	grade		int,							 			-- ���
	gradestar	int,
	lv			int,							 			-- ����

	btidx		bigint					default(-1),		-- ����Ʋ�ε���
	btgameid	varchar(20), 								-- ��Ʋ����
	btlog		varchar(1024), 								-- �÷��̷α׵���Ÿ (ȸ, power, �¿찢, ��, ��Ʈ)
	btitem		varchar(16),			 					-- ��Ʋ�� ��������
	btiteminfo	varchar(128), 								-- ���������� (�Ӹ�, ����, ����, ����, ����, �Ȱ�, ��, ��Ʈ)
	bttotal		int,
	btwin		int,										-- �÷��� ����� �¼�
	btresult	int, 										-- ��/��		1 : win	0 : lose
	bthit		int, 										-- �ѰŸ�
	writedate	datetime			default(getdate()), 	-- �÷��̳�¥
	btTotalPower int				default(0),				-- ��Ż�Ŀ�
	btTotalCount int				default(0),				-- ��Ż��Ʈ��
	btAvg		int					default(0),				-- = btTotalPower / btTotalCount
	btsb		int					default(0),				-- ��Ʋ���� ȹ���� �ǹ�
	btmode		int					default(0),
	winstreak	int					default(0),
	winstreak2	int					default(0),

	btcomment	varchar(256),

)

select gameid, btAvg, btlog, * from tBattleLog where btAvg > 4500 order by 1 desc, 2 desc

insert into tBattleLogBlock
select * from dbo.tBattleLog where btAvg > 4500 and gameid in ('whaql2', 'spdlqj34', 'nhkims', 'hello20boy', 'hello18boy', 'hello17boy', 'hello16boy', 'guest24419', 'guest22440', 'apisbio') order by gameid desc, btAvg desc

select * from dbo.tBattleLogBlock

delete from dbo.tBattleLog where btAvg > 4500 and gameid in ('whaql2', 'spdlqj34', 'nhkims', 'hello20boy', 'hello18boy', 'hello17boy', 'hello16boy', 'guest24419', 'guest22440', 'apisbio') order by gameid desc, btAvg desc

*/

/*
-- select top 1 * from dbo.tItemInfo where param7 = @ccharacter and kind in (2, 4, 5, 6) and silverball > 0 and silverball < 2000 order by newid()


select top 1 @sprintitemcode = itemcode, @sprintitemname = itemname from dbo.tItemInfo
where ((param7 = @ccharacter and kind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER)) or (sex = 255 and kind = @ITEM_KIND_BAT))
and silverball > 0 and silverball < (2000 + @lv*125)
and lv < @lv + 10
order by newid()



select * from dbo.tItemInfo
where ((param7 = 0 and kind in (2, 4, 5)) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < (2000 + 50*125)
and lv < 50 + 10

select * from dbo.tItemInfo
where ((param7 = 1 and kind in (2, 4, 5)) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < (2000 + 50*125)
and lv < 50 + 10

select * from dbo.tItemInfo
where ((param7 = 2 and kind in (2, 4, 5)) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < (2000 + 50*125)
and lv < 50 + 10

select * from dbo.tItemInfo
where ((param7 = 3 and kind in (2, 4, 5) and sex != 0) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < (2000 + 50*125)
and lv < 50 + 10

select * from dbo.tUserItem
where itemcode in (
select itemcode from  dbo.tItemInfo where sex = 0
)
*/

/*
-- 5�� �̳��� ���� ���� �о ó���ϱ�
insert into tActionScheduleData(gameid)
select gameid from dbo.tUserMaster where condate > GETDATE() - 10
select top 10 gameid, * from dbo.tUserMaster where condate > GETDATE() - 5
*/

/*
--DROP TABLE dbo.tActionSchedule
--insert into tActionScheduleData(gameid) select gameid from dbo.tUserMaster where
-- PTC_LOGIN
-- if(not exists(select top 1 * from dbo.tActionScheduleData where gameid = @gameid_)
-- begin
--	insert into tActionScheduleData(gameid) values(@gameid_)
-- end
--insert into tActionScheduleData(gameid) values('guest74340')
--insert into tActionScheduleData(gameid) values('guest74341')
--insert into tActionScheduleData(gameid) values('guest74342')
-- select * from tActionScheduleData
-- select * from tActionScheduleStatic

---------------------------------------------
--	���׹̳� ������ > ����� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionScheduleData', N'U') IS NOT NULL
	DROP TABLE dbo.tActionScheduleData;
GO

create table dbo.tActionScheduleData(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),

	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionScheduleData_idx	PRIMARY KEY(idx)
)
-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tActionScheduleData_gameid')
    DROP INDEX tActionScheduleData.idx_tActionScheduleData_gameid
GO
CREATE INDEX idx_tActionScheduleData_gameid ON tActionScheduleData (gameid)
GO


---------------------------------------------
--	���׹̳� ������ > ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionScheduleStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tActionScheduleStatic;
GO

create table dbo.tActionScheduleStatic(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),

	cnt					int					default(0),
	cnt2				int					default(0),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionScheduleStatic_dateid10	PRIMARY KEY(dateid10)
)


*/


/*
-- ���� Ǫ�� �����ϱ�
insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
values('SangSang', 'guest74341', 'APA91bF-BGCKWBD0VzDmTv8ZCaChPZeleMYxsDiF9wYYDMOpKvAsaw5ItMYKdZ1QDZSBvP1CrqkhmjGszpkb50nryy9qQeQT2-hcMPjbLXBpD7H_LtHb40swZACYjBD3X-JKwYz8gLubUDRDxPc3g06r2D0zi2q4eoDwVOwKXqp4tC_WbQ2bQRE', 1, 99, '[Ȩ������(guest74341)]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')

insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
values('SangSang', 'guest74342', 'APA91bF-BGCKWBD0VzDmTv8ZCaChPZeleMYxsDiF9wYYDMOpKvAsaw5ItMYKdZ1QDZSBvP1CrqkhmjGszpkb50nryy9qQeQT2-hcMPjbLXBpD7H_LtHb40swZACYjBD3X-JKwYz8gLubUDRDxPc3g06r2D0zi2q4eoDwVOwKXqp4tC_WbQ2bQRE', 1, 99, '[Ȩ������(guest74342)]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')

insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
values('SangSang', 'guest74343', 'APA91bF-BGCKWBD0VzDmTv8ZCaChPZeleMYxsDiF9wYYDMOpKvAsaw5ItMYKdZ1QDZSBvP1CrqkhmjGszpkb50nryy9qQeQT2-hcMPjbLXBpD7H_LtHb40swZACYjBD3X-JKwYz8gLubUDRDxPc3g06r2D0zi2q4eoDwVOwKXqp4tC_WbQ2bQRE', 1, 99, '[Ȩ������(guest74343)]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')

insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
values('SangSang', 'guest74344', 'APA91bF-BGCKWBD0VzDmTv8ZCaChPZeleMYxsDiF9wYYDMOpKvAsaw5ItMYKdZ1QDZSBvP1CrqkhmjGszpkb50nryy9qQeQT2-hcMPjbLXBpD7H_LtHb40swZACYjBD3X-JKwYz8gLubUDRDxPc3g06r2D0zi2q4eoDwVOwKXqp4tC_WbQ2bQRE', 1, 99, '[Ȩ������(guest74344)]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')

*/

/*
---------------------------------------------
--	���׹̳� ������ǥ��
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tActionSchedule;
GO

create table dbo.tActionSchedule(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),

	cnt					int					default(0),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionSchedule_dateid10	PRIMARY KEY(dateid10)
)
--select * from  dbo.tActionSchedule

*/

/*
-- alter table dbo.tUserMaster add actionPush		int					default(0)
-- update dbo.tUserMaster set actionPush = 0
--select gameid, actionCount, actionMax, condate, * from dbo.tUserMaster
--where actionPush = 0 and actionCount < actionMax and (getdate() - 1) <= condate
--select gameid, actionCount, actionMax, condate, getdate() - 1, * from dbo.tUserMaster
--where (getdate() - 1) <= condate and actionPush = 0 and actionCount < actionMax

-- 1-1. ���� ����
declare @gameid 				varchar(20)
declare @pushid					varchar(256)
declare @actiontime				datetime
declare @actioncount			int
declare	@actionmax				int
declare @nActPerMin				bigint
declare @nActCount				int
declare @dActTime				datetime
declare @LOOP_TIME_ACTION		int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����

-- 1-2. ���� �ʱ�ȭ
set @nActPerMin = @LOOP_TIME_ACTION


-- 2-1. Ŀ�� ����
declare curActionCheck Cursor for
select gameid, actiontime, actioncount, actionmax, pushid from dbo.tUserMaster
where actionPush = 0 and actionCount < actionMax and (getdate() - 1) <= condate

-- 2-2. Ŀ������
open curActionCheck

-- 2-3. Ŀ�� ���
Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid
while @@Fetch_status = 0
	Begin
			---------------------------------------
			-- �ൿġ�� �����ΰ�?
			---------------------------------------
			set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
			set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
			set @actioncount = @actioncount + @nActCount
			if(@actioncount >= @actionmax)
				begin
					---------------------------------------
					select '����', @gameid, @actiontime, @actioncount, @actionmax

					-- Push�� �Է��ϱ�
					insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
					values('SangSang', @gameid, @pushid, 1, 99, '[Ȩ������]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')

					-- ���� ������ ����ϱ�
					update dbo.tUserMaster
						set
							actionPush = 1
					where gameid = @gameid
				end
			else
				begin
					select '����', @gameid, @actiontime, @actioncount, @actionmax
				end

		Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid
	end

-- 2-4. Ŀ���ݱ�
close curActionCheck
Deallocate curActionCheck
*/


/*
alter table dbo.tItemUpgradeInfo add permanentstep			int					default(20)
update dbo.tItemUpgradeInfo set permanentstep = 20
*/

/*
---------------------------------------------
--	�Ϲݺ��� > ����ϱ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRewardLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRewardLog;
GO

create table dbo.tUserRewardLog(
	idx			int					IDENTITY(1,1),

	gameid		varchar(20),
	serialkey	varchar(256),
	mode		int,

	writedate	datetime			default(getdate()),
	comment		varchar(1024),

	-- Constraint
	CONSTRAINT	pk_tUserRewardLog_idx	PRIMARY KEY(idx)
)

--insert into dbo.tUserRewardLog(gameid, serialkey, mode) values('superman7', 'xxxxxxxxxxx1', 1)
--insert into dbo.tUserRewardLog(gameid, serialkey, mode) values('superman7', 'xxxxxxxxxxx2', 1)
-- select top 10 * from dbo.tUserRewardLog
-- select top 1  * from dbo.tUserRewardLog where serialkey = 'xxxxxxxxxxx1'
-- select top 10 * from dbo.tUserRewardLog where gameid = 'superman7'

-- ������Ű �浹�˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRewardLog_serialkey')
    DROP INDEX tUserRewardLog.idx_tUserRewardLog_serialkey
GO
CREATE INDEX idx_tUserRewardLog_serialkey ON tUserRewardLog (serialkey)
GO

--������ �˻���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRewardLog_gameid')
    DROP INDEX tUserRewardLog.idx_tUserRewardLog_gameid
GO
CREATE INDEX idx_tUserRewardLog_gameid ON tUserRewardLog (gameid)
GO

---------------------------------------------
-- 	�Ϲݺ��� > ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRewardLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRewardLogTotal;
GO

create table dbo.tUserRewardLogTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	mode			int,
	cnt				int				default(1),

	-- Constraint
	CONSTRAINT	pk_tUserRewardLogTotal_dateid_mode	PRIMARY KEY(dateid, mode)
)
-- select top 100 * from dbo.tUserRewardLogTotal order by dateid desc
-- select top 100 * from dbo.tUserRewardLogTotal where dateid = '20121129' order by dateid desc
--update dbo.tUserRewardLogTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tUserRewardLogTotal(dateid, cnt) values('20130204', 1)
*/



/*
-- select gameid, * from dbo.tUserMaster where idx <= 130
-- select gameid, goldball, silverball, ccharacter, face, cap, cupper, cunder, bat, glasses,wing, tail, pet, customize, stadium, * from dbo.tUserMaster where idx <= 130
-- select * from dbo.tUserItem where gameid in (select gameid from dbo.tUserMaster where idx <= 130)
--	and buydate >= '2013-01-31'
--	and upgradestate != 0

-- ������ ��ȭ
declare @gameid 		varchar(20)
declare @idx			int

declare curTemp Cursor for
select gameid, idx from dbo.tUserItem where gameid in (select gameid from dbo.tUserMaster where idx <= 130)
	and ((itemcode between 100 and 499) or (itemcode between 5000 and 5100))
	and buydate >= '2013-01-31' and upgradestate < 40

-- 2. Ŀ������
open curTemp

-- 3. Ŀ�� ���
Fetch next from curTemp into @gameid, @idx
while @@Fetch_status = 0
	Begin
		update dbo.tUserItem
			set
				upgradestate = Convert(int, ceiling(RAND() * 60)) + 45
		where gameid = @gameid and idx = @idx
		--select @gameid, @idx, Convert(int, ceiling(RAND() * 40)) + 20

		Fetch next from curTemp into @gameid, @idx
	end

-- 4. Ŀ���ݱ�
close curTemp
Deallocate curTemp
*/

/*

-- ��� ����
declare @gameid 		varchar(20)

declare curTemp Cursor for
select gameid from dbo.tUserMaster where idx <= 130

-- 2. Ŀ������
open curTemp

-- 3. Ŀ�� ���
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		update dbo.tUserMaster
			set
				grade = Convert(int, ceiling(RAND() * 5)) + 45
		where gameid = @gameid
		--select Convert(int, ceiling(RAND() * 5)) + 45

		Fetch next from curTemp into @gameid
	end

-- 4. Ŀ���ݱ�
close curTemp
Deallocate curTemp
*/




/*


-- ������ ��ȭ
declare @gameid 		varchar(20)
declare @idx			int

declare curTemp Cursor for
select gameid, idx from dbo.tUserItem where gameid in (select gameid from dbo.tUserMaster where idx <= 130)
	and (itemcode between 500 and 899)
	and buydate >= '2013-01-31' and upgradestate > 0

-- 2. Ŀ������
open curTemp

-- 3. Ŀ�� ���
Fetch next from curTemp into @gameid, @idx
while @@Fetch_status = 0
	Begin
		update dbo.tUserItem
			set
				upgradestate = 0
		where gameid = @gameid and idx = @idx
		--select @gameid, @idx, Convert(int, ceiling(RAND() * 40)) + 20

		Fetch next from curTemp into @gameid, @idx
	end

-- 4. Ŀ���ݱ�
close curTemp
Deallocate curTemp
*/





/*
-- ������ ����
exec spu_ItemChange 'lolderhome', 100, 	-1		-- ����(101)
exec spu_ItemChange 'lolderhome', 200, 	-1		-- ����(201)
exec spu_ItemChange 'lolderhome', 300, 	-1		-- ����(301)
exec spu_ItemChange 'lolderhome', 400, 	-1		-- ��Ʈ(401)
exec spu_ItemChange 'lolderhome', 500, 	-1		-- �Ȱ�(501)
exec spu_ItemChange 'lolderhome', 600, 	-1		-- ����(601)
exec spu_ItemChange 'lolderhome', 700, 	-1		-- ����(701)
exec spu_ItemChange 'lolderhome', 800, 	-1		-- ����(801)
exec spu_ItemChange 'lolderhome', 5000, 	-1		-- ��(5001)
exec spu_ItemChange 'lolderhome', 0, 		-1		-- ĳ����(0)

*/

/*
select * from dbo.tUserMaster where idx <= 130

update dbo.tUserMaster set ccharacter = 0 from dbo.tUserMaster where ccharacter is null and  idx <= 130
update dbo.tUserMaster set face = 50 from dbo.tUserMaster where  face is null
update dbo.tUserMaster set cap = 100 from dbo.tUserMaster where  cap is null
update dbo.tUserMaster set cupper = 200 from dbo.tUserMaster where cupper is null
update dbo.tUserMaster set cunder = 300 from dbo.tUserMaster where cunder is null
update dbo.tUserMaster set bat = 400 from dbo.tUserMaster where bat is null
update dbo.tUserMaster set glasses = -1 from dbo.tUserMaster where glasses is null
update dbo.tUserMaster set wing = -1 from dbo.tUserMaster where wing is null
update dbo.tUserMaster set tail = -1 from dbo.tUserMaster where tail is null
update dbo.tUserMaster set pet = -1 from dbo.tUserMaster where pet is null
update dbo.tUserMaster set customize = 1 from dbo.tUserMaster where customize is null
update dbo.tUserMaster set stadium = 800 from dbo.tUserMaster where stadium is null



select * from dbo.tUserMaster where gameid = 'sususu'

update dbo.tUserMaster set password = '7575970askeie1595312', goldball = 10000, silverball = 100000 from dbo.tUserMaster
where idx <= 130

update dbo.tUserMaster set wing = -1 from dbo.tUserMaster where idx <= 130 and wing is null
select * from dbo.tUserMaster where idx <= 130
update dbo.tUserMaster set grade = Convert(int, ceiling(RAND() * 7)) + 43, lv = 50 from dbo.tUserMaster where idx <= 130



update dbo.tUserItem
	set
		upgradestate = Convert(int, ceiling(RAND() * 50)) + 20
where gameid = 'abbytumble'



select Convert(int, ceiling(RAND() * 50)) + 20 from dbo.tUserItem
where gameid = 'abbytumble' and itemcode >= 100 and buydate > '2013-01-09'





select * from dbo.tUserItem where gameid in (
select gameid from dbo.tUserMaster where idx <= 130)

declare @loop int
set @loop = 1
while @loop < 10
	begin
		select Convert(int, ceiling(RAND() * 7)) + 43
		set @loop = @loop + 1
	end

update dbo.tUserMaster set goldball = 1000, silverball = 100000
where gameid in (
'abbytumble',
'ali00173',
'aongrin064',
'aovelab',
'atasa',
'bailnuke',
'barkdune',
'baseking',
'brtemis',
'bulletmatc',
'byexyloid7',
'crywwet',
'dani7777',
'delman',
'deminida',
'dhadow',
'dhh132',
'dnkibu',
'donghw',
'donmr',
'doremys',
'dorraiva',
'doulj',
'dsaccoun',
'eeelre0401',
'ehite',
'elazarr',
'emotioneas',
'emypinky',
'esjunsik',
'evejacket',
'ggo5219',
'ghimeyelt',
'gigaidlr',
'gomsshine',
'growlerswe',
'gwangkuk',
'hali3030',
'hath22',
'holeearth9',
'holequiz56',
'holsterhea',
'homekick',
'hwangsuk',
'ioman1030',
'jbdesp',
'jejily',
'jnsoryoo',
'joobanndi',
'justiceheh',
'kcicata01',
'keon811',
'kerroland',
'khj745',
'kickqost',
'killerlase',
'kingdomper',
'kinhyim77',
'knowledgee',
'kyssmart',
'lang13',
'lang588711',
'leaguefaz',
'litanos',
'lolderhome',
'lolderlook',
'lsn9372',
'lwjeong',
'ly8779',
'majorkilo9',
'makegman37',
'manaumi80',
'marineown4',
'mayoung7',
'measureove',
'nabosari',
'naragi',
'navyheaven',
'nethell683',
'nexusugly3',
'noblessque',
'nodern005',
'nonobono',
'nuclearbai',
'oh0515',
'ourpleston',
'ownfull541',
'peanuted50',
'personaway',
'persuadefa',
'polzip',
'posiiop76',
'qarkas214',
'qualitygla',
'quicksilve',
'quvius',
'reddhouse',
'richhole22',
'rladlsduu',
'saebaryo',
'samwisse',
'spellxeed',
'spple',
'spril1218',
'sudrkaak',
'tailtire',
'taxq656',
'tucifelz',
'umbrellaaw',
'uoserian',
'upguest556',
'usk6021',
'vestworn15',
'vhosun',
'vjhyun20',
'vlthgus',
'warsenal',
'wildrunner',
'wjdddmsl',
'xake1207',
'xionlucife',
'xraykid',
'xysterspar',
'yawjop886',
'yolkearn92',
'yotoroya',
'zcerver',
'zongsily',
'zookiko',
zyfeel24


*/


/*
select * from dbo.tUserMaster where winstreak < 0
select * from dbo.tBattleLog where winstreak < 0

select * from dbo.tUserMaster where winstreak < 0
update dbo.tUserMaster set winstreak = 0 where winstreak < 0

select * from dbo.tBattleLog where winstreak < 0
update dbo.tBattleLog set winstreak = 0 where winstreak < 0


*/

/*
---------------------------------------------
-- 	���� push > ������ ���̺�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRevenge', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRevenge;
GO

create table dbo.tUserRevenge(
	idx				int				identity(1, 1),

	gameid			varchar(20),								-- �޴� ����
	btpflag			int					default(1),				-- ��ƲPush�α�	> flag:0 ������, flag:1 > ��������
	btpgameid 		varchar(20),								-- ����� ���̵�
	btpgrade 		int,										-- ���
	btptime			datetime			default(getdate()),		-- ��Ʋ�ð�
	btpgmode		int					default(5),				-- ��Ʋ���

	-- Constraint
	CONSTRAINT	pk_tUserRevenge_idx	PRIMARY KEY(idx)
)

-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRevenge_gameid_btptime')
    DROP INDEX tUserRevenge.idx_tUserRevenge_gameid_btptime
GO
CREATE INDEX idx_tUserRevenge_gameid_btptime ON tUserRevenge (gameid, btptime)
GO
-- insert into dbo.tUserRevenge(gameid, btpgameid, btpgrade, btpgmode) values('superman', 'superman2', 40, 5)
-- select top 1 * from dbo.tUserRevenge where gameid = 'superman' and btptime >= getdate() - 0.1 and btpflag = 1 order by idx desc
-- update dbo.tUserRevenge set btpflag = 0 where idx = 1
-- select * from dbo.tUserRevenge order by idx desc


---------------------------------
-- ������ : superman7(13) -> superman(21)		> ���
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('superman7', 'superman')
exec spu_UserPushMsgAndroid 'superman7', '7575970askeie1595312', 'superman', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'superman', 'superman7', 5, 1, -1

-- ������ : superman7(13) <- superman(21)		> ���
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('superman7', 'superman')
exec spu_UserPushMsgAndroid 'superman', '7575970askeie1595312', 'superman7', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'superman7', 'superman', 5, 1, -1

---------------------------------
-- ������ : superman7(13) -> mogly(50)			> ��Ͼ���
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('superman7', 'mogly')
exec spu_UserPushMsgAndroid 'superman7', '7575970askeie1595312', 'mogly', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'mogly', 'superman7', 5, 1, -1

-- ������ : superman7(13) <- mogly(50)
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('superman7', 'mogly')
exec spu_UserPushMsgAndroid 'mogly', '1025093cql5314691943', 'superman7', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'superman7', 'mogly', 5, 1, -1


*/


/*
select gameid from dbo.tItemBuyLog where itemcode = 7004
order by gameid desc


select gameid, actionfreedate from dbo.tUserMaster
where gameid in (select distinct gameid from dbo.tItemBuyLog where itemcode = 7004)

update dbo.tUserMaster
	set
		actionfreedate = actionfreedate + 10
where gameid in (select distinct gameid from dbo.tItemBuyLog where itemcode = 7004)


update dbo.tUserMaster
	set
		actionfreedate = actionfreedate + 10
where gameid in ('tnt1109', 'guest23210')
*/

/*
---------------------------------------------
--  ���׹̳� ���ð���
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tActionInfo;
GO

create table dbo.tActionInfo(
	idx					int 				IDENTITY(1, 1),

	halfmodeprice			int				default(6),
	fullmodeprice			int				default(10),
	freemodeprice			int				default(50),
	freemodeperiod			int				default(5),

	flag					int				default(1),			--(1):Ȱ��ȭ, (0)��Ȱ��ȭ
	comment					varchar(1024),
	writedate				datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tActionInfo(halfmodeprice, fullmodeprice, freemodeprice, freemodeperiod, comment) values(6, 10, 50, 5, '����')
-- insert into dbo.tActionInfo(halfmodeprice, fullmodeprice, freemodeprice, freemodeperiod, comment) values(4, 7, 25, 5, '����')
-- select * from dbo.tActionInfo where flag = 1 order by idx desc
-- select top 1 * from dbo.tActionInfo where flag = 1 order by idx desc
--halfmodeprice=4GB
--fullmodeprice=7GB
--freemodeprice=20GB
--freemodeperiod=5

	select top 1
		@goldballFullPrice = fullmodeprice,
		@goldballHalfPrice = halfmodeprice,
		@goldballFreePrice = freemodeprice,
		@freeModePeriod = freemodeperiod
	from dbo.tActionInfo where flag = 1 order by idx desc


			else if(@subkind = 70)
				begin
					insert into dbo.tActionInfo(halfmodeprice, fullmodeprice, freemodeprice, freemodeperiod, comment)
					values(@p5_, @p6_, @p7_, @p8_, @message_)

					select * from dbo.tActionInfo order by idx desc
				end
			else if(@subkind = 71)
				begin
					update dbo.tActionInfo
						set
							halfmodeprice	= @p5_,
							fullmodeprice	= @p6_,
							freemodeprice	= @p7_,
							freemodeperiod	= @p8_,
							comment 		= @message_
					where idx = @p3

					select * from dbo.tActionInfo order by idx desc
				end
			else if(@subkind = 72)
				begin
					select * from dbo.tActionInfo order by idx desc
				end



*/



/*


alter table dbo.tUserSMSLogTotal add joincnt			int				default(0)
update dbo.tUserSMSLogTotal set joincnt = 0


*/

/*
select top 100 * from dbo.tUserSMSReward
order by idx desc

select top 100 * from dbo.tUserSMSReward
where gameid like 'dddd%'
order by idx desc

select top 100 * from dbo.tUserSMSReward
where recphone like '01011%'
order by idx desc


create table dbo.tUserSMSReward(
	idx			int					IDENTITY(1,1),

	recphone	varchar(20),
	gameid		varchar(20),

	rewarddate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserSMSReward_idx	PRIMARY KEY(idx)
)


*/
/*
alter table dbo.tUserMaster add smsjoincnt int					default(0)
update dbo.tUserMaster set smsjoincnt = 0

*/
/*
---------------------------------------------
--	SMS > Reward
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSMSReward', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSMSReward;
GO

create table dbo.tUserSMSReward(
	idx			int					IDENTITY(1,1),

	recphone	varchar(20),
	gameid		varchar(20),

	rewarddate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserSMSReward_idx	PRIMARY KEY(idx)
)
-- select top 10  * from dbo.tUserSMSLog order by idx asc
-- insert into dbo.tUserSMSReward(recphone, gameid) values('01011112222', 'superman7')
-- select top 10  * from dbo.tUserSMSReward where recphone = '01011112222'

-- ��Ű �˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSReward_recphone')
    DROP INDEX tUserSMSReward.idx_tUserSMSReward_recphone
GO
CREATE INDEX idx_tUserSMSReward_recphone ON tUserSMSReward (recphone)
GO

--������ �˻���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSReward_gameid')
    DROP INDEX tUserSMSReward.idx_tUserSMSReward_gameid
GO
CREATE INDEX idx_tUserSMSReward_gameid ON tUserSMSReward (gameid)
GO

--------------------------------
declare @phone_			varchar(20)		set @phone_ = '01011112222'
declare @comment2		varchar(1024)
declare @smsgameid		varchar(20)
declare @coin			int				set @coin		= 1
declare @bttem5cnt		int				set @bttem5cnt	= 3



select top 1 @smsgameid = gameid from dbo.tUserSMSLog
where recphone = @phone_
order by idx asc

select 'DEBUG ��õ', @smsgameid, coin, bttem5cnt from dbo.tUserMaster where gameid = @smsgameid
if(isnull(@smsgameid, '') != '')
	begin
		select 'DEBUG 1�ܰ� ��õSMS�α׿� ������'
		if(not exists(select top 1 * from dbo.tUserSMSReward where recphone = @phone_))
			begin
				select 'DEBUG 2�ܰ� ����SMS�α׿� ������� > Reward�����ϱ�'
				---------------------------------------------
				--	1-1. ��õ���� �����ϱ�
				---------------------------------------------
				select 'DEBUG > ��õ : coin x 10, ����Ÿ�� 20�� > �޼������'
				update dbo.tUserMaster
					set
						coin = coin + 10,
						bttem5cnt = bttem5cnt + 20
				where gameid = @smsgameid

				insert into tMessage(gameid, sendid, comment)
				values(@smsgameid, '��õ���Ժ���', ltrim(rtrim(@phone_)) + '�� ��õ�� �����ؼ� �������� �̱����� 10��, ����Ÿ�� 20��(�ߺ��߰�����)' )

				---------------------------------------------
				--	1-2. �������� �����ϱ�
				---------------------------------------------
				select 'DEBUG  > ���� : coin x 10, ����Ÿ�� 20�� > �޼������'
				set @coin		= 10
				set @bttem5cnt	= 20
				set @comment2	= ltrim(rtrim(@smsgameid)) + '�� ��õ�� �����ؼ� �������� �̱����� 10��, ����Ÿ�� 20���� �����߽��ϴ�.'

				---------------------------------------------
				--	1-3. ����ϱ�
				---------------------------------------------
				insert into dbo.tUserSMSReward(recphone, gameid)
				values(@phone_, @smsgameid)
			end
	end
select 'DEBUG ��õ', @smsgameid, coin, bttem5cnt from dbo.tUserMaster where gameid = @smsgameid










/*
--------------------------------------------
-- �α���, ������Ȳ > Ŀ���� �۾��ϱ�
-- dbo.tBattleLog > ~ 2013-01-23 23:30
--select
--	Convert(varchar(8), b.writedate,112) + Convert(varchar(2), b.writedate, 108) dateid10,
--	m.market market
--	from dbo.tUserMaster m join dbo.tBattleLog b on m.gameid = b.gameid
--	where b.writedate < '2013-01-23 23:30'
--	--where b.writedate < '2012-09-22 23:30'
--order by b.idxOrder asc
--------------------------------------------
-- Ŀ���͸���¡ ������ �Է��ϱ�
-- 1. Ŀ������
declare @dateid10 		varchar(10)
declare @market			int

declare curtBattleLogStatic Cursor for
select
	Convert(varchar(8), b.writedate,112) + Convert(varchar(2), b.writedate, 108) dateid10,
	m.market market
	from dbo.tUserMaster m join dbo.tBattleLog b on m.gameid = b.gameid
	where b.writedate < '2013-01-23 23:30'
	--where b.writedate < '2012-09-22 23:30'
order by b.idxOrder asc


-- 2. Ŀ������
open curtBattleLogStatic

-- 3. Ŀ�� ���
Fetch next from curtBattleLogStatic into @dateid10, @market
while @@Fetch_status = 0
	Begin
		if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market))
			begin
				insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 0, 1)
			end
		else
			begin
				update dbo.tStaticTime
					set
						playcnt = playcnt + 1
				where dateid10 = @dateid10 and market = @market
			end
		Fetch next from curtBattleLogStatic into @dateid10, @market
	end

-- 4. Ŀ���ݱ�
close curtBattleLogStatic
Deallocate curtBattleLogStatic
*/

/*
--------------------------------------------
-- �ڵ����� > Ŀ���� �۾��ϱ�
-- tUserMaster > ~ 2013-01-23 23:30
--------------------------------------------
-- Ŀ���͸���¡ ������ �Է��ϱ�
-- 1. Ŀ������
declare @phone 		varchar(20)
declare @market		int
declare @regdate	datetime

declare curUserMaster Cursor for
select phone, market, regdate from dbo.tUserMaster
where phone != '' and regdate < '2013-01-23 23:30'
order by idx asc

-- 2. Ŀ������
open curUserMaster

-- 3. Ŀ�� ���
Fetch next from curUserMaster into @phone, @market, @regdate
while @@Fetch_status = 0
	Begin
		if(not exists(select top 1 * from dbo.tUserPhone where phone = @phone))
			begin
				insert into dbo.tUserPhone(phone, market, joincnt, writedate) values(@phone, @market, 1, @regdate)
			end
		else
			begin
				update dbo.tUserPhone
					set
						joincnt = joincnt + 1
				where phone = @phone
			end
		Fetch next from curUserMaster into @phone, @market, @regdate
	end

-- 4. Ŀ���ݱ�
close curUserMaster
Deallocate curUserMaster
*/

/*
---------------------------------------------
--	����ũ ������Ȳ�ľ��ϱ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPhone;
GO

create table dbo.tUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(1),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPhone_idx	PRIMARY KEY(idx)
)
-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPhone_phone')
    DROP INDEX tUserPhone.idx_tUserPhone_phone
GO
CREATE INDEX idx_tUserPhone_phone ON tUserPhone (phone)
GO

--------------------------------------------
-- �ڵ����� ���� ī����
--------------------------------------------
declare @phone 	varchar(20) 		set @phone 	= '01122223335'
if(not exists(select top 1 * from dbo.tUserPhone where phone = @phone))
	begin
		insert into dbo.tUserPhone(phone, market, joincnt) values(@phone, 1, 1)
	end
else
	begin
		update dbo.tUserPhone
			set
				joincnt = joincnt + 1
		where phone = @phone
	end
select * from dbo.tUserPhone
select * from dbo.tUserPhone where phone = '0112'
select * from dbo.tUserPhone where phone like '0112%'

*/
/*
---------------------------------------------
--	�α��� ��Ȳ, �÷��� ��Ȳ
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticTime;
GO

create table dbo.tStaticTime(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),
	market				int					default(1),				-- (����ó�ڵ�) MARKET_SKT

	logincnt			int					default(0),
	playcnt				int					default(0),


	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10_market	PRIMARY KEY(dateid10, market)
)



-- �α��� ī����
declare @dateid10 	varchar(10) 		set @dateid10 	= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
declare @market 	int					set @market 	= 1
if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market))
	begin
		insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 1, 0)
	end
else
	begin
		update dbo.tStaticTime
			set
				logincnt = logincnt + 1
		where dateid10 = @dateid10 and market = @market
	end
select * from dbo.tStaticTime order by dateid10 desc, market desc

-- �÷��� ī���
declare @dateid10 	varchar(10) 		set @dateid10 	= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
declare @market 	int					set @market 	= 1
if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market))
	begin
		insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 0, 1)
	end
else
	begin
		update dbo.tStaticTime
			set
				playcnt = playcnt + 1
		where dateid10 = @dateid10 and market = @market
	end
select * from dbo.tStaticTime order by dateid10 desc, market desc

*/
/*
---------------------------------------------
--  ������Ʋ/�̼� ���ð���
---------------------------------------------
IF OBJECT_ID (N'dbo.tRevModeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tRevModeInfo;
GO

create table dbo.tRevModeInfo(
	idx					int 				IDENTITY(1, 1),

	btrevitemcode		int					default(7020),
	btrevprice			int					default(5),
	msrevitemcode4		int					default(7021),
	msrevprice4			int					default(5),
	msrevitemcode7		int					default(7022),
	msrevprice7			int					default(7),
	msrevitemcode8		int					default(7023),
	msrevprice8			int					default(20),
	msrevitemcode9		int					default(7024),
	msrevprice9			int					default(50),

	flag				int					default(1),			--(1):Ȱ��ȭ, (0)��Ȱ��ȭ
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRevModeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tRevModeInfo(btrevitemcode, btrevprice, msrevitemcode4, msrevprice4, msrevitemcode7, msrevprice7, msrevitemcode8, msrevprice8, msrevitemcode9, msrevprice9, comment) values(7020, 5, 7021, 5, 7022, 7, 7023, 20, 7024, 50, '����')
-- select top 1 * from dbo.tRevModeInfo where flag = 1 order by idx desc


			else if(@subkind = 60)
				begin
					insert into dbo.tRevModeInfo(btrevitemcode, btrevprice, msrevitemcode4, msrevprice4, msrevitemcode7, msrevprice7, msrevitemcode8, msrevprice8, msrevitemcode9, msrevprice9, comment)
					values(@p5_, @p6_, @p7_, @p8_, @p9_, @p10_, @ps1, @ps2_, @ps3_, @ps4_, @message_)
					select * from dbo.tRevModeInfo order by idx desc
				end
			else if(@subkind = 61)
				begin
					update dbo.tRevModeInfo
						set
							btrevitemcode	= @p5_,
							btrevprice		= @p6_,
							msrevitemcode4	= @p7_,
							msrevprice4		= @p8_,
							msrevitemcode7	= @p9_,
							msrevprice7		= @p10_,
							msrevitemcode8	= @ps1,
							msrevprice8		= @ps2_,
							msrevitemcode9	= @ps3_,
							msrevprice9		= @ps4_,
							comment 		= @message_
					where idx = @idx

					select * from dbo.tRevModeInfo order by idx desc
				end
			else if(@subkind = 62)
				begin
					select * from dbo.tRevModeInfo order by idx desc
				end

*/
/*
-- select top 10 * from tBattleLog
-- select max(idxOrder) from tBattleLog
-- 2702386
declare @idx	bigint
declare @loop 	int
set @loop = 1

while(@loop < 100000)
	begin
		set @idx = abs(checksum(newid()))
		if(exists(select * from tBattleLog where idx = @idx))
			begin
				select 'DEBUG 1�� �浹', @idx
				set @idx = abs(checksum(newid()))
				if(exists(select * from tBattleLog where idx = @idx))
					begin
						select 'DEBUG 2�� �浹', @idx
						set @idx = abs(checksum(newid()))
						if(exists(select * from tBattleLog where idx = @idx))
							begin
								select 'DEBUG 3�� �浹', @idx
							end
					end
			end
		--else
		--	begin
		--		select '����', @idx
		--	end
		set @loop = @loop + 1
	end


declare @idx	bigint
declare @loop 	int
set @loop = 1
while(@loop < 10)
	begin
		update dbo.tUserMaster set trainflag = 1, machineflag = 1, memorialflag	= 1, soulflag = 1, btflag = 1, btflag2 = 1, blockstate = 0, cashcopy = 0, resultcopy = 0 where gameid = 'superman6'
		exec spu_GameEnd 'superman6', 6, 1000,		-- gameid, gmode, point																-- ������Ʈ
			21, 8,				-- lvexp, lv
			10,					-- get silver
			2, 1, 2, 1,			-- gradeexp, grade, gradestar, btresult(win/lose)
			'DD1',				-- btgameid
			'@1,4600,24,10@1,4800,25,20@1,4900,26,30@1,4000,28,40@1,4100,29,50@1,4200,31,-10@1,4300,33,-20@1,4400,45,-30@1,4500,20,-40',	-- btlog_ ��Ʈ, �Ŀ�, ��, ����
			'1,0,0,0,0',		-- btitem_ 1 ~ 5���ۼ���
			'0,50,114,220,313,418,5003,510,610,706,2',	-- btiteminfo_ ĳ����, ��, �Ӹ�, ����, ����, ��Ʈ, ��, �Ӹ� �Ǽ��縮, ����, ����, Ŀ���� ����¡
			10000, 9, 1000,		-- bttotalpower_, bttotalcount_, btavg_
			1,					-- btsearchidx_
			20, 3, 4, 1, 2, 3,	-- bestdist_, homerun_, homeruncombo_, pollhit_, ceilhit_, boardhit_
			-1
		set @loop = @loop + 1
	end
--delete from dbo.tBattleLog where gameid = 'superman6'


*/

/*
-- 1�� 1ȸ
-- delete from dbo.tUserSMSLog where recphone = '0162682109'
declare @recphone2_	 varchar(20)
set @recphone2_	= '0162682109'
select * from dbo.tUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 0.2)
if(exists(select * from dbo.tUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 1)))
	begin
		select 'DEBUG ����'
	end



	else if(exists(select * from dbo.tUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 1)))
		begin
			set @nResult_ = @RESULT_ERROR_SMS_KEY_DUPLICATE
			set @comment = 'ERROR ������õ �ø���Ű�� �ߺ��ȴ�.'
		end
*/
/*
select top 10 * from dbo.tUserSMSLog order by recphone desc
select * from dbo.tUserSMSLog order by recphone desc
select * from dbo.tUserSMSLog order by senddate desc

*/
/*
update dbo.tUserMaster set coin = case when coin < 5 then 5 else coin end
*/
/*
--------------------------------------
update dbo.tUserMaster set smsCount = case when smsCount = 10 then 30 else smsCount end, smsMax = 30
update dbo.tUserMaster set smsMax = 30
update dbo.tUserMaster set smsCount = case when smsCount > 10 then 10 else smsCount end, smsMax = 10
select smsCount, smsMax from tUserMaster where gameid like 'superman%'


--------------------------------------
-- ��Ű �˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSLog_recphone')
    DROP INDEX tUserSMSLog.idx_tUserSMSLog_recphone
GO
CREATE INDEX idx_tUserSMSLog_recphone ON tUserSMSLog (recphone)
GO
select count(*) from dbo.tUserSMSLog where recphone = '01011112222'

---------------------------------------------
-- �ڵ��� �̻�����
---------------------------------------------
IF OBJECT_ID (N'dbo.tSMSBlock', N'U') IS NOT NULL
	DROP TABLE dbo.tSMSBlock;
GO

create table dbo.tSMSBlock(
	idx					int 				IDENTITY(1, 1),

	-- �����ν���
	phone				varchar(20),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSMSBlock_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSMSBlock_phone')
    DROP INDEX tUserSMSLog.idx_tSMSBlock_phone
GO
CREATE INDEX idx_tSMSBlock_phone ON tSMSBlock (phone)
GO

-- insert into dbo.tSMSBlock(phone) values('01011112222')




/*
---------------------------------------------
-- �Ϲ� ���ð���
---------------------------------------------
IF OBJECT_ID (N'dbo.tHomeleague', N'U') IS NOT NULL
	DROP TABLE dbo.tHomeleague;
GO

create table dbo.tHomeleague(
	idx						int 				IDENTITY(1, 1),

	-- �����ν���
	reversalitemcode		int					default(7020),
	reversalprice			int					default(5),

	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tHomeleague_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tHomeleague(reversalitemcode, reversalprice, comment) values(7020, 10, '����')
-- select * from tHomeleague order by idx desc


*/
/*
select * from dbo.tUserMaster where gameid like 'quho90'


*/
/*
---------------------------------------------
--  ��ȭ��� > ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemUpgradeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tItemUpgradeInfo;
GO

create table dbo.tItemUpgradeInfo(
	idx						int 				IDENTITY(1, 1),

	petitemupgradebase		int					default(50),
	petitemupgradestep		int					default(30),
	normalitemupgradebase	int					default(50),
	normalitemupgradestep	int					default(10),

	flag				int					default(1),			--(1):Ȱ��ȭ, (0)��Ȱ��ȭ
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tItemUpgradeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tItemUpgradeInfo(petitemupgradebase, petitemupgradestep, normalitemupgradebase, normalitemupgradestep, comment) values(50, 30, 50, 10, '����')
-- select top 1 * from dbo.tItemUpgradeInfo where flag = 1 order by idx desc
--	public const int ITEM_UPGRADE_BASE_PRICE 		= 50;
--	public const int ITEM_UPGRADE_NORMAL_STEP 		= 10;
--	public const int ITEM_UPGRADE_NORMAL_INTERVAl	= 5;
--	public const int ITEM_UPGRADE_PET_STEP 			= 30;

			else if(@subkind = 50)
				begin
					insert into dbo.tItemUpgradeInfo(petitemupgradebase, petitemupgradestep, normalitemupgradebase, normalitemupgradestep, comment)
					values(@p6_, @p7_, @p8_, @p9_, @message_)

					select * from dbo.tItemUpgradeInfo order by idx desc
				end
			else if(@subkind = 51)
				begin
					update dbo.tItemUpgradeInfo
						set
							petitemupgradebase 		= @p6_,
							petitemupgradestep 		= @p7_,
							normalitemupgradebase 	= @p8_,
							normalitemupgradestep 	= @p9_,
							comment = @message_
					where idx = @idx

					select * from dbo.tItemUpgradeInfo order by idx desc
				end
			else if(@subkind = 52)
				begin
					select * from dbo.tItemUpgradeInfo order by idx desc
				end




*/
/*
select top 10 * from dbo.tUserItem order by idx desc
alter table dbo.tUserItem add lvignore int 					default(0)
update dbo.tUserItem set lvignore = 0
*/
/*
select count(*) from dbo.tUserPushAndroidTotal
select count(*) from dbo.tUserPushAndroid
select top 10 * from dbo.tUserPushAndroid
select count(*) from  dbo.tUserPushAndroidLog
*/
/*
select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 2 order by rank asc
select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 3 order by rank asc
select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 5 order by rank asc

select * from dbo.tUserMasterSchedule order by dateid desc
select * from dbo.tRankTotal where dateid = '20130117' order by gamemode desc, rank asc


*/
/*
--declare @GAME_MODE_MACHINE		int		set @GAME_MODE_MACHINE		= 2
--declare @GAME_MODE_MEMORISE		int		set @GAME_MODE_MEMORISE		= 3
--declare @GAME_MODE_BATTLE			int		set @GAME_MODE_BATTLE		= 5

---------------------------------------------
-- 	��ũ���
---------------------------------------------
IF OBJECT_ID (N'dbo.tRankTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tRankTotal;
GO

create table dbo.tRankTotal(
	idx				int				identity(1, 1),

	dateid			char(8),								-- 20101210
	gamemode		int,
	gameid			varchar(20),

	rank			int,

	machinepoint	int				default(0),
	memorialpoint	int				default(0),
	btwin			int				default(0),
	bttotal			int				default(0),
	btlose			int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRankTotal_dateid_gamemode_gameid	PRIMARY KEY(dateid, gamemode, gameid)
)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'kyssmart', 1, 10, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'superman2', 2, 9, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'superman3', 3, 8, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 3, 'kyssmart', 1, 10, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 5, 'kyssmart', 1, 10, 10, 10, 10, 0)


declare @dateid 	varchar(8) set @dateid = Convert(varchar(8),Getdate(),112)	-- 20120809
                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
select top 10 rank() over(order by machinepoint desc)       as rank, @dateid, 2,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster
                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
select top 10 rank() over(order by memorialpoint desc)      as rank, @dateid, 3,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster
                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
select top 10 rank() over(order by btwin desc, bttotal asc) as rank, @dateid, 5,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster


*/
/*
alter table dbo.tUserSMSLogTotal add cnt2			int				default(1)
update dbo.tUserSMSLogTotal set cnt2 = 0
*/
/*
update dbo.tUserMaster set smsCount = 30, smsMax = 30, smsTime = getdate()
*/

/*
insert into dbo.tItemInfo(labelname, itemcode, itemname, sex, kind, active, itemfilename, pluspower, sale, backicon, iconindex, lv, param1, param2, param3, param4, param5, param6, param7, param8, param9, silverball, goldball, period, explain)
values('etcitem', '7004', '���׹̳��Ϸ�����', '255', '99', '-1', 'etc4', '0', '0', '0', '60', '0', '-999', '-999', '-999', '-999', '-999', '-999', '-1', '-1', '-999', '0', '50', '-1', '�Ϸ罺�׹̳�')

alter table dbo.tUserMaster add actionfreedate		datetime			default(getdate() - 1)
update dbo.tUserMaster set actionfreedate = getdate() - 1

*/
/*
-- �ű԰��� > SKT, 2013-01-15 10:00���� ���ν��� ��Ʈ ����
-- SKT ��õ�̺�Ʈ
declare @market_ int				set @market_ = 1
declare @gameid_ varchar(20)		set @gameid_ = 'superman2'
declare @SKT_EVENT01_DATE datetime	set @SKT_EVENT01_DATE					= '2013-01-15 23:59'

if(@market_ = 1 and getdate() < @SKT_EVENT01_DATE)
	begin
			--------------------------------------
			-- 2013-01-14 ~ 01-15 12:00
			-- SKT ��õ �̺�Ʈ(���ν�Ʈ ��Ʈ(439), 7��)
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2)
			values(@gameid_ , 410, 'SKT��õ', 7);

			-- SKT �̺�Ʈ�� ��������
			insert into tMessage(gameid, comment)
			values(@gameid_, 'SKT ��õ �޴� ���� ������� ��Ʈ ����')
	end



*/
/*

declare @loop int set @loop = 1
declare @rand int
declare @sprintupgradestate2 int

while @loop < 100
	begin
		set @rand = Convert(int, ceiling(RAND() *  100))
		if(@rand < 70)
			begin
				set @sprintupgradestate2 = ( 5 + Convert(int, ceiling(RAND() *  5)) - 1)
			end
		else if(@rand < 95)
			begin
				set @sprintupgradestate2 = (10 + Convert(int, ceiling(RAND() *  5)) - 1)
			end
		else
			begin
				set @sprintupgradestate2 = (15 + Convert(int, ceiling(RAND() *  5)) - 1)
			end

		select @sprintupgradestate2 sprintupgradestate2
		set @loop = @loop + 1
	end

*/

/*
update dbo.tUserMaster set doublepower = 15, doubledegree = 15
select * from dbo.tBattleLog where idxOrder = '153293193'
select * from dbo.tBattleLog where idx = '153293193'
@0,2619.0,-29.4,25.2@1,2730.0,-28.9,-21.3@1,2739.0,-29.3,-23.5@1,2577.0,-31.8,-31.4@1,2754.0,-30.3,42.0@0,2646.0,-33.7,-11.5@0,2688.0,-30.9,32.6@1,2750.0,-27.0,7.1@0,2666.0,-24.7,-41.5@1,2737.0,-29.5,-49.2@1,2576.0,-20.5,-41.2@0,0.0,0.0,0.0@1,2726.0,-28.0,-4.5@1,2582.0,-32.6,0.9@0,2683.0,-29.4,3.9@1,2721.0,-27.0,47.4@1,2772.0,-21.1,10.5@1,2576.0,-20.5,43.1@0,2656.0,-35.3,-24.2@1,1388.0,-20.5,38.6@0,0.0,0.0,0.0@1,2722.0,-22.5,27.0@0,2603.0,-26.4,-43.9@1,2576.0,-20.5,-17.6
@0,2349,-29.4,25.2  @1,2460,-28.9,-21.3  @1,2469,-29.3,-23.5  @1,2577,-31.8,-31.4  @1,2484,-30.3,42.0  @0,2376,-33.7,-11.5  @0,2418,-30.9,32.6@1,2480,-27.0,7.1@0,2396,-24.7,-41.5@1,2467,-29.5,-49.2@1,2576,-20.5,-41.2@0,0,0.0,0.0@1,2456,-28.0,-4.5@1,2582,-32.6,0.9@0,2413,-29.4,3.9@1,2451,-27.0,47.4@1,2502,-21.1,10.5@1,2576,-20.5,43.1@0,2386,-35.3,-24.2@1,1388,-20.5,38.6@0,0,0.0,0.0@1,2452,-22.5,27.0@0,2333,-26.4,-43.9@1,2576,-20.5,-17.6
*/

/*
alter table dbo.tRouletteLogTotalMaster add goldballkind	int				default(2)
update dbo.tRouletteLogTotalMaster set goldballkind = 2
--�������� tRouletteLogTotalMaster --> PRIMARY KEY (dateid, goldballkind)
-- alter table dbo.tRouletteLogTotalMaster drop  primary key;
--ALTER TABLE tRouletteLogTotalMaster add CONSTRAINT not null goldballkind
--ALTER TABLE tRouletteLogTotalMaster MODIFY CONSTRAINT PRIMARY KEY (dateid, goldballkind)

alter table dbo.tRouletteLogTotalSub add goldballkind	int				default(2)
update dbo.tRouletteLogTotalSub set goldballkind = 2
--�������� tRouletteLogTotalSub --> PRIMARY KEY (dateid, silverball, itemcode, goldballkind)
-- exec spu_Roulette 'guest11856', '6528575u7d1d4w744765', -1
-- exec spu_RouletteGold 'guest11856', '6528575u7d1d4w744765', -1
-- update dbo.tUserMaster set goldball = 10000 where gameid = 'sususu'

declare @loop int set @loop = 1
while @loop < 100
	begin
		-- �̼� 15 ~ 25�� (1�����߿� 10�� ����)
		-- �̱� �Ϲ�
		select (15 + Convert(int, ceiling(RAND() * 10))) '�̼�',

			   ( 0 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�1-1',
			   ( 3 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�1-2',
			   ( 6 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�1-3',

			   ( 9 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�2-1',
			   (12 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�2-2',
			   (15 + Convert(int, ceiling(RAND() *  5)) - 1) '�̱�2-3'


		set @loop = @loop + 1
	end


*/



/*
---------------------------------------------
-- 	�귿 �α� > ����2 Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalMaster2', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalMaster2;
GO

create table dbo.tRouletteLogTotalMaster2(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	goldballkind	int				default(2),

	goldball		int				default(0),			-- ���� ��纼 (-)
	silverball		int				default(0),			-- ���� �ǹ��� (+)
	itemcodecnt		int				default(0),			-- ���� ������ (+)
	cnt				int				default(1),			-- ���� 	   (+)

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalMaster2_dateid_goldballkind	PRIMARY KEY(dateid, goldballkind)
)
insert into tRouletteLogTotalMaster2(dateid, goldballkind, goldball, silverball, itemcodecnt, cnt)
select dateid, goldballkind, goldball, silverball, itemcodecnt, cnt from tRouletteLogTotalMaster order by idx desc

---------------------------------------------
-- 	�귿 �α� > ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalSub2', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalSub2;
GO

create table dbo.tRouletteLogTotalSub2(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	goldballkind	int				default(2),

	goldball		int				default(0),
	silverball		int				default(0),
	itemcode		int				default(-1),
	cnt				int				default(1),
	comment			varchar(128),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalSub2_dateid_silverball_itemcode PRIMARY KEY(dateid, silverball, itemcode, goldballkind)
)

insert into tRouletteLogTotalSub2(dateid, goldballkind, goldball, silverball, itemcode, cnt, comment)
select dateid, goldballkind, goldball, silverball, itemcode, cnt, comment from tRouletteLogTotalSub order by idx asc
*/

/*
---------------------------------------------
--  ������ ������ ���̺�
---------------------------------------------
IF OBJECT_ID (N'dbo.tDoubleModeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tDoubleModeInfo;
GO

create table dbo.tDoubleModeInfo(
	idx					int 				IDENTITY(1, 1),
	doubleitemcode		int					default(7002),

	doubleperiodinfo	int					default(3),
	doublepowerinfo		int					default(50),
	doubledegreeinfo	int					default(50),
	doublepriceinfo		int					default(20),

	--flag				int					default(1),			--(1):Ȱ��ȭ, (0)��Ȱ��ȭ
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tDoubleModeInfo_idx	PRIMARY KEY(idx)
)
insert into dbo.tDoubleModeInfo(doubleitemcode, doubleperiodinfo, doublepowerinfo, doubledegreeinfo, doublepriceinfo) values(7002, 3, 50, 50, 20)
-- select top 1 * from dbo.tDoubleModeInfo where flag = 1 order by idx desc
-- DoublePowerMode(�α���, ������)
declare @doubleitemcode					int				set	@doubleitemcode				= 7002;
declare @doublepowerinfo				int				set @doublepowerinfo			= 50
declare @doubledegreeinfo				int				set @doubledegreeinfo			= 50
declare @doublepriceinfo				int				set @doublepriceinfo			= 20
declare @doubleperiodinfo				int				set @doubleperiodinfo			= 3

select top 1
	@doublepowerinfo 	= doublepowerinfo,
	@doubledegreeinfo 	= doubledegreeinfo,
	@doublepriceinfo	= doublepriceinfo,
	@doubleperiodinfo	= doubleperiodinfo
from dbo.tDoubleModeInfo
where flag = 1 order by idx desc

select @doublepowerinfo, @doubledegreeinfo, @doublepriceinfo, @doubleperiodinfo

*/
/*
--�÷����� ���Է�
alter table dbo.tUserMaster add doublepower		int					default(50)
alter table dbo.tUserMaster add doubledegree	int					default(50)
update dbo.tUserMaster set doublepower = 15, doubledegree = 15



*/
/*
-- HomerunGM �� ��ƶ� ����, ����
-- ����Ÿ ī��
insert into dbo.tBattleLog(gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, btTotalPower, btTotalCount, btAvg, btsb, btmode, winstreak, winstreak2, btcomment)
select gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, btTotalPower, btTotalCount, btAvg, btsb, btmode, winstreak, winstreak2, btcomment
from dbo.tBattleLog where gameid = 'HomerunGM'

select count(*) from dbo.tBattleLog where gameid = 'HomerunGM'

select top 10 * from dbo.tBattleLog order by idxOrder desc

-- ���߿� ������
select count(*) from dbo.tBattleLog where gameid = 'HomerunGM'
select top 10 * from dbo.tBattleLog where gameid = 'HomerunGM' order by idxOrder desc
select top 10 * from dbo.tBattleLog where gameid = 'HomerunGM' order by idxOrder asc
select top 10 * from dbo.tBattleLog where gameid = 'HomerunGM' and writedate >= '2013-01-08' order by idxOrder desc --��¥���� ī���ؼ� �����Ѵ�.
select count(*) from dbo.tBattleLog where gameid = 'HomerunGM' and idxOrder >= 200000
-- delete from dbo.tBattleLog where gameid = 'HomerunGM' and idxOrder >= 200000
*/
/*
update dbo.tUserMaster
set
	itemupgradecnt = 0,
	itemupgradebest = 300,
	petmatingcnt = 70,
	petmatingbest = 100
where
itemupgradecnt is null
or itemupgradebest is null
or petmatingcnt is null
or petmatingbest is null


select itemupgradecnt, itemupgradebest, petmatingcnt, petmatingbest, * from dbo.tUserMaster
where
itemupgradecnt is null
or itemupgradebest is null
or petmatingcnt is null
or petmatingbest is null


select
ltrim(rtrim(str(isnull(ccharacter, 0)))) + ',' +
ltrim(rtrim(str(isnull(face, 50)))) + ',' +
ltrim(rtrim(str(isnull(cap, 100)))) + ',' +
ltrim(rtrim(str(isnull(cupper, 200)))) + ',' +
ltrim(rtrim(str(isnull(cunder, 300)))) + ',' +
ltrim(rtrim(str(isnull(bat, 400)))) + ',' +
ltrim(rtrim(str(isnull(pet, -1)))) + ',' +
ltrim(rtrim(str(isnull(glasses, -1)))) + ',' +
ltrim(rtrim(str(isnull(wing, -1)))) + ',' +
ltrim(rtrim(str(isnull(tail, -1)))) + ',' +
isnull(customize, '1')
, customize, * from dbo.tUserMaster where gameid = 'DD1'

<btiteminfo>0,50,100,200,300,400,-1,-1,-1,-1,1,</btiteminfo>
<btiteminfo>3,53,149,249,349,420,-1,510,603,703,2</btiteminfo>
            3,53,149,249,349,420,-1,510,603,703,3,
ccharacter  face        cap         cupper      cunder      bat    pet      glasses     wing        tail          customize                                                                                                                        stadium     actionCount actionMax   actionTime              coin        coindate                friendLSCount friendLSMax friendLSTime            smsCount    smsMax      smsTime                 doubledate              trainflag   trainpoint  machineflag machinepoint memorialflag memorialpoint soulflag    soulpoint   btflag      btflag2     gradeexp    grade       gradestar   lvexp       lv          bttem1chk   bttem2chk   bttem3chk   bttem4chk   bttem5chk   bttotal     btwin       btlose      bttem1cnt   bttem2cnt   bttem3cnt   bttem4cnt   bttem5cnt   winstreak   winstreak2  grademax    sprintwin   petmsg                                             itemupgradecnt itemupgradebest petmatingcnt petmatingbest machpointaccrue machpointbest machplaycnt mempointaccrue mempointbest memplaycnt  friendaddcnt friendvisitcnt pollhitcnt  ceilhitcnt  boardhitcnt btdistaccrue btdistbest  bthrcnt     bthrcombo   btwincnt    btwinstreak btplaycnt   spdistaccrue spdistbest  sphrcnt     sphrcombo   spwincnt    spwinstreak spplaycnt   dayplusdate             trainpointbkup machinepointbkup memorialpointbkup soulpointbkup bttotalbkup btwinbkup   btlosebkup  eventnpcwin
3           53          149         249         349         420    -1         510         603       703           2.660899                                                                                                                         802         41          41          2012-11-28 15:58:26.950 1           2012-11-27 17:58:26.950 5             5           2012-11-28 15:44:45.750 10          10          2012-11-29 09:27:13.707 2013-01-16 14:10:54.693 0           0           0           0            0            0             1           0           0           0           12          3           0           2810        33          1           1           0           1           1           0           0           0           0           1           0           0           2           0           0           24          0           ???????                                            0              0               0            0             0               0             0           0              0            0           0            0              0           0           0           0            0           0           0           0           0           0           0            0           0           0           0           0           0           2012-11-28 15:51:48.397 0              0                0                 0             0           0           0           0
3           53          ,149,       249,        349,        420,   -1,      510,        603,        703,          2</btiteminfo>

*/

/*

-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_phone')
    DROP INDEX tUserMaster.idx_tUserMaster_phone
GO
CREATE INDEX idx_tUserMaster_phone ON tUserMaster (phone)
GO


*/


/*

---------------------------------------------
-- 	(���� ����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tMessageAdmin', N'U') IS NOT NULL
	DROP TABLE dbo.tMessageAdmin;
GO

create table dbo.tMessageAdmin(
	idx			int					IDENTITY(1,1),
	adminid		varchar(20),
	gameid		varchar(20),
	comment		varchar(1024),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tMessageAdmin_idx	PRIMARY KEY(idx)
)

-- insert into tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '�������');
-- select top 100 * from tMessageAdmin order by idx desc

*/
/*
select (Convert(int, ceiling(RAND() * 10)) + 10)
*/
/*
declare @gameid varchar(20)
declare @newid varchar(20)
--set @gameid = 'superman4'
set @gameid = 'hakunamatata'
set @newid = 'HomerunGM'

update dbo.tUserMaster set gameid = @newid where gameid = @gameid
update dbo.tUserCustomize set gameid = @newid where gameid = @gameid
update dbo.tBattleLogSearchJump set gameid = @newid where gameid = @gameid
update dbo.tBattleLogSearch set gameid = @newid where gameid = @gameid
update dbo.tBattleLog set gameid = @newid where gameid = @gameid
update dbo.tQuestUser set gameid = @newid where gameid = @gameid
update dbo.tAdminUser set gameid = @newid where gameid = @gameid
update dbo.tRouletteLogPerson set gameid = @newid where gameid = @gameid
update dbo.tUserSMSLog set gameid = @newid where gameid = @gameid
update dbo.tMessage set gameid = @newid where gameid = @gameid
update dbo.tCashLog set gameid = @newid where gameid = @gameid
update dbo.tCashChangeLog set gameid = @newid where gameid = @gameid
update dbo.tGiftList set gameid = @newid where gameid = @gameid
update dbo.tUserItem set gameid = @newid where gameid = @gameid
update dbo.tItemBuyLog set gameid = @newid where gameid = @gameid
update dbo.tUserItemUpgradeLog set gameid = @newid where gameid = @gameid
update dbo.tUserUnusualLog set gameid = @newid where gameid = @gameid
update dbo.tUserBlockLog set gameid = @newid where gameid = @gameid
update dbo.tUserDeleteLog set gameid = @newid where gameid = @gameid
update dbo.tUserFriend set gameid = @newid where gameid = @gameid
update dbo.tUserFriend set friendid = @newid where friendid = @gameid


*/
/*
declare	@doubledate		datetime						set @doubledate = getdate() + 3
select @doubledate, getdate()
--update dbo.tUserMaster set doubledate = '2012-01-01' where gameid = 'guest74086'

-- ������:2012-01-01 00:00:00 > ������:2013-01-10 14:17:23
-- ������:2013-01-12 13:41:32 > ������:2013-01-15 13:41:32
-- ����������
update dbo.tUserMaster
set
	doubledate 		= doubledate + 3
where doubledate > getdate()

-- �űԱ���
update dbo.tUserMaster
set
	doubledate 		= getdate() + 3
where doubledate < getdate()

select * from dbo.tItemBuyLog where itemcode = 7002
*/
/*

---------------------------------------------
-- 	������ȣ > ���Խ� ��ó����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBlockPhone;
GO

create table dbo.tUserBlockPhone(
	idx			int 					IDENTITY(1, 1),
	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tUserBlockPhone(phone, comment) values('01022223333', '������ī��')
-- insert into dbo.tUserBlockPhone(phone, comment) values('01092443174', 'ȯ������ī��')
-- select top 100 * from dbo.tUserBlockPhone order by idx desc
-- select top 1   * from dbo.tUserBlockPhone where phone = '01022223333'

-- ����Ű �浹�˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockPhone_idx')
    DROP INDEX tUserBlockPhone.idx_tUserBlockPhone_idx
GO
CREATE INDEX idx_tUserBlockPhone_idx ON tUserBlockPhone (idx)
GO



*/

/*
select * from tCashChangeLog
exec spu_HomerunD 12, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', ''

update dbo.tCashChangeLogTotal
	set
		goldball = goldball - (500 + 500 -5000 +4)*2,
		silverball = silverball - (220*4 + 200000*2 - 1100000)*2
where dateid = '20130106'

select * from tCashChangeLogTotal where dateid = '20130106'

*/
/*
insert into dbo.tItemInfo(labelname, itemcode, itemname, sex, kind, active, itemfilename, pluspower, sale, backicon, iconindex, lv, param1, param2, param3, param4, param5, param6, param7, param8, param9, silverball, goldball, period, explain)
values('etcitem', '7003', '�ν��͸��', '255', '99', '-1', 'etc3', '0', '0', '0', '60', '0', '-999', '-999', '-999', '-999', '-999', '-999', '-1', '-1', '-999', '0', '20', '-1', '3�ϰ� �Ŀ��� ���е� ���')
GO



---------------------------------------------
-- 	�ν���, ���� > ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemBuyPromotionTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tItemBuyPromotionTotal;
GO

create table dbo.tItemBuyPromotionTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	itemcode		int,

	cnt				int				default(1),
	goldball		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tItemBuyPromotionTotal_dateid_itemcode	PRIMARY KEY(dateid, itemcode)
)

--update dbo.tItemBuyPromotionTotal
--	set
--		goldball = goldball + 20,
--		cnt = cnt + 1
--where dateid = '20130105' and itemcode = 7002
-- insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, cnt, goldball) values('20130105', 7002, 1, 20)
-- insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, cnt, goldball) values('20130105', 7003, 1, 20)
-- select top 100 * from dbo.tItemBuyPromotionTotal order by dateid desc, itemcode desc
-- select top 1   * from dbo.tItemBuyPromotionTotal where dateid = '20130105' and itemcode = 7002

-- �Ҹ���
declare @ITEMCODE_DOUBLE_MODE				int				set	@ITEMCODE_DOUBLE_MODE				= 7002;
declare @ITEMCODE_DOUBLE_MODE_PRICE			int				set	@ITEMCODE_DOUBLE_MODE_PRICE			= 20;
declare @ITEMCODE_BOOST_MODE				int				set	@ITEMCODE_BOOST_MODE				= 7003;
declare @ITEMCODE_BOOST_MODE_PRICE			int				set	@ITEMCODE_BOOST_MODE_PRICE			= 20;
declare @itemcode			int 				set @itemcode 				= @ITEMCODE_DOUBLE_MODE
declare @dateid varchar(8)
set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
declare @gameid				varchar(20)
declare @goldball			int
declare	@doubledate			datetime
declare @goldballPrice		int					set @goldballPrice 			= @ITEMCODE_DOUBLE_MODE_PRICE
declare @silverballPrice 	int					set @silverballPrice		= 20000


			---------------------------------------------------------
			-- ����ǹ�, �ν��͸�� �αױ��
			---------------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyPromotionTotal
						set
							goldball = goldball + @goldballPrice,
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
					values(@dateid, @itemcode, @goldballPrice, 1)
				end


*/
/*
	-- Ÿ���� ����
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40�п� �ѹ���
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- ģ����Ŀ��ǹ� 20M�п� �Ѱ��� ä����
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)
	declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-01-17'	-- 1.16�ϱ���
	declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	declare @GOLDBALLGIVE_OPEN_EVENT01		int				set @GOLDBALLGIVE_OPEN_EVENT01		= 3
	declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	declare @COINGIVE_OPEN_EVENT01			int				set @COINGIVE_OPEN_EVENT01			= 3

	declare @coindate		datetime
declare @nCointPerMin bigint,
					@nCoinCount int,
					@dCoinTime datetime,
					@nCoinGive int,
					@coin int
set @coin = 0
set @coindate = '2013-01-03'

			set @nCointPerMin = @LOOP_TIME_COIN
			set @nCoinCount = datediff(s, @coindate, getdate())/@nCointPerMin
			set @dCoinTime = DATEADD(s, @nCoinCount*@nCointPerMin, @coindate)
			set @nCoinGive = @COINGIVE_NORMAL
			if(getdate() < @OPEN_EVENT01_END)
				begin
					set @nCoinGive = @COINGIVE_OPEN_EVENT01
				end
select 1,@nCoinGive, @coin

			--set @coin = @coin + @nCoinCount
			--set @coin = case when @coin > @nCoinGive then @nCoinGive else 0 end
			if(@coin < @nCoinGive)
				begin
select 2,@nCoinGive, @coin
					--------------------------------
					-- ������ ���� ����
					--------------------------------
					set @coin = @coin + case when @nCoinCount > 0 then @nCoinGive else 0 end
select 3, @nCoinGive, @coin
					set @coin = case when @coin > @nCoinGive then @nCoinGive when @coin < 0 then 0 else @coin end
select 4, @nCoinGive, @coin
				end
			--else
			--	begin
			--		--------------------------------------
			--		-- ������Ʈ�� �߰�ȹ��� ���� > �״�� ����
			--		--------------------------------------
			--	end
			--select 'DEBUG ��������', @coindate, getdate(), @nCoinCount, @coin, @dCoinTime
			--select 'DEBUG (��)', @actionCount actionCount, @actionMax actionMax, @actionTime actionTime, @friendlscount friendlscount,  @friendlsmax friendlsmax, @friendlstime friendlstime,  @coin coin,  @coindate coindate

select 5, @nCoinGive, @coin


/*
select * from dbo.tUserFriend where gameid = 'superman' and friendid = 'pjstime'


alter table dbo.tAdminUser add grade			int					default(0)

update dbo.tAdminUser set grade = 100 where grade is null
update dbo.tAdminUser set grade = 1000 where gameid = 'blackm'
update dbo.tAdminUser set grade = 100 where gameid = 'black4'

*/
/*
--select Convert(varchar(8), Getdate(), 112)
select Convert(varchar(8), writedate, 112), * from dbo.tCashLog
select * from dbo.tCashTotal

declare @gameid_		varchar(512)
declare @idx int
set @gameid_ = 'SangSang'
set @idx = 2

declare @dateid varchar(8)
declare @market int
declare @goldball int
declare @cash int

-- �˻��ؼ� ������ ������, ����
select
	@dateid = Convert(varchar(8), writedate, 112),
	@market = market,
	@goldball = goldball,
	@cash = cash
from dbo.tCashLog
where idx = @idx and gameid = @gameid_

delete dbo.tCashLog where idx = @idx and gameid = @gameid_

update dbo.tCashTotal
	set
		goldball = goldball - @goldball,
		cash = cash - @cash,
		cnt = cnt - 1
where dateid = @dateid and cashkind = @cash and market = @market
*/

/*

alter table dbo.tUserMaster add eventnpcwin			int				default(0)

update dbo.tUserMaster
	set
		eventnpcwin = 0
where eventnpcwin is null

select * from dbo.tUserMaster where eventnpcwin = 1

*/
/*

alter table dbo.tNotice add market			int				default(1)
alter table dbo.tNotice add adurl2			varchar(512)
alter table dbo.tNotice add adfile2			varchar(512)

update dbo.tNotice set market = 1 where market is null
update dbo.tNotice set adurl2 = adurl, adfile2 = adfile  where adurl2 is null
update dbo.tNotice set branchurl = adurl where branchurl is null
update dbo.tNotice set facebookurl = adurl where facebookurl is null

select * from dbo.tNotice
where idx in (select max(idx) from dbo.tNotice group by market)
order by market asc
*/

/*
alter table dbo.tCashLog add market			int				default(1)
update dbo.tCashLog set market = 1 where market is null
*/

/*
alter table dbo.tUserJoinTotal add market			int				default(1)
update dbo.tUserJoinTotal set market = 1 where market is null

insert into dbo.tUserJoinTotal(dateid, market, cnt, cnt2)
select dateid, market, cnt, cnt2 from dbo.tUserJoinTotal2 order by idx asc

ALTER TABLE dbo.tUserJoinTotal DROP pk_tUserJoinTotal_dateid
Alter Table dbo.tUserJoinTotal alter column dateid			char(8) not null
Alter Table dbo.tUserJoinTotal ADD CONSTRAINT	pk_tUserJoinTotal_dateid_market	PRIMARY KEY(dateid, market)
*/
--------------------------------------------
-- ��뷮 Ǫ��������
---------------------------------------------
/*

-- ��뷮���� �Է��ϱ�
insert into dbo.tQuestUser(gameid, questcode, queststate, queststart)
	select @gameid_, questcode, @QUEST_STATE_USER_ING, getdate()
		from dbo.tQuestInfo where questinit = @QUEST_INIT_FIRST



insert into dbo.tUserPushAndroid(recepushid, sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
	select distinct pushid, @ps2_, @gameid_, @p5_, 99, @ps3_, @ps4_, @branchurl from dbo.tUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50

	select distinct pushid, 'a2' from dbo.tUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50
		and gameid in ('guest74019', 'guest74022')

	select distinct pushid, 'a2' from dbo.tUserMaster
		where gameid in ('guest74019', 'guest74022')

*/

--------------------------------------------
--
---------------------------------------------

/*
declare @goldballPrice	int,		@silverballPrice	int, @sale			int

set @sale = 10
set @goldballPrice = 0
set @silverballPrice = 15

		-- ������ ��������.
		if(@sale > 0 and @sale <= 100)
			begin
				if(@goldballPrice > 0)
					begin
						set @goldballPrice = @goldballPrice * (100 - @sale) / 100
					end
				else if(@silverballPrice > 0)
					begin
						set @silverballPrice = @silverballPrice * (100 - @sale) / 100
					end
			end

select @goldballPrice goldballPrice, @silverballPrice silverballPrice
*/
/*
alter table dbo.tNotice add adurl			varchar(512)
alter table dbo.tNotice add adfile			varchar(512)
update dbo.tNotice set adurl = '', adfile = ''
*/
/*
select (getdate() - 1)
alter table dbo.tUserMaster add doubledate		datetime			default(getdate() - 1)
update dbo.tUserMaster set doubledate = (getdate() - 1)

declare @doubledate datetime
set @doubledate = '20121205'
if(getdate() < @doubledate)
	select '������'
else
	select '�Ϲݸ��'
select getdate(), DATEADD(dd, 3, getdate())

alter table dbo.tBattleLog add btcomment	varchar(256)
update dbo.tBattleLog set btcomment = ''


--��õ�� �� �����
alter table dbo.tUserMaster add mboardstate	int						default(0)
update dbo.tUserMaster set mboardstate = 0
alter table dbo.tMarketPatch add mboardurl	varchar(512)		default('')
update dbo.tMarketPatch set mboardurl = ''

declare @gameid			varchar(20)
declare @mboardstate	int
select
	@gameid = gameid, @mboardstate = mboardstate
	from dbo.tUserMaster
where gameid = 'superman'
select @gameid gameid, @mboardstate mboardstate

select * from tMarketPatch
delete from tMarketPatch where market = 7 and buytype = 1
delete from tMarketPatch where buytype = 1

select branchurl, mboardurl from dbo.tMarketPatch
where market = 1 and buytype = 0

select * from tUs

alter table dbo.tUserMaster add resultwinpush		int 					default(0)
update dbo.tUserMaster set resultwinpush = 0

*/
--------------------------------------------
-- ��Ʋ �ֱ� 10��
---------------------------------------------
/*
-- �� <- ���  btgameid, idxOrder
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_btgameid_idxOrder')
    DROP INDEX tBattleLog.idx_tBattleLog_btgameid_idxOrder
GO
CREATE INDEX idx_tBattleLog_btgameid_idxOrder ON tBattleLog (btgameid, idxOrder desc)
GO

-- �� -> ��� gameid, idxOrder
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_idxOrder')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_idxOrder
GO
CREATE INDEX idx_tBattleLog_gameid_idxOrder ON tBattleLog (gameid, idxOrder desc)
GO

-- �ε����� �Ǿ� �־ �׷��� �о����ȴ�. ������
select top 10 * from dbo.tBattleLog where btgameid = 'pjstime' order by idxOrder desc


-- �� -> ���
--declare @gameid_ varchar(20)
set @gameid_ = 'pjstime'
--select top 10 btgameid, * from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc

select u2.avatar, u2.picture, u2.ccode, u2.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from
	(select top 20 * from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc) as bt
		join
	(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster
		where gameid in
			(select top 20 btgameid from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc)) as u2
	on bt.btgameid = u2.gameid

-- �� <- ���(�����Ѱ͵�)
declare @gameid_ varchar(20)
set @gameid_ = 'pjstime'
--select top 10 gameid, * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc

select u2.avatar, u2.picture, u2.ccode, bt.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from
	(select top 20 * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc) as bt
		join
	(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster
		where gameid in
			(select top 20 gameid from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc)) as u2
	on bt.gameid = u2.gameid

select * from dbo.tUserMaster where gameid = 'pjstime' and password = '37993721339797757114'
*/


--------------------------------------------
-- Android Push �߼��� �α������� �̵��ϱ�
---------------------------------------------
/*
-- select min(idx) min, max(idx) max from dbo.tUserPushAndroid
-- select * from dbo.tUserPushAndroid
DECLARE @tTemp TABLE(
				sendid			varchar(20),
				receid			varchar(20),
				recepushid		varchar(256),
				comment			varchar(256)
			);
delete from dbo.tUserPushAndroid
	OUTPUT DELETED.sendid, DELETED.receid, DELETED.recepushid, DELETED.comment into @tTemp
	where idx in (1, 2)
	--where idx between 1 and 2
-- select * from @tTemp

insert into dbo.tUserPushAndroidLog(sendid, receid, recepushid, comment)
	(select sendid, receid, recepushid, comment from @tTemp)
-- select * from dbo.tUserPushAndroidLog
*/

--------------------------------------------
--
---------------------------------------------
/*
update dbo.tUserMaster set smsCount = 10, smsMax = 10, smsTime = getdate()
delete from tBattleCountry where ccode > 18
select * from tBattleCountry where ccode > 18

delete from tBattleCountry where ccode <= 1
select * from tBattleCountry where ccode <= 1
select * from tBattleCountry
exec spu_HomerunD 21, -1, -1,  5, -1, -1, -1, -1, -1, -1, '', '', '', '', ''		--�������(5)

select count(*) from dbo.tUserMaster where ccode <= 1 or ccode >= 19
update dbo.tUserMaster
	set
		ccode = 2
 where ccode <= 1 or ccode >= 19
*/
--------------------------------------------
-- ��������
---------------------------------------------
/*
declare @loop int	set @loop = 0
declare @CCODE_MAX int set @CCODE_MAX = 18

while @loop < 100
	begin
		-- 1 <= x <= @MAX
		--select Convert(int, ceiling(RAND() * @CCODE_MAX))
		--set @loop = @loop + 1

		-- 0 <= x <= @MAX - 1
		--select Convert(int, ceiling(RAND() * @CCODE_MAX - 1))
		--set @loop = @loop + 1

		select 1 + Convert(int, ceiling(RAND() * 17 ))
		set @loop = @loop + 1
	end
select Convert(int, ceiling(RAND() * 2))
*/
--------------------------------------------
-- ���̵� �˻��� ���ؼ� ��ŷ
---------------------------------------------
-- ��ŷTop10���⿹��(MSSQL).sql �������Ŀ�
/*
declare @gameid			varchar(20)
declare @machinepoint	int,
		@memorialpoint	int,
		@bttotal		int,
		@btwin			int

set @gameid = 'SangSang777'

select @gameid = gameid, @machinepoint = machinepoint, @memorialpoint = memorialpoint, @btwin = btwin, @bttotal = bttotal from tUserTTT where gameid = @gameid
select @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal

select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal from dbo.tUserTTT where machinepoint > @machinepoint
select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal from dbo.tUserTTT where memorialpoint > @memorialpoint
select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal from dbo.tUserTTT where btwin > @btwin
*/

--------------------------------------------
-- �˻� ��� ��ȭ
---------------------------------------------
--select top 1 * from dbo.tUserMaster where gameid = 'mogly'
--select top 10 * from dbo.tBattleLog where gameid = 'mogly'

--------------------------------------------
-- ȯ��
---------------------------------------------
/*
declare @goldballChange_ int
declare @plus decimal(10, 1)
declare @silverball2 int

set @goldballChange_ = 10

while @goldballChange_ < 600
	begin
		set @plus = 0
		if(@goldballChange_ <= 20)
			begin
				set @plus = 0.1
			end
		else if(@goldballChange_ <= 50)
			begin
				set @plus = 0.2
			end
		else if(@goldballChange_ <= 100)
			begin
				set @plus = 0.3
			end
		else if(@goldballChange_ <= 300)
			begin
				set @plus = 0.4
			end
		else if(@goldballChange_ < 500)
			begin
				set @plus = 0.5
			end
		else
			begin
				set @plus = 1.0
			end

		set @silverball2 = (@goldballChange_ * 200) + (@goldballChange_ * 200) * @plus
		select @goldballChange_ goldballChange, @plus plus, @silverball2 silverball2

		set @goldballChange_ = @goldballChange_ + 10
	end
*/


--------------------------------------------
-- �������
---------------------------------------------
/*
select top 10 * from dbo.tUserMaster order by regdate desc

select * from dbo.tUserMaster
where regdate >= '2012-11-14 19:00:00' and regdate <= '2012-11-18 23:59:59'
order by regdate desc

-- �ϰ�����Ȳ
select Convert(varchar(8), regdate,112), count(*) from dbo.tUserMaster
where regdate >= '2012-11-14 19:00:00' and regdate <= '2012-11-18 23:59:59'
and phone != ''
group by Convert(varchar(8), regdate,112)
order by 1 desc

-- �÷��� ����
select m.gameid, cnt, email, regdate, concnt, phone, grade, lv from
	(select gameid, count(gameid) cnt from dbo.tBattleLog
	where writedate >= '2012-11-14 19:00:00' and writedate <= '2012-11-18 23:59:59'
	group by gameid ) p
		join
	(select gameid, email, regdate, concnt, phone, grade, lv from dbo.tUserMaster
	--where regdate >= '2012-11-14 19:00:00' and regdate <= '2012-11-18 23:59:59'
	--and phone != ''
	) m
		on p.gameid = m.gameid
order by cnt desc, lv desc, grade desc

-- �����ۺ� �Ǹ���Ȳ
select top 10 * from dbo.tUserItem
where buydate >= '2012-11-14 19:00:00' and buydate <= '2012-11-18 23:59:59'


select count(*) from dbo.tUserItem
where buydate >= '2012-11-14 19:00:00' and buydate <= '2012-11-18 23:59:59'
group by itemcode



select i.itemcode, itemname, goldball, silverball, s.upgradestate, s.upgradecost, s.cnt, s.cnt*goldball '����Ǹű�', s.cnt*silverball '�ǹ��Ǹű�'
	from dbo.tItemInfo i
		join
	(select itemcode, sum(upgradestate) upgradestate, sum(upgradecost) upgradecost, count(itemcode) cnt from dbo.tUserItem
		where buydate >= '2012-11-14 19:00:00' and buydate <= '2012-11-18 23:59:59'
		group by itemcode
		-- having sum(upgradestate) > 0 or sum(upgradecost) > 0
	) s
	on i.itemcode = s.itemcode
order by 1 asc

*/

--------------------------------------------
-- ��ŷ�ʱ�ȭ
---------------------------------------------
/*
declare @loopStart	int,
		@loopEnd	int,
		@interval	int

set @loopStart = 0
set @interval = 1000
select @loopEnd = max(idx) from dbo.tUserMaster
while @loopStart < @loopEnd
	begin
		-- select top 10 machinepoint, memorialpoint, btwin, bttotal, btlose from dbo.tUserMaster
		select str(@loopStart) + ' ~ ' + str(@loopStart + @interval)
		update dbo.tUserMaster
			set
				machinepoint = 0,
				memorialpoint = 0,
				btwin = 0,
				bttotal = 0,
				btlose = 0
		where idx >= @loopStart and idx < @loopStart + @interval

		set @loopStart = @loopStart + @interval
	end
*/

--------------------------------------------
-- ����� > �ű� ���׽�Ʈ
---------------------------------------------
/*
select
	spdistaccrue, spdistbest, sphrcnt, sphrcombo, spwincnt, spwinstreak, spplaycnt,
	btdistaccrue, btdistbest, bthrcnt, bthrcombo, btwincnt, btwinstreak, btplaycnt,
	machpointaccrue, machpointbest, machplaycnt,
	mempointaccrue, mempointbest, memplaycnt,
	friendaddcnt, friendvisitcnt,
	pollhitcnt, ceilhitcnt, boardhitcnt,
	itemupgradebest, itemupgradecnt, petmatingbest, petmatingcnt
		from dbo.tUserMaster where gameid = 'superman6'
update dbo.tUserMaster set trainflag = 1, machineflag = 1, memorialflag	= 1, soulflag = 1, btflag = 1, btflag2 = 1, blockstate = 0, cashcopy = 0, resultcopy = 0 where gameid = 'superman6'
--exec spu_GameEndNew 'superman6', 2, 100,		18, 7,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��
--exec spu_GameEndNew 'superman6', 3, 250,		12, 4,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ϱ���
--exec spu_GameEndNew 'superman6', 5, 1000,		-- gameid, gmode, point																-- ��Ʋ���
exec spu_GameEndNew 'superman6', 6, 1000,		-- gameid, gmode, point																-- ������Ʈ
	21, 8,				-- lvexp, lv
	10,					-- get silver
	2, 1, 2, 1,			-- gradeexp, grade, gradestar, btresult(win/lose)
	'DD1',				-- btgameid
	'@1,4600,24,10@1,4800,25,20@1,4900,26,30@1,4000,28,40@1,4100,29,50@1,4200,31,-10@1,4300,33,-20@1,4400,45,-30@1,4500,20,-40',	-- btlog_ ��Ʈ, �Ŀ�, ��, ����
	'1,0,0,0,0',		-- btitem_ 1 ~ 5���ۼ���
	'0,50,114,220,313,418,5003,510,610,706,2',	-- btiteminfo_ ĳ����, ��, �Ӹ�, ����, ����, ��Ʈ, ��, �Ӹ� �Ǽ��縮, ����, ����, Ŀ���� ����¡
	10000, 9, 1000,		-- bttotalpower_, bttotalcount_, btavg_
	1,					-- btsearchidx_
	20, 3, 4, 1, 2, 3,	-- bestdist_, homerun_, homeruncombo_, pollhit_, ceilhit_, boardhit_
	-1
select
	spdistaccrue, spdistbest, sphrcnt, sphrcombo, spwincnt, spwinstreak, spplaycnt,
	btdistaccrue, btdistbest, bthrcnt, bthrcombo, btwincnt, btwinstreak, btplaycnt,
	machpointaccrue, machpointbest, machplaycnt,
	mempointaccrue, mempointbest, memplaycnt,
	friendaddcnt, friendvisitcnt,
	pollhitcnt, ceilhitcnt, boardhitcnt,
	itemupgradebest, itemupgradecnt, petmatingbest, petmatingcnt
		from dbo.tUserMaster where gameid = 'superman6'
select * from dbo.tUserMaster where gameid = 'superman6'
delete from dbo.tBattleLog where gameid = 'superman6'
delete from dbo.tGiftList where gameid = 'superman6'
*/

--------------------------------------------
-- ��������Ʈ > ������ �Է��ϱ�
---------------------------------------------
/*
declare @gameid varchar(20)
declare curQuestUser Cursor for
	select gameid from dbo.tUserMaster
		where gameid not in (select distinct gameid from dbo.tQuestUser)

	Open curQuestUser
	Fetch next from curQuestUser into @gameid
	while @@Fetch_status = 0
		Begin
			insert into dbo.tQuestUser(gameid, questcode, queststate, queststart)
				select @gameid, questcode, 2, getdate()
					from dbo.tQuestInfo where questinit = 1
			Fetch next from curQuestUser into @gameid
		end
close curQuestUser
Deallocate curQuestUser
*/

--------------------------------------------
-- ��������Ʈ
---------------------------------------------
/*
-- id/quest ���� > �ʱ��� �ٷ����� (������ ���ʾ��ֱ�)
insert into dbo.tQuestUser(gameid, questcode, queststate, queststart)
	select 'Superman3', questcode, 2, getdate()
		from dbo.tQuestInfo where questinit = 1
-- select * from dbo.tQuestUser where gameid = 'Superman3'
-- delete from dbo.tQuestUser where gameid = 'Superman3'
*/

/*
-- �������������� ��Ȯ��
select gameid, i.questlv, u.questcode, u.queststate, queststart, questend, questnext, questkind, questsubkind, questvalue, rewardsb, rewarditem, content, questtime, * from dbo.tQuestUser u join
	(select * from dbo.tQuestInfo) i
		on u.questcode = i.questcode
where gameid = 'superman3'
--order by questcode asc
*/

/*
-- �α��� > ���ð� Ȯ�� -> ������Ʈ �ޱ�(��������, ���������� �ٲ�ð�)
-- update dbo.tQuestUser set queststate = 1 where gameid = 'superman3' and questcode = 100
declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 		= 0
declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 		= 1
declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 		= 2
declare @gameid_						varchar(20)		set @gameid_				= 'superman3'
declare @lv								int				set @lv						= 1
declare @questcode	int,	@questkind		int,	@questsubkind		int,		@questclear		int

-- �α��� > �����(1) and �ð��� ��ȿ > Ŀ���� ����
declare curQuestUser Cursor for
	select questcode, questkind, questsubkind, questclear from dbo.tQuestInfo
	where questcode in (select questcode from dbo.tQuestUser
						where gameid = @gameid_
							  and queststate = @QUEST_STATE_USER_WAIT
							  and getdate() > queststart)
	Open curQuestUser
	Fetch next from curQuestUser into @questcode, @questkind, @questsubkind, @questclear
	while @@Fetch_status = 0
		Begin
			if(@questclear = @QUEST_CLEAR_START)
				begin
					--select 'DEBUG �α��� > ����Ÿ Ŭ�������ּ���.', @questcode, @questkind, @questsubkind, @questclear
					exec spu_CheckQuestData @gameid_, @questkind, @questsubkind, -1
				end
			-- ����
			-- exec spu_ClearQuestUser @gameid_, 2, @questcode, @questkind, @questsubkind, @questclear
			Fetch next from curQuestUser into @questcode, @questkind, @questsubkind, @questclear
		end
close curQuestUser
Deallocate curQuestUser

-- �ӵ��� ���ؼ� �ϰ� --> ������(2)���� ����
update dbo.tQuestUser set queststate = @QUEST_STATE_USER_ING
where gameid = @gameid_ and queststate = @QUEST_STATE_USER_WAIT and getdate() > queststart

--> ������ ����Ʈ �����
select * from dbo.tQuestInfo
where questcode in (
	select questcode from dbo.tQuestUser
	where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
)
*/

/*
-- select * from dbo.tUserMaster where gameid like 'superman%'
-- ������ �����ֱ�
declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 			= 0
declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 			= 1
declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD			= 2
declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 		= 0
declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 		= 1
declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 		= 2
declare @gameid_						varchar(20)		set @gameid_				= 'superman3'
declare @lv								int				set @lv						= 1
declare @questcode int,		@questkind int,		@questsubkind int,		@questclear int

select * from dbo.tQuestUser where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING
--
-- ���Ϸ� > ���Ϸ�, ������ ����
-- select * from dbo.tQuestUser where gameid = 'SangSang' and questcode = 100
	-- ����Ʈ �Ϸῡ ���� ��������
	-- update dbo.tQuestUser set queststate = 0, questend = getdate() where gameid = 'SangSang' and questcode = 100
	-- update dbo.tUserMaster set ����SB, ������ where gameid = 'SangSang'
	--
	-- ������ �����ϱ�
	-- select @questnext = questnext from dbo.tQuestInfo where questcode = 100
	-- if(@questnext != -1)
	--	select @questtime = questtime from dbo.tQuestInfo where questcode = @questnext
	--	if(not exists(select top 1 * from dbo.tQuestUser where questcode = @questnext))
	--		insert into dbo.tQuestUser(gameid, questcode, queststate, queststart)
	--		values(@gameid, @questnext, �����(1), DATEADD(hh, @questtime, getdate())
	--	else
	--		update dbo.tQuestUser
	--			set
	--				queststate = �����(1),
	--				queststart = DATEADD(hh, @questtime, getdate())
	--		where gameid = @gameid and questcode = @questnext
	-- else
	--	���̻� �����ϱ� > �ڵ��Ҹ�ȴ�.


-- insert into dbo.tQuestUser(gameid, questcode, queststate, queststart) select 'SangSang', questcode, 2, DATEADD(hh, questtime, getdate()) from dbo.tQuestInfo where questinit = 1
-- ���Ϸ� > �Է�, ������Ʈ
*/

---------------------------------------------
-- ��ȭ��� ���ϱ�
---------------------------------------------
/*
declare @upgradeitemlv int set @upgradeitemlv = -10
while @upgradeitemlv <= 50
	begin
		set @upgradeitemlv = case when @upgradeitemlv < 0 then 0 else @upgradeitemlv end
		select @upgradeitemlv 'LV',
				50 + (@upgradeitemlv/5)*10 'item',
				50 + @upgradeitemlv*30 'pet'
		set @upgradeitemlv = @upgradeitemlv + 1
	end
*/


---------------------------------------------
-- �Ϸ翡 1 goldball �����ϱ�
---------------------------------------------
/*
declare @DAY_PLUS_TIME	bigint				set @DAY_PLUS_TIME = 24*60*60

declare @dayplusdate	datetime
declare @goldball		int
declare @dayplusgb		int
set @dayplusdate = getdate() - 1

-- �������� �о > @dayplusdate, @goldball

			-- �Ϸ翡 �ϳ��� ��纻 ����
			set @dayplusgb = datediff(s, @dayplusdate, getdate())/@DAY_PLUS_TIME
			if(@dayplusgb >= 1)
				begin
					-- �Ϸ翡
					set @dayplusgb = 1
					set @goldball = @goldball + 1
					set @dayplusdate = getdate()
				end
			else
				begin
					set @dayplusgb = 0
					--set @dayplusdate = getdate()
				end
-- �ٽóֱ�  > @dayplusdate, @goldball
select @dayplusgb
*/


----------------------------------------------
-- ��Ʋ�α� �Ϻλ����ϱ�
----------------------------------------------
/*
select count(*) from dbo.tBattleLog
-- delete from  dbo.tBattleLog where gameid = 'kimmogly'
-- delete from  dbo.tBattleLog where gameid = 'superman'
-- delete from  dbo.tBattleLog where gameid = 'parks'

select top 3 * from dbo.tBattleLog order by idxOrder asc
select top 3 * from dbo.tBattleLog order by idxOrder desc
select * from dbo.tBattleLog order by grade desc
*/

/*
-------------------------------------------------
declare @var int		set @var = 0
declare @var2 int		set @var2 = 0
declare @max int		set @max = 1465000
select top 1 @var = idxOrder from dbo.tBattleLog order by idxOrder asc
set @var2 = @var + 800000

if(@var2 > @max)
	begin
		set @var2 = @max
	end

while(@var < @var2)
	begin
		delete from  dbo.tBattleLog where idxOrder < @var
		set @var = @var + 10
		select @var
	end
*/



----------------------------------------------
-- ������Ʈ �˻�����
----------------------------------------------
/*
declare @winstreak2		int
declare @grademin2		int
declare @grademax2		int
declare @grade			int

set @grade = 1
set @winstreak2 = 0
while(@grade <= 50)
	begin
		while(@winstreak2 < 10)
			begin
				-- �����
				--set @grademin2 = @grade + @winstreak2 * 1 - 5
				--set @grademax2 = @grade + @winstreak2 * 3

				-- ó���� ���� ������ ��ư� > ��ƴ�.
				--set @grademin2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3
				--set @grademax2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3

				-- �������� �յ��ϰ�
				--set @grademin2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6
				--set @grademax2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6

				-- �����Ϳ� 1/2
				set @grademin2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.6
				set @grademax2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.8

				select @grade grade, @winstreak2 winstreak2, @grademin2 grademin2, @grademax2 grademax2

				set @winstreak2 = @winstreak2 + 1
			end
		set @grade = @grade + 5
		set @winstreak2 = 0
	end
*/