-- -- create procedure or function for
-- 1. show all account

    SELECT * FROM account;

-- 2. show all groups

    SELECT * FROM group_note;

-- 3. show all notes

    SELECT * FROM note;

-- -- show group by
-- 1. show all groups group by account

    SELECT * FROM group_note AS g
        JOIN account AS a ON a.username = g.user_account;

-- 3. show all notes group by groups

    SELECT * FROM note AS n
        JOIN group_note AS g ON g.id = n.group_note_id;

-- -- user
-- 1. show profile
-- 2. show my group
-- 3. show my note by group
-- 4. show detail note