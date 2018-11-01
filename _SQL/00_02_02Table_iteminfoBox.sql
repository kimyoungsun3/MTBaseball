---------------------------------------------
--		아이템 정보
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tItemInfoPieceBox', N'U') IS NOT NULL
	DROP TABLE dbo.tItemInfoPieceBox;
GO

create table dbo.tItemInfoPieceBox(
	idx				int				IDENTITY(1,1), 		-- 번호

	itemcode		int, 								-- 아이템 코드
	category		int,								-- 카테고리
	subcategory		int, 								-- 서브 카테고리
	grade			int, 								-- 등급

	getbox			int				default(4000),
	getpercent1000	int				default(0),

	-- Constraint
	CONSTRAINT	pk_tItemInfoPieceBox_itemcode	PRIMARY KEY(itemcode, grade)
)

--------------------------------------------------------------------

declare @itemcode 		int,
		@category		int,
		@subcategory	int,
		@grade			int,
		@getbox			int,
		@getpercent1000	int,
		@totalpercent	int
declare @category2		int,
		@subcategory2	int,
		@grade2			int,
		@getbox2		int,
		@getpercent10002 int,
		@totalpercent2	int
set @grade2 		= -1
set @totalpercent	= 0

declare curItemPiece Cursor for
select itemcode, category, subcategory, grade, param1, param2 from dbo.tItemInfo where category = 15 order by grade asc, itemcode asc

Open curItemPiece
Fetch next from curItemPiece into @itemcode, @category, @subcategory, @grade, @getbox, @getpercent1000
while @@Fetch_status = 0
	Begin
		--select ' change0', @itemcode, @category, @subcategory, @grade, @getbox, @getpercent1000, @category2, @subcategory2, @grade2, @getbox2, @getpercent10002
		if( @grade != @grade2)
			begin
				--select ' change1', @itemcode, @category, @subcategory, @grade, @getbox, @getpercent1000, @category2, @subcategory2, @grade2, @getbox2, @getpercent10002
				set @totalpercent	= 0
				if(@grade2 >= 2)
					begin
						select ' change2', @itemcode, @category, @subcategory, @grade, @getbox, @getpercent1000, @category2, @subcategory2, @grade2, @getbox2, @getpercent10002
						set @totalpercent2 = @totalpercent2 + 390
						insert into dbo.tItemInfoPieceBox( itemcode,  category,   subcategory,   grade,   getbox,   getpercent1000)
						values(                                4600, @category2, @subcategory2, @grade2, @getbox2, @totalpercent2)

						--select 4600, @category2, @subcategory2, @grade2, @getbox2, @totalpercent2
					end
			end
			set @totalpercent = @totalpercent + @getpercent1000

			insert into dbo.tItemInfoPieceBox(itemcode,  category,  subcategory,  grade,  getbox,  getpercent1000)
			values(                          @itemcode, @category, @subcategory, @grade, @getbox, @totalpercent)


		set @grade2			= @grade
		set @category2		= @category
		set @subcategory2	= @subcategory
		set @getbox2		= @getbox
		set @totalpercent2	= @totalpercent
		Fetch next from curItemPiece into @itemcode, @category, @subcategory, @grade, @getbox, @getpercent1000
	end
close curItemPiece
Deallocate curItemPiece

set @totalpercent2 = @totalpercent2 + 390
insert into dbo.tItemInfoPieceBox( itemcode,  category,   subcategory,   grade,   getbox,   getpercent1000)
values(                                4600, @category2, @subcategory2, @grade2, @getbox2, @totalpercent2)


-- select * from dbo.tItemInfo where category = 15 order by category asc, grade asc
-- select grade, sum(param2) from dbo.tItemInfo where category = 15 group by grade
-- select * from dbo.tItemInfoPieceBox order by category asc, grade asc
-- select * from dbo.tItemInfoPieceBox order by getpercent1000 desc, grade asc
-- select a.*, param2, b.itemname from dbo.tItemInfoPieceBox a, tItemInfo b where a.itemcode = b.itemcode order by grade asc, itemcode asc




