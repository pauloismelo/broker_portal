<?php

if (!empty($_FILES)) {
	$pasta = $_GET['id'];
	$newdir = mkdir ($_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'] .'/'.$pasta, 0700 );
	$tempFile = $_FILES['Filedata']['tmp_name'];
	$targetPath = $_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'] . '/'.$pasta.'/';
	$targetFile =  str_replace('//','/',$targetPath) . $_FILES['Filedata']['name'];
	
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
	
	
	//============================BURSCAR O PROTOCOLO=============================
	// Dados do banco
	$dbhost = '189.113.160.110'; #Nome do host
	$db = 'compacta'; #Nome do banco de dados
	$user = 'compacta'; #Nome do usuário
	$password = '1974xd-1974c032'; #Senha do usuário
	
	// Dados da tabela
	$id = $_GET['id'];
	
	$conn = new COM ('ADODB.Connection') or die('Nâo foi possível carregar o ADO');
	$connStr = 'PROVIDER=SQLOLEDB;SERVER='.$dbhost.';UID='.$user.';PWD='.$password.';DATABASE='.$db;
	$conn->open($connStr);
	
	
	
	$instrucaoSQL = 'SELECT * FROM TB_MOVIMENTACOES where id='.$id;
	$rs = $conn->execute($instrucaoSQL);
	
	//$num_columns = $rs->Fields->Count();
	//echo 'Foi mostrada $num_columns coluna da presente tabela.';
	
	$protocolo = $rs['protocolo'];
	$cliente = $rs['nome'];
	
	$instrucaoSQL3 = 'select * from CADASTROGERAL where id='.$rs['id_empresa'];
	$rs3 = $conn->execute($instrucaoSQL3);
	$titular = $rs3['titular'];
	
	$instrucaoSQL2 = 'select * from MOVIMENTACAO_PENDENCIA where id_movimentacao='.$id;
	$rs2 = $conn->execute($instrucaoSQL2);
	
	//SE RETORNAR ALGUM REGISTRO
	//if ($num_columns>0){
	if (!$rs2->eof){
		//============================ENVIO DE EMAIL=============================
		//Variáveis
		$data_envio = date('d/m/Y');
		$hora_envio = date('H:i:s');
		
		$arquivo = "<body><table width='650' border='0'><tr><td align=center bgcolor=#000000><font color=#FFFFFF>UPLOAD EM MOVIMENTA&Ccedil;&Atilde;O</font></td></tr><tr><td><br><p>H&aacute; um novo upload em movimenta&ccedil;&atilde;o  pendente<strong>#".$protocolo."</strong><br><br>Beneficiario: <strong>".$cliente."</strong><br>Empresa/cliente: <strong>".$titular."</strong></p><br>Acesse essa movimenta&ccedil;&atilde;o clicando <a href=http://compacta-net/SISCAD/HOME_MOVIMENTACOES.asp?id=$id target=_blank>aqui!</a><br></td></tr><tr><td align=center bgcolor=#000000><font color=#FFFFFF>Este e-mail foi enviado em ".$data_envio." &agrave;s ".$hora_envio."</font></td></tr></table></body>";
	   
		  // emails para quem será enviado o formulário
		  $emailenviar = "faturamento@compactasaude.com";
		  $destino = $emailenviar;
		  $assunto = "UPLOAD DE DOCUMENTOS";
		 
		  // É necessário indicar que o formato do e-mail é html
			$headers  = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
			$headers .= 'From: Portal do cliente <detec@compactasaude.com>';
			$headers .= "Bcc: manutencao@compactasaude.com\r\n";
		   
		  $enviaremail = mail($destino, $assunto, $arquivo, $headers);
	  
	}

}
?>