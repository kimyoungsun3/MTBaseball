---------------------------------------------------------------
/*
----------------------------------------
-- �⵿̱��/���� (�̱�).
----------------------------------------
delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind in (1, 1200, 1040)
exec spu_SetDirectItemNew 'xxxx2', 1, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 4, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 7, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 10, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 13, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 16, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 20, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 26, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 220, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 224, 1, 3, -1
exec spu_SetDirectItemNew 'xxxx2', 120010, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120011, 1, 3, -1		exec spu_SetDirectItemNew 'xxxx2', 120012, 1, 3, -1		exec spu_SetDirectItemNew 'xxxx2', 120013, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120014, 1, 3, -1	exec spu_SetDirectItemNew 'xxxx2', 120015, 1, 3, -1		-- �̱⺸��.
update dbo.tUserMaster set randserial = -1 where gameid = 'xxxx2'

-- ��������.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:25;', 										 '7771', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:34;3:26;4:27;5:28;6:29;7:30;8:31;9:32;10:33;', '7772', -1


-- ��������.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 2, '1:35;', 										 '7773', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 2, '1:36;2:37;3:38;4:39;5:40;', 					 '7774', -1

----------------------------------------
--�������ŵ���(1), ��������(17).
----------------------------------------
delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind in (1, 1200, 1040)
exec spu_SetDirectItemNew 'xxxx2', 1, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1
exec spu_SetDirectItemNew 'xxxx2', 22, 1, 17, -1	exec spu_SetDirectItemNew 'xxxx2', 22, 1, 17, -1
update dbo.tUserMaster set randserial = -1 where gameid = 'xxxx2'

-- ��������.
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:25;', '7781', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:26;', '7782', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:27;2:28;2:29;', '7783', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '1:30;', '7785', -1
exec spu_ApartItemcode 'xxxx2', '049000s1i0n7t8445289', 1, '2:31;', '7786', -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ApartItemcode', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ApartItemcode;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ApartItemcode
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@listset_				varchar(256),
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int					set @USERITEM_INVENKIND_TREASURE			= 1200

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.

	-- ���ظ��.
	declare @MODE_APART_ANIMAL					int					set @MODE_APART_ANIMAL						= 1		-- ��������.
	declare @MODE_APART_TREASURE				int					set @MODE_APART_TREASURE					= 2		-- ��������.

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--����
	declare @DEFINE_HOW_GET_ANIMAL_APART		int					set @DEFINE_HOW_GET_ANIMAL_APART			= 15	-- ��������.
	declare @DEFINE_HOW_GET_TREASURE_APART		int					set @DEFINE_HOW_GET_TREASURE_APART			= 16	-- ��������.
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--���ẹ��.

	-- ��Ÿ���.
	declare @GIVE_STEMCELL_DONT					int					set @GIVE_STEMCELL_DONT						= -1	-- ����������������.
	declare @GIVE_STEMCELL_GIVE					int					set @GIVE_STEMCELL_GIVE						=  1	-- ��������.
	declare @APARY_BUY_CNT_MAX					int					set @APARY_BUY_CNT_MAX						= 2000	-- ���� �̻��̸� �����ϳ��ش�.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- ��������.
	declare @cashcost		int				set @cashcost		= 0
	declare @gamecost		int				set @gamecost		= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'

	declare @invenkind		int				set @invenkind		= -1
	declare @sendgethow		int				set @sendgethow	 	= @DEFINE_HOW_GET_ANIMAL_APART
	declare @senditemcode	int				set @senditemcode	= -1
	declare @gradeorg		int				set @gradeorg	 	= -1
	declare @grade			int				set @grade	 		= -1
	declare @rtnlistidx 	int				set @rtnlistidx		= -1
	declare @cnt			int				set @cnt	 		= 0
	declare @delmode		int				set @delmode	 	= 4
	declare @apartbuycnt	int				set @apartbuycnt	= 0
	declare @gethow			int				set @gethow			= @DEFINE_HOW_GET_BUY
	declare @itemcode		int				set @itemcode		= -1
	declare @givestemcell	int				set @givestemcell	= @GIVE_STEMCELL_GIVE
	declare @needgamecost	int
	declare @needcashcost	int
	declare @plusgamecost	int				set @plusgamecost	= 0
	declare @sellgamecost	int				set @sellgamecost	= 0
	declare @tstrigger		int				set @tstrigger		= 1

	declare @kind			int
	declare @info			int
	declare @loopidx		int
	declare @loopmax		int
	declare @bgroul1		int				set @bgroul1	 	= -1
	declare @bgroul2		int				set @bgroul2	 	= -1
	declare @bgroul3		int				set @bgroul3	 	= -1
	declare @bgroul4		int				set @bgroul4	 	= -1
	declare @bgroul5		int				set @bgroul5	 	= -1
	declare @bgroul6		int				set @bgroul6	 	= -1
	declare @bgroul7		int				set @bgroul7	 	= -1
	declare @bgroul8		int				set @bgroul8	 	= -1
	declare @bgroul9		int				set @bgroul9	 	= -1
	declare @bgroul10		int				set @bgroul10	 	= -1
	declare @bgroul11		int				set @bgroul11	 	= -1
	declare @bgroul12		int				set @bgroul12	 	= -1
	declare @bgroul13		int				set @bgroul13	 	= -1
	declare @bgroul14		int				set @bgroul14	 	= -1
	declare @bgroul15		int				set @bgroul15	 	= -1
	declare @bgroul16		int				set @bgroul16	 	= -1
	declare @bgroul17		int				set @bgroul17	 	= -1
	declare @bgroul18		int				set @bgroul18	 	= -1
	declare @bgroul19		int				set @bgroul19	 	= -1
	declare @bgroul20		int				set @bgroul20	 	= -1
	declare @apartcnt		int				set @apartcnt	 	= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listset_ listset_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 	= gameid,		@cashcost	= cashcost, 	@gamecost	= gamecost, 	@apartbuycnt= apartbuycnt,
		@bgroul1 	= bgroul1,		@bgroul2 	= bgroul2,		@bgroul3 	= bgroul3,		@bgroul4 = bgroul4,		@bgroul5 = bgroul5,
		@bgroul6 	= bgroul6,		@bgroul7 	= bgroul7,		@bgroul8 	= bgroul8,		@bgroul9 = bgroul9,		@bgroul10= bgroul10,
		@bgroul11 	= bgroul11,		@bgroul12 	= bgroul12,		@bgroul13 	= bgroul13,		@bgroul14 = bgroul14,	@bgroul15 = bgroul15,
		@bgroul16 	= bgroul16,		@bgroul17 	= bgroul17,		@bgroul18 	= bgroul18,		@bgroul19 = bgroul19,	@bgroul20= bgroul20,
		@randserial	= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @randserial randserial

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ not in (@MODE_APART_ANIMAL, @MODE_APART_TREASURE ) )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( LEN( @listset_ ) < 3 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment 	= 'ERROR ����Ʈ ��ȣ�� ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �����߽��ϴ�.(����)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.'
			--select 'DEBUG ' + @comment

			-- �κ��� ����.
			if( @mode_ = @MODE_APART_ANIMAL )
				begin
					set @invenkind 	= @USERITEM_INVENKIND_ANI
					set @sendgethow	= @DEFINE_HOW_GET_ANIMAL_APART
					set @delmode	= 4
					--select 'DEBUG ��������', @mode_ mode_, @invenkind invenkind, @sendgethow sendgethow
				end
			else
				begin
					set @invenkind = @USERITEM_INVENKIND_TREASURE
					set @sendgethow	= @DEFINE_HOW_GET_TREASURE_APART
					set @delmode	= 5
					--select 'DEBUG ��������', @mode_ mode_, @invenkind invenkind, @sendgethow sendgethow
				end

			-- ����Ʈ ��ȣ �ʱ�ȭ.
			set @bgroul1	 	= -1
			set @bgroul2	 	= -1
			set @bgroul3	 	= -1
			set @bgroul4	 	= -1
			set @bgroul5	 	= -1
			set @bgroul6	 	= -1
			set @bgroul7	 	= -1
			set @bgroul8	 	= -1
			set @bgroul9	 	= -1
			set @bgroul10	 	= -1
			set @bgroul11	 	= -1
			set @bgroul12	 	= -1
			set @bgroul13	 	= -1
			set @bgroul14	 	= -1
			set @bgroul15	 	= -1
			set @bgroul16	 	= -1
			set @bgroul17	 	= -1
			set @bgroul18	 	= -1
			set @bgroul19	 	= -1
			set @bgroul20	 	= -1

			------------------------------------------------------------------
			-- ��ȭ�������ֱ�.
			------------------------------------------------------------------
			-- 1. Ŀ�� ����
			declare curApartItemcode Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. Ŀ������
			open curApartItemcode

			-- 3. Ŀ�� ���
			Fetch next from curApartItemcode into @kind, @info
			while @@Fetch_status = 0
				Begin
					-- ���������ϱ��� �ʱ�ȭ.
					set @senditemcode	= -1
					set @grade			= -1
					set @gradeorg		= -1
					set @itemcode		= -1
					set @rtnlistidx		= -1
					set @gethow			= @DEFINE_HOW_GET_BUY
					set @sellgamecost	= 0
					set @tstrigger		= 1

					-- ������ ���� Ȯ���غ���.
					select @itemcode = itemcode, @gethow = gethow from dbo.tUserItem
					where gameid = @gameid_ and listidx = @info and invenkind = @invenkind

					-- ����/���� -> ��޺���
					select
						@gradeorg		= grade,
						@needgamecost 	= gamecost,
						@needcashcost 	= cashcost,
						@sellgamecost	= sellcost,
						@tstrigger		= param5
					from dbo.tItemInfo where itemcode = @itemcode
					--select 'DEBUG > ����, ���� ���.', @kind kind, @info listidx, @gradeorg gradeorg, @itemcode itemcode, @gethow gethow, @needgamecost needgamecost, @needcashcost needcashcost

					if( @itemcode != -1 and @gradeorg != -1 )
						begin
							set @apartcnt = @apartcnt + 1
							--------------------------------------
							--> ����� ���� or ���� ���� ����
							--------------------------------------
							exec spu_DeleteUserItemBackup @delmode, @gameid_, @info
							--select 'DEBUG > ����, ���� ������(�����)'

							---------------------------------
							-- ���� ����ȿ�� ����.
							-- �����߿� ������(2)
							-- ������ �ϸ� �����ϴ� �κ� �ȿ��� �翬�� �ؼ� ���η� �������...
							---------------------------------
							if( @mode_ = @MODE_APART_TREASURE and @tstrigger = 2 )
								begin
									exec spu_TSRetentionEffect @gameid_, @itemcode
								end

							------------------------------------------------------------------
							-- ��������
							--		> xx�� ���� �ݾ� �̻� ���Ž� �ٲ���
							-- ��������
							--		> ��������.
							------------------------------------------------------------------
							set @givestemcell = @GIVE_STEMCELL_GIVE
							if( @gethow = @DEFINE_HOW_GET_BUY )
								begin
									set @apartbuycnt = @apartbuycnt + case
																			when ( @needcashcost > 0  ) then 99999
																			when ( @needgamecost <= 0 ) then 0
																			else						     @needgamecost
																	  end
									--select 'DEBUG  > ���ŵ���', @apartbuycnt apartbuycnt, @needcashcost needcashcost, @needgamecost needgamecost

									if( @apartbuycnt >= @APARY_BUY_CNT_MAX )
										begin
											--select 'DEBUG  > �����ƽ��� ����'
											set @givestemcell 	= @GIVE_STEMCELL_GIVE
											set @apartbuycnt	= 0
										end
									else
										begin
											--select 'DEBUG  > ���������̶� ������'
											set @givestemcell 	= @GIVE_STEMCELL_DONT
											set @plusgamecost 	= @plusgamecost + @sellgamecost * 80 / 100
										end

								end
							else if( @gethow = @DEFINE_HOW_GET_FREEANIRESTORE )
								begin
									--select 'DEBUG  > ��������(�׳��н�)'
									set @givestemcell 	= @GIVE_STEMCELL_DONT
									set @plusgamecost 	= 1
								end
							--else
							--	begin
							--		set @givestemcell = @GIVE_STEMCELL_GIVE
							--	end
							--select 'DEBUG  > ���޻���', @givestemcell givestemcell



							--------------------------------------
							-- ��޿� ���� ���� ����.
							-- 	���� 0 1 2 3 4 5 6 7 8 9 10
							--       1 1 2 2 2 2 2 2 2 2 2
							--  ����   1 2 3 4 5 6
							--         1 1 2 2 2 2
							--------------------------------------
							--select 'DEBUG ����'
							set @grade 		= dbo.fun_GetApartGrade(@mode_, @gradeorg)
							set @loopidx	= 0
							set @loopmax	= 1
							if (@mode_ = @MODE_APART_ANIMAL and @gradeorg >= 2 )
								begin
									set @loopmax = 2
								end
							else if (@mode_ = @MODE_APART_TREASURE and @gradeorg >= 3 )
								begin
									set @loopmax = 2
								end


							--------------------------------------
							-- ������ ������� ����
							--	> �ش缼�� ã��
							--	> �־��ֱ�.
							--------------------------------------
							while( @givestemcell = @GIVE_STEMCELL_GIVE and @loopidx < @loopmax)
								begin
									set @cnt 		= @cnt + 1
									set @loopidx	= @loopidx + 1

									select @senditemcode = itemcode from dbo.tItemInfo
									where subcategory = @ITEM_SUBCATEGORY_STEMCELL and grade = @grade
									order by newid()
									--select 'DEBUG > ���޼�������.', @grade grade, @senditemcode senditemcode

									--> �ٱ⼼�� �־��ֱ�.
									exec spu_SetDirectItemNew @gameid_, @senditemcode, 1, @sendgethow, @rtn_ = @rtnlistidx OUTPUT
									--select 'DEBUG > ���޼�������.', @gameid_ gameid_, @grade grade, @senditemcode senditemcode, @sendgethow sendgethow, @rtnlistidx rtnlistidx

									if( @cnt = 1 )
										begin
											set @bgroul1 = @rtnlistidx
										end
									else if( @cnt = 2 )
										begin
											set @bgroul2 = @rtnlistidx
										end
									else if( @cnt = 3 )
										begin
											set @bgroul3 = @rtnlistidx
										end
									else if( @cnt = 4 )
										begin
											set @bgroul4 = @rtnlistidx
										end
									else if( @cnt = 5 )
										begin
											set @bgroul5 = @rtnlistidx
										end
									else if( @cnt = 6 )
										begin
											set @bgroul6 = @rtnlistidx
										end
									else if( @cnt = 7 )
										begin
											set @bgroul7 = @rtnlistidx
										end
									else if( @cnt = 8 )
										begin
											set @bgroul8 = @rtnlistidx
										end
									else if( @cnt = 9 )
										begin
											set @bgroul9 = @rtnlistidx
										end
									else if( @cnt = 10 )
										begin
											set @bgroul10 = @rtnlistidx
										end
									else if( @cnt = 11 )
										begin
											set @bgroul11 = @rtnlistidx
										end
									else if( @cnt = 12 )
										begin
											set @bgroul12 = @rtnlistidx
										end
									else if( @cnt = 13 )
										begin
											set @bgroul13 = @rtnlistidx
										end
									else if( @cnt = 14 )
										begin
											set @bgroul14 = @rtnlistidx
										end
									else if( @cnt = 15 )
										begin
											set @bgroul15 = @rtnlistidx
										end
									else if( @cnt = 16 )
										begin
											set @bgroul16 = @rtnlistidx
										end
									else if( @cnt = 17 )
										begin
											set @bgroul17 = @rtnlistidx
										end
									else if( @cnt = 18 )
										begin
											set @bgroul18 = @rtnlistidx
										end
									else if( @cnt = 19 )
										begin
											set @bgroul19 = @rtnlistidx
										end
									else if( @cnt = 20 )
										begin
											set @bgroul20 = @rtnlistidx
										end
								end
						end

					Fetch next from curApartItemcode into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curApartItemcode
			Deallocate curApartItemcode

			if( @cnt >= 1 or @plusgamecost > 0)
				begin
					-- �������� ���� �־���
					update dbo.tUserMaster
						set
							gamecost	= @gamecost + @plusgamecost,
							bkapartani	= bkapartani + 	case when (@mode_ = @MODE_APART_ANIMAL) 	then @apartcnt else 0 end,
							bkapartts	= bkapartts + 	case when (@mode_ = @MODE_APART_TREASURE) 	then @apartcnt else 0 end,
							bgroul1 	= @bgroul1,		bgroul2 = @bgroul2,		bgroul3 = @bgroul3,		bgroul4 = @bgroul4,		bgroul5 = @bgroul5,
							bgroul6 	= @bgroul6,		bgroul7 = @bgroul7,		bgroul8 = @bgroul8,		bgroul9 = @bgroul9,		bgroul10= @bgroul10,
							bgroul11 	= @bgroul11,	bgroul12 = @bgroul12,	bgroul13 = @bgroul13,	bgroul14 = @bgroul14,	bgroul15 = @bgroul15,
							bgroul16 	= @bgroul16,	bgroul17 = @bgroul17,	bgroul18 = @bgroul18,	bgroul19 = @bgroul19,	bgroul20= @bgroul20,
							apartbuycnt = isnull(@apartbuycnt, 0),
							randserial	= @randserial_
					where gameid = @gameid_
				end
			else
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR ����Ʈ ��ȣ�� ã�� �� �����ϴ�.(2)'
					--select 'DEBUG ' + @comment
				end
		END



	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @plusgamecost plusgamecost, @cnt apartcnt
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@bgroul1, @bgroul2, @bgroul3, @bgroul4, @bgroul5, @bgroul6, @bgroul7, @bgroul8, @bgroul9, @bgroul10, @bgroul11, @bgroul12, @bgroul13, @bgroul14, @bgroul15, @bgroul16, @bgroul17, @bgroul18, @bgroul19, @bgroul20)
		end
	set nocount off
End

