<?php
$conn = oci_connect("db2020575054","db99304493", "localhost/course"); //설정해주기
if (!$conn) {
	$e = oci_error();
	print htmlentities($e['message']);
}

//$title = $_GET["title"];
//$year = $_GET["year"];

$stmt = oci_parse($conn,
	"select title, year, round(length/60,2) length, studioname as name, address addr from movie, studio ".   //. 은 + 랑 같음    as 빼도 됌
	" where studioname = name order by 1, 2 ");
if (!$stmt) {
	$e = oci_error($conn);
	print $e['message'];
	//print htmlentities($e['message']);
}

/* the define MUST be done BEFORE ociexecute! */    //이 줄은 [$r = oci_execute($stmt);] 전에 해야함
oci_define_by_name($stmt,"TITLE",$title);           // title 여기칸은 반드시 대문자로 소문자x
oci_define_by_name($stmt,"YEAR",$year);
oci_define_by_name($stmt,"LENGTH",$length);
oci_define_by_name($stmt,"NAME",$studio);
oci_define_by_name($stmt,"ADDR",$addr);

//$r = oci_execute($stmt);
if (/*!$r*/oci_execute($stmt)) {
	$e = oci_error();
	print htmlentities($e['message']);
}

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사 <TH> 주소 </TR>\n";

while (oci_fetch($stmt)) {// fetch할 데이터가 있는동안은 true
    print "<TR> <TD> $title <TD> $year <TD> $length <TD> $studio <TD> $addr </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>









