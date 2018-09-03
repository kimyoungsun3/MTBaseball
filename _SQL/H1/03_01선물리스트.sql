/* 
--���� ����Ʈ 
exec spu_GiftList 1, ''
--����������� ����Ʈ
exec spu_GiftList 2, ''
exec spu_GiftList 2, 'SangSang'
select top 10 * from dbo.tGiftList order by idx desc
select top 10 * from dbo.tGiftList order by giftdate desc
*/

IF OBJECT_ID ( 'dbo.spu_GiftList', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GiftList;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GiftList
	@kind_			int,
	@gameid_		varchar(20)
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	
	------------------------------------------------
	--	���ν��� ����
	------------------------------------------------
	declare @KIND_GIFTLIST_ITEMINFO	int			set @KIND_GIFTLIST_ITEMINFO		= 1
	declare @KIND_GIFTLIST_SENDLIST	int			set @KIND_GIFTLIST_SENDLIST		= 2

	------------------------------------------------
	--	�Ϲݺ�������
	------------------------------------------------
	declare @str	varchar(40)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	
	------------------------------------------------
	--	3-2. ����
	------------------------------------------------
	BEGIN
		if(@kind_ in (@KIND_GIFTLIST_ITEMINFO))
			begin
				--and itemcode not in (100, 123, 146, 149, 200, 223, 246, 249, 300, 323, 346, 349, 400)
				declare @tTempTable table(itemcode int)
				insert into @tTempTable select param1 from dbo.tItemInfo where kind = 0
				insert into @tTempTable select param2 from dbo.tItemInfo where kind = 0
				insert into @tTempTable select param3 from dbo.tItemInfo where kind = 0
				insert into @tTempTable select param4 from dbo.tItemInfo where kind = 0
				insert into @tTempTable select param5 from dbo.tItemInfo where kind = 0

				select * from dbo.tItemInfo
				where kind in (2, 4, 5, 6, 7, 8 , 9, 100, 80, 90, 102)
				and itemcode not in(select itemcode from @tTempTable)
				and sex != 0
				order by itemcode asc
			end
		else if(@kind_ in (@KIND_GIFTLIST_SENDLIST))
			begin
				if(isnull(@gameid_, '') = '')
					begin
						select a.idx idx2, gameid, gainstate, gaindate, giftid, giftdate, a.period2, a.upgradestate2, b.* 
						from (select top 100 * from dbo.tGiftList order by giftdate desc) a
							INNER JOIN 
							dbo.tItemInfo b 
							ON a.itemcode = b.itemcode
						order by giftdate desc
					end
				else
					begin
						set @str = @gameid_ + '%'
						select a.idx idx2, gameid, gainstate, gaindate, giftid, giftdate, a.period2, a.upgradestate2, b.* from
							(select top 100 * from dbo.tGiftList where gameid like @str order by giftdate desc) a  
							INNER JOIN
							dbo.tItemInfo b
							ON a.itemcode = b.itemcode
						order by giftdate desc
					end
			end
	END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End
