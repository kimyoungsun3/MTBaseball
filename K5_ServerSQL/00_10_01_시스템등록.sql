use GameMTBaseball
GO

declare @USERITEM_INVENKIND_ANI	int 	set @USERITEM_INVENKIND_ANI					= 1
declare @gameid			varchar(20)		set @gameid 	= 'farmgirl'
declare @ani			int				set @ani		= 112
declare @listidx		int				set @listidx	= 20

select 'DEBUG 1. ��, ��ũ, �κ�Ȯ��, �ʵ�, ���� ���  Iteminfo���� ������Ʈ > (���,����,��Ʈ,����) ����Ʈ �۾�'
if( not exists ( select top 1 * from dbo.tSystemInfo order by idx desc ) )
	begin
		exec spu_FarmD 30, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '8', '28', '1:2000;2:1005;3:6;4:100003;10:10;11:10;12:10;13:10;14:10;15:10;16:10;', ''
	end


select 'DEBUG 2-1. �����̱� ������ �۾�'
if( not exists ( select * from dbo.tSystemRouletteMan where roulmarket = 5 ) )
	begin
		select 'DEBUG �����̱� ������ Google'
		insert into dbo.tSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
		values                            (         5,             1,  '2013-09-01', '2023-09-01',  120505,    120505,    120505,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
	end

if( not exists ( select * from dbo.tSystemRouletteMan where roulmarket = 7 ) )
	begin
		select 'DEBUG �����̱� ������ iPhone'
		insert into dbo.tSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
		values                            (         7,             1, ' 2013-09-01', '2023-09-01',  120505,    120505,    120505,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
	end

select 'DEBUG 2-2. �����̱� ������ �۾�'
if( not exists ( select * from dbo.tSystemTreasureMan where roulmarket = 5 ) )
	begin
		-- Google
		insert into dbo.tSystemTreasureMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
		values                            (         5,             1,  '2013-09-01', '2023-09-01',  120505,    120505,    120505,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
	end

if( not exists ( select * from dbo.tSystemTreasureMan where roulmarket = 7 ) )
	begin
		-- iPhone
		insert into dbo.tSystemTreasureMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
		values                            (         7,             1, ' 2013-09-01', '2023-09-01',  120505,    120505,    120505,        3015,        3015,        3015,  '�ᳪ�� ȭ��D', '������ ����D', '�ᳪ�� ȭ��A',            1,             12,            18,            23, '���ʳ���')
	end



select 'DEBUG 3-2. ��ǥ���� �۾�'
if( not exists ( select * from dbo.tUserMaster where gameid = @gameid ) )
	begin
		exec spu_UserCreate @gameid,  '7575970askeie1595312', 1, 0, 1, 'ukukukuk', 101, '01000000000', '', 'kakaotalkidfarmgirl', 'kakaouseridfarmgirl', '', '', -1, '0:x1;1:x2;2:x3;', -1

		delete from dbo.tUserItem where gameid = @gameid

		-- ���� & �Ǽ�����.
		insert into dbo.tUserItem( gameid,  listidx, itemcode, cnt, farmnum, fieldidx, invenkind		 	  )					-- ��ǥ����(��¯��).
		values(					  @gameid, @listidx,     @ani,   1,       0,       -1, @USERITEM_INVENKIND_ANI)

		-- ��ǥ���� ����.
		update dbo.tUserMaster set anireplistidx = @listidx, housestep = 6, tankstep = 20, famelv = 50, fame = 9999, bottlestep = 20, pumpstep = 20, transferstep = 20, purestep = 20, freshcoolstep = 20 where gameid = @gameid

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			 )
		values(					  @gameid, @listidx + 1,       13,   1,       0,       0, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 2,       14,   1,       0,       1, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 3,       15,   1,       0,       2, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 4,      112,   1,       0,       3, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 5,      113,   1,       0,       4, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 6,      114,   1,       0,       5, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 7,      212,   1,       0,       6, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 8,      213,   1,       0,       7, @USERITEM_INVENKIND_ANI)

		insert into dbo.tUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind			)
		values(					  @gameid, @listidx + 9,      214,   1,       0,       8, @USERITEM_INVENKIND_ANI)

		-- update dbo.tUserMaster set anireplistidx = 20 where gameid = 'farmgirl'
		-- update dbo.tUserMaster set kakaonickname = 'farmgirl', kakaoprofile = 'http://th-p.talk.kakao.co.kr/th/talkp/wkfjowqYrv/dpGpFdOL1r2k99gQVspP20/4haroa_110x110_c.jpg' where gameid = 'farmgirl'
		-- update dbo.tUserMaster set kakaonickname = 'o+0ToIFqRNI/do4X1Bsfcw==', kakaoprofile = 'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELfiLyHElGdtmIJOKwR+QFdHxCFHxtDJ2ZiDL4iBhG/SVAmIxTicVbGFHv/aw5HPCYC8RZMNnBms+' where gameid = 'farmgirl'
		--
		--	http://th-p.talk.kakao.co.kr/th/talkp/wkfwOaFMq9/WPDkwCf978ebs7HCc1t7wK/id2la9_110x110_c.jpg
		--	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWV7EqkH2tMo6AFoTrKd7XOkrsozbjouiJ50LjOEaVZgifUkaN2jRFdHv/aw5HPCYC8RZMNnBms+
		update dbo.tUserMaster set kakaonickname = '¥���', kakaoprofile = 'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWV7EqkH2tMo6AFoTrKd7XOkrsozbjouiJ50LjOEaVZgifUkaN2jRFdHv/aw5HPCYC8RZMNnBms+' where gameid = 'farmgirl'
	end



select 'DEBUG 3-3. �����ð�������'
if( not exists ( select top 1 * from dbo.tEventMaster ) )
	begin
		insert into dbo.tEventMaster(eventstatemaster) values(0)
	end