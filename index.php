<?php
$conn = new PDO('mysql:dbname=db1;host=localhost', 'username', 'password');

$sql = 'select `db2`.`paysys`.`paysys_name`, ROUND(SUM(`db1`.`transactions`.`sum`),2) AS SUM
	from `db1`.`transactions`
	left join `db2`.`paysys`
	on `db1`.`transactions`.`paysys` = `db2`.`paysys`.`id`
	where 
	YEAR(`db1`.`transactions`.`date`) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
	AND
	MONTH(`db1`.`transactions`.`date`) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
	GROUP BY `db1`.`transactions`.`paysys`';

$sth = $conn->prepare($sql);
$sth->execute();

$rs = fopen("report.txt","a+");
fwrite($rs,"Payment report for ".date('F Y h:i:s')."\r\n");

while ($res = $sth->fetch(PDO::FETCH_ASSOC)) {
    fwrite($rs, $res['paysys_name'].' - '.$res['SUM']."\r\n");
}

fclose($rs);
$sth = null;
?>
