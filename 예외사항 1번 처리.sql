# [예외사항 1] 회원 탈퇴 시 개인 정보만 지우기 (user_id 식별자는 보존 필요)
# user_name -> 탈퇴유저_숫자
# password -> null
# nickname -> 탈퇴유저_숫자
# gender -> null

# 탈퇴 처리 테스트용 더미 데이터 추가
INSERT INTO USER (username, password, nickname, gender)
VALUES ('탈퇴 유저 1', '1234', '탈퇴 닉네임 1', 'M'),
       ('탈퇴 유저 2', '1234', '탈퇴 닉네임 2', 'M');

# 'Giselbert 유저 탈퇴'
UPDATE USER
SET username = CONCAT('탈퇴 유저 ', (SELECT COUNT(*) + 1 AS 'NEXT_COUNT'
                                 FROM USER
                                 WHERE username LIKE '탈퇴 유저%'
                                   AND nickname LIKE '탈퇴 닉네임%')),
    nickname = CONCAT('탈퇴 닉네임 ', ((SELECT COUNT(*) + 1 AS 'NEXT_COUNT'
                                   FROM USER
                                   WHERE username LIKE '탈퇴 유저%'
                                     AND nickname LIKE '탈퇴 닉네임%'))),
    password = NULL,
    gender   = NULL
WHERE username = 'Giselbert';

SELECT *
FROM USER;