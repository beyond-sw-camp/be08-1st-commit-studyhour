use study_hour;

# 스터디룸 내 게시글 작성 개수 순위
DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_BOARD_COUNT_RANK_BY_ROOM_ID(
    ROOM_ID int
)
BEGIN
    SELECT u.username                           AS '작성자',
           COUNT(*)                             AS '작성_개수',
           RANK() over (ORDER BY COUNT(*) DESC) AS '게시글_작성_개수_순위'
    FROM STUDY_ROOM_BOARD b
             INNER JOIN STUDY_ROOM_MEMBER m ON b.study_room_member_id = m.study_room_member_id
             INNER JOIN USER u ON m.user_id = u.user_id
    WHERE m.study_room_id = ROOM_ID
    GROUP BY u.username
    ORDER BY '게시글_작성_개수_순위';
end $$
DELIMITER ;

CALL SELECT_BOARD_COUNT_RANK_BY_ROOM_ID(1);



