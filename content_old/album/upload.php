<?php
//print_r($_FILES);

// diretório de destino do arquivo
define('DEST_DIR', __DIR__ . '/documentos/'.$_POST['id'].'/');
$dir = str_replace("\album", "", DEST_DIR);

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
        // podemos acessar os dados de cada arquivo desta forma:
        // - $arquivos['name'][$i]
        // - $arquivos['tmp_name'][$i]
        // - $arquivos['size'][$i]
        // - $arquivos['error'][$i]
        // - $arquivos['type'][$i]
		
        if (!move_uploaded_file($arquivos['tmp_name'][$i], $dir . '/' . $arquivos['name'][$i]))
			
        {
			echo $arquivos['error'][$i];
			echo '<br>';
			echo $arquivos['size'][$i];
            echo "<script>alert('Arquivo não enviado!');</script>";
			echo "Erro ao enviar o arquivo: " . $arquivos['name'][$i];
			exit;
			echo "<script>window.location='index.php?id=".$_POST['id']."&tipo=".$_POST['tipo']."';</script>";
        }
    }
 
    echo "<script>alert($total.' arquivos foram enviados');</script>";
	echo "<script>window.location='index.php?id=".$_POST['id']."&tipo=".$_POST['tipo']."';</script>";
}else{
	echo "<script>alert('Nenhum arquivo enviado! Verifique o tamanho do arquivo!\n Tamanho máximo permitido = 10MB');</script>";
	echo "<script>window.location='index.php?id=".$_POST['id']."&tipo=".$_POST['tipo']."';</script>";
	
}

?>