USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION 테이블에 더미 데이터 추가
-- 이모지 입력이 mariaDB에 올라가지나 모르겠어서 일단 알파벳으로 입력(내일 가서 확인하겠음)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION (`study_room_member_weekly_plan_id`, `study_room_member_id`, `evaluation_date_time`, `evaluation_icon`) VALUES
-- study room 1(photo): week 1 
(1, 2, '2024-06-01 13:25:09', 'A'),
(1, 3, '2024-06-02 15:15:09', 'B'),
(3, 4, '2024-06-01 21:10:40', 'E'),

-- study room 1: week 2 
(13, 1, '2024-06-09 19:22:19', 'C'),
(14, 3, '2024-06-10 12:42:54', 'B'),

-- study room 2(time): week 1 
(23, 6, '2024-06-01 12:35:21', 'A'),
(23, 7, '2024-06-01 16:15:54', 'F'),
(23, 8, '2024-06-02 21:12:23', 'E'),
(26, 7, '2024-06-03 00:23:12', 'D'),
(28, 5, '2024-06-03 07:12:11', 'D'),

-- study room 2: week 2 
(39, 5, '2024-06-07 13:39:29', 'T'),
(40, 7, '2024-06-09 19:32:23', 'U'),
(43, 10, '2024-06-09 23:54:22', 'I'),

-- study room 2: week 3 
(50, 10, '2024-06-14 14:11:07', 'F')
;