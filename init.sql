CREATE SCHEMA IF NOT EXISTS trebledb;

SET SCHEMA 'trebledb';


CREATE TABLE song (
    id              SERIAL                                 NOT NULL,
    artist_id       INTEGER                                NOT NULL REFERENCES artist(id),
    album_id        INTEGER                                NOT NULL REFERENCES album(id),
    name            TEXT                                   NOT NULL,
    genre           TEXT                                   NOT NULL,
    created_at      TIMESTAMP WITHOUT TIMEZONE             NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITHOUT TIMEZONE             NOT NULL DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE video (
    id              SERIAL                                  NOT NULL,
    song_id         INTEGER                                 NOT NULL REFERENCES song(id),
    content_url     TEXT                                    NOT NULL, -- link to s3?
    created_at      TIMESTAMP WITHOUT TIMEZONE              NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITHOUT TIMEZONE              NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- snippet is a 20s clip that is attached to a video
CREATE TABLE snippet (
    id                      SERIAL                                  NOT NULL,
    user_id                 INTEGER                                 NOT NULL,             
    length_ms               INTEGER                                 NOT NULL,
    starting_point_ms       INTEGER                                 NOT NULL,
    is_floating             BOOLEAN                                 NOT NULL,
    location_lat            point                                   NOT NULL, --find a better data type
    location_lng            point                                   NOT NULL, --find a better data type
    content_url             TEXT                                    NOT NULL,
    thumbnail_url           TEXT                                    NOT NULL, 
    created_at              TIMESTAMP WITHOUT TIMEZONE              NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP WITHOUT TIMEZONE              NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE video_placement (
    id                  SERIAL                                      NOT NULL,
    video_id            INTEGER                                     NOT NULL REFERENCES video(id),
    snippet_id          INTEGER                                     NOT NULL REFERENCES snippet(id),
    created_at          TIMESTAMP WITHOUT TIMEZONE                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP WITHOUT TIMEZONE                  NOT NULL DEFAULT CURRENT_TIMESTAMP
);
