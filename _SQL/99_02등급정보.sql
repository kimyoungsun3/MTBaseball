select * from dbo.tLottoPowerInfo order by powerball asc
select * from dbo.tLottoTotalInfo order by total asc

---------------------------------------------
--	파워볼정보.
---------------------------------------------
IF OBJECT_ID (N'dbo.tLottoPowerInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tLottoPowerInfo;
GO

create table dbo.tLottoPowerInfo(
	idx						int					IDENTITY(1,1),

	powerball				int,
	result1					varchar(10),
	result2					varchar(10),
	result3					varchar(10),

	-- Constraint
	CONSTRAINT	pk_tLottoPowerInfo_powerball	PRIMARY KEY(powerball)
)
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(0, 'A', '짝', '언더')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(1, 'A', '홀', '언더')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(2, 'A', '짝', '언더')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(3, 'B', '홀', '언더')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(4, 'B', '짝', '언더')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(5, 'C', '홀', '오버')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(6, 'C', '짝', '오버')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(7, 'D', '홀', '오버')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(8, 'D', '짝', '오버')
GO
insert into dbo.tLottoPowerInfo(powerball, result1, result2, result3) values(9, 'D', '홀', '오버')
GO

---------------------------------------------
--	합으로 업기.
---------------------------------------------
IF OBJECT_ID (N'dbo.tLottoTotalInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tLottoTotalInfo;
GO

create table dbo.tLottoTotalInfo(
	idx						int					IDENTITY(1,1),

	total					int,
	result1					varchar(10),
	result2					varchar(10),
	result3					varchar(10),
	result4					varchar(10),

	-- Constraint
	CONSTRAINT	pk_tLottoTotalInfo_total		PRIMARY KEY(total)
)

insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(57, 'C', '소', '호', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(67, 'E', '중', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(84, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(50, 'C', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(63, 'D', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(56, 'C', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(90, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(82, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(107, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(87, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(42, 'B', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(65, 'D', '중', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(89, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(69, 'E', '중', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(92, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(36, 'B', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(45, 'B', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(98, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(58, 'D', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(68, 'E', '중', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(51, 'C', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(49, 'B', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(102, 'F', '대', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(53, 'C', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(46, 'B', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(40, 'B', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(60, 'D', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(103, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(71, 'E', '중', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(72, 'E', '중', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(33, 'A', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(55, 'C', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(81, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(78, 'E', '중', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(99, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(66, 'E', '중', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(70, 'E', '중', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(74, 'E', '중', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(61, 'D', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(88, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(94, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(86, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(79, 'F', '중', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(62, 'D', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(73, 'E', '중', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(80, 'F', '중', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(30, 'A', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(91, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(85, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(23, 'A', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(52, 'C', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(95, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(77, 'E', '중', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(105, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(101, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(106, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(112, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(34, 'A', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(111, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(83, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(76, 'E', '중', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(108, 'F', '대', '짝', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(109, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(44, 'B', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(64, 'D', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(28, 'A', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(59, 'D', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(93, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(97, 'F', '대', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(75, 'E', '중', '홀', '오버')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(35, 'A', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(24, 'A', '소', '짝', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(25, 'A', '소', '홀', '언더')
GO
insert into dbo.tLottoTotalInfo(total, result1, result2, result3, result4) values(26, 'A', '소', '짝', '언더')
GO