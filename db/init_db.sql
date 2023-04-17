# Create new Database called ScoreVaultDB if not created already
CREATE DATABASE IF NOT EXISTS ScoreVaultDB;

grant all privileges on ScoreVaultDB.* to 'webapp'@'%';
flush privileges;

# Selects DB to be used
USE ScoreVaultDB;

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

# Init Data
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

INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kuhn and Sons','Sasolburg','South Africa','0 Melrose Park');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('D''Amore LLC','Lido','Indonesia','45 Magdeline Point');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Schaden-King','Solok','Indonesia','42 Beilfuss Center');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Rau-Rowe','Ta`ū','American Samoa','914 Kedzie Circle');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Bergstrom, Carter and Oberbrunner','Colorado Springs','United States','5588 Hoard Point');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Bins-Bosco','Bohus','Sweden','38 Corscot Lane');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kuphal-Treutel','Dajin','China','1 Cody Street');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Daugherty-Torp','Perugia','Italy','60660 Morrow Plaza');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Collins-Gorczany','Kyzyl-Kyya','Kyrgyzstan','34194 Bellgrove Center');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Baumbach, Mayert and Leannon','Sandefjord','Norway','6 Fuller Alley');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Hills-Kuhn','Meikeng','China','6050 Macpherson Crossing');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Harber-Brekke','Balong Wetan','Indonesia','43502 Chive Junction');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Brekke-McKenzie','Bulu','Philippines','49 Warrior Point');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kris, Robel and Nicolas','Rejowinangun','Indonesia','979 Kim Plaza');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Lebsack, Hoppe and Cormier','Kayasula','Russia','807 Menomonie Terrace');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Christiansen, Turcotte and Romaguera','San Martín','Colombia','71373 Wayridge Lane');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Zboncak-Oberbrunner','Birni N Konni','Niger','52019 Browning Trail');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Grant-Corwin','Santa Monica','Philippines','7467 Stang Court');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Konopelski, Boyer and Kemmer','Kurów','Poland','4 Dawn Drive');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Towne-Douglas','Liangshan','China','7845 Florence Court');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Homenick and Sons','Hajeom','South Korea','3590 Thackeray Way');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Boyle Group','Zhongba','China','2 7th Point');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Grady, Kozey and Rath','Antanhol','Portugal','9 Sullivan Hill');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Shanahan LLC','Cachón','Dominican Republic','234 Rockefeller Alley');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Casper, Kautzer and Padberg','Sekongkang Bawah','Indonesia','5 Goodland Avenue');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Balistreri, Hermann and Rodriguez','Gnieżdżewo','Poland','67 Wayridge Circle');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Howell, Turner and Parker','Xiangyanglu','China','83293 Arizona Hill');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Hansen, Wintheiser and Hirthe','Genova','Italy','7168 Dennis Park');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Boyle-Medhurst','Poříčany','Czech Republic','151 Warbler Parkway');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kreiger, Considine and Weissnat','Yukuriawat','China','6132 Anhalt Junction');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Emmerich-Schinner','Dushanbe','Tajikistan','113 Prairieview Avenue');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Botsford, Cummerata and Waelchi','Kholmsk','Russia','7 Towne Terrace');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Purdy, Toy and Rath','Kalenderovci Donji','Bosnia and Herzegovina','89 Commercial Park');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Bradtke and Sons','Cikulahan','Indonesia','12 West Drive');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Nader-Corwin','Da’an','China','86 Oak Park');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Hyatt, Schaefer and Fisher','Heret','Indonesia','57 Saint Paul Trail');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kub and Sons','Solna','Sweden','72 Towne Lane');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Kunze, Kling and Welch','Anuchino','Russia','784 Utah Drive');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Mertz Group','Rijeka','Croatia','7373 Portage Way');
INSERT INTO Stadium(stadium_name,city,country,streetAddress) VALUES ('Walsh and Sons','Shuinan','China','09 Gulseth Trail');

INSERT INTO Club(team_name,stadium,country,league) VALUES ('Alpha','Hills-Kuhn','Pakistan','Wisozk Group');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Alphazap','Nader-Corwin','Indonesia','Aufderhar-Mante');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Asoka','Collins-Gorczany','China','Schoen-Hansen');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Biodex','Walsh and Sons','Russia','Kling-Wolf');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Bluehold','Schaden-King','South Korea','Barton LLC');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Daltfresh','Kub and Sons','Philippines','Lehner-Mills');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Domainer','Botsford, Cummerata and Waelchi','China','Stark-Conroy');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Duo Lux','D''Amore LLC','Canada','Jacobi Inc');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Flexidy','Boyle-Medhurst','Indonesia','Bahringer LLC');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Flowdesk','Mertz Group','Russia','Batz LLC');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('It','Grant-Corwin','Sri Lanka','Kassulke and Sons');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Keylex','Lebsack, Hoppe and Cormier','Finland','VonRueden, Collins and Russel');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Latlux','Kuphal-Treutel','Russia','Thompson, Vandervort and Wolf');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Letlux','Towne-Douglas','Russia','Hettinger-Schoen');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Lotlux','Harber-Brekke','China','Rippin, Stehr and Morissette');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Mar Lam Tam','Hansen, Wintheiser and Hirthe','Mexico','Fay-Parisian');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Namfix','Homenick and Sons','Indonesia','Collier-Emmerich');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Quo Lux','Daugherty-Torp','Russia','Dickens, Cole and Davis');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Redhold','Bergstrom, Carter and Oberbrunner','Philippines','Boehm, Connelly and Adams');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Regrant','Brekke-McKenzie','Norway','Watsica Inc');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Ronstring','Kuhn and Sons','China','Schultz LLC');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Solarbreeze','Baumbach, Mayert and Leannon','Bulgaria','Zboncak, Kshlerin and Pollich');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Stringtough','Shanahan LLC','France','Breitenberg Group');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Stronghold','Hyatt, Schaefer and Fisher','South Africa','McCullough-Mertz');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Subin','Rau-Rowe','China','Schuster, Tremblay and West');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Tampflex','Boyle Group','Poland','Jerde-Simonis');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Temp','Balistreri, Hermann and Rodriguez','United States','Fadel, Streich and Treutel');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Perm','Howell, Turner and Parker','Serbia','Koch, Zieme and Mohr');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Tempsoft','Christiansen, Turcotte and Romaguera','China','Maggio-Zboncak');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Softjoyfax','Bins-Bosco','Russia','Schaden-Volkman');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Treeflex','Emmerich-Schinner','Canada','McKenzie, Aufderhar and Stokes');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Tresom','Kunze, Kling and Welch','Thailand','Rogahn-Cormier');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Vagram','Casper, Kautzer and Padberg','Pakistan','Tillman-Fadel');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Seagram','Grady, Kozey and Rath','United States','Ryan-O''Connell');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Ventosanzap','Bradtke and Sons','Brazil','Hane Group');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Yellowhold','Kreiger, Considine and Weissnat','Thailand','Schmidt-Farrell');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Zathin','Kris, Robel and Nicolas','Lebanon','Shanahan and Sons');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Wathin','Purdy, Toy and Rath','Brazil','Yundt-Nolan');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Zontrax','Konopelski, Boyer and Kemmer','China','Hermiston LLC');
INSERT INTO Club(team_name,stadium,country,league) VALUES ('Zoolab','Zboncak-Oberbrunner','Armenia','Wintheiser LLC');

INSERT INTO InternationalTeam(country,nickname) VALUES ('China',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Poland',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Switzerland',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Iraq',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Indonesia',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Czech Republic','Western palm tanager (unidentified)');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Angola','Goose, cape barren');
INSERT INTO InternationalTeam(country,nickname) VALUES ('South Korea','Moorhen, purple');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Philippines','Robin, kalahari scrub');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Mongolia',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Bulgaria',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Brazil','Cormorant, great');
INSERT INTO InternationalTeam(country,nickname) VALUES ('North Korea','Eurasian badger');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Nigeria','Common wallaroo');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Ukraine',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('El Salvador',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Maldives','Bald eagle');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Cuba',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('United States',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Myanmar','Ringtail, common');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Sweden','Black-cheeked waxbill');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Norway','Glider, sugar');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Canada','Fox, cape');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Venezuela','Red-tailed phascogale');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Czech','Grenadier, purple');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Vietnam',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Guatemala',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Cameroon','Superb starling');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Cambodia','Fox, arctic');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Argentina','Fox');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Japan','Ant (unidentified)');
INSERT INTO InternationalTeam(country,nickname) VALUES ('India','White-throated robin');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Nepal',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Croatia','Monitor lizard (unidentified)');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Peru',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Afghanistan','Booby, blue-faced');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Thailand',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('South Sudan',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Sudan',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Chad','Goose');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Mexico',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Democratic Republic of the Congo','Wattled crane');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Portugal','Snake, green vine');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Spain','Northern elephant seal');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Guam',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Morocco','Oriental short-clawed otter');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Algeria',NULL);
INSERT INTO InternationalTeam(country,nickname) VALUES ('Iran','California sea lion');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Syria','Goat, mountain');
INSERT INTO InternationalTeam(country,nickname) VALUES ('Uganda','Bettong, brush-tailed');

INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Fred','Ruslen','CDM',51,30,13,'Colombia','2024-03-15','Regrant','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Constantia','Veal','LB',98,8,82,'China','2025-05-31','Temp','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Nataniel','Eggerton','ST',84,37,24,'Russia','2022-06-08','Namfix','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Sharon','Norvill','CB',83,12,88,'Venezuela','2022-09-30','Vagram','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Onfroi','Tallow','ST',16,55,67,'Greece','2023-05-27','Domainer','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Christie','Thomsen','CB',16,15,17,'China','2022-08-01','Tempsoft','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Josy','Maidlow','CB',1,60,62,'Colombia','2024-10-16','Vagram','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Towney','Barke','RB',57,43,5,'Sweden','2023-11-08','Letlux','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Grannie','Clausner','GK',4,49,98,'China','2024-08-26','Duo Lux','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Koo','Abbado','GK',9,85,62,'Indonesia','2023-04-07','Alpha','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Janka','Ratnage','ST',48,60,19,'Russia','2024-07-13','Mar Lam Tam','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Orville','Windus','GK',89,39,9,'Kuwait','2023-04-18','Namfix','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Gaylene','Wicks','GK',35,62,11,'Indonesia','2023-02-06','Regrant','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Herbert','Brouwer','CM',1,77,53,'Chile','2023-08-06','Zoolab','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Karil','Smitheram','GK',10,6,32,'Czech Republic','2024-12-08','Solarbreeze','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Husein','Rose','RM',11,66,41,'Mexico','2025-07-11','Namfix','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Felicdad','Ogers','CDM',24,85,7,'Czech Republic','2024-08-04','Stronghold','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Domingo','Rodder','ST',82,45,56,'Russia','2025-01-30','Alphazap','Norway');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Ogdan','Moiser','CB',45,61,54,'Philippines','2024-07-25','Keylex','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Torey','Isaaksohn','ST',21,9,35,'Peru','2024-04-10','Seagram','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (49,'Sophey','Liversley','CM',51,28,46,'China','2024-09-22','Asoka','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Shepard','Gronow','RM',4,83,8,'Iran','2023-05-31','Solarbreeze','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Cathe','Sandeman','CDM',46,91,87,'Brazil','2024-02-13','Domainer','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Rosalinda','Parfitt','LB',85,66,3,'Indonesia','2025-04-02','Lotlux','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Eadie','Ibbott','LB',10,96,80,'Mongolia','2022-08-04','Flexidy','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Rayner','Tegler','CB',4,89,10,'Poland','2025-05-25','Toughjoyfax','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Rudie','Shropshire','RB',30,22,88,'Norway','2025-04-15','Temp','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Anetta','Groucock','GK',37,98,49,'Russia','2024-02-02','Seagram','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Ashely','Height','RB',55,36,50,'North Korea','2022-07-05','Keylex','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Cullen','Leathers','CM',51,41,86,'United States','2024-09-07','Namfix','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Eugene','Softley','CB',91,22,3,'France','2023-06-02','Quo Lux','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Cymbre','Franzonetti','CB',53,7,62,'China','2024-01-31','Softjoyfax','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Berti','Strauss','ST',54,71,5,'Indonesia','2024-07-04','Vagram','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Mortie','Muckart','CDM',98,37,58,'China','2025-03-30','Zathin','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Brooks','Pellew','GK',69,94,75,'Croatia','2023-09-17','Vagram','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Penni','Fowells','LB',72,99,82,'Albania','2024-05-23','Vagram','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Ara','Huckell','LB',71,42,51,'Sweden','2024-03-22','Perm','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Brittany','Siddaley','GK',21,79,89,'Greece','2022-05-28','Stronghold','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Barn','Heaphy','RB',25,48,41,'Czech Republic','2023-11-11','Perm','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Cindie','Bissiker','LB',91,99,33,'France','2024-11-09','Seagram','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Nollie','McShane','RM',96,3,90,'Philippines','2022-04-18','It','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Frasquito','Swinglehurst','RM',4,40,44,'Russia','2022-12-08','Latlux','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Olivier','List','RB',2,35,98,'China','2025-01-04','Solarbreeze','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Curry','Levay','CM',12,11,83,'China','2024-08-27','Seagram','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Lemmy','Rosbottom','CB',60,86,95,'Portugal','2025-06-03','Flexidy','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Anatol','Dacks','LM',84,51,83,'Philippines','2022-12-15','Treeflex','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Laura','Standish','CM',89,88,100,'Poland','2024-05-23','Seagram','Angola');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Silvester','Devanney','RM',30,68,97,'Japan','2025-03-22','Flexidy','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (8,'Becca','Heselwood','GK',23,49,85,'Poland','2024-10-15','Zontrax','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Audrey','O''Nowlan','CB',49,90,38,'Czech Republic','2024-09-29','Flexidy','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Cybill','Teece','ST',43,28,34,'Uzbekistan','2022-05-12','Zontrax','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Stacie','Hurd','CM',58,65,6,'Austria','2024-08-04','Zontrax','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Cart','Ibbeson','GK',54,60,16,'China','2024-06-16','Solarbreeze','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Jenn','Vanyashin','CB',68,33,17,'Portugal','2022-10-01','Biodex','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Gun','Catcherside','LM',42,18,28,'Indonesia','2023-07-25','Quo Lux','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Dotti','Budnik','CDM',4,86,80,'Madagascar','2023-07-03','ComerBear','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Tilda','Feavearyear','CB',1,89,26,'Finland','2024-05-26','Vagram','Haiti');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Skipper','Bigley','RM',80,83,54,'Bulgaria','2023-03-21','Quo Lux','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Bram','Joel','ST',49,57,50,'China','2022-07-05','Quo Lux','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Brandea','Saladin','LM',38,99,97,'Czech Republic','2023-03-09','Letlux','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Katherine','Senett','GK',7,52,64,'Philippines','2024-12-01','Keylex','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Danette','Chaize','CM',90,26,96,'Indonesia','2023-10-28','Alpha','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Kandace','Duchart','LM',36,75,38,'Georgia','2023-03-19','Toughjoyfax','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Jarret','Dummett','CDM',86,87,24,'Indonesia','2022-10-31','Seagram','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Anthe','Valdes','CM',100,70,43,'Indonesia','2023-04-28','Lotlux','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Rossie','Jimson','ST',39,63,80,'Philippines','2023-10-19','Softjoyfax','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Mikey','Withrop','LB',59,61,99,'China','2023-10-24','Zoolab','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Irwin','Radborn','LB',96,47,23,'China','2024-07-08','Zathin','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Sigfried','Whittenbury','CB',7,76,62,'Colombia','2024-03-24','Zoolab','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Christophorus','Bowen','GK',69,16,100,'Vietnam','2025-02-23','Flexidy','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Inglis','Triggol','LB',68,77,31,'Argentina','2025-04-12','Vagram','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Evelina','Hauck','CB',100,85,59,'China','2022-06-27','Letlux','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Hertha','Barsby','LB',52,62,94,'Argentina','2023-09-21','Quo Lux','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Honey','Copner','LB',14,94,27,'Czech Republic','2024-01-22','Alpha','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Noreen','Gingedale','CB',48,24,96,'Brazil','2024-11-26','Daltfresh','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Alexis','Putnam','RM',22,53,26,'Greece','2025-06-25','Tempsoft','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Nikolaos','Dowdney','RB',39,95,20,'Portugal','2022-09-11','Mar Lam Tam','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Mersey','Cavie','ST',43,23,97,'China','2025-04-25','Flowdesk','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Tabbitha','Spilsted','LM',99,64,24,'Tunisia','2024-08-23','Latlux','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Hagen','Maylour','LM',40,17,24,'Peru','2024-07-22','Regrant','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Noe','Nightingale','LB',71,28,56,'Sweden','2022-07-25','Stronghold','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Bailie','Morsley','RM',2,3,54,'Indonesia','2023-10-28','Vagram','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Libbie','Kinneally','ST',14,83,58,'Indonesia','2024-02-26','Biodex','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Salomon','Jacobsen','CB',81,76,76,'Portugal','2023-05-29','ComerBear','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Adrianne','Adanet','RM',23,95,12,'Pakistan','2023-11-24','Namfix','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Alika','Turnock','ST',16,56,9,'China','2024-11-14','Redhold','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Brnaby','Monier','RM',25,33,37,'Indonesia','2025-01-17','ComerBear','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Wilma','Bollam','GK',83,31,47,'China','2025-06-18','Tempsoft','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (49,'Tibold','Hairsine','RB',92,38,69,'Philippines','2025-01-26','Tempsoft','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Maryanna','Arnatt','ST',52,40,90,'Russia','2022-08-15','Mar Lam Tam','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Clayton','Martensen','CM',58,61,37,'Costa Rica','2025-03-30','Ronstring','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Nissie','Moxson','ST',49,59,29,'United States','2025-05-31','Daltfresh','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Brantley','Bithell','LB',28,52,67,'Poland','2022-08-28','Yellowhold','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Dane','Reede','LM',76,54,55,'Canada','2024-12-10','Treeflex','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Kala','Vennings','CB',34,96,57,'Japan','2023-03-01','Vagram','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Henri','Kundt','RB',76,74,94,'Indonesia','2023-12-20','Daltfresh','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Susanna','Cotgrave','CM',44,68,70,'Japan','2023-03-06','Domainer','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Ronna','Beechcraft','CDM',95,10,25,'United States','2023-01-02','Tresom','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Gram','Swanbourne','CM',89,48,34,'China','2022-10-22','Ventosanzap','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Brandy','Geraldi','ST',75,60,86,'China','2022-10-05','Zathin','Norway');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Viola','Bolan','CM',23,82,54,'France','2022-04-18','Toughjoyfax','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Ty','Valentin','CDM',55,64,7,'Tanzania','2023-07-13','Seagram','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Haslett','Curedale','LB',73,100,71,'Portugal','2023-06-10','Softjoyfax','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Virginie','Flux','CDM',45,24,89,'China','2024-07-28','Flowdesk','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Brigg','Pedrielli','CDM',57,19,30,'Brazil','2023-04-30','Yellowhold','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Stacee','Lasselle','RM',78,28,16,'Philippines','2024-06-24','Stronghold','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Karoline','Cuthbertson','CB',50,70,92,'Indonesia','2024-05-03','Ventosanzap','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Cirilo','Schoenleiter','ST',23,96,80,'Czech Republic','2024-12-15','Zontrax','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Northrop','Sausman','RB',48,60,55,'Nigeria','2024-02-07','Mar Lam Tam','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Carolann','Kendall','LM',32,34,55,'Mexico','2025-04-29','Flowdesk','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Merrie','Popworth','CM',94,66,17,'China','2023-11-27','Keylex','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Bernardo','Phettis','CM',72,20,16,'Brazil','2025-06-04','Domainer','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Birgitta','Pennells','GK',90,97,19,'Indonesia','2025-01-23','Tampflex','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Arabele','Pridden','LM',44,14,73,'Poland','2025-07-23','Zoolab','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Lauri','Ceci','CDM',15,19,88,'China','2022-07-28','Yellowhold','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Kiel','Dand','GK',79,71,4,'Indonesia','2022-12-23','ComerBear','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Regen','Tribell','CDM',6,14,32,'Portugal','2022-09-10','Daltfresh','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Giraldo','Westnedge','GK',98,1,50,'Colombia','2025-03-18','Treeflex','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Sibel','Cossar','CDM',75,88,9,'Poland','2023-12-28','Namfix','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Abra','Caygill','ST',45,14,62,'China','2024-12-20','Latlux','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Edgardo','Kitchenman','ST',4,41,22,'China','2025-04-05','Zoolab','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Gnni','Braznell','LM',17,34,82,'Canada','2023-09-29','Mar Lam Tam','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Stormie','Barden','RB',54,70,71,'China','2023-09-09','Domainer','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Milt','Studders','RB',14,23,37,'Indonesia','2024-01-26','Latlux','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Oswell','Kamienski','LM',94,34,19,'Russia','2024-08-23','Perm','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Ernestus','Essam','ST',75,74,78,'Russia','2022-06-28','It','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Yasmin','Ladyman','GK',3,83,97,'China','2024-06-06','Softjoyfax','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Courtney','Argo','CB',30,41,91,'China','2024-03-22','Latlux','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Hallie','Meffan','GK',71,21,52,'El Salvador','2024-09-22','Biodex','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Charmine','Necolds','ST',83,64,79,'Madagascar','2024-04-28','Seagram','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Maurise','Groocock','RB',13,53,74,'Mexico','2022-07-06','Keylex','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Tedda','Tireman','CDM',94,74,58,'China','2023-12-27','Domainer','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Eolande','Kilgallen','CB',27,16,46,'Indonesia','2022-11-27','Temp','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Benni','Gwilym','CDM',44,4,81,'China','2023-09-14','Treeflex','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Lyssa','Crossthwaite','ST',25,43,58,'France','2025-03-23','Namfix','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Lucia','Canner','RM',57,79,86,'China','2023-02-02','Keylex','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Jedd','Braysher','CB',51,96,60,'Indonesia','2024-05-29','Domainer','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Yoko','Morriss','CDM',39,15,32,'United States','2024-08-18','Softjoyfax','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Isaac','Whitemarsh','GK',53,2,70,'Mexico','2024-01-14','Duo Lux','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Inglis','Snare','CB',75,19,11,'Bosnia and Herzegovina','2024-04-02','Treeflex','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Krissie','Lissenden','CDM',83,80,62,'Russia','2022-10-16','Temp','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Linn','Benyon','RM',87,38,47,'Sweden','2024-08-20','Solarbreeze','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Codi','Leband','GK',9,87,10,'China','2022-04-30','Seagram','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Shawna','Brownsill','ST',17,28,85,'Senegal','2022-07-27','Perm','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (8,'Mikaela','Whelpdale','CDM',45,23,87,'Chile','2023-09-09','Flowdesk','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Gunner','Godden','ST',17,79,16,'Philippines','2022-07-11','Alphazap','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Worthy','Manoelli','GK',100,14,95,'China','2023-10-07','Biodex','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Corry','Allcroft','CM',87,88,85,'China','2022-05-20','Domainer','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Sibyl','Ellsbury','LB',8,96,29,'Russia','2023-06-19','It','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Nomi','Pasek','CB',37,50,97,'Cape Verde','2023-12-21','Flexidy','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Gianina','Keavy','LM',26,99,84,'North Korea','2024-12-02','Perm','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Tandi','Glascott','ST',36,13,47,'Myanmar','2025-01-03','Lotlux','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Rodge','Corrao','RM',42,17,66,'Philippines','2024-10-25','Redhold','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Jannel','Deelay','CB',88,30,77,'France','2025-04-06','Bluehold','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Warden','Sprowles','ST',8,29,34,'China','2023-06-09','Zoolab','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Delaney','Armin','ST',6,89,55,'China','2025-05-21','Vagram','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Dolly','Jinkinson','ST',70,78,21,'China','2022-12-30','Mat Lam Tam','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Bibi','Screen','GK',26,65,41,'Indonesia','2025-07-11','Mat Lam Tam','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Robyn','Mowson','ST',3,77,82,'Indonesia','2024-01-20','Ventosanzap','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Constancia','Houlaghan','RM',27,55,22,'Spain','2022-12-17','Mat Lam Tam','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Alia','Gribben','LB',52,90,22,'Brazil','2025-04-11','Asoka','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Cammy','Montford','RM',16,22,97,'China','2023-12-20','Mat Lam Tam','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Madella','Corran','ST',89,51,30,'Sweden','2024-09-06','Letlux','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Edvard','Dietmar','RB',14,25,23,'Libya','2025-07-05','Redhold','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Tallie','Wallicker','RM',87,7,75,'China','2025-01-27','Mar Lam Tam','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Trevar','MacLise','LM',92,91,72,'Zambia','2023-11-14','Perm','Norway');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Giraldo','Scouse','LB',42,16,52,'Philippines','2025-03-12','It','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Yolanda','Kynastone','CB',95,6,56,'Norway','2025-07-23','Letlux','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Bennett','Yeend','GK',54,93,35,'Poland','2024-10-02','Tampflex','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Bone','Petry','LM',93,15,87,'China','2023-12-28','Redhold','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Birgit','Ferreira','CB',17,24,9,'Russia','2025-03-20','Daltfresh','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Vail','Hellens','RM',57,28,98,'Russia','2023-03-08','Zoolab','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Reinwald','Hammerstone','LB',44,5,21,'Norway','2024-10-15','Flowdesk','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Krishna','Durrand','CB',10,18,23,'Bolivia','2023-01-09','Stringtough','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Antonino','Gonsalvo','ST',2,33,77,'Bangladesh','2025-01-09','Tresom','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Madelene','Dufoure','LM',32,30,79,'China','2022-12-26','It','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Ban','Pappin','LM',80,99,100,'Nicaragua','2022-12-07','Tampflex','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Gibb','Meininking','LB',73,52,34,'Argentina','2025-04-27','Alphazap','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Anny','Lysaght','CB',42,64,30,'Poland','2023-01-08','Solarbreeze','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Burton','L''Archer','RM',55,43,66,'China','2022-04-22','Tempsoft','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Dorothee','Doreward','ST',59,57,9,'Indonesia','2022-09-12','Tempsoft','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Karry','Padley','CDM',97,34,55,'Brazil','2024-05-27','Zathin','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Adolphe','Rosenkranc','CB',64,93,73,'France','2022-06-17','Stringtough','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Nana','Skough','CB',10,44,39,'Sweden','2022-07-13','Wathin','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Allin','Pollok','ST',49,90,95,'China','2022-09-06','Seagram','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Dorie','Ebbers','LB',57,73,6,'Portugal','2024-03-11','Flexidy','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Colline','Bycraft','CDM',35,75,59,'Angola','2022-10-02','Perm','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Robinette','Di Pietro','RM',100,100,4,'China','2024-08-22','Flexidy','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Valentino','Greville','LM',58,30,4,'China','2024-01-12','Yellowhold','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Ainslee','Ranklin','RM',93,41,76,'Philippines','2022-08-11','Zathin','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Rosina','Stollenbeck','CB',56,27,94,'Indonesia','2023-01-06','Namfix','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Gilburt','Biggs','ST',35,27,15,'Norway','2025-03-15','ComerBear','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Moina','Hamor','ST',95,70,12,'Pakistan','2024-01-31','Duo Lux','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Anya','Flement','LM',53,29,6,'Portugal','2022-06-16','Letlux','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Aurore','Mellsop','CM',82,39,43,'Indonesia','2022-05-28','Temp','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Anissa','Lewzey','CDM',89,41,96,'China','2024-07-12','Temp','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Kenna','Lidgey','ST',25,50,37,'Serbia','2023-07-31','Zathin','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Carola','Probin','CB',71,87,73,'Venezuela','2023-04-26','Flowdesk','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Shannah','Dugget','RM',17,75,53,'China','2024-02-01','Tresom','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Talyah','Rawstorn','ST',76,26,91,'Portugal','2025-03-10','Softjoyfax','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Carney','Leith','RM',32,35,75,'Brazil','2025-04-06','Asoka','Angola');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Stevy','Coneley','RM',18,46,82,'Russia','2023-10-05','Subin','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Sherrie','Birdwistle','RM',51,35,24,'Brazil','2024-08-05','Flexidy','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Ellswerth','Gogay','LM',15,17,23,'Tanzania','2024-10-28','Alphazap','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Thornton','Trineman','CB',92,57,12,'Canada','2024-02-06','Subin','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Darda','Le Grove','RB',69,4,53,'Japan','2025-06-07','Zontrax','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Emanuel','Yeldon','LM',73,43,73,'Poland','2024-07-03','Quo Lux','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Margaret','Lushey','CDM',99,87,10,'China','2025-03-12','Subin','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Saxe','Silly','CDM',89,81,28,'Indonesia','2025-07-08','Quo Lux','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Atalanta','Blant','CDM',57,74,98,'Micronesia','2025-01-10','Lotlux','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Rudolf','Brettoner','GK',29,34,2,'China','2022-10-03','Perm','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Mervin','Lesser','ST',80,25,34,'China','2022-12-31','Treeflex','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Karl','McCosh','ST',70,83,78,'Dominican Republic','2024-10-30','Zoolab','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Doloritas','Thurske','RB',51,23,71,'Poland','2024-11-07','Ronstring','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Ira','McAline','RM',94,57,84,'Poland','2024-05-20','Solarbreeze','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Catina','Matysiak','LM',48,5,96,'Barbados','2023-01-18','Letlux','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Arch','Ivanonko','CB',63,28,97,'Colombia','2022-05-05','Biodex','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Billy','Stain','GK',26,62,94,'France','2023-07-24','Yellowhold','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Ammamaria','Gutowska','RB',46,96,7,'Norway','2022-08-04','Ronstring','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Hershel','Berens','RB',82,14,15,'Philippines','2024-09-06','Ventosanzap','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Gates','Charleston','LB',75,84,48,'Czech Republic','2025-05-15','Perm','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Kellia','Blakelock','GK',81,95,7,'Russia','2023-10-10','Asoka','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Taber','Dashwood','CDM',66,8,41,'Iran','2023-07-01','Redhold','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Maribeth','Forson','CM',34,47,31,'Brazil','2025-04-28','Alpha','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Verney','Eykelbosch','CDM',47,25,41,'Zimbabwe','2025-04-10','Stringtough','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Maia','Ovitts','CM',82,29,4,'Malaysia','2024-04-05','Lotlux','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Daune','Marflitt','CDM',82,41,97,'Poland','2023-10-29','Bluehold','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Guenna','Konzelmann','ST',90,3,96,'Russia','2022-05-04','Letlux','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Griselda','Torricina','CB',89,80,92,'Serbia','2025-05-01','Temp','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Lacie','Carek','CB',37,76,91,'Uzbekistan','2025-05-16','Tempsoft','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Ira','Fley','CDM',15,33,97,'Brazil','2025-05-08','Domainer','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Koren','Goody','CB',16,49,95,'Panama','2023-08-01','Mar Lam Tam','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Herbert','Halso','ST',74,63,15,'Botswana','2022-11-19','Regrant','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Annabella','Horsfield','CDM',31,47,69,'Lithuania','2022-09-25','Letlux','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Ambrosio','Balchin','RM',46,48,87,'Italy','2023-07-20','Temp','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Levon','Beesey','CDM',21,65,66,'Brazil','2025-01-12','Lotlux','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Donni','Kleinert','RB',30,23,36,'Portugal','2025-03-14','Tampflex','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Farra','Letson','LM',4,4,66,'China','2024-05-12','Letlux','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Lev','Witham','CB',10,39,24,'France','2022-04-05','Mat Lam Tam','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Hertha','McBrearty','RB',95,63,77,'Colombia','2023-03-13','Tampflex','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Bartholemy','Rampley','LM',4,7,23,'Yemen','2024-11-08','Redhold','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Gui','Winterborne','CM',20,44,28,'Japan','2022-05-12','Softjoyfax','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Gabriella','Luckey','LB',47,65,100,'Sweden','2024-09-07','Letlux','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Christian','Dauncey','CB',28,96,40,'Croatia','2025-07-08','Flowdesk','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Annabelle','Godsell','CDM',56,19,3,'Indonesia','2024-11-12','Tampflex','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Clarissa','Matysiak','RB',50,98,99,'Ireland','2023-01-12','Biodex','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Eldon','Emson','LB',86,33,24,'Ukraine','2022-10-02','Flowdesk','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Ilene','Shurville','CDM',13,48,70,'Indonesia','2022-06-19','Tempsoft','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Corinna','Boyett','RM',10,73,42,'Ukraine','2022-09-15','Seagram','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Muffin','Cuseck','LB',28,69,36,'Peru','2023-05-15','Ventosanzap','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Cris','Stichel','CB',47,31,74,'Poland','2023-03-29','Regrant','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Leesa','Lenton','CB',31,14,48,'Brazil','2024-06-06','Redhold','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Petrina','Plitz','GK',12,78,59,'Indonesia','2024-07-21','Flexidy','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Rona','Derricoat','CB',36,8,54,'Lesotho','2025-07-17','Zathin','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Gabriele','Callum','LM',31,2,9,'Palestinian Territory','2023-04-14','Ronstring','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Jamison','Mallows','ST',57,95,71,'Mali','2022-09-03','Wathin','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Mauricio','Jantet','CB',82,15,1,'Philippines','2024-08-14','Keylex','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Fabiano','Gillions','CB',84,7,18,'Argentina','2023-09-10','Ronstring','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Shellysheldon','Andrat','ST',7,58,88,'Russia','2022-07-07','Daltfresh','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Penelopa','Cheney','CB',46,85,76,'Mongolia','2023-08-21','Flowdesk','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Marcy','MacCheyne','GK',59,61,2,'Brazil','2023-01-02','Softjoyfax','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Eleanore','Coggins','RB',27,11,13,'China','2023-10-29','Asoka','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Jemima','Parbrook','RM',83,56,52,'United States','2023-08-18','Softjoyfax','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Yolanthe','Jeannard','ST',8,93,26,'Philippines','2024-02-06','Stronghold','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Olivero','Ogelsby','CDM',65,67,21,'Serbia','2024-08-24','Regrant','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Lianne','Hallgath','RM',47,49,85,'Azerbaijan','2022-05-29','Perm','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Jen','Krebs','LB',34,60,55,'China','2022-11-07','Namfix','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Yard','Kingett','GK',23,55,26,'Ukraine','2023-06-07','Yellowhold','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Correy','Servante','ST',84,40,33,'Ukraine','2023-01-08','Tresom','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Mufinella','Morgue','LB',44,10,51,'Indonesia','2024-12-17','Toughjoyfax','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Sheilah','Wharrier','CB',44,52,46,'Japan','2025-04-15','Flexidy','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Oralee','Mellenby','CDM',73,51,17,'Philippines','2022-11-25','Stronghold','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Tami','Waldera','LB',81,51,41,'Russia','2022-10-10','Namfix','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Correna','Corking','ST',13,99,90,'Russia','2024-08-28','Mar Lam Tam','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Odelinda','Francescone','RM',46,62,90,'Canada','2022-11-06','Tampflex','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Mendie','Jellis','GK',74,95,48,'Indonesia','2024-01-28','Flowdesk','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Rufus','Heavens','ST',56,74,18,'Indonesia','2022-11-26','Subin','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Jackie','Gull','CDM',23,24,37,'Sweden','2024-12-11','Daltfresh','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Brander','Allmen','CDM',46,59,29,'Micronesia','2024-10-09','Quo Lux','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Laurence','O''Kenny','CB',10,28,69,'Portugal','2023-01-07','Treeflex','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Row','McCreadie','ST',47,59,62,'Thailand','2023-09-22','Ventosanzap','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Arlen','Gregson','ST',4,63,29,'Philippines','2024-09-24','Temp','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (8,'Christabella','Matiasek','CDM',71,40,93,'Philippines','2024-03-13','Toughjoyfax','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Melvyn','Simms','CM',17,66,72,'Zimbabwe','2024-08-20','Zathin','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Trixie','Lidgate','LM',19,72,56,'Sweden','2023-07-18','Biodex','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Nettie','Whatman','LB',4,13,8,'Philippines','2024-04-12','Lotlux','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Engelbert','Halcro','CB',19,77,45,'Ukraine','2024-05-13','Zontrax','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Sacha','Haly','LM',93,43,52,'China','2024-02-10','Treeflex','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Marshall','Aspinal','LB',55,13,6,'Indonesia','2022-10-24','Namfix','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Mischa','Bernucci','ST',37,50,99,'Guatemala','2024-01-30','Flowdesk','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Maximilien','Loader','CDM',30,41,5,'China','2025-04-11','Wathin','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Corty','MacCambridge','LB',12,88,41,'China','2024-04-11','Mar Lam Tam','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Mattie','Traves','CM',27,49,66,'Brazil','2022-06-26','Mat Lam Tam','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Jeanna','Barkworth','RB',24,59,33,'China','2022-10-22','Mat Lam Tam','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Kailey','Strahan','ST',14,40,91,'Portugal','2022-06-12','Softjoyfax','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Devy','Lawles','CDM',89,71,64,'Finland','2024-07-22','Ventosanzap','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Stormy','Jessett','GK',57,42,49,'France','2022-12-08','Solarbreeze','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Patience','Rive','ST',45,33,49,'China','2022-06-22','Asoka','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Felecia','Kolushev','GK',17,43,50,'Colombia','2022-04-19','Ronstring','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Haydon','Jotcham','ST',12,56,53,'Poland','2025-04-11','ComerBear','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Pauletta','Benzi','CB',16,86,88,'South Africa','2024-01-09','Bluehold','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Seward','St. Aubyn','RM',45,52,57,'Guatemala','2023-11-04','Domainer','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Janet','Rapin','CB',13,43,5,'Portugal','2022-09-05','Ronstring','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Morganne','Blaycock','ST',22,73,31,'Greece','2023-01-01','Zontrax','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Dalia','Perrelli','CB',3,45,49,'Afghanistan','2025-02-04','Yellowhold','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Pam','Bunten','LM',75,91,67,'Germany','2024-04-27','Softjoyfax','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Kesley','Cantwell','RM',85,11,28,'Mongolia','2022-08-01','Zontrax','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Denny','Liddard','RB',99,55,34,'Indonesia','2025-03-12','Redhold','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Gayle','Levison','CB',13,33,47,'Russia','2024-08-17','Ronstring','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Hadlee','Peake','ST',27,35,76,'Sweden','2025-05-21','Seagram','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Rube','Ganford','CB',3,87,87,'Sweden','2024-06-21','Namfix','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Aldwin','Georgins','CB',39,88,78,'Indonesia','2023-07-18','Tampflex','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Lyell','Searl','CM',35,16,70,'China','2022-07-16','Daltfresh','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Horatius','Beisley','CM',25,100,56,'Portugal','2024-01-20','Keylex','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Morna','Duly','RM',45,38,6,'Japan','2024-03-11','Temp','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Raf','Rooze','RM',78,100,30,'Kazakhstan','2023-07-24','Tresom','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Jehanna','Veregan','CM',96,79,87,'China','2025-06-25','Regrant','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Ive','Jenik','RB',92,50,3,'Bulgaria','2024-04-22','Vagram','Haiti');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Kizzee','Begbie','GK',2,64,27,'China','2023-02-04','Mat Lam Tam','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Denni','Northcote','CM',60,17,17,'Latvia','2022-10-29','Tampflex','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Lutero','Shutler','CB',55,61,84,'China','2024-06-15','Seagram','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Leyla','Parrett','LB',5,12,2,'Latvia','2025-04-26','Zontrax','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Lucais','Berggren','CB',48,6,22,'Russia','2022-07-25','Letlux','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Ivan','Sheddan','CB',71,28,32,'Moldova','2022-08-25','Stronghold','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Nata','Steinor','LB',42,6,86,'Russia','2024-02-01','Yellowhold','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Ibbie','Constanza','ST',68,86,70,'China','2023-10-21','Flowdesk','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Tamara','Harley','CDM',68,40,53,'Thailand','2022-06-14','Yellowhold','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Hansiain','Eby','ST',72,22,1,'Philippines','2022-04-19','Mar Lam Tam','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Rozanne','Ruzicka','LM',8,36,94,'China','2023-03-08','Flowdesk','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Rosalinda','Satterly','LB',9,43,18,'Brazil','2023-03-29','Lotlux','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Edith','Burnhard','RB',18,37,64,'United States','2023-05-24','Toughjoyfax','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Dillie','Gemeau','LB',60,86,27,'Philippines','2022-10-09','Treeflex','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Coretta','Clougher','GK',77,3,32,'China','2023-09-13','Alpha','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Meier','Walworche','CDM',13,72,27,'China','2025-01-30','Biodex','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Garvin','Korlat','GK',25,97,41,'Philippines','2023-04-16','Wathin','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Bliss','Ouldcott','LM',10,99,63,'China','2022-11-22','Alphazap','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Tabbatha','Gautrey','CDM',75,14,71,'Ireland','2023-10-13','Namfix','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Lilias','Tatem','CB',91,65,29,'Portugal','2023-08-10','Daltfresh','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Rance','Sket','ST',42,54,53,'Indonesia','2023-09-19','Biodex','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Mureil','Bestwall','GK',99,15,22,'Indonesia','2024-10-31','Asoka','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Roley','Lepick','CB',51,44,51,'Estonia','2025-01-22','Vagram','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Red','Luddy','ST',37,20,3,'Indonesia','2024-04-27','Redhold','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Evita','Font','CB',2,40,79,'Poland','2024-10-11','Treeflex','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Giff','Bravington','ST',92,21,55,'Croatia','2023-06-20','Daltfresh','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Lib','Hubbuck','LM',48,86,80,'China','2023-09-24','Stronghold','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Zabrina','Risley','CB',90,77,96,'Indonesia','2023-07-13','Tempsoft','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Electra','Beale','LB',63,37,60,'Indonesia','2024-03-20','Yellowhold','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Frans','Josephs','CB',27,92,72,'Russia','2024-06-20','Bluehold','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Almire','Impey','RM',92,29,42,'China','2023-04-07','Vagram','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Brockie','Dodgshun','LM',27,40,24,'Sweden','2022-08-19','Vagram','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Jobey','Piken','CM',45,45,54,'Guatemala','2025-06-30','Tampflex','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Lind','Van der Son','CDM',20,52,35,'Serbia','2024-01-14','Stronghold','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Korella','Stubbin','ST',50,18,52,'China','2025-07-03','Bluehold','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Silvio','Luther','CB',29,62,54,'Czech Republic','2023-09-30','Vagram','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Spencer','Ostler','LB',37,31,50,'Russia','2023-05-26','Keylex','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Christian','Figgures','LB',91,29,100,'Saudi Arabia','2023-08-11','Toughjoyfax','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Bobette','Pudney','RM',36,33,58,'Peru','2023-12-21','Tampflex','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Gardy','Hannibal','LM',16,100,53,'China','2022-06-04','Vagram','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Engracia','Frodsam','GK',78,85,79,'Portugal','2022-05-19','Softjoyfax','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Jennine','Leonardi','GK',94,83,68,'China','2023-10-23','Seagram','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Maurizia','Ronaghan','ST',56,42,90,'Iran','2022-06-02','It','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Nalani','Kellick','CB',16,15,44,'Indonesia','2023-11-27','Redhold','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Cristi','Billham','ST',72,95,76,'China','2022-04-13','Seagram','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Marnia','Heape','LB',56,55,2,'Israel','2024-08-03','Zoolab','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Marena','Ambrosi','GK',32,41,85,'Laos','2024-02-08','Keylex','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Nessie','Sutheran','CM',22,83,69,'Poland','2024-12-15','Daltfresh','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Flory','Inglese','RB',15,70,36,'Poland','2023-12-30','Regrant','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Granville','Deave','CDM',38,76,84,'Estonia','2023-05-30','Tempsoft','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Dorie','Gino','ST',29,71,47,'Russia','2025-07-28','Quo Lux','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Sandra','Lewens','LM',79,2,92,'Cyprus','2023-03-13','Zontrax','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Mellie','Artrick','CB',43,28,71,'China','2023-07-26','Redhold','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Wallie','D''Angeli','CM',6,59,78,'United States','2022-07-13','Subin','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Lotta','Shelbourne','ST',81,42,70,'Honduras','2023-06-08','Ronstring','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Eamon','Colisbe','ST',97,10,50,'Egypt','2023-09-30','Asoka','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Seline','Vennings','LM',80,82,27,'France','2024-01-31','Regrant','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Bernete','Duiguid','CB',96,48,46,'Ukraine','2024-05-28','Biodex','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Clint','Semark','CB',69,73,75,'China','2023-09-07','Temp','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Virgilio','Williamson','RM',43,34,68,'Cameroon','2022-10-20','Namfix','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Rickie','Bernadon','LM',31,40,75,'Indonesia','2023-05-02','Redhold','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Ame','Hollingsbee','RB',85,83,40,'Laos','2023-01-20','Alpha','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Robyn','Everly','RM',4,56,6,'Papua New Guinea','2023-05-13','Seagram','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Jerrie','Honnicott','LM',46,89,92,'China','2023-01-18','Solarbreeze','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Brigitta','Raddish','LB',9,82,2,'United States','2024-02-20','Wathin','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Isobel','Wreight','RB',38,81,82,'Russia','2023-03-25','Asoka','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Hildagarde','Thorius','LB',65,33,23,'Germany','2023-02-06','Tresom','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Nickolai','Comford','ST',21,38,12,'Philippines','2023-07-23','Stringtough','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Howie','Segar','ST',50,31,36,'Indonesia','2022-11-21','Alpha','Norway');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Morly','Dowry','CB',21,66,57,'Greece','2024-02-15','Bluehold','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Ali','Djokovic','LB',91,42,2,'Ukraine','2024-10-18','It','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Cam','Liddle','ST',34,30,44,'China','2023-05-14','Tresom','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Star','Sivills','CM',13,33,78,'Ghana','2023-10-01','Asoka','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Tobiah','Karlolczak','CDM',14,82,77,'Belarus','2022-11-19','Bluehold','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (49,'Jefferey','Grassi','CDM',17,12,69,'Philippines','2025-03-11','Mar Lam Tam','Czech Republic');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Darcey','Martland','GK',96,99,7,'Sri Lanka','2022-09-10','Temp','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Marty','Studd','CDM',69,11,85,'Italy','2024-04-19','Domainer','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Isidoro','Polini','CM',48,63,82,'Turkmenistan','2025-02-01','Perm','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Fidel','Bagley','LB',20,99,91,'Slovenia','2024-11-18','Tempsoft','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Ramonda','Gurr','RM',99,23,78,'French Polynesia','2022-04-27','Letlux','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Danny','Silber','GK',87,89,26,'Argentina','2023-05-22','Perm','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Sharon','Renwick','CB',5,29,59,'Croatia','2025-02-23','Daltfresh','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Karissa','Buckam','ST',52,54,26,'China','2024-09-18','Ronstring','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Diana','Vergo','LM',66,45,91,'Mexico','2023-10-02','Alphazap','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Maurits','Cornehl','CB',54,93,91,'China','2024-07-06','Subin','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Tadio','Evensden','LM',22,43,97,'China','2024-02-19','Flowdesk','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Fin','Oglesbee','RB',28,26,22,'Panama','2025-05-08','Namfix','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Cookie','Veall','ST',49,26,54,'Russia','2025-01-25','Zathin','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Kissiah','Guterson','ST',97,60,94,'China','2025-03-11','Zontrax','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Alla','Rydeard','CB',58,28,49,'Norway','2025-04-26','Keylex','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Nell','Hotson','CB',29,48,52,'China','2024-08-15','Wathin','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Morgan','Janovsky','ST',64,43,97,'Peru','2022-11-02','ComerBear','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (30,'Flory','Oven','CB',30,15,92,'Russia','2023-09-24','Redhold','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Johnna','Righy','CB',49,29,75,'Russia','2022-12-13','Latlux','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Chryste','Spaule','CB',41,63,57,'Italy','2025-01-18','Quo Lux','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Marrissa','Juster','LM',3,72,58,'Greece','2025-01-18','ComerBear','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Gardener','Wolvey','RM',36,22,17,'Indonesia','2023-08-08','Letlux','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Arther','Siaskowski','ST',66,54,63,'China','2022-08-02','Zoolab','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Dominic','Lestrange','LM',53,90,86,'China','2024-07-20','Zathin','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Coralie','Nowick','GK',41,75,24,'Madagascar','2024-05-21','Bluehold','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Basia','Ivanenko','CM',81,72,76,'Lithuania','2022-04-26','Daltfresh','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Micky','Moohan','CM',54,73,28,'Portugal','2024-02-22','Duo Lux','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Lauralee','Matthewes','RM',29,100,58,'Georgia','2022-12-06','Tampflex','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Norbie','Marcq','GK',54,100,78,'Guatemala','2023-04-04','Keylex','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Anthony','Perton','CB',79,69,81,'Indonesia','2025-07-16','Daltfresh','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Clem','Wooland','ST',46,54,91,'Indonesia','2023-03-22','Biodex','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Jacenta','Gipp','ST',75,10,88,'Indonesia','2024-10-07','Stronghold','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Erica','Ohms','LB',16,31,45,'Greece','2024-05-03','Regrant','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Cordelia','Verner','CM',58,87,50,'Poland','2022-07-21','Latlux','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Lorry','Myhill','ST',7,44,11,'France','2024-07-16','Tresom','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Ruy','Beange','RB',39,81,48,'Sweden','2022-12-16','Softjoyfax','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Roberta','Watson','RM',71,99,76,'Russia','2023-08-12','Ronstring','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Davidde','Longworthy','LB',49,1,87,'Bulgaria','2022-04-09','Letlux','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Selby','Duiguid','ST',31,15,32,'Philippines','2023-12-12','Softjoyfax','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Dee','Jedraszczyk','RM',72,31,38,'Russia','2023-03-02','Namfix','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Jae','Sheran','CM',89,13,75,'China','2024-07-16','Stronghold','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Nickolai','Glanvill','LM',84,96,18,'China','2022-05-07','Stringtough','Angola');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Gwenora','Jirieck','ST',56,67,51,'Vietnam','2023-11-29','Regrant','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Renee','Jermin','RB',76,84,44,'Zimbabwe','2023-12-01','It','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Aleda','Pergens','CB',18,92,50,'Russia','2023-07-08','Seagram','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Derrek','Jilkes','LB',24,64,7,'Libya','2023-04-03','Toughjoyfax','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Cosetta','Baldung','LB',24,18,92,'Armenia','2022-09-21','Flowdesk','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Brynne','Spellesy','CDM',68,33,68,'Japan','2022-11-25','Redhold','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Mattie','Blew','ST',9,61,75,'Philippines','2024-09-22','Tampflex','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Genovera','Andrassy','CB',42,79,30,'Burkina Faso','2023-12-26','Seagram','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Agnola','Eplett','LB',11,21,51,'France','2022-06-26','Letlux','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Caralie','Elliot','CB',77,12,69,'China','2024-02-20','Latlux','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Gerianne','Moseby','ST',54,2,55,'Sweden','2022-07-14','Solarbreeze','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Jaime','Garmons','CM',83,82,62,'Russia','2023-05-13','Stringtough','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Mollie','Filipczak','CB',37,54,43,'China','2024-08-23','Duo Lux','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Wilmar','Hindmore','ST',67,99,73,'Italy','2024-03-26','Mat Lam Tam','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Ruben','Children','CDM',3,17,44,'China','2022-11-15','Bluehold','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Maynard','Gartrell','ST',7,1,35,'China','2023-05-01','Wathin','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Stevana','Pentland','LM',2,36,93,'Thailand','2023-10-01','Seagram','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Rebecka','Mertin','LM',79,65,18,'Colombia','2023-07-15','Stronghold','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Sada','Jahner','ST',96,40,81,'Indonesia','2025-06-02','Vagram','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Ephraim','MacGahy','RB',85,77,4,'Japan','2024-12-18','Zontrax','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Alfreda','Alexsandrev','ST',20,1,25,'Indonesia','2022-06-22','Subin','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Gavan','Measures','CM',90,35,57,'China','2024-12-13','Redhold','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Deborah','Beardow','LM',35,73,35,'Brazil','2025-01-11','Subin','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Christoffer','McDonell','CM',87,86,25,'China','2024-04-07','Seagram','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Tobit','Cropton','ST',33,29,88,'Mexico','2025-02-01','Latlux','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (9,'Charmion','Bomb','CB',14,59,31,'Russia','2022-07-19','Namfix','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Pierre','Mackney','CB',62,40,12,'Russia','2025-06-23','Wathin','Haiti');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Deny','Hiseman','ST',64,29,67,'Peru','2024-09-08','Redhold','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Shir','Wotton','CDM',95,94,75,'Pakistan','2024-08-12','Temp','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Boy','Bentjens','LB',23,45,65,'France','2023-07-19','Daltfresh','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Nikolaus','Siaspinski','ST',58,43,71,'Netherlands','2023-01-22','Tresom','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Lauritz','Fillingham','LB',59,70,49,'Maldives','2025-07-28','Letlux','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Kenton','Locksley','LM',2,8,62,'Nigeria','2024-10-30','Temp','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Ashley','Reskelly','RB',15,63,21,'Sweden','2022-10-23','Asoka','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Irina','Carvill','RM',41,28,77,'Malawi','2023-02-13','Tampflex','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Roxi','Lemm','CM',44,75,41,'Japan','2025-04-02','Asoka','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Midge','Huyton','LB',66,24,81,'China','2025-03-09','Yellowhold','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Ronnie','Abarough','CDM',49,70,74,'Philippines','2024-09-30','Wathin','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Philippine','Kerridge','ST',37,32,58,'France','2022-12-06','Toughjoyfax','Czech');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (31,'Rafael','Foulsham','CM',83,16,2,'Palestinian Territory','2022-07-14','Alphazap','Algeria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Melania','Lamasna','RM',35,26,86,'Philippines','2025-01-25','Toughjoyfax','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Dennie','Camellini','RB',87,25,19,'Czech Republic','2022-09-23','Quo Lux','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Conny','Veschambre','CDM',47,75,82,'Japan','2025-02-17','Zoolab','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Laina','Oxborough','LB',31,92,10,'Malawi','2023-03-18','Namfix','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Garrik','Hagerty','GK',77,11,51,'Ivory Coast','2022-10-19','Solarbreeze','Nepal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Erina','Bruniges','RB',46,67,65,'France','2024-05-08','Subin','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Camella','Kenen','CM',48,65,51,'Poland','2023-09-13','Toughjoyfax','Chad');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Riley','Mabbott','ST',64,65,88,'Japan','2022-04-22','Treeflex','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Thornie','Stangoe','ST',49,45,46,'Czech Republic','2025-06-26','Zoolab','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Farra','Leatham','CB',93,25,1,'Belarus','2024-12-24','Seagram','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Jessee','Wotherspoon','CM',19,94,93,'Trinidad and Tobago','2025-04-21','Temp','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'John','Thurley','CB',95,80,95,'Philippines','2023-10-10','Perm','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Cecelia','Ajean','LB',88,49,46,'Poland','2025-04-27','Asoka','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Honor','Shanklin','ST',6,21,56,'China','2025-02-03','Flowdesk','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Fair','Ridsdale','CB',10,93,82,'Macedonia','2022-08-07','Redhold','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Ambur','Crippin','ST',81,83,13,'China','2025-02-26','Stronghold','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Coralie','Sancias','GK',1,29,16,'Indonesia','2022-06-11','Keylex','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Daniela','Douty','GK',34,75,62,'China','2024-09-30','Solarbreeze','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Karlens','Billany','ST',50,53,62,'Indonesia','2023-04-13','Ventosanzap','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Orv','Cowie','RM',59,58,17,'Norway','2022-11-02','Ventosanzap','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Riordan','Isgar','LM',69,73,100,'Netherlands','2024-08-31','Latlux','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Keely','Cotta','RM',72,63,51,'Bangladesh','2024-05-08','Namfix','Haiti');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Joellen','McGurn','CDM',65,29,21,'China','2022-11-06','Alphazap','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Harlan','Lawry','RB',25,9,70,'Norway','2023-05-05','Alpha','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Dulcie','Brauner','CB',56,71,16,'Sweden','2025-05-21','Regrant','North Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (26,'Orin','Jonin','LB',97,63,70,'Costa Rica','2023-06-21','Wathin','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Jessa','Merkle','ST',23,33,42,'Canada','2023-02-15','Yellowhold','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Nerissa','Dallyn','LM',11,23,6,'China','2022-06-15','ComerBear','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Cacilia','Bartolomucci','CDM',37,8,67,'China','2022-12-05','Letlux','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Simonne','Akers','RB',54,12,1,'South Africa','2023-12-23','Tempsoft','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Chancey','Gilpin','ST',15,53,78,'Philippines','2024-02-05','Regrant','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Elke','Jermey','ST',39,18,36,'Philippines','2023-01-11','Stronghold','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Romona','Dumbelton','ST',91,38,14,'China','2023-06-05','Domainer','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Lorenza','Thurbon','RM',57,27,51,'China','2023-03-24','Flexidy','Angola');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (20,'Hilario','Knobell','ST',14,44,7,'Nigeria','2024-06-27','Quo Lux','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Clifford','Curran','CB',13,33,28,'Ethiopia','2023-07-15','Duo Lux','Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (2,'Killian','Duddell','CB',96,52,1,'Russia','2022-11-05','Softjoyfax','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (49,'Crosby','Turfrey','CB',68,13,64,'Czech Republic','2022-06-12','Asoka','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Esta','Braganza','RM',15,86,19,'Nepal','2022-12-09','Lotlux','El Salvador');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Rakel','Weerdenburg','LB',71,17,9,'Afghanistan','2025-03-16','Toughjoyfax','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (24,'Lisette','Bachnic','CM',18,27,37,'France','2022-12-17','Biodex','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Corrie','Ballance','CB',38,23,50,'South Africa','2025-01-11','Quo Lux','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Manon','Pund','ST',94,22,38,'Indonesia','2023-04-19','Regrant','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (7,'Filip','Jacklings','CB',61,67,8,'Greece','2023-07-28','Asoka','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Celie','Halvorsen','RM',36,65,92,'Portugal','2022-04-12','Toughjoyfax','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (19,'Fabiano','Hugland','ST',47,100,1,'Philippines','2025-07-29','Domainer','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Amanda','Chirm','LM',38,84,79,'Ukraine','2023-03-23','Toughjoyfax','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Nickolaus','Seres','LM',6,71,4,'Syria','2023-06-19','Toughjoyfax','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Carmine','Borthwick','CDM',48,31,60,'Indonesia','2024-02-25','Mar Lam Tam','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (8,'Maryjo','Mosdill','CB',76,73,98,'Ukraine','2024-06-17','Bluehold','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Spenser','Danilyuk','RB',87,19,88,'China','2023-10-27','Alpha','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Ivar','Derrett','ST',73,32,74,'China','2024-07-31','Lotlux','Maldives');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Tobit','MacGarvey','RB',53,26,64,'Nigeria','2024-07-04','Bluehold','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Riane','McAreavey','LM',84,77,54,'Russia','2024-02-01','Wathin','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Dietrich','Cussins','RM',98,23,71,'Indonesia','2024-12-17','Zoolab','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Merrielle','Eade','CB',33,90,36,'China','2023-12-10','Mar Lam Tam','India');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (47,'Cathie','Rubra','ST',29,8,50,'Saudi Arabia','2024-02-21','Duo Lux','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Torr','Maund','CB',60,30,8,'China','2025-06-26','It','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Talyah','Muckeen','LM',95,75,42,'China','2023-03-08','Softjoyfax','Vietnam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Gelya','Clorley','CM',13,37,23,'Indonesia','2023-04-10','Flexidy','Philippines');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Amil','Baynard','CDM',52,26,62,'China','2022-11-01','Tempsoft','Mexico');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Glynnis','Lensch','LM',52,49,89,'China','2022-05-15','Regrant','Thailand');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Stephani','Dorcey','RM',7,42,94,'China','2024-05-16','Toughjoyfax','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Ev','Abbie','ST',31,21,51,'China','2022-12-28','Daltfresh','Bulgaria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (40,'Ki','Millichip','RM',27,67,69,'United States','2024-10-17','Mat Lam Tam','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (13,'Jacquenette','Sadlier','RM',60,92,43,'Colombia','2023-02-09','Stronghold','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Candace','Viccary','LB',53,76,74,'Norway','2022-04-03','Treeflex','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (48,'Arie','Spivey','CM',65,18,95,'China','2024-06-21','Yellowhold','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (14,'Emmalyn','Haggett','LB',11,52,42,'Mexico','2025-06-25','Tempsoft','Iraq');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Sheela','Eastabrook','CB',53,9,14,'Vietnam','2024-05-23','Softjoyfax','Indonesia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (43,'Yovonnda','Gatley','LM',14,34,82,'China','2025-01-31','Regrant','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Lionel','Bengtson','RB',36,22,64,'Brazil','2024-06-08','Ventosanzap','Spain');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (45,'Patrizia','Barrowcliffe','CDM',59,72,33,'Indonesia','2023-09-26','Biodex','China');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Bernarr','Callander','ST',14,76,48,'Argentina','2024-11-03','Bluehold','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Raviv','Tidbold','CB',81,99,38,'China','2023-05-01','Tampflex','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Gizela','Gergler','CDM',27,38,55,'Ukraine','2023-03-20','Lotlux','Iran');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (8,'Arron','Argont','CB',12,34,68,'China','2025-05-17','It','Cuba');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (37,'Edsel','Tredwell','LB',55,43,80,'Mongolia','2022-09-17','Yellowhold','Syria');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (42,'Sanders','Lorkins','LM',73,22,71,'Japan','2022-07-22','Redhold','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Ramona','Cale','ST',66,59,41,'China','2024-07-28','Bluehold','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (49,'Shae','Farress','CM',16,51,39,'Indonesia','2025-01-01','ComerBear','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Elisa','Haet','ST',39,47,56,'Tunisia','2023-06-29','Solarbreeze','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Kit','Dedon','RB',2,1,25,'Uruguay','2023-12-23','Softjoyfax','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (15,'Ammamaria','Darley','CB',100,92,73,'Portugal','2025-03-29','Domainer','Afghanistan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Parke','Husthwaite','GK',95,46,1,'Portugal','2023-05-31','Regrant','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (1,'Milissent','Lambie','CB',99,82,71,'El Salvador','2025-05-22','Zathin','Japan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Nicol','Chinnery','CB',63,74,27,'Brazil','2023-12-11','Flexidy','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (23,'Amie','Syde','CB',52,31,92,'Ukraine','2022-04-26','Quo Lux','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (46,'Milty','Cubbit','CB',95,23,76,'Argentina','2023-07-06','Asoka','Morocco');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (11,'Glynis','Olyff','RB',92,1,10,'Sweden','2024-08-30','Mar Lam Tam','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (38,'Wilie','Belliveau','ST',49,24,70,'Mexico','2023-09-22','Softjoyfax','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Gracia','Rebillard','LB',72,46,22,'Ukraine','2024-11-24','Zontrax','United Kingdom');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (18,'Betteann','Halwell','LB',69,80,9,'China','2023-12-08','Ventosanzap','Portugal');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (41,'Horatius','Buggs','ST',54,96,62,'China','2022-06-28','Namfix','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Curcio','Giamo','CB',97,40,4,'China','2022-10-22','Zontrax','Haiti');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (35,'Goldie','Drinkwater','LM',81,98,96,'Indonesia','2023-11-08','Namfix','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (25,'Aloin','Skingle','CB',5,52,3,'China','2025-04-08','Mar Lam Tam','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Melisa','Enderle','ST',95,5,41,'China','2025-01-31','Ronstring','Sweden');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Gabriela','Terbrug','GK',31,98,60,'Brazil','2022-06-20','Zathin','Russia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Mamie','Hoodlass','CM',9,99,100,'Indonesia','2023-09-01','Perm','Democratic Republic of the Congo');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Tybi','Skermer','ST',44,97,35,'Japan','2024-11-13','Letlux','Guam');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (28,'Gradey','Franciottoi','ST',77,85,36,'China','2025-03-04','Zathin','Uganda');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (3,'Andi','Lunck','LM',25,54,93,'China','2023-03-26','Regrant','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (22,'Mack','Eidler','CDM',81,16,54,'France','2025-01-02','Tampflex','South Korea');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (6,'Alonzo','Beardow','RM',47,97,88,'Cuba','2024-06-05','Quo Lux','Poland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Reina','Mumbray','LM',85,85,95,'Iran','2023-10-22','Keylex','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Randa','Westell','CB',52,3,4,'Czech Republic','2022-10-25','Solarbreeze','Peru');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Sacha','Janota','CDM',57,22,77,'China','2024-11-29','Letlux','Argentina');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (39,'Lia','Brussels','RM',57,64,49,'Benin','2024-01-15','Tampflex','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Valaree','Caush','CM',56,58,35,'Portugal','2023-10-01','Yellowhold','Ukraine');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (29,'Oren','Alwin','RB',15,25,1,'Poland','2025-05-30','Latlux','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (17,'Jaclin','Woolmington','CB',40,17,30,'Indonesia','2024-06-06','Letlux','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (10,'Opaline','Bucklee','GK',11,79,73,'United States','2023-10-27','Flexidy','Canada');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (36,'Harwilll','Dayborne','LB',12,76,44,'Armenia','2023-01-31','Letlux','Venezuela');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (12,'Ferdinanda','Lucas','GK',38,87,27,'Sweden','2023-08-09','Tresom','Brazil');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (33,'Sergio','Mariolle','RM',94,47,70,'France','2022-10-27','Flowdesk','Myanmar');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (21,'Angy','Gutteridge','CDM',30,7,89,'France','2023-10-26','Regrant','Cambodia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (44,'Paulo','Birtwistle','CM',21,13,48,'United States','2024-01-20','Solarbreeze','Norway');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (4,'Christan','Shallcrass','GK',96,32,83,'Czech Republic','2024-09-05','Latlux','South Sudan');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (34,'Ainsley','Flintiff','GK',76,38,53,'China','2023-01-12','Stronghold','Croatia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (32,'Cathryn','Lidstone','LM',2,54,85,'Indonesia','2022-04-21','Duo Lux','Guatemala');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (16,'Hill','Noquet','ST',91,79,46,'Poland','2025-02-18','Vagram','Mongolia');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (50,'Jessy','Maberley','LM',31,45,79,'Portugal','2025-07-18','Zontrax','United States');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (27,'Ranice','Bonanno','RM',70,67,3,'China','2024-02-24','Tampflex','Switzerland');
INSERT INTO Players(age,first_name,last_name,position,goals,assists,jersey_number,nationality,contract_end_date,team_name,international_team) VALUES (5,'Pris','Hughson','RB',87,99,36,'China','2022-11-11','Lotlux','El Salvador');

INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (76,71,'Alpha','Regrant','2022-06-28','Balistreri, Hermann and Rodriguez');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (69,59,'Alphazap','ComerBear','2022-08-19','Kuphal-Treutel');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (39,31,'Asoka','Vagram','2022-08-31','Nader-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (95,5,'Asoka','Zontrax','2022-11-15','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (4,99,'Biodex','Subin','2022-07-06','Schaden-King');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (56,73,'Biodex','Zontrax','2022-08-08','Hyatt, Schaefer and Fisher');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (96,65,'Biodex','Daltfresh','2022-08-13','Bergstrom, Carter and Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (50,56,'ComerBear','Asoka','2022-06-09','Konopelski, Boyer and Kemmer');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (67,88,'ComerBear','Tampflex','2023-01-21','Bergstrom, Carter and Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (28,44,'ComerBear','Stronghold','2023-02-09','D''Amore LLC');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (12,32,'ComerBear','Tresom','2022-11-12','Kuphal-Treutel');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (64,32,'Daltfresh','Flexidy','2023-04-04','Hyatt, Schaefer and Fisher');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (64,37,'Domainer','Redhold','2022-09-06','Hills-Kuhn');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Domainer','Bluehold','2022-06-17','Rau-Rowe');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Duo Lux','Solarbreeze','2022-07-16','Collins-Gorczany');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (46,97,'Duo Lux','Domainer','2023-02-07','Collins-Gorczany');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (62,66,'Duo Lux','Wathin','2022-05-07','Hills-Kuhn');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Duo Lux','Temp','2022-08-17','Hills-Kuhn');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (34,69,'Duo Lux','Toughjoyfax','2022-10-12','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Duo Lux','Softjoyfax','2022-09-21','Kuhn and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (99,78,'Flexidy','Zontrax','2022-08-27','Botsford, Cummerata and Waelchi');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (19,8,'Flexidy','Daltfresh','2022-11-09','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Flexidy','Letlux','2022-11-13','Christiansen, Turcotte and Romaguera');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Flexidy','It','2022-05-05','Howell, Turner and Parker');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Flexidy','Toughjoyfax','2022-06-24','Emmerich-Schinner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (40,79,'Flowdesk','Stronghold','2022-08-31','Hyatt, Schaefer and Fisher');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (55,31,'Flowdesk','Redhold','2022-10-12','Lebsack, Hoppe and Cormier');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Flowdesk','Perm','2022-11-29','Walsh and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Flowdesk','Flexidy','2022-12-04','Schaden-King');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (11,38,'Flowdesk','Lotlux','2023-02-25','Kuphal-Treutel');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (99,27,'It','Flowdesk','2023-01-31','Casper, Kautzer and Padberg');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (89,30,'It','Zoolab','2022-11-05','Casper, Kautzer and Padberg');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'It','Stronghold','2022-09-21','Boyle Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (42,87,'Keylex','Daltfresh','2022-05-10','Walsh and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (49,23,'Latlux','Wathin','2022-11-05','Baumbach, Mayert and Leannon');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (25,58,'Latlux','Domainer','2022-06-26','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (72,99,'Latlux','Redhold','2023-03-05','Kub and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (53,75,'Letlux','Zoolab','2022-09-21','Collins-Gorczany');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (96,4,'Letlux','Vagram','2022-07-19','Bradtke and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (45,62,'Lotlux','Stringtough','2022-08-02','Howell, Turner and Parker');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (15,69,'Lotlux','Biodex','2022-10-05','Howell, Turner and Parker');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Mar Lam Tam','Tampflex','2022-08-11','Casper, Kautzer and Padberg');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (74,46,'Mar Lam Tam','Stronghold','2022-07-24','Emmerich-Schinner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (64,6,'Mar Lam Tam','Flowdesk','2022-09-27','Bradtke and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (64,56,'Namfix','Perm','2023-03-28','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (72,95,'Namfix','ComerBear','2022-12-26','Towne-Douglas');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Perm','Tempsoft','2022-05-14','Christiansen, Turcotte and Romaguera');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (34,23,'Quo Lux','Toughjoyfax','2022-04-18','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (47,92,'Quo Lux','Redhold','2022-05-24','Christiansen, Turcotte and Romaguera');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (95,69,'Quo Lux','Tampflex','2023-01-12','D''Amore LLC');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Redhold','Namfix','2023-02-13','Christiansen, Turcotte and Romaguera');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Regrant','Redhold','2022-12-12','Mertz Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (98,24,'Regrant','Asoka','2023-01-28','Brekke-McKenzie');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (12,95,'Regrant','Keylex','2023-01-30','Boyle Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (98,4,'Ronstring','Treeflex','2022-06-22','Kunze, Kling and Welch');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (38,83,'Ronstring','Lotlux','2022-11-26','Bradtke and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Seagram','Duo Lux','2022-10-31','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Seagram','Duo Lux','2022-06-23','Zboncak-Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (95,59,'Softjoyfax','Biodex','2022-06-30','Zboncak-Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Solarbreeze','Namfix','2022-06-29','Kris, Robel and Nicolas');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (97,46,'Solarbreeze','Perm','2022-07-23','Baumbach, Mayert and Leannon');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Solarbreeze','Zontrax','2023-03-29','Purdy, Toy and Rath');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (82,19,'Solarbreeze','Alphazap','2022-09-11','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (54,51,'Stringtough','Wathin','2023-03-19','Collins-Gorczany');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (23,2,'Stronghold','Perm','2023-01-03','Hills-Kuhn');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (47,79,'Stronghold','Domainer','2022-11-02','Mertz Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (31,5,'Subin','Solarbreeze','2023-01-17','Botsford, Cummerata and Waelchi');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (34,52,'Subin','Duo Lux','2023-02-25','Kuphal-Treutel');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (2,94,'Subin','Biodex','2023-03-25','Towne-Douglas');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (16,2,'Subin','Domainer','2023-04-10','Kunze, Kling and Welch');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Tampflex','Daltfresh','2022-10-11','Mertz Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (92,44,'Temp','Yellowhold','2023-01-18','Zboncak-Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Toughjoyfax','Softjoyfax','2022-09-24','Mertz Group');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Toughjoyfax','Bluehold','2022-06-09','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Toughjoyfax','Vagram','2022-08-26','Kuhn and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Toughjoyfax','Daltfresh','2023-03-21','Boyle-Medhurst');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Treeflex','Domainer','2023-02-17','Zboncak-Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (34,55,'Treeflex','Toughjoyfax','2022-09-15','Homenick and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Treeflex','Tampflex','2023-04-15','Harber-Brekke');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (31,91,'Treeflex','Quo Lux','2023-02-16','Bins-Bosco');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (81,67,'Treeflex','Namfix','2022-07-05','Konopelski, Boyer and Kemmer');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Tresom','Tempsoft','2023-01-05','Emmerich-Schinner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Vagram','Namfix','2023-03-22','Kuhn and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (53,62,'Vagram','Duo Lux','2023-03-15','Hills-Kuhn');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Vagram','Softjoyfax','2023-01-25','Kris, Robel and Nicolas');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (76,26,'Ventosanzap','Asoka','2022-12-22','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (54,36,'Wathin','Treeflex','2022-06-25','Harber-Brekke');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Yellowhold','Tampflex','2022-07-07','Baumbach, Mayert and Leannon');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (62,41,'Yellowhold','Subin','2022-09-12','Nader-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Yellowhold','Asoka','2023-03-22','D''Amore LLC');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (11,21,'Zathin','Seagram','2023-01-21','Kuphal-Treutel');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (48,5,'Zathin','Subin','2023-02-25','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Zathin','Flowdesk','2022-05-14','Schaden-King');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Zathin','Biodex','2022-11-02','Nader-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Zontrax','Solarbreeze','2022-07-19','Zboncak-Oberbrunner');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (15,78,'Zontrax','Lotlux','2023-01-24','Grant-Corwin');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (NULL,NULL,'Zontrax','Flowdesk','2022-04-23','Baumbach, Mayert and Leannon');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (50,61,'Zoolab','Perm','2022-08-17','Kub and Sons');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (89,75,'Zoolab','Solarbreeze','2022-04-26','Daugherty-Torp');
INSERT INTO Game(home_score,away_score,home_team,away_team,game_date,venue) VALUES (37,93,'Zoolab','Stronghold','2022-06-17','Mertz Group');

INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Alpha','mhosier0',NULL,'skasper0',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Alphazap','sjillard1',NULL,NULL,NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Asoka','fhill2','wbaggarley2','edoutch2','criccio2');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Biodex',NULL,NULL,'ctroppmann3','ktoye3');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Bluehold','smorad4','apirrey4',NULL,'mreen4');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Daltfresh','rpennicott6',NULL,'ctopliss6',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Domainer','kcoverlyn7',NULL,'rfrenchum7',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Duo Lux','csangwin8','aselborne8',NULL,'bhoxey8');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Flexidy','njorck9','tkleimt9','dschettini9',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Flowdesk','ebeattya',NULL,'dautina','dgricea');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('It','jmerridayb','khoultonb',NULL,'hconradsenb');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Keylex',NULL,'dollivierc',NULL,'egalpenc');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Latlux','fhamblingtond','cdahlgrend',NULL,'mjennod');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Letlux','scorne','ebrauntere','emcarthure',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Lotlux','ndohertyf',NULL,'rjahnckef',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Mar Lam Tam','fghelarduccig',NULL,'wloyleyg',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Namfix','tcalveyi',NULL,'lroskrugei','rworralli');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Perm',NULL,'lvilliersj','apolandj','laxtellj');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Quo Lux','jmcgeek','agarbuttk','epollastrinok',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Redhold','mturfsl','twheeltonl','qweitzell',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Regrant','pboissierm','gbisphamm','cchristym','arandlesonm');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Ronstring','lmcpeicen','berdesn',NULL,'bkiffn');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Seagram','cwoolfo','dgillmoro','rweeko','dmillo');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Softjoyfax','agronop','abullockp','tvalderp','dalpinp');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Solarbreeze','vgendrichq','hmedhurstq','vattwoullq',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Stringtough','warpinor','kblissittr','krussamr','cduckettr');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Stronghold','imacknielys','acridlons',NULL,NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Subin','hkeedyt','alincolnt','chebront','bfairbrasst');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Tampflex','fleseku','hpellittu','csellyu',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Temp','dcolenuttv','kwaszkiewiczv','seggintonv','cbernettiv');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Tempsoft','cemanueliw','splowellw','vpaolillow',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Treeflex','ttyghty','mtarreny','ddorrinsy',NULL);
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Tresom','rjelksz','bshearsbyz','oadshadz','bmacvaughz');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Vagram','dburgoin10',NULL,NULL,'msnozzwell10');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Ventosanzap','egiercke11','cdunster11','kscolding11','lcomizzoli11');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Wathin','nullrich12','bbeernt12',NULL,'jkoschek12');
INSERT INTO SocialMedia(team_name,Twitter,Instagram,TikTok,Facebook) VALUES ('Yellowhold','cdencs13','apurser13','oelms13','mfeighry13');

INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Bryana','Stillgoe','Last Hard Men, The','Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','2022-11-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Heaney, Ankunding and Collier','Sonny','Tyhurst','Ripe','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.','2023-01-13');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Williamson, Nicolas and Adams','Padraic','Muris','Ghost Dog: The Way of the Samurai','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','2023-03-02');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Alfredo','Cappel','The King and Four Queens','Sed ante. Vivamus tortor. Duis mattis egestas metus.','2022-12-31');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Becker Inc','Corrinne','McQuirter','Flickering Lights (Blinkende lygter)','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','2022-07-31');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Harris-Gerhold','Rice','Stoaks','Up','Phasellus in felis. Donec semper sapien a libero. Nam dui.','2022-05-09');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Trantow-Jenkins','Tammy','Frazer','Lonely Hearts','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.','2022-11-26');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hartmann-Langworth','Stefania','Sink','Rare Exports: A Christmas Tale (Rare Exports)','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','2022-04-21');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Jacobson and Sons','Dael','Simm','Boy','In congue. Etiam justo. Etiam pretium iaculis justo.','2023-01-08');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Macejkovic and Sons','Beckie','McCreery','Play Girl','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','2022-07-01');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Suzi','Comizzoli','Ring of Darkness','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','2022-05-01');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Judon','Sprigings','Populaire','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','2023-03-15');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Dickinson-Marks','Baldwin','Gretton','Finding Bliss','Sed ante. Vivamus tortor. Duis mattis egestas metus.','2022-09-29');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Turcotte LLC','Annabell','Wakelam','Legend','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.','2022-12-28');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Brekke, Weber and Farrell','Gerri','Buttriss','Science and Islam','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.','2022-08-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Jast, Fadel and Jacobi','Hillery','Ody','Helsinki Napoli All Night Long','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.','2023-02-11');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hahn-Larson','Marcelia','Nenci','The Hungover Games','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.','2023-01-11');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Cristy','Koba','Madhouse','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','2022-11-04');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Oberbrunner-Frami','Callie','Bysh','Jackass 3D','In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.','2022-12-15');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Smith-Lockman','Reinold','McGonagle','Sushi Girl','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','2022-06-18');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Matthaeus','Melpuss','Life, Above All','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','2022-11-23');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Swift-Collier','Sylvan','Stephen','Little Thief, The (Le petit voleur)','Phasellus in felis. Donec semper sapien a libero. Nam dui.','2022-11-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Dasie','Lidierth','Taistelu Näsilinnasta 1918','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','2022-06-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('McLaughlin-Funk','Abagail','Rupprecht','Kandahar (Safar e Ghandehar)','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.','2023-02-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Koelpin-Von','Davin','Clingan','Sweet Nothing','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','2022-09-22');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Concordia','Handsheart','Producers, The','Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.','2022-11-08');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Herman-Runte','Charley','Aplin','Astronaut Farmer, The','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','2022-12-01');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Chastity','Mansell','Scary Movie 2','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','2022-06-05');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Sawayn, Prohaska and Roberts','Wini','Jahnig','De la servitude moderne','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','2022-08-09');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Bins LLC','Tootsie','McNiven','DuckTales: The Movie - Treasure of the Lost Lamp','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.','2023-03-02');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Ullrich-Rippin','Elwood','Baltrushaitis','Won''t Anybody Listen?','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','2022-07-06');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hettinger, Yost and Howe','Chester','Batterbee','Following','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','2022-07-11');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Yost-Shields','Bale','Cottell','Audrey Rose','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.','2022-04-26');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Sanford-Kemmer','Connie','Hacun','Indian Summer (a.k.a. The Professor) (La prima notte di quiete)','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','2022-07-28');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Watsica, Price and Mueller','Hilton','Clempton','Day Lincoln Was Shot, The','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','2022-08-18');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hilll LLC','Neddie','Leftbridge','Attack of the Giant Leeches','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.','2022-06-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('McKenzie LLC','Alta','McLarens','Acacia','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','2023-01-13');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hegmann, O''Connell and Gibson','Gregoire','Serjent','C''mon Man','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','2022-05-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('MacGyver, Von and Collier','Zita','Saffe','Hidden, The','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.','2023-02-24');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Artemus','Legier','Mommy','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','2022-07-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Blair','Pettegree','Texas Killing Fields','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','2022-08-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Parker-Lindgren','Hamnet','Kennermann','S.W.A.T.: Firefight','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','2023-01-26');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Daugherty LLC','Maddie','Selwyne','Power/Rangers','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.','2022-11-11');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Rooney','Binham','Wyvern','Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','2022-06-15');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Kiehn Inc','Lind','Cranstoun','Bekas','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.','2022-07-26');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hayes, Welch and Macejkovic','Martita','Kynan','Along Came Jones','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.','2022-08-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Ebert, Conn and Nienow','Sophie','Stenton','Jailbait','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.','2022-04-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'August','Gravells','Capricorn One','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.','2022-07-01');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Wendell','Purcer','Castle of Purity (El castillo de la pureza)','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','2022-10-30');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Rodolphe','Sutheran','Gozu (Gokudô kyôfu dai-gekijô: Gozu)','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','2022-06-12');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Jacinthe','Stanwix','Asterix and the Vikings (Astérix et les Vikings)','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.','2022-06-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Catrina','Callaway','Life After Tomorrow','Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','2022-08-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Katerina','Domengue','Other People''s Money','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.','2023-03-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Russel-Becker','Moria','Pirot','Elephants Dream','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.','2022-09-13');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Cello','Hoolaghan','Forgotten, The','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.','2022-09-07');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Nicolas, Pollich and Morissette','Justino','Dunstan','Gate of Hell (Jigokumon)','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','2022-12-04');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Torphy and Sons','Stephanus','Posen','Torque','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','2022-04-27');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hintz and Sons','Barbara','Joubert','Beat the Devil','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.','2022-10-29');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Neel','Fanton','Crawlspace','Phasellus in felis. Donec semper sapien a libero. Nam dui.','2022-05-09');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Koch, Schneider and Kshlerin','Genna','Endecott','Reuben, Reuben','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','2022-05-18');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Lindy','Bonniface','Soldier in the Rain','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.','2023-02-24');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Johnston-Hegmann','Myrtie','Dorney','Talk of Angels','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.','2022-07-29');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Kerluke and Sons','Keri','Clow','Only the Strong','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.','2022-04-20');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Jacqui','Gadeaux','Serving Sara','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.','2022-04-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Collins, Halvorson and Waters','Staci','Saffell','Night Moves','Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','2023-04-02');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Dru','Bartalin','Castle on the Hudson','In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.','2022-10-28');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Edita','Carthew','Elektra Luxx','In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.','2022-05-13');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Fahey and Sons','Abner','Moultrie','Big Knife, The','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','2022-05-23');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Helenelizabeth','Woolforde','Treasure Hunter, The (Ci ling)','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','2023-03-29');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Almeta','Ludy','Bill Maher: Victory Begins at Home','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','2023-03-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Harber, Leannon and Roob','Vivi','Husset','Madigan','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','2022-10-28');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Joni','Castlake','Dark Angel (I Come in Peace)','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','2023-03-16');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Abshire and Sons','Cammy','Binion','Miss Nobody','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','2022-10-21');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Sporer, Witting and Schoen','Ardyth','Biasini','Life and Times of Judge Roy Bean, The','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','2023-02-21');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Johnston, Sanford and Kertzmann','Duffy','Epinoy','Life of Another, The (La vie d''une autre)','Sed ante. Vivamus tortor. Duis mattis egestas metus.','2022-04-09');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Schultz, Dooley and Barton','Alexi','Hugues','S.F.W.','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','2022-06-25');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Keebler, Turcotte and Schamberger','Carley','Meachan','Man of a Thousand Faces','In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.','2022-09-18');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Normand','Reinger','July Rhapsody (Laam yan sei sap)','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.','2022-11-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Maryrose','Currer','Dead Zone, The','Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','2022-06-19');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Hegmann-Anderson','Mahalia','Devaney','Hardboiled Egg (Ovosodo)','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','2022-09-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Christiansen-Greenholt','Leah','Starking','Incredibly True Adventure of Two Girls in Love, The','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.','2022-05-22');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Berge, Breitenberg and Cartwright','Judon','Pasek','Botched','Fusce consequat. Nulla nisl. Nunc nisl.','2022-07-31');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Kirstin','Weaver','Lady for a Day','Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','2023-01-25');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Roob-Bins','Reggi','Raitie','Underworld','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','2022-04-28');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Leticia','Coope','Fearless Hyena, The (Xiao quan guai zhao)','Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','2022-11-20');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Henrietta','Searston','Getting Away With Murder','Sed ante. Vivamus tortor. Duis mattis egestas metus.','2022-09-29');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Kyla','Giovannelli','Some Body','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.','2023-01-16');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Sean','Ivasechko','The Emperor''s Candlesticks','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','2022-04-24');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Huel, Batz and Borer','Arri','Denkel','Our Children (À perdre la raison)','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','2022-06-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Lakin, Wilderman and Wolf','Cory','Whitaker','Tarnation','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','2022-05-14');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Wolff, Botsford and Reichel','Jory','Tonnesen','Adventures of Huck Finn, The','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','2022-07-07');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Filberto','Hindshaw','Conan the Barbarian','Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','2022-07-14');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Daugherty and Sons','Maxy','Grammer','Love and Bullets','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.','2022-07-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Adams','Shackell','Gayniggers From Outer Space','Phasellus in felis. Donec semper sapien a libero. Nam dui.','2022-10-21');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('McLaughlin and Sons','Donalt','Acutt','Witches, The','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.','2022-05-31');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES (NULL,'Archaimbaud','Eton','Snow White (Blancanieves)','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.','2022-10-19');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Kertzmann, Parker and Erdman','Simonette','Scurr','Quadrophenia','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','2022-11-10');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Zboncak, Howe and Bins','Pernell','Bartleet','Strong Man, The','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.','2022-09-17');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Predovic-Runolfsdottir','Byron','Crowter','Manual of Love 2 (Manuale d''amore (capitoli successivi))','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','2022-07-03');
INSERT INTO News(outlet,author_first,author_last,title,article_description,news_date) VALUES ('Baumbach Group','Osmond','Gomery','Holy Man','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','2023-01-11');

INSERT INTO Team_News(team_name,news_id) VALUES ('Daltfresh',73);
INSERT INTO Team_News(team_name,news_id) VALUES ('Latlux',76);
INSERT INTO Team_News(team_name,news_id) VALUES ('Biodex',16);
INSERT INTO Team_News(team_name,news_id) VALUES ('Lotlux',40);
INSERT INTO Team_News(team_name,news_id) VALUES ('Tempsoft',70);
INSERT INTO Team_News(team_name,news_id) VALUES ('Stringtough',62);
INSERT INTO Team_News(team_name,news_id) VALUES ('Keylex',38);
INSERT INTO Team_News(team_name,news_id) VALUES ('Keylex',89);
INSERT INTO Team_News(team_name,news_id) VALUES ('Duo Lux',72);
INSERT INTO Team_News(team_name,news_id) VALUES ('Zoolab',44);
INSERT INTO Team_News(team_name,news_id) VALUES ('Latlux',74);
INSERT INTO Team_News(team_name,news_id) VALUES ('Vagram',59);
INSERT INTO Team_News(team_name,news_id) VALUES ('Duo Lux',62);
INSERT INTO Team_News(team_name,news_id) VALUES ('ComerBear',20);
INSERT INTO Team_News(team_name,news_id) VALUES ('Namfix',6);
INSERT INTO Team_News(team_name,news_id) VALUES ('Biodex',32);
INSERT INTO Team_News(team_name,news_id) VALUES ('ComerBear',5);
INSERT INTO Team_News(team_name,news_id) VALUES ('Letlux',5);
INSERT INTO Team_News(team_name,news_id) VALUES ('Alpha',70);
INSERT INTO Team_News(team_name,news_id) VALUES ('ComerBear',15);
INSERT INTO Team_News(team_name,news_id) VALUES ('Treeflex',81);
INSERT INTO Team_News(team_name,news_id) VALUES ('Mar Lam Tam',63);
INSERT INTO Team_News(team_name,news_id) VALUES ('Asoka',80);
INSERT INTO Team_News(team_name,news_id) VALUES ('Domainer',28);
INSERT INTO Team_News(team_name,news_id) VALUES ('Softjoyfax',98);
INSERT INTO Team_News(team_name,news_id) VALUES ('Domainer',75);
INSERT INTO Team_News(team_name,news_id) VALUES ('Mat Lam Tam',95);
INSERT INTO Team_News(team_name,news_id) VALUES ('Bluehold',7);
INSERT INTO Team_News(team_name,news_id) VALUES ('Duo Lux',25);
INSERT INTO Team_News(team_name,news_id) VALUES ('Ronstring',10);
INSERT INTO Team_News(team_name,news_id) VALUES ('It',84);
INSERT INTO Team_News(team_name,news_id) VALUES ('Redhold',19);
INSERT INTO Team_News(team_name,news_id) VALUES ('Regrant',37);
INSERT INTO Team_News(team_name,news_id) VALUES ('Ronstring',55);
INSERT INTO Team_News(team_name,news_id) VALUES ('Subin',77);
INSERT INTO Team_News(team_name,news_id) VALUES ('Quo Lux',25);
INSERT INTO Team_News(team_name,news_id) VALUES ('Regrant',98);
INSERT INTO Team_News(team_name,news_id) VALUES ('Perm',67);
INSERT INTO Team_News(team_name,news_id) VALUES ('Flowdesk',46);
INSERT INTO Team_News(team_name,news_id) VALUES ('Subin',42);

INSERT INTO Player_News(player_id,news_id) VALUES (126,77);
INSERT INTO Player_News(player_id,news_id) VALUES (598,40);
INSERT INTO Player_News(player_id,news_id) VALUES (40,62);
INSERT INTO Player_News(player_id,news_id) VALUES (571,97);
INSERT INTO Player_News(player_id,news_id) VALUES (329,89);
INSERT INTO Player_News(player_id,news_id) VALUES (250,52);
INSERT INTO Player_News(player_id,news_id) VALUES (170,4);
INSERT INTO Player_News(player_id,news_id) VALUES (385,17);
INSERT INTO Player_News(player_id,news_id) VALUES (125,45);
INSERT INTO Player_News(player_id,news_id) VALUES (95,97);
INSERT INTO Player_News(player_id,news_id) VALUES (94,7);
INSERT INTO Player_News(player_id,news_id) VALUES (165,76);
INSERT INTO Player_News(player_id,news_id) VALUES (36,66);
INSERT INTO Player_News(player_id,news_id) VALUES (454,88);
INSERT INTO Player_News(player_id,news_id) VALUES (494,35);
INSERT INTO Player_News(player_id,news_id) VALUES (129,89);
INSERT INTO Player_News(player_id,news_id) VALUES (592,4);
INSERT INTO Player_News(player_id,news_id) VALUES (106,64);
INSERT INTO Player_News(player_id,news_id) VALUES (254,77);
INSERT INTO Player_News(player_id,news_id) VALUES (550,90);
INSERT INTO Player_News(player_id,news_id) VALUES (29,51);
INSERT INTO Player_News(player_id,news_id) VALUES (181,72);
INSERT INTO Player_News(player_id,news_id) VALUES (477,16);
INSERT INTO Player_News(player_id,news_id) VALUES (584,60);
INSERT INTO Player_News(player_id,news_id) VALUES (220,4);
INSERT INTO Player_News(player_id,news_id) VALUES (487,52);
INSERT INTO Player_News(player_id,news_id) VALUES (238,86);
INSERT INTO Player_News(player_id,news_id) VALUES (500,21);
INSERT INTO Player_News(player_id,news_id) VALUES (416,34);
INSERT INTO Player_News(player_id,news_id) VALUES (131,1);
INSERT INTO Player_News(player_id,news_id) VALUES (302,49);
INSERT INTO Player_News(player_id,news_id) VALUES (386,16);
INSERT INTO Player_News(player_id,news_id) VALUES (150,37);
INSERT INTO Player_News(player_id,news_id) VALUES (240,55);
INSERT INTO Player_News(player_id,news_id) VALUES (310,5);
INSERT INTO Player_News(player_id,news_id) VALUES (41,63);
INSERT INTO Player_News(player_id,news_id) VALUES (67,78);
INSERT INTO Player_News(player_id,news_id) VALUES (69,59);
INSERT INTO Player_News(player_id,news_id) VALUES (474,7);
INSERT INTO Player_News(player_id,news_id) VALUES (386,3);

INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Sybyl','Mendes','smendes0@gov.uk','311-206-5878','Kuphal-Schamberger',75);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Elisha','Sautter','esautter0@nba.com','222-709-7837','Abernathy-Baumbach',409);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Donal','Seller','dseller1@liveinternet.ru','644-158-7191','Mohr Inc',581);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Ellerey','Faunch','efaunch2@spiegel.de','635-928-9655','Hoppe Group',90);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Luis','Pretious','lpretious3@fda.gov','641-243-6515','Jenkins Group',278);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Blisse','Houliston','bhouliston4@weather.com','887-311-3246','Greenfelder Inc',6);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Worthington','Rawlcliffe','wrawlcliffe5@etsy.com','302-560-9872',NULL,106);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Garnette','Rhymer','grhymer6@is.gd','776-396-3041','Shields, Schneider and Weimann',45);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Victoir','Mannie','vmannie7@japanpost.jp','528-200-4639','Roob, Grimes and O''Reilly',341);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Kellina','Rudram','krudram8@berkeley.edu','540-423-4395','Stehr-Koch',291);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Perceval','Raspison','praspison9@gmpg.org','934-669-7444','Vandervort, McDermott and Marvin',489);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Yorgos','Muspratt','ymuspratta@biglobe.ne.jp','418-171-4387','Gottlieb, Rosenbaum and Krajcik',506);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Isabelita','Skelington','iskelingtonb@yelp.com','405-105-9473',NULL,421);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Clair','Capozzi','ccapozzic@ameblo.jp','150-281-8284','Daniel, McCullough and Schroeder',439);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Edie','Gold','egoldd@comsenz.com','589-988-9131','Klocko LLC',202);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Rheta','Vanes','rvanese@wisc.edu','566-212-7386','Reichert-Powlowski',74);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Ronalda','Biaggioli','rbiaggiolif@discovery.com','100-600-4249','Borer, Fritsch and Franecki',435);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Helge','Daville','hdavilleg@hibu.com','385-747-0580',NULL,511);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Dorice','Pietron','dpietronh@homestead.com','459-684-2928','Medhurst, Bernhard and Block',62);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Ronna','McQuaker','rmcquakeri@1688.com','849-575-8268','Gleichner-Tremblay',195);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Federica','Cornes','fcornesj@wordpress.com','290-213-2282','Pfannerstill LLC',262);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Violette','Kretschmer','vkretschmerk@slashdot.org','576-105-3006','Ortiz, Runte and Gorczany',116);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Lek','Mumbey','lmumbeyl@hp.com','630-885-1310','Kuphal-Frami',406);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Waly','McCurtin','wmccurtinm@shinystat.com','648-903-9912','Lockman, Effertz and Schowalter',240);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Vannie','Barthot','vbarthotn@oakley.com','142-932-6292','McLaughlin-Lockman',305);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Lydia','Medmore','lmedmoreo@aol.com','930-137-1071','Bednar LLC',448);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Rivy','Challin','rchallinp@omniture.com','370-864-7860','Torp-Smith',379);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Hardy','Weaving','hweavingq@yellowbook.com','783-748-5701',NULL,286);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Stesha','Gillott','sgillottr@zimbio.com','202-658-1758','Kassulke LLC',76);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Agnesse','Smeaton','asmeatons@nsw.gov.au','718-404-1636','Larson LLC',521);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Moira','Cottis','mcottist@unicef.org','578-867-8776','Schmitt, Doyle and Barrows',513);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Vitoria','Leckie','vleckieu@youtu.be','770-987-6448','Jenkins and Sons',546);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Cati','Cranstone','ccranstonev@wunderground.com','333-710-3200','Howe-Mosciski',183);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Pattin','Fulleylove','pfulleylovew@imageshack.us','175-288-2754','MacGyver-Barton',219);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Dynah','Pitkins','dpitkinsx@ox.ac.uk','665-231-6913','Kuhn, Williamson and Bechtelar',254);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Mort','Werrett','mwerretty@msu.edu','142-359-5678','Shields Group',417);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Parker','Warcop','pwarcopz@skype.com','180-616-3453','Rowe, Ratke and Connelly',412);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Marcia','O''Brogan','mobrogan10@boston.com','750-134-3791',NULL,124);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Reynard','Ladson','rladson11@amazonaws.com','474-745-3913','Witting and Sons',3);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Clemmy','Welsby','cwelsby12@desdev.cn','515-604-6894','Frami, Douglas and Hudson',594);
INSERT INTO Agent(first_name,last_name,email,phone,company,player_id) VALUES ('Cele','Galbreath','cgalbreath13@wordpress.com','891-814-8275','Kohler Inc',30);

INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Arv','Rimour','2022-05-10',35,432191,'Treeflex');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Brianna','McCurtain','2023-02-23',42,698439,'Zontrax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Dino','Allery','2022-08-02',61,347153,'Alphazap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Valry','MacDaid','2023-02-23',44,830652,'Letlux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Alfie','Howlings','2022-12-16',52,808376,'Toughjoyfax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Reynolds','Hatz','2023-02-21',33,258112,'Letlux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Aluin','Koubek','2023-03-03',76,310924,'Bluehold');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Cicily','Linzey','2022-10-19',33,795086,'Keylex');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Gasparo','Ketteringham','2023-02-22',67,643518,'Letlux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Missy','Clampe','2022-08-11',51,209943,'Stronghold');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Mara','Gyenes','2022-11-09',47,321434,'Ventosanzap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Dame','Chittie','2022-11-22',59,992342,'Domainer');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Prisca','Galtone','2023-01-07',64,486929,'Bluehold');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Farrell','Reeday','2022-09-22',35,333292,'Perm');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Esther','Ivashov','2022-06-01',65,244368,'Ventosanzap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Julina','Kiraly','2022-10-08',66,724296,'Ronstring');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Philis','Stoker','2022-10-14',72,369858,'Toughjoyfax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Leelah','Dawtre','2022-07-26',75,937471,'Mat Lam Tam');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Rayshell','Imison','2022-07-30',74,180739,'Zathin');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Jamil','Basford','2022-09-01',51,332628,'Flowdesk');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Fielding','Wiles','2022-09-24',42,163509,'Zoolab');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Mauricio','Yole','2022-04-16',45,744688,'Toughjoyfax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Damon','Wallbutton','2022-08-08',47,121434,'Flowdesk');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Kiele','Kettles','2022-10-27',52,712389,'Ventosanzap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Eileen','Blanpein','2022-11-07',36,122530,'Quo Lux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Evvy','Frew','2023-01-25',76,961535,'Seagram');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Lisabeth','Cressey','2022-11-27',79,788857,'Wathin');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Jason','Osler','2022-10-08',39,304152,'Stringtough');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Orsa','Fonte','2022-09-13',44,625834,'Quo Lux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Hasty','Dewick','2022-12-14',74,160760,'Tempsoft');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Garrott','Mussalli','2022-05-31',47,248393,'Alphazap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Armstrong','Timberlake','2022-05-23',33,181045,'Toughjoyfax');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Ruperto','Fleet','2022-08-29',48,947368,'Mar Lam Tam');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Raimondo','Streat','2022-08-11',35,506900,'Zoolab');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Cam','Bowie','2023-03-31',44,928642,'Ventosanzap');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Charleen','Romand','2023-02-03',78,922778,'Lotlux');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Jade','Matyushonok','2023-02-27',50,98242,'Yellowhold');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Diarmid','d'' Elboux','2022-06-29',68,160114,'Stringtough');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Olag','McCreagh','2023-04-05',80,315752,'Redhold');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Bobby','Meaddowcroft','2022-06-10',74,726637,'Seagram');
INSERT INTO Manager(first_name,last_name,contract_end_date,age,salary,team_name) VALUES ('Tim','Haresnape','2023-03-09',75,181697,'Zoolab');

INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Carter','Cokly',36,'919-702-5432','ccokly0@globo.com','Alphazap');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Howard','Ivan',56,'855-878-0845','hivan1@trellian.com','Alphazap');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Christophorus','Brunroth',33,'936-476-9342','cbrunroth2@cocolog-nifty.com','Asoka');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Hanan','Dovington',30,'671-182-0263','hdovington3@hugedomains.com','Zontrax');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Kelsi','Suerz',59,'113-272-5329','ksuerz4@last.fm','Namfix');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Eugenie','Johnke',43,'400-343-1321','ejohnke5@skyrock.com','Vagram');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Nevile','Girtin',88,'971-440-1852','ngirtin6@msu.edu','Stringtough');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Buddy','Revey',84,'709-149-5357','brevey7@wunderground.com','Keylex');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Laurie','O''Carran',99,'115-236-5160','locarran8@home.pl','Wathin');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Mahmoud','Emney',83,'935-434-8577','memney9@goodreads.com','Duo Lux');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Klement','Windross',71,'854-833-2856','kwindrossa@etsy.com','Redhold');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Lenee','Milkin',39,'852-809-6450','lmilkinb@seattletimes.com','Subin');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Curtice','Maps',59,'369-282-3403','cmapsc@miibeian.gov.cn','Ronstring');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Katrinka','Kirkbride',48,'786-816-2995','kkirkbrided@yahoo.co.jp','Toughjoyfax');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Berkie','Greenrodd',99,'810-197-4176','bgreenrodde@dot.gov','Tresom');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Ase','Petroff',55,'183-737-8903','apetrofff@google.pl','Wathin');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Taber','McCree',49,'406-783-1895','tmccreeg@globo.com','Temp');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Dall','Letcher',72,'951-405-5106','dletcherh@google.fr','Alphazap');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Torrance','Kubat',65,'148-806-9354','tkubati@tripadvisor.com','Stringtough');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Billi','Mathews',79,'506-108-5633','bmathewsj@vinaora.com','Daltfresh');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Cilka','Feldstein',31,'823-336-0696','cfeldsteink@yale.edu','Redhold');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Sapphire','Gouldstone',59,'753-758-2184','sgouldstonel@ed.gov','Mar Lam Tam');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Shanan','Brattan',41,'185-429-3493','sbrattanm@state.gov','Namfix');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Kalvin','Berggren',86,'325-924-5642','kberggrenn@oakley.com','Domainer');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Lincoln','Wild',63,'578-954-1911','lwildo@discovery.com','Biodex');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Rosalinde','Givens',80,'311-138-3437','rgivensp@nyu.edu','It');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Ralph','Joerning',55,'520-753-7186','rjoerningq@booking.com','Softjoyfax');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Mira','Rolfini',93,'849-907-1783','mrolfinir@mail.ru','Seagram');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Si','Tommis',80,'375-510-4264','stommiss@1688.com','Quo Lux');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Raviv','Cloney',71,'253-874-0238','rcloneyt@nps.gov','Stringtough');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Jeremiah','Charlon',81,'890-808-9899','jcharlonu@pcworld.com','Lotlux');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Mariam','Grimditch',66,'317-718-5325','mgrimditchv@bigcartel.com','Ronstring');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Joan','Rosenauer',59,'153-741-5152','jrosenauerw@army.mil','Perm');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Bartlet','Spikins',27,'658-761-4566','bspikinsx@ucla.edu','Vagram');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Ileana','Diack',63,'806-498-9243','idiacky@storify.com','Namfix');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Claudette','Zamora',73,'620-543-1856','czamoraz@sourceforge.net','Namfix');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Chick','Clemendet',69,'338-768-5249','cclemendet10@google.com.au','Wathin');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Ernestine','Deners',77,'373-152-3105','edeners11@google.ca','Alphazap');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Shanan','Kleingrub',34,'477-222-3628','skleingrub12@mail.ru','Tempsoft');
INSERT INTO CEO(first_name,last_name,age,phone,email,team_name) VALUES ('Tracee','Dabels',66,'319-124-9126','tdabels13@liveinternet.ru','Tresom');
