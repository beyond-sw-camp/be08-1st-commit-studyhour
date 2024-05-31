USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION (study_room_member_weekly_plan_id, week_duration_time, image_url, create_date_time) VALUES
-- study room 1(photo): week 1 (2번 미인증 -> 벌금 집계)
(1, NULL, 'https://example.com/verification1.jpg', '2024-06-06 23:11:47'),
(3, 142862, 'https://example.com/photo3.png', '2024-06-07 04:46:22'),
(4, 86234, 'https://example.com/art4.jpg', '2024-06-05 11:23:54'),

-- study room 1: week 2 (2번, 4번 미인증 -> 벌금 집계)
(1, NULL, 'https://example.com/verification1-2.jpg', '2024-06-13 22:16:31'),
(3, NULL, 'https://example.com/art3-2.png', '2024-06-13 00:11:43'),

-- study room 2(time): week 1 (전부 clear)
(5, 214375, NULL, '2024-06-06 11:23:12'),
(6, 221582, 'https://example.com/verification6.jpg', '2024-06-06 21:41:12'),
(7, 142862, NULL, '2024-06-03 17:41:32'),
(8, 86234, NULL, '2024-06-05 23:06:37'),
(9, 102837, NULL, '2024-06-02 01:22:41'),
(10, 121123, 'https://example.com/verification10.jpg', '2024-06-04 03:22:17'),

-- study room 2: week 2 (5번 7번 8번 미인증 -> 벌금 집계)
(6, 192782, 'https://example.com/photo6-2.jpg', '2024-06-13 21:26:49'),
(9, 133457, NULL, '2024-06-12 23:02:52'),
(10, 214521, 'https://example.com/verification10-2.jpg', '2024-06-13 11:26:17'),

-- study room 2: week 3 (9번 미인증 -> 벌금 집계)
(5, 123673, NULL, '2024-06-21 01:26:06'),
(6, 99887, 'https://example.com/art6-3.jpg', '2024-06-20 21:00:00'),
(7, 100029, NULL, '2024-06-19 21:06:27'),
(8, 189972, NULL, '2024-06-20 06:16:11'),
(10, 200012, NULL, '2024-06-20 23:11:08');
