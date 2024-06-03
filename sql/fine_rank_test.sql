# 벌금 액수 집계 통계 쿼리(탈퇴 회원 제외, 동순위 rank)

use study_hour;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SELECT_FINE_COUNT_RANK_BY_ROOM_ID (
    room_id INT
)
BEGIN
    SELECT c.username, get_fine_round, sum(fine_amount) as total_fine_amount, RANK() OVER (PARTITION BY get_fine_round ORDER BY sum(fine_amount) DESC) AS rank
    FROM STUDY_ROOM_MEMBER_FINE a
             INNER JOIN STUDY_ROOM_MEMBER b ON a.study_room_member_id = b.study_room_member_id
             INNER JOIN USER c ON b.user_id = c.user_id
    WHERE b.study_room_id = room_id AND c.username NOT LIKE '탈퇴*'
    GROUP BY c.username
    ORDER BY total_fine_amount DESC;
end $$
DELIMITER ;

CALL SELECT_FINE_COUNT_RANK_BY_ROOM_ID(1);