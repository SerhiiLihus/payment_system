# Payment reporting system (Made and tested on Ubuntu 14.04)

***

*** Инструкция по установке приложения(для тестирования работы программы)

1. Скачиваем приложение
   
   Для этого нажимаем на кнопку **Clone or download** -> **Download ZIP**

2. Устанавливаем unzip(для распаковки zip файла)
	
	```
	sudo apt-get install unzip
	```
	
	разархивируем содержимое *.zip файла


	```
	unzip payment_system-master.zip
	cd payment_system-master
	```


3. Разворачиваем дамп:

   ```
   mysql -u your_login -p < dump_1.sql
   ```

   В самом дампе уже прописаны команды для создания двух баз db1 и db2, пользователя(+ права для добавления и извлечения информации из указанных баз), таблиц и команд для вставки пробных данных.

4. Запустить скрипт index.php(или исполняемый файл run):
   
   Для этого в терминале/консоли введите

   ```
   php index.php
   ```

   либо же можно запустить исполняемый php файл который Вы скачали(предварительно сделав его исполняемым):

   ```
   chmod +x run
   ./run
   ```

5. После выполнения скрипта результат его работы можно просмотреть в файле report.txt, либо

   ```
   cat report.txt
   ```

   Добавлю, что для корректной работы необходим драйвер **PDO**.

***


```
select `db2`.`paysys`.`paysys_name`, ROUND(SUM(`db1`.`transactions`.`sum`),2) AS SUM 
from `db1`.`transactions`
left join `db2`.`paysys`
on `db1`.`transactions`.`paysys` = `db2`.`paysys`.`id`
where 
YEAR(`db1`.`transactions`.`date`) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
	AND 
MONTH(`db1`.`transactions`.`date`) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY `db1`.`transactions`.`paysys`;
```
