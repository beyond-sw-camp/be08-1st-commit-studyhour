use study_hour;

-- 스터디룸이 안끝났는데 일반 멤버가 회원 탈퇴 시 -> 해당 인원 스터디룸에서 제외

-- 평가, 게시판, 댓글 테이블은 살린다.
-- 주간계획, 인증, 벌금 테이블은 삭제.
-- study_room 내 인원 집계 시 해당 유저가 탈퇴했는지 안했는지 여부를 확인한다. - 참가인원 확인 시
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

        -- 탈퇴 유저 주간 계획 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_WEEKLY_PLAN
        WHERE study_room_member_id = (SELECT m.study_room_member_id
                                      FROM STUDY_ROOM_MEMBER m
                                      WHERE m.user_id = OLD.user_id);

        -- 탈퇴 유저 벌금 삭제
        DELETE
        FROM STUDY_ROOM_MEMBER_FINE
        WHERE study_room_member_id = (SELECT m.study_room_member_id
                                      FROM STUDY_ROOM_MEMBER m
                                      WHERE m.user_id = OLD.user_id);
    END IF;
END;
DELIMITER ;


SELECT *
FROM STUDY_ROOM_MEMBER m
         INNER JOIN USER u ON m.user_id = u.user_id
         INNER JOIN STUDY_ROOM_MEMBER_TODO todo ON m.study_room_member_id = todo.study_room_member_id
         INNER JOIN STUDY_ROOM_MEMBER_FINE fine ON m.study_room_member_id = fine.study_room_member_id
         INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN plan ON m.study_room_member_id = plan.study_room_member_id
         INNER JOIN STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION v
                    ON plan.study_room_member_weekly_plan_id = v.study_room_member_weekly_plan_id
WHERE m.study_room_id = 3;

