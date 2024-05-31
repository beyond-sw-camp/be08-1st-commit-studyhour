# T1 

# 신규 유저 등록
INSERT INTO `USER` (username, password, nickname, gender) VALUES
('hoya', '1q2w3e4r!', 'hwsc', 'M');

# 13번 유저 1번 스터디룸 신청
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(13, 1, 0, '2024-06-01 11:00:20');

# 아이디 hoya 유저(user_id = 13) 신청 가입 허가
UPDATE study_room_member
SET is_join_accepted = 1,
 	 privilege = 'MEMBER'
WHERE user_id = 13;