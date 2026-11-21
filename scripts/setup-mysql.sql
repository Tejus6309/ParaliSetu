CREATE DATABASE IF NOT EXISTS paralisetu CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'paralisetu'@'localhost' IDENTIFIED BY 'local-demo-password';
GRANT ALL PRIVILEGES ON paralisetu.* TO 'paralisetu'@'localhost';
