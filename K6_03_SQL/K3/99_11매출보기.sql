/*

--select gameid, cash, writedate from dbo.tFVCashLog
DECLARE @ttt TABLE(
	gameid		varchar(60),
	cash		int,
	writedate	varchar(10)
);

--별반차이가 없음.
insert into @ttt(gameid, cash, writedate)
select gameid, cash, Convert(varchar(8), writedate, 112)
from dbo.tFVCashLog order by writedate

select writedate, gameid, cash from @ttt order by writedate asc, gameid asc, cash asc
*/


20150630	farm1071788	3300
20150630	farm1122681	3300
20150630	farm1253818	5500
20150630	farm1253818	5500
20150630	farm1359631	5500
20150630	farm154371	3300
20150630	farm154371	5500
20150630	farm1679976	1100
20150630	farm1679976	1100
20150630	farm1679976	3300
20150630	farm1687801	1100
20150630	farm173159	3300
20150630	farm186320	3300
20150630	farm19599	3300
20150630	farm19599	5500
20150630	farm204333	3300
20150630	farm204333	5500
20150630	farm204333	5500
20150630	farm204333	5500
20150630	farm218211	5500
20150630	farm2355263	3300
20150630	farm285353	1100
20150630	farm308458	3300
20150630	farm451704	5500
20150630	farm623185	1100
20150630	farm623185	3300
20150630	farm681666	5500
20150630	farm681666	5500
20150630	farm704129	3300
20150630	farm86356	5500
20150630	farm86356	5500
20150630	farm89459	3300
20150630	farm971834	1100
20150701	farm1032719	3300
20150701	farm1122681	5500
20150701	farm115820	3300
20150701	farm115820	5500
20150701	farm115820	33000
20150701	farm1318468	1100
20150701	farm1318468	3300
20150701	farm1511883	3300
20150701	farm1605316	3300
20150701	farm186320	5500
20150701	farm201446	3300
20150701	farm201446	5500
20150701	farm2034752	5500
20150701	farm2034752	5500
20150701	farm2034752	11000
20150701	farm2034752	33000
20150701	farm2098694	3300
20150701	farm2306507	3300
20150701	farm2355263	5500
20150701	farm2407778	3300
20150701	farm2477129	1100
20150701	farm2494357	1100
20150701	farm2510909	3300
20150701	farm2616670	3300
20150701	farm2664204	5500
20150701	farm2698922	5500
20150701	farm2698922	33000
20150701	farm2818315	3300
20150701	farm2818315	33000
20150701	farm2818315	110000
20150701	farm2875289	5500
20150701	farm2880781	3300
20150701	farm2897907	5500
20150701	farm2897907	33000
20150701	farm2905922	3300
20150701	farm2967908	3300
20150701	farm3063395	5500
20150701	farm3084541	1100
20150701	farm3084541	5500
20150701	farm3112911	3300
20150701	farm3112911	5500
20150701	farm3127293	3300
20150701	farm3305615	5500
20150701	farm3305615	5500
20150701	farm3365945	5500
20150701	farm3516176	5500
20150701	farm3539719	11000
20150701	farm4020733	3300
20150701	farm4020733	5500
20150701	farm534729	5500
20150701	farm570758	5500
20150701	farm704129	5500
20150701	farm786523	3300
20150701	farm786523	33000
20150701	farm786523	33000
20150701	farm86356	3300
20150701	farm86356	33000
20150701	farm890404	5500
20150701	farm988477	3300
20150701	farm988477	5500
20150702	farm115820	33000
20150702	farm1329170	3300
20150702	farm1621954	3300
20150702	farm167710	3300
20150702	farm167710	5500
20150702	farm1771336	5500
20150702	farm1973382	5500
20150702	farm1990244	5500
20150702	farm2034752	5500
20150702	farm2034752	33000
20150702	farm2355263	5500
20150702	farm2460122	3300
20150702	farm2631527	3300
20150702	farm2638802	3300
20150702	farm2640179	3300
20150702	farm2760474	5500
20150702	farm2818315	110000
20150702	farm2875289	5500
20150702	farm2875289	5500
20150702	farm2967908	5500
20150702	farm306174	5500
20150702	farm3084541	5500
20150702	farm3084541	33000
20150702	farm3084541	33000
20150702	farm3305615	3300
20150702	farm3305615	11000
20150702	farm3396458	5500
20150702	farm3514689	3300
20150702	farm3514689	5500
20150702	farm3514689	5500
20150702	farm3539719	5500
20150702	farm3539719	11000
20150702	farm3645923	33000
20150702	farm3722764	5500
20150702	farm3970229	33000
20150702	farm4061978	5500
20150702	farm4135958	5500
20150702	farm4138402	3300
20150702	farm4174196	1100
20150702	farm4174196	1100
20150702	farm4174196	3300
20150702	farm4199702	3300
20150702	farm4240157	3300
20150702	farm4240157	5500
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4240157	33000
20150702	farm4291266	3300
20150702	farm4364973	3300
20150702	farm4387129	5500
20150702	farm4420522	3300
20150702	farm4420522	5500
20150702	farm4432343	5500
20150702	farm4450698	5500
20150702	farm4450698	33000
20150702	farm4450698	33000
20150702	farm451704	33000
20150702	farm4568254	5500
20150702	farm4568254	33000
20150702	farm4678827	5500
20150702	farm470372	3300
20150702	farm470372	5500
20150702	farm4767511	1100
20150702	farm4767511	1100
20150702	farm4767511	3300
20150702	farm4790598	1100
20150702	farm4790598	1100
20150702	farm4790598	1100
20150702	farm4790598	1100
20150702	farm4798423	3300
20150702	farm4813290	3300
20150702	farm4813290	5500
20150702	farm4836720	3300
20150702	farm4836720	5500
20150702	farm4836720	5500
20150702	farm4836720	33000
20150702	farm4841643	5500
20150702	farm4905191	3300
20150702	farm4905191	33000
20150702	farm4947996	3300
20150702	farm4979276	5500
20150702	farm5003366	5500
20150702	farm5037375	3300
20150702	farm5037375	5500
20150702	farm5184249	3300
20150702	farm5277834	5500
20150702	farm5337949	5500
20150702	farm5337949	11000
20150702	farm5467611	5500
20150702	farm5496498	3300
20150702	farm570758	5500
20150702	farm875506	3300
20150702	farm875506	5500
20150702	farm988477	5500
20150703	farm1318468	5500
20150703	farm1679976	5500
20150703	farm1764184	5500
20150703	farm2500640	3300
20150703	farm2584223	5500
20150703	farm2760474	3300
20150703	farm2760474	33000
20150703	farm2831157	3300
20150703	farm2831157	5500
20150703	farm3090653	3300
20150703	farm3389263	3300
20150703	farm3514689	33000
20150703	farm4240157	66000
20150703	farm4418352	33000
20150703	farm4450698	33000
20150703	farm4510887	3300
20150703	farm4678827	33000
20150703	farm4836720	5500
20150703	farm4836720	33000
20150703	farm4877344	3300
20150703	farm5037375	5500
20150703	farm5037375	33000
20150703	farm5101503	3300
20150703	farm5101503	5500
20150703	farm5184249	5500
20150703	farm5184249	5500
20150703	farm5184249	5500
20150703	farm5337949	11000
20150703	farm5337949	11000
20150703	farm5337949	11000
20150703	farm542370	3300
20150703	farm542370	5500
20150703	farm5467611	33000
20150703	farm5774667	5500
20150703	farm5774667	33000
20150703	farm5912497	3300
20150703	farm5920685	3300
20150703	farm5929903	3300
20150703	farm5929903	5500
20150703	farm5929903	5500
20150703	farm5970306	1100
20150703	farm5989291	3300
20150703	farm6221795	5500
20150703	farm6273302	1100
20150703	farm6304616	3300
20150703	farm6304616	5500
20150703	farm6430172	5500
20150703	farm6676372	5500
20150703	farm6820723	1100
20150703	farm6863172	3300
20150703	farm911667	3300
20150703	farm911667	5500
20150703	farm96391	5500
20150704	farm1264858	1100
20150704	farm1318468	1100
20150704	farm1511883	5500
20150704	farm2017104	3300
20150704	farm204333	5500
20150704	farm204333	33000
20150704	farm2355263	1100
20150704	farm2664204	5500
20150704	farm2767157	3300
20150704	farm3144466	5500
20150704	farm367130	5500
20150704	farm3722764	3300
20150704	farm3970229	5500
20150704	farm4138402	5500
20150704	farm4177964	5500
20150704	farm4450698	5500
20150704	farm4450698	33000
20150704	farm4450698	33000
20150704	farm4509381	3300
20150704	farm4510887	5500
20150704	farm4596984	5500
20150704	farm4834632	1100
20150704	farm4963337	5500
20150704	farm5003366	5500
20150704	farm5184249	5500
20150704	farm5626993	5500
20150704	farm6002120	3300
20150704	farm6082467	3300
20150704	farm6201698	5500
20150704	farm6204653	5500
20150704	farm6204653	5500
20150704	farm6558296	3300
20150704	farm6558296	5500
20150704	farm6665250	1100
20150704	farm6665250	5500
20150704	farm6708722	3300
20150704	farm6820723	5500
20150704	farm6967418	5500
20150704	farm7111368	33000
20150704	farm7111368	33000
20150704	farm7640773	5500
20150704	farm7764857	1100
20150704	farm7772400	5500
20150705	farm1253818	33000
20150705	farm1461975	5500
20150705	farm2642440	3300
20150705	farm2642440	5500
20150705	farm2645786	5500
20150705	farm4240157	66000
20150705	farm4596984	3300
20150705	farm4596984	5500
20150705	farm6002120	5500
20150705	farm6002120	5500
20150705	farm627501	110000
20150705	farm646500	5500
20150705	farm7158496	5500
20150705	farm7162761	3300
20150705	farm7162761	5500
20150705	farm7236724	5500
20150705	farm7250406	3300
20150705	farm7365780	5500
20150705	farm7666514	5500
20150705	farm7966973	5500
20150705	farm8082716	3300
20150705	farm8082716	5500
20150705	farm8172679	1100
20150705	farm8172679	1100
20150705	farm8172679	3300
20150705	farm8186102	3300
20150705	farm8186102	5500
20150705	farm8205795	5500
20150705	farm8209244	5500
20150705	farm8263962	3300
20150705	farm8329622	3300
20150705	farm8329622	5500
20150705	farm8390716	3300
20150705	farm8433697	110000
20150705	farm8526237	3300
20150705	farm8531840	5500
20150705	farm8564316	5500
20150705	farm8564316	5500
20150705	farm8657277	5500
20150705	farm8768984	5500
20150705	farm8768984	33000
20150705	farm8837520	33000
20150705	farm8845990	33000
20150705	farm988477	5500
20150706	farm1113986	3300
20150706	farm1318468	1100
20150706	farm167710	33000
20150706	farm1845458	1100
20150706	farm1845458	1100
20150706	farm4387129	3300
20150706	farm4418352	33000
20150706	farm4418352	110000
20150706	farm4427627	3300
20150706	farm470372	5500
20150706	farm470372	5500
20150706	farm5184249	5500
20150706	farm5184249	33000
20150706	farm6002120	33000
20150706	farm6963332	3300
20150706	farm7039244	33000
20150706	farm7835371	3300
20150706	farm8209244	5500
20150706	farm8388535	5500
20150706	farm8444801	5500
20150706	farm8657277	5500
20150706	farm8845990	5500
20150706	farm9107636	5500
20150706	farm9117290	3300
20150706	farm9117290	11000
20150706	farm9117290	11000
20150706	farm9117290	11000
20150706	farm9117290	33000
20150706	farm9117290	33000
20150706	farm9117290	33000
20150706	farm9179965	5500
20150706	farm9265933	5500
20150706	farm9329921	3300
20150706	farm9329921	5500
20150706	farm9342572	5500
20150706	farm9361296	1100
20150706	farm9377899	5500
20150706	farm9391231	3300
20150706	farm9419279	3300
20150706	farm9419279	5500
20150706	farm9491777	5500
20150706	farm9746816	5500
20150706	farm9755394	3300
20150706	farm9919231	3300
20150707	farm10008515	11000
20150707	farm10042418	5500
20150707	farm10096364	1100
20150707	farm10099684	1100
20150707	farm10099684	1100
20150707	farm10191200	3300
20150707	farm10281934	3300
20150707	farm10281934	5500
20150707	farm10382108	33000
20150707	farm10452265	3300
20150707	farm10452265	5500
20150707	farm1776819	5500
20150707	farm204333	5500
20150707	farm2875289	5500
20150707	farm3365945	5500
20150707	farm4199702	5500
20150707	farm46715	1100
20150707	farm469428	5500
20150707	farm470372	1100
20150707	farm4836720	5500
20150707	farm505637	1100
20150707	farm505637	5500
20150707	farm5184249	5500
20150707	farm5184249	33000
20150707	farm5184249	110000
20150707	farm554557	5500
20150707	farm5878165	3300
20150707	farm5878165	5500
20150707	farm6082467	5500
20150707	farm6082467	33000
20150707	farm6906148	3300
20150707	farm7111368	3300
20150707	farm7111368	5500
20150707	farm7111368	33000
20150707	farm738634	3300
20150707	farm8186102	5500
20150707	farm8209244	5500
20150707	farm8373350	5500
20150707	farm9117290	5500
20150707	farm9117290	33000
20150707	farm9341688	3300
20150707	farm9341688	5500
20150707	farm9362612	3300
20150707	farm9370351	5500
20150707	farm9495333	5500
20150707	farm9499661	3300
20150707	farm9675565	3300
20150707	farm9675565	5500
20150707	farm9919231	5500
20150707	farm9935263	3300
20150707	farm9987566	3300
20150707	farm9987566	5500
20150707	farm9987566	5500
20150708	farm10191200	5500
20150708	farm10212627	5500
20150708	farm10373341	5500
20150708	farm10784327	1100
20150708	farm10784327	5500
20150708	farm10844866	3300
20150708	farm10844866	5500
20150708	farm10860315	1100
20150708	farm10870802	3300
20150708	farm10870802	33000
20150708	farm2494357	3300
20150708	farm4240157	66000
20150708	farm5467611	5500
20150708	farm6905186	3300
20150708	farm7039244	33000
20150708	farm7835371	5500
20150708	farm9324489	3300