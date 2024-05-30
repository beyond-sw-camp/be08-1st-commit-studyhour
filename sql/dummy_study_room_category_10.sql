USE study_hour;

-- 외래 키 제약 조건 비활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE STUDY_ROOM_CATEGORY;

-- 외래 키 제약 조건 활성화
SET FOREIGN_KEY_CHECKS = 1;

insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (1, 'Navigator L');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (2, 'Fleetwood');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (3, 'Metro');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (4, 'Caravan');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (5, 'Freestar');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (6, 'A8');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (7, 'Sportage');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (8, 'Impala');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (9, 'Catera');
insert into STUDY_ROOM_CATEGORY (study_room_category_id, name) values (10, 'Sunbird');
