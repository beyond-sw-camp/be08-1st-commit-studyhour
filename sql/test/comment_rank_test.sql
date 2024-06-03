USE study_hour;

# 스터디룸에서 댓글을 단 사람 순위
DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_COMMENT_COUNT_RANK_BY_ROOM_ID(
    ROOM_ID INT
)
BEGIN
    SELECT u.username                           AS '유저_아이디',
           RANK() over (ORDER BY COUNT(*) DESC) AS '댓글_작성_개수_순위'
    FROM STUDY_ROOM_BOARD_COMMENT c
             INNER JOIN STUDY_ROOM_BOARD b ON c.study_room_board_id = b.study_room_board_id
             INNER JOIN STUDY_ROOM_MEMBER m ON c.study_room_member_id = m.study_room_member_id
             INNER JOIN USER u ON m.user_id = u.user_id
    WHERE m.study_room_id = ROOM_ID
      AND u.username NOT LIKE '탈퇴%'
      AND u.nickname NOT LIKE '탈퇴%'
    GROUP BY u.username;
end $$
DELIMITER ;

CALL SELECT_COMMENT_COUNT_RANK_BY_ROOM_ID(1);

CALL SELECT_COMMENT_COUNT_RANK_BY_ROOM_ID(2);





