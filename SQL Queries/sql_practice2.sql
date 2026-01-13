CREATE TABLE museums (
    museum_id INTEGER PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    address     VARCHAR(255),
    city        VARCHAR(100),
    state       VARCHAR(100),
    postal      VARCHAR(20),
    country     VARCHAR(100),
    phone       VARCHAR(30),
    url         TEXT
);

select * from museums;
drop table if exists image_link;
CREATE TABLE image_link (
    work_id               INTEGER ,
    url                   TEXT ,
    thumbnail_small_url   TEXT,
    thumbnail_large_url   TEXT
);
select * from image_link;


drop table if exists canvas_size;
CREATE TABLE canvas_size (
    size_id INTEGER ,
    width   INTEGER ,
    height  INTEGER,
    label   VARCHAR(50) 
);
select * from canvas_size;


drop table if exists artist;
CREATE TABLE artist (
    artist_id     INTEGER PRIMARY KEY,
    full_name     VARCHAR(255) NOT NULL,
    first_name    VARCHAR(100),
    middle_names  VARCHAR(100),
    last_name     VARCHAR(100),
    nationality   VARCHAR(100),
    style         VARCHAR(100),
    birth         SMALLINT,
    death         SMALLINT
);
select * from artist;


drop table if exists museum_hours;
CREATE TABLE museum_hours (
    museum_id INTEGER NOT NULL,
    day        VARCHAR(10) NOT NULL,
    open_time  VARCHAR(10) NOT NULL,
    close_time VARCHAR(10) NOT NULL
);
select * from museum_hours;


drop table if exists product_size;
CREATE TABLE product_size (
    work_id        INTEGER,
    size_id        varchar(20),
    sale_price     INTEGER,
    regular_price  INTEGER
);
select * from product_size;


drop table if exists subjects;
CREATE TABLE subjects (
    work_id INTEGER NOT NULL,
    subject VARCHAR(100) NOT NULL
);
select * from subjects;


drop table if exists works;
CREATE TABLE works (
    work_id    INTEGER,
    name       VARCHAR(1000) ,
    artist_id  INTEGER ,
    style  text,
    museum_id  INTEGER
);
select * from works;








