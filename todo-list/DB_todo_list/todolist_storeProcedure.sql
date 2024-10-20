-- createing new user ( registration )
INSERT INTO accounts (
    username VARCHAR,
    password VARCHAR,
    email VARCHAR,
    phonenumber VARCHAR
)

CREATE OR REPLACE PROCEDURE reg_new_user(
    username_inp VARCHAR,
    password_inp VARCHAR,
    email_inp VARCHAR,
    phonenumber_inp VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO(
        username, password, email, phonenumber
    ) VALUES (
        username_inp, password_inp, email_inp, phonenumber_inp
    )
END $$