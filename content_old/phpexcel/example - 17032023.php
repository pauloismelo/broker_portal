<meta charset="iso-8859-1">
<?php
/**
 * PHPExcel
 *
 * Copyright (c) 2006 - 2015 PHPExcel
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * @category   PHPExcel
 * @package    PHPExcel
 * @copyright  Copyright (c) 2006 - 2015 PHPExcel (http://www.codeplex.com/PHPExcel)
 * @license    http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt	LGPL
 * @version    ##VERSION##, ##DATE##
 */
 
 
	

/** Error reporting */
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
ini_set('default_charset', "iso-8859-1");
date_default_timezone_set('Europe/London');

define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');

/** Include PHPExcel */
require_once dirname(__FILE__) . '/vendor/phpoffice/phpexcel/Classes/PHPExcel.php';

// Create new PHPExcel object
echo date('H:i:s') , " Create new PHPExcel object" , EOL;
$objPHPExcel = new PHPExcel();


$comAcentos = array('à', 'á', 'â', 'ã', 'ä', 'å', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ù', 'ü', 'ú', 'ÿ', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'O', 'Ù', 'Ü', 'Ú');

$semAcentos = array('a', 'a', 'a', 'a', 'a', 'a', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'u', 'u', 'u', 'y', 'A', 'A', 'A', 'A', 'A', 'A', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'N', 'O', 'O', 'O', 'O', 'O', '0', 'U', 'U', 'U');

// Set document properties
echo date('H:i:s') , " Set document properties" , EOL;
$objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
							 ->setLastModifiedBy("Maarten Balliauw")
							 ->setTitle("PHPExcel Test Document")
							 ->setSubject("PHPExcel Test Document")
							 ->setDescription("Test document for PHPExcel, generated using PHP classes.")
							 ->setKeywords("office PHPExcel php")
							 ->setCategory("Test result file");


// Add some data
echo date('H:i:s') , " Add some data" , EOL;



// Dados do banco
$dbhost = "189.113.160.110";
$user = "compacta";
$password = "1974xd-1974c032";
$db = "compacta";

$conninfo = array("Database" => $db, "UID" => $user, "PWD" => $password);
$conn = sqlsrv_connect($dbhost, $conninfo);

$instrucaoSQL = "select id,edependente,status2,titular,iddependente,redecontratada,idfilial,vlrmensalidadeatual,cpf,codigo from CADASTROGERAL where idcadvenda=".$_GET['id']." and etitular='s' and status2='ATIVO' OR coproduto='".$_GET['id']."' and etitular='s' and status2='ATIVO' order by titular asc";
//$instrucaoSQL = "select * from TB_MOVIMENTACOES where tipo='INCLUSAO' and status='AGUARDANDO VIGENCIA' and vigencia='".date("Y-m-d")."' order by id asc"; //ordenei por id pois estava ordenado por id_titular. Dessa antiga forma, o dependente entrava primeiro e consequentemente nao encontrava o id do seu titular ja cadastrado. feito 10/08/2022

//echo $instrucaoSQL;
//exit;
$params = array();
$options =array("Scrollable" => SQLSRV_CURSOR_KEYSET);
$consulta = sqlsrv_query($conn, $instrucaoSQL, $params, $options);
$numRegistros = sqlsrv_num_rows($consulta);


if ($numRegistros!=0) {
	
	$objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
	$objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
	$objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
	$objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(25);
	
	
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A1', 'Relatorio de Beneficiarios Ativos')
				->setCellValue('B1', '')
				->setCellValue('C1', '')
				->setCellValue('D1', '')
				->setCellValue('E1', '')
				->setCellValue('F1', '')
				->setCellValue('G1', '')
				->setCellValue('H1', '');
	
	$objPHPExcel->getActiveSheet()->mergeCells('A1:H1');	
	$objPHPExcel->getActiveSheet()->getStyle("A1")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("A1:H1")->getFont()->setSize(18);
	$objPHPExcel->getActiveSheet()->getStyle("A1:H1")->getFont()->setBold(true);
		
		
		function Altera($string){
		
		$string2=str_replace("Á","A",$string);
		$string2=str_replace("À","A",$string2);
		$string2=str_replace("Â","A",$string2);
		$string2=str_replace("Ã","A",$string2);
		$string2=str_replace("É","E",$string2);
		$string2=str_replace("È","E",$string2);
		$string2=str_replace("Ê","E",$string2);
		$string2=str_replace("Í","I",$string2);
		$string2=str_replace("Ì","I",$string2);
		$string2=str_replace("Ó","O",$string2);
		$string2=str_replace("Ò","O",$string2);
		$string2=str_replace("Ô","O",$string2);
		$string2=str_replace("Õ","O",$string2);
		$string2=str_replace("Ú","U",$string2);
		$string2=str_replace("Ù","U",$string2);
		
		$string2=str_replace("á","a",$string2);
		$string2=str_replace("à","a",$string2);
		$string2=str_replace("ã","a",$string2);
		$string2=str_replace("â","a",$string2);
		$string2=str_replace("é","e",$string2);
		$string2=str_replace("è","e",$string2);
		$string2=str_replace("í","i",$string2);
		$string2=str_replace("ì","i",$string2);
		$string2=str_replace("ó","o",$string2);
		$string2=str_replace("ò","o",$string2);
		$string2=str_replace("ô","o",$string2);
		$string2=str_replace("õ","o",$string2);
		$string2=str_replace("ú","u",$string2);
		$string2=str_replace("ù","u",$string2);
		
		$string2=str_replace("Ç","C",$string2);
		$string2=str_replace("ç","c",$string2);
		
		return $string2;
	}
		
		
	$SQL = "select titular from CADASTROGERAL where id=".$_GET['idcadastro']." ";
	$consultatit = sqlsrv_query($conn, $SQL, $params, $options);
	$rstit = sqlsrv_fetch_array($consultatit, SQLSRV_FETCH_ASSOC);
	
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A2', Altera($rstit['titular']))
				->setCellValue('B2', '')
				->setCellValue('C2', '')
				->setCellValue('D2', '')
				->setCellValue('E2', '')
				->setCellValue('F2', '')
				->setCellValue('G2', '')
				->setCellValue('H2', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A2:H2');
	
	
	
	
	$SQLvenda = "select ramo, operadora, codigo, nome_amigavel, vencimento, dvigencia,diafaturamento_inclusao,diafaturamento_exclusao from CADASTROGERAL_VENDAS where id=".$_GET['id']." ";
	$consultavenda = sqlsrv_query($conn, $SQLvenda, $params, $options);
	$rsvenda = sqlsrv_fetch_array($consultavenda, SQLSRV_FETCH_ASSOC);
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A3', 'Contrato: '.$rsvenda['ramo'].'.'.$rsvenda['operadora'])
				->setCellValue('B3', '')
				->setCellValue('C3', '')
				->setCellValue('D3', '')
				->setCellValue('E3', '')
				->setCellValue('F3', '')
				->setCellValue('G3', '')
				->setCellValue('H3', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A3:H3');
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A4', 'Cod.: '.$rsvenda['codigo'].' - '.$rsvenda['nome_amigavel'])
				->setCellValue('B4', '')
				->setCellValue('C4', '')
				->setCellValue('D4', '')
				->setCellValue('E4', '')
				->setCellValue('F4', '')
				->setCellValue('G4', '')
				->setCellValue('H4', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A4:H4');
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A5', 'Vencimento da Fatura: '.$rsvenda['vencimento'])
				->setCellValue('B5', '')
				->setCellValue('C5', '')
				->setCellValue('D5', '')
				->setCellValue('E5', '')
				->setCellValue('F5', '')
				->setCellValue('G5', '')
				->setCellValue('H5', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A5:H5');
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A6', 'Corte da fatura p/ inclusao: '.$rsvenda['diafaturamento_inclusao'])
				->setCellValue('B6', '')
				->setCellValue('C6', '')
				->setCellValue('D6', '')
				->setCellValue('E6', '')
				->setCellValue('F6', '')
				->setCellValue('G6', '')
				->setCellValue('H6', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A6:H6');
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A7', 'Corte da fatura p/ exclusao: '.$rsvenda['diafaturamento_exclusao'])
				->setCellValue('B7', '')
				->setCellValue('C7', '')
				->setCellValue('D7', '')
				->setCellValue('E7', '')
				->setCellValue('F7', '')
				->setCellValue('G7', '')
				->setCellValue('H7', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A7:H7');
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A8', 'Vigencia: '.date_format($rsvenda['dvigencia'],"d/m/Y"))
				->setCellValue('B8', '')
				->setCellValue('C8', '')
				->setCellValue('D8', '')
				->setCellValue('E8', '')
				->setCellValue('F8', '')
				->setCellValue('G8', '')
				->setCellValue('H8', '');
	$objPHPExcel->getActiveSheet()->mergeCells('A8:H8');
	
	
				
				
	
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A9', '#')
				->setCellValue('B9', 'Tipo')
				->setCellValue('C9', 'Nome')
				->setCellValue('D9', 'CPF')
				->setCellValue('E9', 'Matricula')
				->setCellValue('F9', 'Plano')
				->setCellValue('G9', 'Unidade')
				->setCellValue('H9', 'Valor');
	$objPHPExcel->getActiveSheet()->getStyle("A9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("B9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("D9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("E9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("F9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("G9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("H9")->getAlignment()->setHorizontal('center');
	$objPHPExcel->getActiveSheet()->getStyle("A9:H9")->getFont()->setBold(true);
	
	$linha=9;
	$contador=0;
	
	
	

	
	while ($rs = sqlsrv_fetch_array($consulta, SQLSRV_FETCH_ASSOC)) {
		
		$unidade='';
		$titular = Altera($rs['titular']);
		//$titular=str_replace($comAcentos, $semAcentos, $rs['titular']);
		//echo $titular.'<br>';
		$linha++;
		$contador++;
		if($rs['edependente']=='s'){
			$dependente='D';
		}else{
			$dependente='T';
		}
		
		//buscar rede contratada
			if ($rs['edependente']=='s'){	
					
				$sqlrede="select redecontratada from CADASTROGERAL where id=".$rs["iddependente"]." ";
			
				$consultarede = sqlsrv_query($conn, $sqlrede, $params, $options);
				$rsrede = sqlsrv_fetch_array($consultarede, SQLSRV_FETCH_ASSOC);
				$numRegistrosrede = sqlsrv_num_rows($consultarede);
				if ($numRegistrosrede!=0){
					if (is_numeric($rsrede['redecontratada'])){
							
							$sqlplano="select nome,acomodacao from CADASTROGERAL_PLANOS where id=".$rsrede["redecontratada"]."  ";
			
							$consultaplano = sqlsrv_query($conn, $sqlplano, $params, $options);
							$rsplano = sqlsrv_fetch_array($consultaplano, SQLSRV_FETCH_ASSOC);
							$numRegistrosplano = sqlsrv_num_rows($consultaplano);
							if ($numRegistrosplano!=0){
								$rede=$rsplano['nome'].' '.$rsplano['acomodacao'].'';
							}
							
					}else{
						$rede=$rsrede['redecontratada'];
					}
				}
			}else{
				
				if (is_numeric($rs['redecontratada'])){
							
						$sqlplano="select nome,acomodacao from CADASTROGERAL_PLANOS where id=".$rs["redecontratada"]."  ";
		
						$consultaplano = sqlsrv_query($conn, $sqlplano, $params, $options);
						$rsplano = sqlsrv_fetch_array($consultaplano, SQLSRV_FETCH_ASSOC);
						$numRegistrosplano = sqlsrv_num_rows($consultaplano);
						if ($numRegistrosplano!=0){
							$rede=$rsplano['nome'].' '.$rsplano['acomodacao'].'';
						}
						
				}else{
					$rede=$rs['redecontratada'];
				}
				
			}
		//fim buscar rede contratada
		
		
		//buscar unidade
			if (empty($rs['idfilial']) or $rs['idfilial']=='0'){
				$unidade='MATRIZ';
			}else{
				
				$sqlfilial="select nome from CADASTROGERAL_FILIAL where id=".$rs["idfilial"]." and idcadastro=".$_GET['idcadastro']." or  numero=".$rs["idfilial"]." and idcadastro=".$_GET['idcadastro']." ";
				
				$consultafilial = sqlsrv_query($conn, $sqlfilial, $params, $options);
				$rsfilial = sqlsrv_fetch_array($consultafilial, SQLSRV_FETCH_ASSOC);
				$numRegistrosfilial = sqlsrv_num_rows($consultafilial);
				if ($numRegistrosfilial!=0){
					$unidade=$rsfilial['nome'];
				}else{
					$unidade='MATRIZ';
				}
			}
		//fim buscar unidade
		
		$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A'.$linha, $contador)
				->setCellValue('B'.$linha, $dependente)
				->setCellValue('C'.$linha, $titular)
				->setCellValue('D'.$linha, $rs['cpf'])
				->setCellValue('E'.$linha, $rs['codigo'])
				->setCellValue('F'.$linha, $rede)
				->setCellValue('G'.$linha, $unidade)
				->setCellValue('H'.$linha, $rs['vlrmensalidadeatual']);
				
				$titular='';
				
		$objPHPExcel->getActiveSheet()->getStyle("A".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("B".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("C".$linha)->getAlignment()->setHorizontal('left');
		$objPHPExcel->getActiveSheet()->getStyle("D".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("E".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("F".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("G".$linha)->getAlignment()->setHorizontal('center');
		$objPHPExcel->getActiveSheet()->getStyle("H".$linha)->getAlignment()->setHorizontal('center');
		
		
		//se houver dependente
		$sqldepe="select id,edependente,status2,titular,iddependente,redecontratada,idfilial,vlrmensalidadeatual,cpf,codigo from CADASTROGERAL where idcadvenda=".$_GET['id']." and etitular='n' and edependente='s' and iddependente=".$rs['id']." and status2='ATIVO' or coproduto=".$_GET['id']." and etitular='n' and edependente='s' and iddependente=".$rs['id']." and status2='ATIVO' ";
				
		$consultadepe = sqlsrv_query($conn, $sqldepe, $params, $options);
		$rsdepe = sqlsrv_fetch_array($consultadepe, SQLSRV_FETCH_ASSOC);
		$numRegistrosdepe = sqlsrv_num_rows($consultadepe);
		if ($numRegistrosdepe!=0){
			
			$linha++;
			$contador++;
			
			
			$objPHPExcel->setActiveSheetIndex(0)
					->setCellValue('A'.$linha, $contador)
					->setCellValue('B'.$linha, 'D')
					->setCellValue('C'.$linha, Altera($rsdepe['titular']))
					->setCellValue('D'.$linha, $rsdepe['cpf'])
					->setCellValue('E'.$linha, $rsdepe['codigo'])
					->setCellValue('F'.$linha, $rede)
					->setCellValue('G'.$linha, $unidade)
					->setCellValue('H'.$linha, $rsdepe['vlrmensalidadeatual']);
				
			$objPHPExcel->getActiveSheet()->getStyle("A".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("B".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("C".$linha)->getAlignment()->setHorizontal('left');
			$objPHPExcel->getActiveSheet()->getStyle("D".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("E".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("F".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("G".$linha)->getAlignment()->setHorizontal('center');
			$objPHPExcel->getActiveSheet()->getStyle("H".$linha)->getAlignment()->setHorizontal('center');


		}
		
	}
	/*
	//Miscellaneous glyphs, UTF-8
	$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A4', 'Miscellaneous glyphs')
				->setCellValue('A5', 'éàèùâêîôûëïüÿäöüç');
	
	
	$objPHPExcel->getActiveSheet()->setCellValue('A8',"Hello\nWorld");
	$objPHPExcel->getActiveSheet()->getRowDimension(8)->setRowHeight(-1);
	$objPHPExcel->getActiveSheet()->getStyle('A8')->getAlignment()->setWrapText(true);
	
	
	$value = "-ValueA\n-Value B\n-Value C";
	$objPHPExcel->getActiveSheet()->setCellValue('A10', $value);
	$objPHPExcel->getActiveSheet()->getRowDimension(10)->setRowHeight(-1);
	$objPHPExcel->getActiveSheet()->getStyle('A10')->getAlignment()->setWrapText(true);
	$objPHPExcel->getActiveSheet()->getStyle('A10')->setQuotePrefix(true);
	
	*/
	
	// Rename worksheet
	echo date('H:i:s') , " Rename worksheet" , EOL;
	$objPHPExcel->getActiveSheet()->setTitle('Simple');
	
	
	// Set active sheet index to the first sheet, so Excel opens this as the first sheet
	$objPHPExcel->setActiveSheetIndex(0);
	
	
	// Save Excel 2007 file
	echo date('H:i:s') , " Write to Excel2007 format" , EOL;
	$callStartTime = microtime(true);
	
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	//$objWriter->save(str_replace('.php', '.xlsx', __FILE__));
	$objWriter->save('Relatorio_Ativos.xlsx');
	$callEndTime = microtime(true);
	$callTime = $callEndTime - $callStartTime;
	
	echo date('H:i:s') , " File written to " , str_replace('.php', '.xlsx', pathinfo(__FILE__, PATHINFO_BASENAME)) , EOL;
	echo 'Call time to write Workbook was ' , sprintf('%.4f',$callTime) , " seconds" , EOL;
	// Echo memory usage
	echo date('H:i:s') , ' Current memory usage: ' , (memory_get_usage(true) / 1024 / 1024) , " MB" , EOL;
	
	
	// Save Excel 95 file
	echo date('H:i:s') , " Write to Excel5 format" , EOL;
	$callStartTime = microtime(true);
	
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
	$objWriter->save(str_replace('.php', '.xls', __FILE__));
	$callEndTime = microtime(true);
	$callTime = $callEndTime - $callStartTime;
	
	echo date('H:i:s') , " File written to " , str_replace('.php', '.xls', pathinfo(__FILE__, PATHINFO_BASENAME)) , EOL;
	echo 'Call time to write Workbook was ' , sprintf('%.4f',$callTime) , " seconds" , EOL;
	// Echo memory usage
	echo date('H:i:s') , ' Current memory usage: ' , (memory_get_usage(true) / 1024 / 1024) , " MB" , EOL;
	
	
	// Echo memory peak usage
	echo date('H:i:s') , " Peak memory usage: " , (memory_get_peak_usage(true) / 1024 / 1024) , " MB" , EOL;
	
	// Echo done
	echo date('H:i:s') , " Done writing files" , EOL;
	echo 'Files have been created in ' , getcwd() , EOL;
	
	//exit;
	$redirect="https://www.portalcompacta.com.br/phpexcel/envio_email.asp?idcadvenda=".$_REQUEST['id']."&idcadastro=".$_REQUEST['idcadastro']."&user=".$_REQUEST['user'];
	header("location:$redirect");
	

}else{
	echo 'IMPOSSIVEL GERAR O RELATORIO! <BR> Entre em contato com o Departamento Comercial!';	
}