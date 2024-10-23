-- Insert dummy data into 'account'
INSERT INTO account (username, password, email, phonenumber)
VALUES
('john_doe', 'hashedpassword1', 'john@example.com', '081234567890'),
('jane_doe', 'hashedpassword2', 'jane@example.com', '081234567891'),
('alex_smith', 'hashedpassword3', 'alex@example.com', '081234567892');

-- Insert dummy data into 'group_note'
INSERT INTO group_note (user_account, title)
VALUES
('john_doe', 'Work Tasks'),
('john_doe', 'Personal Tasks'),
('jane_doe', 'Shopping List'),
('alex_smith', 'Study Notes');

-- Insert dummy data into 'note'
INSERT INTO note (group_note_id, title, text_content, checked)
VALUES
(1, 'Finish Project', 'Complete the project by the end of the week', FALSE),
(1, 'Client Meeting', 'Prepare slides for client presentation', TRUE),
(2, 'Grocery Shopping', 'Buy milk, eggs, and bread', FALSE),
(3, 'Read Book', 'Finish reading "The Pragmatic Programmer"', TRUE),
(4, 'Complete Assignment', 'Finish database assignment by Monday', FALSE);
