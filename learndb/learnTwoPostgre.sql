CREATE TABLE account (
    username VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phonenumber VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    deleted_at TIMESTAMP
)

select * from account where username = 'test'

INSERT INTO account (username, password, email, phonenumber)
VALUES ('test','test','test@gmail.com','+123456403445')


CREATE OR REPLACE FUNCTION check_username(username_input VARCHAR)
RETURNS TEXT AS $$
DECLARE
    user_found RECORD;
BEGIN
    -- Attempt to select the user based on the provided username
    SELECT * INTO user_found FROM account WHERE username = username_input;

    -- Check if the user was found
    IF NOT FOUND THEN
        RETURN 'not found';
    ELSE
        RETURN 'found';
    END IF;
END; $$
LANGUAGE plpgsql;


select 
	case
		when exists (select * from account where username = 'hihihi')
		then 'found'
		else 'not found'
	end as status;