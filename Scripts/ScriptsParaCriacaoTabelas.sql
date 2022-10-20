CREATE TABLE `tb_olist_customers_dataset` (
  `customer_id` varchar(100) DEFAULT NULL,
  `customer_unique_id` varchar(100) DEFAULT NULL,
  `customer_zip_code_prefix` varchar(6) DEFAULT NULL,
  `customer_city` varchar(45) DEFAULT NULL,
  `customer_state` char(2) DEFAULT NULL,
  KEY `fk_tb_olist_customers_dataset_tb_olist_orders_dataset` (`customer_id`),
  KEY `fk_tb_olist_customers_dataset_tb_olist_geolocation_dataset` (`customer_zip_code_prefix`),
  CONSTRAINT `fk_tb_olist_customers_dataset_tb_olist_geolocation_dataset` FOREIGN KEY (`customer_zip_code_prefix`) REFERENCES `tb_olist_geolocation_dataset` (`geolocation_zip_code_prefix`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tb_olist_customers_dataset_tb_olist_orders_dataset` FOREIGN KEY (`customer_id`) REFERENCES `tb_olist_orders_dataset` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_geolocation_dataset` (
  `geolocation_zip_code_prefix` varchar(6) DEFAULT NULL,
  `geolocation_lat` varchar(45) DEFAULT NULL,
  `geolocation_lng` varchar(45) DEFAULT NULL,
  `geolocation_city` varchar(45) DEFAULT NULL,
  `geolocation_state` char(2) DEFAULT NULL,
  UNIQUE KEY `unq_tb_olist_geolocation_dataset_geolocation_zip_code_prefix` (`geolocation_zip_code_prefix`),
  CONSTRAINT `fk_tb_olist_geolocation_dataset_tb_olist_sellers_dataset` FOREIGN KEY (`geolocation_zip_code_prefix`) REFERENCES `tb_olist_sellers_dataset` (`seller_zip_code_prefix`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_order_items_dataset` (
  `order_id` varchar(100) DEFAULT NULL,
  `order_item_id` char(1) DEFAULT NULL,
  `product_id` varchar(100) DEFAULT NULL,
  `seller_id` varchar(100) DEFAULT NULL,
  `shipping_limit_date` varchar(20) DEFAULT NULL,
  `price` varchar(10) DEFAULT NULL,
  `freight_value` varchar(10) DEFAULT NULL,
  UNIQUE KEY `unq_tb_olist_order_items_dataset_product_id` (`product_id`),
  UNIQUE KEY `unq_tb_olist_order_items_dataset_seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_order_payments_dataset` (
  `order_id` varchar(100) DEFAULT NULL,
  `payment_sequential` varchar(2) DEFAULT NULL,
  `payment_type` varchar(15) DEFAULT NULL,
  `payment_installments` varchar(2) DEFAULT NULL,
  `payment_value` varchar(10) DEFAULT NULL,
  KEY `fk_tb_olist_order_payments_dataset_tb_olist_orders_dataset` (`order_id`),
  CONSTRAINT `fk_tb_olist_order_payments_dataset_tb_olist_orders_dataset` FOREIGN KEY (`order_id`) REFERENCES `tb_olist_orders_dataset` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_order_reviews_dataset` (
  `review_id` varchar(100) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `review_score` varchar(2) DEFAULT NULL,
  `review_comment_title` varchar(50) DEFAULT NULL,
  `review_comment_message` varchar(100) DEFAULT NULL,
  `review_creation_date` varchar(20) DEFAULT NULL,
  `review_answer_timestamp` varchar(20) DEFAULT NULL,
  KEY `fk_tb_olist_order_reviews_dataset_tb_olist_orders_dataset` (`order_id`),
  CONSTRAINT `fk_tb_olist_order_reviews_dataset_tb_olist_orders_dataset` FOREIGN KEY (`order_id`) REFERENCES `tb_olist_orders_dataset` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_orders_dataset` (
  `order_id` varchar(100) DEFAULT NULL,
  `customer_id` varchar(100) DEFAULT NULL,
  `order_status` varchar(15) DEFAULT NULL,
  `order_purchase_timestamp` varchar(20) DEFAULT NULL,
  `order_approved_at` varchar(20) DEFAULT NULL,
  `order_delivered_carrier_date` varchar(20) DEFAULT NULL,
  `order_delivered_customer_date` varchar(20) DEFAULT NULL,
  `order_estimated_delivery_date` varchar(20) DEFAULT NULL,
  UNIQUE KEY `unq_tb_olist_orders_dataset_order_id` (`order_id`),
  UNIQUE KEY `unq_tb_olist_orders_dataset_customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_products_dataset` (
  `product_id` varchar(100) DEFAULT NULL,
  `product_category_name` varchar(50) DEFAULT NULL,
  `product_name_lenght` varchar(2) DEFAULT NULL,
  `product_description_lenght` varchar(5) DEFAULT NULL,
  `product_photos_qty` varchar(2) DEFAULT NULL,
  `product_weight_g` varchar(5) DEFAULT NULL,
  `product_lenght_cm` varchar(3) DEFAULT NULL,
  `product_height_cm` varchar(3) DEFAULT NULL,
  `product_width_cm` varchar(3) DEFAULT NULL,
  UNIQUE KEY `unq_tb_olist_products_dataset_product_category_name` (`product_category_name`),
  KEY `fk_tb_olist_products_dataset_tb_olist_order_items_dataset` (`product_id`),
  CONSTRAINT `fk_tb_olist_products_dataset_tb_olist_order_items_dataset` FOREIGN KEY (`product_id`) REFERENCES `tb_olist_order_items_dataset` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_olist_sellers_dataset` (
  `seller_id` varchar(100) DEFAULT NULL,
  `seller_zip_code_prefix` varchar(5) DEFAULT NULL,
  `selller_city` varchar(60) DEFAULT NULL,
  `seller_state` varchar(2) DEFAULT NULL,
  UNIQUE KEY `unq_tb_olist_sellers_dataset_seller_zip_code_prefix` (`seller_zip_code_prefix`),
  KEY `fk_tb_olist_sellers_dataset_tb_olist_order_items_dataset` (`seller_id`),
  CONSTRAINT `fk_tb_olist_sellers_dataset_tb_olist_order_items_dataset` FOREIGN KEY (`seller_id`) REFERENCES `tb_olist_order_items_dataset` (`seller_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_product_category_name_translation` (
  `product_category_name` varchar(50) DEFAULT NULL,
  `product_category_name_english` varchar(50) DEFAULT NULL,
  KEY `fk_tb_product_category_name` (`product_category_name`),
  CONSTRAINT `fk_tb_product_category_name` FOREIGN KEY (`product_category_name`) REFERENCES `tb_olist_products_dataset` (`product_category_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;