/*
-----------------------------------------------------
select dbo.fnc_GetCashCheck(5, '3097877144749175331.8636117861599773')

select dbo.fnc_GetCashCheck(5, 'GPA.1345-5296-8330-51008')
select dbo.fnc_GetCashCheck(5, '12999763169054705758.1343569877495792')
select dbo.fnc_GetCashCheck(1, '1')
select dbo.fnc_GetCashCheck(2, '2')
select dbo.fnc_GetCashCheck(7, '7')
-----------------------------------------------------
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( N'dbo.fnc_GetCashCheck', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnc_GetCashCheck;
GO

CREATE FUNCTION dbo.fnc_GetCashCheck(
	@market_					int,
	@acode_		  				varchar(256)
)
	RETURNS int
AS
BEGIN
	-- 구매처코드
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	--declare @MARKET_NHN						int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	declare @DEFINE_CASHCODE1					varchar(256)	set @DEFINE_CASHCODE1					= 'GPA.'
	declare @DEFINE_CASHCODE2					varchar(256)	set @DEFINE_CASHCODE2					= '12999763169054705758.'

	declare @rtn 			int				set @rtn 		= 0

	if(@market_ = @MARKET_GOOGLE)
		begin
			set @rtn 	= CHARINDEX(@DEFINE_CASHCODE1, @acode_)
			if(@rtn = 0)
				begin
					set @rtn 	= CHARINDEX(@DEFINE_CASHCODE2, @acode_)
				end
		end
	else
		begin
			set @rtn = 1
		end

	RETURN @rtn

END