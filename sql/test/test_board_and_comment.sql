# [6.1] [게시판 작성]
# [6.1.1] [게시글 제목 작성] T
# [6.1.2] [게시글 내용 작성] T
-- 3번 참가자가 1번 스터디룸에 게시글 작성: (제목)테스트 게시글 작성해요 (내용)근데 이거 꼭 작성해야 하나요???

INSERT INTO study_room_board (study_room_id, study_room_member_id, title, content, created_date_time)
VALUES (1, 3, '테스트 게시글 작성해요', '근데 이거 꼭 작성해야 하나요???', '2024-06-09 13:00:12');

# [6.2] [게시판 조회]
# [6.2.1] [게시글 리스트 조회] T
-- view) 1번 스터디룸 게시글 리스트 전체 조회: 제목, 작성자, 작성일 -> 최신순 정렬
-- * 입력받은 스터디룸 번호의 게시글 리스트 뷰를 select해서 반환하는 프로시저 생성
DELIMITER $$
CREATE OR REPLACE PROCEDURE board_list (
    IN id INT
)
BEGIN
	DECLARE v_sql_statement VARCHAR(500);
	SET v_sql_statement = CONCAT(
        'CREATE OR REPLACE VIEW v_study_room_board AS ',
        'SELECT title, content, b.username, created_date_time ',
        'FROM STUDY_ROOM_BOARD a ',
        'INNER JOIN (SELECT study_room_member_id, b.username ',
        '           FROM STUDY_ROOM_MEMBER a ',
        '           INNER JOIN USER b ON a.user_id = b.user_id) b ',
        'ON a.study_room_member_id = b.study_room_member_id ',
        'WHERE study_room_id = ', id,
        ' ORDER BY created_date_time DESC'
    );
	PREPARE stmt FROM v_sql_statement;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;

CALL board_list(1);

# [6.2.2] [게시글 상세 조회] T
-- 9번 게시글(1번 스터디룸의 6번째)을 조회: 제목, 내용, 작성자, 작성일
SELECT title, content, b.username, created_date_time
FROM STUDY_ROOM_BOARD a LEFT JOIN (SELECT study_room_member_id, b.username 
	FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) b
ON a.study_room_member_id = b.study_room_member_id
WHERE title = '한화 코테 준비';

-- 삭제된 회원의 게시글을 조회: 제목, 내용, 작성자, 작성일 -> 작성자: 탈퇴회원_nn
SELECT title, content, b.username, created_date_time
FROM STUDY_ROOM_BOARD a LEFT JOIN (SELECT study_room_member_id, b.username 
	FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) b
ON a.study_room_member_id = b.study_room_member_id
WHERE b.username LIKE '탈퇴*';

# [6.3] [게시판 수정]
# [6.3.1] [게시글 수정] T
-- 9번 게시글(1번 스터디룸의 6번째)의 내용 수정
UPDATE STUDY_ROOM_BOARD
SET title = '게시글 수정 테스트합니다',
	content = '내용도 수정한거 아세요? 날짜도 변경됩니다.',
	created_date_time = NOW()
WHERE study_room_board_id = 9;

-- 게시글 수정된 내용 조회(이전 게시글 제목으로는 조회 안됨, 게시글 식별자로 수정 내용 확인)
SELECT title, content, b.username, created_date_time
FROM STUDY_ROOM_BOARD a LEFT JOIN (SELECT study_room_member_id, b.username 
	FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) b
ON a.study_room_member_id = b.study_room_member_id
WHERE title = '한화 코테 준비';

SELECT title, content, b.username, created_date_time
FROM STUDY_ROOM_BOARD a LEFT JOIN (SELECT study_room_member_id, b.username 
	FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) b
ON a.study_room_member_id = b.study_room_member_id
WHERE study_room_board_id = 9;

# [6.4] [게시판 삭제]
# [6.4.1] [게시글 삭제하기] T
-- 4번 게시글(1번 스터디룸의 3번째) delete 후 view 조회하여 삭제 확인: 6.3.1 테스트 수정 내용도 같이 대략적 확인
-- * 게시글을 삭제하려면 외래키 제약에 의해 해당 댓글을 먼저 전부 삭제하고, 게시글을 삭제하는 작업을 거쳐야 함
-- * 두 작업을 한 번에 처리하기 위해, 프로시저 사용

DELIMITER $$
CREATE PROCEDURE delete_board (
	IN board_id INT
)
BEGIN
	DELETE FROM STUDY_ROOM_BOARD_COMMENT
	WHERE study_room_board_id = board_id;

	DELETE FROM STUDY_ROOM_BOARD
	WHERE study_room_board_id = board_id;
END $$
DELIMITER;

CALL delete_board(4)
CALL board_list(1)

# [6.5] [댓글]
# [6.5.1] [댓글 작성하기] T
-- 28번 게시글(2번 스터디룸의 14번째)에 7번 참가자가 댓글 작성
INSERT INTO study_room_board_comment (study_room_board_id, study_room_member_id, content, created_date_time)
VALUES (28, 7, '테스트 댓글을 작성할거에요.', NOW());

# [6.5.2] [댓글 조회하기] T
-- 28번 게시글(2번 스터디룸의 14번째)의 '제목'으로 댓글 조회
-- 게시글 제목으로 댓글을 조회하는 프로시저 생성, 조회 조건: (게시글)제목, 내용, 작성자, 작성일 (댓글)작성자, 내용, 작성일
DELIMITER $$
CREATE OR REPLACE PROCEDURE board_comment (
    IN board_title VARCHAR(100)
)
BEGIN
	SELECT c.username, a.content, a.created_date_time
    FROM STUDY_ROOM_BOARD_COMMENT a
    LEFT JOIN STUDY_ROOM_BOARD b ON a.study_room_board_id = b.study_room_board_id
    LEFT JOIN (SELECT study_room_member_id, b.username 
	    FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) c ON a.study_room_member_id = c.study_room_member_id
    WHERE b.title = board_title;
END $$
DELIMITER ;

CALL board_comment('고등학교 수학 완전정복');

# [6.5.3] [댓글 삭제하기] T
-- 'Ellary'유저(10번 참가자)가 자신의 댓글을 모두 삭제
-- 전체 댓글 중 'Ellary'가 작성한 댓글 조회해서 확인
DELETE FROM STUDY_ROOM_BOARD_COMMENT
WHERE study_room_member_id = 10;

SELECT c.username, a.content, a.created_date_time
FROM STUDY_ROOM_BOARD_COMMENT a
LEFT JOIN STUDY_ROOM_BOARD b ON a.study_room_board_id = b.study_room_board_id
LEFT JOIN (SELECT study_room_member_id, b.username 
	FROM STUDY_ROOM_MEMBER a LEFT JOIN USER b ON a.user_id = b.user_id) c ON a.study_room_member_id = c.study_room_member_id
WHERE c.username = 'Ellary';

# [6.5.4] [댓글 수정하기] T
-- 28번 게시글(2번 스터디룸의 14번째)에서 'Betti'유저(6번 참가자)가 댓글 수정
-- 28번 게시글 조회해서 수정된 댓글 확인('Ellary'의 삭제된 댓글도 같이 확인)
UPDATE STUDY_ROOM_BOARD_COMMENT
SET content = '조금씩 아니고 대폭 나아지고 있어요.',
	create_date_time = NOW()
WHERE study_room_board_id = 28 AND study_room_member_id = 6;

CALL board_comment('고등학교 수학 완전정복');
