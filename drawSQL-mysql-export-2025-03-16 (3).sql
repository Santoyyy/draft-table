CREATE TABLE `supplier`(
    `supplier_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `supplier_name` VARCHAR(255) NOT NULL,
    `contact_name` VARCHAR(255) NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20) ,
    `city` VARCHAR(100) NULL,
    `country` VARCHAR(100) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    `supplier` ADD UNIQUE `supplier_email_unique`(`email`);
CREATE TABLE `product`(
    `product_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_name` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `quantity_in_stock` BIGINT NOT NULL,
    `supplier_id` BIGINT NULL COMMENT 'FK',
    `category` VARCHAR(100) NULL,
    `brand` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `customer`(
    `customer_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `city` VARCHAR(100) NULL,
    `country` VARCHAR(100) NULL
);
ALTER TABLE
    `customer` ADD UNIQUE `customer_email_unique`(`email`);
ALTER TABLE
    `customer` ADD UNIQUE `customer_phone_unique`(`phone`);
CREATE TABLE `Order`(
    `order_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_id` BIGINT NULL COMMENT 'FK',
    `order_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `total_amount` DECIMAL(10, 2) NOT NULL,
    `tracking_number` VARCHAR(50) NULL
);
ALTER TABLE
    `Order` ADD UNIQUE `order_tracking_number_unique`(`tracking_number`);
CREATE TABLE `order_detail`(
    `order_detail_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT NULL COMMENT 'FK',
    `product_id` BIGINT NULL COMMENT 'FK',
    `price` DECIMAL(10, 2) NOT NULL,
    `subtotal` DECIMAL(10, 2) NOT NULL,
    `quantity` BIGINT NULL COMMENT 'GENERATED ALWAYS AS (quantity * price) STORED,'
);
ALTER TABLE
    `order_detail` ADD CONSTRAINT `order_detail_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product`(`product_id`);
ALTER TABLE
    `Order` ADD CONSTRAINT `order_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `customer`(`customer_id`);
ALTER TABLE
    `product` ADD CONSTRAINT `product_supplier_id_foreign` FOREIGN KEY(`supplier_id`) REFERENCES `supplier`(`supplier_id`);
ALTER TABLE
    `order_detail` ADD CONSTRAINT `order_detail_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`);
ALTER TABLE
    `order_detail` ADD CONSTRAINT `order_detail_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product`(`product_id`);
ALTER TABLE
    `product` ADD CONSTRAINT `product_supplier_id_foreign` FOREIGN KEY(`supplier_id`) REFERENCES `supplier`(`supplier_id`);
ALTER TABLE
    `Order` ADD CONSTRAINT `order_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `customer`(`customer_id`);
ALTER TABLE
    `order_detail` ADD CONSTRAINT `order_detail_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`);