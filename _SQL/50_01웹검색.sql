﻿--@관리자 로그인(25)
--exec spu_GameMTBaseballD 25, 1, 1000, -1, -1, -1, -1, -1, -1, -1, 'global', 'qwer1234', '', '', '', '', '', '', '', ''			-- 관리자 생성
--exec spu_GameMTBaseballD 25, 1, 1000, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''			-- 관리자 생성
--exec spu_GameMTBaseballD 25, 1, 1000, -1, -1, -1, -1, -1, -1, -1, 'aidatakr', '12345', '', '', '', '', '', '', '', ''				-- 관리자 생성
--exec spu_GameMTBaseballD 25, 2, -1, -1, -1, -1, -1, -1, -1, -1,   'blackm', 'qwer1234', '', '', '', '', '', '', '', ''			-- 관리자 로그인
--exec spu_GameMTBaseballD 25, 3, 1000, -1, -1, -1, -1, -1, -1, -1, 'global', 'qwer1234', '', '', '', '', '', '', '', ''			-- 관리자 등급수정
--exec spu_GameMTBaseballD 25, 3, 1000, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'qwer1234', '', '', '', '', '', '', '', ''			-- 관리자 등급수정
--exec spu_GameMTBaseballD 25, 4, -1, -1, -1, -1, -1, -1, -1, -1,   'aaaaaa', 'bbbbbb', '', '', '', '', '', '', '', ''				-- 관리자 삭제
--exec spu_GameMTBaseballD 25, 200,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 관리자 액션정보리스트
--exec spu_GameMTBaseballD 25, 200,-1, -1, -1, -1, -1, -1, -1, -1, '', 'admin', '', '', '', '', '', '', '', ''						--

--@개발용아이템정보(5)
--exec spu_GameMTBaseballD 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--전체
--exec spu_GameMTBaseballD 5, 1,100, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--특정아이템
--exec spu_GameMTBaseballD 5, 1, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--카테고리
--exec spu_GameMTBaseballD 5, 1, -1, -1,  1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--서브카테고리

--@유저검색(7)
--exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''					-- 유저 리스트
--exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1,  2, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 유저 검색
--exec spu_GameMTBaseballD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''			-- 유저 폰검색

--캐쉬로그삭제
--exec spu_GameMTBaseballD 17, 1,  6, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 검색(단일) > 로그삭제, 차감
--exec spu_GameMTBaseballD 17, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx3', '', '', '', '', '', '', '', '', ''				-- 검색(일괄) > 로그삭제, 차감

--@유저삭제(18)
--exec spu_GameMTBaseballD 18, 1, -1, -1, -1, -1, -1, -1, -1, -1, 'mtxxxx3', '', '', '', '', '', '', '', '', ''				-- 유저삭제
--exec spu_GameMTBaseballD 18, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 유저 > 폰번검색 일괄삭제


--@유저세팅(19)
--exec spu_GameMTBaseballD 19, 1003, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동정보.
--exec spu_GameMTBaseballD 19, 1003, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		   검색.
--exec spu_GameMTBaseballD 19, 1005,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--         삭제.
--exec spu_GameMTBaseballD 19, 1006, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동2정보.
--exec spu_GameMTBaseballD 19, 1006, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동2정보.
--exec spu_GameMTBaseballD 19, 1006, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		    검색.
--exec spu_GameMTBaseballD 19, 41, -11, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 캐쉬 +/-
--exec spu_GameMTBaseballD 19,  65,  1,  1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 유저 레벨
--exec spu_GameMTBaseballD 19,  65,  2,  1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				--    경험치
--exec spu_GameMTBaseballD 19,2000,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 상태값 변경.
--exec spu_GameMTBaseballD 19,2000, 10, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 싱글플레이상태.
--exec spu_GameMTBaseballD 19,2000, 20, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 캐쉬카피 클리어.
--exec spu_GameMTBaseballD 19,2000, 21, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 결과카피 클리어.
--exec spu_GameMTBaseballD 19,2000, 22, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 블럭처리/해제, 기록남김
--exec spu_GameMTBaseballD 19,2000, 23, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 블럭처리(일괄핸드폰 > 관련계정모두)
--exec spu_GameMTBaseballD 19,2000, 24, -1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '192.168.0.1', '', '', '', '', '', '', ''	-- 블럭해제
--exec spu_GameMTBaseballD 19,1110, -1, -1, -1, -1,  1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					-- 판매,합성,분해된리스트.
--exec spu_GameMTBaseballD 19, 71,  7,  6, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				-- 소모템 개수변경(공포탄 5 -> 6)
--exec spu_GameMTBaseballD 19, 31, 12, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					-- 유저보유템 삭제



--exec spu_GameMTBaseballD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 블럭리스트
--exec spu_GameMTBaseballD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', '', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 19, 1007,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          삭제.
--exec spu_GameMTBaseballD 19, 1008, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 경쟁모드(퀘스트정보).
--exec spu_GameMTBaseballD 19, 1004,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 쿠폰리스트.
--exec spu_GameMTBaseballD 19, 1004,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '25026F896F274D9A'		-- 쿠폰리스트.
--exec spu_GameMTBaseballD 19, 1004,  3, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', '25026F896F274D9A'-- 사용하기.
--exec spu_GameMTBaseballD 19, 10, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', 'admin', '', '', '', '', '', '', '', ''				-- 삭제처리, 기록남김
--exec spu_GameMTBaseballD 19, 1002, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 삭제리스트
--exec spu_GameMTBaseballD 19, 1002, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', '', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 19, 13,6, -1, -1, -1, -1, -1, -1, -1, 'dd23', 'admin', '192.168.0.1', '', '', '', '', '', '', ''		-- 삭제해제
--exec spu_GameMTBaseballD 19, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 블럭폰리스트
--exec spu_GameMTBaseballD 19, 22, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', 'msg'			-- 블럭폰등록
--exec spu_GameMTBaseballD 19, 23, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', ''			-- 블럭폰삭제
--exec spu_GameMTBaseballD 19, 65,  5,  1, -1, -1, -1, -1, -1, -1, 'xxxx', 'admin', '', '', '', '', '', '', '', ''				--      레벨
--exec spu_GameMTBaseballD 19, 98,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저통계마스터.
--exec spu_GameMTBaseballD 19, 98,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '20140404', '', '', '', '', '', '', ''				--         레벨분포, 레벨통신사.
--exec spu_GameMTBaseballD 19, 98,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '201404', '', '', '', '', '', '', ''					--         레벨분포.
--exec spu_GameMTBaseballD 19, 98,  4, -1, -1, -1, -1, -1, -1, -1, '', '', '201404', '', '', '', '', '', '', ''					--         레벨통신사.
--exec spu_GameMTBaseballD 19, 300,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유니크 가입폰리스트
--exec spu_GameMTBaseballD 19, 300,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '01011112223', '', '', '', '', '', '', ''			--
--exec spu_GameMTBaseballD 19, 400,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 구매리스트
--exec spu_GameMTBaseballD 19, 400,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 19, 401,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 월토탈 통계
--exec spu_GameMTBaseballD 19, 401,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130909', '', '', '', '', '', '', '', ''				--
--exec spu_GameMTBaseballD 19, 402,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130909', '', '', '', '', '', '', '', ''				-- 유저 월서브 통계
--exec spu_GameMTBaseballD 19, 403,-1, -1, -1, -1, -1, -1, -1, -1, '', '201309', '', '', '', '', '', '', '', ''					-- 유저 월아이템 통계
--exec spu_GameMTBaseballD 19, 404,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 뽑기 광고리스트


--@공지사항작성(20)
--exec spu_GameMTBaseballD 20, 21, 1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 문의글 읽기.
--exec spu_GameMTBaseballD 20, 21, 1,  1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''		--        계정.
--exec spu_GameMTBaseballD 20, 21, 1,  1,  1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			--		  상태.
--exec spu_GameMTBaseballD 20, 21, 2,  1, 20,  2,  1, -1, -1, -1, '', 'adminid', '', '', '', '', '', '', '', ''		--      상태변경, 코멘트추가(유저에게 쪽지발송가능).
--exec spu_GameMTBaseballD 20, 21, 2,  1, 20,  2,  1, -1, -1, -1, '', 'adminid', '', '', '', '', '', '', '', ''		--      상태변경, 코멘트추가(유저에게 쪽지발송가능).

--exec spu_GameMTBaseballD 20, 22, 1,  1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''		-- PC방 정보 읽기.
--exec spu_GameMTBaseballD 20, 22, 1,  1,  1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			--
--exec spu_GameMTBaseballD 20, 22, 2,  1, -1, -1, -1, -1, -1, -1, 'xxxx', 'adminid', '127.0.0.1', '', '', '', '', '', '', ''--      등록.
--exec spu_GameMTBaseballD 20, 22, 2,  2,  1, -1, -1, -1, -1, -1, 'xxxx', 'adminid', '127.0.0.1', '', '', '', '', '', '', ''--      수정.
--exec spu_GameMTBaseballD 20, 22, 2,  3,  1, -1, -1, -1, -1, -1, 'xxxx', 'adminid', '127.0.0.1', '', '', '', '', '', '', ''--      삭제.


--@통계자료(21)
--exec spu_GameMTBaseballD 21, 1, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 일별통계
--exec spu_GameMTBaseballD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매로그
--exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_GameMTBaseballD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, 'farm58', '', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', 'TX_00000000150356', '', '', '', '', '', '', ''		--
--exec spu_GameMTBaseballD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매통계
--exec spu_GameMTBaseballD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '20140409', '', '', '', '', '', '', '', ''				--
--exec spu_GameMTBaseballD 21, 13,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_GameMTBaseballD 21, 13,-1, -1, -1, -1, -1, -1, -1, -1, '', '201404', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 21, 14,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬유니크통계
--exec spu_GameMTBaseballD 21, 14,-1, -1, -1, -1, -1, -1, -1, -1, '', '20140408', '', '', '', '', '', '', '', ''				--
--exec spu_GameMTBaseballD 21, 14,-1, -1, -1, -1, -1, -1, -1, -1, '', '20140501', '', '', '', '', '', '', '', ''				--
--exec spu_GameMTBaseballD 21, 21,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저환전로그
--exec spu_GameMTBaseballD 21, 21,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''					--
--exec spu_GameMTBaseballD 21, 23,   3300, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566741', '', '', '', '', '', '', '' -- 캐쉬구매처리.
--exec spu_GameMTBaseballD 21, 23,   5500, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566742', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 21, 23,  11000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566743', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 21, 23,  33000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566744', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 21, 23,  55000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566745', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 21, 23, 110000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566746', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 21, 31,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저판매현재랭킹.
--exec spu_GameMTBaseballD 21, 32,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저배틀현재랭킹.
--exec spu_GameMTBaseballD 21, 33,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저판매지난랭킹.
--exec spu_GameMTBaseballD 21, 34,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '20160405', '', '', '', '', '', '', ''						--
--exec spu_GameMTBaseballD 21, 35,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저배틀지난랭킹.
--exec spu_GameMTBaseballD 21, 36,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '20160405', '', '', '', '', '', '', ''						--

-- @선물(27)
--exec spu_GameMTBaseballD 27, 1,  -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물 가능한 리스트(선물하기위해서)
--exec spu_GameMTBaseballD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx', '', '', '', '', '', '', '', ''						-- 선물 받은 리스트( 전체, 개인)
--exec spu_GameMTBaseballD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx2', '액세서리뽑기', '', '', '', '', '', '', ''				--
--exec spu_GameMTBaseballD 27, 11,  1, -1, -1, -1, -1, -1, -1, -1, 'adminid', 'xxxx', '', '', '', '', '', '', '', ''				-- 선물하기
--exec spu_GameMTBaseballD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'adminid', 'xxxx', '메세지내용', '', '', '', '', '', '', ''			-- 메세지보내기
--exec spu_GameMTBaseballD 27, 21, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물, 메세지 삭제
--exec spu_GameMTBaseballD 27, 22, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '',''							-- 선물, 메세지 원복
--exec spu_GameMTBaseballD 27, 23, -1, 81, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--              삭제
--exec spu_GameMTBaseballD 27, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 룰렛 리스트

-- 게임정보 자동세팅(30)
--exec spu_GameMTBaseballD 30, 1, 10, 20, 900, 5111, 5112, 5113, 5007, -1, '', '', '', '', '', '', '', '', '', '반영내용'				-- 시스템 정보 업그레이드(업글, 할인, 출석)
--exec spu_GameMTBaseballD 30, 2, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 시스템 정보 리스트
--exec spu_GameMTBaseballD 30, 3,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '수정내용'						-- 시스템 멘트만수정
--exec spu_GameMTBaseballD 30, 4,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 복귀세팅
--exec spu_GameMTBaseballD 30, 5, -1, -1, -1, -1, -1, -1, -1, -1, '1,2,3,4,5,6,7', '2013-01-01', '2024-01-01', '산양', '양', '젖소', '', '', '1:1;2:213;3:112;4:14;5:5017;6:5010;7:5009;10:1;11:12;12:18;13:23;20:1;21:10;22:100;', '' -- 뽑기동물기능 입력
--exec spu_GameMTBaseballD 30, 6,  1, -1, -1, -1, -1, -1, -1, -1, '8,2,3,4,5,6,7', '2013-01-08', '2024-01-08', '산양2', '양2', '젖소2', '', '', '1:-1;2:213;3:112;4:14;5:5017;6:5010;7:5009;10:1;11:12;12:18;13:23;20:1;21:10;22:100;', '코멘트수정' -- 루비
--exec spu_GameMTBaseballD 30, 7, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 8, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 9, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 10, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 1, 10, 20, 900, 5111, 5112, 5113, 5007, -1, '', '', '', '', '', '', '', '', '', '반영내용'				-- 시스템 정보 업그레이드(업글, 할인, 출석)
--exec spu_GameMTBaseballD 30, 2, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 시스템 정보 리스트
--exec spu_GameMTBaseballD 30, 3,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '수정내용'					-- 시스템 멘트만수정

--exec spu_GameMTBaseballD 30, 11, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 패키지상품(아이템리스트, 템리스트).
--exec spu_GameMTBaseballD 30, 12, -1,  1, 50, 69, 10,  1, -1, -1, '소A등급 패키지','내용', '1:1;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 13,  1,  1, 50, 69, 10,  1, -1, -1, '소A등급 패키지','내용', '1:1;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 21,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품(아이템리스트, 템리스트) 활성.
--exec spu_GameMTBaseballD 30, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--                                    비활성.
--exec spu_GameMTBaseballD 30, 22, -1,  1, 50, 69, 10,  1, 1000, 300, '소A등급 교배뽑기','내용', '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 23,  1,  1, 50, 69, 10,  1, 1000, 300, '소A등급 교배뽑기','내용', '1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:1;17:2;18:3;19:4;20:5', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 25,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품(아이템리스트, 템리스트) 활성.
--exec spu_GameMTBaseballD 30, 25, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--                                    비활성.
--exec spu_GameMTBaseballD 30, 26, -1,  1, '10', '0', '0', '1', '0', '0', '1~10뽑기 (2차버젼)', '1~10뽑기 (2차버젼)', '1:120010;2:120010;3:120010;4:120010;5:120010;6:120290;7:120010;8:120020;9:120010;10:120070;11:120010;12:120010;13:120160;14:120010;15:120010;16:120010;17:120010;18:120010;19:120010;20:120010;21:120280;22:120010;23:120010;24:120010;25:120010;26:120010;27:120010;28:120010;29:120010;30:120010;31:120010;32:120010;33:120010;34:120010;35:120500;36:120510;37:120010;38:120010;39:120010;40:120540;41:120010;42:120010;43:120010;44:120120;45:120010;46:120280;47:120010;48:120010;49:120010;50:120010;', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 27,  1,  1, '10', '0', '0', '1', '0', '0', '1~10뽑기 (2차버젼)', '1~10뽑기 (2차버젼)', '1:120010;2:120010;3:120010;4:120010;5:120010;6:120290;7:120010;8:120020;9:120010;10:120070;11:120010;12:120010;13:120160;14:120010;15:120010;16:120010;17:120010;18:120010;19:120010;20:120010;21:120280;22:120010;23:120010;24:120010;25:120010;26:120010;27:120010;28:120010;29:120010;30:120010;31:120010;32:120010;33:120010;34:120010;35:120500;36:120510;37:120010;38:120010;39:120010;40:120540;41:120010;42:120010;43:120010;44:120120;45:120010;46:120280;47:120010;48:120010;49:120010;50:120010;', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 41, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 교배뽑기상품Fresh(아이템리스트, 템리스트).
--exec spu_GameMTBaseballD 30, 42, -1,  1, 50, 69, 10,  1, 1000, 300, '소A등급 교배뽑기','내용', '1:10;2:12;3:11;4:13;5:15;6:20;7:20;8:30;', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 43,  1,  1, 50, 69, 10,  1, 1000, 300, '소A2등급 교배뽑기','내용', '1:11;2:12;3:11;4:13;5:15;6:20;7:20;8:30;', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 45, -1,  1, 10, -1, 10,  1, -1, -1, '행운의 상자 1', '1', '1:1026:4:1:500;2:813:5:2:1000;3:1004:7:4:1500;4:2000:9:6:3500;5:2103:10:10:7000;6:1205:11:15:20000;', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 46, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 47,  1,  1, 60, -1, 10,  1, -1, -1, '행운의 상자 1', '1', '1:1026:4:1:500;2:813:5:2:1000;3:1004:7:4:1500;4:2000:9:6:3500;5:2103:10:10:7000;6:1205:11:15:20000;', '1,2,3,4,5,6,7', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''																				-- Push 카운터(안드로이드와 아이폰은 내부에서 판단함).
--exec spu_GameMTBaseballD 30, 32,  1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''							-- Push 개별.
--exec spu_GameMTBaseballD 30, 32,  3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_GameMTBaseballD 30, 32000, 1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''							-- Push 리턴값이 없음.
--exec spu_GameMTBaseballD 30, 32000, 3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_GameMTBaseballD 30, 33,  1,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''								-- Push 전체.
--exec spu_GameMTBaseballD 30, 33,  3,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_GameMTBaseballD 30, 34,  1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '', '', '', '', '', '', '', ''																	-- Push 삭제.
--exec spu_GameMTBaseballD 30, 35,  1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '', '', '', '', '', '', '', ''																	-- Push 삭제.
--exec spu_GameMTBaseballD 30, 36, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '', '', '', '', '', '', '', ''																	-- Push 삭제.

--exec spu_GameMTBaseballD 30, 50, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''		--0 시간제 이벤트 정보.
--exec spu_GameMTBaseballD 30, 51, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''		--0 마스터 활성화.
--exec spu_GameMTBaseballD 30, 52,  1, -1,3000, 50, -1, -1, -1, -1, '','', '보낸이름', '1', '12', '17', '', '', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!'	-- 입력.
--exec spu_GameMTBaseballD 30, 52,  2,  1,3001, 51, -1, -1, -1, -1, '','', '보낸이름', '1', '18', '24', '', '', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!' -- 수정
--exec spu_GameMTBaseballD 30, 52,  3,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 상태수정
--exec spu_GameMTBaseballD 30, 52,  4,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 푸쉬수정
--exec spu_GameMTBaseballD 30, 52,  5,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 일일보상 삭제
--exec spu_GameMTBaseballD 30, 53, -1, -1, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''		-- 상품받아가는 사람
--exec spu_GameMTBaseballD 30, 53, -1, -1, -1,-1, -1, -1, -1, -1, 'xxxx2','', '', '', '', '', '', '', '', ''		--

--exec spu_GameMTBaseballD 30, 60, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''			-- 목장배틀
--exec spu_GameMTBaseballD 30, 61, 6903, -1, -1, -1, -1, -1, -1, -1, '', '', '1:0;2:1;3:4;4:4;5:3;6:0;', '', '', '', '', '', '', ''

--exec spu_GameMTBaseballD 30, 80, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 80,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''
--exec spu_GameMTBaseballD 30, 81, -1, -1, -1, -1, -1, -1, -1, -1, '문화 상품권', 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/gift_card.png', '', '간략설명', '상세설명', '2016-05-25', '2016-05-31', '',    '1:1;2:-1;3:-1;4:15;5:50;6:0;7:1;8:10;', ''
--exec spu_GameMTBaseballD 30, 82,  5, -1, -1, -1, -1, -1, -1, -1, '문화 상품권2', 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/gift_card.png', '', '간략설명2', '상세설명2', '2016-05-25', '2016-05-31', '', '1:1;2:-1;3:-1;4:15;5:50;6:0;7:1;8:10;', ''


use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GameMTBaseballD', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GameMTBaseballD;
GO

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_GameMTBaseballD
	@p1_			int,
	@p2_			int,
	@p3_			int,
	@p4_			int,
	@p5_			int,
	@p6_			int,
	@p7_			int,
	@p8_			int,
	@p9_			int,
	@p10_			bigint,
	@ps1_			varchar(1024),
	@ps2_			varchar(1024),
	@ps3_			varchar(1024),
	@ps4_			varchar(1024),
	@ps5_			varchar(1024),
	@ps6_			varchar(1024),
	@ps7_			varchar(1024),
	@ps8_			varchar(1024),
	@ps9_			varchar(1024),
	@ps10_			varchar(4096)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13	--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50	-- 아이템코드못
	declare @RESULT_ERROR_DOUBLE_IP				int				set @RESULT_ERROR_DOUBLE_IP				= -201	-- IP중복...찾음

	------------------------------------------------
	--	프로시져 종류
	------------------------------------------------
	declare @KIND_ADMIN_LOGIN					int				set @KIND_ADMIN_LOGIN					= 25
	declare @KIND_NOTICE_SETTING				int				set @KIND_NOTICE_SETTING				= 20
	declare @KIND_SEARCH_ITEMINFO				int				set @KIND_SEARCH_ITEMINFO				= 5
	declare @KIND_USER_SETTING					int				set @KIND_USER_SETTING					= 19
	declare @KIND_STATISTICS_INFO				int				set @KIND_STATISTICS_INFO				= 21
	declare @KIND_USER_SEARCH					int				set @KIND_USER_SEARCH					= 7
	declare @KIND_USER_DELETEID					int				set @KIND_USER_DELETEID					= 18
	declare @KIND_USER_GIFT						int				set @KIND_USER_GIFT						= 27

	declare @KIND_SYSTEMINFO_SETTING			int				set @KIND_SYSTEMINFO_SETTING			= 30
	declare @KIND_USER_CASH_LOG_DELETE			int				set @KIND_USER_CASH_LOG_DELETE			= 17
	declare @KIND_USER_BLOCK_LOG				int				set @KIND_USER_BLOCK_LOG				= 2
	declare @KIND_USER_BLOCK_RELEASE			int				set @KIND_USER_BLOCK_RELEASE			= 8
	declare @KIND_USER_DELETE_LOG				int				set @KIND_USER_DELETE_LOG				= 10
	declare @KIND_USER_UNUSUAL_LOG				int				set @KIND_USER_UNUSUAL_LOG				= 4
	declare @KIND_ITEM_BUY_LOG					int				set @KIND_ITEM_BUY_LOG					= 6
	declare @KIND_USER_ITEM_UPGRADE				int				set @KIND_USER_ITEM_UPGRADE 			= 9
	declare @KIND_USER_CASH_CHANGE				int				set @KIND_USER_CASH_CHANGE				= 12
	declare @KIND_USER_CASH_BUY					int				set @KIND_USER_CASH_BUY					= 13
	declare @KIND_USER_CASH_PLUS				int				set @KIND_USER_CASH_PLUS				= 16
	declare @KIND_USER_CASH_MINUS				int				set @KIND_USER_CASH_MINUS				= 23
	declare @KIND_NEWINFO_LIST					int				set @KIND_NEWINFO_LIST					= 26

	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 체킹
	declare @INFOMATION_NO						int					set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int					set @INFOMATION_YES					=  1

	-- 선물 관련 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 10	-- 한폰당 생성할 수 있는 아이디개수.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.


	declare @PAGE_CASH_LIST						int					set @PAGE_CASH_LIST							= 25
	declare @LV_MAX								int					set @LV_MAX									= 650
	------------------------------------------------
	--	일반변수선언
	------------------------------------------------
	declare @kind			int				set @kind			= @p1_
	declare @subkind		int				set @subkind		= @p2_
	declare @idx 			int				set @idx 			= @p3_
	declare @itemcode		int				set @itemcode		= @p4_
	declare @itemkind		int				set @itemcode		= @p5_
	declare @idx2 			int

	declare @gameid			varchar(20)		set @gameid			= @ps1_
	declare @adminid		varchar(1024)	set @adminid 		= @ps2_
	declare @adminip		varchar(1024)	set @adminip 		= @ps3_
	declare @message		varchar(2048)	set @message		= @ps10_
	declare @phone			varchar(20)
	declare @password		varchar(20)
	declare @level			int
	declare @exp			int
	declare @commission		int

	declare @comment		varchar(2048)
	declare @cashcost 		int
	declare @gamecost 		int
	declare @comment4		varchar(4096)

	declare @dateid 		varchar(8)
	declare @dateid6 		varchar(6)		set @dateid6 		= Convert(varchar(6),Getdate(),112)
	declare @dateid8 		varchar(8)
	declare @dateid10 		varchar(10) 	set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid16 		varchar(16) 	set @dateid16 		= Convert(varchar(16), Getdate(),120)
	declare @dateid19 		varchar(19) 	set @dateid19 		= Convert(varchar(19), Getdate(),120)

	declare @syscheck		int
	declare @version		int
	declare @iteminfover	int
	declare @iteminfourl	varchar(512)

	declare @recepushid		varchar(1024)
	declare @maxPage		int				set @maxPage = 1
	declare @idxPage		int				set @idxPage = 1
	declare @fresh			int
	declare @cnt			int
	declare @cnt2			int
	declare @cnt3			int
	declare @cnt4			int
	declare @grade			int
	declare @category		int
	declare @subcategory	int

	declare @nResult		int				set @nResult = @RESULT_SUCCESS
	declare @str			varchar(40)
	declare @str2			varchar(40)
	declare @val			int
	declare @val2			int
	declare @cash			int

	declare @pack1			int		set @pack1 		= -1
	declare @pack2			int		set @pack2 		= -1
	declare @pack3			int		set @pack3 		= -1
	declare @pack4			int		set @pack4 		= -1
	declare @pack5			int		set @pack5 		= -1
	declare @pack6			int		set @pack6 		= -1
	declare @pack7			int		set @pack7 		= -1
	declare @pack8			int		set @pack8 		= -1
	declare @pack9			int		set @pack9 		= -1
	declare @pack10			int		set @pack10		= -1
	declare @pack11			int		set @pack11 	= -1
	declare @pack12			int		set @pack12 	= -1
	declare @pack13			int		set @pack13 	= -1
	declare @pack14			int		set @pack14 	= -1
	declare @pack15			int		set @pack15 	= -1
	declare @pack16			int		set @pack16 	= -1
	declare @pack17			int		set @pack17 	= -1
	declare @pack18			int		set @pack18 	= -1
	declare @pack19			int		set @pack19 	= -1
	declare @pack20			int		set @pack20		= -1
	declare @pack21			int		set @pack21 	= -1
	declare @pack22			int		set @pack22 	= -1
	declare @pack23			int		set @pack23 	= -1
	declare @pack24			int		set @pack24 	= -1
	declare @pack25			int		set @pack25 	= -1
	declare @pack26			int		set @pack26 	= -1
	declare @pack27			int		set @pack27 	= -1
	declare @pack28			int		set @pack28 	= -1
	declare @pack29			int		set @pack29 	= -1
	declare @pack30			int		set @pack30		= -1
	declare @pack31			int		set @pack31 	= -1
	declare @pack32			int		set @pack32 	= -1
	declare @pack33			int		set @pack33 	= -1
	declare @pack34			int		set @pack34 	= -1
	declare @pack35			int		set @pack35 	= -1
	declare @pack36			int		set @pack36 	= -1
	declare @pack37			int		set @pack37 	= -1
	declare @pack38			int		set @pack38 	= -1
	declare @pack39			int		set @pack39 	= -1
	declare @pack40			int		set @pack40		= -1
	declare @pack41			int		set @pack41 	= -1
	declare @pack42			int		set @pack42 	= -1
	declare @pack43			int		set @pack43 	= -1
	declare @pack44			int		set @pack44 	= -1
	declare @pack45			int		set @pack45 	= -1
	declare @pack46			int		set @pack46 	= -1
	declare @pack47			int		set @pack47 	= -1
	declare @pack48			int		set @pack48 	= -1
	declare @pack49			int		set @pack49 	= -1
	declare @pack50			int		set @pack50		= -1

	declare @groupstep1	int		set @groupstep1 	= -1
	declare @groupstep2	int		set @groupstep2 	= -1
	declare @groupstep3	int		set @groupstep3 	= -1
	declare @groupstep4	int		set @groupstep4 	= -1
	declare @groupstep5	int		set @groupstep5 	= -1
	declare @groupstep6	int		set @groupstep6 	= -1
	declare @groupstep7	int		set @groupstep7 	= -1
	declare @groupstep8	int		set @groupstep8 	= -1

	declare @packkind 		int,
			@packvalue 		int
	declare @famelv			int,
			@fame			int
	declare @total			int	set @total 			= 0
	declare @point			int	set @point 			= 0

	-- 유저문의.
	declare @PAGE_LINE10	int						set @PAGE_LINE10	= 10
	declare @PAGE_LINE20	int						set @PAGE_LINE20	= 20
	declare @PAGE_LINE50	int						set @PAGE_LINE50	= 50
	declare @PAGE_LINE		int						set @PAGE_LINE		= 100
	declare @page			int						set @page			= 1

	-- 쿠폰정보.
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1
	declare @certno			varchar(16)				set @certno			= ''

	-- 관리자 과금입력.
	declare @acode			varchar(256)
	declare @ucode			varchar(256)
	declare @ikind			varchar(256)
	declare @cashkind		int

	-- 이벤트처리.
	declare @curdate		datetime				set @curdate		= getdate()
	declare @state			int
	declare @company		int
	declare @startdate		varchar(16)
	declare @enddate		varchar(16)
	declare @title			varchar(256)
	declare @eventspot06	int
	declare @eventsender	varchar(20)
	declare @eventpushtitle	varchar(256)
	declare @eventpushmsg	varchar(256)
	declare @eventstatedaily	int
	declare @eventcnt		int
	declare @eventday		int
	declare @eventstarthour	int
	declare @eventendhour	int


Begin
	------------------------------------------------
	--	초기화
	------------------------------------------------
	set nocount on

	-----------------------------------------------------
	--	관리자 로그인
	-----------------------------------------------------
	if(@kind = @KIND_ADMIN_LOGIN)
		begin
			set @subkind = @p2_
			if(@subkind	= 1)
				begin
					if(not exists(select * from dbo.tAdminUser where gameid = @ps1_))
						begin
							if(@p3_ = -1)
								begin
									set @p3_ = 0
								end
							insert into tAdminUser(gameid, password, grade) values(@ps1_, @ps2_, @p3_)
							select 1 'rtn'
						end
					else
						begin
							select -1 'rtn'
						end
				end
			else if(@subkind = 2)
				begin
					set @grade = -1
					select @grade = grade from dbo.tAdminUser where gameid = @ps1_ and password = @ps2_
					if(@grade != -1)
						begin
							select 1 'rtn', @grade grade, '입력'
						end
					else
						begin
							select -1 'rtn', 0 grade, '입력'
						end
				end
			else if(@subkind = 3)
				begin
					set @grade = -1
					select @grade = grade from dbo.tAdminUser where gameid = @ps1_
					if(@grade != -1)
						begin
							update dbo.tAdminUser
								set
									password 	= @ps2_,
									grade 		= @p3_
							where gameid = @ps1_

							select 1 'rtn', @grade grade, '(루비)'
						end
					else
						begin
							select -1 'rtn', 0 grade, '(루비)'
						end
				end
			else if(@subkind = 4)
				begin
					delete from dbo.tAdminUser where gameid = @ps1_ and password = @ps2_
					select 1 'rtn', 0, '(삭제)'
				end
			else if(@subkind = 200)
				begin
					-----------------------------------
					-- 관리자 행동정보
					-----------------------------------
					if(isnull(@ps2_, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tMessageAdmin

							set @maxPage	= @idx / @PAGE_LINE50
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE50 != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE50

							select top 50 @maxPage maxPage, @page page, * from dbo.tMessageAdmin
							where idx <= @idx order by idx desc
							--select top 100 * from dbo.tMessageAdmin order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1
							select top 100 @maxPage maxPage, @page page, * from dbo.tMessageAdmin where adminid = @ps2_ order by idx desc
						end
				end
		end

	-----------------------------------------------------
	--	아이템정보
	-----------------------------------------------------
	else if(@kind in (@KIND_SEARCH_ITEMINFO))
		begin
			set @subkind 	= @p2_
			set @itemcode	= @p3_
			set @category	= @p4_
			set @subcategory= @p5_
			if(@subkind	= 1)
				begin
					if(@itemcode != -1)
						begin
							select * from dbo.tItemInfo where itemcode = @itemcode order by itemcode asc
						end
					else if(@category != -1)
						begin
							select * from dbo.tItemInfo where category = @category
						end
					else if(@subcategory != -1)
						begin
							select * from dbo.tItemInfo where subcategory = @subcategory
						end
					else
						begin
							select * from dbo.tItemInfo order by itemcode asc
						end
				end
		end
	------------------------------------------------
	--	각상태분기
	------------------------------------------------
	else if(@kind = @KIND_NOTICE_SETTING)
		begin
			set @subkind 	= @p2_
			set @idx		= @p3_
			set @version	= @p6_
			set @syscheck	= @p7_
			set @iteminfover= @p8_
			set @iteminfourl= @ps9_
			set @comment4	= @ps10_

			if(@subkind = 21)
				begin
					if(@p3_ = 1)
						begin
							if(@p5_ != -1)
								begin
									set @maxPage	= 1
									set @page		= 1

									select top 100 @maxPage maxPage, @page page, * from dbo.tSysInquire
									where state = @p5_ order by idx desc
								end
							else if(@ps1_ != '')
								begin
									set @maxPage	= 1
									set @page		= 1

									select top 100 @maxPage maxPage, @page page, * from dbo.tSysInquire
									where gameid = @ps1_ order by idx desc
								end
							else
								begin
									-- 읽기.
									set @idxPage	= @p4_
									select @idx = (isnull(max(idx), 1)) from dbo.tSysInquire

									set @maxPage	= @idx / @PAGE_LINE
									set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
									set @page		= case
														when (@idxPage <= 0)			then 1
														when (@idxPage >  @maxPage)	then @maxPage
														else @idxPage
													end
									set @idx		= @idx - (@page - 1) * @PAGE_LINE

									select top 100 @maxPage maxPage, @page page, * from dbo.tSysInquire
									where idx <= @idx order by idx desc
								end
						end
					else if(@p3_ = 2)
						begin
							-- 처리.
							select @gameid = gameid from dbo.tSysInquire where idx = @p5_

							if(@ps3_ = '')
								begin
									-- 내용은 없고 상태만 변경할 경우.
									update dbo.tSysInquire
										set
											state 		= @p6_,
											adminid		= @ps2_,
											dealdate 	= getdate()
									where idx = @p5_
								end
							else
								begin
									update dbo.tSysInquire
										set
											state 		= @p6_,
											comment2 	= comment2
														  +
														  case
																when @ps3_ != '' then @ps3_
																else				  ''
														  end
														  +
														  + '(' + @ps2_ + ':' + @dateid16 + ')'
														  +
														  case
																when @p6_ = 0 then '(문의중)'
																when @p6_ = 1 then '(확인중)'
																when @p6_ = 2 then '(처리완료)'
																else               '(모름)'
														  end
														  ,
											adminid		= @ps2_,
											dealdate 	= getdate()
									where idx = @p5_

									-- 처리완료 > 쪽지로 발송
									if(@p7_ = 1)
										begin

											if(@ps3_ != '')
												begin
													Exec spu_SubGiftSendNew 1, -1, 0, @ps2_, @gameid, @ps3_
												end
											else if(@p6_ = 1)
												begin
													Exec spu_SubGiftSendNew 1, -1, 0, @ps2_, @gameid, '확인중에 있습니다.'
												end
											else if(@p6_ = 2)
												begin
													Exec spu_SubGiftSendNew 1, -1, 0, @ps2_, @gameid, '처리완료했습니다.'
												end
										end
								end
							select @RESULT_SUCCESS 'rtn'
						end
				end

			else if(@subkind = 22)
				begin
					if(@p3_ = 1)
						begin
							if(@ps1_ != '')
								begin
									set @maxPage	= 1
									set @page		= 1

									select top 100 @maxPage maxPage, @page page, * from dbo.tPCRoomIP
									where gameid = @ps1_ order by idx desc
								end
							else
								begin
									-- 읽기.
									set @idxPage	= @p4_
									select @idx = (isnull(max(idx), 1)) from dbo.tPCRoomIP

									set @maxPage	= @idx / @PAGE_LINE
									set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
									set @page		= case
														when (@idxPage <= 0)			then 1
														when (@idxPage >  @maxPage)	then @maxPage
														else @idxPage
													end
									set @idx		= @idx - (@page - 1) * @PAGE_LINE

									select top 100 @maxPage maxPage, @page page, * from dbo.tPCRoomIP
									where idx <= @idx order by idx desc
								end
						end
					else if(@p3_ = 2)
						begin
							-- 입력.
							if(@p4_ = 1)
								begin
									if(not exists(select top 1   * from dbo.tUserMaster where gameid = @ps1_))
										begin
											select @RESULT_ERROR_NOT_FOUND_GAMEID 'rtn'
										end
									else if(exists(select top 1   * from dbo.tPCRoomIP where gameid = @ps1_ and pcip = @ps3_))
										begin
											select @RESULT_ERROR_DOUBLE_IP 'rtn'
										end
									else
										begin
											--  유저 존재 -> 등록안된 ip
											insert into dbo.tPCRoomIP(gameid,  pcip, adminid)
											values(					   @ps1_, @ps3_,   @ps2_)

											select @RESULT_SUCCESS 'rtn'
										end
								end
							else if(@p4_ = 2)
								begin

									if(not exists(select top 1   * from dbo.tUserMaster where gameid = @ps1_))
										begin
											select @RESULT_ERROR_NOT_FOUND_GAMEID 'rtn'
										end
									else if(exists(select top 1   * from dbo.tPCRoomIP where gameid = @ps1_ and pcip = @ps3_))
										begin
											select @RESULT_ERROR_DOUBLE_IP 'rtn'
										end
									else
										begin
											--  유저 존재 -> 등록안된 ip

											update dbo.tPCRoomIP
												set
													gameid 		= @ps1_,
													pcip		= @ps3_,
													adminid 	= @ps2_
											where idx = @p5_

											select @RESULT_SUCCESS 'rtn'
										end
								end
							else if(@p4_ = 3)
								begin
									delete from dbo.tPCRoomIP where idx = @p5_

									select @RESULT_SUCCESS 'rtn'
								end
						end
				end
		end
	-----------------------------------------------------
	--	유저로그
	-----------------------------------------------------

	else if(@kind in (@KIND_USER_SEARCH))
		begin
			if(isnull(@ps2_, '') != '')
				begin
					select top 100 * from dbo.tUserMaster where phone = @ps2_ order by idx desc
				end
			else if(isnull(@gameid, '') = '')
				begin
					select @idx = max(idx) from dbo.tUserMaster
					set @maxPage = (@idx - 1) / 10
					set @idxPage = @p10_
					if(@idxPage > @maxPage)
						begin
							set @idxPage = @maxPage
						end
					set @idxPage = @idx - (@idxPage - 1) * 10

					if(@idxPage = -1)
						begin
							select top 10 *, @maxPage maxPage from dbo.tUserMaster                       order by idx desc
						end
					else
						begin
							select top 10 *, @maxPage maxPage from dbo.tUserMaster where idx <= @idxPage order by idx desc
						end
				end
			else
				begin
					-----------------------------------------
					-- 유저정보
					-----------------------------------------
					select * from dbo.tUserMaster where gameid = @gameid order by idx desc


					-----------------------------------------
					-- 유저보유 아이템 > 보유템 리스트 출력, 순서
					-----------------------------------------
					select top 700 u.idx idx2, u.*, i.itemname
					from dbo.tUserItem u
						join
							(select * from dbo.tItemInfo) i
						on u.itemcode = i.itemcode
					where gameid = @gameid
					order by invenkind asc, u.itemcode

					-----------------------------------------
					-- 유저보유 삭제아이템
					-----------------------------------------
					select top 10 u.idx idxt, u.*, i.itemname
					from dbo.tUserItemDel u
						join
							(select * from dbo.tItemInfo) i
						on u.itemcode = i.itemcode
					where gameid = @gameid
					order by idx2 desc

					---------------------------------------------
					-- 선물리스트
					---------------------------------------------
					select
						top 10 a.idx idxt, a.idx2 idx2, gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, cnt,
						b.itemcode, b.subcategory, b.itemname, b.grade, b.buyamount, b.gamecost, b.cashcost
					from (select top 20 * from dbo.tGiftList where gameid = @gameid order by idx desc) a
						LEFT JOIN
						dbo.tItemInfo b
						ON a.itemcode = b.itemcode
					order by idxt desc

					-----------------------------------------
					--유저 구매로그
					-----------------------------------------
					select top 10 a.idx 'idx',
						gameid,
						a.idx2 idx2,
						a.buydate2 buydate2,
						a.cnt cnt,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost',
						a.buydate,
						b.gamecost 'gamecost2', b.cashcost 'cashcost2'
					from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode
					where gameid = @gameid order by a.idx desc

					-----------------------------------------------
					---- 캐쉬로그
					-----------------------------------------------
					select top 10 * from dbo.tCashLog
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 비정상행동
					---------------------------------------------
					select top 10 * from dbo.tUserUnusualLog
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 비정상행동
					---------------------------------------------
					select top 10 * from dbo.tUserUnusualLog2
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 유저블럭킹
					---------------------------------------------
					select top 10 * from dbo.tUserBlockLog
					where gameid = @gameid
					order by idx desc

					-----------------------------------------------
					---- 박스오픈
					-----------------------------------------------


					-----------------------------------------------
					---- 조각조합
					-----------------------------------------------

					-----------------------------------------------
					---- 의상초월
					-----------------------------------------------
				end
		end
	-----------------------------------------------------
	--	유저로그
	-----------------------------------------------------
	else if(@kind = @KIND_USER_SETTING)
		begin
			set @gameid		= @ps1_

			--------------------------------------------
			-- 블럭로그가 존재하면 > 상세하기
			--------------------------------------------
			if(@p2_ =  1001)
				begin
					if(isnull(@gameid, '') = '')
						begin
							select top 100 * from dbo.tUserBlockLog order by idx desc
						end
					else
						begin
							select top 100 * from dbo.tUserBlockLog where gameid = @gameid order by idx desc

							select * from dbo.tUserUnusualLog where gameid = @gameid order by idx desc
						end
				end
			--------------------------------------------
			-- 비정상행동.
			--------------------------------------------
			else if(@p2_ =  1003)
				begin
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tUserUnusualLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tUserUnusualLog
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tUserUnusualLog
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1005)
				begin
					delete from dbo.tUserUnusualLog where gameid = @gameid and idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1006)
				begin
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tUserUnusualLog2

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tUserUnusualLog2
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tUserUnusualLog2
							where gameid = @gameid
							order by idx desc
						end
				end
			----------------------------------------------------
			-- 캐쉬수정
			----------------------------------------------------
			else if(@p2_ = 41)
				begin
					update dbo.tUserMaster set cashcost = cashcost + @p3_ where gameid = @gameid
					set @comment = '캐쉬 ' +
								+ case when @p3_ >= 0 then ' 추가:' else ' 삭감' end
								+ ltrim(rtrim(str(@p3_)))

					exec spu_AdminAction @ps2_, @gameid, @comment
					select 1 rtn
				end
			----------------------------------------------------
			-- 유저 파라미터 수정(입력방식).
			----------------------------------------------------
			else if(@p2_ = 65)
				begin
					if(@p3_ = 1)
						begin
							set @comment = '  레벨 변경'
							update dbo.tUserMaster
								set
									level  = CASE
													WHEN (@p4_ > @LV_MAX) 	then @LV_MAX
													WHEN (@p4_ < 1) 		then 1
													else @p4_ end
							where gameid = @gameid
						end
					else if(@p3_ = 2)
						begin
							set @comment = '  경험치 변경'
							select @exp = exp + @p4_ from dbo.tUserMaster where gameid = @gameid
							set @exp  = CASE
											WHEN (@exp < 0) 		then 0
											else @exp
										end
							set @level = dbo.fnu_GetLevel(@exp)
							set @commission = dbo.fnu_GetTax100FromLevel(@level)

							update dbo.tUserMaster
								set
									exp 		= @exp,
									level 		= @level,
									commission 	= @commission
							where gameid = @gameid
						end
					select 1 rtn
				end
			----------------------------------------------------
			-- 유저 파라미터 수정(토글방식).
			----------------------------------------------------
			else if(@p2_ = 2000)
				begin
					if(@p3_ = 1)
						begin
							set @comment = '  튜토리얼 변경'
							update dbo.tUserMaster
								set
									tutorial  = CASE
													WHEN tutorial = 0	then 	1
													else 						0
												end
							where gameid = @gameid
						end
					else if(@p3_ = 10)
						begin
							set @comment = '  싱글플레이상태 변경'
							update dbo.tUserMaster
								set
									sflag  = CASE
													WHEN sflag = 0	then 	1
													else 					0
												end
							where gameid = @gameid
						end
					else if(@p3_ = 20)
						begin
							update dbo.tUserMaster set cashcopy = 0 where gameid = @gameid
						end
					else if(@p3_ = 21)
						begin
							update dbo.tUserMaster set resultcopy = 0 where gameid = @gameid
						end
					else if(@p3_ = 22)
						begin
							-- 블럭 토글
							update dbo.tUserMaster
								set
									blockstate = case blockstate
													when @BLOCK_STATE_YES then 	@BLOCK_STATE_NO
													else 						@BLOCK_STATE_YES
												end
							where gameid = @gameid

							select @val = blockstate, @phone = phone from dbo.tUserMaster where gameid = @gameid
							if(@val = @BLOCK_STATE_YES)
								begin
									-- 블럭정보
									set @comment = '관리자(' + @ps2_ + ')가 직접 블럭 처리했습니다.'
									exec spu_AdminActionBlock @adminid, @gameid, @comment
								end
							else if(@val = @BLOCK_STATE_NO)
								begin
									-- 블럭해제
									delete from dbo.tUserBlockPhone where phone = @phone

									set @comment = '관리자(' + @ps2_ + ')가 직접 블럭 해제했습니다.'
									exec spu_AdminActionBlock @adminid, @gameid, @comment
								end
						end
					else if(@p3_ = 23)
						begin
							-- 아이디 > 폰, 블럭일괄처리.
							select @phone = phone from dbo.tUserMaster where gameid = @gameid

							if(LEN(@phone) > 5)
								begin
									-- 무조건 블럭처리
									update dbo.tUserMaster set blockstate = @BLOCK_STATE_YES where phone = @phone

									-- 블럭폰 등록, 로그.
									if(not exists(select top 1   * from dbo.tUserBlockPhone where phone = @phone))
										begin
											insert into dbo.tUserBlockPhone(phone, comment) values(@phone, '캐쉬치트해서 일괄블럭함(' + @ps2_ + ')')


											set @comment = '관리자(' + @ps2_ + ')가 직접 블럭 처리했습니다.'
											exec spu_AdminActionBlock @adminid, @gameid, @comment
										end
								end
							else
								begin
									-- 무조건 블럭처리
									update dbo.tUserMaster set blockstate = @BLOCK_STATE_YES where gameid = @gameid

									-- 블럭폰 등록, 로그.
									set @comment = '관리자(' + @ps2_ + ')가 직접 블럭 처리했습니다.'
									exec spu_AdminActionBlock @adminid, @gameid, @comment
								end
						end
					else if(@p3_ = 24)
						begin
							-------------------------------------
							-- 블럭해제
							-------------------------------------
							update dbo.tUserMaster
								set
									blockstate = @BLOCK_STATE_NO
							where gameid = @gameid

							update dbo.tUserBlockLog
								set
									blockstate = @BLOCK_STATE_NO,
									adminid = @ps2_,
									adminip = @ps3_,
									comment2 = '해제',
									releasedate = getdate()
							where idx = @p3_
						end
					select 1 rtn
				end
			else if(@p2_ =  71)
				begin
					-- 소모템 개수변경
					if(@p4_ < 0)
						begin
							set @p4_ = 0
						end
					else if(@p4_ >= 99999)
						begin
							set @p4_ = 99999
						end

					update dbo.tUserItem
						set
							@itemcode 	= itemcode,
							@cnt2		= cnt,
							@cnt3 		= @p4_,
							cnt 		= @p4_
					where gameid = @gameid and listidx = @p3_

					--메세지 기록하기.
					set @comment = dbo.fnu_GetMessageInt('관리자가(#1)이 (#2)에게 아이템(#3:#4 -> #5) 수량변경했습니다.', @adminid, @gameid, @itemcode, @cnt2, @cnt3)
					exec spu_AdminActionBlock @adminid, @gameid, @comment

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1007)
				begin
					if(@p3_ = 1)
						begin
							delete from dbo.tUserUnusualLog2 where gameid = @gameid and idx = @p4_
						end
					else if(@p3_ = 2)
						begin
							delete from dbo.tUserUnusualLog2 where gameid = @gameid
						end
					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1004)
				begin
					if(@p3_ = 1)
						begin
							-- 쿠폰정보
							select top 10 * from dbo.tEventCertNo where mode = 2 order by idx desc

							select top 10 * from dbo.tEventCertNo where mode = 1 order by idx desc

							select top 10 * from dbo.tEventCertNoBack order by idx desc
						end
					else if(@p3_ = 2)
						begin
							-- 쿠폰정보
							select top 10 * from dbo.tEventCertNo where mode = 2 and certno = @ps10_ order by idx desc

							select top 10 * from dbo.tEventCertNo where mode = 1 and certno = @ps10_ order by idx desc

							select top 10 * from dbo.tEventCertNoBack where certno = @ps10_ order by idx desc
						end
					else if(@p3_ = 3)
						begin
							-- select 'DEBUG ', @gameid gameid, @ps10_ ps10_
							select
								@itemcode1	= itemcode1,
								@itemcode2	= itemcode2,
								@itemcode3	= itemcode3,
								@certno		= certno,
								@kind		= kind
							from dbo.tEventCertNo where certno = @ps10_

							if(@gameid = '' or @ps10_ = null)
								begin
									select @RESULT_ERROR 'rtn'
								end
							else if(not exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
								begin
									select @RESULT_ERROR 'rtn'
								end
							-- 사전 예약 코드
							else if(UPPER(@ps10_) = 'LSYOARPUSSDGG796')
								begin
									select
										@eventspot06	= eventspot06
									from dbo.tUserMaster where gameid = @gameid

									-- 공통쿠폰 이벤트.
									if(@curdate < '2014-05-23 00:01' or @curdate > '2014-06-30 23:59')
										begin
											select @RESULT_ERROR 'rtn', '기간만료'
										end
									else if(@eventspot06 = 1)
										begin
											select @RESULT_ERROR 'rtn', '이미사용'
										end
									else
										begin
											---------------------------------------------------
											-- 유저 > 선물지급(없으면 자동 패스됨)
											---------------------------------------------------
											exec spu_SubGiftSendNew 2, 1205, 0, '설문보상', @gameid, ''

											--------------------------------------
											-- 인증번호 > 사용상태로 변경
											--------------------------------------
											update dbo.tUserMaster set eventspot06	= 1 where gameid = @gameid

											---------------------------------------------------
											-- 토탈 기록하기
											---------------------------------------------------
											exec spu_DayLogInfoStatic 41, 1				-- 일 쿠폰등록수

											select @RESULT_SUCCESS 'rtn'
										end
								end

							else if(@kind >= 7 and exists(select top 1 * from dbo.tEventCertNoBack where gameid = @gameid and kind = @kind))
								begin
									select @RESULT_ERROR 'rtn'
								end
							else if(not exists(select top 1 * from dbo.tEventCertNo where certno = @ps10_))
								begin
									select @RESULT_ERROR 'rtn'
								end
							else
								begin
									select
										@itemcode1	= itemcode1,
										@itemcode2	= itemcode2,
										@itemcode3	= itemcode3,
										@certno		= certno,
										@kind		= kind
									from dbo.tEventCertNo where certno = @ps10_

									--------------------------------------
									-- 유저 > 선물지급(없으면 자동 패스됨)
									--------------------------------------
									if(@itemcode1 != -1)
										begin
											exec spu_SubGiftSendNew 2, @itemcode1, 0, 'SysCert', @gameid, ''
										end

									if(@itemcode2 != -1)
										begin
											exec spu_SubGiftSendNew 2, @itemcode2, 0, 'SysCert', @gameid, ''
										end

									if(@itemcode3 != -1)
										begin
											exec spu_SubGiftSendNew 2, @itemcode3, 0, 'SysCert', @gameid, ''
										end

									--------------------------------------
									-- 인증번호 > 사용상태로 변경(사용여부, 아이디, 사용날짜)
									--------------------------------------
									delete from dbo.tEventCertNo where certno = @ps10_

									insert into dbo.tEventCertNoBack(certno,   gameid,   itemcode1,  itemcode2,  itemcode3,  kind)
									values(                           @ps10_, @gameid,  @itemcode1, @itemcode2, @itemcode3, @kind)


									---------------------------------------------------
									-- 토탈 기록하기
									---------------------------------------------------
									exec spu_DayLogInfoStatic 41, 1				-- 일 쿠폰등록수

									select @RESULT_SUCCESS 'rtn'
								end

						end
				end
			else if(@p2_ =  1110)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tUserItemDel


							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tUserItemDel
							u join (select * from dbo.tItemInfo) i on u.itemcode = i.itemcode
							where u.idx <= @idx order by u.idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tUserItemDel
							u join (select * from dbo.tItemInfo) i on u.itemcode = i.itemcode
							where gameid = @gameid
							order by u.idx desc
						end
				end
			----------------------------------------------------
			-- 해킹한 유저들.
			----------------------------------------------------
			else if(@p2_ = 21)
				begin
					select top 100 * from dbo.tUserBlockPhone order by idx desc
				end
			else if(@p2_ = 22)
				begin
					if(not exists(select top 1   * from dbo.tUserBlockPhone where phone = @ps3_))
						begin
							insert into dbo.tUserBlockPhone(phone, comment) values(@ps3_, @ps10_)
						end

					select 1 rtn
				end
			else if(@p2_ = 23)
				begin
					if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @ps3_))
						begin
							delete from dbo.tUserBlockPhone where phone = @ps3_
						end

					select 1 rtn
				end
			else if(@p2_ = 31)
				begin
					delete from dbo.tUserItem
					where gameid = @gameid and listidx = @p3_

					select 1 rtn
				end
			else if(@p2_ = 64)
				begin
					if(@p3_ = 4)
						begin
							set @comment = ' 튜토리얼 초기화'
							update dbo.tUserMaster set tutorial  = 0 where gameid = @ps1_
						end
					select 1 rtn
				end
			else if(@p2_ = 300)
				begin
					-----------------------------------
					-- 유니크 핸드폰 정보
					-----------------------------------
					if(isnull(@ps3_, '') = '')
						begin
							select top 100 * from dbo.tUserPhone order by idx desc
						end
					else
						begin
							select top 100 * from dbo.tUserPhone where phone = @ps3_ order by idx desc
						end
				end
			-----------------------------------
			-- 유저 구매리스트, 토탈, 세부, 월별
			-----------------------------------
			else if(@p2_ = 400)
				begin
					-- 유저 구매리스트
					if(isnull(@ps1_, '') = '')
						begin
							--select top 300 * from dbo.tUserItemBuyLog order by idx desc
							select top 300 a.idx 'idx',
								gameid,
								a.idx2 idx2,
								a.buydate2 buydate2,
								a.cnt cnt,
								a.itemcode 'itemcode', b.itemname,
								a.gamecost 'gamecost', a.cashcost 'cashcost',
								a.buydate
							from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode
							order by a.idx desc
						end
					else
						begin
							--select top 300 * from dbo.tUserItemBuyLog where gameid = @ps1_ order by idx desc
							select top 300 a.idx 'idx',
								gameid,
								a.idx2 idx2,
								a.buydate2 buydate2,
								a.cnt cnt,
								a.itemcode 'itemcode', b.itemname,
								a.gamecost 'gamecost', a.cashcost 'cashcost',
								a.buydate
							from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode
							where gameid = @ps1_ order by a.idx desc
						end
				end
			else if(@p2_ = 401)
				begin
					-- 유저 월토탈 통계
					if(isnull(@ps2_, '') = '')
						begin
							select top 300 * from dbo.tUserItemBuyLogTotalMaster order by dateid8 desc
						end
					else
						begin
							select top 300 * from dbo.tUserItemBuyLogTotalMaster where dateid8 = @ps2_ order by dateid8 desc
						end
				end
			else if(@p2_ = 402)
				begin
					-- 유저 월서브 통계
					set @ps2_ = isnull(@ps2_, '')

					select top 500 a.idx 'idx',
						dateid8,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost',
						a.cnt
					from dbo.tUserItemBuyLogTotalSub a join dbo.tItemInfo b on a.itemcode = b.itemcode
					where dateid8 = @ps2_
					order by a.cashcost desc, a.gamecost desc
				end
			else if(@p2_ = 403)
				begin
					-- 유저 월아이템 통계
					set @ps2_ = isnull(@ps2_, '')

					select top 600 a.idx 'idx',
						dateid6,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost',
						a.cnt
					from dbo.tUserItemBuyLogMonth a join dbo.tItemInfo b on a.itemcode = b.itemcode
					where dateid6 = @ps2_
					order by a.cashcost desc, a.gamecost desc
				end
			else if(@p2_ = 421)
				begin
					-- 유저 월토탈 통계
					if(isnull(@ps2_, '') = '')
						begin
							select top 300 * from dbo.tUserItemUpgradeLogTotalMaster order by dateid8 desc
						end
					else
						begin
							select top 300 * from dbo.tUserItemUpgradeLogTotalMaster where dateid8 = @ps2_ order by dateid8 desc
						end
				end
			else if(@p2_ = 422)
				begin
					-- 유저 월서브 통계
					set @ps2_ = isnull(@ps2_, '')

					select top 500 a.idx 'idx',
						dateid8,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost', a.heart 'heart',
						a.cnt
					from dbo.tUserItemUpgradeLogTotalSub a join dbo.tItemInfo b on a.itemcode = b.itemcode
					where dateid8 = @ps2_
					order by a.cashcost desc, a.gamecost desc
				end
			else if(@p2_ = 423)
				begin
					-- 유저 월아이템 통계
					set @ps2_ = isnull(@ps2_, '')

					select top 600 a.idx 'idx',
						dateid6,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost', a.heart 'heart',
						a.cnt
					from dbo.tUserItemUpgradeLogMonth a join dbo.tItemInfo b on a.itemcode = b.itemcode
					where dateid6 = @ps2_
					order by a.cashcost desc, a.gamecost desc
				end
		end
	-----------------------------------------------------
	--	유저삭제
	-----------------------------------------------------
	else if(@kind = @KIND_USER_DELETEID)
		begin
			set @subkind 	= @p2_
			set @gameid		= @ps1_
			if(@subkind = 1)
				begin
					update dbo.tUserPhone set joincnt = joincnt - 1
					where phone = (select phone from dbo.tUserMaster where gameid = @gameid)

					delete from dbo.tUserMaster where gameid = @gameid
					delete from dbo.tUserItem where gameid = @gameid
					delete from dbo.tUserItemDel where gameid = @gameid
					delete from dbo.tUserItemBuyLog where gameid = @gameid
					delete from dbo.tUserBlockLog where gameid = @gameid
					delete from dbo.tUserUnusualLog where gameid = @gameid
					delete from dbo.tUserUnusualLog2 where gameid = @gameid
					delete from dbo.tUserBlockLog where gameid = @gameid
					delete from dbo.tGiftList where gameid = @gameid
					delete from dbo.tCashLog where gameid = @gameid
					delete from dbo.tSysInquire where gameid = @gameid

					set @comment = ('개발자가 '+@gameid+'계정을 삭제하면서 자료까지 삭제했습니다.')
					exec spu_AdminAction @adminid, @gameid, @comment
				end
			else if(@subkind = 2)
				begin
					update dbo.tUserPhone set joincnt = 0
					where phone = (select phone from dbo.tUserMaster where gameid = @gameid)

				end
			select @RESULT_SUCCESS 'rtn'
		end
	-----------------------------------------------------
	--	선물
	-----------------------------------------------------
	else if(@kind = @KIND_USER_GIFT)
		begin
			set @subkind 	= @p2_
			set @itemcode	= @p3_
			set @adminid 	= @ps1_
			set @gameid 	= @ps2_
			set @comment 	= @ps3_
			if(@subkind	= 1)
				begin
					          select * from dbo.tItemInfo where                      itemcode = 5000	-- 캐쉬
					union all select * from dbo.tItemInfo where						 itemcode = 3600	--
					union all select * from dbo.tItemInfo where subcategory = 45 						-- 조합주문서
					union all select * from dbo.tItemInfo where subcategory = 46 						-- 수수료주문서
					union all select * from dbo.tItemInfo where subcategory = 40 						-- 박스템
					union all select * from dbo.tItemInfo where subcategory = 41 						-- 박스템
					union all select * from dbo.tItemInfo where subcategory = 42 						-- 박스템
					union all select * from dbo.tItemInfo where category in (1, 15)
					--order by itemcode asc
				end
			else if(@subkind = 2)
				begin
					if(isnull(@gameid, '') = '')
						begin
							-- 최근것
							select a.idx idxt, a.idx2 idx2, gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
							from (select top 50 * from dbo.tGiftList order by idx desc) a
								LEFT JOIN
								dbo.tItemInfo b
								ON a.itemcode = b.itemcode
							order by idxt desc
						end
					else
						begin
							set @str 	= @gameid
							set @str2 	= @ps3_
							if(isnull(@str2, '') = '')
								begin
									select a.idx idxt, a.idx2 idx2,  gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
									from (select top 1000 * from dbo.tGiftList where gameid = @str order by idx desc) a
										LEFT JOIN
										dbo.tItemInfo b
										ON a.itemcode = b.itemcode
									order by idxt desc
								end
							else
								begin
									select a.idx idxt, a.idx2 idx2,  gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
									from (select top 1000 * from dbo.tGiftList where gameid = @str and giftid = @str2 order by idx desc) a
										LEFT JOIN
										dbo.tItemInfo b
										ON a.itemcode = b.itemcode
									order by idxt desc
								end

						end
				end
			else if(@subkind = 11)
				begin
					if(not exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_GAMEID
						end
					else if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @itemcode))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_ITEMCODE
						end
					else
						begin
							set @nResult = @RESULT_SUCCESS
							set @str = '관리자(' + @adminid + ')'

							if( @itemcode = 3800 and @ps4_ >= 99 )
								begin
									set @ps4_ = 99
								end
							else if( @itemcode = 3801 and @ps4_ >= 1 )
								begin
									set @ps4_ = 1
								end

							exec spu_SubGiftSendNew 2,  @itemcode, @ps4_, @str, @gameid, ''

							--insert into dbo.tGiftList(gameid, giftkind, itemcode, giftid)
							--values(@gameid, 2, @itemcode, @adminid);
						end

					select @nResult 'rtn'
				end
			else if(@subkind = 12)
				begin
					if(not exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_GAMEID
						end
					else
						begin
							set @nResult = @RESULT_SUCCESS
							set @str = '관리자(' + @adminid + ')'

							exec spu_SubGiftSendNew 1, -1, 0, @str, @gameid, @comment

							--insert into dbo.tGiftList(gameid, giftkind, message)
							--values(@gameid, 1, @comment);
						end

					select @nResult 'rtn'
				end
			else if(@subkind = 21)
				begin
					update dbo.tGiftList
						set
							giftkind = case
											when giftkind = @GIFTLIST_GIFT_KIND_MESSAGE 	then @GIFTLIST_GIFT_KIND_MESSAGE_DEL
											when giftkind = @GIFTLIST_GIFT_KIND_GIFT 		then @GIFTLIST_GIFT_KIND_GIFT_DEL
											else giftkind
										end
					where idx = @p4_

					select @nResult 'rtn'
				end
			else if(@subkind = 22)
				begin
					update dbo.tGiftList
						set
							giftkind = case
											when giftkind = @GIFTLIST_GIFT_KIND_MESSAGE_DEL 	then @GIFTLIST_GIFT_KIND_MESSAGE
											when giftkind = @GIFTLIST_GIFT_KIND_GIFT_DEL		then @GIFTLIST_GIFT_KIND_GIFT
											when giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET		then @GIFTLIST_GIFT_KIND_GIFT
											when giftkind = @GIFTLIST_GIFT_KIND_GIFT_SELL		then @GIFTLIST_GIFT_KIND_GIFT
											else giftkind
										end
					where idx = @p4_

					select @nResult 'rtn'
				end
			else if(@subkind = 23)
				begin
					delete from dbo.tGiftList where idx = @p4_

					select @nResult 'rtn'
				end
			--else if(@subkind = 31)
			--	begin
			--		select * from dbo.tItemInfo
			--		where subcategory in (1, 2, 3, 8, 9, 11, 12, 13, 40, 50, 51, 22, 23, 16, 19)
			--		order by itemcode asc
			--	end
		end
	-----------------------------------------------------
	--	통계자료
	-----------------------------------------------------
	else if(@kind = @KIND_STATISTICS_INFO)
		begin
			set @dateid = @ps2_

			if(@p2_	= 1)
				begin
					-- 읽기.
					set @idxPage	= @p4_
					select @idx = (isnull(max(idx), 1)) from dbo.tDayLogInfoStatic

					set @maxPage	= @idx / @PAGE_LINE50
					set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE50 != 0) then 1 else 0 end
					set @page		= case
										when (@idxPage <= 0)			then 1
										when (@idxPage >  @maxPage)	then @maxPage
										else @idxPage
									end
					set @idx		= @idx - (@page - 1) * @PAGE_LINE50

					select top 50 @maxPage maxPage, @page page, * from dbo.tDayLogInfoStatic
					where idx <= @idx
					order by dateid8 desc, idx desc

				end
			else if(@p2_ = 11)
				begin
					-- 유저구매로그
					select @idx = max(idx) from dbo.tCashLog
					set @maxPage = (@idx - 1) / 25 + 2
					set @idxPage = @p3_
					if(@idxPage > @maxPage)
						begin
							set @idxPage = @maxPage
						end
					set @idxPage = @idx - (@idxPage - 1) * 25
					--select 'DEBUG ', @idx idx, @maxPage maxPage, @idxPage idxPage

					if(isnull(@ps3_, '') != '')
						begin
							--select 'DEBUG 1'
							select top 1 *, @maxPage maxPage from dbo.tCashLog where acode = @ps3_ order by idx desc
						end
					else if(isnull(@gameid, '') != '')
						begin
							--select 'DEBUG 2'
							if(@idxPage = -1)
								begin
									select *, @maxPage maxPage from dbo.tCashLog where gameid = @gameid order by idx desc
								end
							else
								begin
									select *, @maxPage maxPage from dbo.tCashLog where gameid = @gameid and idx <= @idxPage order by idx desc
								end
						end
					else
						begin
							--select 'DEBUG 3'
							if(@idxPage = -1)
								begin
									select top 25 *, @maxPage maxPage from dbo.tCashLog order by idx desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage from dbo.tCashLog where idx <= @idxPage order by idx desc
								end
						end
				end
			else if(@p2_ = 12)
				begin
					select @idx = max(idx) from dbo.tCashTotal
					set @maxPage = @idx / @PAGE_CASH_LIST + case when (@idx > 0 and @idx % @PAGE_CASH_LIST != 0) then 1 else 0 end
					set @idxPage = case
										when @p3_ <= 0 			then 1
										when @p3_ >= @maxPage 	then @maxPage
										else					     @p3_
									end
					set @idx2 = @idx - (@idxPage - 1) * 25
					--select 'DEBUG ', @idx idx, @maxPage maxPage, @idxPage idxPage, @idx2 idx2

					if(isnull(@dateid, '') = '')
						begin
							if(@idxPage = -1)
								begin
									select top 25 *, @maxPage maxPage  from dbo.tCashTotal                                         order by dateid desc, cashkind desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage  from dbo.tCashTotal where                     idx <= @idx2  order by dateid desc, cashkind desc
								end
						end
					else
						begin
							if(@idxPage = -1)
								begin
									select top 25 *, @maxPage maxPage  from dbo.tCashTotal where dateid = @dateid                  order by dateid desc, cashkind desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage  from dbo.tCashTotal where dateid = @dateid and idx <= @idx2 order by dateid desc, cashkind desc
								end
						end
				end
			else if(@p2_ = 13)
				begin
					--select 'DEBUG 1 ', @ps2_ ps2_
					if(@ps2_ != '')
						begin
							--select 'DEBUG 2-1', @ps2_ ps2_
							set @dateid = @ps2_ + '%'
						end
					else
						begin
							--select 'DEBUG 2-2', @dateid6 dateid6
							set @dateid = @dateid6 + '%'
						end
					--select 'DEBUG 3', @dateid dateid
					select dateid, sum(cashcost) cashcost, sum(cash) cash, count(*) cnt from dbo.tCashTotal where dateid like @dateid group by dateid order by dateid desc
				end
			else if(@p2_ = 14)
				begin
					select top 100 * from dbo.tStaticCashUnique order by idx desc
				end
			else if(@p2_ = 23)
				begin
					set @cashkind = @p3_
					set @gameid = @ps1_
					set @ikind 	= @ps2_
					set @acode 	= @ps3_
					set @ucode 	= @ps3_
					set @password = ''
					select
						@gameid 	= gameid,
						@password 	= password
					from dbo.tUserMaster where gameid = @gameid
					--select 'DEBUG ', @gameid gameid, @password password, @ikind ikind

					if(@gameid = '' or @password = '')
						begin
							select @RESULT_ERROR 'rtn', '계정이 존재하지 않습니다.'
						end
					else if(@acode = '' or @ucode = '')
						begin
							select @RESULT_ERROR 'rtn', '영수증 번호가 없습니다.'
						end
					else if(@cashkind not in (5000, 5001, 5002, 5003, 5004, 5005, 5006))
						begin
							select @RESULT_ERROR 'rtn', '금액이 잘못 되었습니다.'
						end
					else if(exists(select top 1 * from dbo.tCashLog where acode = @acode))
						begin
							select @RESULT_ERROR 'rtn', '코드가 중복됩니다.(acode)'
						end
					else if(exists(select top 1 * from dbo.tCashLog where ucode = @ucode))
						begin
							select @RESULT_ERROR 'rtn', '코드가 중복됩니다.(ucode)'
						end
					else
						begin
							--내부에서 또 리턴해준다.
							set @comment = ('강제로 캐쉬지급 ' + ltrim(rtrim(str(@cashkind))) + '원')
							exec spu_AdminAction @adminid, @gameid, @comment

							if(@cashkind in (5000) )
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind,     1,     10,     1,   10, @ikind, '', '', -1	-- 구매
								end
							else if(@cashkind in (5001))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind,   100,   1000,   100,   1000, @ikind, '', '', -1	--
								end
							else if(@cashkind in (5002))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind,  1000,  10000,  1000,  10000, @ikind, '', '', -1	--
								end
							else if(@cashkind in (5003))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind,  2500,  25000,  2500,  25000, @ikind, '', '', -1	--
								end
							else if(@cashkind in (5004))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind,  4000,  40000,  4000,  40000, @ikind, '', '', -1	--
								end
							else if(@cashkind in (5005))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind, 10000, 100000, 10000, 100000, @ikind, '', '', -1	--
								end
							else if(@cashkind in (5006))
								begin
									exec spu_CashBuyAdmin 1, @gameid,      '', @password, @acode, @ucode, 1, @cashkind, 20000, 200000, 20000, 200000, @ikind, '', '', -1	--
								end
							else
								begin
									select @RESULT_ERROR 'rtn', '오류가 나왔네요'
								end
						end
				end
		end

	-----------------------------------------------------
	--	캐쉬삭제
	-----------------------------------------------------
/*
	else if(@kind = @KIND_USER_CASH_LOG_DELETE)
		begin
			--if(isnull(@gameid, '') = '')
			--	begin
			--		select @RESULT_ERROR 'rtn'
			--		return
			--	end

			set @idx 			= @p3_
			if(@p2_ = 1)
				begin
					----------------------------------------------
					-- 검색(단일) > 로그삭제, 차감
					----------------------------------------------
					select
						@dateid = Convert(varchar(8), writedate, 112),
						@cashcost = cashcost,
						@cash = cash
					from dbo.tCashLog
					where idx = @idx and gameid = @gameid
					--select 'DEBUG ', @dateid dateid, @cashcost cashcost, @cash cash, @idx idx, @gameid gameid

					-- 로그삭제
					delete dbo.tCashLog where idx = @idx and gameid = @gameid

					-- 통계차감
					update dbo.tCashTotal
						set
							cashcost = cashcost - @cashcost,
							cash = cash - @cash,
							cnt = cnt - 1
					where dateid = @dateid and cashkind = @cash

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 2)
				begin
					----------------------------------------------
					-- 검색(일괄) > 로그삭제, 차감
					----------------------------------------------
					-- 2-1. 커서 설정
					declare curCashLog Cursor for
					select Convert(varchar(8), writedate, 112), cashcost, cash, idx from dbo.tCashLog where gameid = @gameid

					-- 2-2. 커서오픈
					open curCashLog

					-- 2-3. 커서 사용
					Fetch next from curCashLog into @dateid, @cashcost, @cash, @idx
					while @@Fetch_status = 0
						Begin
							-- 로그삭제
							delete dbo.tCashLog where idx = @idx and gameid = @gameid

							-- 통계차감
							update dbo.tCashTotal
								set
									cashcost = cashcost - @cashcost,
									cash = cash - @cash,
									cnt = cnt - 1
							where dateid = @dateid and cashkind = @cash

							Fetch next from curCashLog into @dateid, @cashcost, @cash, @idx
						end

					-- 2-4. 커서닫기
					close curCashLog
					Deallocate curCashLog

					select @RESULT_SUCCESS 'rtn'
				end

		end
*/
	-----------------------------------------------------
	--	캐쉬삭제
	-----------------------------------------------------
/*
	else if(@kind = @KIND_SYSTEMINFO_SETTING)
		begin
			-----------------------------------
			-- 동물뽑기 21, 22, 23
			-----------------------------------
			if(@p2_ = 21)
				begin
					-------------------------------------------------
					-- 교배뽑기 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tItemInfo
					where subcategory in (1, 15, 3)

					select * from dbo.tItemInfo
					where subcategory in (1, 15, 3)
					order by itemcode asc

					select top 200 * from dbo.tSystemRoulette
					where packstate = @p3_
					order by idx desc
					--order by famelvmin desc, famelvmax desc, idx desc
				end
			else if(@p2_ = 22)
				begin
					-------------------------------------------------
					-- 교배뽑기 (등록)
					-------------------------------------------------
					-- 1. 커서 생성
					declare curRoulInsert Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @ps3_)

					-- 2. 커서오픈
					open curRoulInsert

					-- 3. 커서 사용
					Fetch next from curRoulInsert into @packkind, @packvalue
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG ', @packkind packkind, @packvalue packvalue
							if(@packkind = 1) 		set @pack1 = @packvalue
							else if(@packkind = 2) 	set @pack2 = @packvalue
							else if(@packkind = 3) 	set @pack3 = @packvalue
							else if(@packkind = 4) 	set @pack4 = @packvalue
							else if(@packkind = 5) 	set @pack5 = @packvalue
							else if(@packkind = 6) 	set @pack6 = @packvalue
							else if(@packkind = 7) 	set @pack7 = @packvalue
							else if(@packkind = 8) 	set @pack8 = @packvalue
							else if(@packkind = 9) 	set @pack9 = @packvalue
							else if(@packkind = 10) set @pack10 = @packvalue
							else if(@packkind = 11) set @pack11 = @packvalue
							else if(@packkind = 12) set @pack12 = @packvalue
							else if(@packkind = 13) set @pack13 = @packvalue
							else if(@packkind = 14) set @pack14 = @packvalue
							else if(@packkind = 15) set @pack15 = @packvalue
							else if(@packkind = 16) set @pack16 = @packvalue
							else if(@packkind = 17) set @pack17 = @packvalue
							else if(@packkind = 18) set @pack18 = @packvalue
							else if(@packkind = 19) set @pack19 = @packvalue
							else if(@packkind = 20) set @pack20 = @packvalue
							else if(@packkind = 21) set @pack21 = @packvalue
							else if(@packkind = 22) set @pack22 = @packvalue
							else if(@packkind = 23) set @pack23 = @packvalue
							else if(@packkind = 24) set @pack24 = @packvalue
							else if(@packkind = 25) set @pack25 = @packvalue
							else if(@packkind = 26) set @pack26 = @packvalue
							else if(@packkind = 27) set @pack27 = @packvalue
							else if(@packkind = 28) set @pack28 = @packvalue
							else if(@packkind = 29) set @pack29 = @packvalue
							else if(@packkind = 30) set @pack30 = @packvalue
							else if(@packkind = 31) set @pack31 = @packvalue
							else if(@packkind = 32) set @pack32 = @packvalue
							else if(@packkind = 33) set @pack33 = @packvalue
							else if(@packkind = 34) set @pack34 = @packvalue
							else if(@packkind = 35) set @pack35 = @packvalue
							else if(@packkind = 36) set @pack36 = @packvalue
							else if(@packkind = 37) set @pack37 = @packvalue
							else if(@packkind = 38) set @pack38 = @packvalue
							else if(@packkind = 39) set @pack39 = @packvalue
							else if(@packkind = 40) set @pack40 = @packvalue
							else if(@packkind = 41) set @pack41 = @packvalue
							else if(@packkind = 42) set @pack42 = @packvalue
							else if(@packkind = 43) set @pack43 = @packvalue
							else if(@packkind = 44) set @pack44 = @packvalue
							else if(@packkind = 45) set @pack45 = @packvalue
							else if(@packkind = 46) set @pack46 = @packvalue
							else if(@packkind = 47) set @pack47 = @packvalue
							else if(@packkind = 48) set @pack48 = @packvalue
							else if(@packkind = 49) set @pack49 = @packvalue
							else if(@packkind = 50) set @pack50 = @packvalue

							Fetch next from curRoulInsert into @packkind, @packvalue
						end

					-- 4. 커서닫기
					close curRoulInsert
					Deallocate curRoulInsert

					if(not exists(select top 1 * from dbo.tSystemRoulette where packstr = @ps3_))
						begin
							-- 정보수집용 추가 > 아이템 테이블 추가하기.
							set @itemcode = 60000
							select @itemcode = max(itemcode) + 1 from dbo.tItemInfo where subcategory = 600

							if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @itemcode))
								begin
									insert into dbo.tItemInfo(labelname,     itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
									                   values('staticinfo', @itemcode, '600',    '600',       '0',      @ps1_,    '0',      '0',     '0',   '0',      '16', '0',      '0',     '0',      '0',      '0',       '0',      @ps2_)
									insert into dbo.tSystemRoulette( itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale,             packstate, packname,  comment, packstr,
																 	 pack1,   pack2,   pack3,   pack4,   pack5,   pack6,   pack7,   pack8,   pack9,  pack10,
																	pack11,  pack12,  pack13,  pack14,  pack15,  pack16,  pack17,  pack18,  pack19,  pack20,
																	pack21,  pack22,  pack23,  pack24,  pack25,  pack26,  pack27,  pack28,  pack29,  pack30,
																	pack31,  pack32,  pack33,  pack34,  pack35,  pack36,  pack37,  pack38,  pack39,  pack40,
																	pack41,  pack42,  pack43,  pack44,  pack45,  pack46,  pack47,  pack48,  pack49,  pack50,
																	gamecost, heart)
														     values(@itemcode, @p4_,      @p5_,      @p6_,         @p7_,        @p6_ - (@p6_ * @p7_)/100, @p8_,      @ps1_,     @ps2_,   @ps3_,
														     		 @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
														     		@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																	@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																	@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																	@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50,
														     		@p9_,     @p10_)
								end
						end

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 23)
				begin
					update dbo.tSystemRoulette
							set
								famelvmin	= @p4_,
								famelvmax	= @p5_,
								--cashcostcost= @p6_,
								--cashcostper= @p7_,
								--cashcostsale= @p6_ - (@p6_ * @p7_)/100,
								--gamecost 	= @p9_,
								--heart 	= @p10_,
								packstate	= @p8_,
								packname	= @ps1_,
								comment		= @ps2_
					where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			-----------------------------------
			-- 보물뽑기 25, 26, 27
			-----------------------------------
			else if(@p2_ = 25)
				begin
					-------------------------------------------------
					-- 보물뽑기 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tItemInfo
					where subcategory in (1200)

					select * from dbo.tItemInfo
					where subcategory in (1200)
					order by itemcode asc

					select top 200 * from dbo.tSystemTreasure
					where packstate = @p3_
					order by idx desc
					--order by famelvmin desc, famelvmax desc, idx desc
				end
			else if(@p2_ = 26)
				begin
					-------------------------------------------------
					-- 보물뽑기 (등록)
					-------------------------------------------------
					-- 1. 커서 생성
					declare curRoulInsert Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @ps3_)

					-- 2. 커서오픈
					open curRoulInsert

					-- 3. 커서 사용
					Fetch next from curRoulInsert into @packkind, @packvalue
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG ', @packkind packkind, @packvalue packvalue
							if(@packkind = 1) 		set @pack1 = @packvalue
							else if(@packkind = 2) 	set @pack2 = @packvalue
							else if(@packkind = 3) 	set @pack3 = @packvalue
							else if(@packkind = 4) 	set @pack4 = @packvalue
							else if(@packkind = 5) 	set @pack5 = @packvalue
							else if(@packkind = 6) 	set @pack6 = @packvalue
							else if(@packkind = 7) 	set @pack7 = @packvalue
							else if(@packkind = 8) 	set @pack8 = @packvalue
							else if(@packkind = 9) 	set @pack9 = @packvalue
							else if(@packkind = 10) set @pack10 = @packvalue
							else if(@packkind = 11) set @pack11 = @packvalue
							else if(@packkind = 12) set @pack12 = @packvalue
							else if(@packkind = 13) set @pack13 = @packvalue
							else if(@packkind = 14) set @pack14 = @packvalue
							else if(@packkind = 15) set @pack15 = @packvalue
							else if(@packkind = 16) set @pack16 = @packvalue
							else if(@packkind = 17) set @pack17 = @packvalue
							else if(@packkind = 18) set @pack18 = @packvalue
							else if(@packkind = 19) set @pack19 = @packvalue
							else if(@packkind = 20) set @pack20 = @packvalue
							else if(@packkind = 21) set @pack21 = @packvalue
							else if(@packkind = 22) set @pack22 = @packvalue
							else if(@packkind = 23) set @pack23 = @packvalue
							else if(@packkind = 24) set @pack24 = @packvalue
							else if(@packkind = 25) set @pack25 = @packvalue
							else if(@packkind = 26) set @pack26 = @packvalue
							else if(@packkind = 27) set @pack27 = @packvalue
							else if(@packkind = 28) set @pack28 = @packvalue
							else if(@packkind = 29) set @pack29 = @packvalue
							else if(@packkind = 30) set @pack30 = @packvalue
							else if(@packkind = 31) set @pack31 = @packvalue
							else if(@packkind = 32) set @pack32 = @packvalue
							else if(@packkind = 33) set @pack33 = @packvalue
							else if(@packkind = 34) set @pack34 = @packvalue
							else if(@packkind = 35) set @pack35 = @packvalue
							else if(@packkind = 36) set @pack36 = @packvalue
							else if(@packkind = 37) set @pack37 = @packvalue
							else if(@packkind = 38) set @pack38 = @packvalue
							else if(@packkind = 39) set @pack39 = @packvalue
							else if(@packkind = 40) set @pack40 = @packvalue
							else if(@packkind = 41) set @pack41 = @packvalue
							else if(@packkind = 42) set @pack42 = @packvalue
							else if(@packkind = 43) set @pack43 = @packvalue
							else if(@packkind = 44) set @pack44 = @packvalue
							else if(@packkind = 45) set @pack45 = @packvalue
							else if(@packkind = 46) set @pack46 = @packvalue
							else if(@packkind = 47) set @pack47 = @packvalue
							else if(@packkind = 48) set @pack48 = @packvalue
							else if(@packkind = 49) set @pack49 = @packvalue
							else if(@packkind = 50) set @pack50 = @packvalue

							Fetch next from curRoulInsert into @packkind, @packvalue
						end

					-- 4. 커서닫기
					close curRoulInsert
					Deallocate curRoulInsert

					if(not exists(select top 1 * from dbo.tSystemTreasure where packstr = @ps3_))
						begin
							-- 정보수집용 추가 > 아이템 테이블 추가하기.
							set @itemcode = 130000
							select @itemcode = isnull(max(itemcode), 130000) + 1 from dbo.tItemInfo where subcategory = 1300

							if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @itemcode))
								begin
									insert into dbo.tItemInfo(labelname,     itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
									                   values('staticinfo', @itemcode,   '1300',      '1300',       '0',   @ps1_,      '0',     '0',   '0',      '0', '16',      '0',     '0',      '0',      '0',       '0',      '0',       @ps2_)
									insert into dbo.tSystemTreasure( itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale,             packstate, packname,  comment, packstr,
																 	 pack1,   pack2,   pack3,   pack4,   pack5,   pack6,   pack7,   pack8,   pack9,  pack10,
																	pack11,  pack12,  pack13,  pack14,  pack15,  pack16,  pack17,  pack18,  pack19,  pack20,
																	pack21,  pack22,  pack23,  pack24,  pack25,  pack26,  pack27,  pack28,  pack29,  pack30,
																	pack31,  pack32,  pack33,  pack34,  pack35,  pack36,  pack37,  pack38,  pack39,  pack40,
																	pack41,  pack42,  pack43,  pack44,  pack45,  pack46,  pack47,  pack48,  pack49,  pack50,
																	gamecost, heart)
														     values(@itemcode, @p4_,      @p5_,      @p6_,         @p7_,        @p6_ - (@p6_ * @p7_)/100, @p8_,      @ps1_,     @ps2_,   @ps3_,
														     		 @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
														     		@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																	@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																	@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																	@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50,
														     		@p9_,     @p10_)
								end
						end

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 27)
				begin
					update dbo.tSystemTreasure
							set
								famelvmin	= @p4_,
								famelvmax	= @p5_,
								packstate	= @p8_,
								packname	= @ps1_,
								comment		= @ps2_
					where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end

			else if(@p2_ = 50)
				begin
					-------------------------------------------------
					-- 패키지 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tItemInfo
					where subcategory in (1, 2, 3, 8, 9, 44, 11, 12, 13, 40, 41, 42, 50, 51, 22, 23, 16, 19)

					select * from dbo.tItemInfo
					where subcategory in (1, 2, 3, 8, 9, 44, 11, 12, 13, 40, 41, 42, 50, 51, 22, 23, 16, 19)
					order by itemcode asc

					-------------------------------------------------
					-- 시간제 이벤트 정보.
					-------------------------------------------------
					select * from dbo.tEventMaster where idx = 1

					select top 200 u.*, i.itemname from dbo.tEventSub u join
						(select * from dbo.tItemInfo) i
							on u.eventitemcode = i.itemcode
					order by eventday asc, eventstarthour asc
				end
			else if(@p2_ = 51)
				begin
					update dbo.tEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 52)
				begin
					set @subkind		= @p3_
					set @idx			= @p4_
					set @itemcode 		= @p5_
					set @eventstatedaily= @p6_
					set @eventcnt		= @p7_
					set @eventsender	= @ps3_
					set @eventday		= @ps4_
					set @eventstarthour	= @ps5_
					set @eventendhour	= @ps6_
					set @eventpushtitle	= @ps9_
					set @eventpushmsg	= @ps10_

					if(@subkind = 1)
						begin
							if(@itemcode != -1)
								begin
									insert into dbo.tEventSub(eventitemcode,  eventsender,  eventday,  eventstarthour,  eventendhour,  eventpushtitle,  eventpushmsg,  eventstatedaily,  eventcnt)
									values(                         @itemcode, @eventsender, @eventday, @eventstarthour, @eventendhour, @eventpushtitle, @eventpushmsg, @eventstatedaily, @eventcnt)
								end
							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 2)
						begin
							-- 수정.
							update dbo.tEventSub
								set
									eventstatedaily	= @eventstatedaily,
									eventcnt		= @eventcnt,
									eventitemcode 	= @itemcode,
									eventsender		= @eventsender,
									eventday		= @eventday,
									eventstarthour	= @eventstarthour,
									eventendhour	= @eventendhour,
									eventpushtitle	= @eventpushtitle,
									eventpushmsg	= @eventpushmsg
							where eventidx = @idx

							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 3)
						begin
							update dbo.tEventSub set eventstatedaily = case when eventstatedaily = 0 then 1 else 0 end where eventidx = @idx

							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 4)
						begin
							update dbo.tEventSub set eventpushstate = case when eventpushstate = 0 then 1 else 0 end where eventidx = @idx

							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 5)
						begin
							delete from dbo.tEvnetUserGetLog where idx = @p4_

							select @RESULT_SUCCESS 'rtn'
						end
				end
			else if(@p2_ = 53)
				begin
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tEvnetUserGetLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tEvnetUserGetLog u join
								(select * from dbo.tItemInfo) i
									on u.eventitemcode = i.itemcode
							where u.idx <= @idx order by u.idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tEvnetUserGetLog u join
								(select * from dbo.tItemInfo) i
									on u.eventitemcode = i.itemcode
							where gameid = @gameid
							order by u.idx desc
						end
				end
			else if(@p2_ = 60)
				begin
					select * from dbo.tItemInfo
					where subcategory in (69)
					order by itemcode asc
				end
			else if(@p2_ = 61)
				begin
					-------------------------------------------------
					-- 목장배틀 정보수정.
					-------------------------------------------------
					-- 1. 커서 생성
					declare curGameMTBaseballList Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @ps3_)

					-- 2. 커서오픈
					open curGameMTBaseballList

					-- 3. 커서 사용
					Fetch next from curGameMTBaseballList into @packkind, @packvalue
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG ', @packkind packkind, @packvalue packvalue
								 if(@packkind = 2) 	set @pack2 = @packvalue
							else if(@packkind = 3) 	set @pack3 = @packvalue
							else if(@packkind = 4) 	set @pack4 = @packvalue
							else if(@packkind = 5) 	set @pack5 = @packvalue
							else if(@packkind = 6) 	set @pack6 = @packvalue

							Fetch next from curGameMTBaseballList into @packkind, @packvalue
						end

					-- 4. 커서닫기
					close curGameMTBaseballList
					Deallocate curGameMTBaseballList

					update dbo.tItemInfo
						set
							param16	= @pack2,
							param17	= @pack3,
							param18	= @pack4,
							param19	= @pack5,
							param20	= @pack6
					where itemcode = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
		end
*/
	------------------------------------------------
	--	완료
	------------------------------------------------
	set nocount off
End
