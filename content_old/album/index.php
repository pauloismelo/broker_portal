<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Carregando Documentos</title>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="scripts/swfobject.js"></script>
<script type="text/javascript" src="scripts/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#uploadify").uploadify({
		'uploader'       : 'scripts/uploadify.swf',
		'script'         : 'scripts/uploadify.php?id=<?php echo $_GET['id']?>',
		'fileDesc'       : 'Image Files',
        'fileExt'        : '*.jpg;*.jpeg;*.gif;*.pdf;*.png;*',
		'cancelImg'      : 'cancel.png',
		'folder'         : '/documentos',
		'queueID'        : 'fileQueue',
		'buttonText'     : 'Achar Arquivos',
		'auto'           : false,
		'multi'          : true
	});
});
</script>

<style>
.Arial_azulClaro {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 20px;
	color: #0783CD;
	text-decoration: none;
}

.Arial_azulEscuro {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 22px;
	color: #315E95;
	text-decoration: none;
	font-weight:bold;
}

.texto {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	color: #0783CD;
	text-decoration: none;
}
.boxZ { border: 1px solid #cccccc;  padding: 1px; }
</style>

</head>

<body onload="CarregaDiv();">
	<?php
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
	$protocolo = $rs['protocolo'];
    
    $num_columns = $rs->Fields->Count();
    //echo 'Foi mostrada $num_columns coluna da presente tabela.';
    
    if ($rs['id_contrato']!= ''){
    $instrucaoSQL2 = 'SELECT * FROM CADASTROGERAL_VENDAS where id='.$rs['id_contrato'];
    $rs2 = $conn->execute($instrucaoSQL2);
    
    $plano = $rs2['operadora'];
    $tipo = $_GET['tipo'];
    }else{
        $plano = $_GET['plano'];
    }
    ?>

<table width="100%" cellpadding="10" cellspacing="10">
<tr>
	<td colspan="3" class="Arial_azulClaro" style="padding:10px; border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;">
    Falta pouco para enviar sua solicita&ccedil;&atilde;o. Agora &eacute; hora de inserir os documentos. 
    <p>
    	<span class="Arial_azulClaro">Benefici&aacute;rio(a) titular:</span><span class="Arial_azulEscuro"><?php echo $rs['nome']?></span>
    </p>
    <p>
    	<span class="Arial_azulClaro">Solicita&ccedil;&atilde;o:</span><span class="Arial_azulEscuro"><? echo strtoupper($tipo)?></span>
    </p>
    <p>
    	<span class="Arial_azulClaro">Protocolo:</span><span class="Arial_azulEscuro"><?php echo $protocolo?></span>
    </p>
    
    </td>
    
</tr>

	<tr>
		<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;" class="Arial_azulEscuro">
			1&deg; Passo<br />
            <span class="Arial_azulClaro">Documentos necess&aacute;rios</span>
    	</td>
        <td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;" class="Arial_azulEscuro">
			2&deg; Passo<br />
            <span class="Arial_azulClaro">Inserir Novos Documentos</span>
    	</td>
        <td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;" class="Arial_azulEscuro">
			3&deg; Passo<br />
            <span class="Arial_azulClaro">Conferir Documentos Inseridos</span>
    	</td>
	</tr>
    <tr>
        <td align="left" valign="top" width="33%">
        Abaixo voc&ecirc; encontrar&aacute; a lista de documentos necess&aacute;rios para a sua solicita&ccedil;&atilde;o.
        
        <span >
        <?
        if ($plano =='AMIL'){
            ?>
        
        <li>Formulário específico para inclusão (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documentação de Vínculo/Empresa: 
            <ul>
                <li> Titular (funcionário) – Vínculo empregatício (Relação de FGTS + Comprovante de Quitação – Atualizada).<br /> Quando o funcionário for recém-admitido (até 30 dias de admissão), deverá ser enviada a cópia da CTPS (carteira de trabalho – páginas com foto/assinatura, dados pessoais e de admissão) e cópia do CAGED.</li>
    
                <li>Titular (sócio) – Cópia do Contrato Social e Última Alteração.</li>
            </ul>
    
        </li>
        <li>Documentação Pessoal:
            <ul>
            
                <li>Titular – Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do comprovante de endereço e cópia do CPF.</li>
                <li>Dependente (s) Elegíveis - Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do CPF, cópia de Certidão de Nascimento e cópia de Certidão de Casamento.</li>
            </ul>
        </li>
        <?
        }
        elseif ($plano =='BRADESCO') {
        ?>
        <li>Carta com a solicitação da empresa em papel timbrado ou com carimbo de CNPJ especificando a data da inclusão com o dia, mês e ano (a partir de...);</li>
        <li>Formulário específico para inclusão (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documentação de Vínculo/Empresa: 
            <ul>
                <li>Titular (funcionário) – Vínculo empregatício (Relação de FGTS + Comprovante de Quitação – Atualizada). Quando o funcionário for recém-admitido (até 30 dias de admissão), deverá ser enviada a cópia da CTPS (carteira de trabalho – páginas com foto/assinatura, dados pessoais e de admissão) e cópia do CAGED.</li>
                <li>Titular (sócio) – Cópia do Contrato Social e Última Alteração.</li>
            </ul>
        </li>
        <li>Documentação Pessoal:
            <ul>
                <li>Titular – Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do comprovante de endereço e cópia do CPF.</li>
                <li>Dependente (s) Elegíveis - Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do CPF, cópia de Certidão de Nascimento e cópia de Certidão de Casamento.</li>
            </ul>
        </li>
    
        
        <?
        }
        elseif ($plano =='SULAMERICA') {
        ?>
        <li>Formulário específico para inclusão (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documentação de Vínculo/Empresa: 
            <ul>
                <li>Titular (funcionário) – Vínculo empregatício (Relação de FGTS + Comprovante de Quitação – Atualizada). Quando o funcionário for recém-admitido (até 30 dias de admissão), deverá ser enviada a cópia da CTPS (carteira de trabalho – páginas com foto/assinatura, dados pessoais e de admissão) e cópia do CAGED.</li>
                <li>Titular (sócio) – Cópia do Contrato Social e Última Alteração.</li>
            </ul>
         </li>
    
        <li>Documentação Pessoal:
            <ul>
                <li>Titular – Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do comprovante de endereço e cópia do CPF.</li>
                <li>Dependente (s) Elegíveis - Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do CPF, cópia de Certidão de Nascimento e cópia de Certidão de Casamento.</li>
            </ul>
        </li>
        <?
        }
        elseif ($plano =='PROMED') {
        ?>
        <li><a href="https://compactasaude.com.br/artigos/1931_Declaração%20de%20saúde%20Promed.pdf" target="_blank" title="Clique para abrir o documento">Declaração de Saúde</a></li>
        <li>Documentação Pessoal:
            <ul>
                <li>Dependente (s) Elegíveis - Cópia de Documento de Identificação Oficial (RG, CNH, outros), cópia do CPF, cópia de Certidão de Nascimento e cópia de Certidão de Casamento.</li>
            </ul>
        </li>
        
        <?
        } else{
        ?>
        <li>Titular:
            <ul>
                <li>Comprovante de vínculo com a empresa;</li>
                <li>Documentos Pessoais</li>
            </ul>
        </li>
        
        <li>Dependente:
            <ul>
                <li>Documentos Pessoais</li>
            </ul>
        </li>
        <?
        }
        ?>
        
        </span>
        
        
        <p style="color:#F00;">
          <strong>ATEN&Ccedil;&Atilde;O!</strong><br />
          <ul>
            <li>A documenta&ccedil;&aring;o solicitada dever&aacute; ser anexada no sistema abaixo.</li>
            <li>Nenhuma solicita&ccedil;&atilde;o ser&aacute; processada caso os documentos solicitados
    n&atilde;o sejam enviados ou se os dados informados estiverem incorretos.</li>
            
          </ul>
        </p>
        </td>
    	<td valign="top" align="left" width="33%" style="border:solid; border-width:1px; border-color:#CCC;">
        
        	<div>
            <form action="upload.php" method="post" enctype="multipart/form-data">
            <table width="100%" border="0">
              <tr>
                <td align="center">
                	<input type="hidden" name="id" value="<?php echo $_GET['id'] ?>" />
                    <input type="hidden" name="tipo" value="<?php echo $_GET['tipo'] ?>" /><br />
                    <span style="color:#F00;">Para anexar os documentos, selecione os arquivos dentro do seu computador e clique em 'Anexar Documentos'.</span><BR /><BR />
                	<input type="file" name="arquivos[]" multiple style="border:solid; border-width:1px; border-color:#CCC; width:100%; height:100%;"><BR /><BR />
                </td>
              </tr>
              <tr>
                <td align="center"><input type="submit" value="Anexar documentos" style="background-color:#02335C; color:#FFF; padding:5px; border-radius:10px; font-size:16px; font-weight:bold;"></td>
              </tr>
            </table>
        	</form>
            
			
			</div>
        </td>
        <td valign="top" width="33%" style="border:solid; border-width:1px; border-color:#CCC;">
        	<div id="docinseridos">		
			<?php
			// pega o endereço do diretório
			$diretorio = getcwd(); 
			$pastax=str_replace("album",'documentos\\'.$_GET['id'], $diretorio);
			
			
			if(is_dir($pastax)){
				// abre o diretório
				$ponteiro  = opendir($pastax);
				// monta os vetores com os itens encontrados na pasta
				while ($nome_itens = readdir($ponteiro)) {
					$itens[] = $nome_itens;
				}
				// ordena o vetor de itens
				sort($itens);
				// percorre o vetor para fazer a separacao entre arquivos e pastas 
				foreach ($itens as $listar) {
				// retira "./" e "../" para que retorne apenas pastas e arquivos
				   if ($listar!="." && $listar!=".."){ 
				
				// checa se o tipo de arquivo encontrado é uma pasta
						if (is_dir($listar)) { 
				// caso VERDADEIRO adiciona o item à variável de pastas
							$pastas[]=$listar; 
						} else{ 
				// caso FALSO adiciona o item à variável de arquivos
							$arquivos[]=$listar;
						}
				   }
				}
			
				// lista as pastas se houverem
				if ($pastas != "" ) { 
				foreach($pastas as $listar){
				   print "Pasta: <a href='$listar'>$listar</a><br>";}
				   }
				// lista os arquivos se houverem
				if ($arquivos != "") {
				foreach($arquivos as $listar){
				
				echo "Arquivo: ";
					
					  echo "<a href='../documentos/".$_GET["id"]."/".$listar."' TITLE='VISUALIZAR ARQUIVO' target=_blank>".$listar."</a><br>";
				 }
				}
			}else{
				echo 'Nenhum Documento inserido!';	
			}
			?>
            </div>
        </td>
    </tr>
    <tr>
    	<td colspan="3" align="center" style="border-top:solid; border-top-color:#000; border-top-width:1px;" class="texto">
        Ap&oacute;s conferir os documentos inseridos, clique no bot&atilde;o abaixo:
       
        </td>
    </tr>
    <tr>
    	<td colspan="3" align="center">
        <input type="button" value="Enviar Solicita&ccedil;&atilde;o" style="background-color:#315E95; color:#FFF;  border:solid; border-width:1px; border-radius:10px; border-color:#009; font-size:22px; font-weight:bold; padding:10px; cursor:pointer" onclick="FechaJanela(<? echo $protocolo?>);" /> </td>
    </tr>
    
    
   
</table>

	<?PHP //echo $_SERVER['DOCUMENT_ROOT']
			
	$rs->Close();
	$conn->Close();
	
	$rs = null;
	$conn = null;
	?>


</body>
</html>
<script>
function CarregaDiv(){
  	setInterval(horamonitora, 8000);
  }

function horamonitora(){
	
  $("#docinseridos").load('teste.php?id=<?php echo $_GET['id']?>');
  }
  
function FechaJanela(x){
	alert('Sua solicitacao foi enviada com sucesso!\nAcompanhe essa solicitacao no portal atraves do protocolo: '+x);
	
	window.location='../index.asp?go=movimentacoes';	
}
</script>