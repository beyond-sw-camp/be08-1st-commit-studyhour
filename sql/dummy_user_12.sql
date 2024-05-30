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
