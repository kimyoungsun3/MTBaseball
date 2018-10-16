/*

-- mtxxxx3 <- mtxxxx2 가져오기
delete from dbo.tSingleGame 	where gameid = 'mtxxxx3' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )
delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx3' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )
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
							selectdata, writedate, connectip, level, exp, commissionbet, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx2' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )

*/


/*

-- mtxxxx3 -> mtxxxx2 백업
--delete from dbo.tSingleGame 	where gameid = 'mtxxxx2' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )
--delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx2' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )
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
from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 829533, 829534, 829537, 829538, 829540 )

*/