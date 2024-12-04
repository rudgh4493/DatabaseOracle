<?php   //오늘과제 title %들어간애들 검색하는걸 해결하는거
function p_error() {
    $e = oci_error();
    print "<b>$stmt</b> : ".htmlentities($e['message'])."<br>";
    exit();
}
$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn)    p_error();

$title = str_replace("'", "''", $_POST["title"]);
$year = $_POST["year"];
$studio = $_POST["studio"];

print "incolor : ".$_POST['incolor']." <br>";
print "option : ".$_POST['option']." <br>";
        

$sql ="select title, year, round(length/60,2) length, studioname name, address addr from movie, studio ".
	" where studioname = name ";    
//타이틀이 있을때만       다이나믹하게 추가 할수 있도록
if(!empty($title)){
    $sql = $sql." and title like '%$title%' ";
}
if(!empty($title)){
    $sql = $sql." and year = '$year' ";
}
if(!empty($studio)){
    $sql = $sql." and studio = '$studio' ";
}
$stmt = oci_parse($conn, $sql." order by 1, 2 ");

if (!$stmt)    p_error();
if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사 <TH> 주소 </TR>\n";

while ($row = oci_fetch_array($stmt)) {
    print "<TR> <TD> {$row['TITLE']} <TD> {$row[1]} <TD> {$row['LENGTH']} <TD> {$row['NAME']} <TD> {$row['ADDR']} </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
