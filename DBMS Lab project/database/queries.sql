SELECT product_name, unit_price FROM Products; 

SELECT * FROM Suppliers WHERE supplier_name LIKE '%Farm%';

SELECT order_id, order_date FROM PurchaseOrders WHERE supplier_id = 1 AND order_date > '2024-03-10'; -- Orders from supplier 1 after a specific date

-- Get purchase order details with supplier and product information
SELECT po.order_id, s.supplier_name, p.product_name, oi.quantity, oi.unit_price
FROM PurchaseOrders po
JOIN Suppliers s ON po.supplier_id = s.supplier_id
JOIN OrderItems oi ON po.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- Get inventory levels with warehouse and product details
SELECT w.warehouse_name, p.product_name, i.quantity_on_hand
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN Products p ON i.product_id = p.product_id;


SELECT supplier_name AS name, 'Supplier' AS type FROM Suppliers
UNION ALL
SELECT customer_name, 'Customer' FROM Customers;

SELECT AVG(unit_price) AS average_product_price FROM Products; -- Average product price

SELECT COUNT(*) AS total_purchase_orders FROM PurchaseOrders; -- Total number of purchase orders

SELECT SUM(total_amount) AS total_purchase_value FROM PurchaseOrders; -- Total value of purchase orders

SELECT MAX(quantity_on_hand) AS max_inventory_level FROM Inventory; -- Maximum inventory level

SELECT s.supplier_name, SUM(oi.quantity * oi.unit_price) AS total_spent_per_supplier
FROM PurchaseOrders po
JOIN Suppliers s ON po.supplier_id = s.supplier_id
JOIN OrderItems oi ON po.order_id = oi.order_id
GROUP BY s.supplier_name;