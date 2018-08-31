use Farm
GO
--select gameid, COUNT(*), COUNT(*)*1800 from dbo.tFVGiftList where itemcode = 3500 group by gameid order by 2 desc
--select * from dbo.tFVGiftList where gameid in('farm15193186') and itemcode = 3500 order by idx desc
--select * from dbo.tFVGiftList where gameid in('farm19483939') and itemcode = 3500 order by idx desc
--select * from dbo.tFVGiftList where gameid in('farm12566370') and itemcode = 3500 order by idx desc
--
--farm15193186 999
--farm19483939 998
--farm12566370 997

select * from dbo.tUserMaster where gameid in('farm15193186', 'farm19483939')
select m.gameid, m.nickname, g.cnt, m.roulettepaycnt, m.vippoint, m.vippoint2, m.cashcost, m.cashcost2
from dbo.tUserMaster as m
 JOIN
 (select top 100 gameid, COUNT(*) cnt from dbo.tFVGiftList where itemcode = 3500 group by gameid order by 2 desc) as g
 ON m.gameid = g.gameid

select gameid, nickname, roulettepaycnt, vippoint, vippoint2, cashcost, cashcost2 from dbo.tUserMaster where roulettepaycnt > 100 order by 3 desc