
/*
-- 상인그룹.
declare @tradesuccesscnt int
set @tradesuccesscnt = 0
while( @tradesuccesscnt <= 10)
	begin
		select @tradesuccesscnt tradesuccesscnt, dbo.fun_GetDealerGroup( @tradesuccesscnt )
		set @tradesuccesscnt = @tradesuccesscnt + 1
	end


*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetDealerGroup', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetDealerGroup;
GO

CREATE FUNCTION dbo.fun_GetDealerGroup(
	@tradesuccesscnt_					int = 1
)
	RETURNS int
AS
BEGIN
	declare @rtn 								int					set @rtn 							= 0


	set @rtn = case
					when( @tradesuccesscnt_ < 4 )				then 0
					when( @tradesuccesscnt_ < 4+5 )				then 1
					when( @tradesuccesscnt_ < 4+5+6 )			then 2
					when( @tradesuccesscnt_ < 4+5+6+7 )			then 3
					when( @tradesuccesscnt_ < 4+5+6+7+8 )		then 4
					when( @tradesuccesscnt_ < 4+5+6+7+8+9)		then 5
					when( @tradesuccesscnt_ < 4+5+6+7+8+9+12)	then 6
					else 											 7+ (@tradesuccesscnt_ -(4+5+6+7+8+9+12)) / 12
				end

	RETURN @rtn
END
