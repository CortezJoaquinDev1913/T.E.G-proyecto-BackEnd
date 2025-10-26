INSERT INTO app_user (email, password_hash, username) VALUES ('dev@local.test', 'devpass', 'devuser');
INSERT INTO player (user_id, nickname, color, is_bot) VALUES (1, 'Joaquin', 'blue', false);

-- continents + countries
INSERT INTO continent (name, bonus_armies) VALUES ('South America', 2);
INSERT INTO country_template (name, continent_id) VALUES ('Argentina', 1);
INSERT INTO country_template (name, continent_id) VALUES ('Brazil', 1);
INSERT INTO country_template (name, continent_id) VALUES ('Chile', 1);

-- adjacency (ensure id ordering: a < b)
INSERT INTO territory_adjacency (territory_a, territory_b) VALUES (1,2);
INSERT INTO territory_adjacency (territory_a, territory_b) VALUES (1,3);
INSERT INTO territory_adjacency (territory_a, territory_b) VALUES (2,3);

-- create a match and assign initial territory states for demo
INSERT INTO match_game (name, created_by_player_id) VALUES ('Demo Match', 1);
INSERT INTO player_match (match_id, player_id, seat_order, reinforcements) VALUES (1, 1, 1, 5);

INSERT INTO territory_state (match_id, country_template_id, armies, owner_player_match_id)
VALUES (1, 1, 3, 1);
INSERT INTO territory_state (match_id, country_template_id, armies, owner_player_match_id)
VALUES (1, 2, 2, 1);
INSERT INTO territory_state (match_id, country_template_id, armies, owner_player_match_id)
VALUES (1, 3, 1, 1);