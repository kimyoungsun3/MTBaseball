use Farm
GO

-- �߸��ؼ� ���̺��� ��ü �ǵ帱�� �־ �ּ�ó���� ���Ƶд�.(���� �Ǽ������� �־)
-- �Է� < �˻�(�켱����)
-- ����Ÿ���̽� ��ҹ��� ���о���(���� ���õ� ���� Ȯ���ʿ�)
---------------------------------------------
--		��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMaster;
GO

create table dbo.tFVUserMaster(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(��������)
	gameid		varchar(60),									-- �̸���(PK)
	phone		varchar(20)				default(''),			-- indexing
	market		int						default(5),				-- (����ó�ڵ�)
	buytype		int						default(0),				-- (����/�����ڵ�)
	version		int						default(101),			-- Ŭ�����
	concode		int						default(82),			-- �ѱ�(82), �Ϻ�(81), �̱�(1)
	pushid		varchar(256)			default(''),

	-- ���� ����
	nickname	varchar(20)				default(''),			-- ��Ī(�г���)
	nickcnt		int						default(1),

	regdate		datetime				default(getdate()),		-- ���ʰ�����
	condate		datetime				default(getdate()),		-- (�α��νø��� �Ź�������Ʈ)
	concnt		int						default(1),				-- ����Ƚ��
	logindate	varchar(8)				default('20100101'),	--
	savebktime	datetime				default(getdate() - 1),		-- ����� Ÿ��

	-- �ʴ�����
	kakaomsginvitecnt		int			default(0), 			-- 			�ʴ�.
	kakaomsginvitecntbg		int			default(0), 			-- 			�ʴ�bg.
	kakaomsginvitetodaycnt	int			default(0),				-- 			���� �ʴ��ο���.
	kakaomsginvitetodaydate	datetime	default(getdate()),		-- 			���� ��¥.

	blockstate	int						default(0),				-- 0 : �����¾ƴ�, 1 : ������
	cashcopy	int						default(0),				-- ĳ���ҹ�ī�ǽ� +1�߰��ȴ�.
	resultcopy	int						default(0),				-- �αװ��ī�ǽ� +1�߰��ȴ�.
	bestani		int						default(500),
	cashpoint	int						default(0),
	cashcost	bigint					default(0),				-- ����.
	vippoint	int						default(0),
	ownercashcost	bigint				default(0),

	randserial	varchar(20)				default('-1'),			-- ����������
	bgitemcode1	int						default(-1),
	bgitemcode2	int						default(-1),
	bgitemcode3	int						default(-1),
	bgcnt1		int						default(0),
	bgcnt2		int						default(0),
	bgcnt3		int						default(0),
	logwrite2	int						default(1),

	-- Ŭ���̾�Ʈ ����Ÿ.
	cashcost2	bigint					default(0),				-- ����.
	vippoint2	int						default(0),				--
	salemoney2	bigint					default(0),

	-- ȸ����.
	roulette	int						default(1),
	roulettefreecnt	int					default(0),
	roulettepaycnt	int					default(0),
	roulettegoldcnt	int					default(0),
	wheelgauage	int						default(0),				-- ȸ����(��������)
	wheelfree	int						default(0),				-- 1�̸� ����ȸ��.

	-- (�̱�)
	tsgrade1cnt	int						default(0),				-- �Ϲ�     �̱� Ƚ�� D, C
	tsgrade2cnt	int						default(0),				-- �����̾� �̱� Ƚ�� B, A
	tsgrade3cnt	int						default(0),				--          �̱� Ƚ�� A, S
	tsgrade4cnt	int						default(0),				--          �̱� Ƚ�� A, S(3 + 1)
	tsgrade2gauage	int					default(0),				-- �����̾� ������ B, A.
	tsgrade3gauage	int					default(0),				--          ������ A, S
	tsgrade4gauage	int					default(0),				--          ������ A, S(3 + 1)
	tsgrade2free	int					default(0),
	tsgrade3free	int					default(0),
	tsgrade4free	int					default(0),
	adidx		int						default(0),				-- �����ȣ.

	-- �̺�Ʈ.
	eventspot06		int					default(0),				-- �������� ���.
	eventspot07		int					default(0),				-- �������� ���.
	eventspot08		int					default(0),				-- �������� ���.
	eventspot09		int					default(0),				-- �������� ���.
	eventspot10		int					default(0),				-- �������� ���.
	eventspot0x		int					default(0),

	-- Constraint
	CONSTRAINT pk_tFVUserMaster_gameid	PRIMARY KEY(gameid)
)
GO
-- alter table dbo.tFVUserMaster add logindate	varchar(8)				default('20100101')
-- ����Ÿ 10���� ������ �־ �����غ���(���ID�� ���� ������ �Է��Ѵ�.)
-- ���Խ� gameid ���� > PRIMARY KEY(gameid) > �ε���

-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_phone')
    DROP INDEX tFVUserMaster.idx_tFVUserMaster_phone
GO
CREATE INDEX idx_tFVUserMaster_phone ON tFVUserMaster (phone)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_idx')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_idx
GO
CREATE INDEX idx_tFVUserMaster_idx ON tFVUserMaster (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_salemoney2')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_salemoney2
GO
CREATE INDEX idx_tFVUserMaster_salemoney2 ON tFVUserMaster (salemoney2)
GO

-- insert into dbo.tFVUserMaster(gameid, phone, market, version) values('xxxx@gmail.com', '01022223333', 5, 101)
-- select * from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
-- update dbo.tFVUserMaster set market = 5, version = 101 where gameid = 'xxxx@gmail.com'

---------------------------------------------
--		��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserData', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserData;
GO

create table dbo.tFVUserData(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(��������)
	gameid		varchar(60),
	market		int						default(5),				-- (����ó�ڵ�)
	savestate	int						default(1),				-- 1(save), -1(�о)
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData_gameid	PRIMARY KEY(gameid, market)
)
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserData_idx')
   DROP INDEX tFVUserData.idx_tFVUserData_idx
GO
CREATE INDEX idx_tFVUserData_idx ON tFVUserData (idx)
GO

---------------------------------------------
--		������ ��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVGiftList;
GO

create table dbo.tFVGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(60),									-- gameid�� itemcode�� �ߺ��� �߻��Ѵ�.
	giftkind	int					default(0),					-- 1:�޽���, 2:����, -1:�޽�������, -2:�����޾ư�

	message		varchar(256)		default(''), 				-- �޼���(1)

	itemcode	int					default(-1),				-- ����(2)
	cnt			bigint				default(0),
	gainstate	int					default(0),					-- ����������	0:�Ȱ�����, 1:������
	gaindate	datetime, 										-- ��������
	giftid		varchar(60)			default('SangSang'),		-- ������ ����
	giftdate	datetime			default(getdate()), 		-- ������

	-- Constraint
	CONSTRAINT	pk_tFVGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx
GO
CREATE INDEX idx_tFVGiftList_gameid_idx ON tFVGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx2')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx2
GO
CREATE INDEX idx_tFVGiftList_gameid_idx2 ON tFVGiftList (gameid, idx2)
GO



---------------------------------------------
-- 	������ȣ > ���Խ� ��ó����
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockPhone;
GO

create table dbo.tFVUserBlockPhone(
	idx			int 					IDENTITY(1, 1),

	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01022223335', '������ī��')
-- select top 100 * from dbo.tFVUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tFVUserBlockPhone where phone = '01022223333'

-- ����Ű �浹�˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockPhone_idx')
    DROP INDEX tFVUserBlockPhone.idx_tFVUserBlockPhone_idx
GO
CREATE INDEX idx_tFVUserBlockPhone_idx ON tFVUserBlockPhone (idx)
GO

---------------------------------------------------
--	(ȸ�����)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tFVNotice;
GO

create table dbo.tFVNotice(
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
	comfile6		varchar(512)	default(''),
	comurl6			varchar(512)	default(''),
	comfile7		varchar(512)	default(''),
	comurl7			varchar(512)	default(''),
	comfile8		varchar(512)	default(''),
	comurl8			varchar(512)	default(''),
	comfile9		varchar(512)	default(''),
	comurl9			varchar(512)	default(''),
	comment			varchar(4096)	default(''),

	version			int				default(101),			--Ŭ���̾�Ʈ����
	patchurl		varchar(512)	default(''),			--��ġURL
	recurl			varchar(512)	default(''),			--�Խ���URL
	smsurl			varchar(512)	default(''),			--SMSURL (������)
	smscom			varchar(512)	default(''),			--(������)

	iteminfover		int				default(100),			-- ������
	iteminfourl		varchar(512)	default(''),			-- ��URL

	writedate		datetime		default(getdate()), 	-- �ۼ���
	syscheck		int				default(0),				-- 0:������ 	1:������

	-- Constraint
	CONSTRAINT	pk_tFVNotice_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVNotice where market = 1 order by writedate desc
--select * from dbo.tFVNotice where market = 1 order by writedate desc
--insert into dbo.tFVNotice(market, version, patchurl) values(1, 101, 'http://m.naver.com')
--insert into dbo.tFVNotice(market, version, patchurl) values(2, 101, 'http://m.naver.com')
--insert into dbo.tFVNotice(market, version, patchurl) values(5, 101, 'http://m.naver.com')


---------------------------------------------
-- 	����������
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDayLogInfoStatic;
GO

create table dbo.tFVDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),
	market			int				default(1),

	joinukcnt		int				default(0),					-- �� ����ũ ����(����)
	joinukcnt2		int				default(0),					-- �� ����ũ ����(����)
	logincnt		int				default(0),					-- �� �α���(�ߺ�)
	logincnt2		int				default(0),					-- �� �α���(����ũ)
	invitekakao		int				default(0),

	roulettefreecnt	int				default(0),					-- �� ���Ϸ귿
	roulettepaycnt	int				default(0),					-- �� �����귿
	roulettegoldcnt	int				default(0),					-- �� Ȳ�ݹ���

	certnocnt		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDayLogInfoStatic_dateid8_market')
    DROP INDEX tFVDayLogInfoStatic.idx_tFVDayLogInfoStatic_dateid8_market
GO
CREATE INDEX idx_tFVDayLogInfoStatic_dateid8_market ON tFVDayLogInfoStatic(dateid8, market)
GO

-- insert into dbo.tFVDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tFVDayLogInfoStatic order by idx desc


---------------------------------------------
-- 	ĳ������(���ηα�)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLog;
GO

create table dbo.tFVCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(60)		not null, 				-- ������
	gameyear		int				default(2013),			-- ���ӽ��� 2013�� 3������ ����(��)
	gamemonth		int				default(3),				--
	famelv			int				default(1),

	giftid			varchar(20), 							-- �����������
	acode			varchar(256), 							-- �����ڵ�() ������.�Ф�
	ucode			varchar(256), 							-- �����ڵ�

	ikind			varchar(256),							-- ������, Google ����(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(����)
	idata2			varchar(4096),							-- ���������� ���Ǵ� ����Ÿ(�ؼ���)
	concode			int				default(82),			-- �ѱ�(82), �Ϻ�(81), �̱�(1)

	cashcost		int				default(0), 			-- ������纼
	cash			int				default(0),				-- ��������
	writedate		datetime		default(getdate()), 	-- ������
	market			int				default(1),				-- (����ó�ڵ�) MARKET_SKT

	-- Constraint
	CONSTRAINT	pk_tFVCashLog_idx	PRIMARY KEY(idx)
)
--���� clustered�� ���� ������ ����� idx�� �ϰ� �˻��� ucode > idx�� ���ؼ� �ϵ��� ����
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_ucode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_ucode
GO
CREATE INDEX idx_tFVCashLog_ucode ON tFVCashLog (ucode)
GO
--�����αװ˻�
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_gameid')
    DROP INDEX tFVCashLog.idx_tFVCashLog_gameid
GO
CREATE INDEX idx_tFVCashLog_gameid ON tFVCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_acode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_acode
GO
CREATE INDEX idx_tFVCashLog_acode ON tFVCashLog (acode)
GO
--insert into dbo.tFVCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tFVCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	ĳ������Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashTotal;
GO

create table dbo.tFVCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,
	market			int				default(1),				-- (����ó�ڵ�) MARKET_SKT

	cashcost		int				default(0), 			-- ���Ǹŷ�
	cash			int				default(0), 			-- ���Ǹŷ�
	cnt				int				default(1),				--����ȸ��
	-- Constraint
	CONSTRAINT	pk_tFVCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 2000, 1, 21, 2000)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tFVCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tFVCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1



---------------------------------------------
--  ������ ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVAdminUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVAdminUser;
GO

create table dbo.tFVAdminUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(20),
	password		varchar(20),
	writedate		datetime			default(getdate()),
	grade			int					default(0),

	-- Constraint
	CONSTRAINT	pk_tFVAdminUser_idx	PRIMARY KEY(gameid)
)

--select * from dbo.tFVAdminUser
--insert into tFVAdminUser(gameid, password) values('blackm', 'a1s2d3f4')




---------------------------------------------
--	���������� �ൿ�� �ҷ��� �ϴ� ����üŷ > ��ó��
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog;
GO

create table dbo.tFVUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- �ൿ��
	comment			varchar(512), 							-- �����󳻿�
	writedate		datetime		default(getdate()), 	-- �������ۼ���

	chkstate		int				default(0),				-- Ȯ�λ���(0:üŷ����, 1:üŷ��)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- Ȯ�γ���

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog_gameid_idx')
    DROP INDEX tFVUserUnusualLog.idx_tFVUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog_gameid_idx ON tFVUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', 'ĳ��ī�ǽõ�')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', 'ȯ��ī�ǽõ�')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x2', '�������')
-- select top 20 * from dbo.tFVUserUnusualLog order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog where gameid = 'sususu' order by idx desc



---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
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
	CONSTRAINT	pk_tFVUserPushAndroid_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserPushAndroid

-- ����
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
-- ������
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
--


---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
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
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushiPhone_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVUserPushAndroidLog
---- Push�Է��ϱ�
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������', 'Ȩ������ ����Ǫ���� ������.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, 'Ȩ����������url', 'Ȩ������ ����Ǫ���� ������.url', 'http://m.naver.com')



---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushSendInfo;
GO

create table dbo.tFVUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgurl			varchar(512)	default(''),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVUserPushSendInfo order by idx desc
-- insert into dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tFVUserPushiPhone
-- select max(idx), min(idx) from dbo.tFVUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushAndroid
-- select top 10 * from dbo.tFVUserPushiPhone where msgtitle = '���� iPhone'
-- select top 10 * from dbo.tFVUserPushAndroid where msgtitle = '���� Google'
-- ����
-- delete from dbo.tFVUserPushiPhone  where msgtitle = '���� iPhone'
-- delete from dbo.tFVUserPushAndroid where msgtitle = '���� Google'
-- delete from dbo.tFVUserPushiPhone  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
-- delete from dbo.tFVUserPushAndroid  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)


---------------------------------------------
--	PushBlackList
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVPushBlackList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVPushBlackList;
GO

create table dbo.tFVPushBlackList(
	idx				int				identity(1, 1),

	phone			varchar(20),
	comment			varchar(512),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVPushBlackList_idx	PRIMARY KEY(idx)
)
--insert into dbo.tFVPushBlackList(phone, comment) values('01036630157', '�輼�ƴ�ǥ')
--insert into dbo.tFVPushBlackList(phone, comment) values('01055841110', '�̴뼺 ����')
--insert into dbo.tFVPushBlackList(phone, comment) values('01051955895', '������')
--insert into dbo.tFVPushBlackList(phone, comment) values('01043358319', '�賲��')
--insert into dbo.tFVPushBlackList(phone, comment) values('01089114806', '����')
--insert into dbo.tFVPushBlackList(phone, comment) values('0183302149', 'ä����')
--insert into dbo.tFVPushBlackList(phone, comment) values('01050457694', '�̿���')
--insert into dbo.tFVPushBlackList(phone, comment) values('01048742835', '������ �븮')
--insert into dbo.tFVPushBlackList(phone, comment) values('01024065144', '� �����')
--insert into dbo.tFVPushBlackList(phone, comment) values('01027624701', '���� �輱��')
--insert into dbo.tFVPushBlackList(phone, comment) values('01090196756', '����_ȣ���þ�ü')





---------------------------------------------
-- �̺�Ʈ ����Ű��
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNo;
GO

create table dbo.tFVEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNo_idx	PRIMARY KEY(idx)
)
-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNo_certno')
    DROP INDEX tFVEventCertNo.idx_tFVEventCertNo_certno
GO
CREATE INDEX idx_tFVEventCertNo_certno ON tFVEventCertNo (certno)
GO

---------------------------------------------
-- �̺�Ʈ ����Ű��(���)
-- �������� ������������ �����ߴ�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNoBack;
GO

create table dbo.tFVEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(60),
	market		int				default(5),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- ������ȣ �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_certno')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_certno
GO
CREATE INDEX idx_tFVEventCertNoBack_certno ON tFVEventCertNoBack (certno)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind ON tFVEventCertNoBack (gameid, kind)
GO




---------------------------------------------
--		�̺�Ʈ ������
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:�����, 1:������, 2:�Ϸ���

	-- Constraint
	CONSTRAINT	pk_tFVEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- ó�� ����Ÿ�� �־�����Ѵ�.
-- insert into dbo.tFVEventMaster(eventstatemaster) values(0)
-- update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tFVEventMaster where idx = 1

---------------------------------------------
--		�̺�Ʈ ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventSub;
GO

create table dbo.tFVEventSub(
	eventidx		int					IDENTITY(1,1),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventcnt		int					default(0),
	eventsender		varchar(60)			default('sangsang'),
	eventday		int					default(0),
	eventstarthour	int					default(0),
	eventendhour	int					default(0),

	eventpushtitle	varchar(512)		default(''),				-- Ǫ�� ����, ����, ����
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tFVEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventSub_eventday_eventstarthour_eventendhour')
    DROP INDEX tFVEventSub.idx_tFVEventSub_eventday_eventstarthour_eventendhour
GO
CREATE INDEX idx_tFVEventSub_eventday_eventstarthour_eventendhour ON tFVEventSub (eventday, eventstarthour, eventendhour)
GO

--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             12,           18,  'Ǫ�� ����1',   'Ǫ�� ����1')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             19,           24,  'Ǫ�� ����1-2',   'Ǫ�� ����1-2')
--update dbo.tFVEventSub
--	set
--		eventstatedaily	= 1,
--		eventitemcode 	= 1000,
--		eventday		= 1,
--		eventstarthour	= 12,
--		eventendhour	= 18,
--		eventsender		= 'sangsang',
--		eventpushtitle	= 'Ǫ�� ����1',
--		eventpushmsg	= 'Ǫ�� ����1'
--where eventidx = 1
--update dbo.tFVEventSub set eventstatedaily	= 1 where eventidx = 2
--declare @curdate datetime 	set @curdate = '2014-09-02 23:59'
--declare @dd int 			set @dd = DATEPART(dd, @curdate)
--declare @hour int 			set @hour = DATEPART(hour, @curdate)
--select * from dbo.tFVEventSub where @dd = eventday and eventstarthour <= @hour and @hour <= eventendhour and eventstatedaily = 1
--select top 100 * from dbo.tFVEventSub order by eventidx desc



---------------------------------------------
--		�̺�Ʈ �޾ư� �����α�
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEvnetUserGetLog;
GO

create table dbo.tFVEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	eventidx		int,
	eventitemcode	int,
	writedate		datetime			default(getdate()),
	CONSTRAINT		pk_tFVEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tFVEvnetUserGetLog.idx_tFVEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tFVEvnetUserGetLog_gameid_eventidx ON tFVEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1






---------------------------------------------------
--	��õ����
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommend2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommend2;
GO

create table dbo.tFVSysRecommend2(
	idx				int				IDENTITY(1,1), 			-- ��ȣ
	packmarket		varchar(40)		default('1,2,3,4,5,6,7'),

	comfile			varchar(512)	default(''),
	comurl			varchar(512)	default(''),
	compackname		varchar(512)	default(''),
	rewarditemcode	int 			default(0),
	rewardcnt		int 			default(0),

	syscheck		int				default(-1),			-- 1:������ 	-1:����
	ordering		int				default(0),				-- �������� ����.
	writedate		datetime		default(getdate()), 	-- �ۼ���

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommend2_idx	PRIMARY KEY(idx)
)


---------------------------------------------------
--	��õ���� �ΰ�
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommendLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommendLog;
GO

create table dbo.tFVSysRecommendLog(
	idx				int				IDENTITY(1,1), 			-- ��ȣ

	gameid			varchar(60),
	recommendidx	int 			default(0),
	writedate		datetime		default(getdate()), 	-- �ۼ���

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommendLog_idx	PRIMARY KEY(idx)
)



---------------------------------------------
--		��ŷ���ΰ�? �Ⱥ��ΰ�?
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankView', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankView;
GO

create table dbo.tFVUserRankView(
	idx				int 					IDENTITY(1, 1),			-- indexing
	userrankview	int						default(-1),
)
GO

insert into dbo.tFVUserRankView(userrankview) values(-1)
update dbo.tFVUserRankView set userrankview = case when userrankview = -1 then 1 else -1 end where idx = 1





---------------------------------------------
--	������ŷ���(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankMaster;
GO

create table dbo.tFVUserRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tFVUserRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tFVUserRankMaster where dateid = '20150216'

---------------------------------------------
--		������ŷ���(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankSub;
GO

create table dbo.tFVUserRankSub(
	idx			int 					IDENTITY(1, 1),			-- indexing

	dateid8		varchar(8),

	rank		int,
	gameid		varchar(60),
	salemoney	bigint					default(0),
	bestani		int						default(500),
	nickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tFVUserRankSub_idx	PRIMARY KEY(idx)		-- ���������� dateid, rank�� ����´�.
)
GO


---------------------------------------------
--	����������2 �ൿ�� �ҷ��� �ϴ� ����üŷ > ��ó��
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog2;
GO

create table dbo.tFVUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- �ൿ��
	comment			varchar(512), 							-- �����󳻿�
	writedate		datetime		default(getdate()), 	-- �������ۼ���

	chkstate		int				default(0),				-- Ȯ�λ���(0:üŷ����, 1:üŷ��)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- Ȯ�γ���

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog2_gameid_idx')
    DROP INDEX tFVUserUnusualLog2.idx_tFVUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog2_gameid_idx ON tFVUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', 'ĳ��ī�ǽõ�')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', 'ȯ��ī�ǽõ�')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x2', '�������')
-- select top 20 * from dbo.tFVUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog2 where gameid = 'sususu' order by idx desc



---------------------------------------------
-- �̱��̺�Ʈ ���� ����.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRouletteMan;
GO

create table dbo.tFVSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 0.Ư���ð��� Ȯ�����.
	roulsaleflag		int					default(-1),
	roulsalevalue		int					default(0),

	-- 1.Ư������ ����ޱ�.
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

	-- 2.Ư���ð��� Ȯ�����.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),
	roultimetime4		int					default(-1),

	-- 3.�����̾� ����̱�.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(10),
	pmgauagemax			int					default(100),

	-- 4.��ȭ��� ����.
	tsupgradesaleflag	int					default(-1),
	tsupgradesalevalue	int					default(0),

	-- 5.ȸ���� ����̱�.
	wheelgauageflag		int					default(-1),
	wheelgauagepoint	int					default(10),
	wheelgauagemax		int					default(100),

	--�ڸ�Ʈ.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                              (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3

--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         1,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,            12,            18,            23, '���ʳ���')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         5,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         6,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         7,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')




---------------------------------------------
-- 	������ȭ �αױ��(200������ ����).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserWheelLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserWheelLog;
GO

create table dbo.tFVUserWheelLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	idx2			int,
	mode			int,		-- ���Ϸ귿(20), �����귿(21), Ȳ�ݹ���(22)
	cashcost		int,		-- �������.

	ownercashcost	bigint,		-- ��������.
	ownercashcost2	bigint,		-- ��������.
	strange			int,		-- �̻���(1) ����(-1), ��������(-2)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserWheelLog_idx PRIMARY KEY(idx)
)
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserWheelLog_gameid_idx2')
    DROP INDEX tFVUserWheelLog.idx_tFVUserWheelLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserWheelLog_gameid_idx2 ON tFVUserWheelLog (gameid, idx2)
GO



---------------------------------------------
--		��������(���)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserDataBackup', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserDataBackup;
GO

create table dbo.tFVUserDataBackup(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(��������)
	gameid		varchar(60),
	market		int						default(5),				-- (����ó�ڵ�)
	idx2		int,
	savedata	varchar(4096)			default('-1'),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserDataBackup_gameid_market_idx2	PRIMARY KEY(gameid, market, idx2)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserDataBackup_idx')
   DROP INDEX tFVUserDataBackup.idx_tFVUserDataBackup_idx
GO
CREATE INDEX idx_tFVUserDataBackup_idx ON tFVUserDataBackup (idx)
GO




---------------------------------------------
--		Kakao �ʴ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	receuserid		varchar(60),
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_gameid_receuserid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_gameid_receuserid
GO
CREATE INDEX idx_tFVKakaoInvite_gameid_receuserid ON tFVKakaoInvite (gameid, receuserid)
GO

-- select top 1 * from dbo.tFVKakaoInvite where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5����
-- insert into dbo.tFVKakaoInvite(gameid, receuserid) values('xxxx@gmail.com', 'kakaotalkid13')
-- update dbo.tFVKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'



---------------------------------------------
--		���� ��ŷ
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockLog;
GO

create table dbo.tFVUserBlockLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- ���̵�
	comment			varchar(512), 							-- �ý����ڸ�Ʈ
	writedate		datetime		default(getdate()), 	-- �����
	blockstate		int				default(1), 			-- ������ 	0 : �����¾ƴ�	1 : ������

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- �ڸ�Ʈ
	releasedate		datetime								-- ������

	-- Constraint
	CONSTRAINT pk_tFVUserBlockLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockLog_gameid_idx')
    DROP INDEX tFVUserBlockLog.idx_tFVUserBlockLog_gameid_idx
GO
CREATE INDEX idx_tFVUserBlockLog_gameid_idx ON tFVUserBlockLog(gameid, idx)
GO