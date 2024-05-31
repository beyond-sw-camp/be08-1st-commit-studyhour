# T1. 신규 유저 등록
INSERT INTO `USER` (username, password, nickname, gender) VALUES
('hoya', '1q2w3e4r!', 'hwsc', 'M');

# T2. 13번 유저 1번 스터디룸 신청
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(13, 1, 0, '2024-06-01 11:00:20');

# T3. 아이디 hoya 유저(user_id = 13) 신청 가입 허가
UPDATE study_room_member
SET is_join_accepted = 1,
 	 privilege = 'MEMBER'
WHERE user_id = 13;



# T4. 스터디룸 생성
INSERT INTO study_room (study_room_category_id, `name`, is_public, private_password, `description`, max_capacity, start_date_time, end_date_time, created_date_time) VALUES
(3,'당근마켓 클론 프로젝트',0,'asdf1020','당근마켓 클론 프로젝트 모임입니다.', 6, '2024-06-01 12:12:13', '2024-12-06 05:00:00', '2024-05-31 17:12:31');

-- 스터디룸 생성하면서 동시에 스터디룸 멤버에 방장으로써 데이터 삽입되어야함
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(12, 3, 1, 'MANAGER','2024-05-31 17:12:31');
