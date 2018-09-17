use GameMTBaseball
GO

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
	deletestate	int						default(0),				-- 0 : �������¾ƴ�, 1 : ��������
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

-- select * from dbo.tUserMaster where gameid = 'xxxx'

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
	gamecost	int					default(0),
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
	gamecost	int					default(0),
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
	gamecost	int					default(0),
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
	gamecost	int					default(0),
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
	adminid			varchar(20),

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


---------------------------------------------------
--	(ȸ�����)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tNotice;
GO

create table dbo.tNotice(
	idx				int				IDENTITY(1,1), 			-- ��ȣ

	comfile1		varchar(512)	default(''),			-- �̱ۿ��� �̹���.
	comurl1			varchar(512)	default(''),			-- ����URL
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
	writedate		datetime		default(getdate()), 	-- �ۼ���
	syscheck		int				default(0),				-- 0:������ 	1:������

	-- Constraint
	CONSTRAINT	pk_tNotice_idx	PRIMARY KEY(idx)
)



---------------------------------------------
-- 	����������
---------------------------------------------
IF OBJECT_ID (N'dbo.tDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tDayLogInfoStatic;
GO

create table dbo.tDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),

	joinukcnt		int				default(0),					-- �� ����ũ ����
	logincnt		int				default(0),					-- �� �α���
	logincnt2		int				default(0),					-- �� �α���(����ũ)

	pieceboxcnt		int				default(0),					-- �� �����ڽ� ����
	clothesboxcnt	int				default(0),					-- �� �ǻ�ڽ� ����
	cashcnt			int				default(0),					-- �� ĳ������(�Ϲ�
	practicecnt		int				default(0),					--   �������Ƚ��
	singlecnt		int				default(0),					--   �̱۸��Ƚ��
	multicnt		int				default(0),					--

	certnocnt		int				default(0),					--   �������Ƚ��

	-- Constraint
	CONSTRAINT	pk_tDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDayLogInfoStatic_dateid8')
    DROP INDEX tDayLogInfoStatic.idx_tDayLogInfoStatic_dateid8
GO
CREATE INDEX idx_tDayLogInfoStatic_dateid8 ON tDayLogInfoStatic(dateid8)
GO

-- insert into dbo.tDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tDayLogInfoStatic order by idx desc

---------------------------------------------
-- 	����������
---------------------------------------------
IF OBJECT_ID (N'dbo.tDayLogInfoSubStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tDayLogInfoSubStatic;
GO

create table dbo.tDayLogInfoSubStatic(
	idx				int				IDENTITY(1,1),

	dateid10		varchar(10),

	joinukcnt		int				default(0),					-- �� ����ũ ����
	logincnt		int				default(0),					-- �� �α���

	pieceboxcnt		int				default(0),					-- �� �����ڽ� ����
	clothesboxcnt	int				default(0),					-- �� �ǻ�ڽ� ����
	cashcnt			int				default(0),					-- �� ĳ������(�Ϲ�
	practicecnt		int				default(0),					--
	singlecnt		int				default(0),					--
	multicnt		int				default(0),					--

	-- Constraint
	CONSTRAINT	pk_tDayLogInfoSubStatic_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDayLogInfoSubStatic_dateid10')
    DROP INDEX tDayLogInfoSubStatic.idx_tDayLogInfoSubStatic_dateid10
GO
CREATE INDEX idx_tDayLogInfoSubStatic_dateid10 ON tDayLogInfoSubStatic(dateid10)
GO

-- insert into dbo.tDayLogInfoSubStatic(dateid10) values('20130827')
-- select top 100 * from dbo.tDayLogInfoSubStatic order by idx desc

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
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
--    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
--GO
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
--		������ ���� (���շα�)
---------------------------------------------

---------------------------------------------
--		����ڷ� (���շα�)
---------------------------------------------


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
	level			int				default(1),

	giftid			varchar(20), 							-- �����������
	acode			varchar(256), 							-- �����ڵ�() ������.�Ф�
	ucode			varchar(256), 							-- �����ڵ�

	ikind			varchar(256),							-- ������, Google ����(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(����)
	idata2			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(�ؼ���)

	cashcost		int				default(0), 			-- ������纼
	cash			int				default(0),				-- ��������
	writedate		datetime		default(getdate()), 	-- ������

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

	cashcost		int				default(0), 			-- ���Ǹŷ�
	cash			int				default(0), 			-- ���Ǹŷ�
	cnt				int				default(1),				--����ȸ��
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid PRIMARY KEY(dateid, cashkind)
)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 2000, 21, 2000)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 5000, 55, 5000)
-- select top 1 * from dbo.tCashTotal where dateid = '20120818' and cashkind = 2000
-- update dbo.tCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000

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
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticCashUnique_idx		PRIMARY KEY(idx)
)


/*

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
--	�α��� ��Ȳ, �÷��� ��Ȳ
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticTime;
GO

create table dbo.tStaticTime(
	idx					int 				IDENTITY(1, 1),
	dateid10			varchar(10),
	logincnt			int					default(0),
	playcnt				int					default(0),

	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10	PRIMARY KEY(dateid10)
)
-- select top 1 * from dbo.tStaticTime




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
--	��踶����[FameLV]
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
*/

