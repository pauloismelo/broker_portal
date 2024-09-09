<?php

if (!empty($_FILES)) {
	$ref = $_GET['id'];
	$newdir = mkdir ($_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'] , 0700 );
	$tempFile = $_FILES['Filedata']['tmp_name'];
	$targetPath = $_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'].'/';
	$targetFile =  str_replace('//','/',$targetPath) . $ref.'__'.$_FILES['Filedata']['name'];
	
	// $fileTypes  = str_replace('*.','',$_REQUEST['fileext']);
	// $fileTypes  = str_replace(';','|',$fileTypes);
	// $typesArray = split('\|',$fileTypes);
	// $fileParts  = pathinfo($_FILES['Filedata']['name']);
	
	// if (in_array($fileParts['extension'],$typesArray)) {
		// Uncomment the following line if you want to make the directory if it doesn't exist
		// mkdir(str_replace('//','/',$targetPath), 0755, true);
		
		move_uploaded_file($tempFile,$targetFile);
		echo "1";
	// } else {
	// 	echo 'Invalid file type.';
	// }
}
?>