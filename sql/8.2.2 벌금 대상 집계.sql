-- 스터디룸 생성 시 입력되었던 인증 주기, 인증 방법 정보를 바탕으로 대상을 집계한다.
SELECT 
    sr.study_room_id,
    sr.authentication_method,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
GROUP BY 
    sr.study_room_id, sr.authentication_method;

-- 벌금 대상은 기간 단위 내 스터디원 성취 여부를 기준으로 70% 이하 성취 시 집계되어야 한다.
SELECT 
    sr.study_room_id,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) AS total_achieved_todos,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT srm.study_room_member_id), 0) AS achievement_rate
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
GROUP BY 
    sr.study_room_id
HAVING 
    achievement_rate <= 0.7;
-- 벌금 대상은 기간 단위 다음날 05:00시 기준으로 집계되어야 한다.
SELECT 
    sr.study_room_id,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
WHERE 
    DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d 05:00:00'), INTERVAL 1 DAY) <= NOW()
GROUP BY 
    sr.study_room_id;



-- 벌금 대상은 기간 단위 기준으로 초기화되어야 한다.

-- 기간 단위로 초기화하는 쿼리 (예를 들어, 매주 월요일 오전 5시에 실행)
UPDATE 
    STUDY_ROOM_MEMBER_FINE
SET 
    fine_amount = 0
WHERE 
    DAYOFWEEK(NOW()) = 2 AND HOUR(NOW()) = 5; -- 월요일 오전 5시
   
-- 스터디룸 생성 시 입력되었던 인증 주기, 인증 방법 정보를 바탕으로 대상을 집계하는 테스트 케이스
SELECT 
    sr.study_room_id,
    sr.authentication_method,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
GROUP BY 
    sr.study_room_id, sr.authentication_method;

-- 벌금 대상은 기간 단위 내 스터디원 성취 여부를 기준으로 70% 이하 성취 시 집계되어야 한다.
SELECT 
    sr.study_room_id,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) AS total_achieved_todos,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT srm.study_room_member_id), 0) AS achievement_rate
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
GROUP BY 
    sr.study_room_id
HAVING 
    achievement_rate <= 0.7;

-- 벌금 대상은 기간 단위 다음날 05:00시 기준으로 집계되어야 한다.
SELECT 
    sr.study_room_id,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
WHERE 
    DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d 05:00:00'), INTERVAL 1 DAY) <= NOW()
GROUP BY 
    sr.study_room_id;

-- 벌금 대상은 기간 단위 기준으로 초기화되어야 한다.
-- 초기화 전
SELECT * FROM STUDY_ROOM_MEMBER_FINE;

-- 벌금 대상을 기간 단위로 초기화
UPDATE 
    STUDY_ROOM_MEMBER_FINE
SET 
    fine_amount = 0
WHERE 
    DAYOFWEEK(NOW()) = 2 AND HOUR(NOW()) = 5; -- 월요일 오전 5시

-- 초기화 후
SELECT * FROM STUDY_ROOM_MEMBER_FINE;

