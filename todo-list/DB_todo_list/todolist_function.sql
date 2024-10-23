-- ==== DELETE USING SOFT DELETE
-- CREATE OR REPLACE FUNCTION soft_delete(p_id INT)
-- RETURNS VOID AS $$
-- BEGIN
--     UPDATE your_table
--     SET is_deleted = TRUE,
--         deleted_at = NOW()
--     WHERE id = p_id;
-- END;
-- $$ LANGUAGE plpgsql;


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
