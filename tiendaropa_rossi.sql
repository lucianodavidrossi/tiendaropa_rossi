-- Creación de la base de datos
CREATE DATABASE tiendaropa_rossi;

USE tiendaropa_rossi;

-- Tabla de clientes
CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  phone VARCHAR(15),
  address TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de productos
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  price DECIMAL(10, 2),
  stock INT,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabla de categorías
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

-- Tabla de pedidos
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Tabla de ítems de pedido
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(10, 2),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Tabla de pagos
CREATE TABLE payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(10, 2),
  payment_method VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Tabla de proveedores
CREATE TABLE suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  contact_name VARCHAR(100),
  contact_email VARCHAR(255),
  contact_phone VARCHAR(15)
);

-- Tabla de proveedores de productos
CREATE TABLE product_suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  supplier_id INT,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

-- Tabla de reseñas
CREATE TABLE reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  customer_id INT,
  rating INT CHECK(rating BETWEEN 1 AND 5),
  comment TEXT,
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Tabla de descuentos
CREATE TABLE discounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(50),
  description TEXT,
  discount_amount DECIMAL(10, 2),
  start_date TIMESTAMP,
  end_date TIMESTAMP
);

-- Tabla de descuentos aplicados a pedidos
CREATE TABLE order_discounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  discount_id INT,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (discount_id) REFERENCES discounts(id)
);

-- Tabla de registros de inventario
CREATE TABLE inventory_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  change_amount INT,
  reason VARCHAR(255),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
