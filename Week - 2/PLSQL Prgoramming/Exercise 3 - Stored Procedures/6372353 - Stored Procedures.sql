--6372353 
--Varun S

--Scenario 1: The bank needs to process monthly interest for all savings accounts.
--Question: Write a stored procedure ProcessMonthlyInterest that calculates and updates the balance of all savings accounts by applying an interest rate of 1% to the current balance.

--Create Table

DROP TABLE accounts;

CREATE TABLE accounts (
    acc_id        NUMBER PRIMARY KEY,
    acc_holder    VARCHAR2(50),
    balance       NUMBER(10,2),
    account_type  VARCHAR2(20)  
);

-- Sample savings and current accounts
INSERT INTO accounts VALUES (101, 'Arun', 5000, 'Savings');
INSERT INTO accounts VALUES (102, 'Divya', 3000, 'Savings');
INSERT INTO accounts VALUES (103, 'Karan', 10000, 'Current');
INSERT INTO accounts VALUES (104, 'Meena', 8000, 'Savings');

COMMIT;


CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    FOR acc IN (
        SELECT acc_id, balance
        FROM accounts
        WHERE account_type = 'Savings'
    )
    LOOP
        UPDATE accounts
        SET balance = balance + (acc.balance * 0.01)
        WHERE acc_id = acc.acc_id;

        DBMS_OUTPUT.PUT_LINE('Interest applied to Account ID ' || acc.acc_id);
    END LOOP;

    COMMIT;
END;
/


BEGIN
    ProcessMonthlyInterest;
END;
/


--SCENARIO 2

DROP TABLE employees;

CREATE TABLE employees (
    emp_id     NUMBER PRIMARY KEY,
    emp_name   VARCHAR2(50),
    salary     NUMBER(10,2),
    dept_name  VARCHAR2(30)
);


INSERT INTO employees VALUES (1, 'Rahul Sharma', 40000, 'IT');
INSERT INTO employees VALUES (2, 'Priya Singh', 55000, 'HR');
INSERT INTO employees VALUES (3, 'Amit Verma', 60000, 'IT');
INSERT INTO employees VALUES (4, 'Neha Rao', 45000, 'Finance');

COMMIT;


CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_dept_name   IN VARCHAR2,
    p_bonus_pct   IN NUMBER
)
IS
BEGIN
    FOR emp IN (
        SELECT emp_id, salary
        FROM employees
        WHERE dept_name = p_dept_name
    )
    LOOP
        UPDATE employees
        SET salary = salary + (salary * p_bonus_pct / 100)
        WHERE emp_id = emp.emp_id;

        DBMS_OUTPUT.PUT_LINE('Bonus applied to Employee ID ' || emp.emp_id);
    END LOOP;

    COMMIT;
END;
/


BEGIN
    UpdateEmployeeBonus('IT', 10);  -- Give 10% bonus to IT dept
END;
/


--SCENARIO 3

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_acc_id   IN NUMBER,
    p_to_acc_id     IN NUMBER,
    p_amount        IN NUMBER
)
IS
    v_from_balance  NUMBER;
BEGIN
    -- Get balance of sender
    SELECT balance INTO v_from_balance
    FROM accounts
    WHERE acc_id = p_from_acc_id;

    -- Check if sufficient balance
    IF v_from_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient balance in account ' || p_from_acc_id);
        RETURN;
    END IF;

    -- Deduct from sender
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE acc_id = p_from_acc_id;

    -- Add to receiver
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE acc_id = p_to_acc_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('₹' || p_amount || ' transferred from Account ' || p_from_acc_id || ' to Account ' || p_to_acc_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: One or both account IDs do not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/


BEGIN
    TransferFunds(101, 102, 500);
END;
/

