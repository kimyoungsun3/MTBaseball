use GameMTBaseball
GO


---------------------------------------------
--  ������ ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tAdminUser', N'U') IS NOT NULL
	DROP TABLE dbo.tAdminUser;
GO

create table dbo.tAdminUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(20),
	password		varchar(20),
	writedate		datetime			default(getdate()),
	grade			int					default(0),

	-- Constraint
	CONSTRAINT	pk_tAdminUser_idx	PRIMARY KEY(gameid)
)

--select * from dbo.tAdminUser
--insert into tAdminUser(gameid, password) values('blackm', 'a1s2d3f4')


-- �߸��ؼ� ���̺��� ��ü �ǵ帱�� �־ �ּ�ó���� ���Ƶд�.(���� �Ǽ������� �־)
-- �Է� < �˻�(�켱����)
-- ����Ÿ���̽� ��ҹ��� ���о���(���� ���õ� ���� Ȯ���ʿ�)
---------------------------------------------
--		��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserMaster;
GO

create table dbo.tUserMaster(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	password	varchar(20),									-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	sid			int						default(100),			-- ���� ���ǹ�ȣ.

	username	varchar(60),									-- ȫ�浿
	birthday	varchar(8),										-- 19900801
																-- 20000801
	email		varchar(60),									-- ai@aidata.com
	nickname	varchar(60),									-- �浿�г���...
	phone		varchar(60),									-- 01012345678 -> >5SEF5ES6Q7E
	connectip	varchar(20)				default(''),			-- ���ӽ� ���Ǵ� ip
	version		int						default(100),			-- ���Թ���.

	--(��������)
	regdate		datetime				default(getdate()),		-- ���ʰ�����
	condate		datetime				default(getdate()),		-- (�α��νø��� �Ź�������Ʈ)
	concnt		int						default(1),				-- ����Ƚ��
	logindate	varchar(8)				default('20100101'),	-- �α�������.

	-- (������)
	blockstate	int						default(0),				-- ���ƴ�(0), ������(1)
	cashcopy	int						default(0),				-- ĳ���ҹ�ī�ǽ� +1�߰��ȴ�.
	resultcopy	int						default(0),				-- �αװ��ī�ǽ� +1�߰��ȴ�.

	-- (���̹��Ӵ�)
	cashcost	int						default(0),				-- ���̾�.
	cashpoint	int						default(0),				-- ĳ�� �����ϸ� ����.
	cashreceivetotal	int				default(0),				-- ����, ������ ���� �����ݾ�.
	cashbuytotal		int				default(0),				-- ������ �����ݾ�.
	pieceboxopencnt		int				default(0),				-- �������¼���.
	wearboxopencnt		int				default(0),				-- �ǻ���¼���.
	adviceboxopencnt	int				default(0),				-- ������¼���.
	combinatecnt		int				default(0),				-- �����ǻ� ���ռ���.
	evolutioncnt		int				default(0),				-- �ϼ��ǻ��ʿ�����.

	-- (���Ӻ��� : �ȶ����)
	param0			int					default(0),				--Ŭ���̾�Ʈ����.
	param1			int					default(0),
	param2			int					default(0),
	param3			int					default(0),
	param4			int					default(0),
	param5			int					default(0),
	param6			int					default(0),
	param7			int					default(0),
	param8			int					default(0),
	param9			int					default(0),

	-- (���Ӻ��� : �Ϲ�����2)
	level			int					default(1),
	exp				int					default(0),				--
	commission		float				default(7.00), 			-- ������... (�⺻ 7%�� ����) -> ���� �뵵�ϻ��̴�.
	tutorial		int					default(0),				-- �Ⱥ�(0), ��(1)
	randserial		varchar(20)			default('-1'),			-- �����۱���, �ڽ����, ��������, �ǻ��ʿ����� ������ ������ ����������

	-- (���Ӻ��� : �̱۰��Ӻ���)
	sflag			int					default(0),				-- �̱۹�����(0), ������(1).
	strycnt			int					default(0),				-- �̱�Ƚ��.
	ssuccesscnt		int					default(0),				--   ����Ƚ��.
	sfailcnt		int					default(0),				--   ����Ƚ��.
	serrorcnt		int					default(0),				--   ����Ƚ��.

	-- (���Ӻ��� : ��������� �ε�������Ʈ)
	helmetlistidx		int 			default(-1),
	shirtlistidx		int 			default(-1),
	pantslistidx		int 			default(-1),
	gloveslistidx		int 			default(-1),
	shoeslistidx		int 			default(-1),
	batlistidx			int 			default(-1),
	balllistidx			int 			default(-1),
	gogglelistidx		int 			default(-1),
	wristbandlistidx	int 			default(-1),
	elbowpadlistidx		int 			default(-1),
	beltlistidx			int 			default(-1),
	kneepadlistidx		int 			default(-1),
	sockslistidx		int 			default(-1),

	-- �̺�Ʈ.
	eventspot01		int					default(0),				-- �α��λ��(1~5).
	eventspot02		int					default(0),
	eventspot03		int					default(0),
	eventspot04		int					default(0),
	eventspot05		int					default(0),
	eventspot06		int					default(0),				-- �������� ���.
	eventspot07		int					default(0),				-- 5���� �̻� ���Ž� �ϲ� ����(100005)
	eventspot08		int					default(0),				-- skt ����ù���� Ŭ����κ�.
	eventspot09		int					default(0),				-- �̻��
	eventspot10		int					default(0),				-- �̻��

	-- Constraint
	CONSTRAINT pk_tUserMaster_idx		PRIMARY KEY(idx)
)
GO
-- alter table dbo.tUserMaster add randserial			varchar(20)		default('-1')
-- ����Ÿ 10���� ������ �־ �����غ���(���ID�� ���� ������ �Է��Ѵ�.)
-- ���Խ� gameid ���� > PRIMARY KEY(gameid) > �ε���

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_gameid')
   DROP INDEX tUserMaster.idx_tUserMaster_gameid
GO
CREATE INDEX idx_tUserMaster_gameid ON tUserMaster (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_email')
    DROP INDEX tUserMaster.idx_tUserMaster_email
GO
CREATE INDEX idx_tUserMaster_email ON tUserMaster (email)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_nickname')
   DROP INDEX tUserMaster.idx_tUserMaster_nickname
GO
CREATE INDEX idx_tUserMaster_nickname ON tUserMaster (nickname)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_phone')
    DROP INDEX tUserMaster.idx_tUserMaster_phone
GO
CREATE INDEX idx_tUserMaster_phone ON tUserMaster (phone)
GO

-- insert into dbo.tUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
-- select * from dbo.tUserMaster where gameid = 'xxxx'
-- update dbo.tUserMaster set market = 1 where gameid = 'xxxx'

---------------------------------------------
--		������ ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItem', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItem;
GO

create table dbo.tUserItem(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- ����Ʈ�ε���(�����κ��� ����)

	invenkind		int					default(1),					--��з�(�����κ�(1), �����κ�(2), �Һ��κ�(3))
	itemcode		int,
	cnt				int					default(1),					--������

	randserial		varchar(20)			default('-1'),				--����������(Ŭ���̾�Ʈ���� ������)
	writedate		datetime			default(getdate()),			--������/ȹ����
	gethow			int					default(0),					--ȹ����

	-- Constraint
	CONSTRAINT	pk_tUserItem_gameid_listidx	PRIMARY KEY(gameid, listidx)
)

--alter table dbo.tUserItem add diedate			datetime
--alter table dbo.tUserItem add diemode			int					default(-1)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItem_idx')
    DROP INDEX tUserItem.idx_tUserItem_idx
GO
CREATE INDEX idx_tUserItem_idx ON tUserItem (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItem_gameid_itemcode')
    DROP INDEX tUserItem.idx_tUserItem_gameid_itemcode
GO
CREATE INDEX idx_tUserItem_gameid_itemcode ON tUserItem (gameid, itemcode)
GO

-- select isnull(max(listidx), 0) from dbo.tUserItem where gameid = 'xxxx'	--Ʈ���� ����ϸ� ������ �ʴ� ����� �����±�(insert:inserted, update:deleted/inserted, delete:deleted)
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 0, 1, 1, 0, 0, 1, 1001)
-- select top 1 * from dbo.tUserItem where gameid = 'xxxx' and randserial = 1010
-- update dbo.tUserItem set fieldidx = 0 where gameid = 'xxxx' and listidx = 1
-- select * from dbo.tUserItem where gameid = 'xxxx' and category in (1, 3, 4)

---------------------------------------------
--		������ �������� > ���� ������ �������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemDel', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemDel;
GO

create table dbo.tUserItemDel(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- ����Ʈ�ε���(�����κ��� ����)

	invenkind		int					default(1),
	itemcode		int,
	cnt				int					default(1),					--������

	randserial		varchar(20)			default(-1),				--����������(Ŭ���̾�Ʈ���� ������)
	writedate		datetime			default(getdate()),			--������/ȹ����
	gethow			int					default(0),					--ȹ����(0:����, 1:����, 2:����/�̱�, 3:�˻�)

	idx2			int,											-- ���� idx��ȣ�� ����(����������)
	writedate2		datetime			default(getdate()),			-- ������.
	state			int					default(0),					-- 0:��������, 1:�Ǹ�, 2:������

	-- Constraint
	CONSTRAINT	pk_tUserItemDel_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemDel_gameid_idx2')
    DROP INDEX tUserItemDel.idx_tUserItemDel_gameid_idx2
GO
CREATE INDEX idx_tUserItemDel_gameid_idx2 ON tUserItemDel (gameid, idx2)
GO

---------------------------------------------
--		�����ߴ� �α�(����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLog;
GO

create table dbo.tUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- ��ȣ

	gameid		varchar(20), 										-- ����id
	idx2		int,
	itemcode	int, 												-- �������ڵ�, �ߺ� ���ű���Ѵ�.
	buydate2	varchar(8),											-- ������20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- ���Ű���(�����Ҽ��־)
	buydate		datetime			default(getdate()), 			-- ������

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tUserItemBuyLog
--select top 20 * from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'Marbles' order by a.idx desc
--select top 20 * from dbo.tUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost) values('xxxx', 1, 5)
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost) values('xxxx', 1, 0)

--���� �˻��� �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_idx')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_idx ON tUserItemBuyLog (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_idx2')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_idx2 ON tUserItemBuyLog (gameid, idx2)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_buydate2_itemcode ON tUserItemBuyLog (gameid, buydate2, itemcode)
GO


---------------------------------------------
-- 	�����ߴ� �α�(���� Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogTotalMaster;
GO

create table dbo.tUserItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tUserItemBuyLogTotalMaster
-- select top 1   * from dbo.tUserItemBuyLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt) values('20120818', 100, 0, 1)
--update dbo.tUserItemBuyLogTotalMaster
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	�����ߴ� �α�(���� Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogTotalSub;
GO

create table dbo.tUserItemBuyLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 100 * from dbo.tUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
-- select         * from dbo.tUserItemBuyLogTotalSub where dateid8 = '20120818'
-- select top 1   * from dbo.tUserItemBuyLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tUserItemBuyLogTotalSub
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, cnt) values('20120818', 1, 100, 1)


---------------------------------------------
-- 	�����ߴ� �α�(���� ����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogMonth;
GO

create table dbo.tUserItemBuyLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tUserItemBuyLogMonth(dateid6, itemcode, gamecost, cnt) values('201309', 1, 100, 1)
--update dbo.tUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1

---------------------------------------------
--		���� ��ŷ
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBlockLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBlockLog;
GO

create table dbo.tUserBlockLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- ���̵�
	comment			varchar(512), 							-- �ý����ڸ�Ʈ
	writedate		datetime		default(getdate()), 	-- �����
	blockstate		int				default(1), 			-- ������ 	0 : �����¾ƴ�	1 : ������

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- �ڸ�Ʈ
	releasedate		datetime								-- ������

	-- Constraint
	CONSTRAINT pk_tUserBlockLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockLog_gameid_idx')
    DROP INDEX tUserBlockLog.idx_tUserBlockLog_gameid_idx
GO
CREATE INDEX idx_tUserBlockLog_gameid_idx ON tUserBlockLog(gameid, idx)
GO
-- �� ���ϴ� ������ �ߺ��� �߻��� �� �ִ�. �ѹ� �����ϰ� �� �����Ѵ�. �� �ߺ� ���� ���Ѵ�.
-- insert into dbo.tUserBlockLog(gameid, comment) values(@gameid_, '�����۸� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
-- update dbo.tUserMaster set blockstate = '0' where gameid = 'DD0'
-- update dbo.tUserBlockLog set blockstate = 0, adminid = 'Marbles', adminip = '172.0.0.1', comment2 = 'Ǯ���־���.', releasedate = getdate() where idx = 17
-- select * from dbo.tUserBlockLog order by idx desc
-- select idx, gameid, comment, writedate, blockstate, adminid, comment2, releasedate from dbo.tUserBlockLog order by idx desc
-- select top 20 * from dbo.tUserBlockLog where gameid = 'DD0' order by idx desc




---------------------------------------------
--		PC������...
---------------------------------------------
IF OBJECT_ID (N'dbo.tPCRoomIP', N'U') IS NOT NULL
	DROP TABLE dbo.tPCRoomIP;
GO

create table dbo.tPCRoomIP(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	pcip			varchar(20),

	writedate		datetime			default(getdate()),			-- �����..

	-- Constraint
	CONSTRAINT	pk_tPCRoomIP_gameid_pcip	PRIMARY KEY(gameid, pcip),
	CONSTRAINT	uk_tPCRoomIP_pcip			UNIQUE( pcip )
)

-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.1')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.2')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.3')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx2', '127.0.0.3')		--error �� �����̴�.
-- select top 1 * from dbo.tPCRoomIP where pcip = '127.0.0.1'
-- select * from dbo.tPCRoomIP where gameid = 'xxxx'
-- update dbo.tPCRoomIP set pcip = '127.0.0.1' where gameid = 'xxxx' and pcip = '127.0.0.1'



---------------------------------------------
--	����ũ ������Ȳ�ľ��ϱ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPhone;
GO

create table dbo.tUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
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
-- select top 1 * from dbo.tUserPhone


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
-- select top 100 * from dbo.tUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tUserBlockPhone where phone = '01022223333'

-- ����Ű �浹�˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockPhone_idx')
    DROP INDEX tUserBlockPhone.idx_tUserBlockPhone_idx
GO
CREATE INDEX idx_tUserBlockPhone_idx ON tUserBlockPhone (idx)
GO



/*

---------------------------------------------
--		������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSeed', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSeed;
GO

create table dbo.tUserSeed(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	seedidx			int					default(0),					-- 0 ~ 11�ʵ��ε���

	itemcode 		int					default(-2),				-- �۹��������ڵ�, (�̱���:-2, ���:-1, ����:0�̻�)
	seedstartdate	datetime			default(getdate()),			-- ������(������ �ڵ� ���̺� > ������ �ٰ��ΰ� ��ϵ�)
	seedenddate		datetime			default(getdate()),			-- ��Ȯ��.

	-- Constraint
	CONSTRAINT	pk_tUserSeed_gameid_listidx	PRIMARY KEY(gameid, seedidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSeed_idx')
    DROP INDEX tUserSeed.idx_tUserSeed_idx
GO
CREATE INDEX idx_tUserSeed_idx ON tUserSeed (idx)
GO

-- select * from dbo.tUserSeed where gameid = 'xxxx' order by seedidx asc
-- insert into dbo.tUserSeed(gameid, seedidx, itemcode) values('xxxx', 0, -2)
-- declare @loop int		set @loop = 1
-- while(@loop <= 11)
--	begin
--		insert into dbo.tUserSeed(gameid, seedidx, itemcode) values('xxxx', @loop, -2)
--		set @loop = @loop + 1
--	end
-- select getdate(), DATEADD(ss, 10, getdate()) -- ����ð� + 10��
-- ����, �����
--update dbo.tUserSeed set itemcode = -1 where gameid = 'xxxx' and seedidx = 8
-- �ɱ�
--update dbo.tUserSeed
--	set
--		itemcode = 607,
--		seedstartdate = getdate(),
--		seedenddate = DATEADD(ss, 20, getdate())
--where gameid = 'xxxx' and seedidx = 7
-- ����Ʈ ���
--select a.*, b.itemname, b.param1, b.param2, b.param5, b.param6
--	from dbo.tUserSeed a
--	LEFT JOIN
--	(select * from dbo.tItemInfo where subcategory = 7) b
--	ON a.itemcode = b.itemcode
--where gameid = 'xxxx' order by seedidx asc


---------------------------------------------
--		������ ���� (���շα�)
---------------------------------------------

---------------------------------------------
--		����ڷ� (���շα�)
---------------------------------------------


---------------------------------------------
--		�ŷ�����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSaleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSaleLog;
GO

create table dbo.tUserSaleLog(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	gameyear	int						default(-1),
	gamemonth	int						default(-1),

	feeduse		int						default(-1),
	playcoin	int						default(-1),
	playcoinmax	int						default(-1),
	fame		int						default(-1),
	famelv		int						default(-1),
	tradecnt	int						default(-1),
	prizecnt	int						default(-1),
	prizecoin	int						default(-1),

	saletrader		int					default(-1),
	saledanga		int					default(-1),
	saleplusdanga	int					default(-1),
	salebarrel		int					default(-1),
	salefresh		int					default(-1),
	salecoin		int					default(-1),
	saleitemcode	int					default(-1),
	plusheart		int					default(0),
	orderbarrel		int					default(0),
	orderfresh		int					default(0),
	milkproduct		int					default(0),

	userinfo		varchar(8000)		default(''),
	aniitem			varchar(8000)		default(''),
	cusitem			varchar(8000)		default(''),
	tradeinfo		varchar(8000)		default(''),

	cashcost	int						default(0),
	gamecost	int						default(0),
	feed		int						default(0),
	fpoint		int						default(0),
	heart		int						default(0),
	goldticket	int						default(0),
	goldticketused	int					default(-1),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserSaleLog_idx	PRIMARY KEY(idx)
)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSaleLog_gameid_gameyear_gamemonth')
    DROP INDEX tUserSaleLog.idx_tUserSaleLog_gameid_gameyear_gamemonth
GO
CREATE INDEX idx_tUserSaleLog_gameid_gameyear_gamemonth ON tUserSaleLog (gameid, gameyear, gamemonth)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSaleLog_gameid_idx2')
    DROP INDEX tUserSaleLog.idx_tUserSaleLog_gameid_idx2
GO
CREATE INDEX idx_tUserSaleLog_gameid_idx2 ON tUserSaleLog (gameid, idx2)
GO

--select top 1 * from dbo.tUserSaleLog where gameid = 'xxxx' and gameyear = '2013' and gamemonth = '4'
--insert into dbo.tUserSaleLog(gameid, 		gameyear,   	gamemonth,
--							feeduse, 		playcoin,		playcoinmax,		fame,    		famelv,   		tradecnt,  		prizecnt,
--							saletrader, 	saledanga,		saleplusdanga,		salebarrel,		salefresh,		salecost,	saleitemcode)
--values(						'xxxx', 		2013, 			4,
--							1, 				2,				40,					0, 				1, 				1, 				0,
--							1, 				2, 				3, 					4, 				5, 				6, 				7)



---------------------------------------------
--		��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSaveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSaveLog;
GO

create table dbo.tUserSaveLog(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	gameyear		int					default(-1),
	gamemonth		int					default(-1),
	frametime		int					default(-1),

	fevergauge		int					default(-1),
	bottlelittle	int					default(-1),
	bottlefresh		int					default(-1),
	tanklittle		int					default(-1),
	tankfresh		int					default(-1),
	feeduse			int					default(-1),
	boosteruse		int					default(-1),
	albause			int					default(-1),
	albausesecond	int					default(-1),
	albausethird	int					default(-1),
	wolfappear		int					default(-1),
	wolfkillcnt		int					default(-1),

	userinfo		varchar(8000)		default(''),
	aniitem			varchar(8000)		default(''),
	cusitem			varchar(8000)		default(''),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserSaveLog_idx	PRIMARY KEY(idx)
)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSaveLog_gameid_gameyear_gamemonth_frametime')
    DROP INDEX tUserSaveLog.idx_tUserSaveLog_gameid_gameyear_gamemonth_frametime
GO
CREATE INDEX idx_tUserSaveLog_gameid_gameyear_gamemonth_frametime ON tUserSaveLog (gameid, gameyear, gamemonth, frametime)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSaveLog_gameid_idx2')
    DROP INDEX tUserSaveLog.idx_tUserSaveLog_gameid_idx2
GO
CREATE INDEX idx_tUserSaveLog_gameid_idx2 ON tUserSaveLog (gameid, idx2)
GO

--select top 1 * from dbo.tUserSaveLog where gameid = 'xxxx2' and gameyear = 2013 and gamemonth = 4 and frametime = 12
--select top 1 idx2 from dbo.tUserSaveLog where gameid = 'xxxx2' order by idx desc
--insert into dbo.tUserSaveLog(
--	idx2,
--	gameid, 		gameyear, 			gamemonth, 			frametime,
--	fevergauge, 	bottlelittle, 		bottlefresh, 		tanklittle,		tankfresh,
--	feeduse,		boosteruse,			albause,			wolfappear,		wolfkillcnt,
--	userinfo,		aniitem,			cusitem
--)
--values(
--	1,
--	'xxxx3', 		2013,				3,      			12,
--	4,       		11,       			101,     			21,     		201,
--	16,  			-1,    			 	-1,  				-1,     		1,
--	'0:2013;1:3;2:13;4:4;10:11;11:101;12:21;13:201;30:16;40:-1;41:-1;42:-1;43:1;',
--	'1:5,1,1;3:5,23,0;4:5,25,-1;',
--	'14:1;15:1;16:1;'
--)


---------------------------------------------
--	���������� �ൿ�� �ҷ��� �ϴ� ����üŷ > ��ó��
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog;
GO

create table dbo.tUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- �ൿ��
	comment			varchar(512), 							-- �����󳻿�
	writedate		datetime		default(getdate()), 	-- �������ۼ���

	chkstate		int				default(0),				-- Ȯ�λ���(0:üŷ����, 1:üŷ��)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- Ȯ�γ���

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog_gameid_idx')
    DROP INDEX tUserUnusualLog.idx_tUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog_gameid_idx ON tUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x1', 'ĳ��ī�ǽõ�')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x1', 'ȯ��ī�ǽõ�')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x2', '�������')
-- select top 20 * from dbo.tUserUnusualLog order by idx desc
-- select top 20 * from dbo.tUserUnusualLog where gameid = 'sususu' order by idx desc


---------------------------------------------
--	����������2 �ൿ�� �ҷ��� �ϴ� ����üŷ > ��ó��
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog2;
GO

create table dbo.tUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- �ൿ��
	comment			varchar(512), 							-- �����󳻿�
	writedate		datetime		default(getdate()), 	-- �������ۼ���

	chkstate		int				default(0),				-- Ȯ�λ���(0:üŷ����, 1:üŷ��)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- Ȯ�γ���

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog2_gameid_idx')
    DROP INDEX tUserUnusualLog2.idx_tUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog2_gameid_idx ON tUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', 'ĳ��ī�ǽõ�')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', 'ȯ��ī�ǽõ�')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x2', '�������')
-- select top 20 * from dbo.tUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tUserUnusualLog2 where gameid = 'sususu' order by idx desc


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



---------------------------------------------
--		������ ���� ��û�� ���� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserDeleteLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserDeleteLog;
GO

create table dbo.tUserDeleteLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- ���̵�
	comment			varchar(512), 							-- �ڸ�Ʈ
	writedate		datetime		default(getdate()), 	-- ������û
	deletestate		int				default(1), 			-- �������� 0 : �������¾ƴ� 1 : ��������

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- �ڸ�Ʈ
	releasedate		datetime								-- ������

	-- Constraint
	CONSTRAINT pk_tUserDeleteLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserDeleteLog_gameid_idx')
    DROP INDEX tUserDeleteLog.idx_tUserDeleteLog_gameid_idx
GO
CREATE INDEX idx_tUserDeleteLog_gameid_idx ON tUserDeleteLog(gameid, idx)
GO
-- select * from dbo.tUserDeleteLog order by idx desc
-- select * from dbo.tUserDeleteLog order by idx desc
-- select top 20 * from dbo.tUserDeleteLog where gameid = 'DD0' order by idx desc


---------------------------------------------------
--	(ȸ�����)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tNotice;
GO

create table dbo.tNotice(
	idx				int				IDENTITY(1,1), 			-- ��ȣ
	market			int				default(1),
	buytype			int				default(0),				-- ����(0), ����(1)

	comfile			varchar(512)	default(''),			-- �����̹���
	comurl			varchar(512)	default(''),			-- ����URL
	comfile2		varchar(512)	default(''),
	comurl2			varchar(512)	default(''),
	comfile3		varchar(512)	default(''),
	comurl3			varchar(512)	default(''),
	comfile4		varchar(512)	default(''),
	comurl4			varchar(512)	default(''),
	comfile5		varchar(512)	default(''),
	comurl5			varchar(512)	default(''),
	comment			varchar(8000)	default(''),

	version			int				default(101),			--Ŭ���̾�Ʈ����
	patchurl		varchar(512)	default(''),			--��ġURL
	recurl			varchar(512)	default(''),			--�Խ���URL
	smsurl			varchar(512)	default(''),			--SMSURL (������)
	smscom			varchar(512)	default(''),			--(������)

	iteminfover		int				default(100),			-- ������
	iteminfourl		varchar(512)	default(''),			-- ��URL
	serviceurl		varchar(512)	default(''),			--
	communityurl	varchar(512)	default(''),			--

	writedate		datetime		default(getdate()), 	-- �ۼ���
	syscheck		int				default(0),				-- 0:������ 	1:������

	-- Constraint
	CONSTRAINT	pk_tNotice_idx	PRIMARY KEY(idx)
)
--alter table dbo.tNotice add smsurl			varchar(512)
--alter table dbo.tNotice add smscom			varchar(512)
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tNotice_writedate')
--    DROP INDEX tNotice.idx_tNotice_writedate
--GO
--CREATE INDEX idx_tNotice_writedate ON tNotice (writedate)
--GO
--select top 1 * from dbo.tNotice where market = 1 order by writedate desc
--select * from dbo.tNotice where market = 1 order by writedate desc
--delete from dbo.tNotice where idx = 7
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(1, 0, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(1, 1, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(2, 0, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(3, 0, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(5, 0, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(7, 0, 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4GameMTBaseball/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)

---------------------------------------------
-- 	������ ����(�ൿ����)
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

-- insert into dbo.tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '�������')
-- select top 100 * from dbo.tMessageAdmin order by idx desc




---------------------------------------------
-- 	����������
---------------------------------------------
IF OBJECT_ID (N'dbo.tDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tDayLogInfoStatic;
GO

create table dbo.tDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),
	market			int				default(1),

	smssendcnt		int				default(0),					-- �� SMS ����
	smsjoincnt		int				default(0),					-- �� SMS ����

	joinplayercnt	int				default(0),					-- �� �Ϲݰ���
	joinguestcnt	int				default(0),					-- �� �Ϲݰ���
	joinukcnt		int				default(0),					-- �� ����ũ ����
	logincnt		int				default(0),					-- �� �α���
	logincnt2		int				default(0),					-- (������)
	invitekakao		int				default(0),					-- �� īī�� �ʴ�.
	kakaoheartcnt	int				default(0),					-- �� īī�� ��Ʈ.
	kakaohelpcnt	int				default(0),					-- �� īī�� ������ģ����.

	heartusecnt		int				default(0),					-- �� ��Ʈ����
	revivalcnt		int				default(0),					-- �� ��Ȱ��(��)
	revivalcntcash	int				default(0),					-- �� ��Ȱ��(ĳ��)
	revivalcntfree	int				default(0),					-- �� ��Ȱ��(����)
	fpointcnt		int				default(0),					-- �� fpoint(����)
	rtnrequest		int				default(0),					-- �� ���Ϳ�û��
	rtnrejoin		int				default(0),					-- �� ���ͼ�

	freeroulettcnt	int				default(0),					-- �� �����̱�
	payroulettcnt	int				default(0),					-- �� ����̱�
	payroulettcnt2	int				default(0),					--
	aniupgradecnt	int				default(0),					-- �� ������ȭ.
	freeanicomposecnt	int			default(0),					-- �� �����ռ�
	payanicomposecnt	int			default(0),					--
	anipromotecnt	int				default(0),					-- �� �����±�.
	freetreasurecnt	int				default(0),					-- �� �����̱�
	paytreasurecnt	int				default(0),					-- �� ����̱�
	paytreasurecnt2	int				default(0),					--    �����̾�2
	tsupgradenor	int				default(0),					--    ����(Normal)
	tsupgradepre	int				default(0),					--    ����(Pre)

	cashcnt			int				default(0),					-- �� ĳ������(�Ϲ�)
	cashcnt2		int				default(0),					-- �� ĳ������(����)

	boxopenopen		int				default(0),					-- �� �ڽ����½ð��Ǿ.
	boxopencash		int				default(0),					-- �� �ڽ����½ð�����
	boxopentriple	int				default(0),					-- �� �ڽ���ÿ���

	tradecnt		int				default(0),					-- �� �ŷ���
	prizecnt		int				default(0),					-- �� �����޼�
	battlecnt		int				default(0),					-- �� ��Ʋ��.
	userbattlecnt	int				default(0),					-- �� ������Ʋ��.
	playcntbuy		int				default(0),					-- �� ��ƲȽ������.

	pushandroidcnt	int				default(0),					-- �ȵ���̵����.
	pushiphonecnt	int				default(0),					-- ���������.

	contestcnt		int				default(0),					-- �� ��ȸ������
	certnocnt		int				default(0),					-- �� ������ϼ�.

	zcpcntfree		int				default(0), 				-- �� ����귿.
	zcpcntcash		int				default(0), 				-- �� Ȳ�ݷ귿.

	zcpappeartradecnt	int			default(0), 				-- �� �ŷ�   ¥���������� �귿����.
	zcpappearboxcnt		int			default(0), 				-- �� �ڽ�   ¥���������� �귿����.
	zcpappearfeedcnt	int			default(0), 				-- �� ���������� ¥���������� �귿����.
	zcpappearheartcnt	int			default(0), 				-- �� ��������Ʈ ¥���������� �귿����.

	wheelnor		int				default(0), 				-- �� ����귿.
	wheelpre		int				default(0), 				-- �� Ȳ�ݷ귿.
	wheelprefree	int				default(0), 				-- �� Ȳ�ݹ���.

	-- Constraint
	CONSTRAINT	pk_tDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tDayLogInfoStatic add certnocnt		int				default(0)
-- alter table dbo.tDayLogInfoStatic add revivalcnt		int				default(0)
-- alter table dbo.tDayLogInfoStatic add revivalcntcash	int				default(0)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDayLogInfoStatic_dateid8_market')
    DROP INDEX tDayLogInfoStatic.idx_tDayLogInfoStatic_dateid8_market
GO
CREATE INDEX idx_tDayLogInfoStatic_dateid8_market ON tDayLogInfoStatic(dateid8, market)
GO

-- insert into dbo.tDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tDayLogInfoStatic order by idx desc


---------------------------------------------
--		������ ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tGiftList;
GO

create table dbo.tGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(20),									-- gameid�� itemcode�� �ߺ��� �߻��Ѵ�.
	giftkind	int					default(0),					-- 1:�޽���, 2:����, -1:�޽�������, -2:�����޾ư�

	message		varchar(256)		default(''), 				-- �޼���(1)

	itemcode	int					default(-1),				-- ����(2)
	cnt			bigint 				default(0),					-- == 0 �̸� �������� ����
																-- >= 1 �̸� �̰��� ���������Ѵ�.
	gainstate	int					default(0),					-- ����������	0:�Ȱ�����, 1:������
	gaindate	datetime, 										-- ��������
	giftid		varchar(20)			default('Marbles'),			-- ������ ����
	giftdate	datetime			default(getdate()), 		-- ������

	-- Constraint
	CONSTRAINT	pk_tGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx
GO
CREATE INDEX idx_tGiftList_gameid_idx ON tGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx2')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx2
GO
CREATE INDEX idx_tGiftList_gameid_idx2 ON tGiftList (gameid, idx2)
GO



-- select * from dbo.tGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'Marbles');

---------------------------------------------
-- 	�����ߴ� �α�(���� Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalMaster;
GO

create table dbo.tUserItemUpgradeLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)

---------------------------------------------
-- 	�����ߴ� �α�(���� Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalSub;
GO

create table dbo.tUserItemUpgradeLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)

---------------------------------------------
-- 	�����ߴ� �α�(���� ����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogMonth;
GO

create table dbo.tUserItemUpgradeLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)



---------------------------------------------
-- 	ĳ������(���ηα�)
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashLog;
GO

create table dbo.tCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- ������
	gameyear		int				default(2013),			-- ���ӽ��� 2013�� 3������ ����(��)
	gamemonth		int				default(3),				--
	famelv			int				default(1),

	giftid			varchar(20), 							-- �����������
	acode			varchar(256), 							-- �����ڵ�() ������.�Ф�
	ucode			varchar(256), 							-- �����ڵ�

	ikind			varchar(256),							-- ������, Google ����(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(����)
	idata2			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(�ؼ���)

	cashcost		int				default(0), 			-- ������纼
	cash			int				default(0),				-- ��������
	writedate		datetime		default(getdate()), 	-- ������
	market			int				default(1),				-- (����ó�ڵ�) MARKET_SKT

	kakaogameid		varchar(60)		default(''),			-- 129xxxxx
	kakaouk			varchar(19)		default(''),			--          ����id

	kakaosend		int				default(-1),			-- ������(-1) -> ����(1)
	productid		varchar(40)		default(''),

	-- Constraint
	CONSTRAINT	pk_tCashLog_idx	PRIMARY KEY(idx)
)
--���� clustered�� ���� ������ ����� idx�� �ϰ� �˻��� ucode > idx�� ���ؼ� �ϵ��� ����
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_ucode')
    DROP INDEX tCashLog.idx_tCashLog_ucode
GO
CREATE INDEX idx_tCashLog_ucode ON tCashLog (ucode)
GO
--�����αװ˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_gameid')
    DROP INDEX tCashLog.idx_tCashLog_gameid
GO
CREATE INDEX idx_tCashLog_gameid ON tCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_acode')
    DROP INDEX tCashLog.idx_tCashLog_acode
GO
CREATE INDEX idx_tCashLog_acode ON tCashLog (acode)
GO
--insert into dbo.tCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	ĳ������Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tCashTotal;
GO

create table dbo.tCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,
	market			int				default(1),				-- (����ó�ڵ�) MARKET_SKT

	cashcost		int				default(0), 			-- ���Ǹŷ�
	cash			int				default(0), 			-- ���Ǹŷ�
	cnt				int				default(1),				--����ȸ��
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 2000, 1, 21, 2000)
-- insert into dbo.tCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1


---------------------------------------------
-- 	ĳ��ȯ���α�
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashChangeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashChangeLog;
GO

create table dbo.tCashChangeLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- ������
	cashcost		int, 									-- ȯ�����
	gamecost		int, 									-- ȯ���ǹ�
	writedate		datetime		default(getdate()),		-- ȯ����

	-- Constraint
	CONSTRAINT	pk_tCashChangeLog_idx	PRIMARY KEY(idx)
)
--ĳ��ȯ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashChangeLog_gameid_idx')
    DROP INDEX tCashChangeLog.idx_tCashChangeLog_gameid_idx
GO
CREATE INDEX idx_tCashChangeLog_gameid_idx ON tCashChangeLog (gameid, idx desc)
GO

-- insert into dbo.tCashChangeLog(gameid, cashcost, gamecost) values('Marbles', 10, 1000)
-- insert into dbo.tCashChangeLog(gameid, cashcost, gamecost) values('Marbles', 20, 2000)
-- insert into dbo.tCashChangeLog(gameid, cashcost, gamecost) values('Marbles', 30, 3000)
-- insert into dbo.tCashChangeLog(gameid, cashcost, gamecost) values('Marbles', 40, 4000)
-- insert into dbo.tCashChangeLog(gameid, cashcost, gamecost) values('DD0', 10, 1000)
-- select * from dbo.tCashChangeLog where gameid = 'Marbles' order by idx desc



---------------------------------------------
-- 	ĳ��ȯ����Ż
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashChangeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tCashChangeLogTotal;
GO

create table dbo.tCashChangeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	cashcost		int				default(0),
	gamecost		int				default(0),

	changecnt		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tCashChangeLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tCashChangeLogTotal order by dateid desc
-- select top 1 * from dbo.tCashChangeLogTotal where dateid = '20120818'
-- insert into dbo.tCashChangeLogTotal(dateid, cashcost, gamecost, changecnt) values('20120818', 10, 1000, 1)
--update dbo.tCashChangeLogTotal
--	set
--		cashcost = cashcost + 10,
--		gamecost = gamecost + 10000,
--		changecnt = changecnt + 1
--where dateid = '20120818'

-- 192.168.0.11 / game4farm / a1s2d3f4

---------------------------------------------
-- ���ְ����ΰ�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashFirstTimeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashFirstTimeLog;
GO

create table dbo.tCashFirstTimeLog(
	idx			int				identity(1, 1),

	gameid		varchar(20),
	itemcode	int,
	writedate	datetime		default(getdate()),

	CONSTRAINT	pk_tCashFirstTimeLog_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashFirstTimeLog_gameid_itemcode')
    DROP INDEX tCashFirstTimeLog.idx_tCashFirstTimeLog_gameid_itemcode
GO
CREATE INDEX idx_tCashFirstTimeLog_gameid_itemcode ON tCashFirstTimeLog (gameid, itemcode)
GO


---------------------------------------------
--		ģ��
-- 	������ ��¥ ����
--	ģ���� 100�������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tUserFriend;
GO

create table dbo.tUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20)		NOT NULL,

	friendid		varchar(20)		NOT NULL, 				-- ģ�����̵�
	familiar		int				default(1), 			-- ģ�е�(����+1)
	state			int				default(0),				-- ģ����û(0), ģ�����(1), ģ������(2)
	senddate		datetime		default(getdate()),		-- ��Ʈ������ 1���Ŀ� �ٽ� ������ ����.
	kakaofriendkind	int				default(1),				-- ����ģ��(1), īī��ģ��(2)
	helpdate		datetime		default(getdate() - 1),	-- ģ���� ������ ��û�� �� ���(����).
	rentdate		datetime		default(getdate() - 1),	-- ģ�������� ������ ����ϱ�.

	writedate		datetime		default(getdate()), 	-- �����
	-- Constraint
	CONSTRAINT pk_tUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--�ϱ� > ����Ʈ
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserFriend_gameid_familiar')
    DROP INDEX tUserFriend.idx_tUserFriend_gameid_familiar
GO
CREATE INDEX idx_tUserFriend_gameid_familiar ON tUserFriend(gameid, familiar desc)
GO

-- xxxx > ģ����
--insert into dbo.tUserFriend(gameid, friendid) values('xxxx', 'xxxx2')
--insert into dbo.tUserFriend(gameid, friendid) values('xxxx', 'xxxx3')
--insert into dbo.tUserFriend(gameid, friendid) values('xxxx', 'xxxx4')
--insert into dbo.tUserFriend(gameid, friendid) values('xxxx', 'xxxx5')

--select * from dbo.tUserFriend where gameid = 'xxxx'
--select * from dbo.tUserFriend where gameid = 'xxxx' order by familiar desc
--update dbo.tUserFriend set familiar = familiar + 1 where gameid = @gameid_ and friendid = @friendid_


---------------------------------------------
--		�Խ��� ����(�۾��⿡ �켱������ �ø�).
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBoard', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBoard;
GO

create table dbo.tUserBoard(
	idx			int					IDENTITY(1,1),

	idx2		int,
	kind		int					default(1),					-- 1:�ϹݰԽ��Ǳ���, 2:ģ�߰Խ��Ǳ���, 3:���װԽ��Ǳ���

	gameid		varchar(20),
	message		varchar(256)		default(''),
	writedate	datetime			default(getdate()), 		-- ������

	schoolidx	int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tUserBoard_idx2_kind	PRIMARY KEY(idx)
)
-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBoard_idx2_kind')
    DROP INDEX tUserBoard.idx_tUserBoard_idx2
GO
CREATE INDEX idx_tUserBoard_idx2_kind ON tUserBoard (idx2, kind)
GO

-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(1, 1, 'xxxx2', '�ϹݰԽ��Ǳ���')
-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(2, 1, 'xxxx2', 'ģ�߰Խ��Ǳ���')
-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(3, 1, 'xxxx2', '���װԽ��Ǳ���')
-- select top 5 * from dbo.tUserBoard where kind = 1 order by idx2 desc
-- select top 5 * from dbo.tUserBoard where kind = 2 order by idx2 desc
-- select top 5 * from dbo.tUserBoard where kind = 3 order by idx2 desc

---------------------------------------------
--		�굵�� : ���ε���
---------------------------------------------
IF OBJECT_ID (N'dbo.tDogamListPet', N'U') IS NOT NULL
	DROP TABLE dbo.tDogamListPet;
GO

create table dbo.tDogamListPet(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tDogamListPet_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDogamListPet_gameid_itemcode')
	DROP INDEX tDogamListPet.idx_tDogamListPet_gameid_itemcode
GO
CREATE INDEX idx_tDogamListPet_gameid_itemcode ON tDogamListPet (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tDogamListPet where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tDogamListPet(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tDogamListPet where gameid = 'xxxx' order by itemcode asc


---------------------------------------------
--		�������� : ���ε���
---------------------------------------------
IF OBJECT_ID (N'dbo.tDogamList', N'U') IS NOT NULL
	DROP TABLE dbo.tDogamList;
GO

create table dbo.tDogamList(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),
	--cnt			int				default(0),

	-- Constraint
	CONSTRAINT pk_tDogamList_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDogamList_gameid_itemcode')
	DROP INDEX tDogamList.idx_tDogamList_gameid_itemcode
GO
CREATE INDEX idx_tDogamList_gameid_itemcode ON tDogamList (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tDogamList where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tDogamList(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tDogamList where gameid = 'xxxx' order by itemcode asc

---------------------------------------------
--		���� : ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tDogamReward', N'U') IS NOT NULL
	DROP TABLE dbo.tDogamReward;
GO

create table dbo.tDogamReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	dogamidx		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tDogamReward_idx	PRIMARY KEY(idx)
)

-- gameid, dogamidx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDogamReward_gameid_dogamidx')
	DROP INDEX tDogamReward.idx_tDogamReward_gameid_dogamidx
GO
CREATE INDEX idx_tDogamReward_gameid_dogamidx ON tDogamReward (gameid, dogamidx)
GO

--if(not exists(select top 1 * from dbo.tDogamReward where gameid = 'xxxx' and dogamidx = 1))
--	begin
--		insert into dbo.tDogamReward(gameid, dogamidx) values('xxxx', 1)
--	end
--select * from dbo.tDogamReward where gameid = 'xxxx' order by dogamidx asc

---------------------------------------------
--		���� : ���� ���̺� ���� > [gameinfo���̺� ����]
---------------------------------------------
-- declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)
--
-- select *  from dbo.tItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM
-- select param1 dogamidx, itemname dogamname, param2 dogam01, param3 dogam02, param4 dogam03, param5 dogam04, param6 dogam05, param7 dogam06, param8 rewarditemcode, param9 cnt  from dbo.tItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM


---------------------------------------------
--		������ ����(��ϵȰ��� ���� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tComReward', N'U') IS NOT NULL
	DROP TABLE dbo.tComReward;
GO

create table dbo.tComReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	idx2			int,
	itemcode		int,
	getdate			datetime		default(getdate()),
	ispass			int				default(-1),

	gameyear		int,
	gamemonth		int,
	famelv			int,

	-- Constraint
	CONSTRAINT pk_tComReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComReward_gameid_itemcode')
	DROP INDEX tComReward.idx_tComReward_gameid_itemcode
GO
CREATE INDEX idx_tComReward_gameid_itemcode ON tComReward (gameid, itemcode)
GO

-- gameid, idx2
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComReward_gameid_idx2')
	DROP INDEX tComReward.idx_tComReward_gameid_idx2
GO
CREATE INDEX idx_tComReward_gameid_idx2 ON tComReward (gameid, idx2)
GO

--if(not exists(select top 1 * from dbo.tComReward where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tComReward(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tComReward where gameid = 'xxxx' order by itemcode asc


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
-- select top 1 * from dbo.tStaticTime

---------------------------------------------
-- �ý��� ���׷��̵� ����
-- �ü� ���׷��̵� �ƽ� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tSystemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemInfo;
GO

create table dbo.tSystemInfo(
	idx					int 				IDENTITY(1, 1),

	-- ��������
	housestepmax		int					default(0),
	tankstepmax			int					default(0),
	bottlestepmax		int					default(0),
	pumpstepmax			int					default(0),
	transferstepmax		int					default(0),
	purestepmax			int					default(0),
	freshcoolstepmax	int					default(0),

	-- �κ�����
	invenstepmax		int					default(0),
	invencountmax		int					default(0),
	seedfieldmax		int					default(0),

	-- �ʵ��������.
	field5lv			int					default(3),
	field6lv			int					default(6),
	field7lv			int					default(9),
	field8lv			int					default(12),

	-- ������ ������. �׳� �־��.
	attend1				int					default(900),
	attend2				int					default(5111),
	attend3				int					default(5112),
	attend4				int					default(5113),
	attend5				int					default(5007),

	-- ĳ������, ȯ��.
	pluscashcost		int					default(0),	-- ���� ĳ������.
	plusgamecost		int					default(0),	-- ������ ����.
	plusheart			int					default(0),	-- ������ ����.
	plusfeed			int					default(0), -- ������.
	plusgoldticket		int					default(0),
	plusbattleticket	int					default(0),

	-- �׼��縮 ����.
	roulaccprice		int					default(10),	-- �׼��縮 ��� ����
	roulaccsale			int					default(10),	-- �׼��縮 ���η�

	-- �����ռ� ���ΰ���.
	composesale			int					default(0),

	-- iPhone���� �Է��� ���̱� �Ⱥ��̱�.
	iphonecoupon		int					default(0),		-- 0:�Ⱥ���, 1:����

	-- ģ���ʴ� ������.
	kakaoinvite01		int					default(2000),
	kakaoinvite02		int					default(1005),
	kakaoinvite03		int					default(6),
	kakaoinvite04		int					default(100003),

	-- 5.ȸ���� ����̱�.
	wheelgauageflag		int					default(0),
	wheelgauagepoint	int					default(10),
	wheelgauagemax		int					default(100),

	-- ���������� ó������.
	rtnflag				int					default(0),		-- 0:OFF, 1:ON

	--�ڸ�Ʈ.
	comment				varchar(256)		default(''),

	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemInfo_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tSystemInfo

--alter table dbo.tSystemInfo add urgency			int					default(3)
--alter table dbo.tSystemInfo add plusheart			int					default(0)
--alter table dbo.tSystemInfo add plusfeed			int					default(0)
--alter table dbo.tSystemInfo add pluscashcost		int					default(0)
--alter table dbo.tSystemInfo add plusgamecost		int					default(0)
--alter table dbo.tSystemInfo add comment			varchar(256)		default('')


---------------------------------------------
-- �����̱��̺�Ʈ ���� ����.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemRouletteMan;
GO

create table dbo.tSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 0.����.
	roulsaleflag		int					default(-1),
	roulsalevalue		int					default(0),

	-- 1. Ư������ ����ޱ�.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulrewardcnt1		int					default(0),
	roulrewardcnt2		int					default(0),
	roulrewardcnt3		int					default(0),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 2. Ư���ð��� Ȯ�����.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),
	roultimetime4		int					default(-1),

	-- 3. �����̾� ����̱�.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(100),
	pmgauagemax			int					default(10),

	--�ڸ�Ʈ.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tSystemRouletteMan(roulmarket, roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,     roulname2,       roulname3, roultimeflag, roultimestart,  roultimeend, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                            ('1,2,3,4,5,6,7',   1, '2013-09-01', '2023-09-01',      213,      112,       14,        5017,        5010,        5009, '��¯ ��纸��', '��¯ �纸��', '��¯ ���Һ���',            1,  '2013-09-01', '2023-09-01',            12,            18,            23, '���ʳ���')
-- update dbo.tSystemRouletteMan set roulflag = -1 where idx = 3

---------------------------------------------
-- �����̱��̺�Ʈ ���� ����.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSystemTreasureMan', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemTreasureMan;
GO

create table dbo.tSystemTreasureMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 1.����.
	roulsaleflag		int					default(-1),
	roulsalevalue		int					default(0),

	-- 2.Ư������ ����ޱ�.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulrewardcnt1		int					default(0),
	roulrewardcnt2		int					default(0),
	roulrewardcnt3		int					default(0),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 3.Ư���ð��� Ȯ�����.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),
	roultimetime4		int					default(-1),

	-- 4.�����̾� ����̱�.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(10),
	pmgauagemax			int					default(100),

	-- 5.��ȭ��� ����.
	tsupgradesaleflag	int					default(-1),
	tsupgradesalevalue	int					default(0),

	--�ڸ�Ʈ.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemTreasureMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tSystemTreasureMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tSystemTreasureMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                              (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
-- update dbo.tSystemTreasureMan set roulflag = -1 where idx = 3

---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushAndroid;
GO

create table dbo.tUserPushAndroid(
	idx				int				identity(1, 1),

	sendid			varchar(60),
	receid			varchar(60),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroid_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tUserPushAndroid

-- ����
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
-- ������
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
--
----------------------------------------------------
---- Ǫ�� �о����(����ó���κ�)
----------------------------------------------------
---- select top 100 * from dbo.tUserPushAndroid
---- ����ϱ�
--DECLARE @tTemp TABLE(
--				sendid			varchar(60),
--				receid			varchar(60),
--				recepushid		varchar(256),
--				sendkind		int,
--
--				msgpush_id		int,
--				msgtitle		varchar(512),
--				msgmsg			varchar(512),
--				msgaction		varchar(512)
--			);
----select * from dbo.tUserPushAndroid
--delete from dbo.tUserPushAndroid
--	OUTPUT DELETED.sendid, DELETED.receid, DELETED.recepushid, DELETED.sendkind, DELETED.sendkind, DELETED.msgpush_id, DELETED.msgtitle, DELETED.msgmsg, DELETED.msgaction into @tTemp
--	where idx in (1)
------select * from @tTemp
----
--insert into dbo.tUserPushAndroidLog(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
--	(select sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction from @tTemp)
--
----select * from dbo.tUserPushAndroidLog

---------------------------------------------
-- 	�귿 �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogPerson;
GO

create table dbo.tRouletteLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	gameid			varchar(20),
	kind			int,
	framelv			int,
	itemcode		int,
	itemcodename	varchar(40),

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	gameyear		int,
	gamemonth		int,
	friendid		varchar(20),
	frienditemcode	int				default(-1),
	frienditemname	varchar(40),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode5		int				default(-1),
	itemcode6		int				default(-1),
	itemcode7		int				default(-1),
	itemcode8		int				default(-1),
	itemcode9		int				default(-1),
	itemcode10		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),
	itemcode5name	varchar(40)		default(''),
	itemcode6name	varchar(40)		default(''),
	itemcode7name	varchar(40)		default(''),
	itemcode8name	varchar(40)		default(''),
	itemcode9name	varchar(40)		default(''),
	itemcode10name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tRouletteLogPerson_gameid_idx')
	DROP INDEX tRouletteLogPerson.idx_tRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tRouletteLogPerson_gameid_idx ON tRouletteLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tRouletteLogPerson where gameid = 'xxxx2' order by idx desc


---------------------------------------------
-- 	����̱��ߴ� �α�(���� Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalMaster;
GO

create table dbo.tRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),
	acccnt			int				default(0),			-- �Ǽ��縮�α�.

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select top 1   * from dbo.tRouletteLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tRouletteLogTotalMaster(dateid8) values('20120818')
--update dbo.tRouletteLogTotalMaster
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt 	= normalcnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	����̱��ߴ� �α�(���� Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalSub;
GO

create table dbo.tRouletteLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 1   * from dbo.tRouletteLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tRouletteLogTotalSub
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt	= normalcnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tRouletteLogTotalSub(dateid8, itemcode) values('20120818', 1)



---------------------------------------------
-- 	�Ǽ��귿 �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tAccRoulLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tAccRoulLogPerson;
GO

create table dbo.tAccRoulLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	kind			int,
	framelv			int,
	cashcost		int				default(0),
	gamecost		int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tAccRoulLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tAccRoulLogPerson_gameid_idx')
	DROP INDEX tAccRoulLogPerson.idx_tAccRoulLogPerson_gameid_idx
GO
CREATE INDEX idx_tAccRoulLogPerson_gameid_idx ON tAccRoulLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tAccRoulLogPerson where gameid = 'xxxx2' order by idx desc



---------------------------------------------
-- 	�ռ� �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tComposeLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tComposeLogPerson;
GO

create table dbo.tComposeLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	kind 			int,
	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	famelv			int,
	heart			int				default(0),
	cashcost		int				default(0),
	gamecost		int				default(0),
	ticket			int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),

	bgcomposeic		int				default(1),
	bgcomposert		int				default(0),
	bgcomposename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tComposeLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComposeLogPerson_gameid_idx2')
	DROP INDEX tComposeLogPerson.idx_tComposeLogPerson_gameid_idx2
GO
CREATE INDEX idx_tComposeLogPerson_gameid_idx2 ON tComposeLogPerson (gameid, idx2)
GO
-- select top 100 * from dbo.tComposeLogPerson where gameid = 'xxxx2' order by idx desc


---------------------------------------------
-- 	�±� �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tPromoteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tPromoteLogPerson;
GO

create table dbo.tPromoteLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	kind 			int,
	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	famelv			int,
	heart			int				default(0),
	cashcost		int				default(0),
	gamecost		int				default(0),
	ticket			int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),

	resultlist		varchar(40)		default(''),

	bgpromoteic		int				default(1),
	bgpromotename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tPromoteLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tPromoteLogPerson_gameid_idx2')
	DROP INDEX tPromoteLogPerson.idx_tPromoteLogPerson_gameid_idx2
GO
CREATE INDEX idx_tPromoteLogPerson_gameid_idx2 ON tPromoteLogPerson (gameid, idx2)
GO
-- select top 100 * from dbo.tPromoteLogPerson where gameid = 'xxxx2' order by idx desc






---------------------------------------------
-- �̺�Ʈ ����Ű��
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO

create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mode		int				default(1),		-- 1: 1��1����, 2:������
	kind		int				default(0),		-- ���ۿ�û�� ȸ���ȣ.

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO

---------------------------------------------
-- �̺�Ʈ ����Ű��(���)
-- �������� ������������ �����ߴ�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoBack;
GO

create table dbo.tEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
GO
--CREATE INDEX idx_tEventCertNoBack_certno ON tEventCertNoBack (certno)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_gameid_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_gameid_certno
GO
CREATE INDEX idx_tEventCertNoBack_gameid_certno ON tEventCertNoBack (gameid, certno)
GO


---------------------------------------------
-- ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tSysInquire;
GO

create table dbo.tSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- ��û���[0], üŷ��[1], �Ϸ�[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tSysInquire order by idx desc
-- insert into dbo.tSysInquire(gameid, comment) values(1, '�߾ȵ˴ϴ�.')
-- update dbo.tSysInquire set state = 1, dealdate = getdate(), comment2 = '�������Դϴ�.' where idx = 1
-- update dbo.tSysInquire set state = 2, dealdate = getdate(), comment2 = 'ó���߽��ϴ�.' where idx = 1
-- if(2)������ �߼۵ȴ�.


---------------------------------------------
-- �̺�Ʈ ���� ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tSysEventInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSysEventInfo;
GO

create table dbo.tSysEventInfo(
	idx					int 				IDENTITY(1, 1),

	adminid				varchar(20),
	state				int					default(0),				-- �����[0], ������[1], �Ϸ�[2]
	startdate			varchar(16),								-- 2014-05-05 10:00
	enddate				varchar(16),
	company				int					default(0),				-- ������Ż(0), �������Ʈ(1)
	title				varchar(256)		default(''),
	comment				varchar(4096)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysEventInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tSysEventInfo(adminid, state, startdate, enddate, company, title, comment) values('blackm', 0, '2014-05-12 00:00', '2014-05-12 23:59', 0, '�̺�Ʈ����', '�̺�Ʈ����')
-- update dbo.tSysEventInfo set state = 1, startdate = '2014-05-12 00:00', enddate = '2014-05-12 23:59', company = 0, title = '�̺�Ʈ����', comment = '�̺�Ʈ����' where idx = 1
-- select top 10 * from dbo.tSysEventInfo order by idx desc

---------------------------------------------
-- 	ĳ������
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tCashLogKakaoSend;
GO

create table dbo.tCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)



---------------------------------------------
--	��踶����[FameLV, Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticMaster;
GO

create table dbo.tStaticMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tStaticMaster_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tStaticMaster
-- if(not exist(select dateid from dbo.tStaticMaster where dateid = '20140404'))
-- 		insert into dbo.tStaticMaster(dateid, step) values('20140404', 1)
-- update dbo.tStaticMaster set step = 2 where dateid = '20140404'

---------------------------------------------
--	���[FameLV]
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticSubFameLV', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticSubFameLV;
GO

create table dbo.tStaticSubFameLV(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	famelv					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticSubFameLV_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tStaticSubFameLV where dateid = '20140404'
-- if(not exist(select dateid from dbo.tStaticSubFameLV where dateid = '20140404'))
-- 	insert into dbo.tStaticSubFameLV(dateid, famelv, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tStaticSubFameLV set cnt = 2 where dateid = '20140404' and famelv = 1

---------------------------------------------
--	���[Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticSubMarket', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticSubMarket;
GO

create table dbo.tStaticSubMarket(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticSubMarket_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tStaticSubMarket where dateid = '20140404'
-- if(not exist(select dateid from dbo.tStaticSubMarket where dateid = '20140404'))
-- 	insert into dbo.tStaticSubMarket(dateid, market, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tStaticSubMarket set cnt = 2 where dateid = '20140404' and market = 1



---------------------------------------------
--	����ڷ�(ĳ�� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashMaster;
GO

create table dbo.tStaticCashMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tStaticCashMaster_dateid	PRIMARY KEY(dateid)
)
GO

---------------------------------------------
--	����ڷ�(ĳ�� ����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashUnique', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashUnique;
GO

create table dbo.tStaticCashUnique(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticCashUnique_idx		PRIMARY KEY(idx)
)


---------------------------------------------
--		������ (�������� �α�)
--		����� �Է��� ����
--		(�ε����� �ϳ��� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemDieLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemDieLog;
GO

create table dbo.tUserItemDieLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- ����Ʈ�ε���(�����κ��� ����)

	invenkind		int					default(1),					--��з�(����(1), �Ҹ�ǰ(3), �׼�����(4))
	itemcode		int,
	cnt				int					default(1),					--������

	farmnum			int					default(-1),				-- �����ȣ(-1:�������, 0~50:�����ȣ)
	fieldidx		int					default(-1),				-- �ʵ�(-2:����, -1:â��, 0~8:�ʵ�)
	anistep			int					default(5),					-- ����ܰ�(0 ~ 12�ܰ�)
	manger			int					default(25),				-- ������(����:1 > ����:20)
	diseasestate	int					default(0),					-- ��������(0:������, ���� >=0 �ɸ�)
	acc1			int					default(-1),				-- �Ǽ�(����:�������ڵ�)
	acc2			int					default(-1),				-- �Ǽ�(��:�������ڵ�)

	upcnt			int					default(0),					--
	upstepmax		int					default(0),					--
	freshstem100	int					default(0),					--
	attstem100		int					default(0),					--
	timestem100		int					default(0),					--
	defstem100		int					default(0),					--
	hpstem100		int					default(0),					--
	usedheart		int					default(0),					--
	usedgamecost	int					default(0),					--

	randserial		varchar(20)			default('-1'),				--����������(Ŭ���̾�Ʈ���� ������)
	writedate		datetime			default(getdate()),			--������/ȹ����
	gethow			int					default(0),					--ȹ����(0:����, 1:����, 2:����/�̱�, 3:�˻�)

	diedate			datetime			default(getdate()),
	diemode			int					default(-1),				-- -1:�ƴ�, 1:����,����, 2:����
	needhelpcnt		int					default(0),					-- ������ ������ �ڵ� ��Ȱ������ ���ȴ�.(��Ȱ�� ������ŭ)

	petupgrade		int					default(1),					-- ����׷��̵� �ϱ�.
	treasureupgrade	int					default(0),					-- �������׷��̵� �ϱ�.

	idx3			int,

	-- Constraint
	CONSTRAINT	pk_tUserItemDieLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemDieLog_idx_gameid')
    DROP INDEX tUserItemDieLog.idx_tUserItemDieLog_idx_gameid
GO
CREATE INDEX idx_tUserItemDieLog_idx_gameid ON tUserItemDieLog (idx, gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemDieLog_gameid_idx3')
    DROP INDEX tUserItemDieLog.idx_tUserItemDieLog_gameid_idx3
GO
CREATE INDEX idx_tUserItemDieLog_gameid_idx3 ON tUserItemDieLog (gameid, idx3)
GO

---------------------------------------------
--		������ (�������� �α�)
--		����� �Է��� ����
--		(�ε����� �ϳ��� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemAliveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemAliveLog;
GO

create table dbo.tUserItemAliveLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- ����Ʈ�ε���(�����κ��� ����)

	invenkind		int					default(1),					--��з�(����(1), �Ҹ�ǰ(3), �׼�����(4))
	itemcode		int,
	cnt				int					default(1),					--������

	farmnum			int					default(-1),				-- �����ȣ(-1:�������, 0~50:�����ȣ)
	fieldidx		int					default(-1),				-- �ʵ�(-2:����, -1:â��, 0~8:�ʵ�)
	anistep			int					default(5),					-- ����ܰ�(0 ~ 12�ܰ�)
	manger			int					default(25),				-- ������(����:1 > ����:20)
	diseasestate	int					default(0),					-- ��������(0:������, ���� >=0 �ɸ�)
	acc1			int					default(-1),				-- �Ǽ�(����:�������ڵ�)
	acc2			int					default(-1),				-- �Ǽ�(��:�������ڵ�)

	upcnt			int					default(0),					--
	upstepmax		int					default(0),					--
	freshstem100	int					default(0),					--
	attstem100		int					default(0),					--
	timestem100		int					default(0),					--
	defstem100		int					default(0),					--
	hpstem100		int					default(0),					--
	usedheart		int					default(0),					--
	usedgamecost	int					default(0),					--

	randserial		varchar(20)			default('-1'),				--����������(Ŭ���̾�Ʈ���� ������)
	writedate		datetime			default(getdate()),			--������/ȹ����
	gethow			int					default(0),					--ȹ����(0:����, 1:����, 2:����/�̱�, 3:�˻�)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:�ƴ�, 1:����,����, 2:����
	needhelpcnt		int					default(0),					-- ������ ������ �ڵ� ��Ȱ������ ���ȴ�.(��Ȱ�� ������ŭ)

	petupgrade		int					default(1),					-- ����׷��̵� �ϱ�.
	treasureupgrade	int					default(0),					-- �������׷��̵� �ϱ�.

	alivedate		datetime			default(getdate()),
	alivecash		int					default(0),
	alivedoll		int					default(0),

	idx3			int,

	-- Constraint
	CONSTRAINT	pk_tUserItemAliveLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemAliveLog_idx_gameid')
    DROP INDEX tUserItemAliveLog.idx_tUserItemAliveLog_idx_gameid
GO
CREATE INDEX idx_tUserItemAliveLog_idx_gameid ON tUserItemAliveLog (idx, gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemAliveLog_gameid_idx3')
    DROP INDEX tUserItemAliveLog.idx_tUserItemAliveLog_gameid_idx3
GO
CREATE INDEX idx_tUserItemAliveLog_gameid_idx3 ON tUserItemAliveLog (gameid, idx3)
GO

---------------------------------------------
--		�̺�Ʈ ������
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tEventMaster;
GO

create table dbo.tEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:�����, 1:������, 2:�Ϸ���

	-- Constraint
	CONSTRAINT	pk_tEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- ó�� ����Ÿ�� �־�����Ѵ�.
-- insert into dbo.tEventMaster(eventstatemaster) values(0)
-- update dbo.tEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tEventMaster where idx = 1


---------------------------------------------
--		�̺�Ʈ �޾ư� �����α�
---------------------------------------------
IF OBJECT_ID (N'dbo.tEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tEvnetUserGetLog;
GO

create table dbo.tEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	eventidx		int,
	eventitemcode	int,
	eventcnt		int,
	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tEvnetUserGetLog.idx_tEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tEvnetUserGetLog_gameid_eventidx ON tEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1







---------------------------------------------
-- 	�ֻ��� ȸ�� �α� (���� ����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserYabauMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserYabauMonth;
GO

create table dbo.tUserYabauMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select         * from dbo.tUserYabauMonth where dateid6 = '201407' and itemcode = 70008
-- insert into dbo.tUserYabauMonth(dateid6, itemcode) values('201407', 70008)
-- update dbo.tUserYabauMonth set step1 = step1 + 1 where dateid6 = '201407' and itemcode = 70008


---------------------------------------------
-- 	�ֻ��� ȸ�� �α� (���� Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserYabauTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserYabauTotalSub;
GO

create table dbo.tUserYabauTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select         * from dbo.tUserYabauTotalSub where dateid8 = '20140724' and itemcode = 70008
-- insert into dbo.tUserYabauTotalSub(dateid8, itemcode) values('20140724', 70008)
-- update dbo.tUserYabauTotalSub set step1 = step1 + 1 where dateid8 = '20140724' and itemcode = 70008


---------------------------------------------
-- 	�ֻ��� �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tYabauLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tYabauLogPerson;
GO

create table dbo.tYabauLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	itemcode		int				default(-1),
	kind			int				default(1),			-- �ֻ����� ��尡 ��.
	framelv			int,

	yabaustep		int				default(-1),
	pack11			int				default(-1),
	pack21			int				default(-1),
	pack31			int				default(-1),
	pack41			int				default(-1),
	pack51			int				default(-1),
	pack61			int				default(-1),
	result			int				default(-1),
	cashcost		int				default(0),
	gamecost		int				default(0),
	yabauchange		int				default(0),
	yabaucount		int				default(0),			-- �õ�Ƚ��
	remaingamecost	int				default(0),			-- �����ݾ�
	remaincashcost	int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tYabauLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tYabauLogPerson_gameid_idx')
	DROP INDEX tYabauLogPerson.idx_tYabauLogPerson_gameid_idx
GO
CREATE INDEX idx_tYabauLogPerson_gameid_idx ON tYabauLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tYabauLogPerson where gameid = 'xxxx2' order by idx desc
-- MODE_YABAU_RESET
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, gamecost) values('xxxx2', 70002, 1, 20, 1700)
-- MODE_YABAU_REWARD
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, yabaustep) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 3)
-- MODE_YABAU_NORMAL, MODE_YABAU_PREMINUM
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, result, cashcost, gamecost) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 1, 1, 0)


-----------------------------------------------------
-- �̵� �̷� ���( ����ġ, ����, ����, �ð�)
-----------------------------------------------------
IF OBJECT_ID (N'dbo.tUserBeforeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBeforeInfo;
GO

create table dbo.tUserBeforeInfo(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	market		int						default(1),				-- (����ó�ڵ�) MARKET_SKT
	marketnew	int						default(1),				-- (����ó�ڵ�) MARKET_SKT
	version		int						default(101),			-- Ŭ�����

	fame		int						default(0),
	famelv		int						default(1),
	famelvbest	int						default(1),
	gameyear	int						default(2013),
	gamemonth	int						default(3),
	changedate	datetime				default(getdate()),
	-- Constraint
	CONSTRAINT pk_tUserBeforeInfo_gameid	PRIMARY KEY(idx)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBeforeInfo_gameid_idx')
	DROP INDEX tUserBeforeInfo.idx_tUserBeforeInfo_gameid_idx
GO
CREATE INDEX idx_tUserBeforeInfo_gameid_idx ON tUserBeforeInfo (gameid, idx)
GO
-- if(@market != @market_)
--	begin
--		insert into dbo.tUserBeforeInfo(gameid,  market,  version,  fame,  famelv,  gameyear,  gamemonth)
--		values(                        @gameid, @market, @version, @fame, @famelv, @gameyear, @gamemonth)
--	end


---------------------------------------------
--		�����г��Ӻ���
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserNickNameChange', N'U') IS NOT NULL
	DROP TABLE dbo.tUserNickNameChange;
GO

create table dbo.tUserNickNameChange(
	idx			int 					IDENTITY(1, 1),

	--(��������)
	gameid		varchar(60),
	oldnickname	varchar(20)				default(''),
	newnickname	varchar(20)				default(''),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserNickNameChange_idx	PRIMARY KEY(idx)
)
GO



---------------------------------------------
--		��Ʋ�ΰ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLog;
GO

create table dbo.tBattleLog(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	farmidx		int						default(6900),

	anidesc1		varchar(120)		default(''),
	anidesc2		varchar(120)		default(''),
	anidesc3		varchar(120)		default(''),
	anidesc4		varchar(120)		default(''),
	anidesc5		varchar(120)		default(''),

	ts1name			varchar(40)			default(''),
	ts2name			varchar(40)			default(''),
	ts3name			varchar(40)			default(''),
	ts4name			varchar(40)			default(''),
	ts5name			varchar(40)			default(''),

	enemydesc		varchar(120)		default(''),

	writedate		datetime			default(getdate()),
	result			int					default(0),		--  1   BATTLE_RESULT_WIN
														-- -1  	BATTLE_RESULT_LOSE
														--  0   BATTLE_RESULT_DRAW
	playtime		int					default(0),
	reward1			int					default(-1),
	reward2			int					default(-1),
	reward3			int					default(-1),
	reward4			int					default(-1),
	reward5			int					default(-1),
	rewardgamecost	int					default(0),
	star			int					default(0),

	-- Constraint
	CONSTRAINT pk_tBattleLog_idx	PRIMARY KEY(idx)
)
GO
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_idx2')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_idx2
GO
CREATE INDEX idx_tBattleLog_gameid_idx2 ON tBattleLog (gameid, idx2)
GO

--update dbo.tBattleLog
--	set
--		result 		= 1,		playtime	= 90,
--		reward1		= 104010,	reward2		= 104010,
--		reward3		= 104010,	reward4		= 104010,	reward5		= -1,
--		rewardgamecost = 20
--where gameid = 'xxxx2' and idx2 = 1




---------------------------------------------
--		������Ʋ �ΰ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleLog;
GO

create table dbo.tUserBattleLog(
	idx				int 					IDENTITY(1, 1),
	idx2			int,

	gameid			varchar(20),
	trophy			int					default(0),
	tier			int					default(1),

	anidesc1		varchar(120)		default(''),
	anidesc2		varchar(120)		default(''),
	anidesc3		varchar(120)		default(''),

	ts1name			varchar(40)			default(''),
	ts2name			varchar(40)			default(''),
	ts3name			varchar(40)			default(''),
	ts4name			varchar(40)			default(''),
	ts5name			varchar(40)			default(''),

	othergameid		varchar(20),
	othernickname	varchar(40)			default(''),
	othertrophy		int					default(0),
	othertier		int					default(1),
	otheridx		int					default(-1),
	--othanidesc1	varchar(120)		default(''),
	--othanidesc2	varchar(120)		default(''),
	--othanidesc3	varchar(120)		default(''),

	--othts1name	varchar(40)			default(''),
	--othts2name	varchar(40)			default(''),
	--othts3name	varchar(40)			default(''),
	--othts4name	varchar(40)			default(''),
	--othts5name	varchar(40)			default(''),

	writedate		datetime			default(getdate()),
	result			int					default(0),		--  1   BATTLE_RESULT_WIN
														-- -1  	BATTLE_RESULT_LOSE
														--  0   BATTLE_RESULT_DRAW

	gettrophy		int					default(0),
	playtime		int					default(0),
	rewardbox		int					default(0),

	-- Constraint
	CONSTRAINT pk_tUserBattleLog_idx	PRIMARY KEY(idx)
)
GO
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleLog_gameid_idx2')
    DROP INDEX tUserBattleLog.idx_tUserBattleLog_gameid_idx2
GO
CREATE INDEX idx_tUserBattleLog_gameid_idx2 ON tUserBattleLog (gameid, idx2)
GO






---------------------------------------------
--	������Ʋ��ŷ���(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleRankMaster;
GO

create table dbo.tUserBattleRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tUserBattleRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tUserBattleRankMaster where dateid = '20150216'

---------------------------------------------
--		������Ʋ��ŷ���(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleRankSub;
GO

create table dbo.tUserBattleRankSub(
	idx				int 					IDENTITY(1, 1),			-- indexing

	dateid8			varchar(8),
	rank			int,
	anirepitemcode	int						default(1),
	trophy			int						default(0),
	tier			int						default(0),
	gameid			varchar(20),
	kakaonickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tUserBattleRankSub_idx	PRIMARY KEY(idx)		-- ���������� dateid, rank�� ����´�.
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleRankSub_dateid8_rank')
    DROP INDEX tUserBattleRankSub.idx_tUserBattleRankSub_dateid8_rank
GO
CREATE INDEX idx_tUserBattleRankSub_dateid8_rank ON tUserBattleRankSub (dateid8, rank)
GO





---------------------------------------------
--	PushBlackList
---------------------------------------------
IF OBJECT_ID (N'dbo.tPushBlackList', N'U') IS NOT NULL
	DROP TABLE dbo.tPushBlackList;
GO

create table dbo.tPushBlackList(
	idx				int				identity(1, 1),

	phone			varchar(20),
	comment			varchar(512),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tPushBlackList_idx	PRIMARY KEY(idx)
)
--insert into dbo.tPushBlackList(phone, comment) select phone, comment from GameMTBaseball.dbo.tFVPushBlackList where phone not in ( select phone from dbo.tPushBlackList )
--insert into dbo.tPushBlackList(phone, comment) select phone, comment from Game4GameMTBaseballVill4.dbo.tFVPushBlackList where phone not in ( select phone from dbo.tPushBlackList )
--insert into dbo.tPushBlackList(phone, comment) values('01036630157', '�輼�ƴ�ǥ')
--insert into dbo.tPushBlackList(phone, comment) values('01055841110', '�̴뼺 ����')
--insert into dbo.tPushBlackList(phone, comment) values('01051955895', '������')
--insert into dbo.tPushBlackList(phone, comment) values('01043358319', '�賲��')
--insert into dbo.tPushBlackList(phone, comment) values('01089114806', '����')
--insert into dbo.tPushBlackList(phone, comment) values('0183302149', 'ä����')
--insert into dbo.tPushBlackList(phone, comment) values('01050457694', '�̿���')
--insert into dbo.tPushBlackList(phone, comment) values('01048742835', '������ �븮')
--insert into dbo.tPushBlackList(phone, comment) values('01024065144', '� �����')
--insert into dbo.tPushBlackList(phone, comment) values('01027624701', '���� �輱��')
--insert into dbo.tPushBlackList(phone, comment) values('01090196756', '����_ȣ���þ�ü')

---------------------------------------------
--		���������.
---------------------------------------------
IF OBJECT_ID (N'dbo.tTTTT', N'U') IS NOT NULL
	DROP TABLE dbo.tTTTT;
GO

create table dbo.tTTTT(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	step			varchar(400)		default(''),
	msg				varchar(400)		default(''),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tTTTT_idx	PRIMARY KEY(idx)
)






---------------------------------------------
-- �̺�Ʈ ����Ű��
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO

create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mainkind	int				default(1),		-- 1: 1��1����, 2:������
	kind		int				default(1),		-- ���ۿ�û�� ȸ���ȣ.

	startdate	datetime		default(getdate()),
	enddate		datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO


---- 1����(1)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON1',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON2',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )
--
---- ������(2)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON1',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON2',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() - 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(          'ZAYOZAYOTYCOONK5',      5000,  300,      5100, 2000,        -1,    0,        2,    0, getdate() + 7 )


---------------------------------------------
-- �̺�Ʈ ����Ű��(���)
-- �������� ������������ �����ߴ�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoBack;
GO

create table dbo.tEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mainkind	int				default(1),		-- 1: 1��1����, 2:������
	kind		int				default(1),		-- ���ۿ�û�� ȸ���ȣ.

	usedtime	datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
GO
--CREATE INDEX idx_tEventCertNoBack_certno ON tEventCertNoBack (certno)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_gameid_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_gameid_certno
GO
CREATE INDEX idx_tEventCertNoBack_gameid_certno ON tEventCertNoBack (gameid, certno)
GO



---------------------------------------------
--		��ŷ�������(��ü).
---------------------------------------------
IF OBJECT_ID (N'dbo.tRankDaJun', N'U') IS NOT NULL
	DROP TABLE dbo.tRankDaJun;
GO

create table dbo.tRankDaJun(
	idx			int 					IDENTITY(1, 1),

	--(��¥����)
	rkdateid8		varchar(8),
	rkteam1			int					default(0),				-- Ȧ������
	rkteam0			int					default(0),				-- ¦������
	rkreward		int					default(0),				-- ������(0), ����(1)

	-- Ȧ��.
	rksalemoney		bigint				default(0),				-- �Ǹż���(0).
	rksalebarrel	bigint				default(0),				-- ����跲(30).
	rkbattlecnt		bigint				default(0),				-- ��ƲȽ��(31).
	rkbogicnt		bigint				default(0),				-- ��������,�����̱�(32).
	rkfriendpoint	bigint				default(0),				-- ģ������Ʈ(�ڵ�����).
	rkroulettecnt	bigint				default(0),				-- �귿Ƚ��(20, 21).
	rkwolfcnt		bigint				default(0),				-- �������(33).

	-- ¦��.
	rksalemoney2	bigint				default(0),				-- �Ǹż���(0).
	rksalebarrel2	bigint				default(0),				-- ����跲(30).
	rkbattlecnt2	bigint				default(0),				-- ��ƲȽ��(31).
	rkbogicnt2		bigint				default(0),				-- ��������,�����̱�(32).
	rkfriendpoint2	bigint				default(0),				-- ģ������Ʈ(�ڵ�����).
	rkroulettecnt2	bigint				default(0),				-- �귿Ƚ��(20, 21).
	rkwolfcnt2		bigint				default(0),				-- �������(33).

	-- Constraint
	CONSTRAINT pk_tRankDaJun_rkdateid8	PRIMARY KEY(rkdateid8)
)
GO


---------------------------------------------
-- 	���� ¥��������� �ΰ�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserZCPLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserZCPLog;
GO

create table dbo.tUserZCPLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	idx2			int,
	mode			int,		-- ���Ϸ귿(0), �����귿(1)
	usedcashcost	int,		-- ĳ�����.
	ownercashcost	int,		-- ��������.
	cnt				int,		-- ȹ�氳��

	writedate		smalldatetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserZCPLog_idx PRIMARY KEY(idx)
)
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserZCPLog_gameid_idx2')
    DROP INDEX tUserZCPLog.idx_tUserZCPLog_gameid_idx2
GO
CREATE INDEX idx_tUserZCPLog_gameid_idx2 ON tUserZCPLog (gameid, idx2)
GO



---------------------------------------------
-- 	��������.
---------------------------------------------
IF OBJECT_ID (N'dbo.tZCPMarket', N'U') IS NOT NULL
	DROP TABLE dbo.tZCPMarket;
GO

create table dbo.tZCPMarket(
	idx				int				identity(1, 1),

	kind			int				default(1),			-- Best(1)
														-- �Ϲ�(2)
														-- ��������(3)
														-- �����ѳ�(4)
														-- ����ѳ�(5)
														-- ��Ÿ(6)
	title			varchar(60),						-- Ÿ��Ʋ
	zcpfile			varchar(512),						-- �̹���URL
	zcpurl			varchar(512),						-- ����URL
	bestmark		int				default(-1),		-- Best��ū		YES(1) NO(-1)
	newmark			int				default(-1),		-- New��ũ	 	YES(1) NO(-1)
	needcnt			int				default(99),		-- �ʿ���������
	firstcnt		int				default(0),			-- �԰�
	balancecnt		int				default(0),			-- ��뷮
	commentsimple	varchar(512),						-- �󼼼���(����)
	commentdesc		varchar(2048),						-- �󼼼���(��)
	opendate		smalldatetime	default(getdate()),	-- ���³�¥
	expiredate		smalldatetime	default(getdate() + 30),-- ���⳯¥
	zcpflag			int				default(-1),		-- Ȱ������ ��Ȱ��(-1), Ȱ��(1)
	zcporder		int				default(0),			-- ������(����)

	writedate		smalldatetime	default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tZCPMarket_idx PRIMARY KEY(idx)
)

--insert into dbo.tZCPMarket( kind ) values( 1 )
--update dbo.tZCPMarket
--	set
--		kind 	= 2,
--		title	= '���̱��� �Ұ��',
--		zcpfile	= 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/gift_card.png',
--		zcpurl	= '',
--		bestmark= 1,
--		newmark	= 1,
--		needcnt	= 99,
--		firstcnt= 50,
--		balancecnt= 0,
--		commentsimple= '������ �Ұ�� ��������',
--		commentdesc	 = '������ �Ұ�� �󼼼���',
--		opendate	= '2016-05-25',
--		expiredate	= '2016-05-31',
--		zcpflag		= 1,
--		zcporder	= 0
--where idx = 2
--select * from dbo.tZCPMarket where zcpflag = 1 and getdate() < expiredate order by kind asc, zcporder desc



---------------------------------------------
-- 	¥�����Ϳ��� ������ ����..
---------------------------------------------
IF OBJECT_ID (N'dbo.tZCPOrder', N'U') IS NOT NULL
	DROP TABLE dbo.tZCPOrder;
GO

create table dbo.tZCPOrder(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	state			int				default(0),			-- �����(0), Ȯ����(1), �߼ۿϷ�(2)
	zcpidx			int				default(-1),
	comment			varchar(1024)	default(''),
	usecnt			int				default(0),
	orderdate		smalldatetime	default(getdate()),

	adminid			varchar(20)			default(''),
	comment2		varchar(1024)		default(''),
	deliverdate		smalldatetime,

	-- Constraint
	CONSTRAINT	pk_tZCPOrder_idx PRIMARY KEY(idx)
)

--insert into dbo.tZCPOrder( gameid, zcpidx, usecnt )
--values(                   'xxxx2',      1,     15 )
--update dbo.tZCPOrder
--	set
--		state 		= 1,
--		dealdate	= getdate()
--where idx = 1
--
-- select * from dbo.tZCPOrder order by idx desc
-- select * from dbo.tZCPOrder where state = 0 order by idx desc
*/

