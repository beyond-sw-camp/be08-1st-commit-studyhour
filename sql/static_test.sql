-- 9.1.1 주간계획 총 개수 집계
-- ex : 자바로 알고리즘 공부하기 그룹 유저들의 1회차 주간계획 개수 출력
SELECT sr.name AS 'group name',
       u.username,
       COUNT(*) AS 'num of plan'
FROM study_room_member srm
INNER JOIN user u ON u.user_id = srm.user_id
INNER JOIN study_room_member_weekly_plan wp ON wp.study_room_member_id = srm.study_room_member_id
INNER JOIN study_room sr ON sr.study_room_id = srm.study_room_id
WHERE sr.name = '자바로 알고리즘 공부하기'
AND wp.weekly_plan_round_number = 1
AND srm.is_join_accepted = 1
GROUP BY sr.name, u.username
ORDER BY COUNT(*) DESC
;

-- 9.1.2 주간계획 총 소요시간 집계
-- sec_to_time 메소드 이용
SELECT sr.name AS 'group name',
       u.username,
       SEC_TO_TIME(SUM(wp.plan_duration)) AS 'total time'
FROM study_room_member srm
INNER JOIN user u ON u.user_id = srm.user_id
INNER JOIN study_room_member_weekly_plan wp ON wp.study_room_member_id = srm.study_room_member_id
INNER JOIN study_room sr ON sr.study_room_id = srm.study_room_id
WHERE sr.name = '자바로 알고리즘 공부하기'
AND wp.weekly_plan_round_number = 1
AND srm.is_join_accepted = 1
GROUP BY sr.name, u.username
ORDER BY COUNT(*) DESC
;

-- 9.2 주간 계획 평가 집계
-- 자바로~ 그룹의 1회차 주간 계획 평가개수
SELECT sr.name AS 'group name',
       u.username,
       COUNT(ev.study_room_member_weekly_plan_evaluation_id) AS 'num of evaluation'
FROM study_room_member srm
INNER JOIN user u ON u.user_id = srm.user_id
INNER JOIN study_room_member_weekly_plan wp ON wp.study_room_member_id = srm.study_room_member_id
INNER JOIN study_room sr ON sr.study_room_id = srm.study_room_id
INNER JOIN study_room_member_weekly_plan_evaluation ev ON ev.study_room_member_weekly_plan_id = wp.study_room_member_weekly_plan_id
WHERE sr.name = '자바로 알고리즘 공부하기'
AND wp.weekly_plan_round_number = 1
AND srm.is_join_accepted = 1
GROUP BY sr.name, u.username
ORDER BY 3 DESC;