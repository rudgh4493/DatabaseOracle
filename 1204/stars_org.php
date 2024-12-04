<?php
function p_error() {
    $e = oci_error();
    print "<b font color=red>$stmt</b> : ".htmlentities($e['message'])."<br>";
    exit();
}
$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn)    p_error("[Connection Error]");
//$title = $_GET["title"];
//$year = $_GET["year"];
$stmt = oci_parse($conn,
	" select name, address addr, gender, to_char(birthdate,'YYYY-MM-DD') birth from moviestar ".
	" where birthdate > '1900-01-01' order by 4, 1 ");
if (!$stmt)    p_error("[Parsing Error]");
if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 배우 이름 <TH> 주소 <TH> 생년월일 <th> 출연영화</TR>\n";

while ($row = oci_fetch_array($stmt)) {
    $name = $row['NAME'];
    $addr = $row['ADDR'];
    $gender = $row['GENDER'];
    $birth = explode("-", $row['BIRTH']);
    if(!strcasecmp($gender, "female")) $gender = "여";
    else $gender = "남";
    $name2 = str_replace("'", "''", $name);
        
    $stmt_cnt = oci_parse($conn,
	" select count(*) from starsin where starname = '$name2' ");
    if (!$stmt_cnt)    p_error();
    if (!oci_execute($stmt_cnt)) p_error ();
    $cnt = oci_fetch_array($stmt_cnt)[0];
    
    if($cnt >0){
        $stmt_mvs = oci_parse($conn,
            " select movietitle, movieyear from starsin where starname = '$name2' ");
        if (!$stmt_mvs)    p_error();
        if (!oci_execute($stmt_mvs)) p_error ();
        $first = true;
        while($mv = oci_fetch_array($stmt_mvs)) {
            print "<TR> ";
            if($first){
                print "<TD rowspan=$cnt> $name($gender) <TD rowspan=$cnt> $addr <TD rowspan=$cnt> $birth[0]년$birth[1]월$birth[2]일 ";
                $first = false;
            }
            $title = $mv[0];
            $year = $mv[1];
            $title2 = htmlentities($title, ENT_QUOTES);
            print "<td>";
            print "<a target=_blank href='movies.php?title=$title2&year=$year'>$title($year)</a><br>";
            print "</tr>\n";
        }
    }else{
        print "<tr><TD> $name($gender) <TD> $addr <TD> $birth[0]년$birth[1]월$birth[2]일 "
            . " <td style='background-color:red; color:yellow;'><b> 출연 영화 정보 없음</b></tr>\n";
    }
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
