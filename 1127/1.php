<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    exit();
}
$conn = oci_connect("db2020575054","db99304493", "localhost/course"); 
if (!$conn) p_error();

$stmt = oci_parse($conn,
	"select title, year, length, (select name from movieexec where certno = producerno) as producername, ".
        " (select name from studio where certno = presno) as presidentname ". 
        " from movie, starsin, movieexec, studio, moviestar ". 
        " where studio.name = studioname and title = movietitle and year = movieyear and ".
        " certno = producerno and certno = presno and starname=moviestar.name ".
        " order by year, length; ");
if (!$stmt) p_error();

oci_define_by_name($stmt,"TITLE",$title);           
oci_define_by_name($stmt,"YEAR",$year);
oci_define_by_name($stmt,"LENGTH",$length);
oci_define_by_name($stmt,"PRODUCERNAME",$producer);
oci_define_by_name($stmt,"PRESIDENTNAME",$president);

if (oci_execute($stmt)) p_error();

print "<TABLE bgcolor=#E7FEFF border=1 cellspacing=2>\n";
print "<TR bgcolor=#7DDAFF align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 제작자 <TH> 영화사사장 </TR>\n";

while (oci_fetch($stmt)) {
    print "<TR> <TD> $title <TD> ".$year."년 <TD> $length <TD> $producer <TD> $president </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>









