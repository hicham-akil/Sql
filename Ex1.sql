
//1

SELECT name ,email from customers ;

SELECT * FROM products WHERE price > 50;

SELECT * FROM orders WHERE order_date>' 2024-4-1';

SELECT * FROM customers WHERE country='france';
//2;
SELECT C.customer_id ,O.order_date
FROM customers C
JOIN orders O ON O.customer_id=C.customer_id;

SELECT p.product_id,O.quantity ,(P.price * O.quantity) AS 'total price'
from OrderItems O
JOIN products P ON p.product_id=O.product_id ;

SELECT O.order_id, P.name , C.email 
FROM orders O 
JOIN customers C on C.customer_id=O.customer_id
JOIN orderitems I ON I.order_id=O.order_id
JOIN products P ON P.product_id=I.product_id;

//3;
SELECT COUNT(O.order_id),C.customer_id
FROM orders O
JOIN customers C on C.customer_id=O.customer_id
GROUP BY C.customer_id;

SELECT sum(P.price*O.quantity)
FROM products P
JOIN orderitems O ON O.product_id=P.product_id;
SELECT sum(O.quantity) , P.product_id,
  P.name
FROM products P
JOIN orderitems O ON O.product_id=P.product_id
GROUP BY P.product_id;
//4;
SELECT C.customer_id, COUNT(O.order_id) as total_orders
FROM orders O
JOIN customers C ON C.customer_id=O.customer_id
GROUP BY customer_id
HAVING total_orders>0;

SELECT SUM(O.quantity)  as total_quantity ,O.product_id
FROM orderitems O
GROUP BY O.product_id
HAVING total_quantity>1;

//4;

SELECT * 
FROM products
ORDER BY price DESC; 

SELECT SUM(P.price*O.quantity) as total_spent, O.product_id
FROM products P
JOIN orderitems O ON O.product_id=P.product_id
JOIN customers C ON C.customer_id=O.
ORDER BY total_spent DEsC
GROUP BY 

