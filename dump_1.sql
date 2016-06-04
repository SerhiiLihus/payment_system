create database if not exists `db1`;
create database if not exists `db2`;

grant select, insert on `db1`.* to 'username'@'localhost' identified by 'password';
grant select, insert on `db2`.* to 'username'@'localhost' identified by 'password';

-- 
-- Таблица transactions для первой бд
-- 

create table if not exists `db1`.`transactions` (
	`id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`date` timestamp NOT NULL default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`paysys` int NOT NULL,
	`sum` float NOT NULL,
	`agremment` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8; 

insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (1,99.60,'003450');
insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (1,55.55,'115450');
insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (2,60.60,'223550');
insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (3,120.60,'673450');
insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (4,120.60,'613450');
insert into `db1`.`transactions` (`paysys`, `sum`, `agremment`) 
	values (1,99.60,'773450');
insert into `db1`.`transactions` (`date`, `paysys`, `sum`, `agremment`) 
	values ('2016-05-02 18:29:21',1,22.60,'773450');
insert into `db1`.`transactions` (`date`, `paysys`, `sum`, `agremment`) 
	values ('2016-05-02 18:29:21',2,30.60,'773450');
insert into `db1`.`transactions` (`date`, `paysys`, `sum`, `agremment`) 
	values ('2016-05-02 18:29:21',1,40.60,'773450');


-- 
-- Таблица paysys для второй бд
-- 

create table if not exists `db2`.`paysys` (
	`id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`paysys_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8; 

insert into `db2`.`paysys` (`paysys_name`) 
	values ('EasyPay');
insert into `db2`.`paysys` (`paysys_name`) 
	values ('PayPal');
insert into `db2`.`paysys` (`paysys_name`) 
	values ('iPay');
insert into `db2`.`paysys` (`paysys_name`) 
	values ('Western Union');
