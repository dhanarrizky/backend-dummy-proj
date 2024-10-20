CREATE OR REPLACE FUNCTION transfer_funds(
   sender INT,
   receiver INT, 
   amount DEC
)
RETURNS TEXT
LANGUAGE plpgsql    
AS $$
DECLARE
    sender_balance DEC;
    receiver_exists BOOLEAN;
BEGIN
    -- check sender is exists
    SELECT balance INTO sender_balance FROM accounts WHERE id = sender;
    IF NOT FOUND THEN
        RETURN 'Gagal: Akun pengirim tidak ditemukan';
    END IF;

    -- check recevier is exists
    SELECT TRUE INTO receiver_exists FROM accounts WHERE id = receiver;
    IF NOT receiver_exists THEN
        RETURN 'Gagal: Akun penerima tidak ditemukan';
    END IF;

    -- validate balance from sender is enough
    IF sender_balance < amount THEN
        RETURN 'Gagal: Saldo pengirim tidak mencukupi';
    END IF;

    -- decrease balance from sender
    UPDATE accounts 
    SET balance = balance - amount 
    WHERE id = sender;

    -- add amount to receiver
    UPDATE accounts 
    SET balance = balance + amount 
    WHERE id = receiver;

    -- Commit transaksi
    COMMIT;

    RETURN 'Berhasil: Transfer berhasil dilakukan';
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'Gagal: Terjadi kesalahan saat transfer';
END; $$
