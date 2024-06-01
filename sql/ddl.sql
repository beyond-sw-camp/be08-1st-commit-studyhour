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
# CREATE TABLE `STATISTICS`
# (
#     `study_room_id`    INT          NOT NULL,
#     `participant_id`   INT          NOT NULL,
#     `study_room_round` INT          NOT NULL,
#     `attendance`       VARCHAR(255) NULL,
#     `todo_achievement` VARCHAR(255) NULL,
#     `pay_fine`         VARCHAR(255) NULL
# );


CREATE TABLE `USER`
(
    `user_id`  INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(15) UNIQUE,
    `password` VARCHAR(64),
    `nickname` VARCHAR(10) UNIQUE,
    `gender`   ENUM ('M','F')
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
    `private_password`       VARCHAR(64)            NULL,
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