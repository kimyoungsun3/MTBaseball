/*

-- mtxxxx3 <- mtxxxx2 가져오기
--update dbo.tPracticeGame set gamestate = -1 where gameid = 'mtxxxx2' and gamestate = -3
--delete from dbo.tGiftList		where gameid = 'mtxxxx3' and giftdate > '2018-10-18'
delete from dbo.tPracticeGame 	where gameid = 'mtxxxx3' and curturntime in ( 831842, 831843, 831844, 831845 )
delete from dbo.tPracticeGameLog 	where gameid = 'mtxxxx3' and curturntime in ( 831842, 831843, 831844, 831845 )
insert into tPracticeGame (
							gameid,
							curturntime, curturndate, gamemode, select1,
							select2,
							select3,
							select4,
							selectdata, writedate, level, exp
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, select1,
							select2,
							select3,
							select4,
							selectdata, writedate, level, exp
from dbo.tPracticeGame where gameid = 'mtxxxx2' and curturntime in ( 831842, 831843, 831844, 831845 )

*/


/*

-- mtxxxx3 -> mtxxxx2 백업
--delete from dbo.tPracticeGame 	where gameid = 'mtxxxx2' and curturntime in ( 831842, 831843, 831844, 831845 )
--delete from dbo.tPracticeGameLog 	where gameid = 'mtxxxx2' and curturntime in ( 831842, 831843, 831844, 831845 )
insert into tPracticeGame (
							gameid,
							curturntime, curturndate, gamemode, select1,
							select2,
							select3,
							select4,
							selectdata, writedate, level, exp
						)
select
							'mtxxxx2',
							curturntime, curturndate, gamemode, select1,
							select2,
							select3,
							select4,
							selectdata, writedate, level, exp
from dbo.tPracticeGame where gameid = 'mtxxxx3' and curturntime in ( 831842, 831843, 831844, 831845 )

*/

