use Farm
GO

declare @kakaouserid	varchar(60),
		@gameid			varchar(60)
set @kakaouserid	= '91188455545412242'	-- PC
--set @kakaouserid	= '88255137081585760'	-- 만종이폰
--set @kakaouserid	= '88812599272546640'	-- 최정기
--set @kakaouserid	= '88141973561720689'	-- 준식
--set @kakaouserid	= '88318663778986177'	-- 연지
--set @kakaouserid	= '90396051283528689'	-- 임진혁
--set @kakaouserid	= '88294959671580064'	-- 김태민
--set @kakaouserid	= '88072204762769425'	-- 최창규
--set @kakaouserid	= '92064568193308403'	-- 박인규
--set @kakaouserid	= '88114671263625504'	-- 김선훈
--set @kakaouserid	= '88103356826892544'	-- 이대표
--set @kakaouserid	= '88258263875124913'	--핸드폰

select top 1 @gameid = gameid from dbo.tUserMaster where kakaouserid = @kakaouserid order by idx desc
delete from dbo.tFVGiftList where gameid = @gameid

exec spu_FVSubGiftSend 2, 80010, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80014, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80020, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80024, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80030, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80034, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80040, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80044, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80050, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80054, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80060, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80064, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80070, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80074, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80080, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80084, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80090, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80094, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80100, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80104, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80110, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80114, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80120, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80124, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80130, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80134, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80140, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80144, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80200, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80204, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80205, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80209, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80210, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80214, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80215, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80219, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80220, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80224, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80225, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80229, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80230, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80234, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80235, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80239, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80240, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80244, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80245, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80249, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80250, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80254, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80255, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80259, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80260, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80264, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80265, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80269, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80270, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80274, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80275, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80279, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80280, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80284, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80285, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80289, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80290, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80294, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80295, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80299, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80300, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80304, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80305, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80309, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80310, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 80314, 1, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''