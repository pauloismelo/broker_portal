<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title>Carregando Documentos</title>


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
	<%
	Set Conexao = CreateObject("ADODB.CONNECTION")
	conStr="Provider=SQLOLEDB;Data Source=189.113.160.110;Initial Catalog=compacta;User Id=compacta;Password=1974xd-1974c032"
	ConexaoAberta = FALSE
	Sub AbreConexao()
		if not ConexaoAberta then
		Conexao.Open ConStr
		ConexaoAberta = True
		end if
	end sub
	Sub FechaConexao()
		if ConexaoAberta then
		Conexao.close
		ConexaoAberta = False
		end if
	end sub 
	%>
    
    <?php
    
    
    
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
			1&deg; Passo - Documentos necess&aacute;rios
    	</td>
        <td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;" class="Arial_azulEscuro">
			2&deg; Passo - Inserir Novos Documentos
    	</td>
        <td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px;" class="Arial_azulEscuro">
			3&deg; Passo - Conferir Documentos Inseridos
    	</td>
	</tr>
    <tr>
        <td align="left" valign="top" width="33%">
        Abaixo voc&ecirc; encontrar&aacute; a lista de documentos necess&aacute;rios para a sua solicita&ccedil;&atilde;o.
        
        <span >
        <?
        if ($plano =='AMIL'){
            ?>
        
        <li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documenta��o de V�nculo/Empresa: 
            <ul>
                <li> Titular (funcion�rio) � V�nculo empregat�cio (Rela��o de FGTS + Comprovante de Quita��o � Atualizada).<br /> Quando o funcion�rio for rec�m-admitido (at� 30 dias de admiss�o), dever� ser enviada a c�pia da CTPS (carteira de trabalho � p�ginas com foto/assinatura, dados pessoais e de admiss�o) e c�pia do CAGED.</li>
    
                <li>Titular (s�cio) � C�pia do Contrato Social e �ltima Altera��o.</li>
            </ul>
    
        </li>
        <li>Documenta��o Pessoal:
            <ul>
            
                <li>Titular � C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do comprovante de endere�o e c�pia do CPF.</li>
                <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
            </ul>
        </li>
        <?
        }
        elseif ($plano =='BRADESCO') {
        ?>
        <li>Carta com a solicita��o da empresa em papel timbrado ou com carimbo de CNPJ especificando a data da inclus�o com o dia, m�s e ano (a partir de...);</li>
        <li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documenta��o de V�nculo/Empresa: 
            <ul>
                <li>Titular (funcion�rio) � V�nculo empregat�cio (Rela��o de FGTS + Comprovante de Quita��o � Atualizada). Quando o funcion�rio for rec�m-admitido (at� 30 dias de admiss�o), dever� ser enviada a c�pia da CTPS (carteira de trabalho � p�ginas com foto/assinatura, dados pessoais e de admiss�o) e c�pia do CAGED.</li>
                <li>Titular (s�cio) � C�pia do Contrato Social e �ltima Altera��o.</li>
            </ul>
        </li>
        <li>Documenta��o Pessoal:
            <ul>
                <li>Titular � C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do comprovante de endere�o e c�pia do CPF.</li>
                <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
            </ul>
        </li>
    
        
        <?
        }
        elseif ($plano =='SULAMERICA') {
        ?>
        <li>Formul�rio espec�fico para inclus�o (Titular, Titular + Dependente (s) e Apenas Dependente (s));</li>
        <li>Documenta��o de V�nculo/Empresa: 
            <ul>
                <li>Titular (funcion�rio) � V�nculo empregat�cio (Rela��o de FGTS + Comprovante de Quita��o � Atualizada). Quando o funcion�rio for rec�m-admitido (at� 30 dias de admiss�o), dever� ser enviada a c�pia da CTPS (carteira de trabalho � p�ginas com foto/assinatura, dados pessoais e de admiss�o) e c�pia do CAGED.</li>
                <li>Titular (s�cio) � C�pia do Contrato Social e �ltima Altera��o.</li>
            </ul>
         </li>
    
        <li>Documenta��o Pessoal:
            <ul>
                <li>Titular � C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do comprovante de endere�o e c�pia do CPF.</li>
                <li>Dependente (s) Eleg�veis - C�pia de Documento de Identifica��o Oficial (RG, CNH, outros), c�pia do CPF, c�pia de Certid�o de Nascimento e c�pia de Certid�o de Casamento.</li>
            </ul>
        </li>
        <?
        }
        elseif ($plano =='PROMED') {
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
        <li>Titular:
            <ul>
                <li>Comprovante de v�nculo com a empresa;</li>
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
            <li style="color:#F00;">Se voc&ecirc; est&aacute; com dificuldade para anexar os arquivos, <a href="https://get.adobe.com/flashplayer/" target="_blank">clique aqui</a> e selecione "permitir".</li>
          </ul>
        </p>
        </td>
    	<td valign="top" align="left" width="33%" style="border:solid; border-width:1px; border-color:#CCC;">
        <ul>
        <li>
        1&deg; - Clique no bot&atilde;o "Achar Arquivos" para localizar os arquivos no seu computador.<span style="color:#F00;"> Se o bot&atilde;o "Achar Arquivos" n&atilde;o estiver aparecendo para voc&ecirc;, <a href="https://get.adobe.com/flashplayer/" target="_blank">clique aqui</a> e selecione "permitir".</span></li>
        <li>
        2&deg; - Assim que os arquivos selecionados aparecerem na lista abaixo, clique no bot&atilde;o "Gravar arquivos".
        </li>
        <li>
        3&deg; - Automaticamente os arquivos aparecer&atilde;o na lista &agrave; direita(3&deg; Passo).
        </li>
        </ul>
        	<div>
            <?php date_default_timezone_set('America/Sao_Paulo');
			$date = date('d-m-Y');
			$date = str_replace('-','', $date);
			$nomecliente = $rs['nome'];?>
			
			<div id="fileQueue"></div>
			<input type="file" name="uploadify" id="uploadify" />
			<a href="javascript:jQuery('#uploadify').uploadifyUpload()"><img src="gravar.jpg" width="110" height="30" border="0" hspace="4" vspace="0"  /></a><a href="javascript:jQuery('#uploadify').uploadifyClearQueue()"><img src="limpar.jpg" width="110" height="30" hspace="4" vspace="0" border="0"  /></a>
			
			</div>
        </td>
        <td valign="top" width="33%" style="border:solid; border-width:1px; border-color:#CCC;">
        	<div id="docinseridos">		
			<?php
			// pega o endere�o do diret�rio
			$diretorio = getcwd(); 
			$pastax=str_replace("album",'documentos\\'.$_GET['id'], $diretorio);
			
			
			if(is_dir($pastax)){
				// abre o diret�rio
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
				
				// checa se o tipo de arquivo encontrado � uma pasta
						if (is_dir($listar)) { 
				// caso VERDADEIRO adiciona o item � vari�vel de pastas
							$pastas[]=$listar; 
						} else{ 
				// caso FALSO adiciona o item � vari�vel de arquivos
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