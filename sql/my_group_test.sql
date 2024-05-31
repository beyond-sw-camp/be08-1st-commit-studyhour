SELECT * FROM study_room_member;
SELECT * FROM user;
SELECT * FROM study_room;

-- 준비 : 유저가 참가 수락 된 데이터만으로 뷰 만들어두기 
-- is_join_accepted로 스터디그룹 참여 가능 여부가 갈림
CREATE OR REPLACE VIEW myStudyRoomView AS 
SELECT u.username,
		 sr.name AS 'study_group_name', 
		 src.name AS 'category',
		 sr.description,
		 sr.max_capacity,
		 sr.start_date_time,
		 sr.end_date_time,
		 srmem.is_join_accepted,
		 sr.is_finished
FROM study_room_member srmem
INNER JOIN user u ON u.user_id = srmem.user_id
INNER JOIN study_room sr ON sr.study_room_id = srmem.study_room_id
INNER JOIN study_room_category src ON src.study_room_category_id = sr.study_room_category_id
WHERE srmem.is_join_accepted = true
;

SELECT * FROM mystudyroomview;
-- starla가 마이 스터디룸 서비스를 이용한다고 가정
-- [2.6.1] 마이스터디룸 조회 (스터디룸 이름, 종료여부)
SELECT study_group_name, if(is_finished, 'end (종료)', 'proceeding (진행중)') AS '종료여부'
FROM myStudyRoomView
WHERE username = 'starla'
;

-- [2.6.2] 마이 스터디룸 상세 조회 (스룸 이름, 소개, 카테고리명, 스터디 최대인원, 시작/끝 날짜)
SELECT * FROM myStudyRoomView
WHERE username = 'starla'
;

-- 스터디룸 참가중인 인원
SELECT COUNT(*) AS '참가인원',
FROM myStudyRoomView
GROUP BY study_group_name
HAVING study_group_name = (SELECT study_group_name FROM myStudyRoomView 
							WHERE username = 'starla')
;


-- [2.7.1] 스터디룸 퇴장 (음~)
-- is_join_accept를 false로 바꾸고, 권한 없애기
UPDATE study_room_member
SET is_join_accepted = false, privilege = null
WHERE user_id = (
						SELECT user_id FROM user
						WHERE username = 'starla'
					)
AND privilege = 'member'
;

-- [2.7.2] 스터디룸 부원 강퇴
-- starla가 방장이라면 luther을 자바로 알고리즘 공부하기에서 강퇴
DELIMITER $

CREATE OR REPLACE PROCEDURE multProc(
    IN MEMBER VARCHAR(15),
    IN study_group VARCHAR(30)
)
BEGIN
    DECLARE manager_check BOOLEAN;

    -- Check if the user 'starla' has manager privileges
    SELECT IF(privilege = 'manager', TRUE, FALSE)
    INTO manager_check
    FROM study_room_member
    WHERE user_id = (
        SELECT user_id FROM user
        WHERE username = 'starla'
    );

    -- If the user 'starla' is a manager, proceed with the removal
    IF manager_check THEN
        UPDATE study_room_member
        SET is_join_accepted = FALSE, privilege = NULL
        WHERE user_id = (
            SELECT user_id FROM user
            WHERE username = MEMBER
        )
        AND study_room_id = (
            SELECT study_room_id FROM study_room
            WHERE name = study_group
        );
    END IF;
END $

DELIMITER ;

CALL multProc('luther','자바로 알고리즘 공부하기');
