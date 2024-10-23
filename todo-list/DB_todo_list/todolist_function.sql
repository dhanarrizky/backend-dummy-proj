-- ==== DELETE USING SOFT DELETE
-- SELECT soft_delete(123);

CREATE OR REPLACE FUNCTION soft_delete(table_name VARCHAR(100), username_inp VARCHAR(50), id_inp INT)
RETURNS text AS $$
DECLARE
    row_count INT;
BEGIN
    IF table_name = 'account' OR
        table_name = 'group_note' OR
        table_name = 'note' THEN

        IF table_name = 'account' THEN
            UPDATE account
            SET deleted_at = NOW()
            WHERE username = username_inp;
        ELSE
            EXECUTE FORMAT('UPDATE %I SET deleted_at = NOW() WHERE id = $1', table_name)
            USING id_inp;
        END IF;

        GET DIAGNOSTICS row_count = ROW_COUNT;
        
        IF row_count > 0 THEN
            RETURN FORMAT('%s soft-deleted successfully', table_name);
        ELSE
            RETURN FORMAT('%s soft-deleted failed', table_name);
        END IF;

    ELSE
        RETURN 'table_name not found';
    END IF;

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION checked_note(id_inp INT)
RETURNS text AS $$
DECLARE
    row_count INT;
BEGIN
    UPDATE note
    SET checked = TRUE, Updated_at = NOW()
    WHERE id = id_inp;

    GET DIAGNOSTICS row_count = ROW_COUNT;

    IF row_count > 0 THEN
        RETURN FORMAT('Note with id %s has been checked successfully.', id_inp);
    ELSE
        RETURN FORMAT('No note found with id %s.', id_inp);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN FORMAT('Error checking note: %', SQLERRM);
END;
$$ LANGUAGE plpgsql;

