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
$n_stars = oci_fetch_all($stmt, $row, null, null, OCI_FETCHSTATEMENT_BY_ROW);

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 배우 이름 <TH> 주소 <TH> 생년월일 <th> 출연영화</TR>\n";


for($i=0; $i<$n_stars; $i++) {
    $name = $row[$i]['NAME'];
    $addr = $row[$i]['ADDR'];
    $gender = $row[$i]['GENDER'];
    $birth = explode("-", $row[$i]['BIRTH']);
    if(!strcasecmp($gender, "female")) $gender = "여";
    else $gender = "남";
    $name2 = str_replace("'", "''", $name);
    
    $stmt_mvs = oci_parse($conn, " select movietitle tt, movieyear yy from starsin where starname = ':sn' ");
    
    if (!$stmt_mvs)    p_error();
    oci_bind_by_name($stmt_mvs, "$:sn", $name2);
    if (!oci_execute($stmt_mvs)) p_error ();
    $cnt = oci_fetch_all($stmt_mvs, $mv,null,null, OCI_FETCHSTATEMENT_BY_ROW);
    if($cnt >0){                
        $first = true;
        for($j=0; $j<$cnt; $j++) {
            print "<TR> ";
            if($first){
                print "<TD rowspan=$cnt> $name($gender) <TD rowspan=$cnt> $addr <TD rowspan=$cnt> $birth[0]년$birth[1]월$birth[2]일 ";
                $first = false;
            }
            $title = $mv[$j]['TT'];
            $year = $mv[$j]['YY'];
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
