use Game4Farmvill5
GO

declare @grademax			int,
		@idx				int,
		@idx2				int,
		@farmidx			int,
		@itemcode			int,
		@itemcodebef		int,
		@rand				int,
		@grade				int,
		@subcategory		int,
		@stritemcode		varchar(1024),
		@mode				int


-- 1 : 동물을 신선도 별로 정령.
-- 2 : 합성, 승급에서 출력용 정보.
set @mode		= 1
set @grademax	= 6
set @stritemcode= ''

DECLARE @tItemExpire TABLE(
	idx			int 		IDENTITY(1, 1) PRIMARY KEY,
	itemcode	int,
	grade		int,
	itemname	varchar(128),
	fresh		int,
	fresh10p	int,
	freshbase	int,
	freshconst	int,
	opendange	int,
	subcategory	int,
	farmidx		int		default(-1),
	rewardex1	int		default(-1)
);

DECLARE @tItemExpire2 TABLE(
	idx			int 		IDENTITY(1, 1) PRIMARY KEY,
	itemcode	int,
	grade		int,
	itemname	varchar(128),
	fresh		int,
	fresh10p	int,
	freshbase	int,
	freshconst	int,
	opendange	int,
	farmidx		int,
	rewardex1	int,
	ordergroup	int
);


DECLARE @tItemExpire3 TABLE(
	idx			int 		IDENTITY(1, 1) PRIMARY KEY,
	itemcode	int,
	idx2		int,
	ordergroup	int
);

-- 0. 동물을 계산해서 넣어주기.
insert into @tItemExpire (itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, subcategory)
select itemcode, grade, itemname, param19 + param20 * 8, param19 + param20 * 8 + (param19 + param20 * 8)* 10 / 100, param19, param20, houselv, subcategory from dbo.tItemInfo
where subcategory in (1, 2, 3)
	and itemname not like '%미정%'
	and itemcode not in (22, 30, 31, 32, 128, 129, 130, 228, 229, 230)


if(@mode = 1)
	begin

		-------------------------------------
		-- 1-1. 목장정보 순서갱신.
		-------------------------------------
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 1  from dbo.tItemInfo where subcategory = 69 and itemcode >= 6900 and itemcode <= 6929
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 21 from dbo.tItemInfo where subcategory = 69 and itemcode >  6929 and itemcode <= 6943
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 22 from dbo.tItemInfo where subcategory = 69 and itemcode >  6929 and itemcode <= 6943
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 31 from dbo.tItemInfo where subcategory = 69 and itemcode >  6943 and itemcode <= 6952
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 32 from dbo.tItemInfo where subcategory = 69 and itemcode >  6943 and itemcode <= 6952
		insert into @tItemExpire3 (itemcode, ordergroup) select itemcode, 33 from dbo.tItemInfo where subcategory = 69 and itemcode >  6943 and itemcode <= 6952

		set @idx2 = 1

		-- 1. 선언하기.
		declare curFarmOrder Cursor for
		select idx from @tItemExpire3 order by itemcode asc

		-- 2. 커서오픈
		open curFarmOrder

		-- 3. 커서 사용
		Fetch next from curFarmOrder into @idx
		while @@Fetch_status = 0
			Begin
				update @tItemExpire3 set idx2 = @idx2 where idx = @idx

				set @idx2 = @idx2 + 1
				Fetch next from curFarmOrder into @idx
			end

		-- 4. 커서닫기
		close curFarmOrder
		Deallocate curFarmOrder

		-------------------------------------
		-- 2-1. 목장정보 -> 동물정보에 입력하기.
		-------------------------------------
		set @idx2 = 1

		-- 1. 선언하기.
		declare curAnimalToFarm Cursor for
		select idx, grade, itemcode, subcategory from @tItemExpire order by fresh asc
		--select 'DEBUG ', * from @tItemExpire order by idx asc

		-- 2. 커서오픈
		open curAnimalToFarm

		-- 3. 커서 사용
		Fetch next from curAnimalToFarm into @idx, @grade, @itemcode, @subcategory
		while @@Fetch_status = 0
			Begin
				select @farmidx = itemcode from @tItemExpire3 where idx2 = @idx2

				--최하단을 제거하자.
				set @itemcode = case
									when ( @itemcode = 0   ) then @itemcode + 1
									when ( @itemcode = 100 ) then @itemcode + 1
									when ( @itemcode = 200 ) then @itemcode + 1
									else   @itemcode
								end

				set @itemcode = case
									when ( @grade <= 0 ) then @itemcode
									when ( @grade <= 1 ) then @itemcode -  (1 + 0)
									when ( @grade <= 2 ) then @itemcode -  (2 + 0)
									when ( @grade <= 3 ) then @itemcode -  (3 + 1)
									when ( @grade <= 4 ) then @itemcode -  (4 + 2)
									when ( @grade <= 5 ) then @itemcode -  (5 + 2)
									when ( @grade <= 6 ) then @itemcode -  (6 + 3)
									when ( @grade <= 7 ) then @itemcode -  (7 + 4)
									when ( @grade <= 8 ) then @itemcode -  (8 + 5)
									when ( @grade <= 9 ) then @itemcode -  (9 + 6)
									when ( @grade <= 10 ) then @itemcode - (10 + 7)
								end

				----------------------------
				-- 필터 1. 최대값 필터하기.
				----------------------------
				set @itemcode = case
									when ( @subcategory = 1 and @itemcode <=  4 ) then  4		-- 언더라인 체킹
									when ( @subcategory = 2 and @itemcode <= 102) then 102
									when ( @subcategory = 3 and @itemcode <= 200) then 200
									when ( @subcategory = 1 and @itemcode >= 12 ) then 12		-- 맥스 체킹
									when ( @subcategory = 2 and @itemcode >= 108) then 108
									when ( @subcategory = 3 and @itemcode >= 205) then 205
									else @itemcode
								end
				----------------------------
				-- 필터 2. 잘못된값을 조절하자.
				----------------------------
				if(not exists( select top 1 * from dbo.tItemInfo where itemcode = @itemcode ) )
					begin
						select 'ERROR > 찾을수 없음.', @idx, @grade, @itemcode, @subcategory, @farmidx farmidx, @itemcode itemcode
					end

				----------------------------
				-- 필터 3. 잘못된값을 조절하자.
				-- 반복해서 나오는 패턴을 없애자~~
				-- 12 108 205
				----------------------------
				if( @itemcode in ( 12, 108, 205 ) and @itemcodebef = @itemcode )
					begin

						set @rand	= Convert(int, ceiling(RAND() * 100))
						if( @itemcode = 12 )
							begin
								set @itemcode = case
													when @rand < 50 then 108
													else 				 205
												end
							end
						else if( @itemcode = 108 )
							begin
								set @itemcode = case
													when @rand < 50 then 12
													else 				 205
												end
							end
						else if( @itemcode = 205 )
							begin
								set @itemcode = case
													when @rand < 50 then 12
													else 				 108
												end
							end
					end
				set @itemcodebef = @itemcode


				update @tItemExpire
					set
						farmidx = @farmidx,
						rewardex1 = @itemcode
				where idx = @idx

				set @idx2 = @idx2 + 1
				Fetch next from curAnimalToFarm into @idx, @grade, @itemcode, @subcategory
			end

		-- 4. 커서닫기
		close curAnimalToFarm
		Deallocate curAnimalToFarm

		-------------------------------------
		-- 3-1. 동물정보 입력하기.
		-------------------------------------
		-- 1. 선언하기.
		declare curFreshAnimal Cursor for
		select grade from @tItemExpire group by grade order by grade asc

		-- 2. 커서오픈
		open curFreshAnimal

		-- 3. 커서 사용
		Fetch next from curFreshAnimal into @grade
		while @@Fetch_status = 0
			Begin
				if( @grade <= 3 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 1, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 4 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 11, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 12, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 5 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 15, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 16, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 6 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 21, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 22, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 23, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 7 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 25, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 26, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 27, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 8 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 31, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 32, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 33, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 34, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 9 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 41, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 42, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 43, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 44, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 45, rewardex1 from @tItemExpire where grade = @grade
					end
				else if( @grade <= 10 )
					begin
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 51, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 52, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 53, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 54, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 55, rewardex1 from @tItemExpire where grade = @grade
						insert into @tItemExpire2(itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, ordergroup, rewardex1) select itemcode, grade, itemname, fresh, fresh10p, freshbase, freshconst, opendange, farmidx, 56, rewardex1 from @tItemExpire where grade = @grade
					end
				Fetch next from curFreshAnimal into @grade
			end

		-- 4. 커서닫기
		close curFreshAnimal
		Deallocate curFreshAnimal


		--select 'DEBUG 1', * from @tItemExpire  order by fresh asc
		--select 'DEBUG 3', * from @tItemExpire3 order by itemcode asc
		--select 'DEBUG 2', * from @tItemExpire2 order by ordergroup asc, fresh asc
		select itemcode checkvalue2, farmidx checkvalue3, rewardex1, '--', * from @tItemExpire2 order by ordergroup asc, fresh asc
	end
else if(@mode = 2)
	begin
		select * from @tItemExpire where grade <= @grademax order by fresh asc

		-- 1.생성
		declare curItemCode Cursor for
		select itemcode from @tItemExpire where grade <= @grademax order by fresh asc

		-- 2. 오픈
		open curItemCode

		-- 3. 사용
		Fetch next from curItemCode into @itemcode
		while @@Fetch_status = 0
			begin
				set @stritemcode = @stritemcode + ltrim(rtrim(str(@itemcode))) + '^'
			Fetch next from curItemCode into @itemcode
		end

		-- 4. 커서닫기
		close curItemCode
		Deallocate curItemCode

		select 'DEBUG ', @grademax grademax, @stritemcode stritemcode
	end




