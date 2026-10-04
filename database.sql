CREATE TABLE IF NOT EXISTS path_finder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    target_coords VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO path_finder (player_name, target_coords) VALUES ('default', '0.0, 0.0, 0.0');