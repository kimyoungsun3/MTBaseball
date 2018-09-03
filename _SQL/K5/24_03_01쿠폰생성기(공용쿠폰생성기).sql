use GameMTBaseball
GO

-----------------------------------------------------
-- 공용형(2)		1차분
-- 루비(5000)		* 300
-- 코인(5100)		* 2000
-----------------------------------------------------
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(          'ZAYOZAYOTYCOONK5',      5000,  300,      5100, 2000,        -1,    0,        2,    0, getdate() + 7 )




--declare @CERTNO_MAINKIND_ONEBYONE			int				set	@CERTNO_MAINKIND_ONEBYONE			= 1	--  1인형(1)
declare @CERTNO_MAINKIND_COMMON				int				set	@CERTNO_MAINKIND_COMMON				= 2	-- 공용형(2)
declare @certno			varchar(16)
declare @itemcode1		int			set @itemcode1	= -1
declare @itemcode2		int			set @itemcode2	= -1
declare @itemcode3		int			set @itemcode3	= -1
declare @cnt1			int			set	@cnt1		=  0
declare @cnt2			int			set	@cnt2		=  0
declare @cnt3			int			set	@cnt3		=  0
declare @startdate		datetime
declare @enddate		datetime
declare @mainkind		int			set @mainkind		= @CERTNO_MAINKIND_COMMON
declare @kind			int			set @kind			= 0

-----------------------------------------------------
-- 공용형(2)		2차분
-- 프리미엄(2300)	* 1
-- 긴급지원(2100)	* 5
-----------------------------------------------------
--set @certno		= 'COMETOWEALTH'
--set @itemcode2	= 2300				set @cnt2	= 1
--set @itemcode3	= 2100				set @cnt3	= 5
--set @startdate	= '2016-05-12'		set @enddate	= '2016-05-14 23:59'

-------------------------------------------------------
---- 공용형(2)		3차분 twitter
---- 루비(5000)		* 250
---- 코인(5100)		* 3000
-------------------------------------------------------
--set @certno		= 'ZAYOTWITTER'
--set @itemcode2	= 5000				set @cnt2	= 250
--set @itemcode3	= 5100				set @cnt3	= 3000
--set @startdate	= '2016-05-17'		set @enddate	= '2016-05-24 23:59'

-----------------------------------------------------
-- 공용형(2)		4차분 twitter
-- 골드박스(3702)		* 1
-- 프교배티켓(2300)		* 1
-----------------------------------------------------
set @certno		= 'ZZAYO2016FB'
set @itemcode1	= 3702				set @cnt1	= 1
set @itemcode2	= 2300				set @cnt2	= 1
set @itemcode3	= -1				set @cnt3	= 0
set @startdate	= '2016-01-01'		set @enddate	= '2016-05-27 23:59'

select 'DEBUG 쿠폰입력', @certno certno, @mainkind mainkind, @kind kind, @itemcode1 itemcode1, @cnt1 cnt1, @itemcode2 itemcode2, @cnt2 cnt2, @itemcode3 itemcode3, @cnt3 cnt3, @startdate startdate, @enddate enddate

--삭제후..
delete from dbo.tEventCertNo where certno = @certno
--delete from dbo.tEventCertNoBack where gameid = 'farm3967580'

-- 입력...
insert into dbo.tEventCertNo(certno,  itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3,  mainkind,  kind,  enddate )
values(          			@certno, @itemcode1, @cnt1, @itemcode2, @cnt2, @itemcode3, @cnt3, @mainkind, @kind, @enddate )



