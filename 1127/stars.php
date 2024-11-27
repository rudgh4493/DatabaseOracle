<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    exit();
}
$conn = oci_connect("db2020575054","db99304493", "localhost/course"); 
if (!$conn)     p_error();

//$title = $_GET["title"];
//$year = $_GET["year"];

$stmt = oci_parse($conn,
	" select name, address addr, gender, to_char(birthdate, 'YYYY-MM-DD') birth from moviestar ". 
	" where birthdate > '1950-01-01' order by 4, 1 ");
if (!$stmt)     p_error();
if (!oci_execute($stmt))  p_error();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";     //html 태그 신택스
print "<TR bgcolor=#1ebcbabf align=center><TH> 배우 이름 <TH> 주소 <TH> 생년월일 <th> 출연영화 </TR>\n";

while ($row = oci_fetch_array($stmt)) {
    $name = $row['NAME'];
    $name2 = $row['NAME'];
    $addr = $row['ADDR'];
    $gender = $row['GENDER'];
    $birth = explode("-", $row['BIRTH']);
    if(!strcasecmp($gender, "female")) $gender = "여";       //female말고 male로 하면 안됌   gender는 6칸이라서 male을 구분못함
    else $gender = "남";
    $name = str_replace("'", "''", $name);              //이름안에 ' 오류 제거
         
    $stmt_cnt = oci_parse($conn,
	" select count(*) from starsin where starname = '$name2' ");
    if (!$stmt_cnt)     p_error();
    if (!oci_execute($stmt_cnt))  p_error();
    $cnt = oci_fetch_array($stmt_cnt)[0];
    
    print "<TR> <TD> $name($gender) <TD> $addr <TD> $birth[0]년$birth[1]월$birth[2]일 ";

    $stmt_mvs = oci_parse($conn,
	" select movietitle, movieyear from starsin where starname = '$name2' ");
    if (!$stmt_mvs)     p_error();
    if (!oci_execute($stmt_mvs))  p_error();
    
    print "<td> ";
    while($mv = oci_fetch_array($stmt_mvs)){
        $title = $mv[0];
        $year = $mv[1];
        $title2 = htmlentities($title, ENT_QUOTES);         //제목에 ' 오류 수정
        print "<a target=_blank href='movies2.php?title=$title2&year=$year'>$title($year)</a><br>";
    }
    print "</tr>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>









