- Suppliers first
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
