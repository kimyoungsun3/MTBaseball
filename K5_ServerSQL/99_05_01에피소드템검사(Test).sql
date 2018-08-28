use Game4Farmvill5
GO

declare @itemcode			int,
		@itemname			varchar(40),
		@reward11			int,
		@reward21			int, 			@reward22			int,
		@reward31			int, 			@reward32			int,		@reward33			int,
		@reward41			int, 			@reward42			int,		@reward43			int,		@reward44			int,
		@rewardcnt11		int,
		@rewardcnt21		int, 			@rewardcnt22		int,
		@rewardcnt31		int, 			@rewardcnt32		int,		@rewardcnt33		int,
		@rewardcnt41		int, 			@rewardcnt42		int,		@rewardcnt43		int,		@rewardcnt44		int,
		@reward11name		varchar(40),
		@reward21name		varchar(40), 	@reward22name		varchar(40),
		@reward31name		varchar(40), 	@reward32name		varchar(40),@reward33name		varchar(40),
		@reward41name		varchar(40), 	@reward42name		varchar(40),@reward43name		varchar(40),@reward44name		varchar(40)


DECLARE @tItemTable TABLE(
	itemcode int,  itemname varchar(400),
	reward11 int, reward11name varchar(400),
	reward21 int, reward21name varchar(400),		reward22 int, reward22name varchar(400),
	reward31 int, reward31name varchar(400),		reward32 int, reward32name varchar(400),		reward33 int, reward33name varchar(400),
	reward41 int, reward41name varchar(400),		reward42 int, reward42name varchar(400),		reward43 int, reward43name varchar(400),		reward44 int, reward44name varchar(400)
);


--------------------------------------------------------
-- 1. 커서 생성
declare curTemp Cursor for
select itemcode, itemname, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14 FROM dbo.tItemInfo where subcategory = 910

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @itemcode, @itemname, @reward11, @reward21, @reward22, @reward31, @reward32, @reward33, @reward41, @reward42, @reward43, @reward44
while @@Fetch_status = 0
	Begin
		set @reward11name = ''

		select @reward11name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward11

		set @reward21name = ''
		set @reward22name = ''
		select @reward21name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward21
		select @reward22name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward22

		set @reward31name = ''
		set @reward32name = ''
		set @reward33name = ''
		select @reward31name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward31
		select @reward32name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward32
		select @reward33name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward33

		set @reward41name = ''
		set @reward42name = ''
		set @reward43name = ''
		set @reward44name = ''
		select @reward41name = itemname + ' x '+  case when (@reward41 < 300) then ltrim(str((param19 + param20 * 8 + (param19 + param20 * 8)* 10 / 100))) else ltrim(str(buyamount)) end FROM dbo.tItemInfo where itemcode = @reward41
		select @reward42name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward42
		select @reward43name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward43
		select @reward44name = itemname + ' x '+ ltrim(str(buyamount)) FROM dbo.tItemInfo where itemcode = @reward44

		insert into @tItemTable
		select  @itemcode itemcode, @itemname itemname,
				@reward11 reward11, @reward11name reward11name,
				@reward21 reward21, @reward21name reward21name,		@reward22 reward22, @reward22name reward22name,
				@reward31 reward31, @reward31name reward31name,		@reward32 reward32, @reward32name reward32name,		@reward33 reward33, @reward33name reward33name,
				@reward41 reward41, @reward41name reward41name,		@reward42 reward42, @reward42name reward42name,		@reward43 reward43, @reward43name reward43name,			@reward44 reward44, @reward44name reward44name

		Fetch next from curTemp into @itemcode, @itemname, @reward11, @reward21, @reward22, @reward31, @reward32, @reward33, @reward41, @reward42, @reward43, @reward44
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp

select * from @tItemTable