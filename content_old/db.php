<?php
date_default_timezone_set('America/Sao_Paulo');
header('Content-Type: text/html; charset=iso-8859-1');

$dbhost = "45.164.92.21";
$user = "compacta";
$password = "GJmizak!za1m";
$db = "compacta";
	
	$serverName = "$dbhost"; //serverName\instanceName

	// Since UID and PWD are not specified in the $connectionInfo array,
	// The connection will be attempted using Windows Authentication.
	$connectionInfo = array( "Database"=>"$db", "UID"=>"$user", "PWD"=>"$password");
	$conn = sqlsrv_connect( $serverName, $connectionInfo);
	
	if( $conn ) {
		 //echo "Connection established.<br />";
	}else{
		 echo "Connection could not be established.<br />";
		 die( print_r( sqlsrv_errors(), true));
	}
 
?>

