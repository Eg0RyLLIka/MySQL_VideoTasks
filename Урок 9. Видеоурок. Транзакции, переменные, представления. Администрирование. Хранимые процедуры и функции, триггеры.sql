-- PRACTICE TASK ON THE TOPIC "TRANSACTION, VALUES, PRESENTATION"


-- � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
use sample;

start transaction;
insert into sample.users select * from shop.users where id = 1;

select * from users;

-- �������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
create view new_presentation (name_from_products, name_from_catalogs) as 
select name from products 
left join catalogs
on name.products = name.catalogs;

select * from new_presentation;

drop view new_presentation;

-- (�� �������) ����� ������� ����� ������� � ����������� ����� created_at. �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.

use mysql_videotasks;

SELECT * FROM accounts ORDER BY created_at Asc; -- ������ ���� �� �����������.

DELETE FROM accounts 
WHERE created_at NOT IN (
	SELECT * FROM accounts ORDER BY created_at ASC
	LIMIT 5
	);

SELECT * FROM accounts ORDER BY created_at DESC;


-- PRACTICE TASK ABOUT "STORED PROCEDURES AND FUNCTIONS, TRIGGERS"


--  �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
drop function if exists hello();
DELIMITER //
CREATE FUNCTION hello()
DECLARE @hour int;
SET @hour = HOUR(now());
CASE
WHEN @hour BETWEEN 6 AND 11 THEN RETURN 'Dobroe utro';
WHEN @hour BETWEEN 12 AND 17 THEN RETURN 'Dobryi den';
WHEN @hour BETWEEN 18 AND 23 THEN RETURN 'Dobryi vecher';
WHEN @hour BETWEEN 0 AND 5 THEN RETURN 'Dobroi nochi';
END CASE;
END//

DELIMITER ;

SELECT HOUR(now()), hello();

-- � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
DELIMITER //

CREATE TRIGGER new_trigger BEFORE INSERT ON PRODUCTS
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		DROP TRIGGER new_trigger;	
	END IF;
	SET NEW.name = COALESCE(NEW.name,OLD.name);
	SET NEW.description = COALESCE(NEW.description,OLD.description);
END//

--(�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. ����� ������� FIBONACCI(10) ������ ���������� ����� 55.