/*

-- mtxxxx3 <- mtxxxx2 가져오기
--update dbo.tSingleGame set gamestate = -1 where gameid = 'mtxxxx2' and gamestate = -3
--delete from dbo.tGiftList		where gameid = 'mtxxxx3' and giftdate > '2018-10-18'
delete from dbo.tSingleGame 	where gameid = 'mtxxxx3' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )
delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx3' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, case when gamestate = -3 then -1 else gamestate end
from dbo.tSingleGame where gameid = 'mtxxxx2' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )

*/


/*

-- mtxxxx3 -> mtxxxx2 백업
--delete from dbo.tSingleGame 	where gameid = 'mtxxxx2' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )
--delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx2' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
						)
select
							'mtxxxx2',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 830094, 830093, 830092, 829540, 829538, 829537, 829534, 829533, 828644, 828643 )

*/


/*
-- mtxxxx3 -> mtxxxx2 백업
delete from dbo.tSingleGame 	where gameid = 'mtxxxx2' and curturntime in ( 830094 )
delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx2' and curturntime in ( 830094 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
						)
select
							'mtxxxx2',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 830094 )

*/