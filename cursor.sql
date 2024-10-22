CREATE TABLE N_RollCall (
    rno INT PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(20)
);

CREATE TABLE O_RollCall (
    rno INT PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(20)
);


DECLARE
    v_name N_RollCall.name%TYPE;
    v_status N_RollCall.status%TYPE;
BEGIN
    SELECT name, status INTO v_name, v_status 
    FROM N_RollCall
    WHERE rno = 2;

    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name || ', Status: ' || v_status);
END;



DECLARE
    CURSOR roll_cursor IS
        SELECT rno, name, status FROM N_RollCall;

    v_rno N_RollCall.rno%TYPE;
    v_name N_RollCall.name%TYPE;
    v_status N_RollCall.status%TYPE;
BEGIN
    OPEN roll_cursor;
    LOOP
        FETCH roll_cursor INTO v_rno, v_name, v_status;
        EXIT WHEN roll_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Roll No: ' || v_rno || ', Name: ' || v_name || ', Status: ' || v_status);
    END LOOP;
    CLOSE roll_cursor;
END;



DECLARE
    CURSOR roll_cursor IS
        SELECT rno, name, status FROM N_RollCall;
BEGIN
    FOR rec IN roll_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Roll No: ' || rec.rno || ', Name: ' || rec.name || ', Status: ' || rec.status);
    END LOOP;
END;




DECLARE
    CURSOR param_cursor (p_status VARCHAR2) IS
        SELECT rno, name FROM N_RollCall WHERE status = p_status;
BEGIN
    FOR rec IN param_cursor('Present') LOOP
        DBMS_OUTPUT.PUT_LINE('Roll No: ' || rec.rno || ', Name: ' || rec.name);
    END LOOP;
END;


SET SERVEROUTPUT ON;

BEGIN
    MERGE INTO O_RollCall o
    USING N_RollCall n
    ON (o.rno = n.rno)
    WHEN NOT MATCHED THEN
        INSERT (rno, name, status)
        VALUES (n.rno, n.name, n.status);

    DBMS_OUTPUT.PUT_LINE('Data merge process completed. ' || SQL%ROWCOUNT || ' rows merged.');

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
