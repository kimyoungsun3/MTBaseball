/*
declare @gameid varchar(20)		set @gameid = 'SangSangt'
declare @email varchar(60)		set @email = @gameid + '@SangSangDigital.com'
exec spu_UserCreate @gameid, '049000s1i0n7t8445289', @email, 1, 0, 1, 1, 'ukukukuk', 100, -1
select * from dbo.tUserMaster where gameid = @gameid

select * from dbo.tUserMaster where gameid = 'SangSang29'
select count(*) from dbo.tUserMaster
select count(*) from dbo.tUserItem
select count(*) from dbo.tMessage

select * from dbo.tUserItem where gameid = 'SangSang11' and getdate() < expiredate 
select * from dbo.tUserItem	where gameid = 'SangSang' and '2062-07-25' < expiredate 
select * from dbo.tUserItem where gameid = 'SangSang' and '2012-07-25' < expiredate 
select count(*) from dbo.tUserMaster

-- ������ 200���� �Է��ϱ� (�ʱ⳪�����ؼ�)
declare @nameid varchar(20)		set @nameid = 'DD'
declare @var int
declare @gameid varchar(20)
declare @email varchar(20)
set @var = (0)
while @var < 10000
	begin
		set @gameid = @nameid + ltrim(@var)
		set @email = @nameid + ltrim(@var) + '@SangSangDigital.com'
		exec dbo.spu_UserCreate 
							@gameid,		-- gameid
							'049000s1i0n7t8445289',		-- password
							@email,			-- email
							1,				-- market code
							0,				-- buytype
							1,				-- platform
							1,				-- ccode(�����ڵ�)
							'ukukukuk',		-- ukey
							100,			-- version
							-1
		set @var = @var + 1
	end

-- guest �α����ϱ�
exec spu_UserCreate 'guest', '049000s1i0n7t8445289', '', 1, 0, 1, 1, 'ukukukuk', 100, '', '', -1
exec spu_UserCreate 'guest', '049000s1i0n7t8445289', '', 2, 0, 1, 1, 'ukukukuk', 100, '', '', -1
exec spu_UserCreate 'supermmm', '049000s1i0n7t8445289', 'supermmm@naver.com', 1, 0, 1, 1, 'ukukukuk', 100, '', '', -1
exec spu_UserCreate 'supermmm3', '049000s1i0n7t8445289', 'supermmm3@naver.com', 1, 0, 1, 1, 'ukukukuk', 100, '01092443174', '', -1
exec spu_UserCreate 'supermmm4', '049000s1i0n7t8445289', 'supermmm4@naver.com', 1, 0, 1, 1, 'ukukukuk', 100, '01092443174', '', -1

delete from dbo.tUserSMSReward where recphone = '01011112222'
delete from dbo.tMessage where gameid = 'supermmm5'
delete from dbo.tUSerMaster where gameid = 'supermmm5'
delete from dbo.tUserCustomize where gameid = 'supermmm5'
delete from dbo.tUserItem where gameid = 'supermmm5'
delete from dbo.tQuestUser where gameid = 'supermmm5'
exec spu_UserCreate 'supermmm5', '049000s1i0n7t8445289', 'supermmm5@naver.com', 1, 0, 1, 1, 'ukukukuk', 107, '01011112222', '', -1

delete from dbo.tMessage where gameid = 'supermmm6'
delete from dbo.tUSerMaster where gameid = 'supermmm6'
delete from dbo.tUserCustomize where gameid = 'supermmm6'
delete from dbo.tUserItem where gameid = 'supermmm6'
delete from dbo.tQuestUser where gameid = 'supermmm6'
exec spu_UserCreate 'supermmm6', '049000s1i0n7t8445289', 'supermmm6@naver.com', 1, 0, 1, 1, 'ukukukuk', 107, '01011112222', '', -1
exec spu_UserCreate 'supermmm8', '049000s1i0n7t8445289', 'supermmm8@naver.com', 1, 0, 1, 1, 'ukukukuk', 107, '01012549879', '', -1
exec spu_UserCreate 'supermmm9', '049000s1i0n7t8445289', 'supermmm9@naver.com', 1, 0, 1, 1, 'ukukukuk', 107, '01012549879', '', -1

exec spu_UserCreate 'supermmm11', '049000s1i0n7t8445289', 'supermmm11@naver.com', 1, 0, 1, 1, 'ukukukuk', 109, '01011112211', '', -1
exec spu_UserCreate 'supermmm12', '049000s1i0n7t8445289', 'supermmm12@naver.com', 2, 0, 1, 1, 'ukukukuk', 109, '01011112212', '', -1
exec spu_UserCreate 'supermmm13', '049000s1i0n7t8445289', 'supermmm13@naver.com', 3, 0, 1, 1, 'ukukukuk', 109, '01011112213', '', -1
exec spu_UserCreate 'supermmm14', '049000s1i0n7t8445289', 'supermmm14@naver.com', 4, 0, 1, 1, 'ukukukuk', 109, '01011112214', '', -1
exec spu_UserCreate 'supermmm15', '049000s1i0n7t8445289', 'supermmm15@naver.com', 5, 0, 1, 1, 'ukukukuk', 109, '01011112215', '', -1
exec spu_UserCreate 'supermmm16', '049000s1i0n7t8445289', 'supermmm16@naver.com', 6, 0, 1, 1, 'ukukukuk', 109, '01011112216', '', -1
exec spu_UserCreate 'supermmm17', '049000s1i0n7t8445289', 'supermmm17@naver.com', 6, 1, 1, 1, 'ukukukuk', 109, '01011112217', '', -1

-- ������ ������ ���� ����
exec spu_UserCreate 'supermani', '049000s1i0n7t8445289', 'supermani@naver.com', 7, 0, 2, 1, 'ukukukuk', 100, '01011112217', '089c5cfc3ff57d1aca53be9df1d8d47c02601fb2820caef4b5a0db92909f292c', -1


exec spu_UserCreate 'supermmm60', '049000s1i0n7t8445289', 'supermmm60@naver.com', 1, 0, 1, 1, 'ukukukuk', 109, '01011112260', '', -1
exec spu_UserCreate 'supermmm61', '049000s1i0n7t8445289', 'supermmm61@naver.com', 3, 0, 1, 1, 'ukukukuk', 109, '01011112261', '', -1
exec spu_UserCreate 'supermmm62', '049000s1i0n7t8445289', 'supermmm62@naver.com', 5, 0, 1, 1, 'ukukukuk', 109, '01011112262', '', -1
exec spu_UserCreate 'supermmm63', '049000s1i0n7t8445289', 'supermmm63@naver.com', 1, 0, 1, 1, 'ukukukuk', 109, '01011112260', '', -1
exec spu_UserCreate 'supermmm64', '049000s1i0n7t8445289', 'supermmm64@naver.com', 3, 0, 1, 1, 'ukukukuk', 109, '01011112261', '', -1
exec spu_UserCreate 'supermmm65', '049000s1i0n7t8445289', 'supermmm65@naver.com', 5, 0, 1, 1, 'ukukukuk', 109, '01011112262', '', -1

exec spu_UserCreate 'xxx01', '049000s1i0n7t8445289', 'xxx01@naver.com', 5, 0, 1, 1, 'ukukukuk', 109, '01022220001', '', -1
exec spu_UserCreate 'xxx02', '049000s1i0n7t8445289', 'xxx02@naver.com', 5, 0, 1, 1, 'ukukukuk', 109, '01022220001', '', -1
*/



IF OBJECT_ID ( 'dbo.spu_UserCreate', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_UserCreate;
GO

create procedure dbo.spu_UserCreate
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@email_					varchar(60),						-- �̸���
	@market_				int,								-- (����ó�ڵ�) MARKET_SKT
																--		MARKET_SKT		= 1
																--		MARKET_KT		= 2
																--		MARKET_LGT		= 3 
																--		MARKET_FACEBOOK = 4
																--		MARKET_GOOGLE	= 5
																--		MARKET_NHN		= 6
																--		MARKET_IPHONE	= 7
	@buytype_				int,								-- (����/�����ڵ�)
																--		���ᰡ�� : ������ �ּ� BUYTYPE_FREE		= 0
																--		���ᰡ�� : ������ ���� BUYTYPE_PAY		= 1
	@platform_				int,								-- (�÷���)
																--		PLATFORM_ANDROID	= 1
																--		PLATFORM_IPHONE		= 2
																--		PLATFORM_FACEBOOK	= 3
	@ccode_					int,								-- 1�ѱ�, 2�̱�, 3�߱�, 4�Ϻ�
	@ukey_					varchar(256),						-- UKey	
	@version_				int,								-- Ŭ�����
	@phone_					varchar(20),
	@pushid_				varchar(256),
	@nResult_				int				OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	--declare @rtn			int				set @rtn			= -1
	declare @goldball 		int									-- �Ʒ����� �����Է�
	declare @silverball 	int
	declare	@regmsg			varchar(200)	set @regmsg = '������ �������� ���� �մϴ�.'
	
	declare @ccharacter 	int				set @ccharacter		= 0
	declare @face 			int				set @face			= 50
	declare @cap 			int				set @cap			= 100
	declare @cupper 		int				set @cupper			= 200
	declare @cunder 		int				set @cunder			= 300
	declare @bat 			int				set @bat			= 400
	declare @stadium 		int				set @stadium		= 800

	declare @BUYTYPE_FREE					int		set @BUYTYPE_FREE 					= 0	-- ���ᰡ�� : ������ �ּ� 
	declare @BUYTYPE_PAY					int		set @BUYTYPE_PAY 					= 1	-- ���ᰡ�� : ������ ���� 
	declare @BUYTYPE_PAY2					int		set @BUYTYPE_PAY2 					= 2	-- ���ᰡ�� : ������ ���� 
	
	declare @RESULT_SUCCESS					int		set @RESULT_SUCCESS					=  1
	declare @RESULT_ERROR					int		set @RESULT_ERROR					= -1
	declare @RESULT_ERROR_ID_DUPLICATE		int		set @RESULT_ERROR_ID_DUPLICATE		= -2
	declare @RESULT_ERROR_EMAIL_DUPLICATE	int 	set @RESULT_ERROR_EMAIL_DUPLICATE	= -3
	
	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY		datetime		set @ITEM_PERMANENT_START_DAY				= '2012-01-01'	--- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR		int				set @ITEM_PERMANENT_ADD_YEAR				= 50			--- �����۱Ⱓ
	declare @ITEM_CHAR_CUSTOMIZE_INIT		varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT				= '1'
	declare @AVATAR_MAX						int				set @AVATAR_MAX 							= (15+1+10)		-- 0 ~ 15��.+10
	declare @SENDER							varchar(20)		set @SENDER									= '���Ժ���'
	
	-- ����Ʈ 
	declare @QUEST_KIND_UPGRADE				int 			set @QUEST_KIND_UPGRADE 			= 100	-- ��ȭ
	declare @QUEST_KIND_MATING				int 			set @QUEST_KIND_MATING				= 200	-- ����
	declare @QUEST_KIND_MACHINE				int 			set @QUEST_KIND_MACHINE				= 300	-- �ӽ�
	declare @QUEST_KIND_MEMORIAL			int 			set @QUEST_KIND_MEMORIAL			= 400	-- �ϱ�
	declare @QUEST_KIND_FRIEND				int 			set @QUEST_KIND_FRIEND				= 500	-- ģ��
	declare @QUEST_KIND_POLL				int 			set @QUEST_KIND_POLL				= 600	-- ����
	declare @QUEST_KIND_BOARD				int 			set @QUEST_KIND_BOARD				= 700	-- ����
	declare @QUEST_KIND_CEIL				int 			set @QUEST_KIND_CEIL				= 800	-- õ��
	declare @QUEST_KIND_BATTLE				int 			set @QUEST_KIND_BATTLE				= 900	-- ��Ʋ
	declare @QUEST_KIND_SPRINT				int 			set @QUEST_KIND_SPRINT				= 1000	-- ����
	
	declare @QUEST_SUBKIND_POINT_ACCRUE		int 			set @QUEST_SUBKIND_POINT_ACCRUE 	= 1		-- ����
	declare @QUEST_SUBKIND_POINT_BEST		int 			set @QUEST_SUBKIND_POINT_BEST 		= 2		-- �ְ�
	declare @QUEST_SUBKIND_FRIEND_ADD		int 			set @QUEST_SUBKIND_FRIEND_ADD 		= 3		-- �߰�
	declare @QUEST_SUBKIND_FRIEND_VISIT		int 			set @QUEST_SUBKIND_FRIEND_VISIT 	= 4		-- �湮
	declare @QUEST_SUBKIND_HR_CNT			int 			set @QUEST_SUBKIND_HR_CNT 			= 5		-- Ȩ������
	declare @QUEST_SUBKIND_HR_COMBO			int 			set @QUEST_SUBKIND_HR_COMBO 		= 6		-- Ȩ���޺�
	declare @QUEST_SUBKIND_WIN_CNT			int 			set @QUEST_SUBKIND_WIN_CNT 			= 7		-- �´���
	declare @QUEST_SUBKIND_WIN_STREAK		int 			set @QUEST_SUBKIND_WIN_STREAK 		= 8		-- �¿���
	declare @QUEST_SUBKIND_CNT				int 			set @QUEST_SUBKIND_CNT 				= 9		-- �÷���

	declare @QUEST_INIT_NOT					int 			set @QUEST_INIT_NOT 				= 0
	declare @QUEST_INIT_FIRST				int 			set @QUEST_INIT_FIRST 				= 1
		
	declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
	declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
	declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
	
	declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 			= 0
	declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 			= 1
	declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 			= 2
	
	-- ����Ʈ �Ϲ����ǹ�
	declare @QUEST_MODE_CLEAR				int 			set @QUEST_MODE_CLEAR 				= 1
	declare @QUEST_MODE_CHECK				int 			set @QUEST_MODE_CHECK 				= 2
	
	--declare @OBT_END_DATE 				datetime		set @OBT_END_DATE					= '2012-11-18 23:59'
	declare @JOIN_MODE_GUEST				int				set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER				int				set @JOIN_MODE_PLAYER				= 2
	
	-- ���°�.
	declare @BLOCK_STATE_NO					int				set	@BLOCK_STATE_NO					= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES				int				set	@BLOCK_STATE_YES				= 1				-- ������
	declare @DELETE_STATE_NO				int				set	@DELETE_STATE_NO				= 0				-- �������¾ƴ�
	declare @DELETE_STATE_YES				int				set	@DELETE_STATE_YES				= 1				-- ��������
	
	-- ��Ż� ���а�
	declare @SKT 							int					set @SKT						= 1
	declare @KT 							int					set @KT							= 2
	declare @LGT 							int					set @LGT						= 3
	declare @FACKBOOK 						int					set @FACKBOOK					= 4
	declare @GOOGLE 						int					set @GOOGLE						= 5
	declare @NHN							int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7
	declare @NHNWEB							int					set @NHNWEB						= 8	
	declare @SKT2 							int					set @SKT2						= 11
	declare @KT2 							int					set @KT2						= 12
	declare @LGT2 							int					set @LGT2						= 13
	declare @GOOGLE2 						int					set @GOOGLE2					= 15	
	declare @XXXXXXXXXXXXXXXXXXX			int					set @XXXXXXXXXXXXXXXXXXX		= 99
	
	----------------------------------------------------
	-- 2013-01-14 ~ 01-15 12:00
	-- SKT ��õ �̺�Ʈ(��Ŭ���� ��Ʈ(410), 7��)
	----------------------------------------------------
	--declare @SKT_EVENT01_DATE 					datetime		set @SKT_EVENT01_DATE					= '2013-01-15 23:59'
	
	---------------------------------------
	---- SKT ��õ���� ~ 2013-01-30
	---------------------------------------
	--declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-02-04'	-- 1.30�ϱ���
	--declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	--declare @GOLDBALLGIVE_OPEN_EVENT01	int				set @GOLDBALLGIVE_OPEN_EVENT01		= 1
	--declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	--declare @COINGIVE_OPEN_EVENT01		int				set @COINGIVE_OPEN_EVENT01			= 3
	
	-----------------------------------------------
	--	���� : WBC ��� ��� �̺�Ʈ (����)
	-- 		   LGU+���� WBC ����� �߰���� Ȯ���Ͽ� LGU+ HDTV�� �� ���߻� �߱� ������ ���� ���θ���� ������ �����Դϴ�.
	-- 	�̺�Ʈ �Ⱓ : 2�� 25��(��) ~ 3�� 24��(��)
	--	1ȸ : 50GB����
	--	2ȸ : �������
	-----------------------------------------------	
	--declare @EVENT_START					datetime		set @EVENT_START					= '2013-02-28 00:01'
	--declare @EVENT_END					datetime		set @EVENT_END						= '2013-03-20 23:59'
	--declare @EVENT_COMMENT				varchar(128)	set @EVENT_COMMENT					= 'WBC ��� ��� �̺�Ʈ ���ݰ�� ����(50���)'
	
	-----------------------------------------------
	--	Ÿ�� 		: LGU, Google 4�� 27�� �ű� �ٿ�ε� ���� 1ȸ ����
	--  ���޹�� 	: ���Խ� ��� ����
	-- 	�̺�Ʈ �Ⱓ : 4�� 27��(��) 00:01 ~ 4�� 27��(��) 23:59
	--	1ȸ : 50GB����
	-----------------------------------------------	
	declare @EVENT_START					datetime		set @EVENT_START					= '2013-04-27 00:01'
	declare @EVENT_END						datetime		set @EVENT_END						= '2013-04-27 23:59'
	declare @EVENT_COMMENT					varchar(128)	set @EVENT_COMMENT					= '���ξ߱� ������ �¾� UPlus�ű� �������� ���ݰ�� 50���~~'
	declare @EVENT_GOLD						int				set @EVENT_GOLD						= 50
	
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @avatar			int
	declare @ccode			int	
	declare @dateid8 		varchar(8)						set @dateid8 = Convert(varchar(8),Getdate(),112)
	declare @joinmode		int								set @joinmode = @JOIN_MODE_PLAYER
	declare @blockstate		int
	declare	@doubledate		datetime						set @doubledate = getdate() + 1
	
	-- ��õ�� ������ ���� ����
	declare @smsgameid		varchar(20) 
	declare @coin			int								set @coin			= 1
	declare @bttem5cnt		int								set @bttem5cnt		= 3
	declare @smsplusgbrec	int								set @smsplusgbrec	= 0
	declare @smsplusgbmy	int								set @smsplusgbmy	= 0
	declare @commentrec		varchar(128)
	declare @commentmy		varchar(128)
	
Begin	
	-- query > insert * n, select > count ����
	-- select > count 1
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	
	-------------------------------------------------
	----	�������� > �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)
	-------------------------------------------------
	--set @coin = @COINGIVE_NORMAL
	--if(getdate() < @OPEN_EVENT01_END)
	--	begin
	--		set @coin = @COINGIVE_OPEN_EVENT01
	--	end
	
	
	------------------------------------------------
	--	3-1. �Խ�ƮID����
	------------------------------------------------
	if(@gameid_ = 'guest')
		begin
			set @joinmode = @JOIN_MODE_GUEST
			
			-- 1. guest ���̵����
			declare @maxIdx int
			select @maxIdx = max(idx)+1 from dbo.tUserMaster
			set @gameid_ = @gameid_ + rtrim(ltrim(str(@maxIdx)))
			--select 'DEBUG 1', @gameid_
			
			if exists (select * from tUserMaster where gameid = @gameid_)
				begin
					declare @tmp varchar(10)
					set @tmp = replace(newid(), '-', '')
					set @gameid_ = 'guest' + @tmp
					--select 'DEBUG 2���̵��ߺ��Ǿ �׳ɻ���', @gameid_
				end
			
			-- 2. guest email����
			set @email_ = @gameid_ + '@guest.com'			
			--select 'DEBUG 2', @email_
						
			-- 4. �α���ó������.
			--select 'DEBUG 4', @gameid_ gameid_, @password_ password_, @email_ email_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ccode_ ccode_, @ukey_ ukey_, @version_	version_
			--return
		end
		
	------------------------------------------------
	--	3-2. ��������.
	------------------------------------------------
	if exists (select * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE					/* ���̵� �ִ°�? */
			set @comment = ' DEBUG (����)���̵� �ߺ��Ǿ����ϴ�.'
		end
	else if exists (select * from tUserMaster where email = @email_)
		begin
			set @nResult_ = @RESULT_ERROR_EMAIL_DUPLICATE				/* �̸����ߺ��ΰ�? */
			set @comment = ' DEBUG (����)�̸����� �ߺ��Ǿ����ϴ�.'
		end
	else
		begin
			-----------------------------------------------------------
			-- ���� : SB(2500), GB(5) 
			-- ���� : SB(2500), GB(60)
			-----------------------------------------------------------
			-- �⺻
			set @silverball		= 2500
			set @goldball		= 5
			
			if(@buytype_ = @BUYTYPE_PAY)
				begin
					if(not exists(select top 1 * from dbo.tUserPay where phone = @phone_ and market = @market_))
						begin
							------------------------------------
							-- ���� > �ѹ��� ���޾���
							-- ����� ����
							-- ���� �α׿� ����ϱ�
							------------------------------------
							set @silverball		= 2500
							set @goldball		= 60
							
							insert into dbo.tUserPay(phone, market) values(@phone_, @market_)
						end
					else
						begin
							------------------------------------
							-- ���� > �ι����޽� ����� ����
							------------------------------------
							set @buytype_ = @BUYTYPE_PAY2
						end
				end
			else if(@buytype_ = @BUYTYPE_FREE and (@market_ = @LGT or @market_ = @GOOGLE))
				begin
					------------------------------------------------------------
					--	���� : LGU 4�� 27�� �ű� �ٿ�ε� ���� 1ȸ ����
					-- 	�̺�Ʈ �Ⱓ : 4�� 27��(��) 00:01 ~ 4�� 27��(��) 23:59
					------------------------------------------------------------
					if(getdate() >= @EVENT_START and getdate() <= @EVENT_END)
						begin
							if(not exists(select top 1 * from dbo.tUserPayEvent where phone = @phone_ and market = @market_))
								begin
									------------------------------------
									-- �ѹ��� ���޾���
									------------------------------------
									set @silverball		= 2500
									set @goldball		= @EVENT_GOLD
									
									-- �αױ��
									insert into dbo.tUserPayEvent(phone, market) values(@phone_, @market_)
									
									-- �޼��� ���
									insert into tMessage(gameid, comment)
									values(@gameid_, @EVENT_COMMENT)
								end
						end
				end

			-- ���� �ڵ����� ��������������ȣ.
			if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
				begin
					--�������� ī��ó��.
					set @blockstate = @BLOCK_STATE_YES
					
					-- �������� ���Ժ��� ������ ó���Ѵ�.
					insert into dbo.tUserBlockLog(gameid, comment)
					values(@gameid_, '�� ������ �����ҷ��� �ؼ� ���Ժ��� ��ó����.')	
				end
			else
				begin
					set @blockstate = @BLOCK_STATE_NO
				end
				
			------------------------------------------------------
			---- 2013-01-14 ~ 01-15 12:00
			---- SKT ��õ �̺�Ʈ(��Ŭ���� ��Ʈ(410), 7��)
			------------------------------------------------------
			--if(@market_ = 1 and getdate() < @SKT_EVENT01_DATE)
			--	begin
			--			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			--			values(@gameid_ , 410, 'SKT��õ', 7);
			--
			--			-- SKT �̺�Ʈ�� ��������
			--			insert into tMessage(gameid, comment)
			--			values(@gameid_, 'SKT ��õ �޴� ���� ������� ��Ʈ ����')
			--	end

			/*
			���� ������ ���̺� �Է�	
				������ ������ ���� �Է�
				�⺻������ : 0, 50, 100, 200, 300, 400	<= �������� (select * from dbo.tItemInfo where itemcode = 0)
				��Ʋ�Ҹ� ������ �⺻ 3���� > default
				��纼, �ǹ��� ����
				�ƹ�Ÿ����
			*/
			set @avatar = Convert(int, ceiling(RAND() * @AVATAR_MAX) - 1)		-- 0 <= x < M - 1
			if(@ccode_ <= 1 or @ccode_ >= 19)
				begin
					set @ccode	= 1 + Convert(int, ceiling(RAND() * 9 ))			-- 1 + (1 ~ 17) > 2 ~ 10
				end
			else
				begin
					set @ccode	= @ccode_
				end
				
			---------------------------------------------
			--	1. ��õ���� �����ϱ�
			---------------------------------------------
			select top 1 @smsgameid = gameid from dbo.tUserSMSLog 
			where recphone = @phone_
			order by idx asc
			
			--select 'DEBUG ��õ', @smsgameid, coin, bttem5cnt from dbo.tUserMaster where gameid = @smsgameid
			if(isnull(@smsgameid, '') != '')
				begin
					--select 'DEBUG 1�ܰ� ��õSMS�α׿� ������'
					if(not exists(select top 1 * from dbo.tUserSMSReward where recphone = @phone_))
						begin
							--select 'DEBUG 2�ܰ� ����SMS�α׿� ������� > Reward�����ϱ�'
							---------------------------------------------
							--	1-1. ��õ���� �����ϱ�
							-- NHN 	
							--		��õ�� : 10Goldball, coin x 10, ������Ʈ 20��
							--		������ :  5Goldball, coin x 10, ������Ʈ 20��
							-- ��Ÿ 
							--		��õ�� :  5Goldball, coin x 10, ������Ʈ 20��
							--		������ :             coin x 10, ������Ʈ 20��
							---------------------------------------------
							set @coin		= 10
							set @bttem5cnt	= 20
							if(@market_ = @NHN)
								begin
									set @smsplusgbrec	= 10
									set @commentrec		= ltrim(rtrim(@phone_)) + '�� ��õ�� �����ؼ� �������� 10�������(1000��), �̱����� 10��, ����Ÿ�� 20��(�ߺ��߰�����)'
									
									set @smsplusgbmy	= 5
									set @commentmy	= ltrim(rtrim(@smsgameid)) + '�� ��õ�� �����ؼ� �������� 5�������(500��), �̱����� 10��, ����Ÿ�� 20���� �����߽��ϴ�.'
								end
							else
								begin
									set @smsplusgbrec	= 5
									set @commentrec		= ltrim(rtrim(@phone_)) + '�� ��õ�� �����ؼ� �������� 5�������(500��), �̱����� 10��, ����Ÿ�� 20��(�ߺ��߰�����)'
									
									set @smsplusgbmy	= 0	
									set @commentmy	= ltrim(rtrim(@smsgameid)) + '�� ��õ�� �����ؼ� �������� �̱����� 10��, ����Ÿ�� 20���� �����߽��ϴ�.'
									
								end
							
							----------------------------------------------
							-- 1-2-1. ��õ ����
							----------------------------------------------
							--select 'DEBUG > ��õ : coin x 10, ����Ÿ�� 20�� > �޼������'
							update dbo.tUserMaster 
								set 
									goldball	= goldball 		+ @smsplusgbrec,
									coin 		= coin     		+ @coin,
									bttem5cnt 	= bttem5cnt 	+ @bttem5cnt,
									smsjoincnt	= smsjoincnt 	+ 1
							where gameid = @smsgameid
			
							insert into tMessage(gameid, sendid, comment) 
							values(@smsgameid, '��õ���Ժ���', @commentrec)
			
							---------------------------------------------
							--	1-2-2. �������� �����ϱ�
							---------------------------------------------
							--select 'DEBUG  > ���� : coin x 10, ����Ÿ�� 20�� > �޼������'							
							insert into tMessage(gameid, sendid, comment) 
							values(@gameid_, '��õ���Ժ���', @commentmy)
			
							---------------------------------------------
							--	1-3. ����ϱ�
							---------------------------------------------
							insert into dbo.tUserSMSReward(recphone, gameid) 
							values(@phone_, @smsgameid)
							
							---------------------------------------------------
							-- ��Ż ����ϱ�
							---------------------------------------------------
							if(exists(select top 1 * from dbo.tUserSMSLogTotal where dateid = @dateid8))
								begin
									update dbo.tUserSMSLogTotal 
										set
											joincnt = joincnt + 1
									where dateid = @dateid8
								end
							else
								begin
									insert into dbo.tUserSMSLogTotal(dateid, joincnt) 
									values(@dateid8, 1)
								end
						end
				end
			--select 'DEBUG ��õ', @smsgameid, coin, bttem5cnt from dbo.tUserMaster where gameid = @smsgameid
			
			
			---------------------------------------------
			--	���� ���� �Է��ϱ�
			---------------------------------------------
			insert into dbo.tUserMaster(gameid, password, email, market, buytype, platform, ukey, version, ccode,
										phone, pushid,
										ccharacter, face, cap, cupper, cunder, bat, stadium,
										avatar,
										blockstate,
										doubledate,
										coin, bttem5cnt, 
										silverball, goldball
										)
			values(@gameid_, @password_, @email_, @market_, @buytype_, @platform_, @ukey_, @version_, @ccode,
										@phone_, @pushid_,
										@ccharacter, @face, @cap, @cupper, @cunder, @bat, @stadium,
										@avatar,
										@blockstate,
										@doubledate,
										@coin, @bttem5cnt, 
										@silverball, @goldball + @smsplusgbmy
										)
			
			------------------------------------------------
			-- Ŭ���ο��ľ�					
			------------------------------------------------
			if(exists(select * from dbo.tBattleCountryClub where ccode = @ccode))
				begin
					update dbo.tBattleCountryClub set cnt = cnt + 1 where ccode = @ccode
				end
										
										
			------------------------------------------------
			-- ���Խ� Ŀ���� ����¡ ������ �Է��Ѵ�.							
			------------------------------------------------
			insert into dbo.tUserCustomize(gameid, itemcode, customize)
			values(@gameid_, @ccharacter, @ITEM_CHAR_CUSTOMIZE_INIT)

			/* 
			���� ���̺� �߰�
				������ ���̺� ����(0, �Ⱓ 50��, ���)	
			*/
			insert into dbo.tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @ccharacter, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @face, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @cap, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @cupper, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @cunder, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @bat, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			insert into tUserItem(gameid, itemcode, expiredate)
			values(@gameid_, @stadium, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY))
			
			
			/* �ý��� �޽����� ��� ���� */
			insert into tMessage(gameid, comment)
			values(@gameid_, @regmsg)
			
			-- id/quest ���� > �ʱ��� �ٷ�����
			-- ���� ���;��� > ���͸� �ϸ� ���� �ߵ��� �ȵ�
			insert into dbo.tQuestUser(gameid, questcode, queststate, queststart) 
				select @gameid_, questcode, @QUEST_STATE_USER_ING, getdate() 
					from dbo.tQuestInfo where questinit = @QUEST_INIT_FIRST
					
			------------------------------------
			-- ���� ��踦 �ۼ��Ѵ�.
			------------------------------------
			if(not exists(select top 1 * from dbo.tUserJoinTotal where dateid = @dateid8 and market = @market_))
				begin
					if(@joinmode = @JOIN_MODE_PLAYER)
						begin
							insert into dbo.tUserJoinTotal(dateid, cnt, cnt2, market) values(@dateid8, 1, 0, @market_)
						end
					else
						begin
							insert into dbo.tUserJoinTotal(dateid, cnt, cnt2, market) values(@dateid8, 0, 1, @market_)
						end
				end
			else
				begin
					if(@joinmode = @JOIN_MODE_PLAYER)
						begin
							update dbo.tUserJoinTotal 
								set 
									cnt = cnt + 1
							where dateid = @dateid8 and market = @market_
						end
					else
						begin
							update dbo.tUserJoinTotal 
								set 
									cnt2 = cnt2 + 1
							where dateid = @dateid8 and market = @market_
						end
				end
			--------------------------------------------
			-- �ڵ����� ���� ī����
			--------------------------------------------
			if(not exists(select top 1 * from dbo.tUserPhone where phone = @phone_))
				begin
					insert into dbo.tUserPhone(phone, market, joincnt) values(@phone_, @market_, 1)
				end
			else
				begin
					update dbo.tUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end
					
			
			
			set @nResult_ = @RESULT_SUCCESS
			set @comment = ' DEBUG (����)������ �����մϴ�.'
		end
		
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid

	--���� ����� �����Ѵ�.
	set nocount off
End



