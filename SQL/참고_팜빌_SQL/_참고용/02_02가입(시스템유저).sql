/*
use Farm
GO

declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
declare @gameid			varchar(60)		set @gameid 	= 'farmgirl'
declare @ani			int				set @ani		= 112
declare @listidx		int				set @listidx	= 20
declare @acc1			int				set @acc1		= 1425
declare @acc2			int				set @acc2		= -1


exec spu_FVUserCreate 'farmgirl',  '7575970askeie1595312', 1, 0, 1, 'ukukukuk', 101, '01000000000', '', 'kakaotalkidfarmgirl', 'kakaouseridfarmgirl', '', '', -1, '0:x1;1:x2;2:x3;', -1

delete from dbo.tFVUserItem where gameid = @gameid --and fieldidx >= 0

-- 동물 & 악세지급.
insert into dbo.tFVUserItem( gameid,  listidx, itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,	acc2)					-- 대표동물(얼짱양).
values(					  @gameid, @listidx,     @ani,   1,       0,       -1, @USERITEM_INVENKIND_ANI, @acc1, @acc2)

-- 대표동물 변경.
update dbo.tFVUserMaster set anireplistidx = @listidx, housestep = 6, tankstep = 20, famelv = 50, fame = 9999, bottlestep = 20, pumpstep = 20, transferstep = 20, purestep = 20, freshcoolstep = 20 where gameid = @gameid

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 1,       13,   1,       0,       0, @USERITEM_INVENKIND_ANI, 1424,		1457)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 2,       14,   1,       0,       1, @USERITEM_INVENKIND_ANI, 1415,		1477)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 3,       15,   1,       0,       2, @USERITEM_INVENKIND_ANI, 1409,		1483)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 4,      112,   1,       0,       3, @USERITEM_INVENKIND_ANI, 1425,		1460)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 5,      113,   1,       0,       4, @USERITEM_INVENKIND_ANI, 1418,		1482)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 6,      114,   1,       0,       5, @USERITEM_INVENKIND_ANI, 1402,		1468)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 7,      212,   1,       0,       6, @USERITEM_INVENKIND_ANI, 1400,		1465)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 8,      213,   1,       0,       7, @USERITEM_INVENKIND_ANI, 1407,		1456)

insert into dbo.tFVUserItem( gameid,  listidx,     itemcode, cnt, farmnum, fieldidx, invenkind,				acc1,		acc2)
values(					  @gameid, @listidx + 9,      214,   1,       0,       8, @USERITEM_INVENKIND_ANI, 1404,		1458)

-- update dbo.tFVUserMaster set anireplistidx = 20 where gameid = 'farmgirl'
-- update dbo.tFVUserMaster set kakaonickname = 'farmgirl', kakaoprofile = 'http://th-p.talk.kakao.co.kr/th/talkp/wkfjowqYrv/dpGpFdOL1r2k99gQVspP20/4haroa_110x110_c.jpg' where gameid = 'farmgirl'
-- update dbo.tFVUserMaster set kakaonickname = 'o+0ToIFqRNI/do4X1Bsfcw==', kakaoprofile = 'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELfiLyHElGdtmIJOKwR+QFdHxCFHxtDJ2ZiDL4iBhG/SVAmIxTicVbGFHv/aw5HPCYC8RZMNnBms+' where gameid = 'farmgirl'
--
--	http://th-p.talk.kakao.co.kr/th/talkp/wkfwOaFMq9/WPDkwCf978ebs7HCc1t7wK/id2la9_110x110_c.jpg
--	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWV7EqkH2tMo6AFoTrKd7XOkrsozbjouiJ50LjOEaVZgifUkaN2jRFdHv/aw5HPCYC8RZMNnBms+
update dbo.tFVUserMaster set kakaonickname = 'o+0ToIFqRNI/do4X1Bsfcw==', kakaoprofile = 'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWV7EqkH2tMo6AFoTrKd7XOkrsozbjouiJ50LjOEaVZgifUkaN2jRFdHv/aw5HPCYC8RZMNnBms+' where gameid = 'farmgirl'
*/