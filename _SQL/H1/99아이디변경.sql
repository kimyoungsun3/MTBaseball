
declare @gameid varchar(20) 
declare @newid varchar(20) 
--set @gameid = 'superman4'
set @gameid = 'powerfulatist'
set @newid = 'poweratist'

update dbo.tUserMaster set gameid = @newid where gameid = @gameid
update dbo.tUserCustomize set gameid = @newid where gameid = @gameid
update dbo.tBattleLogSearchJump set gameid = @newid where gameid = @gameid
update dbo.tBattleLogSearch set gameid = @newid where gameid = @gameid
update dbo.tBattleLog set gameid = @newid where gameid = @gameid
update dbo.tQuestUser set gameid = @newid where gameid = @gameid
update dbo.tAdminUser set gameid = @newid where gameid = @gameid
update dbo.tRouletteLogPerson set gameid = @newid where gameid = @gameid
update dbo.tUserSMSLog set gameid = @newid where gameid = @gameid
update dbo.tMessage set gameid = @newid where gameid = @gameid
update dbo.tCashLog set gameid = @newid where gameid = @gameid
update dbo.tCashChangeLog set gameid = @newid where gameid = @gameid
update dbo.tGiftList set gameid = @newid where gameid = @gameid
update dbo.tUserItem set gameid = @newid where gameid = @gameid
update dbo.tItemBuyLog set gameid = @newid where gameid = @gameid
update dbo.tUserItemUpgradeLog set gameid = @newid where gameid = @gameid
update dbo.tUserUnusualLog set gameid = @newid where gameid = @gameid
update dbo.tUserBlockLog set gameid = @newid where gameid = @gameid
update dbo.tUserDeleteLog set gameid = @newid where gameid = @gameid
update dbo.tUserFriend set gameid = @newid where gameid = @gameid
update dbo.tUserFriend set friendid = @newid where friendid = @gameid
update dbo.tUserSMSReward set gameid = @newid where gameid = @gameid
update dbo.tUserRewardLog set gameid = @newid where gameid = @gameid
update dbo.tRankTotal set gameid = @newid where gameid = @gameid
update dbo.tActionScheduleData set gameid = @newid where gameid = @gameid
update dbo.tBattleLogBlock set gameid = @newid where gameid = @gameid
update dbo.tEventMaster set gameid = @newid where gameid = @gameid
update dbo.tTotoUser set gameid = @newid where gameid = @gameid