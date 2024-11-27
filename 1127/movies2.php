<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    exit();
}
$conn = oci_connect("db2020575054","db99304493", "localhost/course"); //설정해주기
if (!$conn)     p_error();

$title = str_replace("'", "''", $_GET["title"]);
$year = $_GET["year"];

$stmt = oci_parse($conn,
	"select title, year, round(length/60,2) length, studioname as name, address addr from movie, studio ".   //. 은 + 랑 같음    as 빼도 됌
	" where studioname = name and title = '$title' and year = '$year' order by 1, 2 ");
if (!$stmt)     p_error();

if (!oci_execute($stmt))  p_error();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사 <TH> 주소 </TR>\n";

while ($row = oci_fetch_array($stmt)) {
    
    print "<TR> <TD> {$row['TITLE']} <TD> {$row[1]} <TD> {$row['LENGTH']} <TD> {$row['NAME']} <TD> {$row['ADDR']} </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>









