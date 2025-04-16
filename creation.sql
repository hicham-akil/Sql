Create table Customers(
    customer_id int PRIMARY KEY,
    name VARCHAR(100),
    email varchar(100),
    country varchar(100)

);
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  stock INT
);
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  Foreign Key (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE OrderItems (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
