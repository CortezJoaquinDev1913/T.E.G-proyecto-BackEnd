-- schema.sql (minimal)
CREATE TYPE match_state AS ENUM ('WAITING', 'STARTED', 'IN_PROGRESS', 'FINISHED', 'CANCELLED');
CREATE TYPE turn_phase AS ENUM ('REINFORCEMENT', 'ATTACK', 'FORTIFY', 'END');

CREATE TABLE app_user (
                          id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          email VARCHAR(255) UNIQUE NOT NULL,
                          password_hash VARCHAR(255) NOT NULL,
                          username VARCHAR(100),
                          created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE player (
                        id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        user_id BIGINT REFERENCES app_user(id) ON DELETE SET NULL,
                        nickname VARCHAR(100) NOT NULL,
                        color VARCHAR(30),
                        is_bot BOOLEAN NOT NULL DEFAULT FALSE,
                        created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
                        UNIQUE (user_id, nickname)
);

CREATE TABLE match_game (
                            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                            name VARCHAR(150),
                            created_by_player_id BIGINT REFERENCES player(id) ON DELETE SET NULL,
                            max_players INT NOT NULL DEFAULT 6,
                            state match_state NOT NULL DEFAULT 'WAITING',
                            created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE player_match (
                              id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                              match_id BIGINT NOT NULL REFERENCES match_game(id) ON DELETE CASCADE,
                              player_id BIGINT NOT NULL REFERENCES player(id) ON DELETE CASCADE,
                              seat_order INT,
                              reinforcements INT DEFAULT 0,
                              eliminated BOOLEAN DEFAULT FALSE,
                              UNIQUE (match_id, player_id)
);

CREATE TABLE continent (
                           id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           bonus_armies INT NOT NULL DEFAULT 0
);

CREATE TABLE country_template (
                                  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                                  name VARCHAR(250) NOT NULL UNIQUE,
                                  continent_id BIGINT REFERENCES continent(id) ON DELETE SET NULL
);

CREATE TABLE territory_adjacency (
                                     territory_a BIGINT NOT NULL REFERENCES country_template(id) ON DELETE CASCADE,
                                     territory_b BIGINT NOT NULL REFERENCES country_template(id) ON DELETE CASCADE,
                                     PRIMARY KEY (territory_a, territory_b),
                                     CHECK (territory_a <> territory_b),
                                     CHECK (territory_a < territory_b)
);

CREATE TABLE territory_state (
                                 id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                                 match_id BIGINT NOT NULL REFERENCES match_game(id) ON DELETE CASCADE,
                                 country_template_id BIGINT NOT NULL REFERENCES country_template(id) ON DELETE CASCADE,
                                 armies INT NOT NULL DEFAULT 0,
                                 owner_player_match_id BIGINT REFERENCES player_match(id) ON DELETE SET NULL,
                                 UNIQUE (match_id, country_template_id)
);

CREATE TABLE game_event (
                            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                            match_id BIGINT NOT NULL REFERENCES match_game(id) ON DELETE CASCADE,
                            event_type VARCHAR(80),
                            description TEXT,
                            created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
)