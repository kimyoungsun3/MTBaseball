select top 50 * from dbo.tMessage m1 INNER JOIN (select * from dbo.tUserMaster where market in (5, 15) and blockstate = 0) m2
on m1.gameid = m2.gameid
where comment like '%����� ����%'
order by m1.idx desc