-- ================================ aCCOUNT

-- query for createing procedure for added new users
CREATE OR REPLACE PROCEDURE reg_new_user(
    username_inp VARCHAR,
    password_inp VARCHAR,
    email_inp VARCHAR,
    phonenumber_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    err_msg VARCHAR(100)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM account
        WHERE username = user_account_inp OR 
            email = email_inp OR
            phonenumber = phonenumber_inp
    ) THEN
        IF EXISTS (SELECT 1 FROM account WHERE username = user_account_inp) THEN
            err_msg := 'username must be unique.'
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
    )

    COMMIT;
    RETURN 'success : success - Registration of new user has been successfully.';

EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE NOTICE 'Error inserting new user: %', SQLERRM;
    RETURN 'failed :  error - failed to inserting data new user, please try again!.';
END $$

-- updated data account (user)
CREATE OR REPLACE PROCEDURE update_user(
    username_inp VARCHAR,
    password_inp VARCHAR,
    email_inp VARCHAR,
    phonenumber_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
DECLARE
    pass VARCHAR;
    eml VARCHAR;
    phn_num VARCHAR;
AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM account WHERE username = username_inp;
    ) THEN
        SELECT 
            COALESCE(NULLIF(password_inp,''), password) AS password,
            COALESCE(NULLIF(email_inp,''), email) AS email,
            COALESCE(NULLIF(phonenumber_inp,''), phonenumber) AS phonenumber           
        INTO pass, eml, phn_num
        FROM account 
        WHERE username = username_inp;
    
        UPDATE account
        SET 
            password = pass,
            email = eml,
            phonenumber = phn_num
        WHERE username = username_inp;

        COMMIT;
        RETURN 'Updated account has been successfully';    
    ELSE
        ROLLBACK;
        RETURN 'failed to updated account';
    END IF;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE NOTICE 'Error updateing user: %', SQLERRM;
    RETURN 'failed :  error - failed to updated data user, please try again!.';
END $$


-- ================================ GROUP NOTE


-- query for add new group_note
CREATE OR REPLACE add_new_group_note (
    user_account_inp VARCHAR,
    title_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    
    IF EXISTS (
        SELECT 1 FROM account WHERE username = user_account_inp;
    ) THEN 
        RETURN 'failed : warning - user_account is not found!!';
    END IF;

    INSERT INTO group_note(
        user_account,
        title
    ) VALUES (
        user_account_inp, title_inp
    )

    COMMIT;
    RETURN 'success : success - Added new group_note has been successfully..';
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE NOTICE 'Error inserting group_note: %', SQLERRM;
    RETURN 'failed :  error - failed to inserting data new user, please try again';
END $$




-- ================================ NOTES


-- add new dotolist
CREATE OR REPLACE add_new_todo_list(
    group_note_id_inp VARCHAR,
    title_inp VARCHAR,
    text_content_inp TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    
    IF EXISTS (
        SELECT 1 FROM group_note WHERE id = group_note_id_inp;
    ) THEN 
        RETURN 'failed : warning - group_note is not found!!'
    END IF;

    INSERT INTO note(
        group_note_id,
        title,
        text_content
    ) VALUES (
        group_note_id_inp,
        title_inp,
        text_content_inp
    )

    COMMIT;
    RETURN 'success : success - Added new new_todo_list has been successfully..';
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE NOTICE 'Error inserting group_note: %', SQLERRM;
    RETURN 'failed :  error - failed to inserting data new note, please try again';
END $$;