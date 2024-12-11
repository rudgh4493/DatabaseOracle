<?php
function p_error ($e_message = "OCI_Error", $conn = null, $exit = true ) {
//conn이 널이면 메시지 띄움 exit - false면 exit안함. 에러나도 계속 진행
    print "<font color=red>".$e_message."</font><br>";
    if($conn == null)   $e = oci_error();   //파라미터 생략됨
    else  $e = oci_error($conn);            //파라미터 ㅇㅇ
    print "[$e] ";
    print htmlentities($e['message']);
    if($exit) exit();
}
$conn = oci_connect("db2020575054","db99304493", "localhost/course");
if (!$conn)    p_error("Login");    //메시지 로그인, 나머지 기본값

$delete = $_GET["DELETE"];
if(!empty($delete)){
    print"<b>$delete</b>";
    $stmt = oci_parse($conn, "delete from movie where title=:tt and year=:yy ");
    if (!$stmt)    p_error("Parsing", $stmt);
    
    $tt_yy = $_GET["TitleYear"];
    for($i=0; $i<count($tt_yy);$i++){
        $ty = explode("|", $tt_yy[$i]);
        $title = $ty[0]; $year = $ty[1];
        print "<mark style='color:red; size:150%'> Movie($title,$year) ";
        oci_bind_by_name($stmt, ":tt", $title);
        oci_bind_by_name($stmt, ":yy", $year);
        if (!oci_execute($stmt)){ 
             print " Deletion Error</mark><br>\n ";
            p_error ("Deletion", $conn, false);
        }else 
            print " Deleted</mark><br> ";
    }
}else{
    $title = str_replace("'", "''", $_GET["title"]);
    $year = $_GET["year"];
    $studio = $_GET["studio"];
    $sql = "select title, year, round(length/60,2) length, studioname name, address addr from movie, studio ".
            " where studioname = name ";

    if(!empty($title)) $sql = $sql." and title like '%$title%' ";
    if(!empty($year)) $sql = $sql." and year = $year ";
    if(!empty($studio)) $sql = $sql." and studioname = '$studio' ";

    $stmt = oci_parse($conn, $sql." order by 1, 2 ");
    if (!$stmt)    p_error("Parsing", $stmt);                          //수정   sql문 틀리면 여기서 에러나야되는데 건너뛰고 excute에서발생함
                                                                            //파싱 에러는 못잡으니 틀리지 말 것
    if (!oci_execute($stmt)) p_error ("Excute", $conn);                //수정   []는 $e가 나와야되는데 리턴 없으면 빈칸

    print "<form method= 'get' action='movies_check.php'>\n ";
    print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2 cellpadding=3>\n";
    print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사 <TH> 주소 <th> 삭제 </TR>\n";

    $cnt = oci_fetch_all($stmt, $result, null, null, OCI_FETCHSTATEMENT_BY_ROW);
    foreach ($result as $row) {
        $tt= htmlentities($row['TITLE'], ENT_QUOTES);
        $yy= $row['YEAR'];
        print "<TR> <TD> $tt <TD> $yy <TD> {$row['LENGTH']}시간 <TD> {$row['NAME']} <TD> {$row['ADDR']} ";
        print "<td> <input type='checkbox' name='TitleYear[]' value='$tt|$yy'></tr>\n ";     //[]- 배열화  //현재 영화의 체크박스 선택하면 value로 전달됨
    }
    print "<tr> <td colspan =6><input type='submit' name='DELETE' value='삭제'> "//value로 버튼 값 구별가능
        ." <input type='submit' name='DELETE' value='수정'> "
        . " <input type=reset value='초기화'</tr>\n";
    print "</TABLE>\n";
    print "</form>\n";
}
oci_free_statement($stmt);
oci_close($conn);
?>
