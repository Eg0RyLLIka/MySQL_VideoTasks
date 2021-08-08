-- ������������ ������� �� ���� ������������ ��������

-- �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������, ������������� ���������� ����� � ���������� ���� name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(50) NOT NULL,
	table_id INT UNSIGNED NOT NULL,
	`name` VARCHAR(50) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS log_users;
delimiter //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, table_id, `name`)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, table_id, `name`)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

delimiter //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, table_id, `name`)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;

-- (�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.


-- ������������ ������� �� ���� �NoSQL�

-- � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.

redis-cli

SADD ipadd 172.265.17.89 156.267.14.458

expire ipadd 60

exit

-- ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������, ����� ������������ ������ ������������ �� ��� �����.

redis-cli

set Egor EGOR@mail.ru

set EGOR@mail.ru Egor

get Egor

get EGOR@mail.ru

exit 

-- ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.

ps aux | grep mongod -- ��������� ��� ������ mongodb ��������

mongo

use shop

db.shop.insert({category: ''})

db.shop.insert({value products: ''})

db.shop.find()

db.shop.drop()
