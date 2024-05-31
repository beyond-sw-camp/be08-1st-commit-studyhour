USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- STUDY_ROOM 테이블에 더미 데이터 추가
INSERT INTO STUDY_ROOM (study_room_category_id, name, is_public, private_password, description, max_capacity, authentication_method, fine, current_study_round, start_date_time, end_date_time, created_date_time, is_finished) VALUES
(1, '자바로 알고리즘 공부하기', TRUE, NULL, '자바로 코테 뿌수기, 빡시게할 사람만 오세요.', 12, 'PHOTO', 12000, 1, '2024-05-31 12:00:00', '2024-06-14 05:00:00', '2024-05-30 19:20:00', FALSE),
(2, '파이썬으로 알고리즘 공부하기', TRUE, NULL, '파이썬으로 코테 날먹하자, 날먹 좋아하는 사람만 오세요', 12, 'TIME', 5000, 1, '2024-05-31 12:00:00', '2024-06-21 05:00:00', '2024-05-30 19:20:00', FALSE);
