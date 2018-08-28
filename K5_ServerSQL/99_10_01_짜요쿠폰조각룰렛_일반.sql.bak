use Game4Farmvill5
GO


declare @loop 		int 	set @loop 		= 0
declare @loopmax	int 	set @loopmax	= 10000
declare @val1 		int 	set @val1 		= 0
declare @val2 		int 	set @val2 		= 0
declare @val3 		int 	set @val3 		= 0

declare @rand 		int 	set @rand 		= 0
declare @rand2 		int 	set @rand2 		= 0
declare @rand3 		int 	set @rand3 		= 0

DECLARE @tTempTable TABLE(
	idx				int,
	cnt				int,
	val1			int,
	val2			int,
	val3			int
);

insert into @tTempTable ( idx, cnt, val1, val2, val3 )
values(                      1,  0,    0,    0,    0 )


while( @loop < @loopmax )
	begin
		set @rand  = Convert(int, ceiling(RAND() * 10000))
		set @rand2 = Convert(int, ceiling(RAND() * 10000))
		set @rand3 = Convert(int, ceiling(RAND() * 10000))

		set @val1 = dbo.fun_getZCPChance(  0, 0, @rand  )
		set @val2 = dbo.fun_getZCPChance( 10, 0, @rand2 )
		set @val3 = dbo.fun_getZCPChance( 20, 0, @rand3 )

		update @tTempTable
			set
				cnt = cnt + 1,
				val1 = val1 + case when @val1 = 1 then 1 else 0 end,
				val2 = val2 + case when @val2 = 1 then 1 else 0 end,
				val3 = val3 + case when @val3 = 1 then 1 else 0 end
		where idx = 1
		set @loop = @loop + 1
	end

--select * from @tTempTable
select * from @tTempTable
