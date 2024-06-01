# [1.3] [신규 회원 가입] T
INSERT INTO `USER` (username, password, nickname, gender) VALUES
('hoya', '1q2w3e4r!', 'hwsc', 'M');

# 1.5 회원 탈퇴
## 스터디룸 방장인데 회원 탈퇴할 시


# [2.1] [스터디룸 생성] T
-- 12번 유저가 '당근마켓 클론 프로젝트'라는 이름의 스터디룸 개설 (비공개)
INSERT INTO study_room (study_room_category_id, `name`, is_public, private_password, `description`, 
								max_capacity, start_date_time, end_date_time, created_date_time, is_finished) VALUES
(3,'당근마켓 클론 프로젝트',0,'asdf1020','당근마켓 클론 프로젝트 모임입니다.', 
6, '2024-06-01 12:12:13', '2024-12-06 05:00:00', '2024-05-31 17:12:31', FALSE);

-- 스터디룸 생성하면서 동시에 스터디룸 멤버에 방장으로써 데이터 삽입되어야함
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (12, 3, 1, 'MANAGER', '2024-05-31 17:12:31');


# [2.2] [스터디룸 정보 수정] T
--	3번 스터디룸 비밀번호 변경 및 인원수 조정, 벌금 추가
UPDATE study_room
SET	private_password = '',
		max_capacity = 7,
		fine = 1000
WHERE study_room_id = 3;

-- * 스터디룸 생성하면서 동시에 스터디룸 멤버에 방장으로써 데이터 삽입되어야함
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time) VALUES
(12, 3, 1, 'MANAGER','2024-05-31 17:12:31');

# [2.3.1] [공개 스터디룸 참가 신청] T
-- 13번 유저 1번 스터디룸 참가 신청
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(13, 1, 0, '2024-06-01 11:00:20');

# [2.4.1] [스터디룸 참가 신청내역 조회] T
-- 1번 스터디룸 참가 신청 내역 조회(1번 스터디룸 방장)
SELECT u.nickname,
		 u.gender,
		 up.profile_image_url,
		 srm.join_date_time
FROM study_room_member srm
INNER JOIN `user` u ON srm.user_id = u.user_id
LEFT OUTER JOIN user_profile up ON u.user_id = up.user_id
WHERE is_join_accepted = 0
AND study_room_id = 1
;

# [2.4.2] [스터디룸 참가 신청 수락] T
-- 아이디 hoya 유저(user_id = 13) 신청 가입 허가
UPDATE study_room_member
SET is_join_accepted = 1,
 	 privilege = 'MEMBER'
WHERE user_id = ( SELECT user_id FROM `user` WHERE `nickname` = 'hwsc' );


# [2.4.3] [스터디룸 참가 신청 거부] T
-- 삭제 케이스를 위해 신청 내역 추가(nickname = Walczak)
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, join_date_time) VALUES
(5, 1, 0, '2024-06-01 11:00:20');

SELECT * 
FROM study_room_member;

-- 5번 유저(Neddy)의 1번 스터디룸 참가 신청을 거부함에 따른 삭제
DELETE
FROM study_room_member
WHERE privilege IS NULL
AND study_room_id = 1
AND user_id = (SELECT user_id FROM `user` WHERE `nickname` = 'Walczak')
;

SELECT * 
FROM study_room_member;

# [2.5.1] [스터디룸 전체 조회 (전체 조회 화면)] T
SELECT r.`name`, r.is_public, r.`description`, r.max_capacity, c.`name` AS 'category'
FROM study_room r
INNER JOIN study_room_category c ON c.study_room_category_id = r.study_room_category_id
ORDER BY created_date_time DESC, is_finished ASC;

# [2.5.2] [스터디룸 필터링 조회] T
-- 진행중인 공개 스터디룸 조회
SELECT r.`name`, 
		 r.is_public,
		 r.`description`, 
		 r.max_capacity, 
		 c.`name` AS 'category',
		 r.created_date_time,
		 r.end_date_time,
FROM study_room r
INNER JOIN study_room_category c ON c.study_room_category_id = r.study_room_category_id
WHERE r.is_public = 1
AND 	r.end_date_time >= NOW()
;

# [2.5.3] [스터디룸 상세 조회] T
-- 2번 스터디룸 상세 조회
-- id 컬럼 제외 모든 컬럼 조회할 수 있도록 프로시저 생성
DELIMITER $$

CREATE OR REPLACE PROCEDURE select_study_room(
	IN id INT(11)
)
BEGIN
    DECLARE columns_list VARCHAR(1000);

    -- Construct the column list excluding `study_room_id`
    SELECT GROUP_CONCAT(CONCAT('r.', COLUMN_NAME) SEPARATOR ', ')
    INTO columns_list
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'study_room'
    AND COLUMN_NAME != 'study_room_id'
    AND COLUMN_NAME != 'study_room_category_id';

    -- Construct the query
    SET @query = CONCAT('SELECT c.`name` AS category, ', columns_list, 
                        ' FROM study_room r INNER JOIN study_room_category c ',
                        ' ON c.study_room_category_id = r.study_room_category_id ',
                        ' WHERE r.study_room_id = ', id);

    -- Execute the query
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$

DELIMITER ;

-- 프로시저 호출
CALL select_study_room(2);


# [3.1.1] [주간 계획 생성] T
-- 12번 user (hoya) 새로운 1주차 주간계획 생성
INSERT INTO study_room_member_weekly_plan (study_room_id, study_room_member_id, plan_detail, created_date_time, weekly_plan_round_number) VALUES
(1, 12, 'solveSQL 5문제풀기', '2024-06-01 12:00:00', 1);

-- 생성 후 생성된 내용 화면에 띄우기 위해 조회
SELECT u.nickname,
		 r.`name`,
		 wp.weekly_plan_round_number,
		 wp.plan_detail,
		 wp.created_date_time
FROM study_room_member_weekly_plan wp
INNER JOIN study_room r ON wp.study_room_id = r.study_room_id
INNER JOIN study_room_member m ON wp.study_room_member_id = m.study_room_member_id
INNER JOIN `user` u ON m.user_id = u.user_id
WHERE wp.study_room_member_id = 12;

# [3.2.1] [주간 계획 조회] T

-- (Luisetti가 로그인 상태) 내 주간계획 조회
SELECT wp.weekly_plan_round_number,
		 wp.plan_detail,
		 wp.created_date_time
FROM study_room_member_weekly_plan wp
INNER JOIN study_room r ON wp.study_room_id = r.study_room_id
INNER JOIN study_room_member m ON wp.study_room_member_id = m.study_room_member_id
INNER JOIN `user` u ON m.user_id = u.user_id
WHERE wp.study_room_member_id = (SELECT srm.study_room_member_id
											FROM study_room_member srm
											INNER JOIN `user` u ON srm.user_id = u.user_id 
											WHERE u.nickname = 'Luisetti');

# [3.2.1] - 2  [같은 스터디룸 안의 주간 계획 조회] T

-- (Luisetti가 로그인 상태) 내가 참여하고 있는 스터디룸에서 다른 사람 주간계획 조회

-- 내가 참여하고 있는 스터디룸의 참가자들 띄우기
CREATE OR REPLACE VIEW my_study_room_members_view AS 
SELECT u.nickname
FROM study_room_member srm
INNER JOIN `user` u ON u.user_id = srm.user_id
INNER JOIN study_room sr ON sr.study_room_id = srm.study_room_id
WHERE srm.is_join_accepted = TRUE
AND 	sr.study_room_id = (SELECT srm.study_room_id 
									 FROM  study_room_member srm
									 INNER JOIN `user` u ON u.user_id = srm.user_id
									 WHERE nickname = 'Luisetti')
;

SELECT * FROM my_study_room_members_view;
;


-- 같은 스터디룸에 있는 Fliege의 주간 계획 보러 가기
DELIMITER $$
CREATE OR REPLACE PROCEDURE search_weekly_plan(
	IN clicked_nickname VARCHAR(10)
)
BEGIN 
	SELECT wp.weekly_plan_round_number,
			 wp.plan_detail,
			 wp.created_date_time
	FROM study_room_member_weekly_plan wp
	INNER JOIN study_room r ON wp.study_room_id = r.study_room_id
	INNER JOIN study_room_member m ON wp.study_room_member_id = m.study_room_member_id
	INNER JOIN `user` u ON m.user_id = u.user_id
	WHERE wp.study_room_member_id = (SELECT srm.study_room_member_id
												FROM study_room_member srm
												INNER JOIN `user` u ON srm.user_id = u.user_id 
												WHERE u.nickname = clicked_nickname);
END $$
DELIMITER ;

CALL search_weekly_plan('Fliege');


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
