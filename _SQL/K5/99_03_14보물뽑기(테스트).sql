use GameMTBaseball
GO

declare @gameid_		varchar(20),
		@password_		varchar(20),
		@mode			int
declare @dateid8 		varchar(8)
declare @loopmax 		int
declare @curloop		int
declare @famelv			int
declare @idx			int


set @mode			= 4		-- �Ϲݻ̱�(1), ���̱�(2), ���̱�10(4)
set @loopmax		= 1000


set @famelv			= 1
set @dateid8 		= Convert(varchar(8),Getdate(),112)
set @gameid_		= 'xxxx2'
set @password_		= '049000s1i0n7t8445289'
delete from dbo.tTreasureLogTotalMaster where dateid8 = @dateid8	-- ��ü�̱�
delete from dbo.tTreasureLogTotalSub where dateid8 = @dateid8		-- ��ü�̱�

while(@famelv <= 70)
	begin
		set @curloop 		= 1

		--------------------------------------------------
		-- 	��������Ÿ ����.
		--------------------------------------------------
		delete from dbo.tGiftList where gameid = @gameid_					-- ���μ���
		delete from dbo.tTreasureLogPerson where gameid = @gameid_			-- ���λ̱�

		while(@curloop <= @loopmax)
			begin
				update dbo.tUserMaster set famelv = @famelv, cashcost = 1000000, gamecost = 1000000, heart = 5000000, randserial = -1 where gameid = @gameid_


				exec spu_RoulTreasureBuyNewTest @gameid_, @password_, @mode, @curloop, -1
				set @curloop = @curloop + 1
			end

		select @famelv famelv
		exec spu_GameMTBaseballD 19, 433,-1, -1, -1, -1, -1, -1, -1, -1, '', @dateid8, '', '', '', '', '', '', '', ''				-- ���� �̱������ ���

		set @famelv = case
							when @famelv <=  1 then  6
							when @famelv <=  6 then 11
							when @famelv <= 11 then 14
							when @famelv <= 14 then 20
							when @famelv <= 20 then 26
							when @famelv <= 26 then 31
							when @famelv <= 31 then 37
							when @famelv <= 37 then 43
							when @famelv <= 43 then 48
							when @famelv <= 48 then 50
							when @famelv <= 53 then 58
							when @famelv <= 58 then 60
							when @famelv <= 63 then 68
							when @famelv <= 68 then 70
							else 					99
					end
	end




/*
-- ȹ�� ������ �־��.
declare @dateid8 	varchar(8)		set @dateid8 	= Convert(varchar(8),Getdate(),112)
declare @gameid		varchar(20)		set @gameid		= 'farm939085910'
declare @itemcode	int				set @itemcode	= -1

-- 1. Ŀ�� ����
declare curRoulInsert Cursor for
select itemcode from dbo.tRouletteLogTotalSub where dateid8 = @dateid8

-- 2. Ŀ������.
open curRoulInsert

-- 3. Ŀ�� ���
Fetch next from curRoulInsert into @itemcode
while @@Fetch_status = 0
	Begin
		exec spu_SubGiftSend 2,     @itemcode, 'SysLogin', @gameid, ''
		Fetch next from curRoulInsert into @itemcode
	end

-- 4. Ŀ���ݱ�
close curRoulInsert
Deallocate curRoulInsert
*/

