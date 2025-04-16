CREATE Function function_q1(p_order_id int)returns decimal(10,2)
begin
DECLARE result decimal(10,2);
SELECT sum(o.quantity * P.price) INTO result
FROM orderitems o
JOIN products P ON `P`.product_id=o.product_id
WHERE o.order_id=p_order_id;
RETURN result;
END;


SELECT function_q1(1);
//2 ;
CREATE TABLE OrderItems (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  Foreign Key (customer_id) REFERENCES Customers(customer_id)
);
CREATE Procedure Ex2(    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT)
begin
   DECLARE new_order_id INT;

    -- Create new order
    INSERT INTO Orders(customer_id, order_date)
    VALUES (p_customer_id, CURDATE());
    
    SET new_order_id = LAST_INSERT_ID();

    -- Insert order item
    INSERT INTO OrderItems(order_id, product_id, quantity)
    VALUES (new_order_id, p_product_id, p_quantity);

    -- Update stock
    UPDATE Products
    SET stock = stock - p_quantity
    WHERE product_id = p_product_id;
END;
DROP Procedure `Ex2`;

CREATE Procedure ex3()
begin
 DECLARE done int DEFAULT 0;
 DECLARE c_order_id int ;
 DECLARE cur CURSOR for
  SELECT order_id FROM orders;
 DECLARE CONTINUE HANDLER for NOT FOUND SET done=1;
OPEN cur;
read_loop: LOOP
  FETCH cur INTO c_order_id;
  if done THEN
    LEAVE read_loop;
  end if;
  SELECT function_q1(c_order_id);
END LOOP;
CLOSE cur;
END;
CALL Ex3();

CREATE Trigger trg1
BEFORE INSERT on orderitems
for each row
begin
DECLARE stock int;
SELECT stock INTO stock FROM products WHERE product_id=new.product_id;
  if new.quantity>stock then
  SIGNAL SQLSTATE '45000'
  set MESSAGE_TEXT='not enough stock';
  END if;
end;