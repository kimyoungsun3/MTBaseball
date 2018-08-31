---------------------------------------------
--  퀘스트Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tQuestInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tQuestInfo;
GO

create table dbo.tQuestInfo(
	idx				int 				IDENTITY(1, 1),
	questlv			int					default(1),
	questlabel		varchar(40),
	
	questcode		int,
	questnext		int,
	
	questkind 		int,
	questsubkind	int,
	questvalue		int,
	
	rewardsb		int					default(0),
	rewarditem		int					default(-1),	
	content			varchar(80),
	questtime		int					default(24),
	questinit		int					default(0),
	questclear		int					default(0),
	questorder		int,
	
	-- Constraint
	CONSTRAINT	pk_tQuestInfo_idx	PRIMARY KEY(questcode)	
)
-- idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tQuestInfo_questorder')
    DROP INDEX tQuestInfo.idx_tQuestInfo_questorder
GO
CREATE INDEX idx_tQuestInfo_questorder ON tQuestInfo (questorder)
GO


/*
select * from dbo.tQuestInfo
select 
	'insert into dbo.tQuestInfo('
	+ ' questlv, questlabel, questcode, questnext, questkind, '
	+ ' questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit, '
	+ ' questclear, questorder'
	+ ') values('
		+ ltrim(rtrim(str(questlv))) + ', '
		+ '"' + ltrim(rtrim(questlabel)) + '", '
		+ ltrim(rtrim(str(questcode))) + ', '
		+ ltrim(rtrim(str(questnext))) + ', '
		+ ltrim(rtrim(str(questkind))) + ', '
		+ ltrim(rtrim(str(questsubkind))) + ', '
		+ ltrim(rtrim(str(questvalue))) + ', '
		+ ltrim(rtrim(str(rewardsb))) + ', '
		+ ltrim(rtrim(str(rewarditem))) + ', '
		+ '"' + ltrim(rtrim(content)) + '", '
		+ ltrim(rtrim(str(questtime))) + ', '
		+ ltrim(rtrim(str(questinit))) + ', '
		+ ltrim(rtrim(str(questclear))) + ', '
		+ ltrim(rtrim(str(questorder)))
	+ ')'	
from dbo.tQuestInfo order by idx asc
*/

insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 100, 101, 100, 2, 20, 250, -1, '한 개의 아이템 20번 강화 성공', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 101, 102, 100, 2, 30, 400, -1, '한 개의 아이템 30번 강화 성공', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 102, 103, 100, 2, 50, 600, -1, '한 개의 아이템 50번 강화 성공', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 103, -1, 100, 2, 100, 800, -1, '한 개의 아이템 100번 강화 성공', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 110, 111, 100, 9, 1, 50, -1, '아이템 1번 강화시도 하기', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 111, 112, 100, 9, 10, 100, -1, '아이템 구분 없이 누적 10회 강화 하기', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 112, 113, 100, 9, 20, 200, -1, '아이템 구분 없이 누적 20회 강화 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 113, 114, 100, 9, 100, 500, -1, '아이템 구분 없이 누적 100회 강화 하기', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 114, 114, 100, 9, 50, 400, -1, '아이템 구분 없이 누적 50회 강화 하기', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 200, 201, 200, 9, 1, 50, -1, '펫 교배 1회 시도 해보기', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 201, 202, 200, 9, 5, 100, -1, '펫 교배 누적 횟수 5번 달성 하기', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 202, 203, 200, 9, 10, 200, -1, '펫 교배 누적 횟수 10번 달성 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 203, 204, 200, 9, 20, 400, -1, '펫 교배 누적 횟수 20번 달성 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 204, 205, 200, 9, 30, 800, -1, '펫 교배 누적 횟수 30번 달성 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 205, 206, 200, 9, 100, 1000, -1, '펫 교배 누적 횟수 100번 달성 하기', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 206, 206, 200, 9, 50, 500, -1, '펫 교배 누적 횟수 50번 달성 하기', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 300, 301, 300, 1, 10000, 150, -1, '머신모드 총 10000점 누적', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 301, 302, 300, 1, 50000, 500, -1, '머신모드 총 50000점 누적', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 302, -1, 300, 1, 200000, 800, -1, '머신모드 총 200000점 누적', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 310, 311, 300, 2, 1000, 100, -1, '머신모드에서 점수 1000점 이상 내기', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 311, 312, 300, 2, 4500, 150, -1, '머신모드에서 점수 4500점 이상 내기', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 312, 312, 300, 2, 9000, 250, -1, '머신모드에서 점수 9000점 이상 내기', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 320, 321, 300, 9, 1, 50, -1, '머신모드 1회 플레이 성공', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 321, 322, 300, 9, 10, 100, -1, '머신모드 총 10회 플레이', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 322, 323, 300, 9, 50, 300, -1, '머신모드 총 50회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 323, 324, 300, 9, 100, 500, -1, '머신모드 총 100회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 324, 325, 300, 9, 300, 800, -1, '머신모드 총 300회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 325, -1, 300, 9, 1000, 800, -1, '머신모드 총 1000회 플레이', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 400, 401, 400, 1, 10000, 250, -1, '기억력모드 총 10000점 누적', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 401, 402, 400, 1, 50000, 500, -1, '기억력모드 총 50000점 누적', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 402, -1, 400, 1, 200000, 700, -1, '기억력모드 총 200000점 누적', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 410, 411, 400, 2, 500, 250, -1, '기억력모드에서 점수 500점 이상 내기', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 411, 412, 400, 2, 2000, 300, -1, '기억력모드에서 점수 2000점 이상 내기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 412, 412, 400, 2, 7000, 500, -1, '기억력모드에서 점수 7000점 이상 내기', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 420, 421, 400, 9, 1, 50, -1, '기억력모드 1회 플레이 성공', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 421, 422, 400, 9, 10, 100, -1, '기억력모드 총 10회 플레이', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 422, 423, 400, 9, 50, 300, -1, '기억력모드 총 50회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 423, 424, 400, 9, 100, 1000, -1, '기억력모드 총 100회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 424, 425, 400, 9, 300, 1000, -1, '기억력모드 총 300회 플레이', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 425, -1, 400, 9, 1000, 1000, -1, '기억력모드 총 1000회 플레이', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 500, 501, 500, 3, 1, 50, -1, '새로운 친구 1명 추가 해보기', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 501, 502, 500, 3, 10, 100, -1, '추가한 친구 10명 도달 하기', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 502, 503, 500, 3, 20, 200, -1, '추가한 친구 20명 도달 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 503, 504, 500, 3, 30, 300, -1, '추가한 친구 30명 도달 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 504, -1, 500, 3, 50, 500, -1, '추가한 친구 50명 도달 하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 510, 511, 500, 4, 5, 50, -1, '친구 5번 방문해 보기', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 511, 512, 500, 4, 50, 100, -1, '친구 총 50번 방문하기', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 512, 513, 500, 4, 100, 250, -1, '친구 총 100번 방문하기', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 513, 513, 500, 4, 50, 100, -1, '친구 총 50번 방문하기', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 600, 601, 600, 1, 1, 100, -1, '폴 히트 성공 해보기', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 601, 602, 600, 1, 10, 300, -1, '폴 타격 성공 10회 도달', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 602, 602, 600, 1, 50, 600, -1, '폴 타격 성공 50회 도달', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 700, 701, 700, 1, 3, 50, -1, '전광판 3회 맞춰 보기', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 701, 702, 700, 1, 50, 150, -1, '전광판 타격 성공 50회 도달', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 702, 702, 700, 1, 300, 500, -1, '전광판 타격 성공 300회 도달', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 800, 801, 800, 1, 2, 100, -1, '천장 2회 맞춰 보기', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 801, 802, 800, 1, 100, 250, -1, '천장 타격 성공 100회 도달', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 802, 802, 800, 1, 500, 1000, -1, '천장 타격 성공 500회 도달', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 900, 901, 900, 1, 50000, 500, -1, '배틀모드 누적 점수 50000점 도달', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 901, 902, 900, 1, 100000, 800, -1, '배틀모드 누적 점수 100000점 도달', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 902, -1, 900, 1, 1000000, 1000, -1, '배틀모드 누적 점수 1000000점 도달', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 910, 911, 900, 5, 5, 250, -1, '배틀모드에서 홈런 기록 5회', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 911, 911, 900, 5, 200, 500, -1, '배틀모드에서 홈런 기록 200회', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 920, 921, 900, 6, 3, 50, -1, '배틀모드에서 1회 플레이시 홈런 3콤보 이상 기록', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 921, 922, 900, 6, 6, 100, -1, '배틀모드에서 1회 플레이시 홈런 6콤보 이상 기록', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 922, 922, 900, 6, 10, 200, -1, '배틀모드에서 1회 플레이시 홈런 10콤보 이상 기록', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 930, 931, 900, 7, 5, 100, -1, '배틀모드에서 5회 승리 해보기', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 931, 932, 900, 7, 25, 300, -1, '배틀모드에서 승리 누적 25회', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 932, 933, 900, 7, 100, 700, -1, '배틀모드에서 승리 누적 100회', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 933, 933, 900, 7, 50, 500, -1, '배틀모드에서 승리 누적 50회', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 940, 941, 900, 8, 3, 100, -1, '배틀모드에서 연승 3회 성공 해보기', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 941, 942, 900, 8, 4, 150, -1, '배틀모드에서 연승 4회 이상 기록', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 942, 940, 900, 8, 5, 250, -1, '배틀모드에서 연승 5회 이상 기록', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 950, 951, 900, 9, 1, 50, -1, '배틀모드 1회 플레이', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 951, 952, 900, 9, 50, 200, -1, '배틀모드 50회 플레이', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 952, 952, 900, 9, 100, 500, -1, '배틀모드 100회 플레이', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1000, 1001, 1000, 1, 15000, 300, -1, '미션모드 누적 점수 15000점 도달', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1001, 1002, 1000, 1, 30000, 500, -1, '미션모드 누적 점수 30000점 도달', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1002, -1, 1000, 1, 300000, 800, -1, '미션모드 누적 점수 300000점 도달', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1010, 1011, 1000, 5, 5, 50, -1, '미션모드에서 홈런 기록 5회', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1011, 1011, 1000, 5, 100, 500, -1, '미션모드에서 홈런 기록 100회', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1020, 1021, 1000, 6, 2, 50, -1, '미션모드에서 1회 플레이시 홈런 2콤보 이상 기록', 6, 1, 1, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1021, 1022, 1000, 6, 3, 150, -1, '미션모드에서 1회 플레이시 홈런 3콤보 이상 기록', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1022, 1020, 1000, 6, 4, 300, -1, '미션모드에서 1회 플레이시 홈런 4콤보 이상 기록', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1030, 1031, 1000, 7, 5, 100, -1, '미션모드 승리 5회 성공', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1031, 1032, 1000, 7, 25, 300, -1, '미션모드 승리 누적 25회', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1032, 1033, 1000, 7, 100, 700, -1, '미션모드 승리 누적 100회', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1033, 1033, 1000, 7, 50, 500, -1, '미션모드 승리 누적 50회', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1040, 1041, 1000, 8, 4, 100, -1, '미션모드에서 연승 4회 성공', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1041, 1042, 1000, 8, 7, 500, -1, '미션모드에서 연승 7회 성공', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1042, 1040, 1000, 8, 10, 800, -1, '미션모드에서 연승 10회 성공', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1050, 1051, 1000, 9, 1, 50, -1, '미션모드 1회 플레이', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1051, 1052, 1000, 9, 100, 300, -1, '미션모드 100회 플레이', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1052, 1052, 1000, 9, 200, 500, -1, '미션모드 200회 플레이', 6, 0, 1, 3)


