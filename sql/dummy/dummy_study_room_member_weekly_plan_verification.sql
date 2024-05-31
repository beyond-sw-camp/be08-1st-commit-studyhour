USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION (study_room_member_weekly_plan_id, image_url, create_date_time) VALUES
(1, 'https://example.com/photo1.jpg', '2024-06-04 01:23'),
(3, 'https://example.com/photo3.jpg', '2024-06-03 15:42'),
(4, 'https://example.com/photo4.jpg', '2024-06-01 22:54'),
(6, 'https://example.com/photo6.jpg', '2024-06-07 11:08'),
(7, 'https://example.com/photo7.jpg', '2024-06-07 18:26'),
(8, 'https://example.com/photo8.jpg', '2024-06-04 02:39'),
(9, 'https://example.com/photo9.jpg', '2024-06-04 07:14'),
(13, 'https://example.com/photo13.jpg', '2024-06-13 10:43'),
(14, 'https://example.com/photo14.jpg', '2024-06-07 17:20'),
(15, 'https://example.com/photo15.jpg', '2024-06-08 00:58'),
(16, 'https://example.com/photo16.jpg', '2024-06-09 08:35'),
(18, 'https://example.com/photo18.jpg', '2024-06-10 21:49'),
(19, 'https://example.com/photo19.jpg', '2024-06-11 03:27'),
(20, 'https://example.com/photo20.jpg', '2024-06-13 12:05'),
(21, 'https://example.com/photo21.jpg', '2024-06-11 19:42'),
(22, 'https://example.com/photo22.jpg', '2024-06-11 06:19'),
(24, 'https://example.com/photo24.jpg', '2024-06-04 22:34'),
(30, 'https://example.com/photo30.jpg', '2024-06-02 12:17'),
(31, 'https://example.com/photo31.jpg', '2024-06-01 18:54'),
(32, 'https://example.com/photo32.jpg', '2024-06-07 02:31'),
(37, 'https://example.com/photo37.jpg', '2024-06-03 10:38'),
(38, 'https://example.com/photo38.jpg', '2024-06-03 17:16'),
(39, 'https://example.com/photo39.jpg', '2024-06-07 00:53'),
(40, 'https://example.com/photo40.jpg', '2024-06-02 08:30'),
(41, 'https://example.com/photo41.jpg', '2024-06-04 15:07'),
(42, 'https://example.com/photo42.jpg', '2024-06-03 21:44'),
(43, 'https://example.com/photo43.jpg', '2024-06-05 03:22'),
(47, 'https://example.com/photo47.jpg', '2024-06-08 14:51'),
(48, 'https://example.com/photo48.jpg', '2024-06-12 22:28'),
(49, 'https://example.com/photo49.jpg', '2024-06-07 01:05'),
(50, 'https://example.com/photo50.jpg', '2024-06-10 09:42'),
(51, 'https://example.com/photo51.jpg', '2024-06-08 16:19'),
(52, 'https://example.com/photo52.jpg', '2024-06-09 22:57'),
(53, 'https://example.com/photo53.jpg', '2024-06-11 10:43'),
(54, 'https://example.com/photo54.jpg', '2024-06-09 17:40'),
(57, 'https://example.com/photo57.jpg', '2024-06-10 11:12'),
(58, 'https://example.com/photo58.jpg', '2024-06-13 21:44'),
(59, 'https://example.com/photo59.jpg', '2024-06-11 03:27'),
(60, 'https://example.com/photo60.jpg', '2024-06-13 12:01'),
(61, 'https://example.com/photo61.jpg', '2024-06-06 00:53'),
(62, 'https://example.com/photo62.jpg', '2024-06-05 08:30'),
(63, 'https://example.com/photo63.jpg', '2024-06-08 15:07'),
(64, 'https://example.com/photo64.jpg', '2024-06-09 23:02')
;