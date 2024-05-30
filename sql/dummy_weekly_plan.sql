-- weekly_plan dummy data
-- dumy data in study room 1 (4 people)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_id, study_room_member_id, plan_detail, created_date_time, weekly_plan_round_number) VALUES
(1, 1, '코드트리 그리디알고리즘 1~5번 풀기', '2024-05-30 23:46:47', 1),
(1, 2, '혼자 공부하는 자바 챕터 1,2 공부하기', '2024-05-30 23:46:57', 1),
(1, 3, '마리아DB 테이블 생성, 조회, 삭제 블로그에 정리하기', '2024-05-30 23:49:04', 1),
(1, 4, '리눅스 명령어 정리하기', '2024-05-30 23:55:04', 1),
(1, 2, '코드트리 정렬알고리즘 5번문제 다시 풀기', '2024-05-30 23:55:57', 1),
(1, 4, '백준 DP알고리즘 7문제 풀기', '2024-05-30 23:58:10', 1),
(1, 1, '프로젝트 회원가입,로그인 로직 구현 끝내기', '2024-05-30 23:58:47', 1),
(1, 3, '토익 단어 500개 외우기', '2024-05-30 23:59:00', 1),
(1, 3, '백준 DFS알고리즘 10문제 풀기', '2024-05-30 23:59:50', 1),
(1, 1, '팀프로젝트 ERD랑 테이블명세서 작성 끝내기', '2024-05-30 23:59:57', 1),
(1, 3, 'DB 트랜잭션이랑 트리거 블로그 정리하기', '2024-05-30 23:59:58', 1),
(1, 3, '코드트리 DP 알고리즘 3문제 풀기', '2024-06-07 23:45:47', 2),
(1, 1, '팀프로젝트 테스트케이스 만들기', '2024-06-07 23:45:48', 2),
(1, 3, 'SQLD 정리본 블로그에 정리하기', '2024-06-07 23:45:49', 2),
(1, 4, '코드트리 백트래킹 알고리즘 6문제 풀기', '2024-06-07 23:45:55', 2),
(1, 1, '팀프로젝트 물리적 모델링 끝내기', '2024-06-07 23:45:57', 2),
(1, 2, '정보처리기사 기출 3회분 끝내기', '2024-06-07 23:45:59', 2),
(1, 3, '백준 DFS 알고리즘 6문제 풀기', '2024-06-07 23:47:47', 2),
(1, 4, '인프런 리액트 강의 6개 듣기', '2024-06-07 23:49:47', 2),
(1, 3, '컴퓨터구조 강의 3개 듣기', '2024-06-07 23:53:00', 2),
(1, 1, '코드트리 백트래킹 알고리즘 2문제 풀기', '2024-06-07 23:56:47', 2),
(1, 4, '팀프로젝트 논리적 모델링 끝내기', '2024-06-07 23:56:49', 2),
(1, 2, 'sqlp 기출 3회분 끝내기', '2024-06-07 23:59:07', 2)
;

-- dumy data in study room 2 (6 people)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_id, study_room_member_id, plan_detail, created_date_time, weekly_plan_round_number) VALUES
(2, 1, '코드트리 그리디알고리즘 15문제 풀기', '2024-05-30 10:12:34', 1),
(2, 2, '혼자 공부하는 자바 챕터 5 공부하기', '2024-05-30 11:23:45', 1),
(2, 3, 'C언어 포인터 공부하기', '2024-05-30 12:34:56', 1),
(2, 6, '리눅스 명령어 정리하기', '2024-05-30 13:45:12', 1),
(2, 5, '정보처리기사 필기 접수하기', '2024-05-30 14:56:23', 1),
(2, 4, '프로그래머스 sql 10문제 풀이', '2024-05-30 15:07:34', 1),
(2, 2, '코드트리 BFS알고리즘 13번문제 다시 풀기', '2024-05-30 16:18:45', 1),
(2, 4, '백준 DP알고리즘 7문제 풀기', '2024-05-30 17:29:56', 1),
(2, 1, '스프링부트 강의 5개 듣기', '2024-05-30 18:40:12', 1),
(2, 3, 'HTML/CSS 책 1회독 하기', '2024-05-30 19:51:23', 1),
(2, 6, '스프링부트 강의 3개 듣기', '2024-05-30 20:02:34', 1),
(2, 5, 'HTML/CSS 책 1회독 하기', '2024-05-30 21:13:45', 1),
(2, 3, '코드트리 DP 알고리즘 3문제 풀기', '2024-06-07 09:15:22', 2),
(2, 1, '팀프로젝트 테스트케이스 만들기', '2024-06-07 10:16:33', 2),
(2, 3, 'SQLD 정리본 블로그에 정리하기', '2024-06-07 11:17:44', 2),
(2, 5, '코드트리 백트래킹 알고리즘 6문제 풀기', '2024-06-07 12:18:55', 2),
(2, 6, '팀프로젝트 물리적 모델링 끝내기', '2024-06-07 13:19:11', 2),
(2, 2, '정보처리기사 기출 3회분 끝내기', '2024-06-07 14:20:22', 2),
(2, 3, '백준 DFS 알고리즘 6문제 풀기', '2024-06-07 15:21:33', 2),
(2, 4, '인프런 리액트 강의 6개 듣기', '2024-06-07 16:22:44', 2),
(2, 3, '컴퓨터구조 강의 3개 듣기', '2024-06-07 17:23:55', 2),
(2, 5, '코드트리 백트래킹 알고리즘 2문제 풀기', '2024-06-07 18:24:11', 2),
(2, 4, '팀프로젝트 논리적 모델링 끝내기', '2024-06-07 19:25:22', 2),
(2, 6, 'sqlp 기출 3회분 끝내기', '2024-06-07 20:26:33', 2),
(2, 5, '프로그래머스 백트래킹 알고리즘 6문제 풀기', '2024-06-14 09:27:44', 3),
(2, 6, '팀프로젝트 물리적 모델링 끝내기', '2024-06-14 10:28:55', 3),
(2, 2, '정보처리기사 기출 4회분 끝내기', '2024-06-14 11:29:11', 3),
(2, 3, '백준 자료구조 해시맵 6문제 풀기', '2024-06-14 12:30:22', 3),
(2, 4, '인프런 스프링 강의 3개 듣기', '2024-06-14 13:31:33', 3),
(2, 3, '컴퓨터네트워크 강의 3개 듣기', '2024-06-14 14:32:44', 3),
(2, 5, '백준 백트래킹 알고리즘 2문제 풀기', '2024-06-14 15:33:55', 3),
(2, 4, '운영체제 배운거 블로그정리', '2024-06-14 16:34:11', 3),
(2, 6, '토플 이번주 내용 정리하기', '2024-06-14 17:35:22', 3)
;