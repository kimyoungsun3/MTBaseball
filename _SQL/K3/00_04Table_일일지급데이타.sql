if(not exists(select top 1 * from dbo.tFVEventMaster))
	begin
		insert into dbo.tFVEventMaster(eventstatemaster) values(1)
	end

update dbo.tFVEventMaster set eventstatemaster = 1 where idx = 1


-- select * from dbo.tFVEventSub
delete from dbo.tFVEventSub

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  1, 1, 23, '2015년 새해가 밝았습니다.', '새해 복 많이 받으세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  2, 1, 23, '즐거운 양띠의 해 2015년 새해에도', '재미있는 짜요 외전과 함께 즐겨요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  3, 1, 23, '행복한 주말! 재미있는 짜요 외전', '모두 같이 즐겨보아요!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  4, 1, 23, '행복한 주말! 즐거운 목장LIFE를', '짜요목장이야기 외전에서 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  5, 1, 23, '피곤한 월요일에는', '재밌는 외전과 함께하면 즐거워져요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  6, 1, 23, '즐겁고 다양한 이벤트', '외전과 함께 즐겨보아요!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  7, 1, 23, '주인님을 애타게 기다리고 있어요~', '지금 접속해서 빨리 관리해주세요~ 터질것 같아요 ㅠ_ㅠ', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  8, 1, 23, '즐겁고 다양한 이벤트', '불쌍한 가축들에게 관리해주고 유제품도 판매해제주세요~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  9, 1, 23, '짜요외전과 함께하면 ', '절대 심심하지 않은 하루! 지금 접속하세요~!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 10, 1, 23, '따뜻한 카페라떼와 함께', '짜요 외전을 즐겨보세요~', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 11, 1, 23, '지금바로 접속해보세요.', '결정을 모아뒀습니다. 받아가세요~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 12, 1, 23, '불금엔 신나게 놀고 집에 올때', '짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 13, 1, 23, '양의 해 기념 이벤트 진행 중', '구매하시면 선물함에 우유결정이 우왕', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 14, 1, 23, '양의 해 기념 이벤트 진행 중', '구매하시면 선물함에 우유결정이 우왕 굿', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 15, 1, 23, '새로운 한주의 시작을', '짜요 외전과 같이 시작해보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 16, 1, 23, '추운 겨울 집에서만 빈둥빈둥할 때', '재미있는 짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 17, 1, 23, '점심시간 이후에 피곤할 때는', '여유로운 짜요 외전으로 피로를 풀어보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 18, 1, 23, '신나고 다양한 이벤트를', '짜요 외전과 함께 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 19, 1, 23, '행복한 목장 경영 시뮬레이션 ', '짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 20, 1, 23, '맛있는 우유 먹고 여유롭게', '짜요 외전을 즐기실 준비 되셨나요', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 21, 1, 23, '절호의 찬스!!! 이번기회 놓치지 마세요', '우유 결정 100개를 선물함으로 드려요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 22, 1, 23, '동물들이 추워서 떨고 있어요', '불쌍한 동물들을 관리해주고, 우유제품도 팔아보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 23, 1, 23, '사랑스러운 동물들과 함께 ', '즐거운 짜요 외전을 신나게 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 24, 1, 23, '여유있는 목장 라이프를 짜요 외전에서', '재미있고 신나는 컨텐츠를 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 25, 1, 23, '행복한 주말에는 짜요외전과 함께', '즐거운 목장 라이프를 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 26, 1, 23, '여유롭게 즐길 수 있는', '짜요 외전을 친구들과 함께해요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 27, 1, 23, '훈훈한 분위기의 짜요 외전과 함꼐', '더욱 재미있고 즐거운 하루 보내세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 28, 1, 23, '짜요 외전에서 다양한 이벤트가', '진행중입니다 참여해서 혜택을 받아가세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 29, 1, 23, '행복한 목장 경영 시뮬레이션 ', '짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 30, 1, 23, '맛있는 우유 먹고 여유롭게', '짜요 외전을 즐기실 준비 되셨나요', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 31, 1, 23, '지금바로 접속해보세요.', '결정을 모아뒀습니다. 받아가세요~', 0)

/*
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100,  1, 1, 23, '2015년 새해가 밝았습니다.', '새해 복 많이 받으세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  2, 1, 23, '즐거운 양띠의 해 2015년 새해에도', '재미있는 짜요 외전과 함께 즐겨요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200,  3, 1, 23, '행복한 주말! 재미있는 짜요 외전', '모두 같이 즐겨보아요!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  4, 1, 23, '행복한 주말! 즐거운 목장LIFE를', '짜요목장이야기 외전에서 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200,  5, 1, 23, '피곤한 월요일에는', '재밌는 외전과 함께하면 즐거워져요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  6, 1, 23, '즐겁고 다양한 이벤트', '외전과 함께 즐겨보아요!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   3,  7, 1, 23, '주인님을 애타게 기다리고 있어요~', '지금 접속해서 빨리 관리해주세요~ 터질것 같아요 ㅠ_ㅠ', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100,  8, 1, 23, '즐겁고 다양한 이벤트', '불쌍한 가축들에게 관리해주고 유제품도 판매해제주세요~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  9, 1, 23, '짜요외전과 함께하면 ', '절대 심심하지 않은 하루! 지금 접속하세요~!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 10, 1, 23, '따뜻한 카페라떼와 함께', '짜요 외전을 즐겨보세요~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 11, 1, 23, '지금바로 접속해보세요.', '결정을 모아뒀습니다. 받아가세요~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 12, 1, 23, '불금엔 신나게 놀고 집에 올때', '짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 13, 1, 23, '양의 해 기념 이벤트 진행 중', '구매하시면 선물함에 우유결정이 우왕', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3500,   1, 14, 1, 23, '양의 해 기념 이벤트 진행 중', '구매하시면 선물함에 우유결정이 우왕 굿', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100, 15, 1, 23, '새로운 한주의 시작을', '짜요 외전과 같이 시작해보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 16, 1, 23, '추운 겨울 집에서만 빈둥빈둥할 때', '재미있는 짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 17, 1, 23, '점심시간 이후에 피곤할 때는', '여유로운 짜요 외전으로 피로를 풀어보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 18, 1, 23, '신나고 다양한 이벤트를', '짜요 외전과 함께 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 19, 1, 23, '행복한 목장 경영 시뮬레이션 ', '짜요 외전을 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 20, 1, 23, '맛있는 우유 먹고 여유롭게', '짜요 외전을 즐기실 준비 되셨나요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   3, 21, 1, 23, '절호의 찬스!!! 이번기회 놓치지 마세요', '우유 결정 100개를 선물함으로 드려요', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100, 22, 1, 23, '동물들이 추워서 떨고 있어요', '불쌍한 동물들을 관리해주고, 우유제품도 팔아보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 23, 1, 23, '사랑스러운 동물들과 함께 ', '즐거운 짜요 외전을 신나게 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 24, 1, 23, '여유있는 목장 라이프를 짜요 외전에서', '재미있고 신나는 컨텐츠를 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 25, 1, 23, '행복한 주말에는 짜요외전과 함께', '즐거운 목장 라이프를 즐겨보세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 26, 1, 23, '여유롭게 즐길 수 있는', '짜요 외전을 친구들과 함께해요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 27, 1, 23, '훈훈한 분위기의 짜요 외전과 함꼐', '더욱 재미있고 즐거운 하루 보내세요', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3500,   1, 28, 1, 23, '짜요 외전에서 다양한 이벤트가', '진행중입니다 참여해서 혜택을 받아가세요', 0)
*/
