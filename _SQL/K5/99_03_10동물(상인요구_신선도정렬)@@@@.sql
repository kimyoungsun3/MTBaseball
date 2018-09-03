use GameMTBaseball
GO

declare @strfresh 			varchar(1024)
declare @famelv				int,
		@datastr			varchar(40),
		@dataint			int,
		@freshbase			int,
		@needfresh			int,
		@plusfreshfromlv	int,
		@plusfreshfromin	int,
		@group1 			int, 	@group2 	int, 	@group3 	int, 	@group4 	int,
		@itemcode			int,
		@fresh				int,
		@stritemcode		varchar(1024),
		@stritemfresh		varchar(1024),
		@mode				int

set @mode		= 3		-- 1:정보모드, 3:아이템코드 뽑기(Text모드에서 뽑으시면 엑셀에 들어가요.)
set @strfresh = ''
set @strfresh = @strfresh + ' 1:  7,     15, 15,  25,  47;'
set @strfresh = @strfresh + ' 6: 15,     15, 15,  25,  55;'
set @strfresh = @strfresh + '11: 25,     20, 25,  35,  65;'
set @strfresh = @strfresh + '14: 40,     25, 30,  50,  80;'
set @strfresh = @strfresh + '20: 60,     30, 35,  65,  90;'
set @strfresh = @strfresh + '26:100,     35, 40,  85, 110;'
set @strfresh = @strfresh + '31:125,     40, 45,  95, 140;'
set @strfresh = @strfresh + '37:135,     45, 50, 100, 165;'
set @strfresh = @strfresh + '43:165,     50, 55, 105, 200;'
set @strfresh = @strfresh + '50:165,     55, 60, 110, 250;'

DECLARE @tItemExpire TABLE(
	itemcode	int,
	itemname	varchar(128),
	fresh		int
);

DECLARE @tItemExpire2 TABLE(
	itemcode	int,
	plusfreshfromin	int,
	famelv		int
);

insert into @tItemExpire
select itemcode, itemname, (param19 + param20 * 8) from dbo.tItemInfo where category = 1

insert into @tItemExpire2
select itemcode, param5 plusfreshfromin, param7 famelv from dbo.tItemInfo where subcategory = 62

--------------------------------------------------------
-- 1. 커서 생성
declare curTemp Cursor for
select * FROM dbo.fnu_SplitTwoStr(';', ':', @strfresh)

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @famelv, @datastr
while @@Fetch_status = 0
	Begin
		select @freshbase 	= listidx FROM dbo.fnu_SplitOne(',', @datastr) where idx = 0
		select @group1 		= listidx FROM dbo.fnu_SplitOne(',', @datastr) where idx = 1
		select @group2 		= listidx FROM dbo.fnu_SplitOne(',', @datastr) where idx = 2
		select @group3 		= listidx FROM dbo.fnu_SplitOne(',', @datastr) where idx = 3
		select @group4 		= listidx FROM dbo.fnu_SplitOne(',', @datastr) where idx = 4

		--------------------------------------
		-- 플러스 신선도.
		--------------------------------------
		set @plusfreshfromlv = @famelv/20 + 1
		select top 1 @plusfreshfromin = plusfreshfromin from @tItemExpire2 where famelv <= @famelv order by famelv desc
		select 	@famelv famelv, @freshbase freshbase,
				@group1 group1, @group1 - (@plusfreshfromlv + @plusfreshfromin),
				@group2 group2, @group2 - (@plusfreshfromlv + @plusfreshfromin),
				@group3 group3, @group3 - (@plusfreshfromlv + @plusfreshfromin),
				@group4 group4, @group4 - (@plusfreshfromlv + @plusfreshfromin),
				@plusfreshfromlv plusfreshfromlv, @plusfreshfromin plusfreshfromin


		--------------------
		-- 그룹1.
		--------------------
		set @group1		= case when @group1 > 55 then 55 else @group1 end
		set @needfresh 	= @group1
		set @needfresh = case when @needfresh < 15 then 15 else @needfresh end
		if(@mode = 1)
			begin
				select '그룹1' groupkind, rank() over(order by fresh desc) as number, @famelv famelv, @freshbase freshbase, @group1 group1, fresh + @plusfreshfromlv + @plusfreshfromin fresh2, fresh, itemcode, itemname from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 2)
			begin
				select '그룹1' groupkind, rank() over(order by fresh desc) as number, fresh, itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 3)
			begin
				-- 1.생성
				set @stritemcode = ''
				declare curItemCode Cursor for
				select itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh asc, itemcode asc

				-- 2. 오픈
				open curItemCode

				-- 3. 사용
				Fetch next from curItemCode into @itemcode
				while @@Fetch_status = 0
					begin
						set @stritemcode = @stritemcode + ltrim(rtrim(str(@itemcode))) + '	'
					Fetch next from curItemCode into @itemcode
				end

				-- 4. 커서닫기
				close curItemCode
				Deallocate curItemCode

				select @stritemcode group1
			end

		--------------------
		-- 그룹2.
		--------------------
		set @group2		= case when @group2 > 65 then 65 else @group2 end
		set @needfresh 	= @group2
		if(@mode = 1)
			begin
				select '그룹2' groupkind, rank() over(order by fresh desc) as number, @famelv famelv, @freshbase freshbase, @group2 group2, fresh + @plusfreshfromlv + @plusfreshfromin fresh2, fresh, itemcode, itemname from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 2)
			begin
				select '그룹2' groupkind, rank() over(order by fresh desc) as number, fresh, itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 3)
			begin
				-- 1.생성
				set @stritemcode = ''
				declare curItemCode Cursor for
				select itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh asc, itemcode asc

				-- 2. 오픈
				open curItemCode

				-- 3. 사용
				Fetch next from curItemCode into @itemcode
				while @@Fetch_status = 0
					begin
						set @stritemcode = @stritemcode + ltrim(rtrim(str(@itemcode))) + '	'
					Fetch next from curItemCode into @itemcode
				end

				-- 4. 커서닫기
				close curItemCode
				Deallocate curItemCode

				select @stritemcode group2
			end

		--------------------
		-- 그룹3.
		--------------------
		set @needfresh 	= @group3
		if(@mode = 1)
			begin
				select '그룹3' groupkind, rank() over(order by fresh desc) as number, @famelv famelv, @freshbase freshbase, @group3 group3, fresh + @plusfreshfromlv + @plusfreshfromin fresh2, fresh, itemcode, itemname from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 2)
			begin
				select '그룹3' groupkind, rank() over(order by fresh desc) as number, fresh, itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 3)
			begin
				-- 1.생성
				set @stritemcode = ''
				declare curItemCode Cursor for
				select itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh asc, itemcode asc

				-- 2. 오픈
				open curItemCode

				-- 3. 사용
				Fetch next from curItemCode into @itemcode
				while @@Fetch_status = 0
					begin
						set @stritemcode = @stritemcode + ltrim(rtrim(str(@itemcode))) + '	'
					Fetch next from curItemCode into @itemcode
				end

				-- 4. 커서닫기
				close curItemCode
				Deallocate curItemCode

				select @stritemcode group3
			end

		--------------------
		-- 그룹4.
		--------------------
		set @needfresh 	= @group4
		if(@mode = 1)
			begin
				select '그룹4' groupkind, rank() over(order by fresh desc) as number, @famelv famelv, @freshbase freshbase, @group4 group4, fresh + @plusfreshfromlv + @plusfreshfromin fresh2, fresh, itemcode, itemname from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 2)
			begin
				select '그룹4' groupkind, rank() over(order by fresh desc) as number, fresh, itemcode from @tItemExpire
				where fresh <= @needfresh
				order by fresh desc, itemcode asc
			end
		else if(@mode = 3)
			begin
				-- 1.생성
				set @stritemcode = ''
				set @stritemfresh	= ''
				declare curItemCode Cursor for
				select itemcode, fresh from @tItemExpire
				where fresh <= @needfresh
				order by fresh asc, itemcode asc

				-- 2. 오픈
				open curItemCode

				-- 3. 사용
				Fetch next from curItemCode into @itemcode, @fresh
				while @@Fetch_status = 0
					begin
						set @stritemcode = @stritemcode + ltrim(rtrim(str(@itemcode))) + '	'
						set @stritemfresh = @stritemfresh + ltrim(rtrim(str(@fresh))) + '	'
					Fetch next from curItemCode into @itemcode, @fresh
				end

				-- 4. 커서닫기
				close curItemCode
				Deallocate curItemCode

				select @stritemcode group4

				select @stritemfresh stritemfresh
			end

		Fetch next from curTemp into @famelv, @datastr
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp