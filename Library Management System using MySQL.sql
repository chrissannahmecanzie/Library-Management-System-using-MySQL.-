CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);
INSERT into BRANCH VALUES
(1, 101, '123 Main St, Anytown USA', 1234567890),
(2, 102, '456 Oak Rd, Somewhere City', 0987654321),
(3, 103, '789 Elm St, Elsewhere Town', 5555555555),
(4, 104, '321 Pine Ave, Somewhere Else', 9999999999),
(5, 105, '654 Maple Blvd, Anywhere City', 8888888888);

CREATE TABLE Employee (
    Employee_Id INT PRIMARY KEY,
    Employee_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
INSERT INTO Employee (Employee_Id, Employee_name, Position, Salary, Branch_no) 
VALUES 
(1, 'John Doe', 'Manager', 60000.00, 1),
(2, 'Jane Smith', 'Assistant Manager', 40000.00, 1),
(3, 'Alice Johnson', 'Clerk', 30000.00, 2),
(4, 'Bob Williams', 'Assistant Clerk', 25000.00, 2),
(5, 'Eva Brown', 'Janitor', 20000.00, 3);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'John', '123 Main St, Anytown, USA', '2021-12-31'),
(2, 'Mary George', '456 Elm St, Sometown, USA', '2021-11-15'),
(3, 'Thomas Daniel', '789 Oak St, Othertown, USA', '2021-10-20'),
(4, 'Dia', '101 Pine St, Anothertown, USA', '2021-09-05'),
(5, 'Aby Abraham', '222 Maple St, Yetanothertown, USA', '2021-08-10');

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'The Outsider', '2022-03-15', 123456789),
(2, 2, 'Hamlet', '2022-06-20', 234567890),
(3, 3, 'Sunset', '2022-01-01', 345678901),
(4, 4, 'The Magic of Memoir', '2021-12-25', 456789012),
(5, 5, 'The Witch Elm', '2021-11-30', 567890123);

CREATE TABLE Books (
    ISBN varchar(200),
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
(1, 'The Outsider', 'Fiction', 10.00, 'yes', 'Stephen King', 'Publisher 1'),
(2, 'Hamlet', 'Fiction', 12.00, 'yes', 'William Shakespeare', 'Publisher 2'),
(3, 'Sunset', 'Non-fiction', 15.00, 'yes', 'Amy Lane', 'Publisher 3'),
(4, 'The Magic of Memoir', 'Non-fiction', 18.00, 'yes', 'Brooke Warner', 'Publisher 4'),
(5, 'The Witch Elm', 'Mystery', 20.00, 'yes', 'Tana French', 'Publisher 5');

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2.List the employee names and their respective salaries in descending order of salary.
SELECT Employee_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
select issued_cust,issued_book_name from issuestatus;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Employee_name, Position
FROM Employee
WHERE Salary > 50000.00;

-- 6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
select customer_name from customer where Reg_date<"2022-01-01" and customer_id not in (select issued_cust from issuestatus);

-- 7.Display the branch numbers and the total count of employees in each branch.
select b.branch_no,count(e.employee_id) as total_employees from branch b left join 
employee e on b.branch_no=e.branch_no group by b.branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.;
select customer_name from customer where month(Reg_date)=6;

-- 9.Retrieve book_title from book table containing history.
select book_title from books where book_title like "%history%" ;

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(Employee_Id) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(Emp_Id) >5;


drop database library;

