
/*
declare @gameid 	varchar(20)
declare @giftid 	varchar(20)
declare @rank 		int
declare @cnt 		int
declare @posNext 	int,
		@strLen		int
declare @strTemp 	VARCHAR(8000) 	-- 분리된 문자열 임시 저장변수
declare @strValue_ 	VARCHAR(8000)
declare @sendid 	VARCHAR(20)



-- 1. 선언하기.
declare curTemp Cursor for
--select gameid, giftid from dbo.tGiftList where giftid like '백승0515_%' and itemcode = 3600
--select gameid, giftid from dbo.tGiftList where giftid like '백승0520_%' and itemcode = 3600
select gameid, giftid from dbo.tGiftList where giftid like '백승0522_%' and itemcode = 3600
order by giftid asc
-- select * from dbo.tGiftList where giftid like '백승0520_%' or giftid = '추가지급' order by gameid asc
-- select * from dbo.tGiftList where giftid like '백승0522_%' or giftid = '추가지급2' order by gameid asc


-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid, @giftid
while @@Fetch_status = 0
	Begin

		--set @giftid = '백승0515_1000'
		set @posNext 	= 1 	-- 구분문자 위치
		set @strValue_	= @giftid
		set @strValue_	= LTrim(RTrim(@strValue_))
		set @strLen		= len(@strValue_)
		set @posNext 	= CHARINDEX('_', @strValue_, 1)
		set @strTemp = RIGHT(@strValue_, @strLen - @posNext )
		set @rank = convert( int, @strTemp )
		set @sendid	= '추가지급2'
		--select 'DEBUG ', @gameid, @giftid, @rank

		if(@rank >= 1 and @rank <= 1)
			begin
				exec spu_SubGiftSendNew 2, 3600, 50, @sendid, @gameid, ''
				exec spu_SubGiftSendNew 2, 3500, 50, @sendid, @gameid, ''
			end
		else if(          @rank <= 5)
			begin
				exec spu_SubGiftSendNew 2, 3600, 60, @sendid, @gameid, ''
				exec spu_SubGiftSendNew 2, 3500, 60, @sendid, @gameid, ''
			end
		else if(          @rank <= 10)
			begin
				exec spu_SubGiftSendNew 2, 3600, 60, @sendid, @gameid, ''
				exec spu_SubGiftSendNew 2, 3500, 60, @sendid, @gameid, ''
			end
		else if(          @rank <= 100)
			begin
				exec spu_SubGiftSendNew 2, 3600, 30, @sendid, @gameid, ''
				exec spu_SubGiftSendNew 2, 3500, 30, @sendid, @gameid, ''
			end
		else
			begin
				exec spu_SubGiftSendNew 2, 3600, 20, @sendid, @gameid, ''
				exec spu_SubGiftSendNew 2, 3500, 20, @sendid, @gameid, ''
			end

		Fetch next from curTemp into @gameid, @giftid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/



/*

declare @gameid 	varchar(20)
declare @cnt 		int
declare @cashcost	int

-- 1. 선언하기.
declare curTemp Cursor for
select gameid from dbo.tRouletteLogPerson where itemcode0 = 0 --and gameid = 'farm3967580'
group by gameid

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		select 'DEBUG ', @gameid
		exec spu_SubGiftSendNew 2,  2200, 1, '교배 보상 지급', @gameid, ''
		exec spu_SubGiftSendNew 1,    -1, 0, '교배 보상 지급', @gameid, '동물 교배에서 동물이 안나온것으로 확인되어 티켓으로 다시 보내드립니다. 이용에 불편을 드려서 죄송합니다.'

		Fetch next from curTemp into @gameid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/