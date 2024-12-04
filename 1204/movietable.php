<?php   //오늘과제 title %들어간애들 검색하는걸 해결하는거
function p_error() {
    $e = oci_error();
    print "<b>$stmt</b> : ".htmlentities($e['message'])."<br>";
    exit();
}
$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn)    p_error();

$table =  $_GET["table"];
if(empty($talbe)) $table='movie';
$sql ="select * from $table ";    
$stmt = oci_parse($conn, $sql." order by 1, 2 ");

if (!$stmt)    p_error();
if (!oci_execute($stmt)) p_error ();
//$cnt = oci_fetch_all($stmt, $rows, null, null, OCI_FETCHSTATEMENT_BY_COLUMN);밑이랑 같음
$cnt = oci_fetch_all($stmt, $rows);
print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<tr>";
foreach ($rows as $key => $value) {
    print "<th>$key ";
}
//foreach ($rows[0] as $key => $value) {//OCI_FETCHSTATEMENT_BY_row일때      //각 행에 대해서      //첫번쨰 튜플을 foreach돌린다 
//    print "<th>$key ";
//}
print "</tr>";
for($i=0; $o<$cnt; $i++){
    print "<tr>";
    foreach ($rows as $value) {
        print "<td> $value[$i] ";
    }
    print "</tr>";
}
//for($i=0; $o<$cnt; $i++){//OCI_FETCHSTATEMENT_BY_row일때  
//    print "<tr>";
//    foreach ($rows[$i] as $key => $value) {//각 행에 대해서      //첫번쨰 튜플을 foreach돌린다
//        print "<td> $value ";
//    }
//    print "</tr>";
//}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
