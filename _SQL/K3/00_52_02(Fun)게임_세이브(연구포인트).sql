use Game4FarmVill3
GO
/*
210]88952{			//코인
217]66666{			//우정포인트
215]33423{			//캐쉬
216]77777{			//vip
1010]45}44}47{		//티켓
700]99915{			//연구포인트

-- 세이브 데이타에서 결정수량을 파악
select dbo.fnu_GetFVSaveDataToRebrith('xxxxxx')
select dbo.fnu_GetFVSaveDataToRebrith('210]88952{217]66666{215]33423{216]77777{220]0{230]1{240]1{231]70{1000]3500}3400}3501{1010]45}44}47{1100]{1210]3{1200]623{310]1{320]1{370]1{340]1{380]1{350]1{804]0{801]1{802]1{805]0{807]0{808]1{200]10040}10007}10015}10023}10041}10050{201]10001}10010}10019}10028}10037}10046}10006}10013}10040}10007}10049}10022}10023}10015}10041}10050}10004}10032}10051}10014}10031}10033{202]1}1}1}1}1}1}2}2}1}2}1}1}5}1}4}1}2}2}1}1}2}1{203]10001}10010}10019}10028}10037}10046}10006}10013}10040}10007}10049}10022}10023}10015}10041}10050}10004}10032}10051}10014}10031}10033}10005{204]10001}10010}10019}10028}10037}10046}10041}10032}10023}10014}10015}10007}10005}10006{1600]81{500]{510]{520]{600]06/23/2015 19:21:16{700]99915{710]3{720]{730]{910]{930]{920]{1400]{940]{1501]3213{1700]8{1800]5')
*/

IF OBJECT_ID ( N'dbo.fnu_GetFVSaveDataToRebrith', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVSaveDataToRebrith;
GO

CREATE FUNCTION dbo.fnu_GetFVSaveDataToRebrith(
	@strValue_ 			varchar(8000)
)
	RETURNS bigint
AS
BEGIN
	--declare @strValue_ 	varchar(8000)
	--set @strValue_		= '210]88952{217]66666{215]33423{216]77777{220]0{230]1{240]1{231]70{1000]3500}3400}3501{1010]45}44}47{1100]{1210]3{1200]623{310]1{320]1{370]1{340]1{380]1{350]1{804]0{801]1{802]1{805]0{807]0{808]1{200]10040}10007}10015}10023}10041}10050{201]10001}10010}10019}10028}10037}10046}10006}10013}10040}10007}10049}10022}10023}10015}10041}10050}10004}10032}10051}10014}10031}10033{202]1}1}1}1}1}1}2}2}1}2}1}1}5}1}4}1}2}2}1}1}2}1{203]10001}10010}10019}10028}10037}10046}10006}10013}10040}10007}10049}10022}10023}10015}10041}10050}10004}10032}10051}10014}10031}10033}10005{204]10001}10010}10019}10028}10037}10046}10041}10032}10023}10014}10015}10007}10005}10006{1600]81{500]{510]{520]{600]06/23/2015 19:21:16{700]99915{710]3{720]{730]{910]{930]{920]{1400]{940]{1501]3213{1700]8{1800]5'
	--set @strValue_		= 'xxxx'
	--set @strValue_		= 'xxxx%9:1,2,3'

	declare @rtn 				bigint				set @rtn		= 0
	declare @charSplit_ 		varchar(10)			set @charSplit_ = '{700]'
	declare @charSplit2_ 		varchar(10)			set @charSplit2_= '{'
	declare @len2				int					set @len2		= len(@charSplit_)
	declare @posStart 	int,
			@posNext 	int
	set @posStart 	= 1 	-- 구분문자 검색을 시작할 위치
	set @posNext 	= 1 	-- 구분문자 위치

	set @posStart 	= CHARINDEX(@charSplit_, @strValue_, @posStart)
	set @posNext 	= CHARINDEX(@charSplit2_, @strValue_, @posStart + 1)

	--select 'DEBUG', @posStart posStart, @posNext posNext, @len2 len2
	if(@posStart != 0 and @posNext != 0)
		begin
			set @strValue_ 	= SUBSTRING(@strValue_, @posStart + @len2, @posNext - (@posStart + @len2))
		end
	else
		begin
			set @strValue_ = ''
		end
	--select 'DEBUG', @strValue_ strValue_, @posStart posStart, @posNext posNext


	if(LEN(@strValue_) >= 1)
		begin
			SELECT @rtn = listidx FROM dbo.fnu_SplitOne(',', @strValue_) where idx = 0
		end
	--select 'DEBUG', @rtn rtn
	RETURN @rtn
END

