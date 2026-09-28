CREATE DATABASE netflix_analytics;

USE netflix_analytics;

-- =========================
-- NETFLIX CONTENT TABLE
-- =========================

CREATE TABLE netflix_content (
    show_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content_type VARCHAR(20) NOT NULL,
    director VARCHAR(255),
    country VARCHAR(255),
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    duration INT,
    duration_unit VARCHAR(20),
    listed_in VARCHAR(255),
    description TEXT
);

-- =========================
-- INSERT SAMPLE DATA
-- =========================

INSERT INTO netflix_content
(show_id, title, content_type, director, country, date_added,
 release_year, rating, duration, duration_unit, listed_in, description)
VALUES

(1,'Stranger Things','TV Show','The Duffer Brothers','United States',
'2021-07-15',2016,'TV-14',4,'Seasons',
'International TV Shows, TV Dramas, Teen TV Shows',
'Kids uncover supernatural mysteries in their town.'),

(2,'Money Heist','TV Show','Alex Pina','Spain',
'2021-09-01',2017,'TV-MA',5,'Seasons',
'Crime TV Shows, International TV Shows, TV Thrillers',
'A criminal mastermind plans major heists.'),

(3,'The Crown','TV Show','Peter Morgan','United Kingdom',
'2020-11-20',2016,'TV-MA',6,'Seasons',
'British TV Shows, International TV Shows, TV Dramas',
'Historical drama about the British royal family.'),

(4,'Wednesday','TV Show','Tim Burton','United States',
'2022-11-23',2022,'TV-14',1,'Season',
'TV Comedies, Teen TV Shows, TV Dramas',
'A dark comedy following Wednesday Addams.'),

(5,'Breaking Bad','TV Show','Vince Gilligan','United States',
'2019-06-10',2008,'TV-MA',5,'Seasons',
'Crime TV Shows, TV Dramas',
'A chemistry teacher enters the criminal world.'),

(6,'Dark','TV Show','Baran bo Odar','Germany',
'2020-05-15',2017,'TV-MA',3,'Seasons',
'International TV Shows, TV Dramas, TV Mysteries',
'A mystery involving time travel and family secrets.'),

(7,'Squid Game','TV Show','Hwang Dong-hyuk','South Korea',
'2021-09-17',2021,'TV-MA',1,'Season',
'International TV Shows, Korean TV Shows, TV Thrillers',
'Contestants compete in deadly games for money.'),

(8,'The Witcher','TV Show','Lauren Schmidt Hissrich','United States',
'2021-12-17',2019,'TV-MA',3,'Seasons',
'International TV Shows, TV Dramas, Fantasy',
'A monster hunter travels through a dangerous world.'),

(9,'Stranger Things 4','TV Show','The Duffer Brothers','United States',
'2022-07-01',2022,'TV-14',1,'Season',
'TV Dramas, Teen TV Shows, TV Horror',
'The group faces a powerful new supernatural threat.'),

(10,'Peaky Blinders','TV Show','Steven Knight','United Kingdom',
'2022-06-10',2013,'TV-MA',6,'Seasons',
'British TV Shows, Crime TV Shows, TV Dramas',
'A gangster family builds its criminal empire.'),

(11,'Red Notice','Movie','Rawson Marshall Thurber','United States',
'2021-11-12',2021,'PG-13',118,'Minutes',
'Action & Adventure, Comedies',
'An FBI agent works with an art thief.'),

(12,'Extraction','Movie','Sam Hargrave','United States',
'2020-04-24',2020,'R',117,'Minutes',
'Action & Adventure, Thrillers',
'A mercenary is hired for a dangerous rescue.'),

(13,'Bird Box','Movie','Susanne Bier','United States',
'2020-01-01',2018,'R',124,'Minutes',
'International Movies, Thrillers',
'A woman protects her children from an unseen threat.'),

(14,'Enola Holmes','Movie','Harry Bradbeer','United Kingdom',
'2020-09-23',2020,'PG-13',123,'Minutes',
'Action & Adventure, Children & Family Movies',
'A young detective searches for her missing mother.'),

(15,'The Gray Man','Movie','Anthony Russo, Joe Russo','United States',
'2022-07-22',2022,'PG-13',129,'Minutes',
'Action & Adventure, Thrillers',
'A skilled CIA operative becomes hunted.'),

(16,'RRR','Movie','S. S. Rajamouli','India',
'2022-05-20',2022,'TV-14',182,'Minutes',
'Action & Adventure, International Movies',
'Two revolutionaries form an unexpected friendship.'),

(17,'Dangal','Movie','Nitesh Tiwari','India',
'2021-08-15',2016,'TV-14',161,'Minutes',
'International Movies, Sports Movies',
'A father trains his daughters to become wrestlers.'),

(18,'3 Idiots','Movie','Rajkumar Hirani','India',
'2021-06-01',2009,'PG-13',170,'Minutes',
'Comedies, Dramas, International Movies',
'Three engineering students experience college life.'),

(19,'KGF Chapter 1','Movie','Prashanth Neel','India',
'2022-01-10',2018,'TV-14',156,'Minutes',
'Action & Adventure, International Movies',
'A man rises through the ranks of a gold mining empire.'),

(20,'Jawan','Movie','Atlee','India',
'2023-11-02',2023,'TV-14',169,'Minutes',
'Action & Adventure, International Movies',
'A man confronts corruption and injustice.'),

(21,'Parasite','Movie','Bong Joon Ho','South Korea',
'2020-02-10',2019,'R',132,'Minutes',
'International Movies, Dramas',
'A poor family becomes involved with a wealthy household.'),

(22,'Train to Busan','Movie','Yeon Sang-ho','South Korea',
'2019-12-10',2016,'TV-MA',118,'Minutes',
'International Movies, Horror Movies',
'Passengers fight to survive a zombie outbreak.'),

(23,'Your Name','Movie','Makoto Shinkai','Japan',
'2020-04-01',2016,'TV-PG',106,'Minutes',
'Anime Features, International Movies',
'Two teenagers mysteriously exchange bodies.'),

(24,'Spirited Away','Movie','Hayao Miyazaki','Japan',
'2020-01-15',2001,'PG',125,'Minutes',
'Anime Features, Children & Family Movies',
'A girl enters a mysterious spirit world.'),

(25,'The Social Network','Movie','David Fincher','United States',
'2019-10-10',2010,'PG-13',120,'Minutes',
'Dramas',
'A drama about the creation of a social network.'),

(26,'The Irishman','Movie','Martin Scorsese','United States',
'2019-11-27',2019,'R',209,'Minutes',
'Dramas, Crime Movies',
'A veteran reflects on his involvement with organized crime.'),

(27,'Roma','Movie','Alfonso Cuaron','Mexico',
'2018-12-14',2018,'R',135,'Minutes',
'Dramas, International Movies',
'A family story set in Mexico City.'),

(28,'Lupin','TV Show','Louis Leterrier','France',
'2021-01-08',2021,'TV-MA',3,'Seasons',
'Crime TV Shows, International TV Shows',
'A gentleman thief seeks revenge.'),

(29,'Narcos','TV Show','Chris Brancato','United States',
'2019-08-28',2015,'TV-MA',3,'Seasons',
'Crime TV Shows, TV Dramas',
'A crime drama based on drug trafficking.'),

(30,'Bridgerton','TV Show','Chris Van Dusen','United States',
'2022-03-25',2020,'TV-MA',3,'Seasons',
'Romantic TV Shows, TV Dramas',
'A period drama about love and society.');
