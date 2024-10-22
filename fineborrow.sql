CREATE TABLE Borrower (
    Roll INT PRIMARY KEY,
    Name VARCHAR(100),
    DateofIssue DATE,
    NameofBook VARCHAR(255),
    Status CHAR(1) -- 'I' for Issued, 'R' for Returned
);

CREATE TABLE Fine (
    Roll_no INT,
    DateofReturn DATE,
    Amt NUMBER
);


DECLARE
    roll_no       INT;
    book_name     VARCHAR(255);
    date_of_issue DATE;
    current_date  DATE := SYSDATE; -- Get the current date
    days_overdue  INT;
    fine_amount   NUMBER := 0;
    
BEGIN
    -- Accepting input for roll_no and name of book
    roll_no := &roll_no; -- Use substitution variable for user input
    book_name := '&book_name'; -- Use substitution variable for user input

    -- Fetch the date of issue and check the status
    SELECT DateofIssue INTO v_date_of_issue
    FROM Borrower
    WHERE Rollin = v_roll_no AND NameofBook = v_book_name AND Status = 'I';
    
    -- Calculate the number of overdue days
    v_days_overdue := TRUNC(v_current_date - v_date_of_issue);
    
    -- Calculate fine based on the number of overdue days
    IF v_days_overdue > 30 THEN
        v_fine_amount := (v_days_overdue * 50); -- Rs 50 per day for days > 30
    ELSIF v_days_overdue >= 15 THEN
        v_fine_amount := (v_days_overdue * 5); -- Rs 5 per day for days 15 to 30
    ELSE
        v_fine_amount := 0; -- No fine if less than 15 days
    END IF;

    -- Update the status of the book
    UPDATE Borrower
    SET Status = 'R'
    WHERE Rollin = v_roll_no AND NameofBook = v_book_name;

    -- If a fine is applicable, insert into Fine table
    IF v_fine_amount > 0 THEN
        INSERT INTO Fine (Roll_no, Date, Amt)
        VALUES (v_roll_no, v_current_date, v_fine_amount);
    END IF;

    -- Commit the transaction
    COMMIT;

    -- Output message
    DBMS_OUTPUT.PUT_LINE('Book returned successfully. Fine amount: Rs ' || v_fine_amount);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No record found for the given Roll Number and Book Name.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


