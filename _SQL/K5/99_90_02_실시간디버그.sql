/*
exec spu_TTTT 'DEBUG 1', 'xxxx2', 2013, 3, 'mmmm'
-- exec spu_TTTT 'DEBUG 1', @gameid, @gameyear, @gamemonth, @comment

--delete from dbo.tTTTT 
--delete from dbo.tUserSaleLog where gameid = 'farm166775' 
select * from dbo.tTTTT order by idx asc
select * from dbo.tUserSaleLog where gameid = 'farm166775' -- and gameyear = 2024 and gamemonth = 5
*/

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_TTTT', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TTTT;
GO

create procedure dbo.spu_TTTT
	@step_			varchar(400),
	@gameid_		varchar(20),
	@gameyear_		int,
	@gamemonth_		int,
	@msg_			varchar(400)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 로그기록
	------------------------------------------------
	insert into dbo.tTTTT( step,   gameid,   gameyear,   gamemonth,   msg )
	values(				  @step_, @gameid_, @gameyear_, @gamemonth_, @msg_)



	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


