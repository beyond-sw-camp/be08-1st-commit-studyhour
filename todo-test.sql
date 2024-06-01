USE study_hour;

# 투 두 테스트를 위한 프로시저
DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_STUDY_ROOM_MEMBER_TODO_ALL()
BEGIN
    SELECT r.name                                 AS '스터디룸',
           u.username                             AS '작성자',
           to_do.content                          AS '내용',
           to_do.created_date                     AS '작성일',
           IF(is_checked, 'CHECKED', 'UNCHECKED') AS '체크_여부'
    FROM STUDY_ROOM_MEMBER_TODO to_do
             INNER JOIN STUDY_ROOM_MEMBER m ON to_do.study_room_member_id = m.study_room_member_id
             INNER JOIN STUDY_ROOM r ON m.study_room_id = r.study_room_id
             INNER JOIN USER u ON m.user_id = u.user_id
    ORDER BY r.name;
END $$

DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME(
    IN USERNAME VARCHAR(15)
)
BEGIN
    SELECT r.name                                 AS '스터디룸',
           u.username                             AS '작성자',
           to_do.content                          AS '내용',
           to_do.created_date                     AS '작성일',
           IF(is_checked, 'CHECKED', 'UNCHECKED') AS '체크_여부'
    FROM STUDY_ROOM_MEMBER_TODO to_do
             INNER JOIN STUDY_ROOM_MEMBER m ON to_do.study_room_member_id = m.study_room_member_id
             INNER JOIN STUDY_ROOM r ON m.study_room_id = r.study_room_id
             INNER JOIN USER u ON m.user_id = u.user_id
    WHERE u.username = USERNAME
    ORDER BY r.name;
END $$
DELIMITER ;

# [4.1.1] [투 두 리스트 내용 입력] T
-- Giselbert 가 스터디룸 1번에서 투 두 리스트 작성
INSERT INTO STUDY_ROOM_MEMBER_TODO (study_room_member_id, content, created_date)
    VALUE (3, '투 두 리스트 작성 테스트', CURDATE());

CALL SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME('Giselbert');
# [4.2.1] [투 두 리스트 조회] T
-- 전체 스터디룸 내 모든 투 두 리스트 조회
CALL SELECT_STUDY_ROOM_MEMBER_TODO_ALL();

-- 유저 아이디 'Giselbert'가 작성한 투 두 리스트 조회
CALL SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME('Giselbert');


# [4.3.1] [투 두 리스트 수정] T
-- 유저 아이디 'Giselbert'가 작성한 투 두 리스트 수정
UPDATE STUDY_ROOM_MEMBER_TODO
SET content = '투 두 리스트 수정 테스트'
WHERE study_room_member_id = (SELECT study_room_member_id
                              FROM STUDY_ROOM_MEMBER m
                                       INNER JOIN USER u ON m.user_id = u.user_id
                              WHERE u.username = 'Giselbert');

CALL SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME('Giselbert');

# [4.4.1] [투 두 리스트 삭제] T
-- 유저 아이디 'Giselbert' 가 작성한 투 두 리스트 수정
UPDATE STUDY_ROOM_MEMBER_TODO
SET content = '투 두 리스트 수정 테스트'
WHERE study_room_member_todo_id = (SELECT to_do.study_room_member_todo_id
                                   FROM STUDY_ROOM_MEMBER_TODO to_do
                                            INNER JOIN STUDY_ROOM_MEMBER m
                                                       ON to_do.study_room_member_id = m.study_room_member_id
                                            INNER JOIN STUDY_ROOM r ON m.study_room_id = r.study_room_id
                                            INNER JOIN USER u ON m.user_id = u.user_id
                                   WHERE u.username = 'Giselbert'
                                   ORDER BY to_do.created_date
                                   LIMIT 1);

CALL SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME('Giselbert');
-- 처음으로 작성된 투 두 리스트 제거
DELETE
FROM STUDY_ROOM_MEMBER_TODO
WHERE study_room_member_todo_id = (SELECT to_do.study_room_member_todo_id
                                   FROM STUDY_ROOM_MEMBER_TODO to_do
                                            INNER JOIN STUDY_ROOM_MEMBER m
                                                       ON to_do.study_room_member_id = m.study_room_member_id
                                            INNER JOIN STUDY_ROOM r ON m.study_room_id = r.study_room_id
                                            INNER JOIN USER u ON m.user_id = u.user_id
                                   WHERE u.username = 'Giselbert'
                                   ORDER BY to_do.created_date
                                   LIMIT 1);

CALL SELECT_STUDY_ROOM_MEMBER_TODO_BY_USERNAME('Giselbert');

