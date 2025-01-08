--CREATING DATABASE LIBRARY
create database Library;
use Library;

--CREATING TABLE Branch--

create table Branch(
Branch_no int primary key,
Manager_Id int,
Branch_address varchar(30),
Contact_no varchar(15)
);

--INSERTING VALUES INTO THE TABLE BRANCH--
insert into Branch (Branch_no,Manager_Id,Branch_address,Contact_no) values
(1,1,'ABC Street 1st Main Block','9876543210'),
(2,2,'New Street 6th Main Block','9876543211'),
(3,3,'Second Street 7th Main Block','9876543212'),
(4,4,'XYZ Street 1st Main Block','9876543213'),
(5,5,'Hosur Street 2nd Main Block','9876543214'),
(6,6,'City Street 11th Main Block','9876543215'),
(7,7,'Look Street 6th Main Block','9876543216'),
(8,8,'North Street 1st Main Block','9876543217'),
(9,9,'East Street 5th Main Block','9876543218'),
(10,10,'Pass Street 3rd Main Block','9876543219');
select * from Branch;

--CREATING TABLE Employee--
create table Employee(
Emp_Id int Auto_increment primary key,
Emp_name varchar(15),
Positions varchar(50),
Salary decimal(10,2),
Branch_no int,
Foreign key (Branch_no) references Branch(Branch_no));

--INSERTING VALUES INTO TABLE EMPLOYEE--
insert into Employee(Emp_name,Positions,Salary,Branch_no) values
('Jose Thomas','Head Librarian',60000,1),
('Mathew Varghese','Librarian',38000,2),
('Xavier Antony','Head Librarian',55000,2),
('Treasa Rose','Librarian',35000,1),
('Philip Mathew','Clerk',25000.60,1),
('Mohan P','Clerk',30000.35,3),
('Swetha K','Librarian',35000.50,1),
('Shobana R','Clerk',25000,1),
('Kaviya P R','Clerk',25000,1);

select * from Employee;

--CREATING TABLE Books--
create table Books(
ISBN char(5) primary key,
Book_title varchar(50) not null,
Category varchar(35),
Rental_Price decimal(10,2),
Status ENUM('Yes', 'No') DEFAULT 'Yes',
Author varchar(40),
Publisher varchar(40)
);
--INSERTING VALUES INTO TABLE BOOKS--
insert into Books(ISBN,Book_title,Category,Rental_Price,Status,Author,Publisher) values
(1001,'The History of Time','Science',50.00,'Yes','Stephen Hawking','Bantam Books'),
(1002,'Python Programming Basics','Programming',40.00,'Yes','John Zelle','Franklin Beedle'),
(1003,'The Art of War','Philosophy',30.00,'Yes','Sun Tzu','Penguin Classics'),
(1004,'Pride and Prejudice','Fiction',25.00,'No','Jane Austen','Whitehall Press'),
(1005,'Data Science Handbook','Technology',60.00,'Yes','Carl Shan','Data Insights'),
(1006,'Cosmos','Science',45.00,'Yes','Carl Sagan','Random House'),
(1007,'The Great Gatsby','Fiction',35.00,'Yes','F. Scott Fitzgerald','Charles Scribners Sons'),
(1008,'Machine Learning Explained','Technology',70.00,'No','Michael Bowles','Wiley'),
(1009,'To Kill a Mockingbird','Fiction',30.00,'Yes','Harper Lee','J.B. Lippincott & Co.'),
(1010,'Clean Code','Programming',80.00,'No','Robert C. Martin','Prentice Hall');

select * from Books;
--CREATE TABLE Customer--
create table Customer(
Customer_Id int primary key auto_increment,
Customer_name varchar(25) not null,
Customer_address varchar(50),
Reg_date date
);
--INSERING VALUES INTO TABLE CUSTOMER--
insert into Customer(Customer_name,Customer_address,Reg_date) values
('Rahul Madhav','1st Block 2nd Cross SR layout','2021-03-06'),
('Sneha Dev','Palie Street Church Road','2021-04-30'),
('Thomas Jacob','Venue Road Behind HTC','2021-04-03'),
('Chitra S','Park View Port,2nd Main Road','2022-04-30');

select * from Customer;
 
--CREATE TABLE IssueStatus--
create table IssueStatus(
Issue_Id int auto_increment primary key,
Issued_cust int not null,
Issued_book_name varchar(50) not null,
Issue_date date,
Isbn_book char(13),
Foreign key (Issued_cust) references Customer(Customer_Id),
Foreign key (Isbn_book) references Books(ISBN)
);

--INSERTING VALUES INTO TABLE ISSUESTATUS---
insert into IssueStatus(Issued_cust,Issued_book_name,Issue_date,Isbn_book) values
(1,'Clean Code','2024-09-25',1010),
(2,'Data Science Handbook','2023-06-11',1005),
(2,'Clean Code','2023-06-28',1010);

select * from IssueStatus;

--CREATING TABLE ReturnStatus--
create table ReturnStatus(
Return_Id int primary key auto_increment,
Return_cust varchar(50) not null,
Return_book_name varchar(50) not null,
Return_date date not null,
Isbn_book2 char(13),
Foreign key (Isbn_book2) references Books(ISBN)
);

--INSERTING VALUES INTO TABLE RETURN STATUS--
insert into ReturnStatus(Return_cust,Return_book_name,Return_date,Isbn_book2)values
('Rahul Madhav','Clean Code','2024-10-10',1010);

select * from ReturnStatus;

1. Retrieve the book title, category, and rental price of all available books. 
select Book_title,Category,Rental_Price from Books;

2. List the employee names and their respective salaries in descending order of salary. 
select Emp_name as Employee_Name,Salary from Employee order by Salary desc;

3. Retrieve the book titles and the corresponding customers who have issued those books. 
select b.Book_title, c.Customer_name from IssueStatus i
join Books b on i.Isbn_book = b.ISBN
join Customer c on i.Issued_cust = c.Customer_Id;

4. Display the total count of books in each category.
select Category,count(*) as Total_Books from Books group by Category;

 5. Retrieve the employee names and their positions for the employees whose salaries are 
 above Rs.50,000.
 select Emp_name as Employee_Name,Positions,Salary from Employee where Salary >50000;
 
 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
select c.Customer_name from Customer c
left join IssueStatus i on c.Customer_Id = i.Issued_cust
where c.Reg_date < '2022-01-01' and i.Issue_Id is null;

 7. Display the branch numbers and the total count of employees in each branch.
 select Branch_no,count(*) as Total_Employee from Employee group by  Branch_no;
 
8. Display the names of customers who have issued books in the month of June 2023. 
select distinct c.Customer_name from IssueStatus i
join Customer c on i.Issued_cust = c.Customer_Id
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';


9. Retrieve book_title from book table containing history. 
select Book_title from Books where Book_title like '%history%';

10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select Branch_no, COUNT(*) as Employee_Count from Employee group by Branch_no having COUNT(*) > 5;

11. Retrieve the names of employees who manage branches and their respective branch addresses. 
select e.Emp_name, b.Branch_address from Employee e join Branch b on e.Emp_Id = b.Manager_Id;

12. Display the names of customers who have issued books with a rental price higher than Rs. 25. 
select distinct c.Customer_name from IssueStatus i
join Books b on i.Isbn_book = b.ISBN
join Customer c on i.Issued_cust = c.Customer_Id
where b.Rental_Price > 25;

