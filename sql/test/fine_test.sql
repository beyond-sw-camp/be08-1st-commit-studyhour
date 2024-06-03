-- 스터디룸 생성 시 입력되었던 인증 주기(1주 기준), 인증 방법, 벌금 정보를 바탕으로 액수가 집계된다.
SELECT 
    sr.study_room_id,
    sr.authentication_method,
    sr.fine,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members,
    SUM(CASE WHEN ss.attendance = 'PRESENT' THEN 1 ELSE 0 END) AS total_attended_rounds,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) AS total_achieved_todos,
    SUM(CASE WHEN ss.pay_fine = '12000' THEN 1 ELSE 0 END) AS total_fined_rounds,
    SUM(CASE WHEN ss.pay_fine = '12000' THEN srmf.fine_amount ELSE 0 END) AS total_fine_amount
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
LEFT JOIN 
    STUDY_ROOM_MEMBER_FINE srmf ON srm.study_room_member_id = srmf.study_room_member_id
GROUP BY 
    sr.study_room_id, sr.authentication_method, sr.fine;
    

SELECT * FROM statistics;

-- 벌금은 기간 단위 내 스터디원 성취 여부를 기준으로 70% 이하 성취 시 집계되어야 한다.
SELECT 
    sr.study_room_id,
    sr.authentication_method,
    sr.fine,
    COUNT(DISTINCT srm.study_room_member_id) AS total_members,
    SUM(CASE WHEN ss.attendance = 'PRESENT' THEN 1 ELSE 0 END) AS total_attended_rounds,
    SUM(CASE WHEN ss.todo_achievement = 'ACHIEVED' THEN 1 ELSE 0 END) AS total_achieved_todos,
    SUM(CASE WHEN ss.pay_fine = '12000' THEN 1 ELSE 0 END) AS total_fined_rounds,
    SUM(CASE WHEN ss.pay_fine = '12000' AND 
        (SELECT 
            COUNT(*) 
        FROM 
            STATISTICS 
        WHERE 
            study_room_id = sr.study_room_id 
            AND todo_achievement = 'ACHIEVED'
            AND pay_fine = '12000'
        ) / NULLIF(
            (SELECT 
                COUNT(*) 
            FROM 
                STATISTICS 
            WHERE 
                study_room_id = sr.study_room_id 
                AND pay_fine = 'YES'
            ), 0) <= 0.7 THEN 1 ELSE 0 END) AS total_fined_due_to_achievement_rate,
    SUM(CASE WHEN ss.pay_fine = 'YES' THEN srmf.fine_amount ELSE 0 END) AS total_fine_amount
FROM 
    STUDY_ROOM sr
LEFT JOIN 
    STUDY_ROOM_MEMBER srm ON sr.study_room_id = srm.study_room_id
LEFT JOIN 
    STATISTICS ss ON sr.study_room_id = ss.study_room_id
LEFT JOIN 
    STUDY_ROOM_MEMBER_FINE srmf ON srm.study_room_member_id = srmf.study_room_member_id
GROUP BY 
    sr.study_room_id, sr.authentication_method, sr.fine;


-- 집계된 벌금 액수는 주간 단위 다음날 05:00 기준으로 계산되어야 한다.
 SELECT *
FROM STUDY_ROOM_MEMBER_FINE
WHERE DATE_ADD(NOW(), INTERVAL 1 WEEK) >= DATE_FORMAT(NOW(), '%Y-%m-%d 05:00:00');



-- 집계된 벌금 액수는 주간 단위 기준으로 초기화되어야 한다.
UPDATE STUDY_ROOM_MEMBER_FINE
SET fine_amount = 0
WHERE DAYOFWEEK(NOW()) = 2 AND HOUR(NOW()) = 5; -- 월요일 오전 5시


-- STUDY_ROOM_MEMBER_FINE 테이블에 더미 데이터 삽입
INSERT INTO STUDY_ROOM_MEMBER_FINE (study_room_member_id, get_fine_round, fine_amount)
VALUES 
    (1, 1, 100),
    (2, 1, 200),
    (3, 1, 0),
    (4, 1, 300);

-- 주간 벌금 초기화 쿼리를 실행하기 전에 현재 STUDY_ROOM_MEMBER_FINE 테이블의 데이터 출력
SELECT * FROM STUDY_ROOM_MEMBER_FINE;

-- 주간 벌금 초기화 쿼리 실행
UPDATE STUDY_ROOM_MEMBER_FINE
SET fine_amount = 0
WHERE DAYOFWEEK(NOW()) = 2 AND HOUR(NOW()) = 5; -- 월요일 오전 5시

-- 주간 벌금 초기화 후 STUDY_ROOM_MEMBER_FINE 테이블의 데이터 출력
SELECT * FROM STUDY_ROOM_MEMBER_FINE;

-- 주간 벌금 액수가 주간 단위 다음날 05:00 기준으로 계산되는지 확인하는 쿼리
SELECT *
FROM STUDY_ROOM_MEMBER_FINE
WHERE DATE_ADD(NOW(), INTERVAL 1 WEEK) >= DATE_FORMAT(NOW(), '%Y-%m-%d 05:00:00');

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

