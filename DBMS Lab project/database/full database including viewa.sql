CREATE DATABASE inventorysystem;
USE inventorysystem;

-- Create tables 
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    unit_price DECIMAL(10, 2) NOT NULL,
    unit_of_measure VARCHAR(50)
);

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255)
);

CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_name VARCHAR(255) NOT NULL,
    address VARCHAR(255)
);


CREATE TABLE PurchaseOrders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES PurchaseOrders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_on_hand INT NOT NULL,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE InventoryAudits (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    inventory_id INT NOT NULL,
    audit_date DATE NOT NULL,
    quantity_counted INT NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES Inventory(inventory_id)
);


CREATE VIEW PurchaseOrdersWithSupplier AS
SELECT
    po.order_id,
    po.order_date,
    po.total_amount,
    s.supplier_name,
    s.contact_person,
    s.phone,
    s.email
FROM
    PurchaseOrders po
JOIN
    Suppliers s ON po.supplier_id = s.supplier_id;

-- View for Order Items with Product and Order Information
CREATE VIEW OrderItemsWithDetails AS
SELECT
    oi.order_item_id,
    oi.quantity,
    oi.unit_price,
    p.product_name,
    p.description,
    po.order_id,
    po.order_date
FROM
    OrderItems oi
JOIN
    Products p ON oi.product_id = p.product_id
JOIN
    PurchaseOrders po ON oi.order_id = po.order_id;

-- View for Inventory with Warehouse and Product Information
CREATE VIEW InventoryWithDetails AS
SELECT
    i.inventory_id,
    i.quantity_on_hand,
    w.warehouse_name,
    w.address,
    p.product_name,
    p.description
FROM
    Inventory i
JOIN
    Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN
    Products p ON i.product_id = p.product_id;

-- View for Inventory Audits with Inventory details
CREATE VIEW InventoryAuditsWithDetails AS
SELECT
    ia.audit_id,
    ia.audit_date,
    ia.quantity_counted,
    i.inventory_id,
    i.quantity_on_hand,
    w.warehouse_name,
    p.product_name
FROM
    InventoryAudits ia
JOIN
    Inventory i ON ia.inventory_id = i.inventory_id
JOIN
    Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN
    Products p ON i.product_id = p.product_id;
 
SELECT * FROM PurchaseOrdersWithSupplier;
SELECT * FROM OrderItemsWithDetails;
SELECT * FROM InventoryWithDetails;


-- Insert data.  The order is crucial here!

-- Suppliers first
INSERT INTO Suppliers (supplier_name, contact_person, phone, email) VALUES
('Apple Orchard', 'John Smith', '555-1212', 'john@apple.com'),
('Happy Hens Farm', 'Jane Doe', '555-3434', 'jane@hens.com'),
('Bee Happy Apiary', 'Peter Jones', '555-5656', 'peter@beehappy.com'),
('The Bread Basket', 'Mary Brown', '555-7878', 'mary@bread.com'),
('Dairy Delight', 'Robert Green', '555-9090', 'robert@dairy.com');

INSERT INTO Customers (customer_name, address, phone, email) VALUES
('Community Market', '789 Market Street', '555-1111', 'market@community.com'),
('Local Bakery', '101 Baker Lane', '555-2222', 'bakery@local.com'),
('Green Grocer', '321 Green Ave', '555-3333', 'grocer@green.com'),
('Healthy Eats Cafe', '456 Healthy Blvd', '555-4444', 'cafe@healthyeats.com'),
('Farm Fresh Deli', '678 Farm Road', '555-5555', 'deli@farmfresh.com');

-- Products next
INSERT INTO Products (product_name, description, unit_price, unit_of_measure) VALUES
('Organic Apples', 'Locally grown apples', 2.50, 'kg'),
('Free-Range Eggs', 'Farm fresh eggs', 4.00, 'dozen'),
('Honey', 'Raw honey from local apiary', 8.00, 'jar'),
('Artisan Bread', 'Freshly baked sourdough bread', 5.00, 'loaf'),
('Local Cheese', 'Cheddar cheese from a nearby farm', 7.00, 'lb');


INSERT INTO Warehouses (warehouse_name, address) VALUES
('Main Warehouse', '123 Main Street'),
('Westside Warehouse', '456 West Ave');


-- Purchase Orders (referencing existing Suppliers)
INSERT INTO PurchaseOrders (supplier_id, order_date, total_amount) VALUES
(1, '2024-03-01', 125.00),
(2, '2024-03-05', 80.00),
(3, '2024-03-10', 40.00),
(4, '2024-03-15', 150.00),
(5, '2024-03-20', 210.00);

-- Order Items (referencing existing Products and PurchaseOrders)
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price) VALUES
(1,1,50,2.50),
(2,2,20,4.00),
(3,3,5,8.00),
(4,4,30,5.00),
(5,5,30,7.00);


-- Inventory (referencing existing Products and Warehouses)
INSERT INTO Inventory (warehouse_id, product_id, quantity_on_hand) VALUES
(1, 1, 100),
(1, 2, 50),
(1, 3, 20),
(2, 4, 80),
(2, 5, 60);

-- Inventory Audits (referencing existing Inventory)
INSERT INTO InventoryAudits (inventory_id, audit_date, quantity_counted) VALUES
(1, '2024-03-01', 98),
(2, '2024-03-01', 48),
(3, '2024-03-01', 18),
(4, '2024-03-01', 75),
(5, '2024-03-01', 55);

-- Index on supplier_id in PurchaseOrders for faster lookups of orders by supplier
CREATE INDEX idx_purchaseorders_supplier ON PurchaseOrders (supplier_id);

-- Index on product_id in OrderItems for faster lookups of items by product
CREATE INDEX idx_orderitems_product ON OrderItems (product_id);

-- Index on product_id in Inventory for faster lookups of inventory levels by product
CREATE INDEX idx_inventory_product ON Inventory (product_id);

-- Composite index on warehouse_id and product_id in Inventory for efficient queries
-- that filter by both warehouse and product
CREATE INDEX idx_inventory_warehouse_product ON Inventory (warehouse_id, product_id);

-- Index on inventory_id in InventoryAudits for faster lookups of audits by inventory
CREATE INDEX idx_inventoryaudits_inventory ON InventoryAudits (inventory_id);


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