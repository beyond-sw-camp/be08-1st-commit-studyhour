use study_hour;

-- 게시판, 댓글 테이블은 살린다.
-- 탈퇴자에 대한 주간 계획, 평가, 인증, 벌금 테이블 삭제
DELIMITER $$
CREATE OR REPLACE TRIGGER DELETE_LEAVING_MEMBER_HISTORY
    AFTER UPDATE
    ON USER
    FOR EACH ROW
BEGIN
    IF NEW.username LIKE '탈퇴%' AND NEW.nickname LIKE '탈퇴%'
    THEN
        -- 탈퇴 유저 주간 계획 인증 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION
        WHERE study_room_member_weekly_plan_id in (SELECT p.study_room_member_weekly_plan_id
                                                   FROM STUDY_ROOM_MEMBER m
                                                            INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN p
                                                                       ON m.study_room_member_id = p.study_room_member_id
                                                   WHERE m.user_id = OLD.user_id);

        -- 탈퇴 유저 주간 계획에 대한 평가 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION
        WHERE study_room_member_weekly_plan_id IN (SELECT p.study_room_member_weekly_plan_id
                                                   FROM STUDY_ROOM_MEMBER m
                                                            INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN p
                                                                       ON m.study_room_member_id = p.study_room_member_id
                                                   WHERE m.user_id = OLD.user_id);

        -- 탈퇴 유저 주간 계획 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN
        WHERE study_room_member_id = (SELECT m.study_room_member_id
                                      FROM STUDY_ROOM_MEMBER m
                                      WHERE m.user_id = OLD.user_id);

        -- 탈퇴 유저 벌금 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_FINE
        WHERE study_room_member_id in (SELECT m.study_room_member_id
                                       FROM STUDY_ROOM_MEMBER m
                                       WHERE m.user_id = OLD.user_id);

        -- 탈퇴 유저 투두 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_TODO
        WHERE STUDY_ROOM_MEMBER_TODO.study_room_member_id in (SELECT t.study_room_member_id
                                                              FROM STUDY_ROOM_MEMBER m
                                                                       INNER JOIN STUDY_ROOM_MEMBER_TODO t
                                                                                  ON m.study_room_member_id = t.study_room_member_id
                                                              WHERE m.user_id = OLD.user_id);
    END IF;
END $$
DELIMITER ;

# 탈퇴 처리 테스트용 더미 데이터 추가
INSERT INTO USER (username, password, nickname, gender)
VALUES ('탈퇴 유저 1', '1234', '탈퇴 닉네임 1', 'M'),
       ('탈퇴 유저 2', '1234', '탈퇴 닉네임 2', 'M');

# 'Giselbert 유저 탈퇴'
UPDATE USER
SET username = CONCAT('탈퇴 유저 ', (SELECT COUNT(*) + 1 AS 'NEXT_COUNT'
                                 FROM USER
                                 WHERE username LIKE '탈퇴 유저%'
                                   AND nickname LIKE '탈퇴 닉네임%')),
    nickname = CONCAT('탈퇴 닉네임 ', (SELECT COUNT(*) + 1 AS 'NEXT_COUNT'
                                  FROM USER
                                  WHERE username LIKE '탈퇴 유저%'
                                    AND nickname LIKE '탈퇴 닉네임%')),
    password = NULL,
    gender   = NULL
WHERE username = 'Giselbert';

SELECT *
FROM USER;


SELECT *
FROM STUDY_ROOM_MEMBER m
         INNER JOIN USER u ON m.user_id = u.user_id
         LEFT JOIN STUDY_ROOM_MEMBER_TODO todo ON m.study_room_member_id = todo.study_room_member_id
         LEFT JOIN STUDY_ROOM_MEMBER_FINE fine ON m.study_room_member_id = fine.study_room_member_id
         LEFT JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN plan ON m.study_room_member_id = plan.study_room_member_id
         LEFT JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION v
                   ON plan.study_room_member_weekly_plan_id = v.study_room_member_weekly_plan_id
WHERE m.study_room_id = 1
  AND username LIKE '탈퇴%';
