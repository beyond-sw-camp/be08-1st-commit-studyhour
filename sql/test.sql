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

# 2.3.1 공개 스터디룸 참가 신청
-- 13번 유저 1번 스터디룸 참가 신청
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(13, 1, 0, '2024-06-01 11:00:20');

# 2.4.1. 스터디룸 참가 신청내역 조회
-- 1번 스터디룸 참가 신청 내역 조회(1번 스터디룸 방장)
SELECT user_id, join_date_time
FROM study_room_member
WHERE is_join_accepted = 0
AND study_room_id = 1
;

# 2.4.2. 스터디룸 참가 신청 수락
-- 아이디 hoya 유저(user_id = 13) 신청 가입 허가
UPDATE study_room_member
SET is_join_accepted = 1,
 	 privilege = 'MEMBER'
WHERE user_id = ( SELECT user_id FROM `user` WHERE `username` = 'hoya' );


# 2.4.3. 스터디룸 참가 신청 거부
-- 삭제 케이스를 위해 신청 내역 추가(username = Neddy)
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(5, 1, 0, '2024-06-01 11:00:20');

SELECT * 
FROM study_room_member;

-- 5번 유저(Neddy)의 1번 스터디룸 참가 신청을 거부함에 따른 삭제
DELETE
FROM study_room_member
WHERE privilege IS NULL
AND study_room_id = 1
AND user_id = (SELECT user_id FROM `user` WHERE `username` = 'Neddy')
;

SELECT * 
FROM study_room_member;

# 2.5.1. 스터디룸 전체 조회 (전체 조회 화면)
SELECT r.`name`, r.is_public, r.`description`, r.max_capacity, c.`name` AS 'category'
FROM study_room r
INNER JOIN study_room_category c ON c.study_room_category_id = r.study_room_category_id
ORDER BY created_date_time DESC, is_finished ASC;

# 2.5.2. 스터디룸 필터링 조회
-- 진행중인 공개 스터디룸 조회
SELECT r.`name`, r.is_public, r.`description`, r.max_capacity, c.`name` AS 'category'
FROM study_room r
INNER JOIN study_room_category c ON c.study_room_category_id = r.study_room_category_id
WHERE r.is_public = 1
AND 	r.end_date_time >= NOW()
;

# 2.5.3. 스터디룸 상세 조회
-- 2번 스터디룸 상세 조회
SELECT *
FROM study_room
WHERE study_room_id = 2;


# T4. 스터디룸 생성
INSERT INTO study_room (study_room_category_id, `name`, is_public, private_password, `description`, max_capacity,
                        start_date_time, end_date_time, created_date_time)
VALUES (3, '당근마켓 클론 프로젝트', 0, 'asdf1020', '당근마켓 클론 프로젝트 모임입니다.', 6, '2024-06-01 12:12:13', '2024-12-06 05:00:00',
        '2024-05-31 17:12:31');

-- 스터디룸 생성하면서 동시에 스터디룸 멤버에 방장으로써 데이터 삽입되어야함
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (12, 3, 1, 'MANAGER', '2024-05-31 17:12:31');


# [4.1.1] [투 두 리스트 내용 입력] T
# INSERT INTO STUDY_ROOM_MEMBER_TODO (study_room_member_id, content, todo_duration_time, created_date, is_checked)
# VALUE ()

# [4.2.1] [투 두 리스트 조회] T
SELECT r.name                                 AS '스터디룸',
       u.nickname                             AS '작성자',
       to_do.content                          AS '내용',
       to_do.created_date                     AS '작성일',
       IF(is_checked, 'CHECKED', 'UNCHECKED') AS '체크_여부'
FROM STUDY_ROOM_MEMBER_TODO to_do
         INNER JOIN STUDY_ROOM_MEMBER m ON to_do.study_room_member_id = m.study_room_member_id
         INNER JOIN STUDY_ROOM r ON m.study_room_id = r.study_room_id
         INNER JOIN USER u ON m.user_id = u.user_id;
# [4.3.1] [투 두 리스트 수정] T

# [4.4.1] [투 두 리스트 삭제] T
