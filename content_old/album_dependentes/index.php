<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

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
</head>

<body><div align="center">
<table width="100%">
<tr>
    <td colspan="2" align="left" style="padding:15px;">
    <span ><strong>ATEN&Ccedil;&Atilde;O: </strong><br />
        Nenhuma solicita&ccedil;&atilde;o ser&aacute; processada caso os documentos solicitados
n&atilde;o sejam enviados ou se os dados informados estiverem incorretos.<br />
	<br />
	<br />
    <strong>Documenta��o Necess�ria para Inclus�o:</strong><br />
    <?php
    $plano = $_GET['plano'];
	//echo ($plano);
	if ($plano =='SAUDE-AMIL' || $plano == 'ODONTO-AMIL'){?>  
    <li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
    
    <li>Documenta��o Pessoal:
    	<ul>
			<li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
        </ul>
    </li>
    <?
    }
	elseif ($plano =='SAUDE-BRADESCO' || $plano == 'ODONTO-BRADESCO') {
    ?>
    <li>Carta com a solicita��o da empresa em papel timbrado ou com carimbo de CNPJ especificando a data da inclus�o com o dia, m�s e ano (a partir de...);</li>
	<li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
	<li>Documenta��o Pessoal:
        <ul>
            <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
        </ul>
    </li>

    
    <?
	}
	elseif ($plano =='SAUDE-SULAMERICA' || $plano == 'ODONTO-SULAMERICA') {
    ?>
    <li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
	<li>Documenta��o Pessoal:
    	<ul>
            <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
        </ul>
    </li>
      <?
    }
	elseif ($plano =='SAUDE-PROMED' || $plano == 'ODONTO-PROMED') {
    ?>
    <li><a href="https://compactasaude.com.br/artigos/1931_Declara��o%20de%20sa�de%20Promed.pdf" target="_blank" title="Clique para abrir o documento">Declara��o de Sa�de</a></li>
    <li>Documenta��o Pessoal:
    	<ul>
            <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
        </ul>
    </li>
    <?
	} else{
	?>
    
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
      <strong>ATEN��O!<br />
      A documenta��o solicitada dever� ser anexada no sistema abaixo.<br /> Se voc� est� com dificuldade para anexar os arquivos, <a href="https://get.adobe.com/flashplayer/" target="_blank">clique aqui</a> e selecione "permitir".</strong>
    </p>
    </td>
    </tr>
</table>
<br />

<?php date_default_timezone_set('America/Sao_Paulo');
$date = date('d-m-Y');
$date = str_replace('-','', $date);
?>

<div style="font-size:24px; background-color:#D9E8FF; padding:12px;">
Inserindo documentos para o protocolo: <b><?php echo $date; echo $_GET['id']?></b>
</div>
<br />
<div id="fileQueue"></div>
<input type="file" name="uploadify" id="uploadify" />
<a href="javascript:jQuery('#uploadify').uploadifyUpload()"><img src="gravar.jpg" width="110" height="30" border="0" hspace="4" vspace="0"  /></a><a href="javascript:jQuery('#uploadify').uploadifyClearQueue()"><img src="limpar.jpg" width="110" height="30" hspace="4" vspace="0" border="0"  /></a>
<?PHP //echo $_SERVER['DOCUMENT_ROOT']?>
</div>
</body>
</html>
