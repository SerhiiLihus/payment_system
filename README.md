# payment_system
Payment reporting system

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
