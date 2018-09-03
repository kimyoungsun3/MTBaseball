/*
-- delete from dbo.tRankDaJun where rkdateid8 = '20160517'
-- update dbo.tUserMaster set rktotal = 0, rksalemoney = 0, rksalebarrel = 0, rkbattlecnt = 0, rkbogicnt = 0, rkfriendpoint	= 0, rkroulettecnt	= 0, rkwolfcnt = 0
-- select gameid, rkteam, rktotal, rktotal2, rksalemoney, rksalebarrel, rkbattlecnt, rkbogicnt, rkfriendpoint, rkroulettecnt, rkwolfcnt, rksalemoneybk, rksalebarrelbk, rkbattlecntbk, rkbogicntbk, rkfriendpointbk, rkroulettecntbk, rkwolfcntbk from dbo.tUserMaster where gameid in ('xxxx2', 'xxxx3')
-- exec spu_subRankDaJun 'xxxx2', 1, 1, 1, 1, 1, 1, 1		-- Â¦
-- exec spu_subRankDaJun 'xxxx3', 1, 2, 3, 4, 5, 6, 7		-- È¦

declare @t1			bigint,
		@t2			bigint,
		@t3			bigint,
		@t4			bigint,
		@t5			bigint,
		@t6			bigint,
		@t7			bigint,
		@gameid		varchar(20)


-- 1. ·©Å· Ä¿¼­·Î ÀÐ¾î¿À±â.
declare curUserRanking Cursor for
select gameid from dbo.tUserMaster

-- 2. Ä¿¼­¿ÀÇÂ
open curUserRanking

-- 3. Ä¿¼­ »ç¿ë
Fetch next from curUserRanking into @gameid
while @@Fetch_status = 0
	Begin
		set @t1 = Convert(bigint, ceiling(RAND() *  80000))
		set @t2 = Convert(bigint, ceiling(RAND() *    600))
		set @t3 = Convert(bigint, ceiling(RAND() *     70))
		set @t4 = Convert(bigint, ceiling(RAND() *     60))
		set @t5 = Convert(bigint, ceiling(RAND() *   1510))
		set @t6 = Convert(bigint, ceiling(RAND() *    600))
		set @t7 = Convert(bigint, ceiling(RAND() *     36))


		update dbo.tUserMaster set rkteam = (CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END)%2 where gameid = @gameid
		exec spu_subRankDaJun @gameid, @t1, @t2, @t3, @t4, @t5, @t6, @t7

		Fetch next from curUserRanking into @gameid
	end

-- 4. Ä¿¼­´Ý±â
close curUserRanking
Deallocate curUserRanking
*/