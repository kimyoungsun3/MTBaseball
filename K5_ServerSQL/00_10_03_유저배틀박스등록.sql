/*
select * from dbo.tSystembattleBox where idx = 0
select * from dbo.tSystemBattleBox order by idx asc

declare @idx int set @idx = -6
while (@idx < 1000)
	begin
		select idx, box from dbo.tSystemBattleBox where idx = @idx
		set @idx = @idx + 1
	end

*/
---------------------------------------------
-- 유저배틀 박스등록
-- 	3700	나무 박스
--	3701	실버 박스
--	3702	골드 박스
--	3703	자이언트 박스
--	3704	마법 박스
--	3705	슈퍼마법 박스
--
-- -4 -> 0 -> 240
--	     0 -> 240
--	     0 -> 240
---------------------------------------------
use Game4Farmvill5
GO

IF OBJECT_ID (N'dbo.tSystemBattleBox', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemBattleBox;
GO

create table dbo.tSystemBattleBox(
	idx					int 				IDENTITY(-4, 1),

	box					int
	-- Constraint
	CONSTRAINT	pk_tSystemBattleBox_idx	PRIMARY KEY(idx)
)

declare @idx 		int		set @idx 		= -4

while(@idx <= 240)
	begin
		if(@idx in (11,131,203))
			begin
				--	3705	슈퍼마법 박스
				--	3704	마법 박스
				insert into tSystemBattleBox(box)	values(3704)
			end
		else if(@idx in (51, 158, 190))
			begin
				--	3703	자이언트 박스
				insert into tSystemBattleBox(box)	values(3703)
			end
		else if(@idx in (3, 6, 14, 18,23,25,30,35,38,43,46,54,58,63,65,70,75,78,83,86,91,94,98,103,105,110,115,118,123,126,134,138,143,145,150,155,163,166,171,174,178,183,185,195,198,206,211,214,218,223,225,230,235,238))
			begin
				--	3702	골드 박스
				insert into tSystemBattleBox(box)	values(3702)
			end
		else if(@idx < 0)
			begin
				-- 	3700	나무 박스
				insert into tSystemBattleBox(box)	values(3700)
			end
		else
			begin
				--	3701	실버 박스
				insert into tSystemBattleBox(box)	values(3701)
			end

		set @idx = @idx + 1
	end







