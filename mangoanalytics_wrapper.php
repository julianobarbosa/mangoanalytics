<?php

$ip = $_SERVER["SERVER_ADDR"];
$path = $_SERVER["PATH_INFO"];
$orig_path = $_SERVER["ORIG_PATH_INFO"];
var_dump("Orig path: ".$orig_path);

$loc_path = "http://".$ip.":8000".$path;
var_dump($loc_path);

header("Location: ".$loc_path);

?>