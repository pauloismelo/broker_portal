<div style="width:100%; text-align:center;">
	<img src="img/loading3.gif">
</div>
<?php	
	// define('mpdf60/', 'class/mpdf/');
	set_time_limit(360);
	
	$pasta=$_SERVER['DOCUMENT_ROOT']."\RELATORIO_BENEFICIARIOS";
	//echo $pasta;
	//exit;
	include("mpdf60/mpdf.php");

	$pdf_name="RELATORIO_BENEFICIARIOS-".$_REQUEST['idcadvenda']."-".date("Y-m-d").".pdf";
	$file_location =$pasta."/".$pdf_name;
	
	$my_url="https://portalcompacta.com.br/relatorio_beneficiarios.asp?id=".$_REQUEST['idcadvenda']."&idcadastro=".$_REQUEST['idcadastro'];
	//$my_url="https://plataformacompacta.com.br/multicalculo_manual-view.asp?id=".$_REQUEST['id'];
  	//$html=file_get_contents($my_url);
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch,CURLOPT_URL,$my_url);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13");
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 0); 
	curl_setopt($ch, CURLOPT_TIMEOUT, 600); //timeout in seconds server está com 400 segundos
	$html = curl_exec($ch);
	curl_close($ch);
	
    $mpdf=new mPDF(); 
	$mpdf->SetDisplayMode('fullpage');	
	$mpdf -> allow_charset_conversion=true;
	$mpdf -> charset_in='iso-8859-1';
	//$mpdf -> use_kwt = true; 
	$css = file_get_contents("css/estilo.css");
	$mpdf->WriteHTML($css,1);
	$mpdf->WriteHTML($html);
	$mpdf->Output($file_location,'F');

	$redirect="https://www.portalcompacta.com.br/relatorio_beneficiarios_email.asp?idcadvenda=".$_REQUEST['idcadvenda']."&idcadastro=".$_REQUEST['idcadastro']."&user=".$_REQUEST['user'];
	header("location:$redirect");
    exit();
  
  
  ?>