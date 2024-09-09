<?php



print_r($_FILES);

// diretório de destino do arquivo


define('DEST_DIR', __DIR__ . '/docs_ocorrencia/'.$_POST['id'].'/');
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
		echo $total.'<br>';
	 
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
				echo "<script>window.location='painel.asp?go=ocorrencia_anexos&id=".$_POST['id']."';</script>";
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
		
	 
		echo "<script>alert($total.' arquivos foram enviados');</script>";
		//echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</ script>";
	}else{
		echo "<script>alert('Nenhum arquivo enviado');</script>";
		//echo "<script>window.location='painel.asp?go=inclusao_finaliza&id=".$_POST['id']."';</ script>";
		
	}

?>