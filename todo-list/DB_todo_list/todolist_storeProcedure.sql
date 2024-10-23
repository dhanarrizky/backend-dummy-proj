-- ================================ ACCOUNT

-- query for creating procedure for adding new users
CREATE OR REPLACE PROCEDURE reg_new_user(
    username_inp VARCHAR,
    password_inp VARCHAR,
    email_inp VARCHAR,
    phonenumber_inp VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    err_msg VARCHAR(100);
BEGIN
    IF EXISTS (
        SELECT 1
        FROM account
        WHERE username = username_inp OR 
              email = email_inp OR
              phonenumber = phonenumber_inp
    ) THEN
        IF EXISTS (SELECT 1 FROM account WHERE username = username_inp) THEN
            err_msg := 'username must be unique.';
        ELSIF EXISTS (SELECT 1 FROM account WHERE email = email_inp) THEN
            err_msg := 'email must be unique.';
        ELSE
            err_msg := 'phonenumber must be unique.';
        END IF;
        RETURN 'failed : ' || err_msg;
    END IF;

    INSERT INTO account(
        username, password, email, phonenumber
    ) VALUES (
        username_inp, password_inp, email_inp, phonenumber_inp
    );

    RETURN 'success : Registration of new user has been successfully.';
END; $$


-- updated data account (user)
CREATE OR REPLACE PROCEDURE update_user(
    username_inp VARCHAR,
    password_inp VARCHAR,
    email_inp VARCHAR,
    phonenumber_inp VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    pass VARCHAR;
    eml VARCHAR;
    phn_num VARCHAR;
BEGIN
    IF EXISTS (
        SELECT 1 FROM account WHERE username = username_inp
    ) THEN
        SELECT 
            COALESCE(NULLIF(password_inp, ''), password) AS password,
            COALESCE(NULLIF(email_inp, ''), email) AS email,
            COALESCE(NULLIF(phonenumber_inp, ''), phonenumber) AS phonenumber           
        INTO pass, eml, phn_num
        FROM account 
        WHERE username = username_inp;

        UPDATE account
        SET 
            password = pass,
            email = eml,
            phonenumber = phn_num,
            updated_at = NOW()
        WHERE username = username_inp;

        RETURN 'success : Updated account has been successfully';    
    ELSE
        RETURN 'failed : User account not found';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'failed : Error updating user: ' || SQLERRM;
END; $$


-- ================================ GROUP NOTE

-- query for add new group_note
CREATE OR REPLACE PROCEDURE add_new_group_note (
    user_account_inp VARCHAR,
    title_inp VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM account WHERE username = user_account_inp
    ) THEN 
        RETURN 'failed : warning - user_account is not found!!';
    END IF;

    INSERT INTO group_note(
        user_account,
        title
    ) VALUES (
        user_account_inp, title_inp
    );

    RETURN 'success : Added new group_note has been successfully..';
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'failed : Error inserting group_note: ' || SQLERRM;
END; $$


-- query for update group_note
CREATE OR REPLACE PROCEDURE update_group_note (
    user_account_inp VARCHAR,
    title_inp VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM group_note WHERE user_account = user_account_inp
    ) THEN 
        UPDATE group_note
        SET title = title_inp, Updated_at = NOW()
        WHERE user_account = user_account_inp;

        RETURN 'success : Updated group_note has been successfully..';
    ELSE
        RETURN 'failed : warning - user_account is not found!!';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'failed : Error updating group_note: ' || SQLERRM;
END; $$


-- ================================ NOTES

-- add new todo list
CREATE OR REPLACE PROCEDURE add_new_todo_list(
    group_note_id_inp INT,
    title_inp VARCHAR,
    text_content_inp TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM group_note WHERE id = group_note_id_inp
    ) THEN 
        RETURN 'failed : warning - group_note is not found!!';
    END IF;

    INSERT INTO note(
        group_note_id,
        title,
        text_content
    ) VALUES (
        group_note_id_inp,
        title_inp,
        text_content_inp
    );

    RETURN 'success : Added new todo_list has been successfully..';
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'failed : Error inserting note: ' || SQLERRM;
END; $$;

-- query for  update todo list note
CREATE OR REPLACE PROCEDURE add_new_todo_list(
    id_inp INT,
    title_inp VARCHAR,
    text_content_inp TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    title_val VARCHAR;
    text_content_val TEXT;
BEGIN
    IF EXISTS (
        SELECT 1 FROM note WHERE id = id_inp
    ) THEN 
        SELECT 
            COALESCE(NULLIF(title_inp,''), title) AS title,
            COALESCE(NULLIF(text_content_inp,''), text_content) AS text_content,
        INTO
            title_val, text_content_val
        FROM note
        WHERE id = id_inp;

        UPDATE note
        SET title = title_val, text_content = text_content_val, updated_at = NOW()
        WHERE id = id_inp;

        RETURN 'success : Updated note has been successfully..';
    ELSE
        RETURN 'failed : warning - note is not found!!';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'failed : Error updated note: ' || SQLERRM;
END; $$;