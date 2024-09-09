<?php

// Dados do banco
	$dbhost = "45.164.92.21";
    $user = "compacta";
    $password = "GJmizak!za1m";
    $db = "compacta";


$conninfo = array("Database" => $db, "UID" => $user, "PWD" => $password);
$conn = sqlsrv_connect($dbhost, $conninfo);

//print_r($_FILES);
// diretório de destino do arquivo


define('DEST_DIR', __DIR__ . '/documentos/'.$_POST['id'].'/');
$dir = str_replace("new/", "", DEST_DIR);

//echo $dir.'<br>';
//exit;

if(!is_dir($dir))
{
	mkdir($dir, 0777, true);
	
}
 

	if (isset($_FILES['arquivos']) && !empty($_FILES['arquivos']['name']))
	{
		// se o "name" estiver vazio, é porque nenhum arquivo foi enviado
		
		// cria uma variável para facilitar
		$arquivos = $_FILES['arquivos'];
	 
		// total de arquivos enviados
		$total = count($arquivos['name']);
	 
		for ($i = 0; $i < $total; $i++)
		
		{
			//print_r($arquivos);
			// podemos acessar os dados de cada arquivo desta forma:
			// - $arquivos['name'][$i]
			// - $arquivos['tmp_name'][$i]
			// - $arquivos['size'][$i]
			// - $arquivos['error'][$i]
			// - $arquivos['type'][$i]
			
			
			if($arquivos['size'][$i] >= 2097152){
				echo "<script>alert('Tamanho do arquivo excedido!');</script>";
				echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</script>";
			}
			
			if (!move_uploaded_file($arquivos['tmp_name'][$i], $dir .'/'.$arquivos['name'][$i]))
			{
				echo "<script>alert('Arquivo não enviado!!');</script>";
				print_r($arquivos['name']);
				print_r($arquivos['error'][$i]);
				//echo "Erro ao enviar o arquivo: " . $arquivos['name'][$i];
				//echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</ script>";
			}
		}

		
		//envia email, caso haja pendencia nessa movimentacao
		$instrucaoSQL="select * from MOVIMENTACAO_PENDENCIA where id_movimentacao=".$_POST['id']." and finalizou<>'s' ";
		
		$params = array();
		$options =array("Scrollable" => SQLSRV_CURSOR_KEYSET);
		$consulta = sqlsrv_query($conn, $instrucaoSQL, $params, $options);
		$numRegistros = sqlsrv_num_rows($consulta);

		if ($numRegistros!=0) {

			$instrucaoSQL2="select * from TB_MOVIMENTACOES where id=".$_POST['id']." ";
			$consulta2 = sqlsrv_query($conn, $instrucaoSQL2, $params, $options);
			$numRegistros2 = sqlsrv_num_rows($consulta2);
			$rs = sqlsrv_fetch_array($consulta2, SQLSRV_FETCH_ASSOC);
			if ($numRegistros2!=0) {

				$instrucaoSQL3="select titular from CADASTROGERAL where id=".$rs['id_empresa']." ";
				$consulta3 = sqlsrv_query($conn, $instrucaoSQL3, $params, $options);
				$numRegistros3 = sqlsrv_num_rows($consulta3);
				$rs3 = sqlsrv_fetch_array($consulta3, SQLSRV_FETCH_ASSOC);
				if ($numRegistros3!=0) {
					$titular=$rs3['titular'];
				}

				///////////////ENVIAR EMAIL/////////////
				//carrengando a biblioteca phpmailer
				require("class.phpmailer.php");
				//pegando os dados do formulário
				$nome = "PORTAL COMPACTA	";
				$email = "noreply@compactasaude.com.br";
				$assunto = "Arquivo Enviado: ".$titular;
				//fazemos a chamada a classe phpmailer
				$mail = new PHPMailer();
				//chamada par envio de email via smtp
				$mail->Mailer = "smtp";
				//habilita o envio de email HTML
				$mail->IsHTML(true);
				//Remetente do e-mail
				$mail->From = $email;
				//nome do remetente do email
				$mail->FromName = $nome;
				//endereco de destino do email
				$mail->AddAddress("deman2@compactasaude.com"); //O destino do email
				//copia
				//$mail->addCC("contato@atualizarinformatica.com.br");
				//copia oculta
				//$mail->addBCC("ccaddress@ccdomain.com", "Some CC Name");
				//assunto do email
				$mail->Subject = $assunto;
				//texto da mensagem
				
				$mail->Body = "<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>ARQUIVO ANEXADO NA PENDENCIA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Um arquivo foi anexado em uma movimentacao com pendencia.<br><BR>Empresa: <strong>".$titular."</strong><br>Id da movimentacao: <strong>".$rs['id']."</strong><br> Beneficiario: <strong>".$rs['nome']."</strong><br>Protocolo <strong>".$rs['protocolo']."</strong><br><br>Favor, verificar os anexos no sistema SISCAD<br><B>Este e-mail foi enviado para voc&ecirc; no dia: ".date('d/m/Y H:i').".</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>";
				
				//você poderá concatenar o texto para enviar mais de um assunto
				$mail->Body .= "mais de um assunto";
				//coloque aqui o seu servidor de saída de emails (SMTP)
				$mail->Host = "localhost";
				//habilita a autenticação smtp
				$mail->SMTPAuth = "true"; // Habilitar a autenticação email
				//usuário SMTP
				$mail->Username = "noreply@compactasaude.com.br";
				//senha do usuário SMTP
				$mail->Password = "x7hd0%F8";
				//verifica se está tudo ok e envia a mensagem
				if(!$mail->Send()){
				echo "Ocorreu erros ao enviar o e-mail";
				exit; //sai do script sem executar o codigo
				}
				echo "Email Enviado com sucesso";
					
				//////////////FIM ENVIAR EMAIL//////////
			}else{

				var_dump('Movimentacao nao encontrada');
				//echo "<script>alert('Movimentacao nao encontrada');</script>";
			}

		}else{
			
			var_dump('Pendencia nao encontrada');
			//echo "<script>alert('Pendencia nao encontrada');</script>";
		}
		
	 
		echo "<script>alert($total.' arquivos foram enviados');</script>";
		//echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</ script>";
	}else{
		echo "<script>alert('Nenhum arquivo enviado');</script>";
		//echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</ script>";
		
	}

?>