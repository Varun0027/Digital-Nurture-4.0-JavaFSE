-- Drop if already exists
DROP TABLE loans;
DROP TABLE customers;

-- Create customers table
CREATE TABLE customers (
    cust_id     NUMBER PRIMARY KEY,
    name        VARCHAR2(50),
    age         NUMBER,
    balance     NUMBER(10,2),
    isVIP       VARCHAR2(5)
);

-- Create loans table
CREATE TABLE loans (
    loan_id         NUMBER PRIMARY KEY,
    cust_id         NUMBER REFERENCES customers(cust_id),
    interest_rate   NUMBER(5,2),
    due_date        DATE
);

-- Insert sample customers
INSERT INTO customers VALUES (1, 'Ram Kumar',     65, 12000, 'FALSE');
INSERT INTO customers VALUES (2, 'Sneha Reddy',   45,  8000,  'FALSE');
INSERT INTO customers VALUES (3, 'John Peter',    70, 15000, 'FALSE');
INSERT INTO customers VALUES (4, 'Meena Devi',    30, 25000, 'FALSE');
INSERT INTO customers VALUES (5, 'Rajesh Khanna', 62,  9500,  'FALSE');

-- Insert sample loans
INSERT INTO loans VALUES (101, 1, 7.5, SYSDATE + 15);   -- due in 15 days
INSERT INTO loans VALUES (102, 2, 8.2, SYSDATE + 40);   -- due in 40 days
INSERT INTO loans VALUES (103, 3, 6.5, SYSDATE + 5);    -- due in 5 days
INSERT INTO loans VALUES (104, 4, 9.1, SYSDATE + 60);   -- due in 60 days
INSERT INTO loans VALUES (105, 5, 8.0, SYSDATE + 10);   -- due in 10 days

-- Commit changes to make them permanent
COMMIT;


BEGIN
    FOR cust IN (
        SELECT c.cust_id, l.loan_id, l.interest_rate
        FROM customers c
        JOIN loans l ON c.cust_id = l.cust_id
        WHERE c.age > 60
    )
    LOOP
        -- Apply 1% discount to the current interest rate
        UPDATE loans
        SET interest_rate = cust.interest_rate - 1
        WHERE loan_id = cust.loan_id;
        
        DBMS_OUTPUT.PUT_LINE('1% discount applied to customer ID ' || cust.cust_id || 
                             ' (Loan ID: ' || cust.loan_id || ')');
    END LOOP;
    
    COMMIT;
END;
/
BEGIN
    FOR cust IN (
        SELECT cust_id, balance
        FROM customers
        WHERE balance > 10000
    )
    LOOP
        UPDATE customers
        SET isVIP = 'TRUE'
        WHERE cust_id = cust.cust_id;

        DBMS_OUTPUT.PUT_LINE('Customer ID ' || cust.cust_id || 
                             ' is now marked as VIP.');
    END LOOP;

    COMMIT;
END;
/
BEGIN
    FOR loan_rec IN (
        SELECT l.loan_id, l.due_date, c.name, c.cust_id
        FROM loans l
        JOIN customers c ON l.cust_id = c.cust_id
        WHERE l.due_date <= SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan_rec.loan_id ||
                             ' for Customer "' || loan_rec.name || '" (ID: ' || loan_rec.cust_id || ') is due on ' ||
                             TO_CHAR(loan_rec.due_date, 'DD-MON-YYYY'));
    END LOOP;
END;
/


