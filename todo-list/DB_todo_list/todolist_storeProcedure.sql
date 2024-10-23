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
    unique_count INT,
    err_msg VARCHAR(100)
BEGIN
    SELECT COUNT(*) INTO unique_count
    FROM account
    WHERE username = user_account_inp OR 
        email = email_inp OR
        phonenumber = phonenumber_inp
    

    IF unique_count > 0 THEN
        IF EXISTS (SELECT 1 FROM account WHERE username = user_account_inp) THEN
            err_msg := 'username must be unique.'
            RAISE NOTICE '%', err_msg;
        ELSIF EXISTS (SELECT 1 FROM account WHERE email = email_inp) THEN
            err_msg := 'email must be unique.';
            RAISE NOTICE '%', err_msg;
        ELSE
            err_msg := 'phonenumber must be unique.';
            RAISE NOTICE '%', err_msg;
        END IF;

        RETURN 'failed : ' || err_msg;
    END IF;


    INSERT INTO account(
        username, password, email, phonenumber
    ) VALUES (
        username_inp, password_inp, email_inp, phonenumber_inp
    )

    -- COMMIT;
    RETURN 'success : success - Registration of new user has been successfully.';

EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RETURN 'failed :  error - failed to inserting data new user, please try again!.';
END $$



-- query for add new group_note
CREATE OR REPLACE add_new_group_note (
    user_account_inp VARCHAR,
    title_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM account WHERE username = user_account_inp;
    IF NOT FOUND THEN 
        RAISE NOTICE '%','warning - user_account is not found!!';
        RETURN 'failed : warning - user_account is not found!!';
    END IF;

    INSERT INTO group_note(
        user_account,
        title
    ) VALUES (
        user_account_inp, title_inp
    )

    -- COMMIT;
    RETURN 'success : success - Added new group_note has been successfully..';
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE NOTICE '%', 'warning - user_account is not found!!';
    RETURN 'failed :  error - failed to inserting data new user, please try again';
END $$



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
    SELECT * FROM group_note WHERE id = group_note_id_inp;
    IF NOT FOUND THEN 
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
    RETURN 'failed :  error - failed to inserting data new note, please try again';
END $$;