# Create new Database called ScoreVaultDB if not created already
CREATE DATABASE IF NOT EXISTS `ScoreVaultDB`;

grant all privileges on ScoreVaultDB.* to 'webapp'@'%';
flush privileges;

# Selects DB to be used
USE `ScoreVaultDB`;

# Make Table for Stadium
CREATE TABLE IF NOT EXISTS Stadium
(
    stadium_name  varchar(50) PRIMARY KEY,
    city          varchar(50)  NOT NULL,
    country       varchar(50)  NOT NULL,
    streetAddress varchar(100) NOT NULL
);

# Make Table for Club
CREATE TABLE IF NOT EXISTS Club
(
    team_name varchar(100) PRIMARY KEY,
    stadium   varchar(50) NOT NULL,
    country   varchar(50) NOT NULL,
    league    varchar(50) NOT NULL,
    CONSTRAINT FOREIGN KEY (stadium) references Stadium (stadium_name)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for International Team
CREATE TABLE IF NOT EXISTS InternationalTeam
(
    country  varchar(50) PRIMARY KEY,
    nickname varchar(50) UNIQUE
);

# Make Table for Players
CREATE TABLE IF NOT EXISTS Players
(
    player_id          int AUTO_INCREMENT PRIMARY KEY,
    age                int         NOT NULL,
    first_name         varchar(50) NOT NULL,
    last_name          varchar(50) NOT NULL,
    position           varchar(50) NOT NULL,
    goals              int         NOT NULL,
    assists            int         NOT NULL,
    jersey_number      int         NOT NULL,
    nationality        varchar(50) NOT NULL,
    contract_end_date  DATE,
    team_name          varchar(100),
    international_team varchar(50),
    CONSTRAINT FOREIGN KEY (team_name) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade,
    CONSTRAINT FOREIGN KEY (international_team) REFERENCES InternationalTeam (country)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for Game
CREATE TABLE IF NOT EXISTS Game
(
    game_id   int AUTO_INCREMENT PRIMARY KEY,
    home_score int,
    away_score int,
    home_team varchar(100) NOT NULL,
    away_team varchar(100) NOT NULL,
    game_date DATE         NOT NULL,
    venue     varchar(50)  NOT NULL,
    CONSTRAINT FOREIGN KEY (home_team) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade,
    CONSTRAINT FOREIGN KEY (away_team) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade,
    CONSTRAINT FOREIGN KEY (venue) REFERENCES Stadium (stadium_name)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for Social Media
CREATE TABLE IF NOT EXISTS SocialMedia
(
    team_name varchar(50) PRIMARY KEY,
    Twitter   varchar(50),
    Instagram varchar(50),
    TikTok    varchar(50),
    Facebook  varchar(50),
    CONSTRAINT FOREIGN KEY (team_name) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for News
CREATE TABLE IF NOT EXISTS News
(
    news_id             int AUTO_INCREMENT PRIMARY KEY,
    outlet              varchar(50),
    author_first        varchar(50)   NOT NULL,
    author_last         varchar(50)   NOT NULL,
    title               varchar(100)  NOT NULL,
    article_description varchar(1000) NOT NULL,
    news_date           DATETIME      NOT NULL
);

# Create Join Table for Team News
CREATE TABLE IF NOT EXISTS Team_News
(
    team_name varchar(100),
    news_id   int,
    PRIMARY KEY (team_name, news_id),
    CONSTRAINT FOREIGN KEY (team_name) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade,
    CONSTRAINT FOREIGN KEY (news_id) REFERENCES News (news_id)
        ON UPDATE cascade
        ON DELETE cascade
);

# Create Join Table for Team News
CREATE TABLE IF NOT EXISTS Player_News
(
    player_id int,
    news_id   int,
    PRIMARY KEY (player_id, news_id),
    CONSTRAINT FOREIGN KEY (player_id) REFERENCES Players (player_id)
        ON UPDATE cascade
        ON DELETE cascade,
    CONSTRAINT FOREIGN KEY (news_id) REFERENCES News (news_id)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for Agent
CREATE TABLE IF NOT EXISTS Agent
(
    first_name varchar(50) NOT NULL,
    last_name  varchar(50) NOT NULL,
    email      varchar(50) NOT NULL,
    phone      varchar(15) NOT NULL,
    company    varchar(50),
    player_id  int,
    PRIMARY KEY (player_id, first_name, last_name),
    CONSTRAINT FOREIGN KEY (player_id) REFERENCES Players (player_id)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for Manager
CREATE TABLE IF NOT EXISTS Manager
(
    first_name        varchar(50)  NOT NULL,
    last_name         varchar(50)  NOT NULL,
    contract_end_date DATE         NOT NULL,
    age               int          NOT NULL,
    salary            int          NOT NULL,
    team_name         varchar(100) NOT NULL,
    PRIMARY KEY (team_name, first_name, last_name),
    CONSTRAINT FOREIGN KEY (team_name) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade
);

# Make Table for CEO
CREATE TABLE IF NOT EXISTS CEO
(
    first_name varchar(50)  NOT NULL,
    last_name  varchar(50)  NOT NULL,
    age        int          NOT NULL,
    phone      varchar(15)  NOT NULL,
    email      varchar(50)  NOT NULL,
    team_name  varchar(100) NOT NULL,
    PRIMARY KEY (team_name, first_name, last_name),
    CONSTRAINT FOREIGN KEY (team_name) REFERENCES Club (team_name)
        ON UPDATE cascade
        ON DELETE cascade
);

INSERT INTO Stadium(stadium_name,city,country,streetAddress)
    VALUES ('Heller, Daugherty and Beahan','Liverpool','United Kingdom','87 Division Point');
INSERT INTO Stadium(stadium_name,city,country,streetAddress)
    VALUES ('Brakus-Kub','Milot','Haiti','1 Magdeline Terrace');
INSERT INTO Stadium(stadium_name,city,country,streetAddress)
    VALUES ('Kuhn-Dickinson','Nar''yan-Mar','Russia','5424 Kenwood Parkway');

INSERT INTO Club(team_name,stadium,country,league)
    VALUES ('Toughjoyfax','Heller, Daugherty and Beahan','United Kingdom','Bayer Group');
INSERT INTO Club(team_name,stadium,country,league)
    VALUES ('Mat Lam Tam','Kuhn-Dickinson','Russia','O''Reilly Inc');
INSERT INTO Club(team_name,stadium,country,league)
    VALUES ('ComerBear','Brakus-Kub','Haiti','Donnelly-Lemke');

INSERT INTO InternationalTeam(country,nickname)
    VALUES ('United Kingdom','Deers');
INSERT INTO InternationalTeam(country,nickname)
    VALUES ('Haiti','Eagles');
INSERT INTO InternationalTeam(country,nickname)
    VALUES ('Russia','Bustards');

INSERT INTO Players(
                    player_id,age,first_name,last_name,position,goals,assists,jersey_number,nationality,
                    contract_end_date,team_name,international_team)
    VALUES (1,44,'Neel','Druitt','RW',20,20,23,'Brazil','2023-03-22','Toughjoyfax','Russia');
INSERT INTO Players(player_id,age,first_name,last_name,position,goals,assists,jersey_number,nationality,
                    contract_end_date,team_name,international_team)
    VALUES (2,18,'Jasmina','Fairnington','LW',30,0,82,'Indonesia','2022-07-20',NULL,'Haiti');
INSERT INTO Players(player_id,age,first_name,last_name,position,goals,assists,jersey_number,nationality,
                    contract_end_date,team_name,international_team)
    VALUES (3,41,'Yetta','Cesco','CM',55,44,79,'Greece','2022-05-07','ComerBear',NULL);

INSERT INTO Game(game_id,home_score,away_score,home_team,away_team,game_date,venue)
    VALUES (1,6,0,'Toughjoyfax','Mat Lam Tam','2023-01-22','Heller, Daugherty and Beahan');
INSERT INTO Game(game_id,home_score,away_score,home_team,away_team,game_date,venue)
    VALUES (2,NULL,NULL,'Toughjoyfax','Comerbear','2022-11-11','Heller, Daugherty and Beahan');
INSERT INTO Game(game_id,home_score,away_score,home_team,away_team,game_date,venue)
    VALUES (3,10,9,'Mat Lam Tam','Toughjoyfax','2023-03-08','Kuhn-Dickinson');

INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook)
    VALUES ('Toughjoyfax','gnockolds0','eoliveto0','mmaccathay0','jannwyl0');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook)
    VALUES ('Mat Lam Tam','ihinge1','lmerring1','srigeby1','tregus1');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook)
    VALUES ('ComerBear','tmoughton2','lfindon2','mginnaly2','efirman2');

INSERT INTO News(news_id,outlet,author_first,author_last,title,article_description,news_date)
    VALUES (1,'Ledner-Zboncak','Igor','Longman','Monty Python Live at the Hollywood Bowl',
        'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','2023-03-12 14:41:52');
INSERT INTO News(news_id,outlet,author_first,author_last,title,article_description,news_date)
    VALUES (2,NULL,'Niel','Caskie','Thunderpants',
        'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',
        '2022-05-26 23:07:06');
INSERT INTO News(news_id,outlet,author_first,author_last,title,article_description,news_date)
    VALUES (3,'Simonis-Wilkinson','Helena','Olin','Saturn 3',
        'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.',
        '2022-11-11 02:45:08');

INSERT INTO Team_News(team_name,news_id) VALUES ('Toughjoyfax',3);
INSERT INTO Team_News(team_name,news_id) VALUES ('Mat Lam Tam',2);
INSERT INTO Team_News(team_name,news_id) VALUES ('ComerBear',1);

INSERT INTO Player_News(player_id,news_id) VALUES (1,3);
INSERT INTO Player_News(player_id,news_id) VALUES (3,1);
INSERT INTO Player_News(player_id,news_id) VALUES (2,2);

INSERT INTO Agent(first_name,last_name,email,phone,company,player_id)
    VALUES ('Erich','Basler','ebasler0@globo.com','831-703-9131','Mayer Inc',3);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id)
    VALUES ('Nike','Streetley','nstreetley1@shareasale.com','901-679-2049','Stiedemann, Wisoky and Quitzon',2);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id)
    VALUES ('Robbie','McIlraith','rmcilraith2@whitehouse.gov','973-966-7592','Mosciski-McClure',1);

INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name)
    VALUES ('Flynn','Kretchmer','2023-03-09','37','514846','Toughjoyfax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name)
    VALUES ('Maurita','Crock','2023-06-23','32','297829','Mat Lam Tam');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name)
    VALUES ('Bernette','Herculson','2023-03-16','80','97575','ComerBear');

INSERT INTO CEO(first_name,last_name,age,phone,email,team_name)
    VALUES ('Kittie','Mellmoth',95,'676-139-1171','kmellmoth0@plala.or.jp','Toughjoyfax');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name)
    VALUES ('Roze','Beeching',71,'732-325-7932','rbeeching1@oakley.com','Mat Lam Tam');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name)
    VALUES ('Austina','Barthram',53,'876-453-4793','abarthram2@jigsy.com','ComerBear');