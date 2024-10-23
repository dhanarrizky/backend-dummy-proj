-- createing new user ( registration )
INSERT INTO accounts (
    username VARCHAR,
    password VARCHAR,
    email VARCHAR,
    phonenumber VARCHAR
)


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
    unique_count int
BEGIN
    SELECT COUNT(*) INTO unique_count FROM accounts WHERE username = username_inp;
    IF unique_count > 0 THEN
        RETURN 'failed : warning - username must be unique!!'
    END IF;

    SELECT COUNT(*) INTO unique_count FROM accounts WHERE email = email_inp;
    IF unique_count > 0 THEN
        RETURN 'failed : warning - email must be unique!!'
    END IF;

    INSERT INTO account(
        username, password, email, phonenumber
    ) VALUES (
        username_inp, password_inp, email_inp, phonenumber_inp
    )

    COMMIT;
    RETURN 'success : success - Registration of new user has been successfully..';

EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RETURN 'failed :  error - failed to inserting data new user, please try again';
END $$


-- query for add new Group
CREATE OR REPLACE add_new_group (
    user_account_inp VARCHAR,
    title_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM account WHERE username = user_account_inp;
    IF NOT FOUND THEN 
        RETURN 'failed : warning - user_account is not found!!'
    END IF;

    INSERT INTO group(
        user_account,
        title
    ) VALUES (
        user_account_inp, title_inp
    )

    COMMIT;
    RETURN 'success : success - Added new group has been successfully..'
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RETURN 'failed :  error - failed to inserting data new user, please try again';
END $$

CREATE OR REPLACE add_new_todo_list(
    group_id_inp VARCHAR,
    title_inp VARCHAR,
    text_content_inp TEXT,
    checked_inp BOOLEAN
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    
END $$;