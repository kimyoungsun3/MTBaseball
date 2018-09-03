
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
	market		int						default(1),				-- (����ó�ڵ�) MARKET_SKT
	buytype		int						default(0),				-- (����/�����ڵ�)
	platform	int						default(1),				-- (�÷���)
	ukey		varchar(256),									-- UKey
	version		int						default(101),			-- Ŭ�����
	pushid		varchar(256)			default(''),
	phone		varchar(20)				default(''),
	country		int						default(1),				-- �ѱ�(1), ����(2)

	-- Kakao ����
	kakaouserid			varchar(60)		default(''),			--          ����id
	kakaotalkid			varchar(60)		default(''),			-- īī���� �ؽ� ��ũ���̵�(����ũ�� ��)
	kakaogameid			varchar(60)		default(''),			-- īī���忡�� ������� ���Ӿ��̵�.
	kakaonickname		varchar(40)		default(''),			--          �г���
	kakaoprofile		varchar(512)	default(''),			--          ����
	kakaomsgblocked		int				default(-1),			--          �޽����� (-1:false, 1:true)
	kakaostatus			int				default(1),				--          �������(1:������, -1:�����ϱ�)

	kakaomsginvitecnt		int			default(0), 			-- 			�ʴ�.
	kakaomsginvitetodaycnt	int			default(0),				-- 			���� �ʴ��ο���.
	kakaomsginvitetodaydate	datetime	default(getdate()),		-- 			���� ��¥.
	--kakaomsgproudcnt	int				default(0), 			-- 			�ڶ�.
	--kakaomsgheartcnt	int				default(0), 			-- 			��Ʈ.
	--kakaomsghelpcnt	int				default(0), 			-- 			������.
	kkopushallow		int				default(1),				-- 			īī��Ǫ��
	kkhelpalivecnt		int				default(0),				-- 			īī���� �����û���� ��Ƴ��� ���� �ִ°�? 0 ����, 1 �̻��̸� ����.
	nicknamechange		int				default(0),				-- 			�г��Ӻ���Ƚ��.

	--(��������)
	regdate		datetime				default(getdate()),		-- ���ʰ�����
	condate		datetime				default(getdate()),		-- (�α��νø��� �Ź�������Ʈ)
	constate	int						default(1),				-- 0:���Ǫ���̹߼�, 1:�߼�
	concnt		int						default(1),				-- ����Ƚ��
	deletestate	int						default(0),				-- 0 : �������¾ƴ�, 1 : ��������
	blockstate	int						default(0),				-- 0 : �����¾ƴ�, 1 : ������
	cashcopy	int						default(0),				-- ĳ���ҹ�ī�ǽ� +1�߰��ȴ�.
	resultcopy	int						default(0),				-- �αװ��ī�ǽ� +1�߰��ȴ�.
	attenddate	datetime				default(getdate() - 1),		-- �⼮��
	attendcnt	int						default(0),				-- �⼮Ƚ��(����), �ִ� 28�ϱ����� ��ϵ�
	mboardstate	int						default(0),				-- (0) ���ۼ�, (1) �ۼ��� ������

	-- ���� ����.
	rtngameid	varchar(20)				default(''),			-- ��û���̵�.
	rtndate		datetime				default(getdate() - 1),	-- ��û��¥.
	rtnstep		int						default(-1),			-- ���ͽ���. (-1 : ���ͻ��¾ƴ�), (>=1 : ���ͻ��·� ����)
	rtnplaycnt	int						default(0),				-- �����÷���ī����(x��°�� ���ͼ���).

	-- (�Ϲ�����2)
	nickname	varchar(20)				default(''),			-- ��Ī(�г���)
	tutorial	int						default(0),				-- �����ȣ ���(0, 1, 2...) old��.
	tutostep	int						default(5500),			-- Ʃ�丮�� �����ȣ 5500 -> 5501 -> ... -1.(�̻��)
	comreward	int						default(90106),			-- �������ȣ.
	picture		varchar(128)			default('-1'),
	petlistidx		int					default(-1),			-- �� ������ ����Ʈ ��ȣ ����(-1), ����(>=0).
	petitemcode		int					default(-1),			--    �������ڵ� ����.
	petcooltime		int					default(0),				--    �����ϰ� ������ �ð�.
	pettodayitemcode	int				default(100005),		--    ���ø� �ǸŵǴ� ��.
	pettodayitemcode2	int				default(100005),		--    			 ü�� ��.
	anireplistidx	int					default(0),				-- ��ǥ���� �����ε�����ȣ(�̹�ȣ�� �ش��ϴ� tUserItem > listidx or ������ �⺻)
	anirepitemcode	int					default(1),				-- ��ǥ���� �������ڵ� �� �Ǽ��縮 ����.
	anirepacc1		int					default(-1),			--
	anirepacc2		int					default(-1),			--
	anirepmsg	varchar(40)				default('���� �ְ�'),
	gameyear	int						default(2013),			-- ���ӽ��� 2013�� 3������ ����(��)
	gamemonth	int						default(3),				--
	frametime	int						default(0),				-- �Ѵ�Ÿ��
	tradecnt	int						default(0),				-- ���Ӱŷ� ����Ƚ��
	tradefailcnt	int					default(0),				--          ����Ƚ��
	tradesuccesscnt		int				default(0),				-- �ŷ�����Ƚ��.
	tradeclosedealer	int				default(-1),			-- �����ι�ȣ.
	tradestate		int					default(1),				-- �������� ���(-1), ����(1)
	prizecnt	int						default(0),				-- ����Ƚ��
	tradecntold	int						default(0),				--
	prizecntold	int						default(0),				--
	fame		int						default(0),				-- ����
	famebg		int						default(0),				-- �����ӽù��
	famelv		int						default(1),				-- ��������
	famelvbest	int						default(1),
	contestcnt	int						default(0),				-- ��ȸ����Ƚ��
	farmcnt		int						default(1),				-- ���������
	fevergauge	int						default(0),				-- �ǹ�������.
	adidx		int						default(0),				-- �����ȣ.
	logindate	varchar(8)				default('20100101'),	-- �α�������.
	boardwrite	datetime				default(getdate() - 1),		-- 			���� ��¥.
	star		int						default(0),
	settlestep	int						default(0),				-- ����������.

	-- �ʵ�����.
	field0		int						default(1),				-- �ʵ�0 ~ 8��. �̻��(-1), ���(1)
	field1		int						default(1),				--
	field2		int						default(1),				--
	field3		int						default(1),				--
	field4		int						default(1),				--
	field5		int						default(-1),			--
	field6		int						default(-1),			--
	field7		int						default(-1),			--
	field8		int						default(-1),			--

	--(�κ�)
	invenanimalmax		int				default(50),			-- �����κ�����	(����, �α��� �κе� �����ؾ���.)
	invenanimalbase		int				default(50),			--         Base.
	invenanimalstep		int				default(0),				-- 		   �ܰ�.
	invencustommax		int				default(15),			-- �Һ��κ�����	(����, �α��� �κе� �����ؾ���.)
	invencustombase		int				default(15),			-- 		   Base
	invencustomstep		int				default(0),				-- 		   �ܰ�
	invenaccmax			int				default(6),				-- �Ǽ��κ�����	(����, �α��� �κе� �����ؾ���.)
	invenaccbase		int				default(6),				-- 		   Base
	invenaccstep		int				default(0),				-- 		   �ܰ�
	invenstemcellmax	int				default(50),			-- �ٱ⼼���κ�Max
	invenstemcellbase	int				default(50),			-- 		   Base
	invenstemcellstep	int				default(0),				-- 		   �ܰ�
	inventreasuremax	int				default(50),			-- �����κ�Max
	inventreasurebase	int				default(50),			-- 	   Base
	inventreasurestep	int				default(0),				-- 	   �ܰ�
	tempitemcode		int				default(-1),			-- �ӽþ����� (-1 : �������, > 0 : Ư�������� �ڵ�) > ���ΰŷ��� ȹ�� : Ȯ���˾� > Yes / No
	tempcnt				int				default(0),				-- �ӽþ����۰���

	--(SMS)
	smssendcnt	int						default(0), 			-- SMS�߼�
	smsjoincnt	int						default(0), 			-- SMS��õ�� ��������ī����

	--(���̹��Ӵ�)
	cashcost	int						default(5),				-- 500ĳ��
	gamecost	int						default(100),			-- ���ӸӴ�
	feed		int						default(20),			-- ����
	feedmax		int						default(20),			-- ����Max. ���� ���Žÿ��� �ʰ��� �� ����.
	fpoint		int						default(100),			-- ��������Ʈ.
	fpointmax	int						default(500),			-- 99�������� ����.
	fmonth		int						default(0),				-- ��������Ʈ ����Ѵ�(�ߺ�������).
	cashpoint	int						default(0),				-- ĳ�� ���ų���.
	goldticket		int					default(40),			-- Ȳ��Ƽ��
	goldticketmax	int					default(40),			--
	goldtickettime	datetime			default(getdate()),		--
	battleticket		int				default(40),			-- ��ƲƼ��
	battleticketmax		int				default(40),			--
	battletickettime	datetime		default(getdate()),		--

	-- �����Ʋ����.
	battlefarmidx		int				default(6900),			-- ������ Ŭ�����ߴ°�?
	battleanilistidx1	int				default(-1),			-- ���õ� ���� �ε��� 1 ~ 5
	battleanilistidx2	int				default(-1),
	battleanilistidx3	int				default(-1),
	battleanilistidx4	int				default(-1),
	battleanilistidx5	int				default(-1),
	battleflag			int				default(0),				-- ��Ʋ�÷��� (0)������, (1)������.

	-- ������Ʋ����.
	userbattleanilistidx1	int			default(-1),			-- ���õ� ���� �ε��� 1 ~ 5
	userbattleanilistidx2	int			default(-1),
	userbattleanilistidx3	int			default(-1),
	userbattleflag			int			default(0),				-- ��Ʋ�÷��� (0)������, (1)������.
	userbattleresult		int			default(0),
	userbattlepoint			int			default(0),

	-- ������Ʋ�� ȹ���� �ڽ�����.
	trophy				int				default(0),				-- Ʈ��������.
	tier				int				default(1),				--
	trophybest			int				default(0),				--
	boxrotidx			int				default(-4),			-- �ڽ� �����̼� ��ȣ.
	boxslot1			int				default(-1),			--
	boxslot2			int				default(-1),			--
	boxslot3			int				default(-1),			--
	boxslot4			int				default(-1),			--
	boxslotidx			int				default(-1),			-- �ڽ� ������ �۵��Ǵ� ��ȣ (-1)���۵�, 1~ 4�۵���ȣ.
	boxslottime			datetime		default(getdate()),		-- �ڽ� ���� �ϷΌ���ð�.

	--(��Ʈ)
	heart		int						default(120),			-- ��Ʈ(�۹� > ��Ȯ 100��Ʈ, ģ����õ > 5��Ʈ)
	heartmax	int						default(500),			-- ��Ʈ�ƽ�
	heartget	int						default(0),				-- ��Ʈ��������(ģ������, ����)
	heartsenddate	datetime			default(getdate() - 1),	-- ��Ʈ�⼮��
	heartsendcnt	int					default(0),				-- ��Ʈ 1�� ����.

	-- ��������.
	anibuydate		datetime			default(getdate() - 1),	-- ���� 1��.
	anibuycnt		int					default(0),				-- ���� 1�� ����.

	-- (�̱�(�ߺ����Ź���))
	randserial	varchar(20)				default('-1'),			--��Ű��, �̱�, �ռ��� ������ ������ ����������
	sid			int						default(0),				-- ���� ���ǹ�ȣ.
	bgroul1		int						default(-1),			-- ������ ������ �ӽ������ϴ°�.
	bgroul2		int						default(-1),
	bgroul3		int						default(-1),
	bgroul4		int						default(-1),
	bgroul5		int						default(-1),
	bgroul6		int						default(-1),
	bgroul7		int						default(-1),
	bgroul8		int		 				default(-1),
	bgroul9		int						default(-1),
	bgroul10	int						default(-1),
	bgroul11	int						default(-1),
	bgroul12	int						default(-1),
	bgroul13	int						default(-1),
	bgroul14	int						default(-1),
	bgroul15	int						default(-1),
	bgroul16	int						default(-1),
	bgroul17	int						default(-1),
	bgroul18	int		 				default(-1),
	bgroul19	int						default(-1),
	bgroul20	int						default(-1),

	-- �����̱�.
	anigrade1cnt	int					default(0),				--
	anigrade2cnt	int					default(0),				--  B, A
	anigrade4cnt	int					default(0),				--  A, S(10 + 1)
	anigrade2gauage	int					default(0),				-- �����̾� ������ B, A.
	anigrade4gauage	int					default(0),				--          ������ A, S(10 + 1)

	-- �����̱�.
	tsgrade1cnt	int						default(0),				-- �Ϲ�     �̱� Ƚ�� D, C
	tsgrade2cnt	int						default(0),				-- �����̾� �̱� Ƚ�� B, A
	tsgrade4cnt	int						default(0),				--          �̱� Ƚ�� A, S(10 + 1)
	tsgrade2gauage	int					default(0),				-- �����̾� ������ B, A.
	tsgrade4gauage	int					default(0),				--          ������ A, S(10 + 1)
	tsupgraderesult	int					default(0),				-- ���. 0����, 1����
	tsupcnt		int						default(0),				-- ����������ȭȽ��(109).
	tslistidx1	int						default(-1),			-- ��������Ʈ ��ȣ.
	tslistidx2	int						default(-1),			--
	tslistidx3	int						default(-1),			--
	tslistidx4	int						default(-1),			--
	tslistidx5	int						default(-1),			--
	tsskillcashcost	int					default(0),				-- ��������ȿ�� ������(50)
	tsskillheart	int					default(0),				-- 				��Ʈ����(51).
	tsskillgamecost	int					default(0),				-- 				���λ���(52).
	tsskillfpoint	int					default(0),				-- 				��������(53).
	tsskillrebirth	int					default(0),				-- 				��Ȱ����(54).
	tsskillalba		int					default(0),				-- 				�˹ٻ���(55).
	tsskillbullet	int					default(0),				-- 				Ư��ź ����(56).
	tsskillvaccine	int					default(0),				-- 				���۹�Ż���(57)
	tsskillfeed		int					default(0),				-- 				���ʻ���(58)
	tsskillbooster	int					default(0),				-- 				Ư������������(59)
	tsskillbottlelittle	int				default(0),				-- ��������ȿ�� �絿���� ũ�⸦ �÷��ش�(25)

	-- ����.
	apartbuycnt		int					default(0),				-- ����, �����߿� ����(1), ����(17)�� 1500�� ���̸� ������ ���´�.

	-- ��Ʋ����, ��ȭ
	bgbattlecnt		int					default(0),				-- ������Ʋ����().
	bganiupcnt		int					default(0),				-- ����������ȭ(107).
	anifirstfullupreward	int			default(0),				-- ���� ��ȭ Ǯ�� ��������(0), ����(1)

	trade0		tinyint					default(0),
	trade1		tinyint					default(1),
	trade2		tinyint					default(2),
	trade3		tinyint					default(3),
	trade4		tinyint					default(4),
	trade5		tinyint					default(5),
	trade6		tinyint					default(6),
	tradedummy	tinyint					default(0),				-- ���̰���.

	-- �ռ�, �±�.
	bgcomposeic	int						default(-1),			-- �ռ��� ������ �������ڵ尪
	bgcomposert	int						default(0),				-- �ռ� ����(0), ����(1)
	bgcomposewt	datetime				default(getdate()), 	-- �ռ��� �����ð�.
	bgcomposecc	int						default(0),				-- �ռ� �ʱ�ȭ ���.
	bgpromoteic	int						default(-1),			-- �±� ������ �������ڵ尪

	bgacc1listidx	int					default(-1),
	bgacc2listidx	int					default(-1),
	bgacc1listidxdel	int				default(-1),
	bgacc2listidxdel	int				default(-1),

	-- (�Ǽ�4��)
	acc1		int						default(-1),			--�Ǽ�1(-1:���, �������ڵ�)
	acc2		int						default(-1),			--�Ǽ�2(-1:���, �������ڵ�)
	acc3		int						default(-1),			--�Ǽ�3(-1:���, �������ڵ�)
	acc4		int						default(-1),			--�Ǽ�4(-1:���, �������ڵ�)

	--(�Ҹ�����Ҹ�4��)
	bulletlistidx	int					default(-1),			-- �Ѿ�(-1:���, �������ڵ�)
	vaccinelistidx	int					default(-1),			-- ���(-1:���, �������ڵ�)
	boosterlistidx	int					default(-1),			-- ������(�ν���)(-1:���, �������ڵ�)
	albalistidx		int					default(-1),			-- �˹�(-1:���, �������ڵ�)
	--bulletcnt		int					default(0),				--     (��������)
	--vaccinecnt	int					default(0),				--     (��������)
	--boostercnt	int					default(0),				--     (��������)
	--albacnt		int					default(0),				--     (��������)
	boosteruse		int					default(-1),			-- ��������뿩��(-1:�̻��, 1:�������ڵ��ȣ)
	albause			int					default(-1),			-- �˹�����뿩��(-1:�̻��, 1:�������ڵ��ȣ)
	albausesecond	int					default(-1),			--
	albausethird	int					default(-1),			--
	wolfappear		int					default(-1),			-- �������翩��(-1:������, 1����)

	--(�⺻����4)
	bottlelittle	int					default(0),				--[�絿��] ������ �Ѹ���
	bottlefresh		int					default(0),				--         ���� �ѽż���
	tanklittle		int					default(0),				--[��ũ] ������ �Ѹ���
	tankfresh		int					default(0),				--       ���� �ѽż���

	--(�ü�����)
	housestep		int					default(0),				--��
	housestate		int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	housetime		datetime			default(getdate()),		--�����ܰ�ð�
	tankstep		int					default(0),				--������ũ
	tankstate		int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	tanktime		datetime			default(getdate()),		--�����ܰ�ð�
	bottlestep		int					default(0),				--�絿��
	bottlestate		int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	bottletime		datetime			default(getdate()),		--�����ܰ�ð�
	pumpstep		int					default(0),				--������
	pumpstate		int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	pumptime		datetime			default(getdate()),		--�����ܰ�ð�
	transferstep	int					default(0),				--���Ա�
	transferstate	int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	transfertime	datetime			default(getdate()),		--�����ܰ�ð�
	purestep		int					default(0),				--��ȭ�ü�
	purestate		int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	puretime		datetime			default(getdate()),		--�����ܰ�ð�
	freshcoolstep	int					default(0),				--���º���
	freshcoolstate	int					default(-1),			--�����ܰ����࿩��(-1:������, �Ϸ���, 1:�����ܰ�������)
	freshcooltime	datetime			default(getdate()),		--�����ܰ�ð�

	-- �б⺰ �ڷ�.
	qtsalebarrel	int					default(0),
	qtsalecoin		int					default(0),
	qtfame			int					default(0),
	qtfeeduse		int					default(0),
	qttradecnt		int					default(0),
	qtsalecoinbest	int					default(0),

	--(������) > Ŭ���̾�Ʈ �ʿ信 ���� ������.
																-- ���׷��̵� 	> �α���.
																-- ȹ�浿��		> ����.
	bktwolfkillcnt	int					default(0),				-- ������������.
	bktsalecoin		int					default(0),				-- �����Ǹűݾ�.
	bkheart			int					default(0),				-- ������Ʈȹ��
	bkfeed			int					default(0),				-- ��������ȹ��
	bkbarrel		int					default(0),				-- �����跲.
	bktsuccesscnt	int					default(0),				-- ���Ӽ���Ƚ��
	bktbestfresh	int					default(0),				-- �ְ�ż���
	bktbestbarrel	int					default(0),				-- �ְ�跲
	bktbestcoin		int					default(0),				-- �ְ��Ǹűݾ�
	bkcrossnormal	int					default(0),				-- �����Ϲݱ���
	bkcrosspremium	int					default(0),				-- ���������̾�����
	bktsgrade1cnt	int					default(0),				-- �ӽ��Ϲݺ����̱�(23).
	bktsgrade2cnt	int					default(0),				-- �ӽ����������̱�(24).
	bktsupcnt		int					default(0),				-- �ӽú�����ȭȽ��(25).
	bkbattlecnt		int					default(0),				-- �ӽù�Ʋ����Ƚ��(26).
	bkaniupcnt		int					default(0),				-- �ӽõ�����ȭ(27).
	bkapartani		int					default(0),				-- �ӽõ�������(28).
	bkapartts		int					default(0),				-- �ӽú�������(29).
	bkcomposecnt	int					default(0),				-- �ӽõ����ռ�(20).
	bkpromotecnt	int					default(0),				-- �ӽõ����±�(20).

	--(��Ÿ����)
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

	-- �б�������.
	schoolidx			int				default(-1),		-- ������ ������ȣ.
															-- �����ð��� ���� �Ͽ��� ���� 11.59��.
	schoolresult		int				default(-1),		--  1: �о��   > �����ֻ�. ,
															-- -1: �о	> ���� �Ⱥ����൵��.

	-- (��ŷ����� ����Ÿ) > ������ ���� ���ؼ� ������.
	ttsalecoin		int					default(0),				-- �����Ǹűݾ�. (���ְ����� �Ǵϱ� �ε��� �Ȱɾ���)
	ttsalecoinbkup	bigint				default(0),				-- �����Ǹűݾ׹��(�����쿡 ���ؼ����).

	lmsalecoin		int					default(0),				-- ���� ������.
	lmrank			int					default(1),				-- ���� ���� ����.
	lmcnt			int					default(1),				-- ���� ���� ģ����.

	l1gameid		varchar(20)			default(''),			-- ���� 1�� ģ��.
	l1itemcode		int					default(1),				-- 			��ǥ ����.
	l1acc1			int					default(-1),			-- 			��ǥ �Ǽ�.
	l1acc2			int					default(-1),			-- 			��ǥ �Ǽ�.
	l1salecoin		int					default(0),				-- 			����.
	l1kakaonickname	varchar(40)			default(''),			--          �г���
	l1kakaoprofile	varchar(512)		default(''),			--          ����
	l2gameid		varchar(20)			default(''),			-- ���� 2�� ģ��.
	l2itemcode		int					default(1),				-- 			��ǥ ����.
	l2acc1			int					default(-1),			-- 			��ǥ �Ǽ�.
	l2acc2			int					default(-1),			-- 			��ǥ �Ǽ�.
	l2salecoin		int					default(0),				-- 			����.
	l2kakaonickname	varchar(40)			default(''),			--          �г���
	l2kakaoprofile	varchar(512)		default(''),			--          ����
	l3gameid		varchar(20)			default(''),			-- ���� 3�� ģ��.
	l3itemcode		int					default(1),				-- 			��ǥ ����.
	l3acc1			int					default(-1),			-- 			��ǥ �Ǽ�.
	l3acc2			int					default(-1),			-- 			��ǥ �Ǽ�.
	l3salecoin		int					default(0),				-- 			����.
	l3kakaonickname	varchar(40)			default(''),			--          �г���
	l3kakaoprofile	varchar(512)		default(''),			--          ����

	-- �������.
	etsalecoin		int					default(0),				-- ���Ǽҵ� �����Ǹűݾ�.
	etremain		int					default(-1),			--	        �����ð�.

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

	-- ���� ��������.
																-- �Ϲ� ���� Ƚ��(������).
																-- �����̾� ���� Ƚ��(������).
	bgtradecnt		int					default(0),				-- �ŷ� ���� ���� Ƚ��.
	bgcttradecnt	int					default(0),				-- �ŷ�����Ƚ��.
	bgcomposecnt 	int					default(0),				-- �ռ� ���μ� ����.(n/100)
	bgpromotecnt	int					default(0),				-- �±� Ƚ��.

	-- �������
	yabauidx		int					default(1),				-- ����� �� ����.
	yabaustep		int					default(0),				--
	yabaunum		int					default(0),				--
	yabauresult		int					default(0),				-- �ֻ��� ���. 0����, 1����
	yabaucount		int					default(0),				-- ��������Ʈ��.

	-- ȸ���� ����.
	wheeltodaydate	datetime			default(getdate() - 1),	-- ������ 1��.
	wheeltodaycnt	int					default(0),				-- ���ù���귿 ����Ƚ�� 0�̸� ������ ����
	wheelgauage		int					default(0),				-- ȸ����(��������)
	wheelfree		int					default(0),				-- 1�̸� ����ȸ��.
	bkwheelcnt		int					default(0),				-- ��ü �귿 Ƚ��.

	-- ��ŷ Ȧ¦��.
	rkstartstate	int					default(0),				-- ��ŷ���� �������� ������(0), ����(1) -> �̹��ֿ� �귿 �ѹ��� ������ȴ�.
	rkstartdate		datetime			default(getdate()),		-- ��ŷ���� ������.
	rkteam			int					default(-1),			-- 1Ȧ, 2¦
	rksalemoney		bigint				default(0),				-- �Ǹż���(0).
	rksalebarrel	bigint				default(0),				-- ����跲(30).
	rkbattlecnt		bigint				default(0),				-- ��ƲȽ��(31).
	rkbogicnt		bigint				default(0),				-- ��������,�����̱�(32).
	rkfriendpoint	bigint				default(0),				-- ģ������Ʈ(�ڵ�����).
	rkroulettecnt	bigint				default(0),				-- �귿Ƚ��(20, 21).
	rkwolfcnt		bigint				default(0),				-- �������(33).
	rktotal			bigint				default(0),				-- > ��ŷ������ �������� �����ؼ� ����(������ ���Ȱ���)
	rksalemoneybk	bigint				default(0),				-- ���
	rksalebarrelbk	bigint				default(0),
	rkbattlecntbk	bigint				default(0),
	rkbogicntbk		bigint				default(0),
	rkfriendpointbk	bigint				default(0),
	rkroulettecntbk	bigint				default(0),
	rkwolfcntbk		bigint				default(0),
	rktotalbk		bigint				default(0),

	-- ¥������.
	salefresh		int					default(0),				-- �ŷ��ż���
	zcpplus			int					default(0),				-- Ȯ����°�
	zcpchance		int					default(-1),			-- ¥���������� ��ȸ
	zcpappearcnt	int					default(0),				-- 1�� ����Ƚ��.(�α��ζ� ���� �ٲ�� �ʱ�ȭ��)
	bkzcpcntfree	int					default(0),				-- ���ᵹ��Ƚ��.
	bkzcpcntcash	int					default(0),				-- ���ᵹ��Ƚ��.

	-- �������.
	phone2			varchar(20)			default(''),			-- phone2 ������ �Է��� ��ȣ
																-- phone  �ý����� �����̰�,
	zipcode			varchar(6)			default(''),									-- �����ȣ.
	address1		varchar(256)		default(''),
	address2		varchar(256)		default(''),

	-- Constraint
	CONSTRAINT pk_tUserMaster_gameid	PRIMARY KEY(gameid)
)
GO
-- alter table dbo.tUserMaster add randserial			varchar(20)		default('-1')
-- alter table dbo.tUserMaster add invenanimalstep		int				default(0)
-- alter table dbo.tUserMaster add invencustomstep		int				default(0)
-- alter table dbo.tUserMaster add invenaccstep			int				default(0)
-- alter table dbo.tUserMaster add feedmax		int						default(10)
-- ����Ÿ 10���� ������ �־ �����غ���(���ID�� ���� ������ �Է��Ѵ�.)
-- ���Խ� gameid ���� > PRIMARY KEY(gameid) > �ε���



-- ���ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_phone_deletestate')
    DROP INDEX tUserMaster.idx_tUserMaster_phone_deletestate
GO
CREATE INDEX idx_tUserMaster_phone_deletestate ON tUserMaster (phone, deletestate)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_idx')
   DROP INDEX tUserMaster.idx_tUserMaster_idx
GO
CREATE INDEX idx_tUserMaster_idx ON tUserMaster (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_kakaonickname')
   DROP INDEX tUserMaster.idx_tUserMaster_kakaonickname
GO
CREATE INDEX idx_tUserMaster_kakaonickname ON tUserMaster (kakaonickname)
GO

-- īī��ȸ����ȣ �ε���.
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_kakaouserid')
   DROP INDEX tUserMaster.idx_tUserMaster_kakaouserid
GO
CREATE INDEX idx_tUserMaster_kakaouserid ON tUserMaster (kakaouserid)
GO

-- īī�����Ӿ��̵� �ε���.
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_kakaogameid')
   DROP INDEX tUserMaster.idx_tUserMaster_kakaogameid
GO
CREATE INDEX idx_tUserMaster_kakaogameid ON tUserMaster (kakaogameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_kakaotalkid')
   DROP INDEX tUserMaster.idx_tUserMaster_kakaotalkid
GO
CREATE INDEX idx_tUserMaster_kakaotalkid ON tUserMaster (kakaotalkid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_ttsalecoin')
   DROP INDEX tUserMaster.idx_tUserMaster_ttsalecoin
GO
CREATE INDEX idx_tUserMaster_ttsalecoin ON tUserMaster (ttsalecoin)
GO

--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_pushid')
--    DROP INDEX tUserMaster.idx_tUserMaster_pushid
--GO
--CREATE INDEX idx_tUserMaster_pushid ON tUserMaster (pushid)
--GO

-- insert into dbo.tUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
-- select * from dbo.tUserMaster where gameid = 'xxxx' and password = 'pppp'
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

	expirekind		int					default(-1),				-- ������ X(-1), O(1).
	expiredate		smalldatetime,									-- ������.

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
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 0, 1, 1, 0, 0, 1, 1001) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 1, 1, 1, 0, 1, 1, 1002) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 2, 1, 1, 0, 2, 1, 1003) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 3, 1, 1, 0, 3, 1, 1004) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 4, 1, 1, 0, 4, 1, 1005) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 5, 1, 1, 0, 5, 1, 1006) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 6, 1, 1, 0, 6, 1, 1007) -- ����
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 10, 700, 5, 0, 0, 3, 1010) -- �Ҹ�
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

	randserial		varchar(20)			default(-1),				--����������(Ŭ���̾�Ʈ���� ������)
	writedate		datetime			default(getdate()),			--������/ȹ����
	gethow			int					default(0),					--ȹ����(0:����, 1:����, 2:����/�̱�, 3:�˻�)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:�ƴ�, 1:����,����, 2:����
	needhelpcnt		int					default(0),					-- ������ ������ �ڵ� ��Ȱ������ ���ȴ�.(��Ȱ�� ������ŭ)

	petupgrade		int					default(1),					-- ����׷��̵� �ϱ�.
	treasureupgrade	int					default(0),					-- �������׷��̵� �ϱ�.

	expirekind		int					default(-1),				-- ������ X(-1), O(1).
	expiredate		smalldatetime,									-- ������.

	idx2			int,
	writedate2		datetime			default(getdate()),			--������.
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
--		��������
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserGameMTBaseball', N'U') IS NOT NULL
	DROP TABLE dbo.tUserGameMTBaseball;
GO

create table dbo.tUserGameMTBaseball(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	farmidx			int,											-- �����ȣ
	itemcode		int,											-- �������ڵ�
	incomedate		datetime			default(getdate()),			-- ȸ����.
	incomett		int					default(0),
	buycount		int					default(0),
	star			int					default(0),
	playcnt			int					default(10),				-- �÷��� �Ҽ� �ִ� Ƚ��.
																	-- 5�� ��...
																	-- 10�� 40�� 10�̴ϱ� ����..
																	-- 6�� ���?������...

	buystate 		int					default(-1),				-- �񱸸�(-1), ������(1)
	buydate			datetime			default(getdate()),			-- ������.
	buywhere		int					default(1),					-- 1 ��������, 2 ���Ǽҵ�

	-- Constraint
	CONSTRAINT	pk_tUserGameMTBaseball_gameid_farmidx	PRIMARY KEY(gameid, farmidx)
)
--
-- �̸̹���������� Ŀ���� ���鼭 �Է��ϱ�.
-- insert into dbo.tUserGameMTBaseball(gameid, farmidx) select 'xxxx2', itemcode from dbo.tItemInfo where subcategory = 69 order by itemcode asc
-- select * from dbo.tUserGameMTBaseball where gameid = 'xxxx2' order by farmidx asc
-- update dbo.tUserGameMTBaseball set buystate =  1 where gameid = 'xxxx2' and farmidx = 6900				-- ����
-- update dbo.tUserGameMTBaseball set buystate = -1 where gameid = 'xxxx2' and farmidx = 6900				-- �Ǹ�
-- update dbo.tUserGameMTBaseball set incomedate = getdate(), incomett = incomett + 100 where gameid = 'xxxx2' and farmidx = 6900	-- ����
--                   DATEDIFF(datepart , @incomedate , getdate() )
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 11:00') -- -60	> -1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 12:59') -- +59	> 0
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:00') -- +60	> 1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:01') -- +61	> 1
-- select max(idx) from dbo.tUserGameMTBaseball
--select a.*, b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
--	from dbo.tUserGameMTBaseball a
--	LEFT JOIN
--	(select * from dbo.tItemInfo where subcategory = 69) b
--	ON a.farmidx = b.itemcode
--where gameid = 'xxxx2' order by farmidx asc

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
-- select top 1 * from dbo.tUserPhone



---------------------------------------------
--		�����ߴ� �α�(����)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLog;
GO

create table dbo.tUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- ��ȣ
	idx2		int,

	gameid		varchar(20), 										-- ����id
	itemcode	int, 												-- �������ڵ�, �ߺ� ���ű���Ѵ�.
	buydate2	varchar(8),											-- ������20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- ���Ű���(�����Ҽ��־)
	gamecost	int					default(0),
	heart		int					default(0),
	buydate		datetime			default(getdate()), 			-- ������

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tUserItemBuyLog
--select top 20 * from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'Marbles' order by a.idx desc
--select top 20 * from dbo.tUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 5,  0)
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 0, 50)
--���� �ε���
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_buydate')
--    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_buydate
--GO
--CREATE INDEX idx_tUserItemBuyLog_buydate ON tUserItemBuyLog (buydate)
--GO

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
	gamecost		bigint			default(0),
	heart		int					default(0),
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
--		cashcost = cashcost + 1,
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
	gamecost		int				default(0),
	heart		int					default(0),
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
--		cashcost = cashcost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, gamecost, cnt) values('20120818', 1, 100, 0, 1)


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
	gamecost		bigint			default(0),
	heart		int					default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tUserItemBuyLogMonth(dateid6, itemcode, gamecost, cashcost, cnt) values('201309', 1, 100, 0, 1)
--update dbo.tUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1



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
--		���Ǽҵ� ����(��ϵȰ��� ���� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tEpiReward', N'U') IS NOT NULL
	DROP TABLE dbo.tEpiReward;
GO

create table dbo.tEpiReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,

	etyear			int,
	etsalecoin		int 			default(0),
	etcheckvalue1	int 			default(-1),
	etcheckvalue2	int 			default(-1),
	etcheckvalue3	int 			default(-1),

	etcheckresult1	int				default(0),
	etcheckresult2	int				default(0),
	etcheckresult3	int				default(0),

	etgrade			int				default(0),
	etreward1		int				default(-1),
	etreward2		int				default(-1),
	etreward3		int				default(-1),
	etreward4		int				default(-1),

	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tEpiReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEpiReward_gameid_etyear')
	DROP INDEX tEpiReward.idx_tEpiReward_gameid_etyear
GO
CREATE INDEX idx_tEpiReward_gameid_etyear ON tEpiReward (gameid, etyear)
GO

--if(not exists(select top 1 * from dbo.tEpiReward where gameid = 'xxxx2' and etyear = 2018))
--	begin
--		insert into dbo.tEpiReward(gameid, itemcode, etyear, etsalecoin, etgrade, etreward1, etreward2, etreward3, etreward4) values('xxxx2', 91000, 2018, 1000, 0, -1, -1, -1, -1)
--	end
--select * from dbo.tEpiReward where gameid = 'xxxx2' order by itemcode asc

---------------------------------------------
--	Ʃ�丮��(�߰��߰�) ��� ����(��ϵȰ��� ���� ������)
---------------------------------------------
IF OBJECT_ID (N'dbo.tTutoStep', N'U') IS NOT NULL
	DROP TABLE dbo.tTutoStep;
GO

create table dbo.tTutoStep(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),
	ispass			int				default(-1),

	gameyear		int,
	gamemonth		int,
	famelv			int,

	-- Constraint
	CONSTRAINT pk_tTutoStep_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTutoStep_gameid_itemcode')
	DROP INDEX tTutoStep.idx_tTutoStep_gameid_itemcode
GO
CREATE INDEX idx_tTutoStep_gameid_itemcode ON tTutoStep (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tTutoStep where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tTutoStep(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tTutoStep where gameid = 'xxxx' order by itemcode asc

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
--	Android Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushAndroidLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushAndroidLog;
GO

create table dbo.tUserPushAndroidLog(
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
	CONSTRAINT	pk_tUserPushAndroidLog_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tUserPushAndroidLog

-----------------------------------------------
---- Android Push > ���� > ���ο��� ����.
-----------------------------------------------
-- exec spu_DayLogInfoStatic 1, 50, 10				-- �� push android
-- exec spu_DayLogInfoStatic 1, 51, 1				-- �� push iphone
--
--IF OBJECT_ID (N'dbo.tUserPushAndroidTotal', N'U') IS NOT NULL
--	DROP TABLE dbo.tUserPushAndroidTotal;
--GO
--
--create table dbo.tUserPushAndroidTotal(
--	idx				int				identity(1, 1),
--
--	dateid			char(8),							-- 20101210
--	cnt				int				default(1),
--
--	-- Constraint
--	CONSTRAINT	pk_tUserPushAndroidTotal_dateid	PRIMARY KEY(dateid)
--)
---- select top 100 * from dbo.tUserPushAndroidTotal order by dateid desc
---- select top 100 * from dbo.tUserPushAndroidTotal where dateid = '20121129' order by dateid desc
----update dbo.tUserPushAndroidTotal
----	set
----		cnt = cnt + 1
----where dateid = '20120818'
---- insert into dbo.tUserPushAndroidTotal(dateid, cnt) values('20120818', 1)

---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhone;
GO

create table dbo.tUserPushiPhone(
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
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tUserPushAndroidLog
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
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tUserPushiPhoneLog

---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushSendInfo;
GO

create table dbo.tUserPushSendInfo(
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
	CONSTRAINT	pk_tUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tUserPushSendInfo order by idx desc
-- insert into dbo.tUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tUserPushiPhone
-- select max(idx), min(idx) from dbo.tUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tUserPushAndroid
-- select top 10 * from dbo.tUserPushiPhone where msgtitle = '���� iPhone'
-- select top 10 * from dbo.tUserPushAndroid where msgtitle = '���� Google'
-- ����
-- delete from dbo.tUserPushiPhone  where msgtitle = '���� iPhone'
-- delete from dbo.tUserPushAndroid where msgtitle = '���� Google'
-- delete from dbo.tUserPushiPhone  where msgtitle = (select msgtitle from dbo.tUserPushSendInfo where idx = 1)
-- delete from dbo.tUserPushAndroid  where msgtitle = (select msgtitle from dbo.tUserPushSendInfo where idx = 1)


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
-- 	���� �α� > �����ڷ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogPerson;
GO

create table dbo.tTreasureLogPerson(
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
	CONSTRAINT	pk_tTreasureLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTreasureLogPerson_gameid_idx')
	DROP INDEX tTreasureLogPerson.idx_tTreasureLogPerson_gameid_idx
GO
CREATE INDEX idx_tTreasureLogPerson_gameid_idx ON tTreasureLogPerson (gameid, idx)
GO


---------------------------------------------
-- 	���� �α�(���� Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogTotalMaster;
GO

create table dbo.tTreasureLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),
	acccnt			int				default(0),			-- �Ǽ��縮�α�.

	-- Constraint
	CONSTRAINT	pk_tTreasureLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)


---------------------------------------------
-- 	���� �α�(���� Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogTotalSub;
GO

create table dbo.tTreasureLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tTreasureLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)

---------------------------------------------
-- 	�귿 �α� > ����� �α�.
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserAdLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserAdLog;
GO

create table dbo.tUserAdLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	nickname		varchar(40),
	itemcode		int,
	comment			varchar(128)	default(''),
	mode			int				default(1),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserAdLog_idx PRIMARY KEY(idx)
)
-- insert into dbo.tUserAdLog(gameid, itemcode, comment) values('xxxx2', 101, 'xxxx2���� ���� ����� ������ϴ�.')
-- delete from dbo.tUserAdLog where idx = @idx - 100
-- update dbo.tUserAdLog set adidx = @idx where gameid = @gameid_
-- select top 100 * from dbo.tUserAdLog where gameid = 'xxxx2' order by idx desc

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
--	ģ����ŷ[��������췯]
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tUserMasterSchedule;
GO

create table dbo.tUserMasterSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tUserMasterSchedule
-- if(not exist(select dateid from dbo.tUserMasterSchedule where dateid = '20131227'))
-- 		insert into dbo.tUserMasterSchedule(dateid, idxStart) values('20131227', 1)
-- update tUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'

---------------------------------------------
--		�б������� ���.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolResult', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolResult;
GO

create table dbo.tSchoolResult(
	idx						int					IDENTITY(1,1),

	schoolresult			int					default(0),
	writedate				datetime			default(getdate()),


	-- Constraint
	CONSTRAINT	pk_tSchoolResult_schoolresult	PRIMARY KEY(schoolresult)
)

-- insert into dbo.tSchoolResult(schoolresult) values(1)
-- select * from dbo.tSchoolResult order by schoolresult desc
-- select top 1 schoolresult from dbo.tSchoolResult order by schoolresult desc
-- insert into dbo.tSchoolResult(schoolresult)
-- select top 1 (isnull(schoolresult, 0) + 1) from dbo.tSchoolResult order by schoolresult desc


---------------------------------------------
--		�б�����[�б�]
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolMaster;
GO

create table dbo.tSchoolMaster(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	cnt						int					default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),
	schoolrank				int					default(-1),

	backcnt					int					default(1),
	backtotalpoint			bigint				default(0),
	backschoolrank			int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tSchoolMaster_schoolidx	PRIMARY KEY(schoolidx)
)
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolMaster_totalpoint')
    DROP INDEX tSchoolMaster.idx_tSchoolMaster_totalpoint
GO
CREATE INDEX idx_tSchoolMaster_totalpoint ON tSchoolMaster (totalpoint desc)
GO

-- insert into dbo.tSchoolMaster(schoolidx) values(2)
-- select top 1 * from dbo.tSchoolMaster where schoolidx = 2
-- update dbo.tSchoolMaster set cnt = cnt + 1 where schoolidx = 2
-- update dbo.tSchoolMaster set totalpoint = totalpoint + 10 where schoolidx = 2
-- select top 10 rank() over(order by totalpoint desc) as rank, schoolidx, cnt, totalpoint from dbo.tSchoolMaster

---------------------------------------------
--		�б�����[����]
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolUser', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolUser;
GO

create table dbo.tSchoolUser(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	gameid					varchar(20),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),	--���ʰ�����, ������

	schoolrank				int					default(-1),
	userrank				int					default(-1),
	itemcode 				int					default(1),
	acc1	 				int					default(-1),
	acc2 					int					default(-1),
	itemcode1 				int					default(-1),
	itemcode2 				int					default(-1),
	itemcode3 				int					default(-1),

	backdateid				varchar(8)			default('20100101'),
	backschoolidx			int					default(-1),
	backschoolrank			int					default(-1),
	backuserrank			int					default(-1),
	backpoint				bigint				default(0),
	backitemcode			int					default(1),
	backacc1				int					default(-1),
	backacc2 				int					default(-1),
	backitemcode1			int					default(-1),
	backitemcode2			int					default(-1),
	backitemcode3			int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tSchoolUser_gameid	PRIMARY KEY(gameid)
)

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolUser_schoolidx_point')
    DROP INDEX tSchoolUser.idx_tSchoolUser_schoolidx_point
GO
CREATE INDEX idx_tSchoolUser_schoolidx_point ON tSchoolUser (schoolidx, point desc)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolUser_joindate')
    DROP INDEX tSchoolUser.idx_tSchoolUser_joindate
GO
CREATE INDEX idx_tSchoolUser_joindate ON tSchoolUser (joindate)
GO

-- select top 1 * from dbo.tSchoolUser where gameid = 'xxxx2'
-- delete from dbo.tSchoolUser where gameid = 'xxxx2'
-- insert into dbo.tSchoolUser(schoolidx, gameid) values(1, 'xxxx2')
-- update dbo.tSchoolUser set point = point + 10 where gameid = 'xxxx2'
-- select top 10 rank() over(order by point desc) as rank, schoolidx, gameid, point from dbo.tSchoolUser where schoolidx = 1



---------------------------------------------
--	�б�����[��������췯]
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolSchedule;
GO

create table dbo.tSchoolSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tSchoolSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tSchoolSchedule
-- if(not exist(select dateid from dbo.tSchoolSchedule where dateid = '20131227'))
-- 		insert into dbo.tSchoolSchedule(dateid, step) values('20131227', 1)
-- update tSchoolSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'


---------------------------------------------
--		�б�����[�б����]
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolBackMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolBackMaster;
GO

create table dbo.tSchoolBackMaster(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,

	schoolidx				int,
	cnt						int 				default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128)

	-- Constraint
	CONSTRAINT	pk_tSchoolBackMaster_idx		PRIMARY KEY(idx)
)
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolBackMaster_dateid_schoolrank')
    DROP INDEX tSchoolBackMaster.idx_tSchoolBackMaster_dateid_schoolrank
GO
CREATE INDEX idx_tSchoolBackMaster_dateid_schoolrank ON tSchoolBackMaster (dateid, schoolrank)
GO
-- select top 1 * from dbo.tSchoolBackMaster


---------------------------------------------
--		�б�����[�������]
---------------------------------------------
IF OBJECT_ID (N'dbo.tSchoolBackUser', N'U') IS NOT NULL
	DROP TABLE dbo.tSchoolBackUser;
GO

create table dbo.tSchoolBackUser(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,
	userrank				int,

	schoolidx				int,
	gameid					varchar(20),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128),

	itemcode 				int					default(1),
	acc1	 				int					default(-1),
	acc2 					int					default(-1),

	itemcode1 				int					default(-1),
	itemcode2 				int					default(-1),
	itemcode3 				int					default(-1)

	-- Constraint
	CONSTRAINT	pk_tSchoolBackUser_idx	PRIMARY KEY(idx)
)
-- �ε���
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolBackUser_dateid_schoolrank_userrank')
--   DROP INDEX tSchoolBackUser.idx_tSchoolBackUser_dateid_schoolrank_userrank
--GO
--CREATE INDEX idx_tSchoolBackUser_dateid_schoolrank_userrank ON tSchoolBackUser (dateid, schoolrank, userrank)
--GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolBackUser_dateid_gameid')
    DROP INDEX tSchoolBackUser.idx_tSchoolBackUser_dateid_gameid
GO
CREATE INDEX idx_tSchoolBackUser_dateid_gameid ON tSchoolBackUser (dateid, gameid)
GO
-- select top 1 * from dbo.tSchoolBackUser
-- insert into dbo.tSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 1, 1, 'xxxx2', 800, getdate())
-- insert into dbo.tSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 2, 1, 'xxxx3', 150, getdate())
-- insert into dbo.tSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 3, 1, 'xxxx4',  50, getdate())




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
--		Kakao Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tKakaoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tKakaoMaster;
GO

create table dbo.tKakaoMaster(
	idx				int					IDENTITY(1,1),

	kakaouserid		varchar(60),
	kakaotalkid		varchar(60),
	gameid			varchar(20),
	cnt				int					default(1),					-- ������
	cnt2			int					default(0),
	kakaodata		int					default(1),					-- ī������(1), �Խ�Ʈ����(1)
	writedate		datetime			default(getdate()),
	deldate			datetime			default(getdate() - 1),

	-- Constraint
	CONSTRAINT	pk_tKakaoMaster_kakaotalkid	PRIMARY KEY(kakaouserid)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tKakaoMaster_kakaotalkid')
    DROP INDEX tKakaoMaster.idx_tKakaoMaster_kakaotalkid
GO
CREATE INDEX idx_tKakaoMaster_kakaotalkid ON tKakaoMaster (kakaotalkid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tKakaoMaster_idx')
    DROP INDEX tKakaoMaster.idx_tKakaoMaster_idx
GO
CREATE INDEX idx_tKakaoMaster_idx ON tKakaoMaster (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tKakaoMaster_gameid')
    DROP INDEX tKakaoMaster.idx_tKakaoMaster_gameid
GO
CREATE INDEX idx_tKakaoMaster_gameid ON tKakaoMaster (gameid)
GO

---------------------------------------------
--		Kakao �ʴ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tKakaoInvite;
GO

create table dbo.tKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	receuuid		varchar(40),		-- <- kakaouuid�� ��.
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tKakaoInvite_gameid_receuuid')
    DROP INDEX tKakaoInvite.idx_tKakaoInvite_gameid_receuuid
GO
CREATE INDEX idx_tKakaoInvite_gameid_receuuid ON tKakaoInvite (gameid, receuuid)
GO

-- select top 1 * from dbo.tKakaoInvite where gameid = 'xxxx2' and receuuid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5����
-- insert into dbo.tKakaoInvite(gameid, receuuid) values('xxxx2', 'kakaotalkid13')
-- update dbo.tKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx2' and receuuid = 'kakaotalkid13'

---------------------------------------------
--		Kakao ������ ģ����~~~ (Wait) 24H��ȿ
---------------------------------------------
IF OBJECT_ID (N'dbo.tKakaoHelpWait', N'U') IS NOT NULL
	DROP TABLE dbo.tKakaoHelpWait;
GO

create table dbo.tKakaoHelpWait(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	friendid		varchar(20),
	listidx			int,
	helpdate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoHelpWait_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tKakaoHelpWait_gameid_friendid')
    DROP INDEX tKakaoHelpWait.idx_tKakaoHelpWait_gameid_friendid
GO
CREATE INDEX idx_tKakaoHelpWait_gameid_friendid ON tKakaoHelpWait (gameid, friendid)
GO
-- insert into dbo.tKakaoHelpWait(gameid, friendid, listidx) values( 'xxxx3', 'xxxx2', 1)
-- select * from dbo.tKakaoHelpOrder where gameid = 'xxxx3'
-- update dbo.tUserItem set helpcnt = �ż��������� 2, 3, 4, 5
-- delete from dbo.tKakaoHelpOrder where idx = 1


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

-----------------------------------------------
----		�̺�Ʈ ���� > ���̺��� �����ϹǷ� ���⼭ ��������.
-----------------------------------------------
--IF OBJECT_ID (N'dbo.tEventSub', N'U') IS NOT NULL
--	DROP TABLE dbo.tEventSub;
--GO
--
--create table dbo.tEventSub(
--	eventidx		int					IDENTITY(1,1),
--	label			varchar(20)			default(''),
--	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
--	eventitemcode	int					default(-1),
--	eventcnt		int					default(0),
--	eventsender		varchar(20)			default('¥�� �ҳ�'),
--	eventday		int					default(0),
--	eventstarthour	int					default(0),
--	eventendhour	int					default(0),
--
--	eventpushtitle	varchar(512)		default(''),				-- Ǫ�� ����, ����, ����
--	eventpushmsg	varchar(512)		default(''),				--
--	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND
--
--	writedate		datetime			default(getdate()),
--	CONSTRAINT	pk_tEventSub_eventidx	PRIMARY KEY(eventidx)
--)
--
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventSub_eventday_eventstarthour_eventendhour')
--    DROP INDEX tEventSub.idx_tEventSub_eventday_eventstarthour_eventendhour
--GO
--CREATE INDEX idx_tEventSub_eventday_eventstarthour_eventendhour ON tEventSub (eventday, eventstarthour, eventendhour)
--GO

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
--		������Ʋ ��ũ ����Ÿ.
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleBank', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleBank;
GO

create table dbo.tUserBattleBank(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid			varchar(20),
	kakaonickname	varchar(40)			default(''),
	trophy			int					default(0),
	tier			int					default(0),

	aniitemcode1	int					default(-1),
	upcnt1			int					default(0),
	attstem1		int					default(0),
	defstem1		int					default(0),
	hpstem1			int					default(0),
	timestem1		int					default(0),

	aniitemcode2	int					default(-1),
	upcnt2			int					default(0),
	attstem2		int					default(0),
	defstem2		int					default(0),
	hpstem2			int					default(0),
	timestem2		int					default(0),

	aniitemcode3	int					default(-1),
	upcnt3			int					default(0),
	attstem3		int					default(0),
	defstem3		int					default(0),
	hpstem3			int					default(0),
	timestem3		int					default(0),

	treasure1		int					default(-1),
	treasure2		int					default(-1),
	treasure3		int					default(-1),
	treasure4		int					default(-1),
	treasure5		int					default(-1),
	treasureupgrade1	int				default(0),
	treasureupgrade2	int				default(0),
	treasureupgrade3	int				default(0),
	treasureupgrade4	int				default(0),
	treasureupgrade5	int				default(0),

	writedate		datetime			default(getdate()),
	userdata		int					default(1),		--�����÷��� ����Ÿ(1), ���̵嵥��Ÿ(0)

	-- Constraint
	CONSTRAINT pk_tUserBattleBank_idx	PRIMARY KEY(idx)
)
GO
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleBank_gameid_tier_idx2')
    DROP INDEX tUserBattleBank.idx_tUserBattleBank_gameid_tier_idx2
GO
CREATE INDEX idx_tUserBattleBank_gameid_tier_idx2 ON tUserBattleBank (gameid, tier, idx2)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_trophy')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_trophy
GO
CREATE INDEX idx_tBattleLog_gameid_trophy ON tUserBattleBank (gameid, trophy)
GO


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
--	������ŷ���(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRankMaster;
GO

create table dbo.tUserRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tUserRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tUserRankMaster where dateid = '20150216'

---------------------------------------------
--		������ŷ���(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRankSub;
GO

create table dbo.tUserRankSub(
	idx				int 					IDENTITY(1, 1),			-- indexing

	dateid8			varchar(8),
	rank			int,
	anirepitemcode	int						default(1),
	ttsalecoin		int						default(0),
	gameid			varchar(20),
	kakaonickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tUserRankSub_idx	PRIMARY KEY(idx)		-- ���������� dateid, rank�� ����´�.
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRankSub_dateid8_rank')
    DROP INDEX tUserRankSub.idx_tUserRankSub_dateid8_rank
GO
CREATE INDEX idx_tUserRankSub_dateid8_rank ON tUserRankSub (dateid8, rank)
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
--		������Ʋ �˻��ΰ�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleSearchLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleSearchLog;
GO

create table dbo.tUserBattleSearchLog(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	othergameid	varchar(20),
	writedate	smalldatetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserBattleSearchLog_idx	PRIMARY KEY(idx)
)
GO

-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleSearchLog_gameid_idx2_othergameid')
    DROP INDEX tUserBattleSearchLog.idx_tUserBattleSearchLog_gameid_idx2_othergameid
GO
CREATE INDEX idx_tUserBattleSearchLog_gameid_idx2_othergameid ON tUserBattleSearchLog (gameid, othergameid, idx2)
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
-- 	������ȭ �αױ��(200������ ����).
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserWheelLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserWheelLog;
GO

create table dbo.tUserWheelLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	idx2			int,
	mode			int,		-- ���Ϸ귿(20), �����귿(21), Ȳ�ݹ���(22)
	usedcashcost	int,		-- ĳ�����.
	ownercashcost	int,		-- ��������.

	--ownercashcost2	bigint,		-- ��������.
	--strange			int,		-- �̻���(1) ����(-1), ��������(-2)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserWheelLog_idx PRIMARY KEY(idx)
)
-- �ε���
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserWheelLog_gameid_idx2')
    DROP INDEX tUserWheelLog.idx_tUserWheelLog_gameid_idx2
GO
CREATE INDEX idx_tUserWheelLog_gameid_idx2 ON tUserWheelLog (gameid, idx2)
GO






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


