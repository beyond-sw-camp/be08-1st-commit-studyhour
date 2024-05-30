USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- STUDY_ROOM 테이블에 더미 데이터 추가
INSERT INTO STUDY_ROOM (study_room_category_id, name, is_public, private_password, description, max_capacity, authentication_method, fine, current_study_round, start_date_time, end_date_time, created_date_time, is_finished) VALUES
(1, 'Study Room 1', FALSE, 'password', 'Study room for programming enthusiasts', 10, 'TIME', 2000, 1, '2024-06-01 09:00:00', '2024-06-14 18:00:00', '2024-05-30 10:00:00', FALSE),
(2, 'Study Room 2', TRUE, NULL, 'Study room for photography lovers', 8, 'PHOTO', 3000, 1, '2024-06-01 10:00:00', '2024-06-21 18:00:00', '2024-05-30 20:00:00', FALSE);
