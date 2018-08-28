
use GameMTBaseball
GO

----------------------------------------------
-- 1. 샘플 유저데이타를 입력
-- 2. 유저 정보에 따라서 계정생성.
----------------------------------------------
IF OBJECT_ID (N'dbo.tSample', N'U') IS NOT NULL
	DROP TABLE dbo.tSample;
GO

create table dbo.tSample(
	gameid		varchar(20),
	password	varchar(20),
	email		varchar(60),
	market		int						default(1),
	buytype		int						default(1),
	platform	int						default(1),
	ccode		int						default(1),
	ukey		varchar(128),
	version		int						default(100),
	phone		varchar(20)				default(''),
	pushid		varchar(128)			default(''),

	CONSTRAINT pk_tSample_gameid	PRIMARY KEY(gameid)
)
GO


----------------------------------------------
-- 2. 유저 샘플입력하기
----------------------------------------------
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kyssmart', '049000s1i0n7t8445289', 'kyssmart@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'yolkearn92', '049000s1i0n7t8445289', 'yolkearn929@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'bulletmatc', '049000s1i0n7t8445289', 'bulletmatch@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'abbytumble', '049000s1i0n7t8445289', 'abbytumble562@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'byexyloid7', '049000s1i0n7t8445289', 'byexyloid727@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'richhole22', '049000s1i0n7t8445289', 'richhole222@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'quicksilve', '049000s1i0n7t8445289', 'quicksilverfile7@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nuclearbai', '049000s1i0n7t8445289', 'nuclearbail@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'marineown4', '049000s1i0n7t8445289', 'marineown460@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'holequiz56', '049000s1i0n7t8445289', 'holequiz566@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lolderlook', '049000s1i0n7t8445289', 'lolderlook727@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'xraykid', '049000s1i0n7t8445289', 'xraykid@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'emotioneas', '049000s1i0n7t8445289', 'emotioneast@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'wildrunner', '049000s1i0n7t8445289', 'wildrunner@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'evejacket', '049000s1i0n7t8445289', 'evejacket@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'knowledgee', '049000s1i0n7t8445289', 'knowledgeelli@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'peanuted50', '049000s1i0n7t8445289', 'peanuted504@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kingdomper', '049000s1i0n7t8445289', 'kingdompersuade@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'tailtire', '049000s1i0n7t8445289', 'tailtire@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kickqost', '049000s1i0n7t8445289', 'kickqost@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'bailnuke', '049000s1i0n7t8445289', 'bailnuke@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'umbrellaaw', '049000s1i0n7t8445289', 'umbrellaawe@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'personaway', '049000s1i0n7t8445289', 'personaways404@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'holsterhea', '049000s1i0n7t8445289', 'holsterheavy146@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ownfull541', '049000s1i0n7t8445289', 'ownfull541@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nexusugly3', '049000s1i0n7t8445289', 'nexusugly335@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'majorkilo9', '049000s1i0n7t8445289', 'majorkilo981@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'xysterspar', '049000s1i0n7t8445289', 'xystersparkle135@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'spellxeed', '049000s1i0n7t8445289', 'spellxeed@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'upguest556', '049000s1i0n7t8445289', 'upguest556@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'taxq656', '049000s1i0n7t8445289', 'taxq656@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'justiceheh', '049000s1i0n7t8445289', 'justiceheh@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'jbdesp', '049000s1i0n7t8445289', 'jbdesp@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'persuadefa', '049000s1i0n7t8445289', 'persuadefaz857@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'holeearth9', '049000s1i0n7t8445289', 'holeearth935@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'leaguefaz', '049000s1i0n7t8445289', 'leaguefaz@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'makegman37', '049000s1i0n7t8445289', 'makegman372@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nethell683', '049000s1i0n7t8445289', 'nethell683@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'vestworn15', '049000s1i0n7t8445289', 'vestworn157@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'navyheaven', '049000s1i0n7t8445289', 'navyheaven176@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'xionlucife', '049000s1i0n7t8445289', 'xionlucifer@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lolderhome', '049000s1i0n7t8445289', 'lolderhome@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'noblessque', '049000s1i0n7t8445289', 'noblessqueen@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'measureove', '049000s1i0n7t8445289', 'measureover@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'qualitygla', '049000s1i0n7t8445289', 'qualityglacial@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'yawjop886', '049000s1i0n7t8445289', 'yawjop886@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ghimeyelt', '049000s1i0n7t8445289', 'ghimeyelt@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'growlerswe', '049000s1i0n7t8445289', 'growlersweetly640@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'homekick', '049000s1i0n7t8445289', 'homekick@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'barkdune', '049000s1i0n7t8445289', 'barkdune@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'killerlase', '049000s1i0n7t8445289', 'killerlaser@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'zookiko', '049000s1i0n7t8445289', 'zookiko@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'baseking', '049000s1i0n7t8445289', 'baseking@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'delman', '049000s1i0n7t8445289', 'delman@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'gwangkuk', '049000s1i0n7t8445289', 'gwangkuk@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'khj745', '049000s1i0n7t8445289', 'khj745@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'saebaryo', '049000s1i0n7t8445289', 'saebaryo@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'gigaidlr', '049000s1i0n7t8445289', 'gigaidlr@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'rladlsduu', '049000s1i0n7t8445289', 'rladlsduu@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'crywwet', '049000s1i0n7t8445289', 'crywwet@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'wjdddmsl', '049000s1i0n7t8445289', 'wjdddmsl@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'samwisse', '049000s1i0n7t8445289', 'samwisse@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'elazarr', '049000s1i0n7t8445289', 'elazarr@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'joobanndi', '049000s1i0n7t8445289', 'joobanndi@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dorraiva', '049000s1i0n7t8445289', 'dorraiva@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'reddhouse', '049000s1i0n7t8445289', 'reddhouse@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kerroland', '049000s1i0n7t8445289', 'kerroland@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'gomsshine', '049000s1i0n7t8445289', 'gomsshine@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'doremys', '049000s1i0n7t8445289', 'doremys@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'atasa', '049000s1i0n7t8445289', 'atasa@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'posiiop76', '049000s1i0n7t8445289', 'posiiop76@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'emypinky', '049000s1i0n7t8445289', 'emypinky@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kcicata01', '049000s1i0n7t8445289', 'kcicata01@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dnkibu', '049000s1i0n7t8445289', 'dnkibu@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'deminida', '049000s1i0n7t8445289', 'deminida@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'aongrin064', '049000s1i0n7t8445289', 'aongrin0642@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'esjunsik', '049000s1i0n7t8445289', 'esjunsik@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'warsenal', '049000s1i0n7t8445289', 'warsenal@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'qarkas214', '049000s1i0n7t8445289', 'qarkas214@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'zcerver', '049000s1i0n7t8445289', 'zcerver@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dhh132', '049000s1i0n7t8445289', 'dhh132@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ioman1030', '049000s1i0n7t8445289', 'ioman1030@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'brtemis', '049000s1i0n7t8445289', 'brtemis@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ali00173', '049000s1i0n7t8445289', 'ali00173@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'usk6021', '049000s1i0n7t8445289', 'usk6021@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'quvius', '049000s1i0n7t8445289', 'quvius@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'eeelre0401', '049000s1i0n7t8445289', 'eeelre0401@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'uoserian', '049000s1i0n7t8445289', 'uoserian@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ourpleston', '049000s1i0n7t8445289', 'ourplestone@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dani7777', '049000s1i0n7t8445289', 'dani7777@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'manaumi80', '049000s1i0n7t8445289', 'manaumi80@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'jnsoryoo', '049000s1i0n7t8445289', 'jnsoryoo@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ehite', '049000s1i0n7t8445289', 'ehite@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'donmr', '049000s1i0n7t8445289', 'donmr@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'donghw', '049000s1i0n7t8445289', 'donghw@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'yotoroya', '049000s1i0n7t8445289', 'yotoroya@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lang588711', '049000s1i0n7t8445289', 'lang588711@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'hali3030', '049000s1i0n7t8445289', 'hali3030@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'litanos', '049000s1i0n7t8445289', 'litanos@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dhadow', '049000s1i0n7t8445289', 'dhadow@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'spple', '049000s1i0n7t8445289', 'spple@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nodern005', '049000s1i0n7t8445289', 'nodern005@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'sudrkaak', '049000s1i0n7t8445289', 'sudrkaak@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'vlthgus', '049000s1i0n7t8445289', 'vlthgus@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lang13', '049000s1i0n7t8445289', 'lang13@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'polzip', '049000s1i0n7t8445289', 'polzip@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'kinhyim77', '049000s1i0n7t8445289', 'kinhyim77@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'spril1218', '049000s1i0n7t8445289', 'spril1218@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nabosari', '049000s1i0n7t8445289', 'nabosari@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'vjhyun20', '049000s1i0n7t8445289', 'vjhyun20@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'nonobono', '049000s1i0n7t8445289', 'nonobono@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'oh0515', '049000s1i0n7t8445289', 'oh0515@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'naragi', '049000s1i0n7t8445289', 'naragi@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'keon811', '049000s1i0n7t8445289', 'keon811@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'aovelab', '049000s1i0n7t8445289', 'aovelab@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'zongsily', '049000s1i0n7t8445289', 'zongsily@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'zyfeel24', '049000s1i0n7t8445289', 'zyfeel24@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'vhosun', '049000s1i0n7t8445289', 'vhosun@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'mayoung7', '049000s1i0n7t8445289', 'mayoung720@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ggo5219', '049000s1i0n7t8445289', 'ggo5219@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'xake1207', '049000s1i0n7t8445289', 'xake1207@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'hath22', '049000s1i0n7t8445289', 'hath22@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'tucifelz', '049000s1i0n7t8445289', 'tucifelz@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lwjeong', '049000s1i0n7t8445289', 'lwjeong@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'jejily', '049000s1i0n7t8445289', 'jejily@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'lsn9372', '049000s1i0n7t8445289', 'lsn9372@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'dsaccoun', '049000s1i0n7t8445289', 'dsaccount@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'doulj', '049000s1i0n7t8445289', 'doulj@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'ly8779', '049000s1i0n7t8445289', 'ly8779@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')
insert into dbo.tSample(gameid, password, email, market, buytype, platform, ccode, ukey, version, phone, pushid) values( 'hwangsuk', '049000s1i0n7t8445289', 'hwangsuk80@naver.com', 1, 0, 1, 2, 'ukukukuk', 100, '', '')


/*
-- 3. 샘플로 유저데이타 입력
select kakaonickname, gameid from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample) order by kakaonickname asc
select gameid from dbo.tSample order by gameid asc
*/
declare @gameid 	varchar(20)		set @gameid = 'farm'	-- guest, farm, iuest
declare @nickname	varchar(20)
declare @phone 		varchar(20)
declare @var 		int

-- 3-1. 커서선언
declare curSample Cursor for
select gameid from dbo.tSample
where gameid not in (select kakaonickname from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample))

select @var = max(idx) + 1 from dbo.tUserMaster

-- 3-2. 커서오픈
open curSample

-- 3-3. 커서 사용
Fetch next from curSample into @nickname
while @@Fetch_status = 0
	Begin
		set @phone	= '010' + ltrim(@var)
		set @var 	= @var + 1

		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							5,							-- market
							0,							-- buytype
							1,							-- platform
							'ukukukuk',					-- ukey
							101,						-- version
							@phone,						-- phone
							'',							-- pushid

							'',							-- kakaotalkid (없으면 임으로 생성해줌)
							'',							-- kakaouserid (없으면 임으로 생성해줌)
							@nickname, 					-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'',							-- kakaofriendlist(kakaouserid)
							-1

		Fetch next from curSample into @nickname
	end

-- 3-4. 커서닫기
close curSample
Deallocate curSample

