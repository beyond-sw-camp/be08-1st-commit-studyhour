-- 스터디룸 방장이 회원 탈퇴 시 처리
-- 
-- 저장 프로시저 생성
-- DELIMITER $$
-- 
-- CREATE OR REPLACE PROCEDURE update_other_managers(
--     IN study_room_id INT,
--     IN member_id INT
-- )
-- BEGIN
--     UPDATE study_room_member
--     SET privilege = 'member'
--     WHERE study_room_id = study_room_id
--       AND privilege = 'manager'
--       AND study_room_member_id <> member_id;
-- END $$
-- 
-- DELIMITER ;
-- 
-- 트리거 생성
-- DELIMITER $$
-- 
-- CREATE OR REPLACE TRIGGER trg_delegate_as_manager
-- AFTER UPDATE ON study_room_member
-- FOR EACH ROW
-- BEGIN
--     IF OLD.privilege = 'member' AND NEW.privilege = 'manager' THEN
--         CALL update_other_managers(NEW.study_room_id, NEW.study_room_member_id);
--     END IF;
-- END $$
-- 
-- DELIMITER ;

-- 안된다.. 오류난다
-- Can't update table 'study_room_member' in stored function/trigger because it is already used by statement which invoked this stored function/trigger */


-- 1번 스터디룸 방장인 1번 유저가 3번유저에게 방장 위임
UPDATE study_room_member
SET privilege = 'member'
WHERE user_id = (SELECT user_id FROM `user` WHERE nickname = 'Luisetti') 
AND privilege = 'manager';

UPDATE study_room_member
	SET privilege = 'MANAGER'
 WHERE user_id = 
 (SELECT user_id FROM `user` WHERE nickname = 'Fliege') 
;
