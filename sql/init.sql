USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS USER;
DROP TABLE IF EXISTS USER_PROFILE;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER_TODO;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER_FINE;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION;
DROP TABLE IF EXISTS STUDY_ROOM;
DROP TABLE IF EXISTS STUDY_ROOM_CATEGORY;
DROP TABLE IF EXISTS STUDY_ROOM_BOARD;
DROP TABLE IF EXISTS STUDY_ROOM_BOARD_COMMENT;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER_WEEKLY_PLAN;
DROP TABLE IF EXISTS STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION;
DROP TABLE IF EXISTS STATISTICS;
-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `USER`
(
    `user_id`  INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(15) UNIQUE NOT NULL,
    `password` VARCHAR(64)        NOT NULL,
    `nickname` VARCHAR(10) UNIQUE NOT NULL,
    `gender`   ENUM ('M','F')     NOT NULL
);

CREATE TABLE `USER_PROFILE`
(
    `user_profile_id`   INT PRIMARY KEY AUTO_INCREMENT,
    `user_id`           INT          NOT NULL,
    `age`               TINYINT      NULL,
    `interest`          VARCHAR(255) NULL,
    `state_message`     VARCHAR(100) NULL,
    `profile_image_url` VARCHAR(255) NULL,
    FOREIGN KEY (user_id) REFERENCES USER (user_id)
);

CREATE TABLE `STUDY_ROOM_MEMBER`
(
    `study_room_member_id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id`              INT                        NOT NULL,
    `study_room_id`        INT                        NOT NULL,
    `is_join_accepted`     BOOLEAN                    NOT NULL,
    `privilege`            ENUM ('MANAGER', 'MEMBER') NULL DEFAULT NULL,
    `join_date_time`       TIMESTAMP                  NOT NULL,
    FOREIGN KEY (user_id) REFERENCES USER (user_id),
    FOREIGN KEY (study_room_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);

CREATE TABLE `STUDY_ROOM_MEMBER_FINE`
(
    `study_room_member_fine_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_member_id`      INT NOT NULL,
    `get_fine_round`            INT NOT NULL,
    `fine_amount`               INT NOT NULL DEFAULT 0 CHECK (fine_amount BETWEEN 0 AND 100000),
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);



CREATE TABLE `STUDY_ROOM_MEMBER_TODO`
(
    `study_room_member_todo_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_member_id`      INT          NOT NULL,
    `content`                   VARCHAR(200) NULL,
    `created_date`              DATE         NOT NULL,
    `is_checked`                BOOLEAN      NOT NULL DEFAULT FALSE,
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);

CREATE TABLE STUDY_ROOM_CATEGORY
(
    study_room_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name                   VARCHAR(24) UNIQUE NOT NULL
);

CREATE TABLE `STUDY_ROOM`
(
    `study_room_id`          INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_category_id` INT                    NOT NULL,
    `name`                   VARCHAR(30)            NOT NULL,
    `is_public`              boolean                NOT NULL,
    `private_password`            VARCHAR(64)           NULL,
    `description`            VARCHAR(500)           NULL,
    `max_capacity`           TINYINT                NOT NULL CHECK (max_capacity BETWEEN 2 AND 30),
    `authentication_method`  ENUM ('TIME', 'PHOTO') NOT NULL,
    `fine`                   INT                    NOT NULL DEFAULT 0 CHECK ((fine BETWEEN 0 AND 100000) AND (fine % 1000 = 0)),
    `current_study_round`    INT                    NOT NULL DEFAULT 1,
    `start_date_time`        TIMESTAMP              NOT NULL,
    `end_date_time`          TIMESTAMP              NOT NULL,
    `created_date_time`      TIMESTAMP              NOT NULL,
    `is_finished`            BOOLEAN                NOT NULL DEFAULT TRUE,
    FOREIGN KEY (study_room_category_id) REFERENCES STUDY_ROOM_CATEGORY (study_room_category_id)
);

CREATE TABLE `STUDY_ROOM_BOARD`
(
    `study_room_board_id`  INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_id`        INT           NOT NULL,
    `study_room_member_id` INT           NOT NULL,
    `title`                VARCHAR(50)   NOT NULL,
    `content`              VARCHAR(1000) NOT NULL,
    `created_date_time`    TIMESTAMP     NOT NULL,
    FOREIGN KEY (study_room_id) REFERENCES STUDY_ROOM (study_room_id),
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);

CREATE TABLE `STUDY_ROOM_BOARD_COMMENT`
(
    `study_room_board_comment_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_board_id`         INT          NOT NULL,
    `study_room_member_id`        INT          NOT NULL,
    `content`                     VARCHAR(200) NOT NULL,
    `created_date_time`           TIMESTAMP    NOT NULL,
    FOREIGN KEY (study_room_board_id) REFERENCES STUDY_ROOM_BOARD (study_room_board_id),
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);

CREATE TABLE `STUDY_ROOM_MEMBER_WEEKLY_PLAN`
(
    `study_room_member_weekly_plan_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_id`                    INT          NOT NULL,
    `study_room_member_id`             INT          NOT NULL,
    `plan_detail`                      VARCHAR(500) NULL,
    `plan_duration`                    INT          NULL,
    `created_date_time`                TIMESTAMP    NOT NULL,
    `weekly_plan_round_number`         INT          NOT NULL,
    FOREIGN KEY (study_room_id) REFERENCES STUDY_ROOM (study_room_id),
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);

CREATE TABLE `STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION`
(
    `study_room_member_weekly_plan_verification_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_member_weekly_plan_id`              INT          NOT NULL,
    `image_url`                                     VARCHAR(255) NULL,
    `create_date_time`                              TIMESTAMP    NOT NULL,
    FOREIGN KEY (study_room_member_weekly_plan_id) REFERENCES STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_member_weekly_plan_id)
);

CREATE TABLE `STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION`
(
    `study_room_member_weekly_plan_evaluation_id` INT PRIMARY KEY AUTO_INCREMENT,
    `study_room_member_weekly_plan_id`            INT        NOT NULL,
    `study_room_member_id`                        INT        NOT NULL,
    `evaluation_date_time`                        TIMESTAMP  NOT NULL,
    `evaluation_icon`                             VARCHAR(2) NOT NULL,
    FOREIGN KEY (study_room_member_weekly_plan_id) REFERENCES STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_member_weekly_plan_id),
    FOREIGN KEY (study_room_member_id) REFERENCES STUDY_ROOM_MEMBER (study_room_member_id)
);


-- USER 테이블에 더미 데이터 추가
insert into USER (username, password, nickname, gender)
values ('Edwina', '$2a$04$GOglKss2VCos4w3Z.uipYOwuAS3/mjzpG2siDn8/Ob9cn4A5y7.TC', 'Luisetti', 'F');
insert into USER (username, password, nickname, gender)
values ('Giselbert', '$2a$04$ddcb7A1iCrYkPo3BP3nV/OLt8rHKcXGaZGtNL8mPVFOgRTcVt7MAa', 'Fliege', 'M');
insert into USER (username, password, nickname, gender)
values ('Luther', '$2a$04$l2PSFsKugum4enrKK6JncOg1OlPHNk.7W7ggQwSlOfzjTcuEYVbmu', 'Dandie', 'M');
insert into USER (username, password, nickname, gender)
values ('Starla', '$2a$04$gThssYsSDNo4X3XpqJX8GujuymYLuvXXaXSdzg6TbZqpADb1yXWey', 'Madrell', 'F');
insert into USER (username, password, nickname, gender)
values ('Neddy', '$2a$04$JP5uY8i/u/IYS3VPWqq2yeK/94tWYZagX4TlsRM9Dd/cNYD42xu/a', 'Walczak', 'M');
insert into USER (username, password, nickname, gender)
values ('Deana', '$2a$04$szQdeg7Fbd.qZHmSiX5nFOZnABm/swdEy3GKMmABQXqhTn5YxlbQa', 'Dwyer', 'F');
insert into USER (username, password, nickname, gender)
values ('Betti', '$2a$04$exc08b5nJoSVpw7InTA4aOU7etvyI8LJuaju1VMs5ZU/7.iatfrta', 'Elster', 'F');
insert into USER (username, password, nickname, gender)
values ('Ellary', '$2a$04$UO88JZdRUP8xmtYKVXnJMuDDF7dZccpLV9Wq7i6ZWOM5fkpNguxLa', 'Berth', 'M');
insert into USER (username, password, nickname, gender)
values ('Ethelind', '$2a$04$.J1nMeMO4hBXY1lXNWKl5u9dc3wysmvkj4JPicqADdv2fmGwaFtQC', 'Courtenay', 'F');
insert into USER (username, password, nickname, gender)
values ('Solomon', '$2a$04$aan5YKQzYoKF81UlTbwObu7kJObFPSRvEW5cCU9szmfw4Ndz4yNxy', 'Kirlin', 'M');
insert into USER (username, password, nickname, gender)
values ('Sydney', '$2a$04$zbKGdxGGNmH6olFKdoXNeO/.bVbAqCLMFtqyA265FOwfN.N7A98Dm', 'Voisey', 'M');
insert into USER (username, password, nickname, gender)
values ('Pierce', '$2a$04$k6wAkd2ZYuFpMsGcng8RtuyG4S7Z31LKxNuM3IQDRtBW.c3dWP1zW', 'Blader', 'M');

-- USER_PROFILE 테이블에 더미 데이터 추가
INSERT INTO USER_PROFILE (user_id, age, interest, state_message, profile_image_url)
VALUES (1, 25, 'Programming', 'Hello, I am User One', 'https://example.com/profile1.jpg'),
       (2, 30, 'Photography', 'Nice to meet you. I am User Two', 'https://example.com/profile2.jpg'),
       (3, 22, 'Reading', 'User Three here!', 'https://example.com/profile3.jpg'),
       (4, 28, 'Music', 'User Four says hi!', 'https://example.com/profile4.jpg'),
       (5, 26, 'Gaming', 'Hello from User Five', 'https://example.com/profile5.jpg'),
       (6, 32, 'Cooking', 'User Six at your service', 'https://example.com/profile6.jpg'),
       (7, 29, 'Travel', 'Greetings from User Seven', 'https://example.com/profile7.jpg'),
       (8, 27, 'Fitness', 'User Eight reporting in!', 'https://example.com/profile8.jpg'),
       (9, 24, 'Art', 'User Nine here!', 'https://example.com/profile9.jpg'),
       (10, 31, 'Movies', 'User Ten says hello', 'https://example.com/profile10.jpg');

-- STUDY_ROOM_CATEGORY 테이블에 더미 데이터 추가
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (1, 'Navigator L');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (2, 'Fleetwood');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (3, 'Metro');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (4, 'Caravan');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (5, 'Freestar');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (6, 'A8');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (7, 'Sportage');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (8, 'Impala');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (9, 'Catera');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name)
values (10, 'Sunbird');


-- STUDY_ROOM 테이블에 더미 데이터 추가
INSERT INTO STUDY_ROOM (study_room_category_id, name, is_public, private_password, description, max_capacity,
                        authentication_method, fine, current_study_round, start_date_time, end_date_time,
                        created_date_time, is_finished)
VALUES (1, '자바로 알고리즘 공부하기', TRUE, NULL, '자바로 코테 뿌수기, 빡시게할 사람만 오세요.', 12, 'PHOTO', 12000, 1, '2024-05-31 12:00:00',
        '2024-06-14 05:00:00', '2024-05-30 19:20:00', FALSE),
       (2, '파이썬으로 알고리즘 공부하기', TRUE, NULL, '파이썬으로 코테 날먹하자, 날먹 좋아하는 사람만 오세요', 12, 'TIME', 5000, 1, '2024-05-31 12:00:00',
        '2024-06-21 05:00:00', '2024-05-30 19:20:00', FALSE)
;

-- STUDY_ROOM_MEMBER 테이블에 더미 데이터 추가
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (1, 1, 1, 'MANAGER', '2024-05-30 19:20:00');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (5, 2, 1, 'MANAGER', '2024-05-30 19:20:00');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (2, 1, 1, 'MEMBER', '2024-05-30 19:25:21');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (3, 1, 1, 'MEMBER', '2024-05-30 19:30:33');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (6, 2, 1, 'MEMBER', '2024-05-30 19:00:15');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (7, 2, 1, 'MEMBER', '2024-05-30 21:05:02');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (4, 1, 1, 'MEMBER', '2024-06-01 09:32:46');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (10, 2, 1, 'MEMBER', '2024-06-01 10:22:35');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (9, 2, 1, 'MEMBER', '2024-06-01 11:12:13');
INSERT INTO study_room_member (user_id, study_room_id, is_join_accepted, privilege, join_date_time)
VALUES (8, 2, 1, 'MEMBER', '2024-06-01 11:39:27');

-- STUDY_ROOM_BOARD 테이블에 더미 데이터 추가
INSERT INTO study_room_board (study_room_id, study_room_member_id, title, content, created_date_time)
VALUES (1, 1, '혼공자 스터디', '안녕하세요. 혼공자 모음~ 자유롭게 질문해주세요~!', '2024-05-31 19:00:00'),
       (2, 6, '프랑스어 마스터', '프랑스어를 마스터하기 위해 함께 공부하는 스터디입니다. 각자 학습한 내용을 공유합니다.', '2024-05-31 19:00:00'),
       (1, 1, '정처기 준비중', '자바 파면서 정보처리기사 준비.. 모두 파이팅입니다.', '2024-05-31 20:00:00'),
       (1, 2, '자바 알고리즘 스터디', '같이 하실분??', '2024-06-01 19:00:00'),
       (2, 7, '코딩테스트 준비방', '하반기 입사 지원 예정인 사람들을 위한 스터디입니다.', '2024-06-01 19:00:00'),
       (1, 2, '코테동', '모두가 코딩테스트 통과하는 그날까지 달려봅시다.', '2024-06-01 20:00:00'),
       (1, 1, '자바 기초할 사람?', '함께할 말하는 감자들 구함', '2024-06-02 19:00:00'),
       (2, 8, '지적직 공무원 준비', '지적직 공무원 준비 스터디입니다. 함께 열심히 해봐요!', '2024-06-02 19:00:00'),
       (1, 3, '한화 코테 준비', '한화시스템 코테 입사 관련한 취업 준비 스터디할 사람 일정 댓글로 지속적으로 공유하겠습니다.', '2024-06-02 20:00:00'),
       (1, 3, '상속.. 어려움', '기초 안되어있는디.. 다시 공부해야겠지..?.', '2024-06-03 19:00:00'),
       (2, 9, '서울여대 사회복지학과 19학번', '함께 공부해유~!', '2024-06-03 19:00:00'),
       (1, 2, '프로그래밍 챌린지', '매주 월요일 새로운 프로그래밍 문제를 풀며, 실력을 쌓아가는 스터디 만듭니다. 코드 리뷰도 함께 합니다.', '2024-06-03 20:00:00'),
       (1, 3, '독서 토론 모임', '자바 관련한 책 한 달에 한 권의 책을 읽고, 그에 대해 깊이 있게 토론하는 모임입니다. 과도한 친목은 금지입니다!', '2024-06-04 19:00:00'),
       (2, 10, '디지털 마케팅 전문가', '디지털 마케팅의 다양한 전략과 실무를 배우고 실습하는 스터디입니다.', '2024-06-04 19:00:00'),
       (1, 4, '말하는 감자 구출.. 제발..', '파이썬에서 넘어 와서 뭘해야 할지 막막해.. 조언 좀..', '2024-06-04 20:00:00'),
       (1, 4, '프로젝트 관리 마스터', 'PM으로 성장하기 위해서 개발 공부하는 사람들 있나?.', '2024-06-05 19:00:00'),
       (2, 6, '건강한 라이프 스타일', '건강한 식습관과 운동법을 배우고, 실천하는 스터디입니다.', '2024-06-05 19:00:00'),
       (1, 3, '학교 코딩 과제인데.. 몰루..', '어렵다 어려워..', '2024-06-05 20:00:00'),
       (1, 3, '자바 가끔 이유 없이 오류남', '나만 그런줄 알았는데 친구들도 그러더라구 그래서 끄고 다시하면 됌 참고 ㄱㄱ', '2024-06-06 19:00:00'),
       (2, 7, '창업 준비반', '창업을 준비하며 아이디어를 구체화하고, 사업 계획을 작성하는 스터디입니다.', '2024-06-06 19:00:00'),
       (1, 1, '고생했슈', '내일이면.. 안녕이다..', '2024-06-06 20:00:00'),
       (1, 2, '이제 끝나네유', '다들 수고하셨습니다~!.', '2024-06-07 19:00:00'),
       (2, 8, '패션 디자인 도전', '패션 디자인에 관심 있는 사람들을 위한 스터디입니다. 디자인을 배우고, 작품을 만들고 공유합니다.', '2024-06-07 19:00:00'),
       (2, 9, '스페인어 마스터', '스페인어를 배우고, 회화 실력을 기르기 위한 스터디입니다.', '2024-06-08 19:00:00'),
       (2, 10, '사진 촬영 기법', '사진 촬영 기술을 배우고, 함께 출사 나가서 실습하는 스터디입니다.', '2024-06-09 19:00:00'),
       (2, 6, '건축 설계 실습', '건축 설계 이론을 배우고, 실제 설계 프로젝트를 진행하는 스터디입니다.', '2024-06-10 19:00:00'),
       (2, 7, '인공지능 연구', '인공지능의 이론과 실제를 연구하고, 프로젝트를 진행하는 스터디입니다.', '2024-06-11 19:00:00'),
       (2, 8, '고등학교 수학 완전정복', '고등학교 수학 문제를 완전히 정복하기 위한 스터디입니다.', '2024-06-12 19:00:00'),
       (2, 9, '역사 토론 모임', '역사적인 사건과 인물에 대해 깊이 있는 토론을 진행하는 모임입니다.', '2024-06-13 19:00:00'),
       (2, 9, '9급 공무원 최종 도전', '마지막으로 도전하는 9급 공무원 시험 준비를 위한 스터디입니다.', '2024-06-13 20:00:00');

-- STUDY_ROOM_BOARD_COMMENT 테이블에 더미 데이터 추가
INSERT INTO study_room_board_comment (study_room_board_id, study_room_member_id, content, created_date_time)
VALUES (1, 1, '반가워요! 새로운 게시글에 댓글을 달아봅니다.', '2024-05-31 19:01:00'),
       (2, 6, '공부하는 재미를 느끼고 있어요.', '2024-05-31 19:45:00'),
       (1, 2, '오늘도 힘차게 공부해봅시다!', '2024-05-31 19:10:00'),
       (1, 4, '파이팅이얌ㅎㅎ ><', '2024-05-31 21:04:00'),
       (2, 7, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-05-31 22:05:00'),
       (2, 8, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-05-31 23:11:00'),
       (3, 1, '공부를 하면서 즐거움을 느끼고 있어요.', '2024-06-01 00:11:00'),
       (3, 3, '오늘은 새로운 주제를 공부해보려고요. 항상 감사합니다.', '2024-06-01 19:13:00'),
       (4, 4, '어려운 문제가 있으면 함께 해결해봐요.', '2024-06-01 19:05:00'),
       (4, 3, '모르는 내용은 서로 물어보면서 공부해요.', '2024-06-01 19:11:00'),
       (5, 9, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-01 19:11:00'),
       (6, 1, '오늘도 힘차게 시작해보려고요!', '2024-06-01 20:03:00'),
       (4, 1, '파이팅입니당~!', '2024-06-01 20:21:00'),
       (5, 7, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-01 20:21:00'),
       (6, 2, '새로운 공부법을 시도해보고 있어요.', '2024-06-01 20:22:00'),
       (6, 3, '조금씩이라도 나아지고 있어요.', '2024-06-01 22:44:00'),
       (5, 5, '새로운 공부법을 찾아보려고 해요.', '2024-06-02 00:11:00'),
       (8, 9, '어제보다 조금 더 발전한 것 같아요.', '2024-06-02 19:03:00'),
       (7, 4, '어제보다 더 열심히 공부해보려고요.', '2024-06-02 19:13:00'),
       (7, 2, '새로운 주제에 대해 알아가는 중이에요.', '2024-06-02 19:58:00'),
       (9, 2, '공부하는 재미를 느끼고 있어요.', '2024-06-02 20:45:00'),
       (8, 8, '조금씩이라도 나아지고 있어요.', '2024-06-02 21:40:00'),
       (9, 3, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-02 21:05:00'),
       (9, 4, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-03 00:31:00'),
       (7, 1, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-03 06:35:00'),
       (10, 1, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-03 02:21:00'),
       (10, 2, '새로운 공부법을 찾아보려고 해요.', '2024-06-03 12:45:00'),
       (10, 10, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-03 19:34:00'),
       (11, 6, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-03 19:33:00'),
       (11, 7, '공부하는 재미를 느끼고 있어요.', '2024-06-03 22:22:00'),
       (12, 3, '어제보다 조금 더 발전한 것 같아요.', '2024-06-04 01:45:00'),
       (12, 4, '조금씩이라도 나아지고 있어요.', '2024-06-04 10:10:00'),
       (12, 1, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-04 12:21:00'),
       (13, 1, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-04 19:30:00'),
       (14, 5, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-04 19:45:00'),
       (15, 4, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-04 20:12:00'),
       (14, 6, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-04 20:45:00'),
       (13, 2, '공부하는 재미를 느끼고 있어요.', '2024-06-04 20:48:00'),
       (15, 3, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-04 20:31:00'),
       (13, 3, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-04 23:01:00'),
       (15, 1, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-04 22:18:00'),
       (16, 2, '새로운 공부법을 찾아보려고 해요.', '2024-06-05 19:30:00'),
       (17, 7, '새로운 공부법을 찾아보려고 해요.', '2024-06-05 19:21:00'),
       (18, 4, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-05 20:49:00'),
       (14, 5, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-05 20:45:00'),
       (16, 3, '어제보다 조금 더 발전한 것 같아요.', '2024-06-05 21:01:00'),
       (18, 1, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-05 22:03:00'),
       (17, 10, '어제보다 조금 더 발전한 것 같아요.', '2024-06-05 22:41:00'),
       (18, 2, '공부하는 재미를 느끼고 있어요.', '2024-06-05 23:11:00'),
       (16, 4, '조금씩이라도 나아지고 있어요.', '2024-06-06 00:05:00'),
       (21, 1, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-06 20:01:00'),
       (21, 2, '새로운 공부법을 찾아보려고 해요.', '2024-06-06 21:31:00'),
       (19, 3, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-06 19:11:00'),
       (19, 4, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-06 22:04:00'),
       (21, 3, '어제보다 조금 더 발전한 것 같아요.', '2024-06-07 02:01:12'),
       (19, 5, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-07 01:01:00'),
       (23, 9, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-07 19:43:00'),
       (24, 6, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-09 00:23:00'),
       (23, 6, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-07 23:12:00'),
       (22, 4, '조금씩이라도 나아지고 있어요.', '2024-06-07 19:00:00'),
       (20, 5, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-07 12:45:00'),
       (23, 8, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-08 00:13:00'),
       (22, 2, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-08 22:45:00'),
       (20, 8, '공부하는 재미를 느끼고 있어요.', '2024-06-08 12:22:00'),
       (24, 7, '새로운 공부법을 찾아보려고 해요.', '2024-06-09 02:11:00'),
       (24, 5, '어제보다 조금 더 발전한 것 같아요.', '2024-06-10 06:45:00'),
       (25, 9, '조금씩이라도 나아지고 있어요.', '2024-06-09 19:52:00'),
       (25, 7, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-09 19:58:00'),
       (25, 8, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-09 20:01:00'),
       (22, 1, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-09 06:12:00'),
       (26, 10, '공부하는 재미를 느끼고 있어요.', '2024-06-10 19:03:00'),
       (26, 7, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-11 21:23:00'),
       (27, 10, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-11 20:21:00'),
       (26, 5, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-13 10:12:00'),
       (28, 10, '어제보다 조금 더 발전한 것 같아요.', '2024-06-13 00:45:00'),
       (28, 6, '조금씩이라도 나아지고 있어요.', '2024-06-13 01:00:00'),
       (28, 5, '새로운 주제를 공부하면서 재미를 느끼고 있어요.', '2024-06-13 02:22:00'),
       (30, 7, '서로 물어보면서 배우는 재미를 느끼고 있어요.', '2024-06-13 20:05:00'),
       (29, 10, '오늘은 좀 더 집중해서 공부해보려고요.', '2024-06-13 19:45:00'),
       (29, 7, '공부하는 재미를 느끼고 있어요.', '2024-06-13 20:22:00'),
       (30, 6, '힘차게 공부한 후에는 보상도 필요해요.', '2024-06-13 20:30:00'),
       (29, 8, '어려운 문제도 함께 해결하면 해낼 수 있어요.', '2024-06-14 01:03:00'),
       (30, 10, '오늘도 새로운 도전을 시작해보려고요.', '2024-06-14 00:39:00');

-- STUDY_ROOM_MEMBER_WEEKLY_PLAN 테이블에 더미 데이터 추가
-- dumy data in study room 1 (4 people)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_id, study_room_member_id, plan_detail, created_date_time, weekly_plan_round_number)
VALUES
(1, 1, '코드트리 그리디알고리즘 1~5번 풀기', '2024-05-31 13:46:47', 1),
(1, 2, '혼자 공부하는 자바 챕터 1,2 공부하기', '2024-05-31 11:46:57', 1),
(1, 3, '마리아DB 테이블 생성, 조회, 삭제 블로그에 정리하기', '2024-05-31 10:49:04', 1),
(1, 4, '리눅스 명령어 정리하기', '2024-05-31 15:55:04', 1),
(1, 2, '코드트리 정렬알고리즘 5번문제 다시 풀기', '2024-05-31 18:55:57', 1),
(1, 4, '백준 DP알고리즘 7문제 풀기', '2024-05-31 17:58:10', 1),
(1, 1, '프로젝트 회원가입,로그인 로직 구현 끝내기', '2024-05-31 14:58:47', 1),
(1, 3, '토익 단어 500개 외우기', '2024-05-31 09:59:00', 1),
(1, 3, '백준 DFS알고리즘 10문제 풀기', '2024-05-31 16:59:50', 1),
(1, 1, '팀프로젝트 ERD랑 테이블명세서 작성 끝내기', '2024-05-31 12:59:57', 1),
(1, 3, 'DB 트랜잭션이랑 트리거 블로그 정리하기', '2024-05-31 19:59:58', 1),
(1, 2, '알고리즘 문제 풀이 10문제 풀기', '2024-05-31 08:12:45', 1),
(1, 4, '코딩 테스트 준비 - DFS/BFS', '2024-05-31 14:33:21', 1),
(1, 2, '백준 문제집 풀기 - DP', '2024-05-31 09:47:38', 1),
(1, 1, '프로그래머스 알고리즘 레벨2 문제 풀기', '2024-05-31 16:21:50', 1),
(1, 2, '백준 그리디 알고리즘 문제 풀기', '2024-05-31 12:05:14', 1),
(1, 3, '알고리즘 문제 풀이 5문제 풀기', '2024-05-31 18:36:22', 1),
(1, 2, '코딩 인터뷰 대비 문제 풀기', '2024-05-31 07:15:03', 1),
(1, 2, '백준 그래프 문제 풀기', '2024-05-31 10:22:45', 1),
(1, 4, '알고리즘 기초 강의 듣기', '2024-05-31 11:49:30', 1),
(1, 2, '프로그래머스 문제집 풀기 - 이분탐색', '2024-05-31 15:05:54', 1),
(1, 1, '알고리즘 중급 강의 듣기', '2024-05-31 17:20:40', 1),
(1, 2, '백준 문제집 풀기 - 최단 경로', '2024-05-31 19:30:12', 1),
(1, 3, '프로그래머스 레벨3 문제 풀기', '2024-05-31 13:11:28', 1),
(1, 4, '알고리즘 연습문제 7문제 풀기', '2024-05-31 08:05:18', 1),
(1, 2, '백준 문제집 풀기 - 트리', '2024-05-31 14:40:32', 1),
(1, 2, '프로그래머스 레벨1 문제 풀기', '2024-05-31 18:05:27', 1),
(1, 1, '알고리즘 기본 개념 복습', '2024-05-31 20:30:47', 1),
(1, 2, '백준 문제집 풀기 - 해시', '2024-05-31 12:14:53', 1),
(1, 4, '코딩 테스트 준비 - 트리', '2024-05-31 13:25:15', 1),
(1, 3, '코드트리 DP 알고리즘 3문제 풀기', '2024-06-06 13:45:47', 2),
(1, 1, '팀프로젝트 테스트케이스 만들기', '2024-06-06 14:45:48', 2),
(1, 3, 'SQLD 정리본 블로그에 정리하기', '2024-06-06 15:45:49', 2),
(1, 4, '코드트리 백트래킹 알고리즘 6문제 풀기', '2024-06-06 16:45:55', 2),
(1, 1, '팀프로젝트 물리적 모델링 끝내기', '2024-06-06 10:45:57', 2),
(1, 2, '정보처리기사 기출 3회분 끝내기', '2024-06-06 11:45:59', 2),
(1, 3, '백준 DFS 알고리즘 6문제 풀기', '2024-06-06 12:47:47', 2),
(1, 4, '인프런 리액트 강의 6개 듣기', '2024-06-06 13:49:47', 2),
(1, 3, '컴퓨터구조 강의 3개 듣기', '2024-06-06 14:53:00', 2),
(1, 1, '코드트리 백트래킹 알고리즘 2문제 풀기', '2024-06-06 15:56:47', 2),
(1, 4, '팀프로젝트 논리적 모델링 끝내기', '2024-06-06 16:56:49', 2),
(1, 2, 'sqlp 기출 3회분 끝내기', '2024-06-06 17:59:07', 2),
(1, 2, '백준 문제집 풀기 - 해시', '2024-06-06 08:12:45', 2),
(1, 4, '코딩 테스트 준비 - 동적 프로그래밍', '2024-06-06 14:33:21', 2),
(1, 2, '프로그래머스 문제집 풀기 - 완전탐색', '2024-06-06 09:47:38', 2),
(1, 1, '프로그래머스 알고리즘 레벨2 문제 풀기', '2024-06-06 16:21:50', 2),
(1, 2, '백준 그리디 알고리즘 문제 풀기', '2024-06-06 12:05:14', 2),
(1, 3, '알고리즘 문제 풀이 5문제 풀기', '2024-06-06 18:36:22', 2),
(1, 2, '코딩 인터뷰 대비 문제 풀기', '2024-06-06 07:15:03', 2),
(1, 2, '백준 그래프 문제 풀기', '2024-06-06 10:22:45', 2),
(1, 4, '알고리즘 기초 강의 듣기', '2024-06-06 11:49:30', 2),
(1, 2, '프로그래머스 문제집 풀기 - 이분탐색', '2024-06-06 15:05:54', 2),
(1, 1, '알고리즘 중급 강의 듣기', '2024-06-06 17:20:40', 2),
(1, 2, '백준 문제집 풀기 - 최단 경로', '2024-06-06 19:30:12', 2),
(1, 3, '프로그래머스 레벨3 문제 풀기', '2024-06-06 13:11:28', 2),
(1, 4, '알고리즘 연습문제 7문제 풀기', '2024-06-06 08:05:18', 2),
(1, 2, '백준 문제집 풀기 - 트리', '2024-06-06 14:40:32', 2),
(1, 2, '프로그래머스 레벨1 문제 풀기', '2024-06-06 18:05:27', 2),
(1, 1, '알고리즘 기본 개념 복습', '2024-06-06 20:30:47', 2),
(1, 2, '프로그래머스 문제집 풀기 - 해시', '2024-06-06 11:23:32', 2),
(1, 3, '알고리즘 문제 풀이 3문제 풀기', '2024-06-06 09:14:12', 2);


-- dumy data in study room 2 (6 people)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN (study_room_id, study_room_member_id, plan_detail, created_date_time,
                                           weekly_plan_round_number)
VALUES (2, 10, '코드트리 그리디알고리즘 10문제 풀기', '2024-05-31 07:45:22', 1),
       (2, 9, '프로그래머스 문제집 풀기 - 이분탐색', '2024-05-31 08:36:11', 1),
       (2, 10, '알고리즘 문제 풀이 7문제 풀기', '2024-05-31 09:27:00', 1),
       (2, 6, '백준 그래프 알고리즘 5문제 풀기', '2024-05-31 10:18:45', 1),
       (2, 7, '혼자 공부하는 자바 챕터 3 공부하기', '2024-05-31 11:09:34', 1),
       (2, 10, '백준 DFS 알고리즘 8문제 풀기', '2024-05-31 12:00:23', 1),
       (2, 5, '프로그래머스 DP 문제 풀이', '2024-05-31 12:51:12', 1),
       (2, 8, '코드트리 BFS알고리즘 7문제 풀기', '2024-05-31 13:42:01', 1),
       (2, 10, '알고리즘 중급 강의 듣기', '2024-05-31 14:32:50', 1),
       (2, 9, '프로그래머스 그래프 문제 풀이', '2024-05-31 15:23:39', 1),
       (2, 10, '백준 DP알고리즘 5문제 풀기', '2024-05-31 16:14:28', 1),
       (2, 5, '코드트리 완전탐색 문제 풀기', '2024-05-31 17:05:17', 1),
       (2, 7, '프로그래머스 레벨2 문제 풀이', '2024-05-31 17:56:06', 1),
       (2, 10, '알고리즘 기초 문제 풀이', '2024-05-31 18:46:55', 1),
       (2, 8, '백준 그리디알고리즘 5문제 풀기', '2024-05-31 19:37:44', 1),
       (2, 10, '프로그래머스 그래프 문제 7문제 풀기', '2024-05-31 20:28:33', 1),
       (2, 6, '백준 DFS알고리즘 4문제 풀기', '2024-06-06 07:45:22', 2),
       (2, 10, '알고리즘 중급 강의 듣기', '2024-06-06 08:36:11', 2),
       (2, 5, '프로그래머스 문제집 풀기 - DP', '2024-06-06 09:27:00', 2),
       (2, 9, '백준 그래프 알고리즘 6문제 풀기', '2024-06-06 10:18:45', 2),
       (2, 8, '코드트리 DFS알고리즘 7문제 풀기', '2024-06-06 11:09:34', 2),
       (2, 10, '프로그래머스 DP 문제 풀이', '2024-06-06 12:00:23', 2),
       (2, 7, '백준 BFS알고리즘 8문제 풀기', '2024-06-06 12:51:12', 2),
       (2, 10, '알고리즘 중급 강의 복습', '2024-06-06 13:42:01', 2),
       (2, 6, '프로그래머스 레벨3 문제 풀이', '2024-06-06 14:32:50', 2),
       (2, 5, '코드트리 백트래킹 문제 풀이', '2024-06-06 15:23:39', 2),
       (2, 9, '백준 그리디알고리즘 10문제 풀기', '2024-06-06 16:14:28', 2),
       (2, 10, '프로그래머스 DFS 문제 풀이', '2024-06-06 17:05:17', 2),
       (2, 7, '알고리즘 기초 문제 풀이', '2024-06-06 17:56:06', 2),
       (2, 10, '백준 BFS알고리즘 5문제 풀기', '2024-06-06 18:46:55', 2),
       (2, 8, '프로그래머스 완전탐색 문제 풀기', '2024-06-06 19:37:44', 2),
       (2, 10, '알고리즘 고급 강의 듣기', '2024-06-06 20:28:33', 2),
       (2, 5, '코드트리 그리디알고리즘 8문제 풀기', '2024-06-13 07:45:22', 3),
       (2, 10, '프로그래머스 이분탐색 문제 풀기', '2024-06-13 08:36:11', 3),
       (2, 7, '백준 DFS알고리즘 9문제 풀기', '2024-06-13 09:27:00', 3),
       (2, 6, '알고리즘 중급 강의 듣기', '2024-06-13 10:18:45', 3),
       (2, 10, '프로그래머스 그래프 문제 풀이', '2024-06-13 11:09:34', 3),
       (2, 9, '백준 DP알고리즘 7문제 풀기', '2024-06-13 12:00:23', 3),
       (2, 5, '코드트리 BFS알고리즘 8문제 풀기', '2024-06-13 12:51:12', 3),
       (2, 10, '프로그래머스 레벨2 문제 복습', '2024-06-13 13:42:01', 3),
       (2, 8, '알고리즘 기초 문제 풀이', '2024-06-13 14:32:50', 3),
       (2, 10, '백준 DP 알고리즘 6문제 풀기', '2024-05-31 08:12:34', 1),
       (2, 7, '프로그래머스 문제집 풀기 - 정렬', '2024-05-31 09:23:45', 1),
       (2, 10, '알고리즘 중급 강의 복습', '2024-05-31 10:34:56', 1),
       (2, 6, '백준 DFS 문제 풀이', '2024-05-31 11:45:12', 1),
       (2, 8, '프로그래머스 그래프 문제 풀기', '2024-05-31 12:56:23', 1),
       (2, 10, '코드트리 완전탐색 문제 10문제 풀기', '2024-05-31 13:07:34', 1),
       (2, 5, '알고리즘 기초 강의 듣기', '2024-05-31 14:18:45', 1),
       (2, 10, '프로그래머스 레벨1 문제 풀기', '2024-05-31 15:29:56', 1),
       (2, 9, '백준 BFS 알고리즘 7문제 풀기', '2024-05-31 16:40:12', 1),
       (2, 6, '코드트리 DP 문제 풀이', '2024-05-31 17:51:23', 1),
       (2, 10, '알고리즘 기초 문제 풀이', '2024-05-31 18:02:34', 1),
       (2, 8, '프로그래머스 백트래킹 문제 풀기', '2024-05-31 19:13:45', 1),
       (2, 7, '백준 그리디 알고리즘 문제 풀기', '2024-05-31 20:24:56', 1),
       (2, 10, '알고리즘 고급 강의 듣기', '2024-05-31 21:35:07', 1),
       (2, 5, '프로그래머스 레벨3 문제 풀기', '2024-06-06 08:12:34', 2),
       (2, 10, '백준 그래프 문제 풀이', '2024-06-06 09:23:45', 2),
       (2, 9, '알고리즘 중급 강의 복습', '2024-06-06 10:34:56', 2),
       (2, 6, '프로그래머스 BFS 문제 풀기', '2024-06-06 11:45:12', 2),
       (2, 7, '백준 DP 문제 5문제 풀기', '2024-06-06 12:56:23', 2),
       (2, 10, '코드트리 그리디 알고리즘 문제 풀기', '2024-06-06 13:07:34', 2),
       (2, 8, '알고리즘 기초 강의 듣기', '2024-06-06 14:18:45', 2),
       (2, 10, '프로그래머스 레벨2 문제 복습', '2024-06-06 15:29:56', 2),
       (2, 5, '백준 DFS 문제 8문제 풀기', '2024-06-06 16:40:12', 2),
       (2, 10, '코드트리 DP 문제 풀이', '2024-06-06 17:51:23', 2),
       (2, 9, '알고리즘 고급 강의 듣기', '2024-06-06 18:02:34', 2),
       (2, 6, '프로그래머스 그래프 문제 풀기', '2024-06-06 19:13:45', 2),
       (2, 10, '백준 BFS 문제 풀이', '2024-06-06 20:24:56', 2),
       (2, 8, '프로그래머스 백트래킹 문제 풀이', '2024-06-06 21:35:07', 2),
       (2, 5, '알고리즘 중급 강의 듣기', '2024-06-13 08:12:34', 3),
       (2, 10, '프로그래머스 레벨3 문제 풀기', '2024-06-13 09:23:45', 3),
       (2, 7, '백준 그래프 문제 6문제 풀기', '2024-06-13 10:34:56', 3),
       (2, 6, '코드트리 완전탐색 문제 풀기', '2024-06-13 11:45:12', 3),
       (2, 10, '알고리즘 고급 강의 복습', '2024-06-13 12:56:23', 3),
       (2, 8, '프로그래머스 BFS 문제 풀이', '2024-06-13 13:07:34', 3),
       (2, 9, '백준 DP 문제 7문제 풀기', '2024-06-13 14:18:45', 3),
       (2, 10, '프로그래머스 그래프 문제 복습', '2024-06-13 15:29:56', 3),
       (2, 5, '알고리즘 기초 문제 풀이', '2024-06-13 16:40:12', 3),
       (2, 10, '코드트리 그리디 알고리즘 문제 풀기', '2024-06-13 17:51:23', 3),
       (2, 6, '프로그래머스 레벨2 문제 풀기', '2024-06-13 18:02:34', 3),
       (2, 8, '백준 DFS 문제 풀이', '2024-06-13 19:13:45', 3),
       (2, 10, '알고리즘 고급 강의 듣기', '2024-06-13 20:24:56', 3),
       (2, 9, '프로그래머스 BFS 문제 풀이', '2024-06-13 21:35:07', 3)
;

-- STUDY_ROOM_MEMBER_TODO 테이블에 더미 데이터 추가
INSERT INTO `study_room_member_todo` (`study_room_member_id`, `content`, `created_date`, `is_checked`)
VALUES (1, 'Java 기본 문법 복습', '2024-06-02', 1),
       (2, 'Java 객체지향 프로그래밍 연습', '2024-06-04', 0),
       (3, 'Java 스트림 API 활용하기', '2024-06-06', 1),
       (4, 'Java 컬렉션 프레임워크 학습', '2024-06-08', 0),
       (1, 'Java 람다식과 함수형 인터페이스 이해하기', '2024-06-10', 1),
       (2, 'Java 멀티쓰레드 프로그래밍 연습', '2024-06-12', 0),
       (3, 'Java I/O 스트림 다루기', '2024-06-14', 1),
       (4, 'Java 네트워크 프로그래밍 실습', '2024-06-16', 0),
       (1, 'Java 정규 표현식 학습', '2024-06-18', 1),
       (2, 'Java 디자인 패턴 공부', '2024-06-20', 0),
       (3, 'Java 제네릭 사용법', '2024-06-22', 1),
       (4, 'Java 예외 처리 방법', '2024-06-24', 0),
       (1, 'Java 데이터베이스 연동', '2024-06-26', 1),
       (2, 'Java GUI 프로그래밍', '2024-06-28', 0),
       (3, 'Java 웹 애플리케이션 개발', '2024-06-30', 1),
       (4, 'Java Spring 프레임워크 학습', '2024-06-01', 0),
       (5, 'Python 기본 문법 복습', '2024-06-03', 1),
       (6, 'Python 데이터 분석 라이브러리 활용', '2024-06-05', 0),
       (7, 'Python 웹 스크래핑 연습', '2024-06-07', 1),
       (8, 'Python 웹 개발 실습', '2024-06-09', 0),
       (9, 'Python 머신러닝 기초 학습', '2024-06-11', 1),
       (10, 'Python 딥러닝 프레임워크 사용하기', '2024-06-13', 0),
       (5, 'Python 데이터 시각화 프로젝트', '2024-06-15', 1),
       (6, 'Python API 활용하기', '2024-06-17', 0),
       (7, 'Python GUI 프로그래밍 연습', '2024-06-19', 1),
       (8, 'Python 텍스트 처리 및 분석', '2024-06-21', 0),
       (9, 'Python 네트워크 프로그래밍 실습', '2024-06-23', 1),
       (10, 'Python 비동기 프로그래밍 이해하기', '2024-06-25', 0),
       (5, 'Python 테스트 주도 개발 연습', '2024-06-27', 1),
       (6, 'Python 데이터베이스 연동 실습', '2024-06-29', 0);

-- STUDY_ROOM_MEMBER_FINE 테이블에 더미 데이터 추가
-- 그룹 1 : 1~4 / 그룹2 : 1~6명

-- 그룹 1 dummy data
INSERT INTO STUDY_ROOM_MEMBER_FINE (study_room_member_id, get_fine_round, fine_amount)
VALUES (2, 1, 12000),
       (2, 2, 12000),
       (4, 1, 12000)
;

-- 그룹 2 dummy data
INSERT INTO STUDY_ROOM_MEMBER_FINE (study_room_member_id, get_fine_round, fine_amount)
VALUES (1, 2, 5000),
       (3, 2, 5000),
       (4, 2, 5000),
       (5, 3, 5000)
;

-- STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION 테이블에 더미 데이터 추가
-- 이모지 입력이 mariaDB에 올라가지나 모르겠어서 일단 알파벳으로 입력(내일 가서 확인하겠음)
INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN_EVALUATION (`study_room_member_weekly_plan_id`, `study_room_member_id`,
                                                      `evaluation_date_time`, `evaluation_icon`)
VALUES (2, 1, '2024-06-01 08:36', 'A'),
       (2, 3, '2024-06-01 11:45', 'A'),
       (7, 2, '2024-06-02 07:45', 'A'),
       (12, 2, '2024-06-07 14:18', 'U'),
       (18, 2, '2024-06-07 15:23', 'B'),
       (19, 1, '2024-06-08 19:13', 'L'),
       (23, 2, '2024-06-08 19:37', 'B'),
       (23, 2, '2024-06-09 10:56', 'C'),
       (27, 2, '2024-06-03 12:34', 'O'),
       (29, 1, '2024-06-03 16:40', 'B'),
       (37, 3, '2024-06-04 13:42', 'U'),
       (39, 4, '2024-06-04 17:05', 'U'),
       (42, 3, '2024-06-05 08:45', 'A'),
       (47, 2, '2024-06-09 16:40', 'U'),
       (48, 1, '2024-06-10 10:34', 'C'),
       (50, 2, '2024-06-10 11:45', 'B'),
       (51, 3, '2024-06-11 18:02', 'A'),
       (53, 2, '2024-06-11 18:02', 'L'),
       (53, 2, '2024-06-11 21:35', 'C'),
       (54, 2, '2024-06-12 11:45', 'A'),
       (54, 1, '2024-06-12 18:02', 'L'),
       (57, 2, '2024-06-13 09:13', 'C'),
       (63, 4, '2024-06-13 19:13', 'O'),
       (65, 10, '2024-06-01 17:05', 'L'),
       (66, 5, '2024-06-05 08:45', 'L'),
       (72, 10, '2024-06-02 18:46', 'O'),
       (76, 10, '2024-06-05 20:24', 'B'),
       (78, 7, '2024-06-06 12:51', 'B'),
       (82, 9, '2024-06-07 15:23', 'L'),
       (87, 10, '2024-06-08 19:13', 'B'),
       (93, 9, '2024-06-08 19:37', 'A'),
       (95, 6, '2024-06-09 10:56', 'U'),
       (96, 5, '2024-06-09 11:45', 'U'),
       (98, 7, '2024-06-16 21:35', 'L'),
       (100, 8, '2024-06-17 08:36', 'A'),
       (100, 10, '2024-06-17 10:18', 'C'),
       (116, 7, '2024-06-05 18:46', 'L'),
       (118, 5, '2024-06-05 20:24', 'B'),
       (122, 5, '2024-06-11 18:02', 'B'),
       (123, 9, '2024-06-11 21:35', 'O'),
       (126, 7, '2024-06-12 11:45', 'U'),
       (131, 8, '2024-06-12 18:02', 'B'),
       (137, 7, '2024-06-18 08:36', 'B'),
       (142, 10, '2024-06-18 10:18', 'L'),
       (144, 6, '2024-06-19 07:15', 'A'),
       (144, 5, '2024-06-19 12:51', 'C')
;


INSERT INTO STUDY_ROOM_MEMBER_WEEKLY_PLAN_VERIFICATION (study_room_member_weekly_plan_id, image_url, create_date_time)
VALUES (1, 'https://example.com/photo1.jpg', '2024-06-04 01:23'),
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