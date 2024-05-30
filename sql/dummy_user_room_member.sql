USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM_member;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- study_room_member 더미 데이터 만들기

INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(1,1,1,"MANAGER", '2024-05-30 19:20:00');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(5,2,1,"MANAGER", '2024-05-30 19:20:00');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(2,1,1,"MEMBER", '2024-05-30 19:25:21');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(3,1,1,"MEMBER", '2024-05-30 19:30:33');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(6,2,1,"MEMBER", '2024-05-30 19:00:15');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(7,2,1,"MEMBER", '2024-05-30 21:05:02');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(4,1,1,"MEMBER", '2024-06-01 09:32:46');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(10,2,1,"MEMBER", '2024-06-01 10:22:35');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(9,2,1,"MEMBER", '2024-06-01 11:12:13');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(8,2,1,"MEMBER", '2024-06-01 11:39:27');
