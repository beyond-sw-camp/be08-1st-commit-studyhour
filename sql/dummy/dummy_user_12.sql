USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE USER;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

insert into USER (username, password, nickname, gender) values ('Edwina', '$2a$04$GOglKss2VCos4w3Z.uipYOwuAS3/mjzpG2siDn8/Ob9cn4A5y7.TC', 'Luisetti', 'F');
insert into USER (username, password, nickname, gender) values ('Giselbert', '$2a$04$ddcb7A1iCrYkPo3BP3nV/OLt8rHKcXGaZGtNL8mPVFOgRTcVt7MAa', 'Fliege', 'M');
insert into USER (username, password, nickname, gender) values ('Luther', '$2a$04$l2PSFsKugum4enrKK6JncOg1OlPHNk.7W7ggQwSlOfzjTcuEYVbmu', 'Dandie', 'M');
insert into USER (username, password, nickname, gender) values ('Starla', '$2a$04$gThssYsSDNo4X3XpqJX8GujuymYLuvXXaXSdzg6TbZqpADb1yXWey', 'Madrell', 'F');
insert into USER (username, password, nickname, gender) values ('Neddy', '$2a$04$JP5uY8i/u/IYS3VPWqq2yeK/94tWYZagX4TlsRM9Dd/cNYD42xu/a', 'Walczak', 'M');
insert into USER (username, password, nickname, gender) values ('Deana', '$2a$04$szQdeg7Fbd.qZHmSiX5nFOZnABm/swdEy3GKMmABQXqhTn5YxlbQa', 'Dwyer', 'F');
insert into USER (username, password, nickname, gender) values ('Betti', '$2a$04$exc08b5nJoSVpw7InTA4aOU7etvyI8LJuaju1VMs5ZU/7.iatfrta', 'Elster', 'F');
insert into USER (username, password, nickname, gender) values ('Ellary', '$2a$04$UO88JZdRUP8xmtYKVXnJMuDDF7dZccpLV9Wq7i6ZWOM5fkpNguxLa', 'Berth', 'M');
insert into USER (username, password, nickname, gender) values ('Ethelind', '$2a$04$.J1nMeMO4hBXY1lXNWKl5u9dc3wysmvkj4JPicqADdv2fmGwaFtQC', 'Courtenay', 'F');
insert into USER (username, password, nickname, gender) values ('Solomon', '$2a$04$aan5YKQzYoKF81UlTbwObu7kJObFPSRvEW5cCU9szmfw4Ndz4yNxy', 'Kirlin', 'M');
insert into USER (username, password, nickname, gender) values ('Sydney', '$2a$04$zbKGdxGGNmH6olFKdoXNeO/.bVbAqCLMFtqyA265FOwfN.N7A98Dm', 'Voisey', 'M');
insert into USER (username, password, nickname, gender) values ('Pierce', '$2a$04$k6wAkd2ZYuFpMsGcng8RtuyG4S7Z31LKxNuM3IQDRtBW.c3dWP1zW', 'Blader', 'M');

-- USER_PROFILE 테이블에 더미 데이터 추가
INSERT INTO USER_PROFILE (user_id, age, interest, state_message, profile_image_url) VALUES
(1, 25, 'Programming', 'Hello, I am User One', 'https://example.com/profile1.jpg'),
(2, 30, 'Photography', 'Nice to meet you. I am User Two', 'https://example.com/profile2.jpg'),
(3, 22, 'Reading', 'User Three here!', 'https://example.com/profile3.jpg'),
(4, 28, 'Music', 'User Four says hi!', 'https://example.com/profile4.jpg'),
(5, 26, 'Gaming', 'Hello from User Five', 'https://example.com/profile5.jpg'),
(6, 32, 'Cooking', 'User Six at your service', 'https://example.com/profile6.jpg'),
(7, 29, 'Travel', 'Greetings from User Seven', 'https://example.com/profile7.jpg'),
(8, 27, 'Fitness', 'User Eight reporting in!', 'https://example.com/profile8.jpg'),
(9, 24, 'Art', 'User Nine here!', 'https://example.com/profile9.jpg'),
(10, 31, 'Movies', 'User Ten says hello', 'https://example.com/profile10.jpg');