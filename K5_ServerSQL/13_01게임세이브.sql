/*
--(����) �����(Tab)���� ����ϸ� �������´�.
userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;boosteruse;albause;wolfappear;wolfkillcnt;albausesecond;albausethird;petcooltime
         0:2013;  1:3;      2:12;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;       44:-1;        45:-1;       46:2;
         0:2015;  1:1;      2:65;     4:2;       10:0;        11:0;       12:390;    13:38150; 30:54;  40:1103;   41:1002;42:-1;     43:2;       44:1002;      45:-1;
aniitem=listidx:anistep,manger,diseasestate; (�κ�[O], �ʵ�[O], ����[X])
		...
		1:5,24,1;		--> ��ü�и� 	> 4 : 5, 25, 0
		3:5,23,0;
		4:5,25,0;		--> �������� 	> ��ü����.
		45:5,25,0;    22:5,25,0;    23:5,20,0;    24:5,25,0;    31:4,26,0;
		32:4,22,0;    33:5,25,0;    34:5,24,0;    35:4,21,0;    36:5,26,0;
		37:5,25,0;    41:5,25,0;    44:5,25,0;
cusitem=listidx:usecnt;
		...
		14:1;
		15:1;
		16:1;			--> �Ǽ��縮(�ڵ�����)
paraminfo=param0:value0
		...
		0:0;
		1:0;
		2:0;			--> �Ķ���͵���Ÿ
-- playcoin : �޹߼� ����Ÿ�� �߰��� �������.

update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_GameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- �ʵ����.
-- delete from dbo.tUserUnusualLog2
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- ���� ����ź(700)	 4	�Ҹ�ǰ(3)	�⺻(0)	2014-03-27 17:02	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- ���� ���� ���(800)	 1	�Ҹ�ǰ(3)	����(5)	2014-05-14 11:10	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- �˹��� ����(1002)	 3	�Ҹ�ǰ(3)	�⺻(0)	2014-03-27 17:02	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- ���� ���� ������(1100)	 4	�Ҹ�ǰ(3)	�⺻(0)	2014-03-27 17:02	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- ��Ȱ��(1200)	 6	�Ҹ�ǰ(3)	�⺻(0)	2014-03-27 17:02	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 18	-- ��޿�û Ƽ��(2100)	 1	�Ҹ�ǰ(3)	����(5)	2014-05-14 11:10	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 19	-- �Ϲ� ���� Ƽ��(2200)	 99	�Ҹ�ǰ(3)	����(5)	2014-05-14 11:10	-1	�κ��丮(-1)	5	25	 ������(0)	����(-1)		 null	-1	-1		���߻���
update dbo.tUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- �����̾� ���� Ƽ��(2300)	 1	�Ҹ�ǰ(3)	����(5)	2014
update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_GameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- ���� 1�� > 1�� ������
													'7:2;16:2;9:2;10:2;11:2;18:2;19:2;15:2;',	-- ���� 1�� > 2�� ��������
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- �ʵ����.


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GameSave', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GameSave;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GameSave
	@gameid_								varchar(20),
	@password_								varchar(20),
	@userinfo_								varchar(8000),
	@aniitem_								varchar(8000),
	@cusitem_								varchar(8000),
	@paraminfo_								varchar(8000),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��

	-- ���̺갪����
	declare @SAVE_USERINFO_GAMEYEAR				int					set @SAVE_USERINFO_GAMEYEAR					= 0
	declare @SAVE_USERINFO_MONTH				int					set @SAVE_USERINFO_MONTH					= 1
	declare @SAVE_USERINFO_FRAMETIME			int					set @SAVE_USERINFO_FRAMETIME				= 2
	declare @SAVE_USERINFO_FEVERGAUGE			int					set @SAVE_USERINFO_FEVERGAUGE				= 4
	declare @SAVE_USERINFO_BOTTLELITTLE			int					set @SAVE_USERINFO_BOTTLELITTLE				= 10
	declare @SAVE_USERINFO_BOTTLEFRESH			int					set @SAVE_USERINFO_BOTTLEFRESH				= 11
	declare @SAVE_USERINFO_TANKLITTLE			int					set @SAVE_USERINFO_TANKLITTLE				= 12
	declare @SAVE_USERINFO_TANKFRESH			int					set @SAVE_USERINFO_TANKFRESH				= 13
	declare @SAVE_USERINFO_USEFEED				int					set @SAVE_USERINFO_USEFEED					= 30
	declare @SAVE_USERINFO_BOOSTERUSE			int					set @SAVE_USERINFO_BOOSTERUSE				= 40
	declare @SAVE_USERINFO_ALBAUSE				int					set @SAVE_USERINFO_ALBAUSE					= 41
	declare @SAVE_USERINFO_ALBAUSE_SECOND		int					set @SAVE_USERINFO_ALBAUSE_SECOND			= 44
	declare @SAVE_USERINFO_ALBAUSE_THIRD		int					set @SAVE_USERINFO_ALBAUSE_THIRD			= 45
	declare @SAVE_USERINFO_WOLFAPPEAR			int					set @SAVE_USERINFO_WOLFAPPEAR				= 42
	declare @SAVE_USERINFO_WOLFKILLCNT			int					set @SAVE_USERINFO_WOLFKILLCNT				= 43
	declare @SAVE_USERINFO_PETCOOLTIME			int					set @SAVE_USERINFO_PETCOOLTIME				= 46

	-- �׷�.
	declare @ITEM_REVIVAL_MOTHER				int					set @ITEM_REVIVAL_MOTHER					= 1200	-- ��Ȱ��.
	declare @ITEM_COMPOSE_TIME_MOTHER			int					set @ITEM_COMPOSE_TIME_MOTHER				= 1600	-- �ռ��ð� 1�ð��ʱ�ȭ.
	declare @ITEM_HELPER_MOTHER					int					set @ITEM_HELPER_MOTHER						= 2100	-- �������.
	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- �Ϲݱ���̱�.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- �����̾�����̱�.


	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- �ܰ�.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- ������.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- ��������.

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @CHAR_SPLIT_COMMA					varchar(1)			set @CHAR_SPLIT_COMMA						= ','
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 							= 2

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)
	declare @comment2			varchar(512)
	declare @kind				int,
			@info				int,
			@listidx			int,
			@strdata			varchar(40)

	declare @gameid 			varchar(20)	set @gameid			= ''
	declare @gamecost			int,
			@cashcost			int,
			@feed				int,		@feeduse2			int,
			@heart				int,

			@gameyear			int,		@gameyear2			int,
			@gamemonth			int,		@gamemonth2			int,
			@frametime			int,		@frametime2			int,
			@fevergauge			int,		@fevergauge2		int,
			@bottlelittle		int,		@bottlelittle2		int,	@bottlelittlemax 	int,
			@bottlefresh		int,		@bottlefresh2		int,
			@tanklittle			int,		@tanklittle2		int,	@tanklittlemax		int,
			@tankfresh			int,		@tankfresh2			int,
											@boosteruse2		int,
											@albause2			int,
											@albausesecond2		int,
											@albausethird2		int,
											@petcooltime2		int,
											@wolfappear2		int,
			@bktwolfkillcnt		int,		@wolfkillcnt2		int,

											@param20			int,
											@param21			int,
											@param22			int,
											@param23			int,
											@param24			int,
											@param25			int,
											@param26			int,
											@param27			int,
											@param28			int,
											@param29			int,

			@tankstep			int,
			@bottlestep			int

	set @gamecost 		= 0
	set @cashcost 		= 0
	set @feed			= 0
	set @heart			= 0
	set @bktwolfkillcnt	= 0

	declare 								@stranistep2		varchar(40),
											@strmanger2			varchar(40),
											@strdiseasestate2	varchar(40),
											@listidx2			int,
											@usecnt2			int,
											@cusitemcode		int,
											@cusitemname		varchar(40),
											@cusowncnt			int,
			@data				varchar(40),@data2				varchar(40),
			@pos1	 			int, 		@pos2	 			int,	@pos3	 			int,
			@strlen				int

	declare @idx2				int

	-- ������ �þ ����.
	declare @tsskillbottlelittle	int				set @tsskillbottlelittle 	= 0 	-- �絿��.
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @userinfo_ userinfo_, @aniitem_ aniitem_, @cusitem_ cusitem_


	------------------------------------------------
	--	��������.
	------------------------------------------------
	select
		@gameid 		= gameid,		@gamecost		= gamecost,		@cashcost		= cashcost,
		@feed			= feed,			@heart			= heart,

		@gameyear		= gameyear,		@gamemonth		= gamemonth,
		@frametime		= frametime,	@fevergauge		= fevergauge,
		@bottlelittle	= bottlelittle,	@bottlefresh	= bottlefresh,	@tsskillbottlelittle = tsskillbottlelittle,
		@tanklittle		= tanklittle,	@tankfresh		= tankfresh,

		@bottlestep		= bottlestep,	@tankstep		= tankstep,

		@bktwolfkillcnt	= bktwolfkillcnt
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @gamecost gamecost, @feed feed, @gameyear gameyear, @gamemonth gamemonth, @frametime frametime, @fevergauge fevergauge, @bottlelittle bottlelittle, @bottlefresh bottlefresh, @tanklittle tanklittle, @tankfresh tankfresh

	------------------------------------------------
	-- �絿��, ��ũ > ������Max
	-- �絿�̴� ������ Ȯ���.
	------------------------------------------------
	select
		@bottlelittlemax	= param5 + @tsskillbottlelittle
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE and param1 = @bottlestep

	select
		@tanklittlemax		= param5 * 30
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TANK and param1 = @tankstep

	--select 'DEBUG �絿��MAX, ��ũMAX ', @bottlestep bottlestep, @bottlelittlemax bottlelittlemax, @tankstep tankstep, @tanklittlemax tanklittlemax


	------------------------------------------------
	-- �Է�����1 (useinfo).
	-- userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;
    --          0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:3;
	------------------------------------------------
	set @gameyear2 		= @INIT_VALUE
	set @gamemonth2 	= @INIT_VALUE
	set @frametime2		= @INIT_VALUE
	set @fevergauge2	= @INIT_VALUE
	set @bottlelittle2	= @INIT_VALUE
	set @bottlefresh2	= @INIT_VALUE
	set @tanklittle2	= @INIT_VALUE
	set @tankfresh2		= @INIT_VALUE
	set @feeduse2		= @INIT_VALUE
	set @boosteruse2	= @INIT_VALUE
	set @albause2		= -1
	set @albausesecond2	= -1
	set @albausethird2	= -1
	set @petcooltime2	= 0
	set @wolfappear2	= @INIT_VALUE
	set @wolfkillcnt2	= 0


	if(LEN(@userinfo_) >= 3)
		begin
			-- 1. Ŀ�� ����
			declare curUserInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @userinfo_)

			-- 2. Ŀ������
			open curUserInfo

			-- 3. Ŀ�� ���
			Fetch next from curUserInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					if(@kind = @SAVE_USERINFO_GAMEYEAR)
						begin
							set @gameyear2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_MONTH)
						begin
							set @gamemonth2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FRAMETIME)
						begin
							set @frametime2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FEVERGAUGE)
						begin
							set @fevergauge2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLELITTLE)
						begin
							set @bottlelittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLEFRESH)
						begin
							set @bottlefresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKLITTLE)
						begin
							set @tanklittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKFRESH)
						begin
							set @tankfresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_USEFEED)
						begin
							set @feeduse2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_BOOSTERUSE)
						begin
							set @boosteruse2	= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE)
						begin
							set @albause2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE_SECOND)
						begin
							set @albausesecond2	= @info
						end
					else if(@kind = @SAVE_USERINFO_ALBAUSE_THIRD)
						begin
							set @albausethird2	= @info
						end
					else if(@kind = @SAVE_USERINFO_PETCOOLTIME)
						begin
							set @petcooltime2	= @info
						end
					else if(@kind = @SAVE_USERINFO_WOLFAPPEAR)
						begin
							set @wolfappear2	= @info
						end
					else if(@kind = @SAVE_USERINFO_WOLFKILLCNT)
						begin
							set @wolfkillcnt2	= @info
						end
					Fetch next from curUserInfo into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curUserInfo
			Deallocate curUserInfo
			--select 'DEBUG �Է�����(useinfo)', @gameyear2 gameyear2, @gamemonth2 gamemonth2, @frametime2 frametime2, @fevergauge2 fevergauge2, @bottlelittle2 bottlelittle2, @bottlefresh2 bottlefresh2, @tanklittle2 tanklittle2, @tankfresh2 tankfresh2, @feeduse2 feeduse2, @boosteruse2 boosteruse2, @albause2 albause2, @wolfappear2 wolfappear2, @wolfkillcnt2 wolfkillcnt2
		end

	------------------------------------------------
	-- �Է�����2.(aniitem) > �ϴܿ��� ����.
	------------------------------------------------

	------------------------------------------------
	-- �Է�����3.(cusitem) > �ϴܿ��� ����.
	------------------------------------------------

	----------------------------------------------
	-- �Է�����3-2.(param) >
	-- paraminfo=param0;param1;param2;param3;...
	--       0:0;   1:0;   2:0;   3:0;
	----------------------------------------------
	set @param20 		= @INIT_VALUE
	set @param21 		= @INIT_VALUE
	set @param22 		= @INIT_VALUE
	set @param23 		= @INIT_VALUE
	set @param24 		= @INIT_VALUE
	set @param25 		= @INIT_VALUE
	set @param26 		= @INIT_VALUE
	set @param27 		= @INIT_VALUE
	set @param28 		= @INIT_VALUE
	set @param29 		= @INIT_VALUE

	if(LEN(@paraminfo_) >= 3)
		begin
			-- 1. Ŀ�� ����
			declare curParamInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @paraminfo_)

			-- 2. Ŀ������
			open curParamInfo

			-- 3. Ŀ�� ���
			Fetch next from curParamInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					if(@kind = 0)
						begin
							set @param20 		= @info
						end
					else if(@kind = 1)
						begin
							set @param21 		= @info
						end
					else if(@kind = 2)
						begin
							set @param22 		= @info
						end
					else if(@kind = 3)
						begin
							set @param23 		= @info
						end
					else if(@kind = 4)
						begin
							set @param24 		= @info
						end
					else if(@kind = 5)
						begin
							set @param25 		= @info
						end
					else if(@kind = 6)
						begin
							set @param26 		= @info
						end
					else if(@kind = 7)
						begin
							set @param27 		= @info
						end
					else if(@kind = 8)
						begin
							set @param28 		= @info
						end
					else if(@kind = 9)
						begin
							set @param29 		= @info
						end
					Fetch next from curParamInfo into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curParamInfo
			Deallocate curParamInfo
			--select 'DEBUG �Է�����(paraminfo)', @param20 param20, @param21 param21, @param22 param22, @param23 param23, @param24 param24, @param25 param25, @param26 param26, @param27 param27, @param28 param28, @param29 param29
		end

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment comment
		END
	else if(@gameyear2 = @INIT_VALUE 		or @gamemonth2 = @INIT_VALUE	or @frametime2 = @INIT_VALUE 	or @fevergauge2 = @INIT_VALUE
			or @bottlelittle2 = @INIT_VALUE 	or @bottlefresh2 = @INIT_VALUE	or @tanklittle2	= @INIT_VALUE	or @tankfresh2	= @INIT_VALUE	or @feeduse2		= @INIT_VALUE
			--or @boosteruse2 = @INIT_VALUE		or @albause2 = @INIT_VALUE		or @wolfappear2 = @INIT_VALUE 	or @wolfkillcnt2= 0
			)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	=  '�Ķ���� ����(1) ������������ > �׳� ������ϰ��н�.'
			--select 'DEBUG ', @comment comment
		END
	else if(@gameyear != @gameyear2 or @gamemonth != @gamemonth2 or @frametime > @frametime2)
		BEGIN
			--set @nResult_ 	= @RESULT_ERROR_PARAMETER
			--set @comment 	=  '�Ķ���� ����(2) ��¥����.'
			--select 'DEBUG ', @comment comment, @gameyear gameyear, @gameyear2 gameyear2, @gamemonth gamemonth, @gamemonth2 gamemonth2, @frametime frametime, @frametime2 frametime2


			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '������� �н��մϴ�.'
			select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
			return;
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '������ �����մϴ�(1).'
			--select 'DEBUG ', @comment comment

			----------------------------------------------
			-- ������������, �ŷ�����.(�������ϱ�.)
			----------------------------------------------
			-- ������Ÿ��(0 -> 70), �ð��� �ڷδ� ������.
			set @frametime = case
								when @frametime2 < 0 then 0
								when @frametime2 > 70 then 70
								else @frametime2
							end
			-- �ǹ��˻�.
			set @fevergauge		= case when (@fevergauge2 < 0 or @fevergauge2 >= 5) then 0 else @fevergauge2 end
			--select 'DEBUG �ǹ�(��)', @frametime frametime, @frametime2 frametime2, @fevergauge fevergauge, @fevergauge2 fevergauge2

			-- ��� ���.
			set @feed = @feed - case when (@feeduse2 < 0) then (-@feeduse2) else @feeduse2 end
			set @feed = case when @feed < 0 then 0 else @feed end
			--select 'DEBUG ��� ���(��)', @feed feed, @feeduse2 feeduse2

			--select 'DEBUG �絿��, ��ũ(��)', @bottlelittle bottlelittle, @bottlelittle2 bottlelittle2,	@bottlelittlemax bottlelittlemax, @bottlefresh bottlefresh, 	@bottlefresh2 bottlefresh2, @tanklittle tanklittle, 	@tanklittle2 tanklittle2, 		@tanklittlemax tanklittlemax, @tankfresh tankfresh,		@tankfresh2 tankfresh2
			-- ���� �絿��, ��ũ.
			set @bottlelittle	= case
									when (@bottlelittle2 < 0) 						then 0
									when (@bottlelittle2 > @bottlelittlemax) 		then @bottlelittlemax
									else @bottlelittle2
								  end
			set @bottlefresh	= case
									when (@bottlefresh2 < 0)						then 0
									when (@bottlefresh2 > @bottlelittlemax * 300)	then @bottlelittlemax * 300
									else @bottlefresh2
								  end
			set @tanklittle		= case
									when (@tanklittle2 < 0)							then 0
									when (@tanklittle2 > @tanklittlemax)	 		then @tanklittlemax
									else @tanklittle2
								  end
			set @tankfresh		= case
									when (@tankfresh2 < 0)							then 0
									when (@tankfresh2 > @tanklittlemax * 300) 		then @tanklittlemax * 300
									else @tankfresh2
								  end

			--set @bottlelittle	= case when (@bottlelittle2 < 0 or (@bottlelittle2 > @bottlelittlemax)) 	then 0 	else @bottlelittle2 end
			--set @bottlefresh	= case when (@bottlefresh2 < 0 	or (@bottlefresh2 > @bottlelittlemax * 300))then 0 	else @bottlefresh2 	end
			--set @tanklittle	= case when (@tanklittle2 < 0 	or (@tanklittle2 > @tanklittlemax))	 		then 0 	else @tanklittle2 	end
			--set @tankfresh	= case when (@tankfresh2 < 0 	or (@tankfresh2 > @tanklittlemax * 300)) 	then 0	else @tankfresh2 	end
			--select 'DEBUG �絿��, ��ũ(��)', @bottlelittle bottlelittle, @bottlelittle2 bottlelittle2,	@bottlelittlemax bottlelittlemax, @bottlefresh bottlefresh, 	@bottlefresh2 bottlefresh2, @tanklittle tanklittle, 	@tanklittle2 tanklittle2, 		@tanklittlemax tanklittlemax, @tankfresh tankfresh,		@tankfresh2 tankfresh2

			-- �Ҹ��� �����˻�.
			--set @boosteruse2	= case when (@boosteruse2 not in(-1, 1100, 1101, 1102)) then -1 else @boosteruse2 	end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @boosteruse2 and subcategory = @ITEM_SUBCATEGORY_BOOSTER))
				begin
					set @boosteruse2 = -1
				end
			--set @albause2		= case when (@albause2 not in(-1, 1000, 1001, 1002)) 	then -1 else @albause2 		end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albause2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albause2 = -1
				end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albausesecond2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albausesecond2 = -1
				end
			if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @albausethird2 and subcategory = @ITEM_SUBCATEGORY_ALBA))
				begin
					set @albausethird2 = -1
				end
			--set @wolfappear2 	= case when (@wolfappear2 not in(-1, 0, 1, 2, 3, 4, 5)) 				then -1 else @wolfappear2 	end
			set @wolfkillcnt2 = case when @wolfkillcnt2 not in(0, 1, 2, 3)	 							then  0 else @wolfkillcnt2 	end
			set @bktwolfkillcnt	= @bktwolfkillcnt + @wolfkillcnt2

			----------------------------------------------
			-- ��������.
			----------------------------------------------
			if(LEN(@aniitem_) >= 7)
				begin
				----------------------------------------------
				-- ���ι�ȣ�� ���� �ʵ��ȣ����
				----------------------------------------------
				-- 1. Ŀ�� ����
				declare curAniItem Cursor for
				select * FROM dbo.fnu_SplitTwoStr(';', ':', @aniitem_)

				-- 2. Ŀ������
				open curAniItem

				-- 3. Ŀ�� ���
				Fetch next from curAniItem into @listidx2, @data2
				while @@Fetch_status = 0
					Begin
						set @strlen = LEN(@data2)
						set @pos1 	= 0
						set @pos2 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos1)
						set @pos3 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos2 + 1)
						set @stranistep2		= SUBSTRING(@data2, @pos1    , @pos2 - @pos1)
						set @strmanger2			= SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1)
						set @strdiseasestate2	= SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
						--select 'DEBUG ', @data2 data2, @strlen strlen, @pos1 pos1, @pos2 pos2, @pos3 pos3, SUBSTRING(@data2, @pos1    , @pos2 - @pos1), SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1), SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
						--select 'DEBUG ', @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2
						if(Isnumeric(@stranistep2) = 1 and Isnumeric(@strmanger2) = 1 and Isnumeric(@strdiseasestate2) = 1)
							begin
								--select 'DEBUG ������������ (���ڿ� > ����ó��).', @listidx2 listidx2, @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2

								-- â��, �ʵ� 	> ����
								-- ����			> �н�
								update dbo.tUserItem
									set
										anistep 		= @stranistep2,
										manger			= @strmanger2,
										diseasestate	= @strdiseasestate2
								from dbo.tUserItem
								where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_ANI and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
							end
						Fetch next from curAniItem into @listidx2, @data2
					end

				-- 4. Ŀ���ݱ�
				close curAniItem
				Deallocate curAniItem
			end

			----------------------------------------------
			-- �Ҹ��� �������. > [1:2]
			----------------------------------------------
			if(LEN(@cusitem_) >= 3)
				begin
					-- 1. Ŀ�� ����
					declare curCusItem Cursor for
					-- fieldidx	-> @listidx2
					-- listidx	-> @usecnt2
					select * FROM dbo.fnu_SplitTwo(';', ':', @cusitem_)

					-- 2. Ŀ������
					open curCusItem

					-- 3. Ŀ�� ���
					Fetch next from curCusItem into @listidx2, @usecnt2
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG �Ҹ���', @listidx2 listidx2, @usecnt2 usecnt2

							----------------------------------------------
							-- �����뿪�� ����� �ٲ۴�.(�����ڹ���)
							----------------------------------------------
							set @usecnt2 		= case when @usecnt2 < 0 then (-@usecnt2) else @usecnt2 end

							if(@usecnt2 > 0)
								begin
									----------------------------------------------
									-- ������ �������� ���� �״�� ���� (���Ŀ� �м������� ����صд�.)
									-- update >     find > @updatecnt	= @updatecnt + 1
									-- update > not find >
									-- �̹���� �����Ѵ�.
									----------------------------------------------
									set @cusowncnt		= 0
									set @cusitemcode	= -1
									select
											@cusitemcode 	= itemcode,
											@cusowncnt		= cnt
									from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME
									--select 'DEBUG ������ �Ҹ� �˻�.', @gameid_ gameid_, @listidx2 listidx2, @cusitemcode cusitemcode, @cusowncnt cusowncnt, @usecnt2 usecnt2

									if(@cusitemcode = -1)
										begin
											--select 'DEBUG ���� > �н�'
											set @cusitemcode	= -1
										end
									else if(@cusitemcode in (@ITEM_REVIVAL_MOTHER, @ITEM_COMPOSE_TIME_MOTHER, @ITEM_HELPER_MOTHER, @ITEM_ROULETTE_NOR_MOTHER, @ITEM_ROULETTE_PRE_MOTHER))
										begin
											--select 'DEBUG ��Ȱ, ���, �Ϲ�, �����̾�����, �ռ��ð� > �׶� ���� >(�н�)'
											set @cusitemcode	= -1
										end
									else
										begin
											--select 'DEBUG �Ϲ� �Ҹ��� > �Ѿ�, ���, �˹�, ������(��������)'
											update dbo.tUserItem
												set
													cnt 			= case
																			when ((cnt - @usecnt2) < 0) then 0
																			else (cnt - @usecnt2)
																	  end
											from dbo.tUserItem
											where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME

											--------------------------------------------------
											-- ���� �����ϰ� ���� �ʴµ� ����� �ߴٸ� ���� �����.
											--------------------------------------------------
											--select 'DEBUG ', @listidx2 listidx2, @usecnt2 usecnt2, @cusowncnt cusowncnt, (@cusowncnt - @usecnt2) gapcha, @cusitemcode cusitemcode
											if((@cusowncnt - @usecnt2) < 0)
												begin
													-- ��뷮 �̻� �˻�.
													--select 'DEBUG �Ҹ����� ��뷮 �̻� �����'
													select @cusitemname = itemname from dbo.tItemInfo where itemcode = @cusitemcode
													set @comment2 = '(�����������)' + @cusitemname + '(' +ltrim(rtrim(str(@cusitemcode)))+') ����:'+ltrim(rtrim(str(@cusowncnt)))+' ���:'+ltrim(rtrim(str(@usecnt2)))
													exec spu_SubUnusualRecord2 @gameid_, @comment2
												end
										end
								end
							Fetch next from curCusItem into @listidx2, @usecnt2
						end

					-- 4. Ŀ���ݱ�
					close curCusItem
					Deallocate curCusItem

				end
		END


	select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--select 'DEBUG ���� ��������'
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					feed			= @feed,

					--gameyear		= @gameyear,
					--gamemonth		= @gamemonth,
					frametime		= @frametime,
					fevergauge		= @fevergauge,
					bottlelittle	= @bottlelittle,
					bottlefresh		= @bottlefresh,
					tanklittle		= @tanklittle,
					tankfresh		= @tankfresh,

					boosteruse 		= @boosteruse2,
					albause 		= @albause2,
					albausesecond 	= @albausesecond2,
					albausethird	= @albausethird2,
					wolfappear 		= @wolfappear2,
					--bottlestep	= @bottlestep,
					--tankstep		= @tankstep,
					petcooltime		= @petcooltime2,

					-- �Ķ����
					param0			= case when (@param20 != @INIT_VALUE) 			then @param20		else param0			end,
					param1			= case when (@param21 != @INIT_VALUE) 			then @param21		else param1			end,
					param2			= case when (@param22 != @INIT_VALUE) 			then @param22		else param2			end,
					param3			= case when (@param23 != @INIT_VALUE) 			then @param23		else param3			end,
					param4			= case when (@param24 != @INIT_VALUE) 			then @param24		else param4			end,
					param5			= case when (@param25 != @INIT_VALUE) 			then @param25		else param5			end,
					param6			= case when (@param26 != @INIT_VALUE) 			then @param26		else param6			end,
					param7			= case when (@param27 != @INIT_VALUE) 			then @param27		else param7			end,
					param8			= case when (@param28 != @INIT_VALUE) 			then @param28		else param8			end,
					param9			= case when (@param29 != @INIT_VALUE) 			then @param29		else param9			end,

					bktwolfkillcnt	= @bktwolfkillcnt
			where gameid = @gameid_

			------------------------------------------------
			-- ���̺���������.
			------------------------------------------------
			--Ŭ������ �ε����� �̿�.
			set @idx2 = 0
			select top 1 @idx2 = isnull(idx2, 1) from dbo.tUserSaveLog where gameid = @gameid_ order by idx desc
			set @idx2 = @idx2 + 1

			insert into dbo.tUserSaveLog(
										idx2,
										gameid, 		gameyear, 			gamemonth, 			frametime,
										fevergauge, 	bottlelittle, 		bottlefresh, 		tanklittle,		tankfresh,
										feeduse,		boosteruse,			albause,			wolfappear,		wolfkillcnt,
										albausesecond,	albausethird,
										userinfo,		aniitem,			cusitem
			)
			values(
										@idx2,
										@gameid_, 		@gameyear2, 		@gamemonth2, 		@frametime2,
										@fevergauge2, 	@bottlelittle2, 	@bottlefresh2, 		@tanklittle2,	@tankfresh2,
										@feeduse2,		@boosteruse2,		@albause2,			@wolfappear2,	@wolfkillcnt2,
										@albausesecond2,@albausethird2,
										@userinfo_,		@aniitem_,			@cusitem_
			)
			delete from dbo.tUserSaveLog where gameid = @gameid_ and idx2 < @idx2 - @USER_LOG_MAX

			--select * from dbo.tUserMaster where gameid = @gameid_
		END


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



