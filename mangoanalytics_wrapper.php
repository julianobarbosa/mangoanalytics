<?php

include_once("libs/misc.lib.php");
include_once("configs/default.conf.php");
include_once("libs/paloSantoACL.class.php");
include_once("libs/paloSantoDB.class.php");

session_name("elastixSession");
session_start();
$pDB  = new paloDB($arrConf["elastix_dsn"]["acl"]);
$pACL = new paloACL($pDB);
if(isset($_SESSION["elastix_user"]))
    $elastix_user = $_SESSION["elastix_user"];
else
    $elastix_user = "";
session_commit();
var_dump($elastix_user);
if($pACL->isUserAdministratorGroup($elastix_user)){
	echo "Yesh, yesh, it has permits.";
};

$ip = $_SERVER["SERVER_ADDR"];
$path = $_SERVER["PATH_INFO"];
$orig_path = $_SERVER["ORIG_PATH_INFO"];
var_dump("Orig path: ".$orig_path);

$loc_path = "http://".$ip.":8000".$path;
var_dump($loc_path);

//header("Location: ".$loc_path);

?>