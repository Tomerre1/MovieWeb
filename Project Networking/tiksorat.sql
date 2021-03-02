CREATE TABLE Movies (
    movie_image varchar(1000),
	movie_description nvarchar(1000),
	movieName nvarchar(30),
	price integer,
	prev_price integer,
	category varchar(30),
	age integer,
   	PRIMARY KEY (movieName)
);
SELECT * FROM Movies;
DROP Table movies;


CREATE TABLE tblUser (
    FirstName nvarchar(15),
	LastName nvarchar(15),
	UserName nvarchar(15),
	UserEmail nvarchar(50),
	UserPassword nvarchar(15),
	UserID nvarchar(15),
	UserPhone nvarchar(12),
   	PRIMARY KEY (UserID)
);
SELECT * FROM tblUser;
INSERT INTO tblUser VALUES('tomer','revah','admin','tomerre1@ac.sce.ac.il','admin','205775083','0503031330');


DROP Table tblUser;

INSERT INTO Movies VALUES('https://downloadwap.com/thumbs4/games/preview/2020d/img/361934_x-men_3_the_last_st_1.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','X-MAN',55,55,'Sci-Fi',13);
INSERT INTO Movies VALUES('https://images-na.ssl-images-amazon.com/images/I/51zXl9vpoxL._SY445_.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','SpiderMan 2',50,50,'Sci-Fi',13);
INSERT INTO Movies VALUES('https://images-na.ssl-images-amazon.com/images/I/51tQzS5jp1L._SY445_.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','SpiderMan 3',50,50,'Sci-Fi',13);
INSERT INTO Movies VALUES('https://i.ebayimg.com/images/g/pR0AAOSwsZJadJ42/s-l400.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Valkyrie',60,60,'Action',18);
INSERT INTO Movies VALUES('https://images-na.ssl-images-amazon.com/images/I/51XQKPC010L._AC_.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Gladiator',60,60,'Action',18);
INSERT INTO Movies VALUES('https://www.picclickimg.com/d/l400/pict/133561993468_/Ice-Age-DVD-2006-2-Disc-Set-Super-Cool.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','The Ice Age',30,30,'Cartoon',6);
INSERT INTO Movies VALUES('https://i2.wp.com/www.movie2thai.com/wp-content/uploads/2018/08/bgSHbGEA1OM6qDs3Qba4VlSZsNG.jpg?resize=185%2C278&ssl=1','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Transformers',45,45,'Sci-Fi',13);
INSERT INTO Movies VALUES('https://comicattack.net//wp-content/uploads/2010/06/xmen-magneto-testament-1.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Magneto',50,50,'Sci-Fi',13);
INSERT INTO Movies VALUES('https://cdn.shopify.com/s/files/1/0037/8008/3782/products/kung_fu_panda_ds_os.jpg?v=1607029357','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Transformers',45,45,'Action',13);
INSERT INTO Movies VALUES('https://cdn.shopify.com/s/files/1/0037/8008/3782/products/kung_fu_panda_ds_os.jpg?v=1607029357','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Kung Fu Panda',30,30,'Cartoon',6);
INSERT INTO Movies VALUES('https://images-na.ssl-images-amazon.com/images/I/91mo0eJCv%2BL._SL1500_.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Eagle Eye',60,60,'Action',13);
INSERT INTO Movies VALUES('https://d3rwyinxzcqr6y.cloudfront.net/Assets/22/177/L_p0014317722.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Narnia',40,40,'Action',13);
INSERT INTO Movies VALUES('https://pbs.twimg.com/media/CkjtBskUYAAv84d.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Angels & Demons',65,65,'Thriller',18);
INSERT INTO Movies VALUES('https://www.rarefilmfinder.com/covers/big/34266.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','House',65,65,'Horror',18);
INSERT INTO Movies VALUES('https://marcfusioncom.files.wordpress.com/2019/03/vacancy.jpg?w=300','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Vacancy',65,65,'Horror',18);
INSERT INTO Movies VALUES('https://i.pinimg.com/originals/aa/87/f3/aa87f3455c451cd401f0791f8c92b7a4.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Mirrors',70,70,'Horror',18);
INSERT INTO Movies VALUES('https://the-netflix-review.com/wp-content/uploads/2019/01/the-kingdom-dvd-cover.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','The Kingdom',45,45,'Action',16);
INSERT INTO Movies VALUES('https://images.m4ufree.fun/asset/23000/motives-2004.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','Motives',55,25,'Thriller',18);
INSERT INTO Movies VALUES('https://i.pinimg.com/474x/d9/b2/59/d9b25930affd25596b990d05f6a82a20.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui vivamus arcu felis bibendum. Scelerisque eu ultrices vitae auctor eu. Quis lectus nulla at volutpat diam ut venenatis tellus in. Pharetra massa massa ultricies mi. Non blandit massa enim nec dui nunc mattis enim ut. Vitae tortor condimentum lacinia quis vel eros donec. In pellentesque massa placerat duis ultricies lacus sed. Eget mauris pharetra et ultrices. Auctor elit sed vulputate mi sit amet mauris commodo. Lectus sit amet est placerat in. Mus mauris vitae ultricies leo integer.','The Prestige',55,40,'Thriller',18);

CREATE TABLE Dates (
	movieName nvarchar(30),
	movie_date nvarchar(30),
	movie_time varchar(30),
	hall varchar(10),
   	PRIMARY KEY (movie_date,movie_time,hall)
);
SELECT * FROM Dates;
DROP Table Dates;


INSERT INTO Dates VALUES('X-MAN','2019-02-01','11:30','1');

INSERT INTO Dates VALUES('X-MAN','2021-02-01','11:30','1');
INSERT INTO Dates VALUES('X-MAN','2021-02-01','15:00','1');
INSERT INTO Dates VALUES('X-MAN','2021-02-02','18:30','2');
INSERT INTO Dates VALUES('X-MAN','2021-02-02','14:40','1');
INSERT INTO Dates VALUES('X-MAN','2021-02-02','14:30','2');
INSERT INTO Dates VALUES('X-MAN','2021-02-04','19:30','2');
INSERT INTO Dates VALUES('X-MAN','2021-02-04','21:00','2');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-01','12:00','7');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-01','08:00','7');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-01','09:00','6');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-01','17:00','7');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-01','12:00','6');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-02','16:00','7');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-03','12:00','5');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-03','12:00','4');
INSERT INTO Dates VALUES('SpiderMan 2','2021-02-04','11:30','7');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-01','13:00','1');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-02','17:00','3');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-02','09:30','3');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-02','20:50','2');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-03','22:00','1');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-06','21:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-02','10:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-02','12:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-02','14:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-03','19:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-03','22:00','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-03','22:30','5');
INSERT INTO Dates VALUES('Valkyrie','2021-02-04','13:30','4');
INSERT INTO Dates VALUES('Valkyrie','2021-02-04','16:20','4');
INSERT INTO Dates VALUES('Gladiator','2021-02-01','16:40','5');
INSERT INTO Dates VALUES('Gladiator','2021-02-02','12:50','5');
INSERT INTO Dates VALUES('Gladiator','2021-02-02','16:50','5');
INSERT INTO Dates VALUES('Gladiator','2021-02-03','17:00','5');
INSERT INTO Dates VALUES('Gladiator','2021-02-03','17:30','6');
INSERT INTO Dates VALUES('Gladiator','2021-02-04','16:20','5');
INSERT INTO Dates VALUES('Gladiator','2021-02-05','11:20','5');
INSERT INTO Dates VALUES('The Ice Age','2021-02-01','12:00','6');
INSERT INTO Dates VALUES('The Ice Age','2021-02-01','14:50','7');
INSERT INTO Dates VALUES('The Ice Age','2021-02-02','18:20','5');
INSERT INTO Dates VALUES('The Ice Age','2021-02-03','20:20','8');
INSERT INTO Dates VALUES('The Ice Age','2021-02-03','22:20','8');
INSERT INTO Dates VALUES('The Ice Age','2021-02-03','18:20','8');
INSERT INTO Dates VALUES('The Ice Age','2021-02-04','19:20','7');
INSERT INTO Dates VALUES('The Ice Age','2021-02-05','15:50','7');
INSERT INTO Dates VALUES('The Ice Age','2021-02-05','17:30','6');
INSERT INTO Dates VALUES('The Ice Age','2021-02-06','11:20','3');
INSERT INTO Dates VALUES('Transformers','2021-02-07','10:00','1');
INSERT INTO Dates VALUES('Transformers','2021-02-07','12:30','1');
INSERT INTO Dates VALUES('Transformers','2021-02-07','13:00','2');
INSERT INTO Dates VALUES('Transformers','2021-02-08','10:00','2');
INSERT INTO Dates VALUES('Transformers','2021-02-08','11:00','1');
INSERT INTO Dates VALUES('Transformers','2021-02-09','21:30','3');
INSERT INTO Dates VALUES('Transformers','2021-02-09','23:00','3');
INSERT INTO Dates VALUES('Magneto','2021-02-07','14:20','1');
INSERT INTO Dates VALUES('Magneto','2021-02-07','17:20','1');
INSERT INTO Dates VALUES('Magneto','2021-02-07','19:00','2');
INSERT INTO Dates VALUES('Magneto','2021-02-08','13:10','1');
INSERT INTO Dates VALUES('Magneto','2021-02-08','14:20','2');
INSERT INTO Dates VALUES('Magneto','2021-02-09','09:20','1');
INSERT INTO Dates VALUES('Magneto','2021-02-09','10:20','3');
INSERT INTO Dates VALUES('Magneto','2021-02-09','11:20','1');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-07','08:20','4');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-07','08:30','3');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-07','10:50','4');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-08','13:30','3');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-08','15:00','3');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-08','17:40','3');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-08','18:00','4');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-08','21:00','3');
INSERT INTO Dates VALUES('Kung Fu Panda','2021-02-09','11:00','3');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-07','10:00','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-07','13:20','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-07','15:50','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-07','18:30','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-08','09:00','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-08','11:50','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-08','14:00','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-08','17:10','5');
INSERT INTO Dates VALUES('Eagle Eye','2021-02-08','20:40','5');
INSERT INTO Dates VALUES('Narnia','2021-02-07','10:00','4');
INSERT INTO Dates VALUES('Narnia','2021-02-07','10:40','3');
INSERT INTO Dates VALUES('Narnia','2021-02-07','13:00','4');
INSERT INTO Dates VALUES('Narnia','2021-02-08','21:00','5');
INSERT INTO Dates VALUES('Narnia','2021-02-09','13:00','3');
INSERT INTO Dates VALUES('Narnia','2021-02-09','15:50','3');
INSERT INTO Dates VALUES('Narnia','2021-02-09','18:00','3');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-07','10:00','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-07','13:00','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-07','16:30','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-07','19:50','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-08','12:20','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-08','15:00','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-08','18:00','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-08','21:10','6');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-09','11:00','5');
INSERT INTO Dates VALUES('Angels & Demons','2021-02-09','13:50','5');
INSERT INTO Dates VALUES('House','2021-02-07','21:00','1');
INSERT INTO Dates VALUES('House','2021-02-07','23:30','1');
INSERT INTO Dates VALUES('House','2021-02-07','22:50','6');
INSERT INTO Dates VALUES('House','2021-02-08','20:00','7');
INSERT INTO Dates VALUES('House','2021-02-08','22:10','7');
INSERT INTO Dates VALUES('House','2021-02-08','13:50','7');
INSERT INTO Dates VALUES('House','2021-02-09','17:50','5');
INSERT INTO Dates VALUES('House','2021-02-09','22:00','5');
INSERT INTO Dates VALUES('House','2021-02-09','23:50','5');
INSERT INTO Dates VALUES('Vacancy','2021-02-09','15:00','5');
INSERT INTO Dates VALUES('Vacancy','2021-02-09','15:50','6');
INSERT INTO Dates VALUES('Vacancy','2021-02-09','17:50','5');
INSERT INTO Dates VALUES('Vacancy','2021-02-10','15:50','1');
INSERT INTO Dates VALUES('Vacancy','2021-02-10','19:20','1');
INSERT INTO Dates VALUES('Vacancy','2021-02-11','15:00','1');
INSERT INTO Dates VALUES('Vacancy','2021-02-11','17:40','1');
INSERT INTO Dates VALUES('Mirrors','2021-02-09','13:00','7');
INSERT INTO Dates VALUES('Mirrors','2021-02-09','15:10','7');
INSERT INTO Dates VALUES('Mirrors','2021-02-09','17:40','7');
INSERT INTO Dates VALUES('Mirrors','2021-02-09','22:00','7');
INSERT INTO Dates VALUES('Mirrors','2021-02-10','19:00','3');
INSERT INTO Dates VALUES('Mirrors','2021-02-10','22:50','3');
INSERT INTO Dates VALUES('Mirrors','2021-02-11','23:30','1');
INSERT INTO Dates VALUES('The Kingdom','2021-02-10','14:00','2');
INSERT INTO Dates VALUES('The Kingdom','2021-02-10','16:00','2');
INSERT INTO Dates VALUES('The Kingdom','2021-02-10','18:50','2');
INSERT INTO Dates VALUES('The Kingdom','2021-02-11','13:20','1');
INSERT INTO Dates VALUES('The Kingdom','2021-02-11','13:15','2');
INSERT INTO Dates VALUES('The Kingdom','2021-02-11','17:15','1');
INSERT INTO Dates VALUES('The Kingdom','2021-02-12','12:00','2');
INSERT INTO Dates VALUES('The Kingdom','2021-02-12','15:00','2');
INSERT INTO Dates VALUES('Motives','2021-02-10','20:00','2');
INSERT INTO Dates VALUES('Motives','2021-02-10','21:55','2');
INSERT INTO Dates VALUES('Motives','2021-02-10','22:35','3');
INSERT INTO Dates VALUES('Motives','2021-02-11','15:00','2');
INSERT INTO Dates VALUES('Motives','2021-02-11','17:00','2');
INSERT INTO Dates VALUES('Motives','2021-02-12','15:00','1');
INSERT INTO Dates VALUES('Motives','2021-02-12','17:20','1');
INSERT INTO Dates VALUES('Motives','2021-02-12','20:00','1');
INSERT INTO Dates VALUES('The Prestige','2021-02-10','10:00','3');
INSERT INTO Dates VALUES('The Prestige','2021-02-10','12:15','3');
INSERT INTO Dates VALUES('The Prestige','2021-02-10','14:40','3');
INSERT INTO Dates VALUES('The Prestige','2021-02-11','16:15','2');
INSERT INTO Dates VALUES('The Prestige','2021-02-11','18:00','2');
INSERT INTO Dates VALUES('The Prestige','2021-02-12','14:00','2');
INSERT INTO Dates VALUES('The Prestige','2021-02-12','17:00','2');
INSERT INTO Dates VALUES('The Prestige','2021-02-12','22:15','2');
INSERT INTO Dates VALUES('SpiderMan 3','2021-02-01','17:00','220');


CREATE TABLE Orders(
    movieName varchar(30),
	chairID nvarchar(20),
	movie_date nvarchar(30),
	movie_time varchar(30),
	hallID varchar(10),
   	PRIMARY KEY (movie_date,movie_time,chairID,hallID)
);

SELECT * FROM Orders;
DROP Table Orders;


CREATE TABLE Cart(
    userName varchar(30),
	movie_date nvarchar(20),
	movie_time varchar(30),
	hall varchar(20),
	Seats varchar(50),
	movieName nvarchar(30),
	price varchar(20),
	subTotal varchar(20),
   	PRIMARY KEY (userName,movieName,movie_date,movie_time,Seats)
);
SELECT * FROM Cart;
DROP Table Cart;


CREATE TABLE HallRows (
	HallId nvarchar(10),
	numRows varchar(10),
   	PRIMARY KEY (HallId)
);
INSERT INTO HallRows VALUES('1','5');
INSERT INTO HallRows VALUES('2','5');
INSERT INTO HallRows VALUES('3','5');
INSERT INTO HallRows VALUES('4','5');
INSERT INTO HallRows VALUES('5','5');
INSERT INTO HallRows VALUES('6','5');
INSERT INTO HallRows VALUES('7','5');
INSERT INTO HallRows VALUES('8','5');


SELECT * FROM HallRows;
DROP Table HallRows;