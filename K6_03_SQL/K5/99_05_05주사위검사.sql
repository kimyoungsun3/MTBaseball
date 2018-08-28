
use GameMTBaseball
GO

declare @YABAU_COUNT_L1						int					set @YABAU_COUNT_L1							= 40
declare @YABAU_COUNT_L2						int					set @YABAU_COUNT_L2							= 80
declare @yabaucount		int				set @yabaucount		= 0
declare @yabautemp		int				set @yabautemp		= 0
declare @rand			int				set @rand			= 0
declare @loop 			int				set @loop			= 10000
declare @yabaustep		int				set @yabaustep 		= 0
declare @needyabaunum	int				set @needyabaunum	= 2
declare @successcnt		int				set @successcnt		= 0
declare @slidecnt		int				set @slidecnt		= 0
declare @slidecnt2		int				set @slidecnt2		= 0
DECLARE @tItemExpire TABLE(
	idx int IDENTITY(1, 1),
	comment varchar(128),
	loop int,
	yabaustep int,
	rand int,
	needyabaunum int,
	yabaucount int
);

while(@loop > 0)
	begin
		set @rand 		= Convert(int, ceiling(RAND() * 11)) + 1
		set @needyabaunum	= @yabaustep * 2 + 1
		set @needyabaunum	= case when @needyabaunum >= 12 then 11 when @needyabaunum <= 2 then 2 else @needyabaunum end

		insert into @tItemExpire(comment, loop, yabaustep, rand, needyabaunum, yabaucount)
		select 'DEBUG', @loop loop, @yabaustep yabaustep, @rand rand, @needyabaunum needyabaunum, @yabaucount yabaucount

		-----------------------------------------------------
		-- 필터 기능
		-- 코인 5단계 > 진행횟수 [L0 ~ 가능 ~ L1 ~ 불가능 ~ L2]
		-----------------------------------------------------
		set @yabautemp = @yabaucount % @YABAU_COUNT_L2
		if(@yabaustep >= 5 and @yabautemp > @YABAU_COUNT_L1 and @yabautemp <= @YABAU_COUNT_L2)
			begin
				set @slidecnt = @slidecnt + case
								when @rand >= @needyabaunum then 1
								else							 0
							end
				set @slidecnt2 = @slidecnt2 + 1

				set @rand = case
								when @rand >= @needyabaunum then @needyabaunum - 1
								else							 @rand
							end
				insert into @tItemExpire(comment, loop, yabaustep, rand, needyabaunum, yabaucount)
				select 'DEBUG > 5단계에서 미끄러짐', @loop loop, @yabaustep yabaustep, @rand rand, @needyabaunum needyabaunum, @yabaucount yabaucount
			end


		if(@needyabaunum <= @rand)
			begin
				--select 'DEBUG > 성공'
				set @yabaustep 		= @yabaustep + case when (@yabaustep < 6) then 1 else 0 end
			end
		else
			begin
				--select 'DEBUG > 실패'
				set @yabaustep 		= @yabaustep - case when (@yabaustep > 0) then 1 else 0 end
			end

		if(@yabaustep >= 6)
			begin
				set @successcnt = @successcnt + 1
				set @yabaustep	= 0
				insert into @tItemExpire(comment, loop, yabaustep, rand, needyabaunum, yabaucount)
				select 'DEBUG 받아감', @loop loop, @yabaustep yabaustep, @rand rand, @needyabaunum needyabaunum, @yabaucount yabaucount
			end
		set @yabaucount = @yabaucount + 1
		set @loop = @loop - 1
	end

select @successcnt successcnt, @slidecnt slidecnt, @slidecnt2 slidecnt2
select * from @tItemExpire