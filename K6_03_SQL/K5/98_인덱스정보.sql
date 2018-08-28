-- exec spu_ItemPet 'farm27183138', '3260391k9c8t4i386611', 4,     32, -1
-- select * from dbo.tUserMaster where gameid = 'farm27183138'
-- farm27183138
-- - 클라이언트 인덱스번호를 int -> long확인
--  > 선물함 (1,439,535)
--  >   3 :   100만
--  >  30 :  1000만
--  > 300 : 10000만 1억
--  > 900 : 90000만 9억
--  > 30,0000,0000
--  > 21,4748,3647	()
--  >    1422,7753	(5.02 ~ 5.20일)
select MAX(idx) from dbo.tGiftList 					-- 14227753	> idx(bigint) seed(3억)
select MAX(idx) from dbo.tUserSaleLog 				-- 9881707	> 게임거래(입력, 참조는idx2번)	> 관리자페이지보기. 게임중에 사용은 안함. idx사용안하고 idx2로 대처
select MAX(idx) from dbo.tUserItemBuyLog 			-- 8165681	> 구매통계(입력,참조는idx2번)	> 관리자 페이지 보기. 구매정보
													--			  00_71구매로그시 직접사용(별문제는 없을듯)

--[새벽4시 작업 스케쥴]
--> 2주 선물받아간것 삭제 해주자. (tGiftList) 	> 하드2 > 하드3 이동후 삭제
--> 2주 거래로그 삭제 해주자. 	(tUserSaleLog) 	> 하드2 > 하드3 이동후 삭제
--> 2주 판매로그 삭제 해주자. 	(tUserSaleLog) 	> 하드2 > 하드3 이동후 삭제
--> 학교데이타중 1주일간 활동 없는 친구 강제 탈퇴
use GameMTBaseball
GO

select MAX(idx) from dbo.tUserItem 					-- 7181878	> 안전
select MAX(idx) from dbo.tUserGameMTBaseball 					-- 5973791	> 안전
select MAX(idx) from dbo.tUserPushAndroid 			-- 3412801
select MAX(idx) from dbo.tUserPushAndroidLog 		-- 2738055
select MAX(idx) from dbo.tUserSeed 					-- 2389656
select MAX(idx) from dbo.tComReward 				-- 2279987
select MAX(idx) from dbo.tRouletteLogPerson 		-- 2000564
select MAX(idx) from dbo.tDogamList 				-- 1343475
select MAX(idx) from dbo.tKakaoInvite 				-- 1246828
select MAX(idx) from dbo.tUserFriend 				-- 1015428
select MAX(idx) from dbo.tUserItemDel 				-- 1650708
select MAX(idx) from dbo.tUserPhone 				-- 194199
select MAX(idx) from dbo.tTutoStep 					-- 810835
select MAX(idx) from dbo.tUserAdLog 				-- 697409
select MAX(idx) from dbo.tUserItemDieLog			-- 570293
select MAX(idx) from dbo.tUserItemAliveLog			-- 379356
select MAX(idx) from dbo.tUserSaveLog 				-- 950669
select MAX(idx) from dbo.tUserMaster 				-- 199144
select MAX(idx) from dbo.tDogamListPet 				-- 223971
select MAX(idx) from dbo.tDogamReward 				-- 209055
select MAX(idx) from dbo.tEpiReward 				-- 141969
select MAX(idx) from dbo.tUserPushiPhone 			-- 298174
select MAX(idx) from dbo.tUserPushiPhoneLog 		-- 235157
select MAX(idx) from dbo.tKakaoHelpWait 			-- 240034
select MAX(idx) from dbo.tKakaoMaster 				-- 195151

select MAX(schoolidx) from dbo.tSchoolBank 			-- 77916
select MAX(idx) from dbo.tSchoolMaster 				-- 12233
select MAX(idx) from dbo.tSchoolUser 				-- 68793

select MAX(idx) from dbo.tSchoolBackMaster 			-- 20
select MAX(idx) from dbo.tSchoolBackUser 			-- 22

select MAX(idx) from dbo.tSchoolSchedule 			-- 16350
select MAX(idx) from dbo.tCashLog 					-- 19594
select MAX(checkidx) from dbo.tCashLogKakaoSend 	-- 19594
select MAX(idx) from dbo.tEventCertNo 				-- 25380
select MAX(idx) from dbo.tUserBoard 				-- 27620
select MAX(idx) from dbo.tUserUnusualLog2 			-- 13532
select MAX(idx) from dbo.tSysInquire 				-- 2065
select MAX(idx) from dbo.tAccRoulLogPerson 			-- 4977
select MAX(idx) from dbo.tUserUnusualLog 			-- 1175
select MAX(idx) from dbo.tUserItemBuyLogTotalSub 	-- 3609
select MAX(idx) from dbo.tAdminUser 				-- 6
select MAX(idx) from dbo.tCashChangeLog 			--
select MAX(idx) from dbo.tCashChangeLogTotal 		--
select MAX(idx) from dbo.tCashTotal 				-- 427
select MAX(idx) from dbo.tDayLogInfoStatic 			-- 170
select MAX(idx) from dbo.tEventCertNoBack 			-- 4684
select MAX(idx) from dbo.tItemInfo 					-- 970
select MAX(idx) from dbo.tKakaoMaster2 				-- 222
select MAX(idx) from dbo.tMessageAdmin 				-- 125
select MAX(idx) from dbo.tNotice 					-- 3
select MAX(idx) from dbo.tRouletteLogTotalMaster 	-- 29
select MAX(idx) from dbo.tRouletteLogTotalSub 		-- 625
select MAX(idx) from dbo.tStaticMaster 				-- 30
select MAX(idx) from dbo.tStaticSubFameLV 			-- 501
select MAX(idx) from dbo.tStaticSubMarket 			-- 150
select MAX(idx) from dbo.tStaticTime 				--
select MAX(idx) from dbo.tSystemInfo 				-- 5
select MAX(idx) from dbo.tSystemPack 				-- 5
select MAX(idx) from dbo.tSystemRoulette 			-- 91
select MAX(idx) from dbo.tUserBlockLog 				-- 18
select MAX(idx) from dbo.tUserBlockPhone 			-- 18
select MAX(idx) from dbo.tUserDeleteLog 			-- 3
select MAX(idx) from dbo.tUserItemBuyLogMonth 		-- 869
select MAX(idx) from dbo.tUserItemBuyLogTotalMaster -- 33
select MAX(idx) from dbo.tUserMasterSchedule 		-- 5
select MAX(idx) from dbo.tUserPay 					--
select MAX(idx) from dbo.tUserSaleRewardItemCode 	-- 85
select MAX(idx) from dbo.tStaticCashMaster			-- 22
select MAX(idx) from dbo.tStaticCashUnique			-- 314
select MAX(idx) from dbo.tUserPushSendInfo			-- 20
select MAX(idx) from dbo.tSysEventInfo				-- 16


