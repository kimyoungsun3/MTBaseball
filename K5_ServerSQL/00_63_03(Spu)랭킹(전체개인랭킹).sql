/*
update dbo.tUserMaster set ttsalecoin = 123 where gameid = 'xxxx'
update dbo.tUserMaster set ttsalecoin = 124 where gameid = 'xxxx2'
update dbo.tUserMaster set ttsalecoin = 125 where gameid = 'xxxx3'

exec spu_subUserTotalRank 'xxxx2',  1	-- 실제랭킹.
exec spu_subUserTotalRank 'xxxx2', -1	-- 더미랭킹.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_subUserTotalRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_subUserTotalRank;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_subUserTotalRank
	@gameid_								varchar(20),
	@mode_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid					varchar(20)				set @gameid			= ''
	declare @famelv					int						set @famelv			= 1
	declare @ttsalecoin				int						set @ttsalecoin		= 0
	declare @trophy					int						set @trophy			= 0
	declare @tier					int						set @tier			= 0
	declare @anirepitemcode			int						set @anirepitemcode	= -1
	declare @kakaonickname			varchar(40)				set @kakaonickname	= ''
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 				varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on


	------------------------------------------------
	--	자기랭킹기록.
	------------------------------------------------
	if( @mode_ = 1 )
		begin
			select
				@gameid 		= gameid,
				@ttsalecoin 	= ttsalecoin,
				@anirepitemcode = anirepitemcode,
				@kakaonickname	= kakaonickname,
				@famelv			= famelv
			from tUserMaster
			where gameid = @gameid_

			select count(gameid)+1 as rank, @anirepitemcode anirepitemcode, @ttsalecoin ttsalecoin, @gameid gameid, @kakaonickname kakaonickname, @famelv famelv from dbo.tUserMaster where ttsalecoin > @ttsalecoin and deletestate = 0
			union all
			select top 50 rank() over(order by ttsalecoin desc) as rank, anirepitemcode, ttsalecoin, gameid, kakaonickname, famelv from dbo.tUserMaster where ttsalecoin > 0 and deletestate = 0
		end
	else
		begin
			DECLARE @tTempSalerank TABLE(
				rank			int,
				anirepitemcode	int,
				ttsalecoin		int,
				gameid			varchar(20),
				kakaonickname	varchar(20),
				famelv			int
			);

			select * from @tTempSalerank
		end

	------------------------------------------------
	--	유저배틀랭킹.
	------------------------------------------------
	if( @mode_ = 1 )
		begin
			select
				@gameid 		= gameid,
				@trophy 		= trophy,
				@tier			= tier,
				@anirepitemcode = anirepitemcode,
				@kakaonickname	= kakaonickname,
				@famelv			= famelv
			from tUserMaster
			where gameid = @gameid_

			select count(gameid)+1 as rank, @anirepitemcode anirepitemcode, @trophy trophy, @tier tier, @gameid gameid, @kakaonickname kakaonickname, @famelv famelv from dbo.tUserMaster where trophy > @trophy and deletestate = 0
			union all
			select top 50 rank() over(order by trophy desc) as rank, anirepitemcode, trophy, tier, gameid, kakaonickname, famelv from dbo.tUserMaster where trophy > 0 and deletestate = 0
		end
	else
		begin
			DECLARE @tTempBattlerank TABLE(
				rank			int,
				anirepitemcode	int,
				trophy			int,
				tier			int,
				gameid			varchar(20),
				kakaonickname	varchar(20),
				famelv			int
			);

			select * from @tTempBattlerank
		end

	set nocount off
End

