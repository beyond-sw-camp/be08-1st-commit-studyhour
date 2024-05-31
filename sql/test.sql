# 1.3 신규 회원 가입
INSERT INTO `USER` (username, password, nickname, gender) VALUES
('hoya', '1q2w3e4r!', 'hwsc', 'M');

# 2.1. 스터디룸 생성
-- 12번 유저가 '당근마켓 클론 프로젝트'라는 이름의 스터디룸 개설 (비공개)
INSERT INTO study_room (study_room_category_id, `name`, is_public, private_password, `description`, 
								max_capacity, start_date_time, end_date_time, created_date_time, is_finished) VALUES
(3,'당근마켓 클론 프로젝트',0,'asdf1020','당근마켓 클론 프로젝트 모임입니다.', 
6, '2024-06-01 12:12:13', '2024-12-06 05:00:00', '2024-05-31 17:12:31', FALSE);

# 2.2. 스터디룸 정보 수정
--	3번 스터디룸 비밀번호 변경 및 인원수 조정, 벌금 추가
UPDATE study_room
SET	private_password = '',
		max_capacity = 7,
		fine = 1000
WHERE study_room_id = 3;

-- * 스터디룸 생성하면서 동시에 스터디룸 멤버에 방장으로써 데이터 삽입되어야함
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(12, 3, 1, 'MANAGER','2024-05-31 17:12:31');
# 2.4 13번 유저 1번 스터디룸 신청
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(13, 1, 0, '2024-06-01 11:00:20');

# 2.4.1. 스터디룸 참가 신청내역 조회
-- 1번 스터디룸 참가 신청 내역 조회(1번 스터디룸 방장)
SELECT user_id, join_date_time
FROM study_room_member
WHERE is_join_accepted = 0
AND study_room_id = 1
;

# 2.4.2. 스터디룸 참가 요청 수락
-- 아이디 hoya 유저(user_id = 13) 신청 가입 허가
UPDATE study_room_member
SET is_join_accepted = 1,
 	 privilege = 'MEMBER'
WHERE user_id = ( SELECT user_id FROM USER WHERE name = 'hoya' );



