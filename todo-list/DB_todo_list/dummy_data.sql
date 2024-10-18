INSERT INTO account (username, password, email, phonenumber)
SELECT 
    CONCAT('user_', md5(random()::text)) AS username,
    md5(random()::text) AS password,
    CONCAT(md5(random()::text), '@example.com') AS email,
    CONCAT('+123456', floor(random() * 1000000)::text) AS phonenumber
FROM generate_series(1, 500);  -- Create 500 accounts



INSERT INTO "group" (user_account, title)
SELECT 
    username AS user_account, 
    CONCAT('Group_', md5(random()::text)) AS title
FROM account
ORDER BY random()
LIMIT 500;  -- Create 500 groups linked to random accounts


INSERT INTO note (group_id, title, text_content, checked)
SELECT 
    id AS group_id, 
    CONCAT('Note_', md5(random()::text)) AS title,
    md5(random()::text) AS text_content,
    (random() > 0.5) AS checked
FROM "group"
ORDER BY random()
LIMIT 1500;  -- Create 1500 notes linked to random groups
