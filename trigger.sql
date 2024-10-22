CREATE TABLE Library (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    published_year INT,
    available_copies INT
);

CREATE TABLE Library_Logs (
    log_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    book_id INT,
    operation VARCHAR(10),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES Library(book_id)
);

CREATE OR REPLACE TRIGGER trg_Library_Audit
AFTER INSERT OR UPDATE OR DELETE ON Library
FOR EACH ROW
DECLARE
    v_operation VARCHAR(10);
BEGIN
    -- Determine the type of operation
    IF INSERTING THEN
        v_operation := 'INSERT';
    ELSIF UPDATING THEN
        v_operation := 'UPDATE';
    ELSIF DELETING THEN
        v_operation := 'DELETE';
    END IF;

    -- Insert a log record into the Library_Logs table
    INSERT INTO Library_Logs (book_id, operation) 
    VALUES (COALESCE(:NEW.book_id, :OLD.book_id), v_operation);
END trg_Library_Audit;



SET SERVEROUTPUT ON;

BEGIN
    -- Insert a new book into the Library
    INSERT INTO Library (book_id, title, author, published_year, available_copies)
    VALUES (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 5);
    DBMS_OUTPUT.PUT_LINE('Inserted a new book.');

    -- Update the available copies of the book
    UPDATE Library 
    SET available_copies = 10
    WHERE book_id = 1;
    DBMS_OUTPUT.PUT_LINE('Updated the available copies of the book.');

    -- Delete the book from the Library
    DELETE FROM Library WHERE book_id = 1;
    DBMS_OUTPUT.PUT_LINE('Deleted the book.');

    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
