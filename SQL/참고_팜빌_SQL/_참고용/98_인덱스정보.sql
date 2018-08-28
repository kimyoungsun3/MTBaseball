-- exec spu_FVItemPet 'farm27183138', '3260391k9c8t4i386611', 4,     32, -1
-- select * from dbo.tFVUserMaster where gameid = 'farm27183138'
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
select MAX(idx) from dbo.tFVGiftList 					-- 14227753	> idx(bigint) seed(3억)
select MAX(idx) from dbo.tFVUserSaleLog 				-- 9881707	> 게임거래(입력, 참조는idx2번)	> 관리자페이지보기. 게임중에 사용은 안함. idx사용안하고 idx2로 대처
select MAX(idx) from dbo.tFVUserItemBuyLog 			-- 8165681	> 구매통계(입력,참조는idx2번)	> 관리자 페이지 보기. 구매정보
													--			  00_71구매로그시 직접사용(별문제는 없을듯)

--[새벽4시 작업 스케쥴]
--> 2주 선물받아간것 삭제 해주자. (tGiftList) 	> 하드2 > 하드3 이동후 삭제
--> 2주 거래로그 삭제 해주자. 	(tUserSaleLog) 	> 하드2 > 하드3 이동후 삭제
--> 2주 판매로그 삭제 해주자. 	(tUserSaleLog) 	> 하드2 > 하드3 이동후 삭제
--> 학교데이타중 1주일간 활동 없는 친구 강제 탈퇴
use Farm
GO

select MAX(idx) from dbo.tFVUserItem 					-- 7181878	> 안전
select MAX(idx) from dbo.tFVUserFarm 					-- 5973791	> 안전
select MAX(idx) from dbo.tFVUserPushAndroid 			-- 3412801
select MAX(idx) from dbo.tFVUserPushAndroidLog 		-- 2738055
select MAX(idx) from dbo.tFVUserSeed 					-- 2389656
select MAX(idx) from dbo.tFVComReward 				-- 2279987
select MAX(idx) from dbo.tFVRouletteLogPerson 		-- 2000564
select MAX(idx) from dbo.tFVDogamList 				-- 1343475
select MAX(idx) from dbo.tFVKakaoInvite 				-- 1246828
select MAX(idx) from dbo.tFVUserFriend 				-- 1015428
select MAX(idx) from dbo.tFVUserItemDel 				-- 1650708
select MAX(idx) from dbo.tFVUserPhone 				-- 194199
select MAX(idx) from dbo.tFVTutoStep 					-- 810835
select MAX(idx) from dbo.tFVUserAdLog 				-- 697409
select MAX(idx) from dbo.tFVUserItemDieLog			-- 570293
select MAX(idx) from dbo.tFVUserItemAliveLog			-- 379356
select MAX(idx) from dbo.tFVUserSaveLog 				-- 950669
select MAX(idx) from dbo.tFVUserMaster 				-- 199144
select MAX(idx) from dbo.tFVDogamListPet 				-- 223971
select MAX(idx) from dbo.tFVDogamReward 				-- 209055
select MAX(idx) from dbo.tFVEpiReward 				-- 141969
select MAX(idx) from dbo.tFVUserPushiPhone 			-- 298174
select MAX(idx) from dbo.tFVUserPushiPhoneLog 		-- 235157
select MAX(idx) from dbo.tFVKakaoHelpWait 			-- 240034
select MAX(idx) from dbo.tFVKakaoMaster 				-- 195151

select MAX(schoolidx) from dbo.tFVSchoolBank 			-- 77916
select MAX(idx) from dbo.tFVSchoolMaster 				-- 12233
select MAX(idx) from dbo.tFVSchoolUser 				-- 68793

select MAX(idx) from dbo.tFVSchoolBackMaster 			-- 20
select MAX(idx) from dbo.tFVSchoolBackUser 			-- 22

select MAX(idx) from dbo.tFVSchoolSchedule 			-- 16350
select MAX(idx) from dbo.tFVCashLog 					-- 19594
select MAX(checkidx) from dbo.tFVCashLogKakaoSend 	-- 19594
select MAX(idx) from dbo.tFVEventCertNo 				-- 25380
select MAX(idx) from dbo.tFVUserBoard 				-- 27620
select MAX(idx) from dbo.tFVUserUnusualLog2 			-- 13532
select MAX(idx) from dbo.tFVSysInquire 				-- 2065
select MAX(idx) from dbo.tFVAccRoulLogPerson 			-- 4977
select MAX(idx) from dbo.tFVUserUnusualLog 			-- 1175
select MAX(idx) from dbo.tFVUserItemBuyLogTotalSub 	-- 3609
select MAX(idx) from dbo.tFVAdminUser 				-- 6
select MAX(idx) from dbo.tFVCashChangeLog 			--
select MAX(idx) from dbo.tFVCashChangeLogTotal 		--
select MAX(idx) from dbo.tFVCashTotal 				-- 427
select MAX(idx) from dbo.tFVDayLogInfoStatic 			-- 170
select MAX(idx) from dbo.tFVEventCertNoBack 			-- 4684
select MAX(idx) from dbo.tFVItemInfo 					-- 970
select MAX(idx) from dbo.tFVKakaoMaster2 				-- 222
select MAX(idx) from dbo.tFVMessageAdmin 				-- 125
select MAX(idx) from dbo.tFVNotice 					-- 3
select MAX(idx) from dbo.tFVRouletteLogTotalMaster 	-- 29
select MAX(idx) from dbo.tFVRouletteLogTotalSub 		-- 625
select MAX(idx) from dbo.tFVStaticMaster 				-- 30
select MAX(idx) from dbo.tFVStaticSubFameLV 			-- 501
select MAX(idx) from dbo.tFVStaticSubMarket 			-- 150
select MAX(idx) from dbo.tFVStaticTime 				--
select MAX(idx) from dbo.tFVSystemInfo 				-- 5
select MAX(idx) from dbo.tFVSystemPack 				-- 5
select MAX(idx) from dbo.tFVSystemRoulette 			-- 91
select MAX(idx) from dbo.tFVUserBlockLog 				-- 18
select MAX(idx) from dbo.tFVUserBlockPhone 			-- 18
select MAX(idx) from dbo.tFVUserDeleteLog 			-- 3
select MAX(idx) from dbo.tFVUserItemBuyLogMonth 		-- 869
select MAX(idx) from dbo.tFVUserItemBuyLogTotalMaster -- 33
select MAX(idx) from dbo.tFVUserMasterSchedule 		-- 5
select MAX(idx) from dbo.tFVUserPay 					--
select MAX(idx) from dbo.tFVUserSaleRewardItemCode 	-- 85
select MAX(idx) from dbo.tFVStaticCashMaster			-- 22
select MAX(idx) from dbo.tFVStaticCashUnique			-- 314
select MAX(idx) from dbo.tFVUserPushSendInfo			-- 20
select MAX(idx) from dbo.tFVSysEventInfo				-- 16


