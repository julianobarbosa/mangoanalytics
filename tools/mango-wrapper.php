<?php

$ip = $_SERVER["SERVER_ADDR"];
$path = $_SERVER["PATH_INFO"];

$loc_path = "http://".$ip.":8123".$path;
header("Location: ".$loc_path);

?>