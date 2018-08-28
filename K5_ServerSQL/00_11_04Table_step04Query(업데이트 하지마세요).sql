use GameMTBaseball
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강원도립대학' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강원도립대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북도립대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경북도립대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충남도립청양대학' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '충남도립청양대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국복지대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국복지대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가톨릭상지대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '가톨릭상지대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '군산간호대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '군산간호대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '거제대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '거제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경남정보대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '경남정보대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경민대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경민대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구미래대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구미래대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북전문대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경북전문대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경복대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경복대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경인여자대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '경인여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서라벌대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '서라벌대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광양보건대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '광양보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주보건대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서해대학' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '서해대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '군장대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '군장대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '고구려대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '고구려대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '기독간호대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '기독간호대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전주기전대학' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전주기전대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '김포대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '김포대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '농협대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '농협대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구보건대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '대구보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '수성대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '수성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대림대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '대림대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '우송정보대학' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '우송정보대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동남보건대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '동남보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동부산대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동부산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동아방송예술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '동아방송예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동아인재대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '동아인재대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동양미래대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '동양미래대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동원대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '동원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동주대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '마산대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '마산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '명지전문대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '명지전문대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '목포과학대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '목포과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '배화여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '배화여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '삼육보건대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '삼육보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서영대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '서영대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울여자간호대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울여자간호대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울예술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '서울예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성덕대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '성덕대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '송원대학' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '송원대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '수원과학대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '수원과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '청암대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '청암대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신성대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '신성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '안동과학대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '안동과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '안산대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '안산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '연성대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '연성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '연암공업대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '연암공업대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강릉영동대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강릉영동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '오산대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '오산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '용인송담대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '용인송담대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '울산과학대학교' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '울산과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '원광보건대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '원광보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인하공업전문대학' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인하공업전문대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '적십자간호대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '적십자간호대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '제주산업정보대학' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '제주산업정보대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '조선간호대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '조선간호대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '진주보건대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '진주보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '창원문성대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '창원문성대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '청강문화산업대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '청강문화산업대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '춘해보건대학교' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '춘해보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '선린대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '선린대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '포항대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '포항대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한림성심대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한림성심대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '혜전대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '혜전대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서정대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '서정대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '웅지세무대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '웅지세무대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '김해대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '김해대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국농수산대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국농수산대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국골프대학' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한국골프대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '원주대학' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '원주대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국철도대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국철도대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경남도립거창대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '경남도립거창대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경남도립남해대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '경남도립남해대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충북도립대학' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '충북도립대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인천전문대학' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인천전문대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가천길대학' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '가천길대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경산1대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경산1대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영남외국어대학' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '영남외국어대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경원전문대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경원전문대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '계명문화대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '계명문화대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '계원예술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '계원예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '구미대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '구미대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강동대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '강동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '김천과학대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '김천과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '김천대학' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '김천대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대경대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구공업대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '대구공업대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구과학대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '대구과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대동대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '대동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대원대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '대원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동서울대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '동서울대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대전보건대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '대전보건대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '혜천대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '혜천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '아주자동차대학' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '아주자동차대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인천재능대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인천재능대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북과학대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경북과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동명대학' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동명대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동강대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '동강대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동우대학' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '동우대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동의과학대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동의과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '두원공과대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '두원공과대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '문경대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '문경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '백제예술대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '백제예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '벽성대학' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '벽성대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산경상대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산경상대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산여자대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산과학기술대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부천대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '부천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '삼육의명대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '삼육의명대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '상지영서대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '상지영서대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울보건대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '서울보건대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서일대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서일대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성심외국어대학' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '성심외국어대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '수원여자대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '수원여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '순천제일대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '순천제일대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '숭의여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '숭의여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신구대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '신구대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신흥대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '신흥대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신안산대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '신안산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '양산대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '양산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '여주대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '여주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '천안연암대학' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '천안연암대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영남이공대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '영남이공대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세경대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '세경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영진전문대학' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '영진전문대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국영상대학교' and schoolarea = '세종' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '세종', '한국영상대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '유한대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '유한대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인덕대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '인덕대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '장안대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '장안대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전남과학대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '전남과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전주비전대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전주비전대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전북과학대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전북과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '제주관광대학교' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '제주관광대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '조선이공대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '조선이공대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충북보건과학대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '충북보건과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '우송공업대학' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '우송공업대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '창신대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '창신대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '백석문화대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '백석문화대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대덕대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '대덕대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충청대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '충청대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강원관광대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강원관광대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '국제대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '국제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '제주한라대학교' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '제주한라대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한양여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한양여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한영대학' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '한영대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경기과학기술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경기과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산예술대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전남도립대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '전남도립대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '송호대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '송호대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국관광대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국관광대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '송곡대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '송곡대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국승강기대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '한국승강기대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '공주교육대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '공주교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주교육대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구교육대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '대구교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산교육대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울교육대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경인교육대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '경인교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경인교육대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경인교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전주교육대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전주교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '진주교육대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '진주교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '청주교육대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '청주교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '춘천교육대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '춘천교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강릉원주대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강릉원주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강릉원주대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강릉원주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강원대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강원대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '강원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '경북대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경북대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경상대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '경상대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '공주대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '공주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '군산대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '군산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '금오공과대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '금오공과대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '목포대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '목포대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '목포해양대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '목포해양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부경대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '순천대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '순천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '안동대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '안동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전남대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '전남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전남대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '전남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전북대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전북대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '제주대학교' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '제주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '창원대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '창원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충남대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '충남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '충북대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '충북대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국교원대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '한국교원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국체육대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국체육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국해양대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '한국해양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국교통대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '한국교통대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경남과학기술대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '경남과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울과학기술대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한경대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한밭대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '한밭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울시립대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울시립대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인천대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가야대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '가야대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가야대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '가야대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가톨릭대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가톨릭대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가톨릭대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '감리교신학대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '감리교신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '강남대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '강남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '건국대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '건국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '건국대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '건국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '건양대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '건양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '건양대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '건양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경기대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '경기대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경기대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '경기대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경남대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '경남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경동대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '경동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경동대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '경동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경동대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '경동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구한의대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구한의대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경성대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '경성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '가천대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '가천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경일대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경일대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경주대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경희대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '경희대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '계명대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '계명대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '고려대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '고려대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '고려대학교 세종캠퍼스' and schoolarea = '세종' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '세종', '고려대학교 세종캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '고신대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '고신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '관동대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '관동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광신대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광운대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '광운대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주가톨릭대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '광주가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주여자대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '국민대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '국민대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '그리스도대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '그리스도대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '극동대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '극동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '나사렛대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '나사렛대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '단국대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '단국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '단국대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '단국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구예술대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구가톨릭대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세한대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '세한대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대신대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대전가톨릭대학교' and schoolarea = '세종' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '세종', '대전가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대전대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '대전대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대진대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '대진대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울기독대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울기독대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '덕성여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '덕성여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동국대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '동국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동국대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '동국대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동덕여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '동덕여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동서대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동서대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동신대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '동신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동아대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동아대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동양대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '동양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동의대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동의대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '루터대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '루터대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '명지대학교 인문캠퍼스' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '명지대학교 인문캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '명지대학교 자연캠퍼스' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '명지대학교 자연캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '목원대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '목원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '배재대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '배재대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산가톨릭대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산외국어대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '삼육대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '삼육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '상명대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '상명대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '상명대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '상명대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '상지대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '상지대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서강대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서강대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서경대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서남대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '서남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서남대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '서남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울신학대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '서울신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울장신대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '서울장신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서원대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '서원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '선문대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '선문대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성결대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '성결대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성공회대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '성공회대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성균관대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '성균관대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '성신여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '성신여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세명대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '세명대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세종대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '세종대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '수원가톨릭대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '수원가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '수원대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '수원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '숙명여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '숙명여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '순천향대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '순천향대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '숭실대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '숭실대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신라대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '신라대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '아세아연합신학대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '아세아연합신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '아주대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '아주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '안양대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '안양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '안양대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '안양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '연세대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '연세대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '연세대학교 원주캠퍼스' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '연세대학교 원주캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영남대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '영남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영남신학대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '영남신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영동대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '영동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영산선학대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '영산선학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '용인대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '용인대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '우석대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '우석대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '울산대학교' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '울산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '원광대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '원광대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '위덕대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '위덕대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '을지대학교 대전캠퍼스' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '을지대학교 대전캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '을지대학교 성남캠퍼스' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '을지대학교 성남캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '이화여자대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '이화여자대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인제대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '인제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인제대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '인제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인천가톨릭대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인천가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인천가톨릭대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인천가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '인하대학교' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '인하대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '장로회신학대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '장로회신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '전주대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '전주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '조선대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '조선대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '중부대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '중부대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '중앙대학교 서울캠퍼스' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '중앙대학교 서울캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '중앙대학교 안성캠퍼스' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '중앙대학교 안성캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '중앙승가대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '중앙승가대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '백석대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '백석대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '청주대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '청주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '총신대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '총신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '추계예술대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '추계예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '침례신학대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '침례신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '칼빈대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '칼빈대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '탐라대학교' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '탐라대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '평택대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '평택대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '차의과학대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '차의과학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '포항공과대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '포항공과대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국기술교육대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한국기술교육대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국성서대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국성서대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국외국어대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국외국어대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국항공대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국항공대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한남대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '한남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한동대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '한동대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한라대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한라대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한림대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한림대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한서대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한서대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한성대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한세대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한세대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한신대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한양대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한양대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한양대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한영신학대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한영신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한일장신대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '한일장신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '협성대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '협성대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '호남대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '호남대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '호남신학대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '호남신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '호서대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '호서대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '홍익대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '홍익대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '홍익대학교 세종캠퍼스' and schoolarea = '세종' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '세종', '홍익대학교 세종캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '꽃동네대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '꽃동네대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '남부대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '남부대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '예원예술대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '예원예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '예원예술대학교 전주캠퍼스' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '예원예술대학교 전주캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한중대학교' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한중대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '목포가톨릭대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '목포가톨릭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산장신대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '부산장신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '금강대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '금강대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구외국어대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '예수대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '예수대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국국제대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '한국국제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한북대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한북대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경북외국어대학교' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '경북외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신경대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '신경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동명대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동명대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영산대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '영산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영산대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '영산대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대전신학대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '대전신학대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '중원대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '중원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '우송대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '우송대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '김천대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '김천대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한려대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '한려대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '송원대학교' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '송원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경운대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경운대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '남서울대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '남서울대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '초당대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '초당대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국산업기술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국산업기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '제주국제대학교' and schoolarea = '제주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '제주', '제주국제대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '창신대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '창신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '울산과학기술대학교' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '울산과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국과학기술원' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '한국과학기술원')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주과학기술원' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주과학기술원')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국방송통신대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국방송통신대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한밭대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '한밭대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울과학기술대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울과학기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한경대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한경대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '진주산업대학교' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '진주산업대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국교통대학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '한국교통대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국산업기술대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국산업기술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '광주대학교(산업대)' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '광주대학교(산업대)')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '남서울대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '남서울대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '동명정보대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '동명정보대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영산대학교(산업대)' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '영산대학교(산업대)')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영산대학교(산업대)' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '영산대학교(산업대)')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '우송대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '우송대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '호원대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '호원대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '초당대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '초당대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '청운대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '청운대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경운대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '경운대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한려대학교' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '한려대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '정석대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '정석대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '구세군사관학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '구세군사관학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대전신학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '대전신학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한민학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한민학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '순복음총회신학교' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '순복음총회신학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국예술종합학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국예술종합학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국전통문화대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한국전통문화대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세계사이버대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '세계사이버대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영남사이버대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '영남사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '삼성중공업공과대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '삼성중공업공과대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = 'SPC식품과학대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', 'SPC식품과학대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대우조선해양공과대학' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '대우조선해양공과대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '현대중공업공과대학' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '현대중공업공과대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '삼성전자공과대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '삼성전자공과대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = 'KDB금융대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', 'KDB금융대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = 'LH토지주택대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', 'LH토지주택대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '경희사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '경희사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '국제사이버대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '국제사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '대구사이버대학교' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '대구사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '부산디지털대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '부산디지털대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울디지털대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울디지털대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '서울사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '세종사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '세종사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '열린사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '열린사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '원광디지털대학교' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '원광디지털대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '고려사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '고려사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '숭실사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '숭실사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '디지털서울문화예술대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '디지털서울문화예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한양사이버대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한양사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '사이버한국외국어대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '사이버한국외국어대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '화신사이버대학교' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '화신사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '글로벌사이버대학교' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '글로벌사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '건양사이버대학교' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '건양사이버대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '영진사이버대학' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '영진사이버대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국복지사이버대학' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '한국복지사이버대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '국제예술대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '국제예술대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '백석예술대학교' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '백석예술대학교')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '정화예술대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '정화예술대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '정화예술대학' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '정화예술대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국정보통신기능대학' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국정보통신기능대학')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍Ⅰ대학 서울정수캠퍼스' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국폴리텍Ⅰ대학 서울정수캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 I 대학 서울강서캠퍼스' and schoolarea = '서울' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울', '한국폴리텍 I 대학 서울강서캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 I 대학 성남캠퍼스' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국폴리텍 I 대학 성남캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 II 대학 인천캠퍼스' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '한국폴리텍 II 대학 인천캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 II 대학 남인천캠퍼스' and schoolarea = '인천' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '인천', '한국폴리텍 II 대학 남인천캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 III 대학 춘천캠퍼스' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한국폴리텍 III 대학 춘천캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 III 대학 강릉캠퍼스' and schoolarea = '강원' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '강원', '한국폴리텍 III 대학 강릉캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍IV 대학 대전캠퍼스' and schoolarea = '대전' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대전', '한국폴리텍IV 대학 대전캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 IV 대학 청주캠퍼스' and schoolarea = '충북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충북', '한국폴리텍 IV 대학 청주캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 IV 대학 아산캠퍼스' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한국폴리텍 IV 대학 아산캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 IV 대학 홍성캠퍼스' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한국폴리텍 IV 대학 홍성캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍V대학 광주캠퍼스' and schoolarea = '광주' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '광주', '한국폴리텍V대학 광주캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 V 대학 김제캠퍼스' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '한국폴리텍 V 대학 김제캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍V대학 목포캠퍼스' and schoolarea = '전남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전남', '한국폴리텍V대학 목포캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 익산캠퍼스' and schoolarea = '전북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '전북', '한국폴리텍대학 익산캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 대구캠퍼스' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '한국폴리텍대학 대구캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 구미캠퍼스' and schoolarea = '경북' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경북', '한국폴리텍대학 구미캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 창원캠퍼스' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '한국폴리텍대학 창원캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍Ⅶ대학 부산캠퍼스' and schoolarea = '부산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '부산', '한국폴리텍Ⅶ대학 부산캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 VII 대학 울산캠퍼스' and schoolarea = '울산' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '울산', '한국폴리텍 VII 대학 울산캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학바이오캠퍼스' and schoolarea = '충남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '충남', '한국폴리텍대학바이오캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍 섬유패션캠퍼스' and schoolarea = '대구' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '대구', '한국폴리텍 섬유패션캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 안성여자캠퍼스' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '한국폴리텍대학 안성여자캠퍼스')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '한국폴리텍대학 항공캠퍼스' and schoolarea = '경남' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경남', '한국폴리텍대학 항공캠퍼스')
 	end
GO

-- 학교 정보에 반영
if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울전문학교' and schoolarea = '서울중부' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울중부', '서울전문학교')
 	end
GO
if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '서울서호전문대' and schoolarea = '서울중부' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '서울중부', '서울서호전문대')
 	end
GO

if(not exists(select top 1 * from dbo.tSchoolBank where schoolname = '신한대학교' and schoolarea = '경기' and schoolkind = 4))
	begin
		insert into dbo.tSchoolBank(schoolkind, schoolarea, schoolname) values(4, '경기', '신한대학교')
 	end
GO