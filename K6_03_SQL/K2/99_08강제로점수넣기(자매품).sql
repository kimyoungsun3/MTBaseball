use Farm
GO
/*
--exec spu_subFVRankDaJunTest 'xxxx@gmail.com', '20150312', 1, 2, 3, 4, 5, 6, 7		-- ¦
--exec spu_subFVRankDaJunTest 'xxxx3', '20150312', 1, 2, 3, 4, 5, 6, 7		-- Ȧ
*/

/*
IF OBJECT_ID ( 'dbo.spu_subFVRankDaJunTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_subFVRankDaJunTest;
GO

create procedure dbo.spu_subFVRankDaJunTest
	@gameid_								varchar(20),
	@rkdateid8					 			varchar(8),
	@rksalemoney_							bigint,
	@rkproductcnt_							bigint,
	@rkfarmearn_							bigint,
	@rkwolfcnt_								bigint,
	@rkfriendpoint_							bigint,
	@rkroulettecnt_							bigint,
	@rkplaycnt_								bigint
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as

	------------------------------------------------
	--
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	--declare @rkdateid8 		varchar(8) 				set @rkdateid8 		= Convert(varchar(8), Getdate(),112)
	declare @rkteam				int
	declare @rkteam1			int
	declare @rkteam0			int

	declare @rksalemoney		bigint					set @rksalemoney	= 0
	declare @rkproductcnt		bigint					set @rkproductcnt	= 0
	declare @rkfarmearn			bigint					set @rkfarmearn		= 0
	declare @rkwolfcnt			bigint					set @rkwolfcnt		= 0
	declare @rkfriendpoint		bigint					set @rkfriendpoint	= 0
	declare @rkroulettecnt		bigint					set @rkroulettecnt	= 0
	declare @rkplaycnt			bigint					set @rkplaycnt		= 0

	declare @rksalemoney2		bigint					set @rksalemoney2	= 0
	declare @rkproductcnt2		bigint					set @rkproductcnt2	= 0
	declare @rkfarmearn2		bigint					set @rkfarmearn2	= 0
	declare @rkwolfcnt2			bigint					set @rkwolfcnt2		= 0
	declare @rkfriendpoint2		bigint					set @rkfriendpoint2	= 0
	declare @rkroulettecnt2		bigint					set @rkroulettecnt2	= 0
	declare @rkplaycnt2			bigint					set @rkplaycnt2		= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ��ŷ����', @gameid_ gameid_, @rksalemoney_ rksalemoney_, @rkproductcnt_ rkproductcnt_, @rkfarmearn_ rkfarmearn_, @rkwolfcnt_ rkwolfcnt_, @rkfriendpoint_ rkfriendpoint_, @rkroulettecnt_ rkroulettecnt_, @rkplaycnt_ rkplaycnt_
	if(@rkdateid8 = '')
		begin
			set @rkdateid8 		= Convert(varchar(8), Getdate(),112)
		end

	------------------------------------------------
	--	��������.
	------------------------------------------------
	select @rkteam = rkteam from dbo.tFVUserMaster where gameid = @gameid_
	--select 'DEBUG ', @rkteam rkteam
	if(@rkteam is null) return;

	------------------------------------------------
	--	��ŷ�������(��ü).
	------------------------------------------------
	if(not exists(select top 1 * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8))
		begin
			--select 'DEBUG > ó�� ������ ���', @rkdateid8 rkdateid8
			insert into dbo.tFVRankDaJun(rkdateid8)
			values(                     @rkdateid8)
		end

	------------------------------------------------
	--select 'DEBUG ������ü���'
	------------------------------------------------
	update dbo.tFVRankDaJun
		set
			-- Ȧ����.
			rksalemoney 	= rksalemoney 	+ case when @rkteam = 1 		then @rksalemoney_ 		else 0 end,
			rkproductcnt	= rkproductcnt  + case when @rkteam = 1 		then @rkproductcnt_ 	else 0 end,
			rkfarmearn		= rkfarmearn  	+ case when @rkteam = 1 		then @rkfarmearn_ 		else 0 end,
			rkwolfcnt		= rkwolfcnt  	+ case when @rkteam = 1 		then @rkwolfcnt_ 		else 0 end,
			rkfriendpoint	= rkfriendpoint + case when @rkteam = 1 		then @rkfriendpoint_ 	else 0 end,
			rkroulettecnt	= rkroulettecnt + case when @rkteam = 1 		then @rkroulettecnt_ 	else 0 end,
			rkplaycnt		= rkplaycnt  	+ case when @rkteam = 1 		then @rkplaycnt_ 		else 0 end,

			--¦����.
			rksalemoney2	= rksalemoney2 	+ case when @rkteam = 0 		then @rksalemoney_ 		else 0 end,
			rkproductcnt2	= rkproductcnt2 + case when @rkteam = 0 		then @rkproductcnt_ 	else 0 end,
			rkfarmearn2		= rkfarmearn2  	+ case when @rkteam = 0 		then @rkfarmearn_ 		else 0 end,
			rkwolfcnt2		= rkwolfcnt2  	+ case when @rkteam = 0 		then @rkwolfcnt_ 		else 0 end,
			rkfriendpoint2	= rkfriendpoint2+ case when @rkteam = 0 		then @rkfriendpoint_ 	else 0 end,
			rkroulettecnt2	= rkroulettecnt2+ case when @rkteam = 0 		then @rkroulettecnt_ 	else 0 end,
			rkplaycnt2		= rkplaycnt2  	+ case when @rkteam = 0 		then @rkplaycnt_ 		else 0 end
	where rkdateid8 = @rkdateid8
	--select 'DEBUG ', * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8


	------------------------------------------------
	-- ���ϱ�
	------------------------------------------------
	--select 'DEBUG (��)', * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8
	select
		@rksalemoney 	= rksalemoney,
		@rkproductcnt	= rkproductcnt,
		@rkfarmearn		= rkfarmearn,
		@rkwolfcnt		= rkwolfcnt,
		@rkfriendpoint	= rkfriendpoint,
		@rkroulettecnt	= rkroulettecnt,
		@rkplaycnt		= rkplaycnt,

		@rksalemoney2	= rksalemoney2,
		@rkproductcnt2	= rkproductcnt2,
		@rkfarmearn2	= rkfarmearn2,
		@rkwolfcnt2		= rkwolfcnt2,
		@rkfriendpoint2	= rkfriendpoint2,
		@rkroulettecnt2	= rkroulettecnt2,
		@rkplaycnt2		= rkplaycnt2
	from dbo.tFVRankDaJun
	where rkdateid8 = @rkdateid8

	set @rkteam1 	= 0
	set @rkteam0	= 0
	if(@rksalemoney > @rksalemoney2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rksalemoney < @rksalemoney2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkproductcnt > @rkproductcnt2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkproductcnt < @rkproductcnt2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkfarmearn > @rkfarmearn2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkfarmearn < @rkfarmearn2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkwolfcnt > @rkwolfcnt2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkwolfcnt < @rkwolfcnt2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkfriendpoint > @rkfriendpoint2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkfriendpoint < @rkfriendpoint2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkroulettecnt > @rkroulettecnt2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkroulettecnt < @rkroulettecnt2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkplaycnt > @rkplaycnt2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkplaycnt < @rkplaycnt2)	set @rkteam0 	= @rkteam0 + 1

	--����� ����Ѵ�.
	update dbo.tFVRankDaJun
		set
			rkteam1 = @rkteam1,
			rkteam0 = @rkteam0
	where rkdateid8 = @rkdateid8
	--select 'DEBUG (��)', * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8

	------------------------------------------------
	--	��ŷ���α��.
	------------------------------------------------
	update dbo.tFVUserMaster
		set
			rksalemoney		= rksalemoney	+ @rksalemoney_,
			rkproductcnt	= rkproductcnt 	+ @rkproductcnt_,
			rkfarmearn		= rkfarmearn 	+ @rkfarmearn_,
			rkwolfcnt		= rkwolfcnt		+ @rkwolfcnt_,
			rkfriendpoint	= rkfriendpoint + @rkfriendpoint_,
			rkroulettecnt	= rkroulettecnt + @rkroulettecnt_,
			rkplaycnt		= rkplaycnt 	+ @rkplaycnt_
	where gameid = @gameid_
	--select 'DEBUG ���α��', rksalemoney, rkproductcnt, rkfarmearn	, rkwolfcnt	, rkfriendpoint, rkroulettecnt, rkplaycnt, * from dbo.tFVUserMaster where gameid = @gameid_

	------------------------------------------------
	--	4-1. ����
	------------------------------------------------
	set nocount off
End


*/