use Game4FarmVill3
GO

--관리자 로그인(25)
--exec spu_FVFarmD 25, 1, 1000, -1, -1, -1, -1, -1, -1, -1, 'global', 'global', '', '', '', '', '', '', '', ''			-- 관리자 생성
--exec spu_FVFarmD 25, 1, 1000, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''		-- 관리자 생성
--exec spu_FVFarmD 25, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''			-- 관리자 로그인
--exec spu_FVFarmD 25, 3, 1000, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'a1s2d3f4', '', '', '', '', '', '', '', ''		-- 관리자 등급수정
--exec spu_FVFarmD 25, 4, -1, -1, -1, -1, -1, -1, -1, -1, 'aaaaaa', 'bbbbbb', '', '', '', '', '', '', '', ''			-- 관리자 삭제

--유저검색(7)
--exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 리스트
--exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					-- 유저 상세정보
--exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '01022223333', '', '', '', '', '', '', '', ''				-- 유저 폰검색
--exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '91188455545412243', '', '', '', '', '', '', ''		-- 유저 카톡
--exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', 'sdsssx', '', '', '', '', '', ''					-- 유저 닉네임

--유저세팅(19)
--exec spu_FVFarmD 19, 1, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', 'admin', '', '', '', '', '', '', '', ''				-- 블럭처리/해제, 기록남김
--exec spu_FVFarmD 19, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx9@gmail.com', '', '', '', '', '', '', '', '', ''			-- 유저삭제
--exec spu_FVFarmD 19, 3, 12, -1, -1, -1, -1, -1, -1, -1, 'dd23', 'admin', '192.168.0.1', '', '', '', '', '', '', ''	-- 블럭해제
--exec spu_FVFarmD 19, 4, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', 'admin', '192.168.0.1', '', '', '', '', '', '', ''	-- 푸쉬발송/해제
--exec spu_FVFarmD 19, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 블럭폰리스트
--exec spu_FVFarmD 19, 22, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', 'msg'			-- 블럭폰등록
--exec spu_FVFarmD 19, 23, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', ''			-- 블럭폰삭제
--exec spu_FVFarmD 19, 24, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 푸쉬불가 리스트
--exec spu_FVFarmD 19, 25, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', 'msg'			-- 푸쉬불가 등록
--exec spu_FVFarmD 19, 26, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '01022223333', '', '', '', '', '', '', ''			-- 푸쉬불가 삭제
--exec spu_FVFarmD 19, 64, 31, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			-- 광고리스트 번호 클리어.
--exec spu_FVFarmD 19, 64, 60, 10, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					-- 하트 받을것.
--exec spu_FVFarmD 19, 64, 61, 10, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--      하루동안 받은것.
--exec spu_FVFarmD 19, 64, 62, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--      날짜초기화.
--exec spu_FVFarmD 19, 88, 16, 10, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--      날짜초기화.
--exec spu_FVFarmD 19, 88, 17, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--
--exec spu_FVFarmD 19, 88, 18, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					-- 룰렛 초기화.
--exec spu_FVFarmD 19, 88, 24, 1001, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--
--exec spu_FVFarmD 19, 94, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 상위랭킹 100위
--exec spu_FVFarmD 19, 95, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 지난 랭킹일
--exec spu_FVFarmD 19, 96, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '20150317', '', '', '', '', '', '', ''				-- 지난 순위
--exec spu_FVFarmD 19, 97, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					-- 로고ON/OFF
--exec spu_FVFarmD 19, 401,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 월토탈 통계
--exec spu_FVFarmD 19, 401,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130909', '', '', '', '', '', '', '', ''				--
--exec spu_FVFarmD 19, 402,-1, -1, -1, -1, -1, -1, -1, -1, '', '20130909', '', '', '', '', '', '', '', ''				-- 유저 월서브 통계
--exec spu_FVFarmD 19, 404,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 뽑기 광고리스트
--exec spu_FVFarmD 19, 410,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 뽑기리스트
--exec spu_FVFarmD 19, 410,-1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--
--exec spu_FVFarmD 19, 411,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 유저 뽑기월토탈 통계
--exec spu_FVFarmD 19, 411,-1, -1, -1, -1, -1, -1, -1, -1, '', '20131111', '', '', '', '', '', '', '', ''				--
--exec spu_FVFarmD 19, 412,-1, -1, -1, -1, -1, -1, -1, -1, '', '20131111', '', '', '', '', '', '', '', ''				-- 유저 뽑기월서브 통계
--exec spu_FVFarmD 19, 415,-1, -1, -1, -1, -1, -1, -1, -1, '', '20131111', '', '', '', '', '', '', '', ''				-- 뽑기 통계정보.
--exec spu_FVFarmD 19, 413,-1, -1, -1, -1, -1, -1, -1, -1, '', '20131111', '', '', '', '', '', '', '', ''				-- 유저초대정보.
--exec spu_FVFarmD 19, 414, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 무료로고
--exec spu_FVFarmD 19, 414, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''					--
--exec spu_FVFarmD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 블럭리스트
--exec spu_FVFarmD 19, 1001, -1, -1, -1, -1, -1, -1, -1, -1, 'dd23', '', '', '', '', '', '', '', '', ''					--
--exec spu_FVFarmD 19, 1003, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동정보.
--exec spu_FVFarmD 19, 1003, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		   검색.
--exec spu_FVFarmD 19, 1005,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--         삭제.
--exec spu_FVFarmD 19, 1006, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동2정보.
--exec spu_FVFarmD 19, 1006, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 이상행동2정보.
--exec spu_FVFarmD 19, 1006, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		    검색.
--exec spu_FVFarmD 19, 1007,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          삭제.
--exec spu_FVFarmD 19, 1008, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          일괄삭제.
--exec spu_FVFarmD 19, 1004,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 쿠폰리스트.
--exec spu_FVFarmD 19, 1004,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '25026F896F274D9A'		-- 	   세부검색
--exec spu_FVFarmD 19, 1004,  3,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--     지정삭제(미사용한것).
--exec spu_FVFarmD 19, 1004,  4,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--     지정삭제(사용한것).
--exec spu_FVFarmD 19, 1009, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 닉네임 정보.
--exec spu_FVFarmD 19, 1009, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		  검색.
--exec spu_FVFarmD 19, 1010, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 보물강화정보.
--exec spu_FVFarmD 19, 1010, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		    검색.
--exec spu_FVFarmD 19, 1011,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          삭제.
--exec spu_FVFarmD 19, 1012, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          일괄삭제.
--exec spu_FVFarmD 19, 1020, -1, -1, -1, -1,  2, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 회전정보정보.
--exec spu_FVFarmD 19, 1020, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--		    검색.
--exec spu_FVFarmD 19, 1021,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          삭제.
--exec spu_FVFarmD 19, 1022, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				--          일괄삭제.
--exec spu_FVFarmD 19, 1030,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 보물 이상처리 패스
--exec spu_FVFarmD 19, 1031,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 업글 이상처리 패스
--exec spu_FVFarmD 19, 1032,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 회전 이상처리 패스
--exec spu_FVFarmD 19, 2000, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 체험일 초기화.
--exec spu_FVFarmD 19, 2001,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 세이브데이타 삭제.
--exec spu_FVFarmD 19, 2002,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 일일보상 삭제.
--exec spu_FVFarmD 19, 2003, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 지난랭킹 보여주라.
--exec spu_FVFarmD 19, 2004, -1, -1, -1, -1, -1, -1, -1, -1, 'farm63837', '91188455545412242', '', '', '', '', '', '', '', ''--
--exec spu_FVFarmD 19, 2005,  5, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 자기백업에서 복구하기.
--exec spu_FVFarmD 19, 3001,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 무과금, 5만 결정보유
--exec spu_FVFarmD 19, 3001,  2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 무과금, 2만 VIP보유
--exec spu_FVFarmD 19, 3001,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 무과금, 520까지 진화.
--exec spu_FVFarmD 19, 3001,  4, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 과금 4배이상 차이발생.
--exec spu_FVFarmD 19, 3002,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 랭킹대전결과.
--exec spu_FVFarmD 19, 4003, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', 'savedata'		-- 세이브데이타.

--공지사항작성(20)
--exec spu_FVFarmD 20, 0,  5,  0, 101, -1, -1, -1, -1, -1, 'http://m.naver.com', '', '', '', '', '', '', '', '', ''		-- 작성
--exec spu_FVFarmD 20, 1,  5,  0, 101, -1, -1, -1, -1, -1, 'http://m.naver.com', '', '', '', '', '', '', '', '', ''		-- 수정
--exec spu_FVFarmD 20, 2, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 리스트

-- 통계자료(21)
--exec spu_FVFarmD 21, 13,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_FVFarmD 21, 13,-1, -1, -1, -1, -1, -1, -1, -1, '', '201404', '', '', '', '', '', '', '', ''					--

--캐쉬로그삭제
--exec spu_FVFarmD 17, 1,  6, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 검색(단일) > 로그삭제, 차감
--exec spu_FVFarmD 17, 2, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx3', '', '', '', '', '', '', '', '', ''				-- 검색(일괄) > 로그삭제, 차감
--exec spu_FVFarmD 17, 3, 22, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', 'acodedd', '', '', '', '', '', ''		-- 수정

--시스템
--exec spu_FVFarmD 30, 5, -1, -1, -1, -1, -1, -1, -1, -1, '5', '2015-01-01', '2024-01-01', '보물1', '보물2', '보물3', '', '', '1:1;2:80000;3:80001;4:80010;5:80011;6:80012;7:3015;15:1;16:1;17:100;10:1;11:12;12:18;13:23;20:1;21:10;22:100;', '' 			-- 뽑기동물기능 입력
--exec spu_FVFarmD 30, 6,  1, -1, -1, -1, -1, -1, -1, -1, '5', '2015-01-08', '2024-01-08', '보물1', '보물2', '보물3', '', '', '1:1;2:80000;3:80001;4:80010;5:80011;6:80012;7:3015;15:1;16:1;17:100;10:1;11:12;12:18;13:23;20:1;21:10;22:100;', '코멘트수정' -- 수정
--exec spu_FVFarmD 30, 7, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''

--exec spu_FVFarmD 30, 21,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 뽑기상품(아이템리스트, 템리스트) 활성.
--exec spu_FVFarmD 30, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--                                비활성.
--exec spu_FVFarmD 30, 22, -1,500,505,  0,  0,  1,1000,50, '초보시작1', '내용1', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
--exec spu_FVFarmD 30, 23,  7,500,505,  0,  0,  1,1000,50, '초보시작1', '내용1', '1:80001;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
--exec spu_FVFarmD 30, 24, -1, -1, -1, -1, 20, -1, -1, -1, '','', '', '', '', '', '', '', '', ''							-- 일괄할인수정.

--exec spu_FVFarmD 30, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''																				-- Push 카운터(안드로이드와 아이폰은 내부에서 판단함).
--exec spu_FVFarmD 30, 32,    1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''							-- Push 개별.
--exec spu_FVFarmD 30, 32,    3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_FVFarmD 30, 32000, 1, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''							-- Push 리턴값이 없음.
--exec spu_FVFarmD 30, 32000, 3, -1, -1, -1, -1, -1, -1, -1, 'guest90579', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_FVFarmD 30, 33,  1,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목]', '[푸쉬내용]', 'LANUCH', '2013-01-10', '', '', '', ''								-- Push 전체.
--exec spu_FVFarmD 30, 33,  3,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''
--exec spu_FVFarmD 30, 34,  3,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''			-- Push 전체. 짜요 외전 유저에게 푸쉬.
--exec spu_FVFarmD 30, 34,  7,  5, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '[푸쉬제목URL]', '[푸쉬내용URL]', 'http://m.tstore.co.kr', '2013-01-10', '', '', '', ''			-- Push 전체. 짜요 외전 유저에게 푸쉬.
--exec spu_FVFarmD 30, 35,  0, -1, -1, -1, -1, -1, -1, -1, 'blackm', 'blackm', '', '', '', '', '', '', '', ''																	-- Push 삭제.

-- 1일에 이벤트.
--exec spu_FVFarmD 30, 50, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''		--0 시간제 이벤트 정보.
--exec spu_FVFarmD 30, 51, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''		--0 마스터 활성화.
--exec spu_FVFarmD 30, 52,  1, -1,3000, 50, -1, -1, -1, -1, '','', '보낸이름', '1', '12', '17', '', '', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!'	-- 입력.
--exec spu_FVFarmD 30, 52,  2,  1,3001, 51, -1, -1, -1, -1, '','', '보낸이름', '1', '18', '24', '', '', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!' -- 수정
--exec spu_FVFarmD 30, 52,  3,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 상태수정
--exec spu_FVFarmD 30, 52,  4,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 푸쉬수정
--exec spu_FVFarmD 30, 52,  5,  7, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 일일보상 삭제
--exec spu_FVFarmD 30, 53, -1, -1, -1,-1, -1, -1, -1, -1, '','', '', '', '', '', '', '', '', ''			-- 상품받아가는 사람
--exec spu_FVFarmD 30, 53, -1, -1, -1,-1, -1, -1, -1, -1, 'xxxx2','', '', '', '', '', '', '', '', ''	--

-- 선물(27)
--exec spu_FVFarmD 27, 1,  -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물 가능한 리스트(선물하기위해서)
--exec spu_FVFarmD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx2', '', '', '', '', '', '', '', ''				-- 선물 받은 리스트( 전체, 개인)
--exec spu_FVFarmD 27, 2,  -1, -1, -1, -1, -1, -1, -1, -1, '', 'xxxx2', 'SysLogin', '', '', '', '', '', '', ''
--exec spu_FVFarmD 27, 11, 3000, 1, -1, -1, -1, -1, -1, -1, 'adminid', 'xxxx2', '', '', '', '', '', '', '', ''		-- 선물하기
--exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'adminid', '105216735693570841394', '메세지내용', '', '', '', '', '', '', ''		-- 메세지보내기
--exec spu_FVFarmD 27, 21, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 선물, 메세지 삭제
--exec spu_FVFarmD 27, 22, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '',''							-- 선물, 메세지 원복
--exec spu_FVFarmD 27, 23, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--              삭제

--개발용아이템정보(5)
--exec spu_FVFarmD 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--전체
--exec spu_FVFarmD 5, 1,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--특정아이템
--exec spu_FVFarmD 5, 1, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--카테고리
--exec spu_FVFarmD 5, 1, -1, -1,  1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''	--서브카테고리
-----------------------------------------------------------------------------



-- 통계자료(21)
--exec spu_FVFarmD 21, 1, -1,  1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 일별통계
--exec spu_FVFarmD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매로그
--exec spu_FVFarmD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_FVFarmD 21, 11,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_FVFarmD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						--
--exec spu_FVFarmD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, 'farm58', '', '', '', '', '', '', '', '', ''				--
--exec spu_FVFarmD 21, 11, 1, -1, -1, -1, -1, -1, -1, -1, '', '', 'TX_00000000150356', '', '', '', '', '', '', ''		--
--exec spu_FVFarmD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매통계
--exec spu_FVFarmD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '20140409', '', '', '', '', '', '', '', ''				--
--exec spu_FVFarmD 21, 23,  1100, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566741', '', '', '', '', '', '', '' -- 캐쉬구매처리.
--exec spu_FVFarmD 21, 23,  5500, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566742', '', '', '', '', '', '', ''
--exec spu_FVFarmD 21, 23,  9900, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566743', '', '', '', '', '', '', ''
--exec spu_FVFarmD 21, 23, 33000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566744', '', '', '', '', '', '', ''
--exec spu_FVFarmD 21, 23, 55000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566745', '', '', '', '', '', '', ''
--exec spu_FVFarmD 21, 23, 99000, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'adminid', '12999763169054705758.1313833651566746', '', '', '', '', '', '', ''
--exec spu_FVFarmD 21, 31, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''



IF OBJECT_ID ( 'dbo.spu_FVFarmD', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFarmD;
GO

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_FVFarmD
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
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50	-- 아이템코드못찾음

	------------------------------------------------
	--	프로시져 종류
	------------------------------------------------
	declare @KIND_USER_SEARCH					int				set @KIND_USER_SEARCH					= 7
	declare @KIND_NOTICE_SETTING				int				set @KIND_NOTICE_SETTING				= 20
	declare @KIND_USER_SETTING					int				set @KIND_USER_SETTING					= 19
	declare @KIND_STATISTICS_INFO				int				set @KIND_STATISTICS_INFO				= 21
	declare @KIND_USER_CASH_LOG_DELETE			int				set @KIND_USER_CASH_LOG_DELETE			= 17
	declare @KIND_ADMIN_LOGIN					int				set @KIND_ADMIN_LOGIN					= 25
	declare @KIND_SYSTEMINFO_SETTING			int				set @KIND_SYSTEMINFO_SETTING			= 30
	declare @KIND_USER_GIFT						int				set @KIND_USER_GIFT						= 27
	declare @KIND_SEARCH_ITEMINFO				int				set @KIND_SEARCH_ITEMINFO				= 5

	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 체킹
	declare @INFOMATION_NO						int					set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int					set @INFOMATION_YES					=  1

	-- 통신사 구분값
	declare @SKT 							int					set @SKT						= 1
	declare @KT 							int					set @KT							= 2
	declare @LGT 							int					set @LGT						= 3
	declare @GOOGLE 						int					set @GOOGLE						= 5
	declare @NHN	 						int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7

	-- 선물 관련 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	------------------------------------------------
	--	일반변수선언
	------------------------------------------------
	declare @kind			int				set @kind			= @p1_
	declare @subkind		int				set @subkind		= @p2_
	declare @idx 			int				set @idx 			= @p3_
	declare @itemcode		int				set @itemcode		= @p4_
	declare @grade			int
	declare @idx2 			int
	declare @blockstate		int

	declare @gameid			varchar(60)		set @gameid			= @ps1_
	declare @password		varchar(20)
	declare @adminid		varchar(1024)	set @adminid 		= @ps2_
	declare @adminip		varchar(1024)	set @adminip 		= @ps3_
	declare @message		varchar(2048)	set @message		= @ps10_
	declare @phone			varchar(20)

	declare @comment		varchar(2048)
	declare @comment4		varchar(4096)

	declare @dateid 		varchar(8)
	declare @dateid6 		varchar(6)		set @dateid6 		= Convert(varchar(6),Getdate(),112)
	declare @dateid8 		varchar(8)
	declare @dateid16 		varchar(16) 	set @dateid16 		= Convert(varchar(16), Getdate(),120)

	declare @syscheck		int
	declare @market			int				set @market = 1
	declare @version		int
	declare @questkind		int
	declare @iteminfover	int
	declare @iteminfourl	varchar(512)

	declare @maxPage		int				set @maxPage = 1
	declare @idxPage		int				set @idxPage = 1
	declare @cnt			int
	declare @cnt2			int
	declare @cnt3			int
	declare @cnt4			int

	declare @category		int
	declare @subcategory	int

	declare @nResult		int				set @nResult = @RESULT_SUCCESS
	declare @str			varchar(40)
	declare @str2			varchar(40)
	declare @val			int
	declare @val2			int
	declare @cash			int

	-- 유저문의.
	declare @PAGE_LINE10	int						set @PAGE_LINE10	= 10
	declare @PAGE_LINE20	int						set @PAGE_LINE20	= 20
	declare @PAGE_LINE50	int						set @PAGE_LINE50	= 50
	declare @PAGE_LINE		int						set @PAGE_LINE		= 100
	declare @page			int						set @page			= 1
	declare @PAGE_CASH_LIST	int						set @PAGE_CASH_LIST	= 25

	-- 관리자 과금입력.
	declare @acode			varchar(256)
	declare @ucode			varchar(256)
	declare @cashkind		int

	-- push
	declare @recepushid		varchar(1024)

	-- 이벤트처리.
	declare @eventsender	varchar(20)
	declare @eventpushtitle	varchar(256)
	declare @eventpushmsg	varchar(256)
	declare @eventstatedaily	int
	declare @eventcnt		int
	declare @eventday		int
	declare @eventstarthour	int
	declare @eventendhour	int

	-- 뽑기처리.
	declare @packkind 		int,
			@packvalue 		int
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

	declare @roulmarket			varchar(40)			set @roulmarket 	= '1,2,3,4,5,6,7'
	declare @roulflag			int					set @roulflag		= -1
	declare @roulstart			datetime			set @roulstart 		= '2014-01-01'
	declare @roulend			datetime			set @roulend 		= '2024-01-01'
	declare @roulani1			int					set @roulani1		= -1
	declare @roulani2			int					set @roulani2 		= -1
	declare @roulani3			int					set @roulani3 		= -1
	declare @roulreward1		int					set @roulreward1	= -1
	declare @roulreward2		int					set @roulreward2 	= -1
	declare @roulreward3		int					set @roulreward3 	= -1
	declare @roulrewardcnt1		int					set @roulrewardcnt1	= -1
	declare @roulrewardcnt2		int					set @roulrewardcnt2 = -1
	declare @roulrewardcnt3		int					set @roulrewardcnt3 = -1
	declare @roulname1			varchar(20)			set @roulname1 		= ''
	declare @roulname2			varchar(20)			set @roulname2 		= ''
	declare @roulname3			varchar(20)			set @roulname3 		= ''

	declare @roultimeflag		int					set @roultimeflag 	= -1
	declare @roultimetime1		int					set @roultimetime1 	= -1
	declare @roultimetime2		int					set @roultimetime2 	= -1
	declare @roultimetime3		int					set @roultimetime3 	= -1
	declare @roultimetime4		int					set @roultimetime4 	= -1

	declare @roulsaleflag		int					set @roulsaleflag 	= -1
	declare @roulsalevalue		int					set @roulsalevalue 	= 0

	declare @pmgauageflag		int					set @pmgauageflag 	= -1
	declare @pmgauagepoint		int					set @pmgauagepoint	= 10
	declare @pmgauagemax		int					set @pmgauagemax 	= 100

	-- 보물강화할인.
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- 룰렛(회전판)무료뽑기.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1
	declare @wheelgauagepoint		int				set @wheelgauagepoint	= 10
	declare @wheelgauagemax			int				set @wheelgauagemax		= 100
Begin
	------------------------------------------------
	--	초기화
	------------------------------------------------
	set nocount on

	-----------------------------------------------------
	--	유저로그
	-----------------------------------------------------
	if(@kind in (@KIND_USER_SEARCH))
		begin
			if(isnull(@ps2_, '') != '')
				begin
					select top 100 * from dbo.tFVUserMaster where phone = @ps2_ order by idx desc
				end
			else if(isnull(@ps3_, '') != '')
				begin
					select top 100 * from dbo.tFVUserMaster where kakaouserid = @ps3_ order by idx desc
				end
			else if(isnull(@ps4_, '') != '')
				begin
					select top 100 *, 1 maxPage from dbo.tFVUserMaster where nickname = @ps4_ order by idx desc
				end
			else if(isnull(@gameid, '') = '')
				begin
					select @idx = max(idx) from dbo.tFVUserMaster
					set @maxPage = (@idx - 1) / 10
					set @idxPage = @p10_
					if(@idxPage > @maxPage)
						begin
							set @idxPage = @maxPage
						end
					set @idxPage = @idx - (@idxPage - 1) * 10

					if(@idxPage = -1)
						begin
							select top 10 *, @maxPage maxPage from dbo.tFVUserMaster                       order by idx desc
						end
					else
						begin
							select top 10 *, @maxPage maxPage from dbo.tFVUserMaster where idx <= @idxPage order by idx desc
						end
				end
			else
				begin
					-----------------------------------------
					-- 유저정보
					-----------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid order by idx desc

					-----------------------------------------
					-- 카톡정보.
					-----------------------------------------
					select * from dbo.tFVKakaoMaster
					where kakaouserid = (select top 1 kakaouserid from dbo.tFVUserMaster where gameid = @gameid)

					-----------------------------------------------
					---- 캐쉬로그, 환전
					-----------------------------------------------
					select top 10 * from dbo.tFVCashLog
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 선물리스트
					---------------------------------------------
					select a.idx idxt, a.idx2 idx2, gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
					from (select top 20 * from dbo.tFVGiftList where gameid = @gameid order by idx desc) a
						LEFT JOIN
						dbo.tFVItemInfo b
						ON a.itemcode = b.itemcode
					order by idxt desc

					-----------------------------------------------
					---- 보물뽑기 로고.
					-----------------------------------------------
					select top 10 * from dbo.tFVRouletteLogPerson
					where gameid = @gameid
					order by idx desc

					-----------------------------------------------
					---- 보물뽑기 로고.
					-----------------------------------------------
					select top 10 * from dbo.tFVUserUpgradeLog
					where gameid = @gameid
					order by idx2 desc

					-----------------------------------------------
					---- 보물뽑기 로고.
					-----------------------------------------------
					select top 10 * from dbo.tFVUserWheelLog
					where gameid = @gameid
					order by idx2 desc

					-----------------------------------------------
					--	사용쿠폰
					-----------------------------------------------
					select * from dbo.tFVEventCertNoBack
					where gameid = @gameid

					-----------------------------------------------
					---- 박스보상.
					-----------------------------------------------
					select top 10 * from dbo.tFVLevelUpReward
					where gameid = @gameid
					order by idx desc

					-----------------------------------------------
					--	저장정보
					-----------------------------------------------
					select * from dbo.tFVUserData
					where gameid = @gameid

					---------------------------------------------
					-- 비정상행동
					---------------------------------------------
					select top 10 * from dbo.tFVUserUnusualLog
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 비정상행동
					---------------------------------------------
					select top 10 * from dbo.tFVUserUnusualLog2
					where gameid = @gameid
					order by idx desc

					---------------------------------------------
					-- 유저블럭킹
					---------------------------------------------
					select top 10 * from dbo.tFVUserBlockLog
					where gameid = @gameid
					order by idx desc


					-----------------------------------------------
					---- 유저친구
					-----------------------------------------------
					select f.*, m.nickname from
							(select * from dbo.tFVUserFriend where gameid = @gameid) f
						JOIN
							(select gameid, nickname from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid)) m
							ON f.friendid = m.gameid
					order by state desc, familiar desc

					-----------------------------------------------
					---- 카톡초대친구
					-----------------------------------------------
					--select count(*) cnt from dbo.tFVKakaoInvite where gameid = @gameid
					select top 10 * from dbo.tFVKakaoInvite
					where gameid = @gameid
					order by idx desc


					-----------------------------------------------
					---- 무료충전
					-----------------------------------------------
					select top 10 * from dbo.tFVFreeCashLog
					where gameid = @gameid
					order by idx desc

					-----------------------------------------------
					---- 추천게임보상.
					-----------------------------------------------
					select top 10 * from dbo.tFVSysRecommendLog
					where gameid = @gameid
					order by idx desc

					-----------------------------------------------
					--	저장정보
					-----------------------------------------------
					select * from dbo.tFVUserDataBackup
					where gameid = @gameid
					order by idx2 desc
				end
		end

	else if(@kind = @KIND_USER_SETTING)
		begin
			set @gameid		= @ps1_

			if(@p2_ = 1)
				begin
					-------------------------------------
					-- 아이디 > 블럭기록
					-------------------------------------
					select @blockstate = blockstate, @phone = phone from dbo.tFVUserMaster where gameid = @gameid

					if(@blockstate = @BLOCK_STATE_NO)
						begin
							update dbo.tFVUserMaster
								set
									blockstate 	= @BLOCK_STATE_YES,
									@blockstate = @BLOCK_STATE_YES
							 where gameid = @gameid
						end
					else
						begin

							update dbo.tFVUserMaster
								set
									blockstate 	= @BLOCK_STATE_NO,
									@blockstate = @BLOCK_STATE_NO
							 where gameid = @gameid
						end

					if(@blockstate = @BLOCK_STATE_YES)
						begin
							if(not exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone))
								begin
									-- 블럭정보
									insert into dbo.tFVUserBlockPhone(phone, comment)
									values(@phone, '관리자(' + @ps2_ + ')가 직접 블럭 처리했습니다.')
								end
						end
					else
						begin
							-- 블럭해제
							delete from dbo.tFVUserBlockPhone where phone = @phone
						end

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 2)
				begin
					delete from dbo.tFVUserMaster where gameid = @gameid
					delete from dbo.tFVUserFriend where gameid = @gameid
					delete from dbo.tFVUserBlockLog where gameid = @gameid
					delete from dbo.tFVUserUnusualLog where gameid = @gameid
					delete from dbo.tFVUserUnusualLog2 where gameid = @gameid
					delete from dbo.tFVUserBlockLog where gameid = @gameid
					delete from dbo.tFVGiftList where gameid = @gameid
					delete from dbo.tFVCashLog where gameid = @gameid
					delete from dbo.tFVEventCertNoBack where gameid = @gameid
					delete from dbo.tFVKakaoInvite where gameid = @gameid


					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  3)
				begin
					-------------------------------------
					-- 블럭해제
					-------------------------------------
					update dbo.tFVUserMaster
						set
							blockstate = @BLOCK_STATE_NO
					where gameid = @gameid

					update dbo.tFVUserBlockLog
						set
							blockstate = @BLOCK_STATE_NO,
							adminid = @ps2_,
							adminip = @ps3_,
							comment2 = '해제',
							releasedate = getdate()
					where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  4)
				begin
					-------------------------------------
					-- 블럭해제
					-------------------------------------
					update dbo.tFVUserMaster
						set
							kkopushallow	= case
													when kkopushallow = @INFOMATION_NO then @INFOMATION_YES
													else									@INFOMATION_NO
											  end
					where gameid = @gameid

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 21)
				begin
					select top 100 * from dbo.tFVUserBlockPhone order by idx desc
				end
			else if(@p2_ = 22)
				begin
					if(not exists(select top 1   * from dbo.tFVUserBlockPhone where phone = @ps3_))
						begin
							insert into dbo.tFVUserBlockPhone(phone, comment) values(@ps3_, @ps10_)
						end

					select 1 rtn
				end
			else if(@p2_ = 23)
				begin
					if(exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @ps3_))
						begin
							delete from dbo.tFVUserBlockPhone where phone = @ps3_
						end

					select 1 rtn
				end
			else if(@p2_ = 24)
				begin
					select top 100 * from dbo.tFVPushBlackList order by idx desc
				end
			else if(@p2_ = 25)
				begin
					if(not exists(select top 1   * from dbo.tFVPushBlackList where phone = @ps3_))
						begin
							insert into dbo.tFVPushBlackList(phone, comment) values(@ps3_, @ps10_)
						end

					select 1 rtn
				end
			else if(@p2_ = 26)
				begin
					delete from dbo.tFVPushBlackList where phone = @ps3_
					select 1 rtn
				end

			else if(@p2_ =  1001)
				begin
					--------------------------------------------
					-- 블럭로그가 존재하면 > 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							select top 100 * from dbo.tFVUserBlockLog order by idx desc
						end
					else
						begin
							select top 100 * from dbo.tFVUserBlockLog where gameid = @gameid order by idx desc

							select * from dbo.tFVUserUnusualLog where gameid = @gameid order by idx desc
						end
				end
			else if(@p2_ =  1003)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVUserUnusualLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUnusualLog
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUnusualLog
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1005)
				begin
					delete from dbo.tFVUserUnusualLog where gameid = @gameid and idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1006)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVUserUnusualLog2

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUnusualLog2
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUnusualLog2
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1007)
				begin
					delete from dbo.tFVUserUnusualLog2 where gameid = @gameid and idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1008)
				begin
					delete from dbo.tFVUserUnusualLog2 where gameid = @gameid

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1009)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVUserNickNameChange

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserNickNameChange
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserNickNameChange
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1010)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVUserUpgradeLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUpgradeLog
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserUpgradeLog
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1011)
				begin
					delete from dbo.tFVUserUpgradeLog where gameid = @gameid and idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1012)
				begin
					delete from dbo.tFVUserUpgradeLog where gameid = @gameid

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1020)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVUserWheelLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserWheelLog
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVUserWheelLog
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1021)
				begin
					delete from dbo.tFVUserWheelLog where gameid = @gameid and idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1022)
				begin
					delete from dbo.tFVUserWheelLog where gameid = @gameid

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1023)
				begin
					--------------------------------------------
					-- 상세하기
					--------------------------------------------
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVLevelUpReward

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVLevelUpReward
							where idx <= @idx order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, * from dbo.tFVLevelUpReward
							where gameid = @gameid
							order by idx desc
						end
				end
			else if(@p2_ =  1030)
				begin
					update dbo.tFVRouletteLogPerson set strange = -2 where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1031)
				begin
					update dbo.tFVUserUpgradeLog set strange = -2 where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ =  1032)
				begin
					update dbo.tFVUserWheelLog set strange = -2 where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 64)
				begin
					if(@p3_ = 2)
						begin
							set @comment = '  일일출석 카운터 +=1'
							update dbo.tFVUserMaster
								set attendcnt  = attendcnt + CASE WHEN (attendcnt + 1 > 30) then 0 else 1 end
							where gameid = @gameid

							select 1 rtn
						end
					else if(@p3_ = 3)
						begin
							set @comment = '  친구하트선물  날짜 -1 일전으로 이동'
							update dbo.tFVUserFriend set senddate  = senddate - 1 where gameid = @ps1_ and friendid = @ps2_

							select 1 rtn
						end
					else if(@p3_ = 6)
						begin
							set @comment = '  접속일 -30갱신'
							update dbo.tFVUserMaster set condate  = condate + @p4_ where gameid = @gameid

							select 1 rtn
						end
					else if(@p3_ = 31)
						begin
							set @comment = '  광고리스트 번호 클리어.'
							update dbo.tFVUserMaster set adidx  = 0 where gameid = @ps1_

							select 1 rtn
						end
					else if(@p3_ = 41)
						begin
							set @comment = '  카톡 재가입 시간 클리어.'

							update dbo.tFVKakaoMaster set deldate  = deldate - 1 where idx = @p4_

							select 1 rtn
						end
					else if(@p3_ = 42)
						begin
							set @comment = '  카톡 계정 재연결.'
							--select 'DEBUG ', @gameid gameid, @ps3_ ps3_
							if(exists(select top 1 * from dbo.tFVKakaoMaster where kakaouserid = @ps3_)
								and exists(select top 1 * from dbo.tFVUserMaster where gameid = @gameid and kakaouserid = @ps3_))
									begin
										--select 'DEBUG 계정재연결'
										update dbo.tFVKakaoMaster set gameid = @gameid where kakaouserid = @ps3_
									end

							select 1 rtn
						end
					else if(@p3_ = 43)
						begin
							set @comment = '  카톡 계정 끊어주기..'
							--select 'DEBUG ', @gameid gameid, @ps3_ ps3_
							if(exists(select top 1 * from dbo.tFVKakaoMaster where kakaouserid = @ps3_)
								and exists(select top 1 * from dbo.tFVUserMaster where gameid = @gameid and kakaouserid = @ps3_))
									begin
										--select 'DEBUG 계정재연결'
										update dbo.tFVKakaoMaster set gameid = '' where kakaouserid = @ps3_
									end

							select 1 rtn
						end
					else if(@p3_ = 60)
						begin
							update dbo.tFVUserMaster set heartget = @p4_ where gameid = @gameid

							select 1 rtn
						end
					else if(@p3_ = 61)
						begin
							update dbo.tFVUserMaster set heartcnt = @p4_ where gameid = @gameid

							select 1 rtn
						end
					else if(@p3_ = 62)
						begin
							update dbo.tFVUserMaster set heartdate = '20100101' where gameid = @gameid

							select 1 rtn
						end
					else if(@p3_ in (110, 111, 112,
									 120, 121, 122,
									 130, 131, 132, 133,
									 140, 141, 142, 143 ))
						begin
							update dbo.tFVUserMaster
								set
									roulfreetimetotal 	= case when @p3_ = 110 then 0 else roulfreetimetotal end,
									roulfreetimedate 	= case when @p3_ = 111 then '20010101' else roulfreetimedate end,
									roulfreetimehour  	= case when @p3_ = 112 then 0 else roulfreetimehour end,

									roulfreehearttotal 	= case when @p3_ = 120 then 0 else roulfreehearttotal end,
									roulfreeheartdate 	= case when @p3_ = 121 then '20010101' else roulfreeheartdate end,
									roulfreeheartcnt  	= case when @p3_ = 122 then 0 else roulfreeheartcnt end,

									roulcashcosttotal 	= case when @p3_ = 130 then 0 else roulcashcosttotal end,
									roulcashcostgauage 	= case when @p3_ = 131 then 100 else roulcashcostgauage end,
									roulcashcostfree  	= case when @p3_ = 132 then 1 else roulcashcostfree end,
									roulcashcostfreetotal= case when @p3_ = 133 then 0 else roulcashcostfreetotal end,

									roulcashcost2total 	= case when @p3_ = 140 then 0 else roulcashcost2total end,
									roulcashcost2gauage = case when @p3_ = 141 then 100 else roulcashcost2gauage end,
									roulcashcost2free  	= case when @p3_ = 142 then 1 else roulcashcost2free end,
									roulcashcost2freetotal= case when @p3_ = 143 then 0 else roulcashcost2freetotal end
							where gameid = @gameid

							select 1 rtn
						end
				end
			else if(@p2_ = 88)
				begin
					if(@p3_ = 1)
						begin
							set @p4_ = case when @p4_ < 0 then 0 else @p4_ end
							update dbo.tFVUserMaster set kakaomsginvitecnt = @p4_ where gameid = @gameid
						end
					else if(@p3_ = 2)
						begin
							update dbo.tFVKakaoInvite set senddate = senddate - 31 where idx = @p4_
						end
					else if(@p3_ = 3)
						begin
							delete from dbo.tFVKakaoInvite where idx = @p4_
						end
					else if(@p3_ = 4)
						begin
							update dbo.tFVUserFriend set helpdate = helpdate - 10 where idx = @p4_
						end
					else if(@p3_ = 6)
						begin
							update dbo.tKakaoHelpWait set helpdate = helpdate - 10 where idx = @p4_
						end
					else if(@p3_ = 7)
						begin
							delete from dbo.tKakaoHelpWait where idx = @p4_
						end
					else if(@p3_ = 8)
						begin
							set @p4_ = case when @p4_ < 0 then 0 else @p4_ end
							update dbo.tFVUserMaster set kakaomsginvitetodaycnt = @p4_ where gameid = @gameid
						end
					else if(@p3_ = 9)
						begin
							update dbo.tFVUserMaster set kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 where gameid = @gameid
						end
					else if(@p3_ = 10)
						begin
							update dbo.tFVUserMaster set kakaomsgblocked = case when kakaomsgblocked = 1 then -1 else 1 end where gameid = @gameid
						end
					else if(@p3_ = 11)
						begin
							update dbo.tFVUserFriend set rentdate = rentdate - 10 where idx = @p4_
						end
					else if(@p3_ = 12)
						begin
							update dbo.tFVUserMaster set kakaostatus = case when (kakaostatus = -1) then 1 else -1 end where gameid = @gameid
						end
					else if(@p3_ = 13)
						begin
							update dbo.tFVUserMaster set cashcopy = 0 where gameid = @gameid
						end
					else if(@p3_ = 14)
						begin
							update dbo.tFVUserMaster set resultcopy = 0 where gameid = @gameid
						end
					else if(@p3_ = 15)
						begin
							update dbo.tFVUserMaster set kkhelpalivecnt = kkhelpalivecnt + 1 where gameid = @gameid
						end
					else if(@p3_ = 16)
						begin
							update dbo.tFVUserMaster set bestdealer = @p4_ where gameid = @gameid
						end
					else if(@p3_ = 17)
						begin
							update dbo.tFVUserMaster set bestdealer = 0 where gameid = @gameid
						end
					else if(@p3_ = 18)
						begin
							update dbo.tFVUserMaster set wheeldayfree = case when wheeldayfree = 1 then -1 else 1 end where gameid = @gameid

							update dbo.tFVUserMaster set logindate = '20010101' where gameid = @gameid
						end
					else if(@p3_ = 19)
						begin
							update dbo.tFVUserMaster set wheelgauage = 100 where gameid = @gameid
						end
					else if(@p3_ = 20)
						begin
							update dbo.tFVUserMaster set wheelfree = 1 where gameid = @gameid
						end
					else if(@p3_ = 21)
						begin
							update dbo.tFVUserMaster
								set
									cashdatestart = cashdatestart -1,
									cashdateend = cashdateend - 1,
									cashdatecur = cashdatecur - 1
							where gameid = @gameid
						end
					else if(@p3_ = 22)
						begin
							update dbo.tFVUserMaster set cashdatestart = '20010101', cashdateend = '20010101', cashdatecur = '20010101' where gameid = @gameid
						end
					else if(@p3_ = 23)
						begin
							delete from dbo.tFVSysRecommendLog where gameid = @gameid and idx = @p4_
						end
					else if(@p3_ = 24)
						begin
							delete from dbo.tFVLevelUpReward where gameid = @gameid and idx = @p4_
						end

					select 1 rtn
				end
			else if(@p2_ = 94)
				begin
					select m.*, d.savedata from
						(select top 500 rank() over(order by bestdealer desc) as rank, * from dbo.tFVUserMaster) m
					JOIN
						dbo.tFVUserData d
						ON m.gameid = d.gameid
					order by bestdealer desc
				end
			else if(@p2_ = 95)
				begin
					select top 50 * from dbo.tFVUserRankMaster order by dateid desc
				end
			else if(@p2_ = 96)
				begin
					select * from dbo.tFVUserRankSub where dateid8 = @ps3_
				end
			else if(@p2_ = 97)
				begin
					update dbo.tFVUserMaster set logwrite2 =  case when (logwrite2 = 1) then -1 else 1 end where gameid = @gameid
					select 1 rtn
				end
			else if(@p2_ = 401)
				begin
					-- 유저 월토탈 통계
					if(isnull(@ps2_, '') = '')
						begin
							select top 300 * from dbo.tFVUserItemBuyLogTotalMaster order by dateid8 desc
						end
					else
						begin
							select top 300 * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = @ps2_ order by dateid8 desc
						end
				end
			else if(@p2_ = 402)
				begin
					-- 유저 월서브 통계
					set @ps2_ = isnull(@ps2_, '')

					select top 500 a.idx 'idx',
						dateid8,
						a.itemcode 'itemcode', b.itemname,
						a.gamecost 'gamecost', a.cashcost 'cashcost', a.heart heart,
						a.cnt
					from dbo.tFVUserItemBuyLogTotalSub a join dbo.tFVItemInfo b on a.itemcode = b.itemcode
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
						a.gamecost 'gamecost', a.cashcost 'cashcost', a.heart heart,
						a.cnt
					from dbo.tFVUserItemBuyLogMonth a join dbo.tFVItemInfo b on a.itemcode = b.itemcode
					where dateid6 = @ps2_
					order by a.cashcost desc, a.gamecost desc
				end
			else if(@p2_ = 404)
				begin
					-- 뽑기 광고리스트
					select top 300 * from dbo.tFVUserAdLog
					order by idx desc
				end
			-----------------------------------
			-- 유저 구매리스트, 토탈, 세부, 월별
			-----------------------------------
			else if(@p2_ = 410)
				begin
					-- 유저 구매리스트
					if(isnull(@ps1_, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVRouletteLogPerson

							set @maxPage	= @idx / @PAGE_LINE50
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE50 != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE50

							select top 50 @maxPage maxPage, @page page, * from dbo.tFVRouletteLogPerson
							where idx <= @idx order by idx desc
							--select top 300 * from dbo.tFVRouletteLogPerson order by idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1
							select top 500 @maxPage maxPage, @page page, * from dbo.tFVRouletteLogPerson where gameid = @ps1_ order by idx desc
						end
				end
			else if(@p2_ = 411)
				begin
					-- 유저 월토탈 통계
					if(isnull(@ps2_, '') = '')
						begin
							select top 300 * from dbo.tFVRouletteLogTotalMaster order by dateid8 desc
						end
					else
						begin
							select top 300 * from dbo.tFVRouletteLogTotalMaster where dateid8 = @ps2_ order by dateid8 desc
						end
				end

			else if(@p2_ = 412)
				begin
					select top 100 * from dbo.tFVRouletteLogTotalSub
					where dateid8 = @ps2_
					order by itemcode desc, roulfreehearttotal desc, roulcashcosttotal desc
				end
			else if(@p2_ = 415)
				begin
					if(@p3_ = 1)
						begin
							select * from dbo.tFVRouletteLogTotalSub
							order by itemcode desc, roulfreehearttotal desc, roulcashcosttotal desc
						end
					else if(@p3_ = 11)
						begin
							select itemcode, itemcodename, SUM(roulfreetimetotal + roulfreehearttotal + roulcashcosttotal + roulcashcost2total) cnt from dbo.tFVRouletteLogTotalSub
							group by itemcode, itemcodename
							order by itemcode desc, cnt desc
						end
					else if(@p3_ = 12)
						begin
							select itemcode, itemcodename, SUM(roulfreetimetotal + roulfreehearttotal + roulcashcosttotal + roulcashcost2total) cnt from dbo.tFVRouletteLogTotalSub
							group by itemcode, itemcodename
							order by cnt desc, itemcode desc
						end
				end
			else if(@p2_ = 413)
				begin
					-- 유저 친구초대정보
					if(isnull(@ps1_, '') = '')
						begin
							select top 300 * from dbo.tFVKakaoInvite order by idx desc
						end
					else
						begin
							select top 300 * from dbo.tFVKakaoInvite where gameid = @ps1_ order by idx desc
						end
				end
			else if(@p2_ = 414)
				begin
					-- 무료로고.
					if(isnull(@ps1_, '') = '')
						begin
							select top 300 * from dbo.tFVFreeCashLog order by idx desc
						end
					else
						begin
							select top 300 * from dbo.tFVFreeCashLog where gameid = @ps1_ order by idx desc
						end
				end
			else if(@p2_ =  1004)
				begin
					if(@p3_ = 1)
						begin
							-- 쿠폰정보
							set @p4_ = case when @p4_ = -1 then 1 else @p4_ end
							select top 100 * from dbo.tFVEventCertNo where kind = @p4_ order by idx asc
						end
					else if(@p3_ = 2)
						begin
							-- 쿠폰정보
							select top 100 * from dbo.tFVEventCertNo where certno = @ps10_ order by idx asc

							select top 100 * from dbo.tFVEventCertNoBack where certno = @ps10_ order by idx asc
						end
					else if(@p3_ = 3)
						begin
							delete from dbo.tFVEventCertNo where idx = @p4_

							select 1 rtn
						end
					else if(@p3_ = 4)
						begin
							delete from dbo.tFVEventCertNoBack where idx = @p4_

							select 1 rtn
						end
				end
			else if(@p2_ = 2000)
				begin
					update dbo.tFVUserMaster set logindate = '20010101' where gameid = @gameid

					select 1 rtn
				end
			else if(@p2_ = 2001)
				begin
					delete from dbo.tFVUserData where idx = @p3_

					select 1 rtn
				end
			else if(@p2_ = 2003)
				begin
					update dbo.tFVUserMaster set rankresult = 1 where gameid = @gameid

					select 1 rtn
				end
			else if(@p2_ = 2004)
				begin
					select @comment4 = savedata from dbo.tFVUserData where gameid = @ps1_
					--select @comment4, gameid from dbo.tFVKakaoMaster where kakaouserid = @ps2_

					update dbo.tFVUserData set savedata = @comment4 where gameid = (select gameid from dbo.tFVKakaoMaster where kakaouserid = @ps2_)

					select 1 rtn
				end
			else if(@p2_ = 2005)
				begin
					set @comment4 = ''
					select @comment4 = savedata, @gameid = gameid from dbo.tFVUserDataBackup where idx = @p3_

					update dbo.tFVUserData
						set
							savedata = @comment4
					where gameid = @gameid

					select 1 rtn
				end
			else if(@p2_ = 3001)
				begin
					if(@p3_ = 1)
						begin
							-- 무과금, 5만 결정보유
							select * from dbo.tFVUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and cashcost2 >= 50000
						end
					else if(@p3_ = 2)
						begin
							-- 무과금, 2만 VIP보유
							select * from dbo.tFVUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and vippoint2 >= 20000
						end
					else if(@p3_ = 3)
						begin
							-- 무과금 520까지 진화.
							select * from dbo.tFVUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and bestani >= 520
						end
					else if(@p3_ = 4)
						begin
							-- 과금 4배이상 차이발생.
							select * from dbo.tFVUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint > 0 and cashpoint*4 < cashcost2
						end
					else if(@p3_ = 5)
						begin
							-- 113이하 버젼에서 보석보유자.
							select * from dbo.tFVUserData where (savedata like '%80000%' or savedata like '%80008%')
						end
				end
			else if(@p2_ = 3002)
				begin
					if(@p3_ = 1)
						begin
							select top 50 * from dbo.tFVRankDaJun order by rkdateid8 desc
						end
				end
			else if(@p2_ = 4003)
				begin
					update dbo.tFVUserData
						set
							savedata = @ps10_
					where gameid = @ps1_

					select 1 rtn
				end
		end

	-----------------------------------------------------
	--	통계자료
	-----------------------------------------------------
	else if(@kind = @KIND_STATISTICS_INFO)
		begin
			set @dateid = @ps2_

			if(@p2_	= 1)
				begin
					--select top 50 * from dbo.tFVDayLogInfoStatic
					--order by dateid8 desc, market asc, idx desc

					-- 읽기.
					set @idxPage	= @p4_
					select @idx = (isnull(max(idx), 1)) from dbo.tFVDayLogInfoStatic

					set @maxPage	= @idx / @PAGE_LINE50
					set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE50 != 0) then 1 else 0 end
					set @page		= case
										when (@idxPage <= 0)			then 1
										when (@idxPage >  @maxPage)	then @maxPage
										else @idxPage
									end
					set @idx		= @idx - (@page - 1) * @PAGE_LINE50

					select top 50 @maxPage maxPage, @page page, * from dbo.tFVDayLogInfoStatic
					where idx <= @idx
					order by dateid8 desc, market asc, idx desc

				end
			else if(@p2_ = 11)
				begin
					-- 유저구매로그
					select @idx = max(idx) from dbo.tFVCashLog
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
							select top 1 *, @maxPage maxPage from dbo.tFVCashLog where acode = @ps3_ order by idx desc
						end
					else if(isnull(@gameid, '') != '')
						begin
							--select 'DEBUG 2'
							if(@idxPage = -1)
								begin
									select *, @maxPage maxPage from dbo.tFVCashLog where gameid = @gameid order by idx desc
								end
							else
								begin
									select *, @maxPage maxPage from dbo.tFVCashLog where gameid = @gameid and idx <= @idxPage order by idx desc
								end
						end
					else
						begin
							--select 'DEBUG 3'
							if(@idxPage = -1)
								begin
									select top 25 *, @maxPage maxPage from dbo.tFVCashLog order by idx desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage from dbo.tFVCashLog where idx <= @idxPage order by idx desc
								end
						end
				end
			else if(@p2_ = 12)
				begin
					select @idx = max(idx) from dbo.tFVCashTotal
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
									select top 25 *, @maxPage maxPage  from dbo.tFVCashTotal                                         order by dateid desc, market asc, cashkind desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage  from dbo.tFVCashTotal where                     idx <= @idx2  order by dateid desc, market asc, cashkind desc
								end
						end
					else
						begin
							if(@idxPage = -1)
								begin
									select top 25 *, @maxPage maxPage  from dbo.tFVCashTotal where dateid = @dateid                  order by dateid desc, market asc, cashkind desc
								end
							else
								begin
									select top 25 *, @maxPage maxPage  from dbo.tFVCashTotal where dateid = @dateid and idx <= @idx2 order by dateid desc, market asc, cashkind desc
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
					select dateid, market, sum(cashcost) cashcost, sum(cash) cash, count(*) cnt from dbo.tFVCashTotal where dateid like @dateid group by dateid, market order by dateid desc
				end
			else if(@p2_ = 23)
				begin
					set @gameid 	= @ps1_
					set @acode 		= @ps3_
					set @password 	= ''
					select
						@gameid 	= gameid,
						@password 	= password
					from dbo.tFVUserMaster where gameid = @gameid

					if(@gameid = '' or @password = '')
						begin
							select @RESULT_ERROR 'rtn', '계정이 존재하지 않습니다.'
						end
					else if(@acode = '')
						begin
							select @RESULT_ERROR 'rtn', '영수증 번호가 없습니다.'
						end
					else if(exists(select top 1 * from dbo.tFVCashLog where acode = @acode))
						begin
							select @RESULT_ERROR 'rtn', '코드가 중복됩니다.(acode)'
						end
					else
						begin
							--내부에서 또 리턴해준다.
							--set @comment = ('강제로 캐쉬지급 ' + ltrim(rtrim(str(@p3_))) + ' 아이템코드')
							--exec spu_AdminAction @adminid, @gameid, @comment

							exec spu_FVCashBuy3Admin @gameid, @password, '',      @p3_, @acode, -1
						end
				end
			else if(@p2_ = 31)
				begin
					select top 50 * from dbo.tFVUserMasterSchedule order by idx desc
				end
		end

	-----------------------------------------------------
	--	캐쉬삭제
	-----------------------------------------------------
	else if(@kind = @KIND_USER_CASH_LOG_DELETE)
		begin
			set @idx 			= @p3_
			if(@p2_ = 1)
				begin
					----------------------------------------------
					-- 검색(단일) > 로그삭제, 차감
					----------------------------------------------
					select
						@dateid = Convert(varchar(8), writedate, 112),
						@market = market,
						@cash = cash
					from dbo.tFVCashLog
					where idx = @idx and gameid = @gameid
					--select 'DEBUG ', @dateid dateid, @market market, @cash cash, @idx idx, @gameid gameid

					-- 로그삭제
					delete dbo.tFVCashLog where idx = @idx and gameid = @gameid

					-- 통계차감
					update dbo.tFVCashTotal
						set
							cash = cash - @cash,
							cnt = cnt - 1
					where dateid = @dateid and cashkind = @cash and market = @market

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 2)
				begin
					----------------------------------------------
					-- 검색(일괄) > 로그삭제, 차감
					----------------------------------------------
					-- 2-1. 커서 설정
					declare curCashLog Cursor for
					select Convert(varchar(8), writedate, 112), market, cash, idx from dbo.tFVCashLog where gameid = @gameid

					-- 2-2. 커서오픈
					open curCashLog

					-- 2-3. 커서 사용
					Fetch next from curCashLog into @dateid, @market, @cash, @idx
					while @@Fetch_status = 0
						Begin
							-- 로그삭제
							delete dbo.tFVCashLog where idx = @idx and gameid = @gameid

							-- 통계차감
							update dbo.tFVCashTotal
								set
									cash = cash - @cash,
									cnt = cnt - 1
							where dateid = @dateid and cashkind = @cash and market = @market

							Fetch next from curCashLog into @dateid, @market, @cash, @idx
						end

					-- 2-4. 커서닫기
					close curCashLog
					Deallocate curCashLog

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 3)
				begin
					if(not exists(select top 1 * from dbo.tFVCashLog where acode = @ps4_))
						begin
							update dbo.tFVCashLog
								set
									acode = @ps4_
							where idx = @p3_ and gameid = @gameid
						end
					select @RESULT_SUCCESS 'rtn'
				end
		end

	-----------------------------------------------------
	--	관리자 로그인
	-----------------------------------------------------
	else if(@kind = @KIND_ADMIN_LOGIN)
		begin
			set @subkind = @p2_
			if(@subkind	= 1)
				begin
					if(not exists(select * from dbo.tFVAdminUser where gameid = @ps1_))
						begin
							if(@p3_ = -1)
								begin
									set @p3_ = 0
								end
							insert into tFVAdminUser(gameid, password, grade) values(@ps1_, @ps2_, @p3_)
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
					select @grade = grade from dbo.tFVAdminUser where gameid = @ps1_ and password = @ps2_
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
					select @grade = grade from dbo.tFVAdminUser where gameid = @ps1_
					if(@grade != -1)
						begin
							update dbo.tFVAdminUser
								set
									password 	= @ps2_,
									grade 		= @p3_
							where gameid = @ps1_

							select 1 'rtn', @grade grade, '(수정)'
						end
					else
						begin
							select -1 'rtn', 0 grade, '(수정)'
						end
				end
			else if(@subkind = 4)
				begin
					delete from dbo.tFVAdminUser where gameid = @ps1_ and password = @ps2_
					select 1 'rtn', 0, '(삭제)'
				end
		end

	-----------------------------------------------------
	--	푸쉬,
	-----------------------------------------------------
	else if(@kind = @KIND_NOTICE_SETTING)
		begin
			set @subkind 	= @p2_
			set @idx		= @p3_
			set @market		= @p4_
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

									select top 100 @maxPage maxPage, @page page, * from dbo.tFVSysInquire
									where state = @p5_ order by idx desc
								end
							else if(@ps1_ != '')
								begin
									set @maxPage	= 1
									set @page		= 1

									select top 100 @maxPage maxPage, @page page, * from dbo.tFVSysInquire
									where gameid = @ps1_ order by idx desc
								end
							else
								begin
									-- 읽기.
									set @idxPage	= @p4_
									select @idx = (isnull(max(idx), 1)) from dbo.tFVSysInquire

									set @maxPage	= @idx / @PAGE_LINE
									set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
									set @page		= case
														when (@idxPage <= 0)			then 1
														when (@idxPage >  @maxPage)	then @maxPage
														else @idxPage
													end
									set @idx		= @idx - (@page - 1) * @PAGE_LINE

									select top 100 @maxPage maxPage, @page page, * from dbo.tFVSysInquire
									where idx <= @idx order by idx desc
								end
						end
					else if(@p3_ = 2)
						begin
							-- 처리.
							select @gameid = gameid from dbo.tFVSysInquire where idx = @p5_

							if(@ps3_ = '')
								begin
									-- 내용은 없고 상태만 변경할 경우.
									update dbo.tFVSysInquire
										set
											state 		= @p6_,
											adminid		= @ps2_,
											dealdate 	= getdate()
									where idx = @p5_
								end
							else
								begin
									update dbo.tFVSysInquire
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
													Exec spu_FVSubGiftSend 1, -1, -1,     @ps2_, @gameid, @ps3_
												end
											else if(@p6_ = 1)
												begin
													Exec spu_FVSubGiftSend 1, -1, -1, @ps2_, @gameid, '확인중에 있습니다.'
												end
											else if(@p6_ = 2)
												begin
													Exec spu_FVSubGiftSend 1, -1, -1, @ps2_, @gameid, '처리완료했습니다.'
												end
										end
								end


							select @RESULT_SUCCESS 'rtn'
						end
				end
		end

	-----------------------------------------------------
	--	푸쉬,
	-----------------------------------------------------
	else if(@kind = @KIND_SYSTEMINFO_SETTING)
		begin
			if(@p2_ in (5, 6))
				begin
					-------------------------------------------------
					-- 데이타를 입력
					-------------------------------------------------
					if(@p2_ = 5)
						begin
							set @idx = -1
							insert into dbo.tFVSystemRouletteMan(writedate) values(getdate())
							select top 1 @idx = idx from dbo.tFVSystemRouletteMan order by idx desc
						end
					else
						begin
							set @idx = @p3_
						end

					set @roulmarket 	= @ps1_
					set @roulstart 		= @ps2_
					set @roulend 		= @ps3_
					set @roulname1 		= @ps4_
					set @roulname2 		= @ps5_
					set @roulname3 		= @ps6_

					-- 1. 커서 생성
					declare curSysRoulMan Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @ps9_)

					-- 2. 커서오픈
					open curSysRoulMan

					-- 3. 커서 사용
					Fetch next from curSysRoulMan into @packkind, @packvalue
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG ', @packkind packkind, @packvalue packvalue
							if(@packkind = 1) 		set @roulflag		= @packvalue
							else if(@packkind = 2) 	set @roulani1		= @packvalue
							else if(@packkind = 3) 	set @roulani2 		= @packvalue
							else if(@packkind = 4) 	set @roulani3 		= @packvalue
							else if(@packkind = 5) 	set @roulreward1	= @packvalue
							else if(@packkind = 6) 	set @roulreward2 	= @packvalue
							else if(@packkind = 7) 	set @roulreward3 	= @packvalue
							else if(@packkind = 15) set @roulrewardcnt1	= @packvalue
							else if(@packkind = 16) set @roulrewardcnt2 = @packvalue
							else if(@packkind = 17) set @roulrewardcnt3 = @packvalue

							else if(@packkind = 10) set @roultimeflag 	= @packvalue
							else if(@packkind = 11) set @roultimetime1 	= @packvalue
							else if(@packkind = 12) set @roultimetime2 	= @packvalue
							else if(@packkind = 13) set @roultimetime3 	= @packvalue
							else if(@packkind = 14) set @roultimetime4 	= @packvalue

							else if(@packkind = 20) set @pmgauageflag 	= @packvalue
							else if(@packkind = 21) set @pmgauagepoint	= @packvalue
							else if(@packkind = 22) set @pmgauagemax 	= @packvalue

							else if(@packkind = 23) set @roulsaleflag 	= @packvalue
							else if(@packkind = 24) set @roulsalevalue 	= @packvalue

							else if(@packkind = 25) set @tsupgradesaleflag= @packvalue
							else if(@packkind = 26) set @tsupgradesalevalue= @packvalue

							else if(@packkind = 27) set @wheelgauageflag	= @packvalue
							else if(@packkind = 28) set @wheelgauagepoint= @packvalue
							else if(@packkind = 29) set @wheelgauagemax = @packvalue

							Fetch next from curSysRoulMan into @packkind, @packvalue
						end

					-- 4. 커서닫기
					close curSysRoulMan
					Deallocate curSysRoulMan

					--------------------------------------
					-- 정보 입력
					--------------------------------------
					update dbo.tFVSystemRouletteMan
						set
							roulmarket			= @roulmarket,
							roulflag			= @roulflag,
							roulstart			= @roulstart,
							roulend				= @roulend,
							roulani1			= @roulani1,		roulreward1 		= @roulreward1,		roulrewardcnt1 		= @roulrewardcnt1,		roulname1 			= @roulname1,
							roulani2 			= @roulani2,		roulreward2 		= @roulreward2,		roulrewardcnt2 		= @roulrewardcnt2,		roulname2 			= @roulname2,
							roulani3 			= @roulani3,		roulreward3 		= @roulreward3,		roulrewardcnt3 		= @roulrewardcnt3,		roulname3 			= @roulname3,

							roultimeflag		= @roultimeflag,
							roultimetime1 		= @roultimetime1,
							roultimetime2 		= @roultimetime2,
							roultimetime3 		= @roultimetime3,
							roultimetime4 		= @roultimetime4,

							pmgauageflag		= @pmgauageflag,
							pmgauagepoint 		= @pmgauagepoint,
							pmgauagemax 		= @pmgauagemax,

							roulsaleflag		= @roulsaleflag,
							roulsalevalue		= @roulsalevalue,

							tsupgradesaleflag	= @tsupgradesaleflag,
							tsupgradesalevalue	= @tsupgradesalevalue,

							wheelgauageflag		= @wheelgauageflag,
							wheelgauagepoint 	= @wheelgauagepoint,
							wheelgauagemax 		= @wheelgauagemax,

							comment				= @ps10_
					where idx = @idx

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 7)
				begin
					-------------------------------------------------
					-- 패키지 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tFVItemInfo
					where subcategory in (30, 31, 32, 33, 34, 35)

					select * from dbo.tFVItemInfo
					where subcategory in (30, 31, 32, 33, 34, 35)
					order by itemcode asc

					-------------------------------------------------
					-- 시간제 이벤트 정보.
					-------------------------------------------------
					--select top 200 * from dbo.tFVSystemRouletteMan order by idx desc
					select * from dbo.tFVSystemRouletteMan
					where idx in (select max(idx) from dbo.tFVSystemRouletteMan where roulmarket in (@GOOGLE, @IPHONE) group by roulmarket)
					order by roulmarket asc

				end
			else if(@p2_ = 21)
				begin
					-------------------------------------------------
					-- 교배뽑기 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tFVItemInfo
					where category in (1)

					select * from dbo.tFVItemInfo
					where category in (1)
					order by itemcode asc

					select top 200 * from dbo.tFVSystemRoulette
					where packstate = @p3_
					order by idx desc
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
							if(     @packkind = 1 ) set @pack1  = @packvalue
							else if(@packkind = 2 ) set @pack2  = @packvalue
							else if(@packkind = 3 ) set @pack3  = @packvalue
							else if(@packkind = 4 ) set @pack4  = @packvalue
							else if(@packkind = 5 ) set @pack5  = @packvalue
							else if(@packkind = 6 ) set @pack6  = @packvalue
							else if(@packkind = 7 ) set @pack7  = @packvalue
							else if(@packkind = 8 ) set @pack8  = @packvalue
							else if(@packkind = 9 ) set @pack9  = @packvalue
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

					if(not exists(select top 1 * from dbo.tFVSystemRoulette where packstr = @ps3_))
						begin
							-- 정보수집용 추가 > 아이템 테이블 추가하기.
							set @itemcode = 90000
							select @itemcode = isnull(max(itemcode), 90000) + 1 from dbo.tFVItemInfo where subcategory = 90
							--select 'DEBUG > 동일한 이름이 존재않함 > ', @itemcode itemcode

							if(not exists(select top 1 * from dbo.tFVItemInfo where itemcode = @itemcode))
								begin
									--select 'DEBUG > tFVItemInfo, tFVItemInfo 입력'
									insert into dbo.tFVItemInfo( labelname,     itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
									                   values('staticinfo',    @itemcode,     '90',        '90',      '0',    @ps1_,      '0',     '0',   '0',      '0',  '0',      '0',     '0',      '0',      '0',       '0',      '0',       @ps2_)
									insert into dbo.tFVSystemRoulette( itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale,             packstate, packname,  comment, packstr,
																 	pack1,   pack2,   pack3,   pack4,   pack5,   pack6,   pack7,   pack8,   pack9,   pack10,
																	pack11,  pack12,  pack13,  pack14,  pack15,  pack16,  pack17,  pack18,  pack19,  pack20,
																	pack21,  pack22,  pack23,  pack24,  pack25,  pack26,  pack27,  pack28,  pack29,  pack30,
																	pack31,  pack32,  pack33,  pack34,  pack35,  pack36,  pack37,  pack38,  pack39,  pack40,
																	pack41,  pack42,  pack43,  pack44,  pack45,  pack46,  pack47,  pack48,  pack49,  pack50,
																	gamecost, heart)
														     values(@itemcode, @p4_,      @p5_,      @p6_,         @p7_,        @p6_ - (@p6_ * @p7_)/100, @p8_,      @ps1_,     @ps2_,   @ps3_,
														     		@pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9,  @pack10,
														     		@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																	@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																	@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																	@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50,
														     		@p9_,     @p10_)
								end
						end
					--else
					--	begin
					--		select 'DEBUG > Same name'
					--	end

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 23)
				begin
					-------------------------------------------------
					-- 교배뽑기 (수정)
					-------------------------------------------------

					-- 1. 커서 생성
					declare curRoulUpdate Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @ps3_)

					-- 2. 커서오픈
					open curRoulUpdate

					-- 3. 커서 사용
					Fetch next from curRoulUpdate into @packkind, @packvalue
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG ', @packkind kind, @packvalue packvalue
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

							Fetch next from curRoulUpdate into @packkind, @packvalue
						end

					-- 4. 커서닫기
					close curRoulUpdate
					Deallocate curRoulUpdate

					update dbo.tFVSystemRoulette
							set
								famelvmin	= @p4_,
								famelvmax	= @p5_,
								cashcostcost= @p6_,
								cashcostper	= @p7_,
								cashcostsale= @p6_ - (@p6_ * @p7_)/100,
								gamecost 	= @p9_,
								heart 		= @p10_,
								packstate	= @p8_,
								packname	= @ps1_,
								comment		= @ps2_,
								packstr 	= @ps3_,
								pack1	= @pack1,   	pack2	= @pack2,	pack3	= @pack3,	pack4	= @pack4,		pack5	= @pack5,
								pack6	= @pack6,  		pack7	= @pack7,	pack8	= @pack8,	pack9	= @pack9,		pack10	= @pack10,

								pack11	= @pack11,  	pack12	= @pack12,	pack13	= @pack13,	pack14	= @pack14,		pack15	= @pack15,
								pack16	= @pack16,  	pack17	= @pack17,	pack18	= @pack18,	pack19	= @pack19,		pack20	= @pack20,

								pack21	= @pack21,  	pack22	= @pack22,	pack23	= @pack23,	pack24	= @pack24,		pack25	= @pack25,
								pack26	= @pack26,  	pack27	= @pack27,	pack28	= @pack28,	pack29	= @pack29,		pack30	= @pack30,

								pack31	= @pack31,  	pack32	= @pack32,	pack33	= @pack33,	pack34	= @pack34,		pack35	= @pack35,
								pack36	= @pack36,  	pack37	= @pack37,	pack38	= @pack38,	pack39	= @pack39,		pack40	= @pack40,

								pack41	= @pack41,  	pack42	= @pack42,	pack43	= @pack43,	pack44	= @pack44,		pack45	= @pack45,
								pack46	= @pack46,  	pack47	= @pack47,	pack48	= @pack48,	pack49	= @pack49,		pack50	= @pack50
					where idx = @p3_

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 24)
				begin
					update dbo.tFVSystemRoulette
							set
								cashcostper	= @p7_,
								cashcostsale= cashcostcost - (cashcostcost * @p7_)/100
					where packstate = 1

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 31)
				begin
					set @cnt 	= 0
					set @cnt2 	= 0
					set @cnt3 	= 0
					set @cnt4 	= 0
					select @cnt = isnull(max(idx)+1 - min(idx), 0) from Farm.dbo.tFVUserPushAndroid
					select @cnt2 = isnull(max(idx)+1 - min(idx), 0) from Farm.dbo.tFVUserPushiPhone
					select @cnt3 = isnull(max(idx)+1 - min(idx), 0) from Farm.dbo.tUserPushAndroid
					select @cnt4 = isnull(max(idx)+1 - min(idx), 0) from Farm.dbo.tUserPushiPhone
					select @RESULT_SUCCESS 'rtn', @cnt cnt, @cnt2 cnt2, @cnt3 cnt3, @cnt4 cnt4

					select top 50 * from Game4FarmVill3.dbo.tFVUserPushSendInfo order by idx desc
				end
			else if(@p2_ in (32, 32000))
				begin
					----------------------------------------------------
					-- 짜요 > 짜요(외전)으로 발송
					-- sendkind 3 : URL푸쉬
					--          7 : 단순실행푸쉬
					----------------------------------------------------
					--set @gameid		= @ps1_
					--set @adminid		= @ps2_
					set @recepushid 	= ''

					select @recepushid = pushid, @market = market from Game4FarmVill3.dbo.tFVUserMaster
					where gameid = @gameid

					-- select 'DEBUG ', @adminid sendid, @gameid receid, @recepushid recepushid, @market market, @p3_ sendkind, 99 msgpush_id, @ps3_ msgtitle, @ps4_ msgmsg, @ps5_ msgaction
					if(@recepushid != '')
						begin
							if(@market = @IPHONE)
								begin
									insert into Farm.dbo.tUserPushiPhone(  sendid,  receid,  recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction, scheduleTime)
									values(							     @adminid, @gameid, @recepushid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_, @ps6_)
								end
							else
								begin
									insert into Farm.dbo.tUserPushAndroid( sendid,  receid,  recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction, scheduleTime)
									values(							     @adminid, @gameid, @recepushid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_, @ps6_)
								end
						end

					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 33)
				begin
					-- select 'DEBUG ', @adminid sendid, @gameid receid, @p4_ market, @p3_ sendkind, 99 msgpush_id, @ps3_ msgtitle, @ps4_ msgmsg, @ps5_ msgaction
					if(@p4_ = @IPHONE)
						begin
							set @cnt = 0
							set @cnt2 = 0

							-- receid > gameid가 들어가야하나 중복이 발생때문에 adminid로 대처한다.
							if(@p5_ = 1)
								begin
									insert into Farm.dbo.tUserPushiPhone(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                      pushid, @adminid, gameid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Farm.dbo.tUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and deletestate = 0 and blockstate = 0 and kkopushallow = 1
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end
							else if(@p5_ = 2)
								begin
									insert into Farm.dbo.tFVUserPushiPhone(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                        pushid, @adminid, gameid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Farm.dbo.tUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and deletestate = 0 and blockstate = 0 and kkopushallow = 1
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end


							set @cnt = @@ROWCOUNT
							set @cnt2 = @cnt2 + @cnt

							-----------------------------
							--	메세지 내용기록
							-----------------------------
							insert into Game4FarmVill3.dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt, msgurl)
							values(				  	  		 @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt2, @ps5_)
						end
					else
						begin
							set @cnt = 0
							set @cnt2 = 0
							-- receid > gameid가 들어가야하나 중복이 발생때문에 adminid로 대처한다.
							if(@p5_ = 1)
								begin
									insert into Farm.dbo.tUserPushAndroid(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                         pushid, @adminid, gameid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Farm.dbo.tUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and deletestate = 0 and blockstate = 0 and kkopushallow = 1
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end
							else if(@p5_ = 2)
								begin
									insert into Farm.dbo.tFVUserPushAndroid(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                         pushid, @adminid, gameid,     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Farm.dbo.tUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and deletestate = 0 and blockstate = 0 and kkopushallow = 1
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end


							set @cnt = @@ROWCOUNT
							set @cnt2 = @cnt2 + @cnt

							-----------------------------
							--	메세지 내용기록
							-----------------------------
							insert into Game4FarmVill3.dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt,  msgurl)
							values(				  	  	   	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt2, @ps5_)
						end
					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 34)
				begin
					-- select 'DEBUG ', @adminid sendid, @gameid receid, @p4_ market, @p3_ sendkind, 99 msgpush_id, @ps3_ msgtitle, @ps4_ msgmsg, @ps5_ msgaction
					if(@p4_ = @IPHONE)
						begin
							set @cnt = 0
							set @cnt2 = 0
							-- receid > gameid가 들어가야하나 중복이 발생때문에 adminid로 대처한다.
							if(@p5_ = 1)
								begin
									insert into Farm.dbo.tUserPushiPhone(recepushid,   sendid, receid,        sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                      pushid, @adminid, rtrim(gameid),     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Game4FarmVill3.dbo.tFVUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and blockstate = 0
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end
							else if(@p5_ = 2)
								begin
									insert into Farm.dbo.tFVUserPushiPhone(recepushid,   sendid, receid,        sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                      pushid, @adminid, rtrim(gameid),     @p3_,         99,    @ps3_,  @ps4_,     @ps5_ from Game4FarmVill3.dbo.tFVUserMaster
											where market = @p4_ and pushid is not null and len(pushid) > 20 and blockstate = 0
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end


							set @cnt = @@ROWCOUNT
							set @cnt2 = @cnt2 + @cnt

							-----------------------------
							--	메세지 내용기록
							-----------------------------
							insert into Game4FarmVill3.dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt, msgurl)
							values(				  	  		 @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt2, @ps5_)
						end
					else
						begin
							set @cnt = 0
							set @cnt2 = 0
							-- receid > gameid가 들어가야하나 중복이 발생때문에 adminid로 대처한다.
							if(@p5_ = 1)
								begin
									insert into Farm.dbo.tUserPushAndroid(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                pushid,     @adminid, rtrim(gameid), @p3_,             99,    @ps3_,  @ps4_,     @ps5_ from Game4FarmVill3.dbo.tFVUserMaster
											where market != @IPHONE and pushid is not null and len(pushid) > 20 and blockstate = 0
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end
							else if(@p5_ = 2)
								begin
									insert into Farm.dbo.tFVUserPushAndroid(recepushid,   sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
										select distinct                pushid,     @adminid, rtrim(gameid), @p3_,             99,    @ps3_,  @ps4_,     @ps5_ from Game4FarmVill3.dbo.tFVUserMaster
											where market != @IPHONE and pushid is not null and len(pushid) > 20 and blockstate = 0
											and phone not in (select phone from Game4FarmVill3.dbo.tFVPushBlackList)
								end


							set @cnt = @@ROWCOUNT
							set @cnt2 = @cnt2 + @cnt

							-----------------------------
							--	메세지 내용기록
							-----------------------------
							insert into Game4FarmVill3.dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt,  msgurl)
							values(				  	  	   	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt2, @ps5_)
						end
					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 35)
				begin
					----------------------------------------------------
					-- 푸쉬삭제
					----------------------------------------------------
					if(@p3_ = 0)
						begin
							delete from Farm.dbo.tUserPushAndroid
							delete from Farm.dbo.tUserPushiPhone
							delete from Farm.dbo.tFVUserPushAndroid
							delete from Farm.dbo.tFVUserPushiPhone
						end
					else if(@p3_ = 1)
						begin
							delete from Farm.dbo.tUserPushAndroid
							delete from Farm.dbo.tUserPushiPhone
						end
					else if(@p3_ = 2)
						begin
							delete from Farm.dbo.tFVUserPushAndroid
							delete from Farm.dbo.tFVUserPushiPhone
						end


					select @RESULT_SUCCESS 'rtn'
				end
			else if(@p2_ = 50)
				begin
					-------------------------------------------------
					-- 패키지 상품정보.(상품, 등록리스트)
					-------------------------------------------------
					select count(*) cnt from dbo.tFVItemInfo
					where subcategory in (30, 31, 32, 33, 34, 35)

					select * from dbo.tFVItemInfo
					where subcategory in (30, 31, 32, 33, 34, 35)
					order by itemcode asc

					-------------------------------------------------
					-- 시간제 이벤트 정보.
					-------------------------------------------------
					select * from dbo.tFVEventMaster where idx = 1

					select top 200 u.*, i.itemname from dbo.tFVEventSub u join
						(select * from dbo.tFVItemInfo) i
							on u.eventitemcode = i.itemcode
					order by eventday desc, eventstarthour desc, eventendhour desc
				end
			else if(@p2_ = 51)
				begin
					update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = -1 then 1 else -1 end where idx = 1
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
									insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday,  eventstarthour,  eventendhour,  eventpushtitle,  eventpushmsg,  eventstatedaily,  eventcnt)
									values(                         @itemcode, @eventsender, @eventday, @eventstarthour, @eventendhour, @eventpushtitle, @eventpushmsg, @eventstatedaily, @eventcnt)
								end
							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 2)
						begin
							-- 수정.
							update dbo.tFVEventSub
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
							update dbo.tFVEventSub set eventstatedaily = case when eventstatedaily = 0 then 1 else 0 end where eventidx = @idx

							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 4)
						begin
							update dbo.tFVEventSub set eventpushstate = case when eventpushstate = 0 then 1 else 0 end where eventidx = @idx

							select @RESULT_SUCCESS 'rtn'
						end
					else if(@subkind = 5)
						begin
							delete from dbo.tFVEvnetUserGetLog where idx = @p4_

							select @RESULT_SUCCESS 'rtn'
						end
				end
			else if(@p2_ = 53)
				begin
					if(isnull(@gameid, '') = '')
						begin
							set @idxPage	= @p7_
							select @idx = (isnull(max(idx), 1)) from dbo.tFVEvnetUserGetLog

							set @maxPage	= @idx / @PAGE_LINE
							set @maxPage 	= @maxPage + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
							set @page		= case
												when (@idxPage <= 0)			then 1
												when (@idxPage >  @maxPage)	then @maxPage
												else @idxPage
											end
							set @idx		= @idx - (@page - 1) * @PAGE_LINE

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tFVEvnetUserGetLog u join
								(select * from dbo.tFVItemInfo) i
									on u.eventitemcode = i.itemcode
							where u.idx <= @idx order by u.idx desc
						end
					else
						begin
							set @maxPage	= 1
							set @page		= 1

							select top 100 @maxPage maxPage, @page page, u.*, i.itemname from dbo.tFVEvnetUserGetLog u join
								(select * from dbo.tFVItemInfo) i
									on u.eventitemcode = i.itemcode
							where gameid = @gameid
							order by u.idx desc
						end
				end
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
					select * from dbo.tFVItemInfo where subcategory in (30, 31, 32, 33, 34, 35) and itemcode not in ( 3015, 3016)
					union all
					select * from dbo.tFVItemInfo where itemcode in ( 3015, 3016 )
					--order by itemcode asc
				end
			else if(@subkind = 2)
				begin
					if(isnull(@gameid, '') = '')
						begin
							-- 최근것
							select a.idx idxt, a.idx2 idx2, gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
							from (select top 50 * from dbo.tFVGiftList order by idx desc) a
								LEFT JOIN
								dbo.tFVItemInfo b
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
									from (select top 1000 * from dbo.tFVGiftList where gameid = @str order by idx desc) a
										LEFT JOIN
										dbo.tFVItemInfo b
										ON a.itemcode = b.itemcode
									order by idxt desc
								end
							else
								begin
									select a.idx idxt, a.idx2 idx2,  gameid, giftkind, message, gainstate, gaindate, giftid, giftdate, a.cnt, b.*
									from (select top 1000 * from dbo.tFVGiftList where gameid = @str and giftid = @str2 order by idx desc) a
										LEFT JOIN
										dbo.tFVItemInfo b
										ON a.itemcode = b.itemcode
									order by idxt desc
								end

						end
				end
			else if(@subkind = 11)
				begin
					if(not exists(select top 1 * from dbo.tFVUserMaster where gameid = @gameid))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_GAMEID
						end
					else if(not exists(select top 1 * from dbo.tFVItemInfo where itemcode = @itemcode))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_ITEMCODE
						end
					else
						begin
							set @nResult = @RESULT_SUCCESS
							set @str = '관리자(' + @adminid + ')'

							exec spu_FVSubGiftSend 2,  @itemcode, @ps4_, @str, @gameid, ''

							--insert into dbo.tFVGiftList(gameid, giftkind, itemcode, giftid)
							--values(@gameid, 2, @itemcode, @adminid);
						end

					select @nResult 'rtn'
				end
			else if(@subkind = 12)
				begin
					if(not exists(select top 1 * from dbo.tFVUserMaster where gameid = @gameid))
						begin
							set @nResult = @RESULT_ERROR_NOT_FOUND_GAMEID
						end
					else
						begin
							set @nResult = @RESULT_SUCCESS
							set @str = '관리자(' + @adminid + ')'

							exec spu_FVSubGiftSend 1, -1, -1, @str, @gameid, @comment		-- ?????? ????

							--insert into dbo.tFVGiftList(gameid, giftkind, message)
							--values(@gameid, 1, @comment);
						end

					select @nResult 'rtn'
				end
			else if(@subkind = 21)
				begin
					update dbo.tFVGiftList
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
					update dbo.tFVGiftList
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
					delete from dbo.tFVGiftList where idx = @p4_

					select @nResult 'rtn'
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
							select * from dbo.tFVItemInfo where itemcode = @itemcode order by itemcode asc
						end
					else if(@category != -1)
						begin
							select * from dbo.tFVItemInfo where category = @category
						end
					else if(@subcategory != -1)
						begin
							select * from dbo.tFVItemInfo where subcategory = @subcategory
						end
					else
						begin
							select * from dbo.tFVItemInfo order by itemcode asc
						end
				end
		end

	------------------------------------------------
	--	완료
	------------------------------------------------
	set nocount off
End

