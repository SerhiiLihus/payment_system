# Payment reporting system (Made and tested on Ubuntu 14.04 (PHP, MySQL and little bit of bash :) )

***

*** Алгоритм извлечения данных

Предположим что у нас уже есть две базы в которых есть по таблице и данные таблицы заполнены данными. Отмечу что в файле dump_1.sql есть описание создание баз, пользователя, прав доступа, таблиц, и заполнение их данными.

1. Необходимо сформировать запрос в базу для извлечения необходимых данных:

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

   В данном запросе мы выбираем (извлекаем) название платежной системы и сумму за месяц(округленную до двух знаков после запятой). 

   Для того чтобы получить данные использовался **LEFT JOIN** для ускорения поиска в первой таблице которая находится в первой базе, при этом не учитывая данные из второй таблицы которая находится во второй базе. 

   Также в запросе данные фильтруются с помощью двух фильтров **WHERE** и **GROUP BY**

   В **WHERE** задаем условие для выбора данных за прошлый месяц.

   В **GROUP BY** группируем результат операции суммирования по айдишнику платежной системы.

   На выходе получаем название и сумму по платежной системе за прошлый месяц.

2. Пишем скрипт на php в котором:

   2.1 Подключаемся к базе
   2.2 Посылаем запрос в базу(сам запрос описан выше)
   2.3 Получаем результат в виде ассоциативного массива
   2.4 Создаем файл(в случае если файл создан перемещаем указатель в конец файла для дозаписи)
   2.5 Записываем в файл текущую дату(для удобочитаемости) и результат запроса.
   2.6 Закрываем соединение с базой и файлом.

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

## Планировщик задач

Для того, чтобы осуществить вызов скрипта 1-го числа каждого месяца в 6 часов утра, был использован cron.

Создание задачи для крона выглядит следующим образом:

   Вызываем планировщик задач с под текущего пользователя

   ```
   crontab -e
   ```

   Откроется редактор vi(у меня по-умолчанию vim) в котором необходимо добавить строку указанную ниже. Чтобы начать редактирование документа(себто добавить строку) необходимо нажать клавишу **i** чтобы перейти в режим **Вставки**.

   ```
   0 6 1 * * cd /full/path/to/payment_system-master/ && ./run
   ```

   После добавление строки нажмите **Enter**. Далее нажмите **escape**, и введите **:wq**. После нажмите **Enter**.

   Чтобы проверить успешно ли добавлена задача, введите команду 

   ```
   crontab -l
   ```

   Отобразится список задач для данного пользователя из под которого Вы создали данную задачу. Это также будет означать что сама задача была успешно создана.

