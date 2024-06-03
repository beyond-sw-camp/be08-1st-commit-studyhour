USE study_hour;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_VERIFICATION_BY_USERNAME(
    USERNAME VARCHAR(15)
)
BEGIN
    SELECT u.username    AS '작성자',
           p.plan_detail AS '계획',
           v.image_url   AS '인증 사진'
    FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION v
             INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN p
                        ON v.study_room_member_weekly_plan_id = p.study_room_member_weekly_plan_id
             INNER JOIN STUDY_ROOM_MEMBER m ON p.study_room_member_id = m.study_room_member_id
             INNER JOIN USER u ON m.user_id = u.user_id
    WHERE u.username = USERNAME;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_VERIFICATION_EXIST_BY_ROOM_NAME_AND_USERNAME_AND_DURATION(
    STUDY_ROOM_NAME VARCHAR(30),
    USERNAME VARCHAR(15),
    STUDY_ROOM_DURATION INT
)
BEGIN
    SELECT r.name                             AS '스터디룸',
           u.username                         AS '작성자',
           p.plan_detail                      AS '계획',
           p.weekly_plan_round_number         AS '주차',
           NVL2(p.plan_duration, '인증', '미인증') AS '시간_인증_여부',
           NVL2(v.image_url, '인증', '미인증')     AS '사진_인증_여부'
    FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION v
             RIGHT JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN p
                        ON v.study_room_member_weekly_plan_id = p.study_room_member_weekly_plan_id
             INNER JOIN STUDY_ROOM r ON p.study_room_id = r.study_room_id
             INNER JOIN STUDY_ROOM_MEMBER m ON p.study_room_member_id = m.study_room_member_id
             INNER JOIN USER u ON u.user_id = m.user_id
    WHERE r.name = STUDY_ROOM_NAME
      AND p.weekly_plan_round_number = STUDY_ROOM_DURATION
      AND u.username = USERNAME;
END $$
DELIMITER ;


# [5.1.1] [타이머 인증]
-- Study Room 1번에 참가한 'Giselbert' 유저 계획 시간 업데이트
UPDATE STUDY_ROOM_MEMBER_WEEKLY_PLAN
SET plan_duration = (plan_duration + 10000)
WHERE study_room_member_weekly_plan_id = 2;

SELECT *
FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN p
         INNER JOIN STUDY_ROOM r ON p.study_room_id = r.study_room_id
         INNER JOIN STUDY_ROOM_MEMBER m ON p.study_room_member_id = m.study_room_member_id
         INNER JOIN USER u On m.user_id = u.user_id
WHERE username = 'Giselbert';

# [5.1.2] [사진 인증]
UPDATE STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION
SET image_url = '사진 인증 테스트'
WHERE study_room_member_weekly_plan_id = 2;

# [5.2.1] [스터디원 인증 여부 조회]
# Study Room 1번 2주차 인증여부 조회
CALL SELECT_VERIFICATION_EXIST_BY_ROOM_NAME_AND_USERNAME_AND_DURATION('자바로 알고리즘 공부하기', 'Giselbert', 2);


# [5.3.1] [인증 수정]
# 인증 사진 수정
UPDATE STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION
SET image_url = '사진 인증 수정 테스트'
WHERE study_room_member_weekly_plan_id = 2;

CALL SELECT_VERIFICATION_BY_USERNAME('Giselbert');


# [5.4.1] [인증 삭제]
-- DELETE PLAN_VERIFICATION_BY_USERNAME_AND_PLAN_DETAIL
DELETE
FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION
WHERE study_room_member_weekly_plan_verification_id = (SELECT v.study_room_member_weekly_plan_verification_id
                                                       FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION v
                                                                INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN p
                                                                           ON v.study_room_member_weekly_plan_id = p.study_room_member_weekly_plan_id
                                                                INNER JOIN STUDY_ROOM_MEMBER m ON p.study_room_member_id = m.study_room_member_id
                                                                INNER JOIN USER u ON m.user_id = u.user_id
                                                       WHERE u.username = 'Giselbert'
                                                         AND p.plan_detail = '토익 단어 500개 외우기');

CALL SELECT_VERIFICATION_BY_USERNAME('Giselbert');
