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
		'folder'         : '/docs_exclusao',
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
    <td colspan="2" align="left" style="padding:15px;"><span ><strong>ATEN&Ccedil;&Atilde;O: </strong><br />
        Nenhuma solicita&ccedil;&atilde;o ser&aacute; processada caso os documentos solicitados
n&atilde;o sejam enviados ou se os dados informados estiverem incorretos.<br />
<br />
    <strong>Documentação Necessária para Inclusão:</strong><br />
    </span>
    <p style="color:#F00;">
      <strong>ATENÇÃO!<br />
      A documentação solicitada deverá ser anexada no sistema abaixo.<br /> Se você está com dificuldade para anexar os arquivos, <a href="https://get.adobe.com/flashplayer/" target="_blank">clique aqui</a> e selecione "permitir".</strong>
    </p></td>
    </tr>
</table>
<br />

<?php date_default_timezone_set('America/Sao_Paulo');
$date = date('d-m-Y');
$date = str_replace('-','', $date);
?>

<div style="font-size:24px; background-color:#F66; padding:12px;">
Inserindo documentos para o protocolo de exclus&atilde;o: <b><?php echo $date; echo $_GET['id']?></b>
</div>
<? if ($_GET['empresa']<>''){?>
<div style="font-size:18px; background-color:#EFEFEF; padding:12px;"><?=$_GET['empresa']?></div>
<? }?>
<? if ($_GET['titular']<>''){?>
<div style="font-size:18px; background-color:#DDD; padding:12px;"><?=$_GET['titular']?></div>
<? }?>
<? if ($_GET['dependente']<>''){?>
<div style="font-size:18px; background-color:#C7C7C7; padding:12px;"><?=$_GET['dependente']?></div>
<? }?>
<br />
<div id="fileQueue"></div>
<input type="file" name="uploadify" id="uploadify" />
<a href="javascript:jQuery('#uploadify').uploadifyUpload()"><img src="gravar.jpg" width="110" height="30" border="0" hspace="4" vspace="0"  /></a><a href="javascript:jQuery('#uploadify').uploadifyClearQueue()"><img src="limpar.jpg" width="110" height="30" hspace="4" vspace="0" border="0"  /></a>
<?PHP //echo $_SERVER['DOCUMENT_ROOT']?>
</div>
</body>
</html>
