/*
-- �귿 ���� ������.
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	5000, 3000	-- ��񱤰�
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	3500,  200	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	2300,    6	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	5100,12000	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	3600,  200	--
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_WheelAdLogNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_WheelAdLogNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_WheelAdLogNew
	@gameid_								varchar(20),
	@nickname_								varchar(40),
	@mode_									int,
	@itemcode_								int,
	@cnt_									int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--���μ���(51)

	declare @IDX_MAX							int 				set @IDX_MAX								= 100

	declare @MODE_WHEEL							int					set @MODE_WHEEL								= 101

	------------------------------------------------
	--
	------------------------------------------------
	declare @comment				varchar(128)
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @category				int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	if( @mode_ = @MODE_WHEEL and @itemcode_ != -1 and @cnt_ > 0 )
		begin
			----------------------------------------
			-- ������ �̸��� �˻� > �Է�.
			-- []�� ����� �����ϼ���.~ -> NGUI UI_Lablel���� ������ ����� �ƻ��ϰ� ����.
			-- ������ : [xxxx2]���� [xxxx]�� �����̾� ����� ������ϴ�.
			-- ��  �� : {xxxx2}���� xxxx�� [ff00ff]�����̾� ����[-]�� ������ϴ�.
			----------------------------------------
			select @category = category, @itemname = itemname from dbo.tItemInfo where itemcode = @itemcode_

			if( @category = @ITEM_MAINCATEGORY_GAMECOST )
				begin
					--select 'DEBUG Ȳ�ݷ귿'
					set @comment = @nickname_ + '���� [FFE23B]�Ϲݷ귿[-]�� ���� [ff00ff]{'+ @itemname +' x ' + ltrim(str(@cnt_)) +'��}�� ȹ��[-]�߽��ϴ�.'

				end
			else
				begin
					set @comment = @nickname_ + '���� [FFE23B]�Ϲݷ귿[-]�� ���� [ff00ff]{'+ @itemname +' x ' + ltrim(str(@cnt_)) +'��}�� ȹ��[-]�߽��ϴ�.'
				end

			insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,   mode,   comment)
			values(                    @gameid_, @nickname_, @itemcode_, @mode_, @comment)
		end


	-- �������� �̻��� ������Ŵ
	select @idx = max(idx) from dbo.tUserAdLog
	delete from dbo.tUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End