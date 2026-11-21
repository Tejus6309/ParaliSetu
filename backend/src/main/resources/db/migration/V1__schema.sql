CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(160) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(16) NOT NULL CHECK (role IN ('FARMER','BUYER','LOGISTICS','ADMIN')),
  password_hash VARCHAR(100) NOT NULL
);

CREATE TABLE listings (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  farmer_id BIGINT NOT NULL,
  crop VARCHAR(40) NOT NULL,
  district VARCHAR(80) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  available_kg BIGINT NOT NULL CHECK (available_kg >= 0),
  price_per_kg DECIMAL(10,2) NOT NULL CHECK (price_per_kg > 0),
  status VARCHAR(16) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','PAUSED','REMOVED','DELETED')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX marketplace_idx (status, crop, district),
  FOREIGN KEY (farmer_id) REFERENCES users(id)
);

CREATE TABLE orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  listing_id BIGINT NOT NULL,
  farmer_id BIGINT NOT NULL,
  buyer_id BIGINT NOT NULL,
  carrier_id BIGINT,
  quantity_kg INT NOT NULL CHECK (quantity_kg > 0),
  price_per_kg DECIMAL(10,2) NOT NULL,
  crop VARCHAR(40) NOT NULL,
  district VARCHAR(80) NOT NULL,
  status VARCHAR(16) NOT NULL DEFAULT 'REQUESTED'
    CHECK (status IN ('REQUESTED','ACCEPTED','REJECTED','CANCELLED','ASSIGNED','PICKED_UP','DELIVERED')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX order_listing_status_idx (listing_id, status),
  FOREIGN KEY (listing_id) REFERENCES listings(id),
  FOREIGN KEY (farmer_id) REFERENCES users(id),
  FOREIGN KEY (buyer_id) REFERENCES users(id),
  FOREIGN KEY (carrier_id) REFERENCES users(id)
);
