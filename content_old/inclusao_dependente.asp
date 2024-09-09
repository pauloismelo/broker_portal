<script src="js/js.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
<script>
function getHTTPObject() { 
  var xmlhttp; 
  /*@cc_on 
  @if (@_jscript_version >= 5) 
    try { 
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); 
    } catch (e) { 
      try { 
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
      } catch (e) { 
        xmlhttp = false; 
      } 
    } 
  @else 
  xmlhttp = false; 
  @end @*/ 
  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') { 
    try { 
      xmlhttp = new XMLHttpRequest(); 
    } catch (e) { 
      xmlhttp = false; 
    } 
  } 
  return xmlhttp; 
} 
var http = getHTTPObject();

function ConsultaRegistro(x,y,w,k,a){
	if (document.getElementById("cpf").value==''){
		window.alert('Opção Invalida para consulta!');
	}else{
	 
	 
	if (k!=0){
		var data = k.split('-');
		var admissao = data[2]+'_'+data[1]+'_'+data[0];
		
		//alert('consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&data='+admissao+'&titular='+a);
		http.open("GET", 'consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&data='+admissao+'&titular='+a, true);
	}else{
		//alert('consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&titular='+a);
		http.open("GET", 'consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&titular='+a, true);
	}
	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);

	var arr; //array com os dados retornados
	function handleHttpResponse() 
	{
		if (http.readyState == 4) 
		{
			var response = http.responseText;
			eval("var arr = "+response); //cria objeto com o resultado
			//alert(arr.nome);
			if (arr.id!='-'){
			
			if (arr.tipo=='movimentacao'){
				window.alert('Encontramos uma solicitaçao em andamento para esse CPF!\nVocê será redirecionado para a tela de solicitações');
				window.location='index.asp?go=movimentacoes&pesq=ok&tipo='+arr.tipox+'&protocolo='+arr.protocolo+'&status='+arr.status;
			}else if (arr.tipo=='cadastro'){
				window.alert('O CPF '+arr.cpf+' se encontra ATIVO nesse contrato para o(a) beneficiario(a) '+arr.nome+'\n Você sera direcionado para o cadastro desse(a) beneficiario(a)');
				window.location='index.asp?go=contrato&id='+arr.contrato+'&pesq=ok&campo='+arr.cpf;
				
			}
			//window.location='index.asp?go=movimentacoes';
			//window.open('index.asp?go=movimentacoes')
			}
	
		}
	
	}
	}
}

function Confere(){
	var dnasc = document.getElementById('dnasc').value;
	var ano_atual = dnasc.getFullYear();
	
	if (ano_atual>=2005){
			alert('Preencha a data de nascimento!')
			document.getElementById('dnasc').focus();
	}else{
		document.getElementById('form01').submit();	
	}

}
</script>
<style type="text/css">
	.contLink a {
	 position: relative;
	 font: 12px Arial, Verdana,Helvetica,sans-serif;
	 text-decoration: none;
	 text-align: center;
	 padding: 1px 5px;
	 margin-right:-1px;
	}
	.contLink img { z-index: 1; }
	.contLink a:hover {
	z-index: 1;
	}
	
	.contLink a span { 
	 display:none;
	}
	.contLink a:hover span {
	 display: block;
	 position: absolute; 
	 top:20px; 
	 left:0; 
	 width: 200px;
	 padding: 2px 0; 
	 color: #666; 
	 background:#fffff0;
	 font-size: 12px; 
	 border:2px dotted #000; 
	 text-align:center;
	 z-index: 100;
	}
</style>


<%if request("gravar")="ok" then
	AbreConexao
	
	set tit=conexao.execute("select * from TB_MOVIMENTACOES where id="&request("idtitular")&"")
	if not tit.eof then
		plano=tit("plano")
		
		
		'busca o nome gravado no titular para encontrar o id na tabela
		'///////removido em 12/07/2023 Pois a variavel plano ja recebe o plano do titular
		'set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&plano&" ")
		'if not pla.eof then
		''	plano=pla("id")
		'end if
		'set pla=nothing
			
		
		acomodacao=tit("acomodacao")
		TXTtitular ="<br><br>TITULAR: "&ucase(tit("nome"))&""
		
		if tit("filial")<>""  then
			set fil=conexao.execute("select * from CADASTROGERAL_FILIAL where id="&tit("filial")&"")
			if not fil.eof then
				filialx2=tit("filial")
				TXTfilial="<br><br>FILIAL: "&ucase(fil("nome"))&""
			else
				filialx2=0
			end if
			set fil=nothing
		end if
		
		if tit("centrodecusto")<>""  then
			set cen=conexao.execute("select * from CADASTROGERAL_CENTROS where id="&tit("centrodecusto")&"")
			if not cen.eof then
				centrox2=tit("centrodecusto")
				TXTcentro="<br><br>CENTRO DE CUSTO: "&ucase(cen("nome"))&""
			else
				centrox2=0
			end if
			set cen=nothing
		else
			centrox=0
		end if
	end if
	
	
	
	set rs=conexao.execute("select * from TB_MOVIMENTACOES order by id desc")
	if rs.eof then
	idz=1
	else
	idz=rs("id")+1
	end if
	set rs=nothing
	


	protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&idz
	
	SQZ="insert into TB_MOVIMENTACOES (id, solicitacao_principal, nome, dnasc, cpf, sexo, ecivil, parentesco, mae, status, id_empresa, datareg, rg, rg_dataexpedicao, id_contrato, horareg, solpor, dinicio, datacob, descricao, tipo, cns, expedicaorg, tel, protocolo, dcasamento, centrodecusto, filial, plano, acomodacao, peso, altura) values("&idz&", "&request("idtitular")&", '"&request("nome")&"', '"&databr(request("dnasc"))&"', '"&request("cpf")&"', '"&request("sexo")&"', '"&request("ecivil")&"', '"&request("parentesco")&"', '"&request("mae")&"', 'ENVIADO', "&idx&", '"&databrx2(date)&"', '"&request("rg")&"', '"&databr(request("dataexpedicao"))&"', '"&request("plano")&"', '"&time&"', '"&userxy&"', '"&databr(request("datainicio"))&"', '"&datacob&"', '"&request("descricao")&"', 'INCLUSAO', '"&request("cns")&"', '"&request("expedicaorg")&"', '"&request("tel")&"', '"&protocolo&"', '"&databr(request("datacasamento"))&"', '"&centrox2&"', '"&filialx2&"', '"&plano&"', '"&ucase(acomodacao)&"', '"&request("peso")&"', '"&request("altura")&"')"
	'response.Write("<br><br>")
	'response.Write(SQZ)
	conexao.execute(SQZ)
	
	set cont=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&tit("id_contrato")&" ")
	if not cont.eof then
		ramo=cont("ramo")
		operadora=cont("operadora")
	end if
	set cont=nothing
	
	
	'====================================ENVIA EMAIL
	mailmanager=""
	set ma=conexao.execute("select * from CADASTROGERAL_USUARIOS where idcadastro="&idx&" and email_novainclusao='s'")
	if not ma.eof then
		while not ma.eof
			if mailmanager="" then
				mailmanager=ma("login")
			else
				mailmanager=mailmanager&";"&ma("login")
			end if
			
		ma.movenext
		wend
	end if
	set ma=nothing
	
	if mailmanager<>"" then
		sch = "http://schemas.microsoft.com/cdo/configuration/"
		Set cdoConfig = Server.CreateObject("CDO.Configuration")
		servidor_smtp = "mail.portalcompacta.com.br" 
		email_autentica = "noreply@portalcompacta.com.br" 
		senha_autentica = "7^5pey0B" 
		cdoConfig.Fields.Item(sch & "sendusing") = 2
		cdoConfig.Fields.Item(sch & "smtpauthenticate") = 1
		cdoConfig.Fields.Item(sch & "smtpserver") = servidor_smtp
		cdoConfig.Fields.Item(sch & "smtpserverport") = 587
		cdoConfig.Fields.Item(sch & "smtpconnectiontimeout") = 30
		cdoConfig.Fields.Item(sch & "sendusername") = email_autentica
		cdoConfig.Fields.Item(sch & "sendpassword") = senha_autentica
		cdoConfig.fields.update
		Set myMail=CreateObject("CDO.Message") 
		Set myMail.Configuration = cdoConfig
		myMail.Fields.update
		myMail.Subject="NOVA INCLUSAO DE DEPENDENTE SOLICITADA"
		myMail.From="PORTAL COMPACTA <"&email_autentica&">"
		myMail.To=mailmanager&""&emailx
		myMail.bcc="deman@compactasaude.com;informativo@compactasaude.com"
		myMail.HTMLBody="<body style='color:#666666; font-size:24px; font-family:Arial'><table border=0 cellpadding=0 cellspacing=0 align='center' style='min-width:500px; width:690px;'><tr><td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left'><a href='http://plataformacompacta.com.br/painel_login.asp' title='ENTRAR NO PORTAL DO CORRETOR'><img src='http://www.compactasaude.com.br/mailling/deman/logobeneficios.png' height='60'  border='0'></a></td><td style='color:#fff; text-align:right; font-weight:bold'>ACOMPANHAMENTO DE MOVIMENTAÇÕES<BR>NO PORTAL DO CLIENTE</td></tr></table></td></tr><tr><td align='center' valign=top style='padding:20px; border-radius:10px; color:#000; font-weight: 400;'  bgcolor='#fff'>Uma nova movimentação foi solicitada no Portal do Cliente da Compacta Beneficios</td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000;' bgcolor='#DFE8FD'>EMPRESA: "&titularx&"<br><br>CONTRATO: "&ramo&" . "&operadora&"<br><br> MOVIMENTAÇÃO: INCLUSÃO DE DEPENDENTE<br><br>PROTOCOLO DA SOLICITAÇÃO: "&protocolo&"<BR><br>BENEFICIÁRIO: "&ucase(request("nome"))&" "&TXTtitular&""&TXTfilial&""&TXTcentro&"</td></tr><tr><td width=100% align='center' valign=top bgcolor='#f8f9fa' style='border-radius:10px; padding:20px;'><a href='https://www.compactasaude.com.br/canalcliente/login/' style='font-weight: 400; font-size: 20px;  color:#06F; text-decoration:underline;'>CLIQUE AQUI PARA ACOMPANHAR NO PORTAL</a></td> </tr> <tr> <td height='30' align='center' bgcolor='#EBEBEB' style='padding:20px; font-size:14px; border-radius:10px;'><strong>SE NÃO HOUVER PENDÊNCIAS, ESSA SERÁ EXECUTADA EM ATÉ 48 HS ÚTEIS.<br><br>Solicitado por "&userxy&" em: &nbsp; "&databrx3(date)&" &nbsp; &agrave;s &nbsp; "&time&"</strong></td></tr><tr><td align='center' valign=top bgcolor='#f8f9fa'  style='padding:15px;  border-radius:10px;'></td></tr><tr> <td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px; color:#FFFFFF; text-align:center'><span style='padding:15px; font-size:12px;'>Copyright &copy; "&year(now)&" - Plataforma Compacta. <br>  Todos os Direitos Reservados.</span></td></tr></table></body>"
											
		'myMail.Send 										
														
		set myMail=nothing 
		Set cdoConfig = Nothing
	end if
	'====================================FIM ENVIA EMAIL
	
	response.Write("<script>alert('Dependente gravado com Sucesso!');</script>")
	'response.Write("<script>window.open('album_dependentes/index.php?id="&idz&"&tipo=inclusao', '_blank');")
	response.Write("<script>window.location='painel.asp?go=inclusao_pergunta2&id="&request("idtitular")&"';</script>")
	FechaConexao
end if%>

<%set rss=conexao.execute("select * from tb_movimentacoes where id="&request("id")&"  ")

	contrato=rss("id_contrato")

	set cad=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&contrato&"")

	set regra=conexao.execute("select * from CADASTROGERAL_VENDAS_FORMPORTAL where ramo='"&cad("ramo")&"' and segmento='"&cad("segmento")&"' and operadora='"&cad("operadora")&"' ")
	if not regra.eof then
		campo_nome=regra("campo_nome")
		campo_admissao=regra("campo_admissao")
		campo_cpf=regra("campo_cpf")
		campo_matricula=regra("campo_matricula")
		campo_nascimento=regra("campo_nascimento")
		campo_cns=regra("campo_cns")
		campo_rg=regra("campo_rg")
		campo_sexo=regra("campo_sexo")
		campo_estadocivil=regra("campo_estadocivil")
		campo_celular=regra("campo_celular")
		campo_email=regra("campo_email")
		campo_mae=regra("campo_mae")
		campo_cargo=regra("campo_cargo")
		campo_plano=regra("campo_plano")
		campo_endereco=regra("campo_endereco")
		campo_banco=regra("campo_banco")
		campo_pesoaltura=regra("campo_pesoaltura")
	else
		response.Write("<script>alert('Impossivel Prosseguir!\nSolicite ao Departamento de Manutenção e Relacionamento que cadastre as regras de formulario para esse contrato.');</script>")
		response.End()
	end if
	set regra=nothing
	
	
	'Devolve o ultimo dia do mes
	Function ULTIMO_DIA_MES(ano, mes)
    	ULTIMO_DIA_MES = Day(DateSerial(ano, mes + 1, 1) - 1)
	End Function
	
	UltDiaMEs=ULTIMO_DIA_MES(year(now),month(now))
	
	'response.Write("Ultimo dia: "&UltDiaMEs)
	
	if cad("vencimento")>UltDiaMEs then
		vencimento=UltDiaMEs
	else
		vencimento=cad("vencimento")
	end if
	
	if trim(cad("diafaturamento_inclusao"))<>"" then
		if trim(cad("diafaturamento_inclusao"))>UltDiaMEs then
			corte = trim(UltDiaMEs)&"/"&month(now)&"/"&year(now)
			diadecorte=UltDiaMEs
		else
			corte = trim(cad("diafaturamento_inclusao"))&"/"&month(now)&"/"&year(now)
			diadecorte=cad("diafaturamento_inclusao")
		end if			
	end if
	
	'response.Write("Data de Corte: "&corte)
	
	'Se a data corte do mês atual tiver passado, joga a sugestao para o proximo mês
	if day(now)>diadecorte-4 then
		mesvencimentox=DateAdd("m",1,corte)
		mesvencimento=month(mesvencimentox)
	else
		mesvencimentox=corte
		mesvencimento=month(now)
	end if
	
	'response.Write(mesvencimentox)
	sugestao=mesvencimentox
	sugestao=DateAdd("d",-4,sugestao)
	
	
%>  
<div class="page-content">
<div class="container-fluid">
<div class="row-fluid" style="text-align:center;">
	<div class="page-header" style="text-align:left;">
				<h1>Inclusão de Dependente <small>Preencha os dados do dependente</small></h1><br />
                <a href="index.asp?go=contrato&id=<%=contrato%>"><small><i class="icon-arrow-left"></i>&nbsp;Voltar para o contrato</small></a>
	</div>  

    <table border="0" cellpadding="4" cellspacing="4" style="border-radius:10px;" width="85%">
    	<form action="painel.asp?go=inclusao_dependente&gravar=ok" method="post" name="form01" id="form01">
      				<%if weekday(now)=1 or weekday(now)=7 then'sabado e domingo
						aparece="s"
					elseif weekday(now)=2 or weekday(now)=3 or weekday(now)=4 or weekday(now)=5 then'segunda a quinta
						if hour(now)>=16 and minute(now)>=30 then
							aparece="s"
						else
							aparece="n"
						end if
					elseif  weekday(now)=6 then'sexta feira
						if hour(now)>15 then
							aparece="s"
						else
							aparece="n"
						end if
					end if%>
                    <%if aparece="s" then%>
                   <tr>
                     <td colspan="2">
                     <div style="padding-left:15px; padding-right:15px; text-align:center; border-radius:10px; border-width:1px; border-style:solid; border-color:#F00; background-color:#FFEAEB; padding:8px; margin-left:10%; margin-right:10%; margin-bottom:30px;">
                     <img src="../img/exclamacao.png" onclick="openInfo();" style="cursor:pointer;" /><br>ATENÇÃO<br>Em função do horário, essa movimentação só será executada no próximo dia útil!!
                     </div>
                     </td>
                   </tr>
                   
                   <%end if%>
      <tr>
        <td colspan="2" align="left" style="padding-left:15px; padding-right:15px;">
        	<div style="border-bottom-width:1px; border-bottom-style: solid; border-bottom-color:#999;">
        	<strong><img src="img/setadir.png" style="vertical-align:middle;" />&nbsp;Dados do Plano</strong> 
        </div>
        </td>
      </tr>

          <tr>
            <td align="right" class="tre16-00337f" style="padding-left:15px;">Código ou Matr&iacute;cula</span></td>
            <td align="left"><strong><%=cad("codigo")%></strong></td>
          </tr>
          <tr>
            <td align="right" class="tre16-00337f" style="padding-left:15px;">Contrato</span></td>
            <td align="left">
			<strong><%=cad("ramo")%>-<%=cad("operadora")%></strong>
            <input type="hidden" name="plano" id="plano" value="<%=cad("id")%>" />
			</td>
          </tr>
      <tr>
        <td colspan="2" align="left" style="padding-left:15px; padding-right:15px;">
        	<div style="border-bottom-width:1px; border-bottom-style: solid; border-bottom-color:#999;">
            	<strong><img src="img/setadir.png" style="vertical-align:middle;" />&nbsp; Dados do Titular</strong>
            </div>
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Nome</td>
        <td align="left"><strong><%=rss("nome")%></strong>
        <input type="hidden" name="idtitular" id="idtitular" value="<%=rss("id")%>" />
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">CPF</td>
        <td align="left">
        <%if rss("cpf")<>"" and rss("cpf")<>"0" then%>
            <strong><%=rss("cpf")%></strong>
            <input type="hidden" name="cpft" id="cpft" value="<%=rss("cpf")%>">
        <%else%>
        	<input type="text" name="cpft" id="cpft" value=""  onkeyup="Mascara('CPF',this,event);" maxlength="14" style="text-align:center;" placeholder="___.___.___-__" required >
        <%end if%>
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Plano</td>
        <td align="left">
        <%if rss("plano")<>"" then%>
			<strong>
			<%set cad2=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&rss("plano")&"")
			if not cad2.eof then%>
				<%=cad2("nome")%>
            <%end if
			set cad2=nothing%>
            </strong>
		<%else%>
			<%if rss("redecontratada")<>"" then%>
            	<strong>
				<%set cad2=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&rss("redecontratada")&"")
				if not cad2.eof then%>
					<%=cad2("nome")%>
				<%end if
				set cad2=nothing%>
				</strong>
            <%end if%>
		<%end if%> <strong>. <%=rss("acomodacao")%></strong>
        &nbsp;&nbsp;<span style="color:#F00; font-size:10px;">*O dependente será incluído nesse plano.</span>
        </td>
      </tr>
      <tr>
        <td colspan="2" align="left" style="padding-left:15px; padding-right:15px;">
        	<div style="border-bottom-width:1px; border-bottom-style: solid; border-bottom-color:#999;">
            	<strong><img src="img/setadir.png" style="vertical-align:middle;" />&nbsp;Dados do Dependente a ser incluído</strong>
            </div>
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Parentesco</td>
        <td align="left">
        <script>
		
		function AbreInfo(x){
			//alert(x);	

			var d1 = new Date(x);
			var d2 = new Date();
			var diff = moment(d2,"DD/MM/YYYY HH:mm:ss").diff(moment(d1,"DD/MM/YYYY HH:mm:ss"));
			var dias = moment.duration(diff).asDays();
			//console.log(dias); // 105
			
			if (dias>29) {
				document.getElementById('divtxtcasamento').style.display='block';	
			}else{
				document.getElementById('divtxtcasamento').style.display='none';	
			}			
		}
		
		function AbreInfo2(x,y){
			//alert(x);	
			if (y=='Filho(a)'){
				var d1 = new Date(x);
				var d2 = new Date();
				var diff = moment(d2,"DD/MM/YYYY HH:mm:ss").diff(moment(d1,"DD/MM/YYYY HH:mm:ss"));
				var dias = moment.duration(diff).asDays();
				//console.log(dias); // 105
				
				if (dias>29) {
					document.getElementById('divtxtnascimento').style.display='block';	
				}else{
					document.getElementById('divtxtnascimento').style.display='none';	
				}
			}
		}
		
		function AbreData(x){
			
			if (x == "Conjuge" || x=="Companheiro(a)"){
				document.getElementById("dtcasamento").style.display='block';
				if (x=='Companheiro(a)'){
					document.getElementById("txtcasamento").innerHTML='Data de registro da união estavel';
				}else{
					document.getElementById("txtcasamento").innerHTML='Data do casamento';
				}
			}else{
				document.getElementById("dtcasamento").style.display='none';
				document.getElementById("dtcasamento").value='';
			}
		}
		</script>
        <%if ucase(cad("ramo"))="ODONTO" then%>
        <select name="parentesco" id="parentesco" class="tre14-0099ff boxZ" required onchange="AbreData(this.value);">
            <option value="">Selecione...</option>
            <option value="Conjuge">Cônjuge</option>
            <option value="Companheiro(a)">Companheiro(a)</option>
            <option value="Filho(a)">Filho(a)</option>
            <option value="Pai">Pai</option>
            <option value="Mae">Mãe</option>
            <option value="Tio(a)">Tio(a)</option>
            <option value="Sogro(a)">Sogro(a)</option>
            <option value="Irmaos(as)">Irmãos(ãs)</option>
            <option value="Cunhado(a)">Cunhado(a)</option>
            <option value="Sobrinho(a)">Sobrinho(a)</option>
			<option value="Outros">Outros</option>
        </select>&nbsp;&nbsp;
        <%else%>
        <select name="parentesco" id="parentesco" class="tre14-0099ff boxZ" required onchange="AbreData(this.value);">
            <option value="">Selecione...</option>
            <option value="Conjuge">Cônjuge</option>
            <option value="Companheiro(a)">Companheiro(a)</option>
            <option value="Filho(a)">Filho(a)</option>
        </select>&nbsp;&nbsp;
        <%end if%>
        <span id="dtcasamento" style="display:none;">
        <span id="txtcasamento">Data de Casamento:</span>&nbsp;<input type="date" name="datacasamento" id="datacasamento" placeholder="dd/mm/aaaa" class="boxZ" maxlength="10" style="text-align:center;" onblur="AbreInfo(this.value);" /></span>
        </td>
      </tr>
      <tr>
      	<td colspan="2">
        <div id="divtxtcasamento" style="padding-left:15px; padding-right:15px; text-align:left; border-radius:10px; border-width:1px; border-style:solid; border-color:#F00; background-color:#FFEAEB; padding:8px; margin-left:10%; margin-right:10%; margin-bottom:30px; display:none;">
                     <img src="../img/exclamacao.png" onclick="openInfo();" style="cursor:pointer;" /><strong>ATENÇÃO</strong><br>Esse dependente não terá redução de carência, pois a inclusão está sendo solicitada após 30 dias da data de casamento.<br /><br />A regra para inclusão de dependentes segue a mesma que para inclusão de titulares, ou seja, é necessário que o dependente seja incluído em até 30 dias do ato de ELEGIBILIDADE (fato que dá direito ao usuário de aderir ao plano, nesse caso, casamento), para que o mesmo NÃO tenha que cumprir os prazos de carências contratuais.
        
        </div>
        </td>
      </tr>
      <%if campo_nome="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Nome</td>
        <td align="left"><input type="text" name="nome" id="nome" class="boxZ" size="50" required >
        </td>
      </tr>
      <%end if%>
      <%if campo_cpf="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">CPF</td>
        <td align="left"><input type="text" name="cpf" id="cpf" class="boxZ" onkeyup="Mascara('CPF',this,event);" maxlength="14" style="text-align:center;" onblur="ConsultaRegistro(this.value,<%=contrato%>,'INCLUSAO',0,'n');" required></td>
      </tr>
      <%end if%>
      <%if campo_nascimento="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Data de Nascimento</td>
        <td align="left"><input type="date" name="dnasc" id="dnasc" class="boxZ" style="text-align:center;" required onblur="AbreInfo2(this.value, document.getElementById('parentesco').value);"></td>
      </tr>
      <%end if%>
      
      <tr>
      	<td colspan="2">
        <div id="divtxtnascimento" style="padding-left:15px; padding-right:15px; text-align:left; border-radius:10px; border-width:1px; border-style:solid; border-color:#F00; background-color:#FFEAEB; padding:8px; margin-left:10%; margin-right:10%; margin-bottom:30px; display:none;">
                     <img src="../img/exclamacao.png" onclick="openInfo();" style="cursor:pointer;" /><strong>ATENÇÃO</strong><br>Esse dependente não terá redução de carência, pois a inclusão está sendo solicitada após 30 dias da data de nascimento.<br /><br />A regra para inclusão de dependentes segue a mesma que para inclusão de titulares, ou seja, é necessário que o dependente seja incluído em até 30 dias do ato de ELEGIBILIDADE (fato que dá direito ao usuário de aderir ao plano, nesse caso, nascimento), para que o mesmo NÃO tenha que cumprir os prazos de carências contratuais.
        
        </div>
        </td>
      </tr>
      <%if campo_cns="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">CNS</td>
        <td align="left">
        <input type="text" name="cns" id="cns" class="boxZ ArialUni3nob" maxlength="30"></td>
      </tr>
      <%end if%>
      <%if campo_rg="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">RG</td>
        <td align="left">
        <input type="text" name="rg" id="rg" class="boxZ"/>
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;"><span class="tre14-666666">&Oacute;rg&atilde;o Expedidor RG</span></td>
        <td align="left">
        <input type="text" name="expedicaorg" id="expedicaorg" class="boxZ ArialUni3nob">
        </td>
      </tr>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Data de Expedi&ccedil;&atilde;o RG</td>
        <td align="left">
        <input type="date" name="dataexpedicao" id="dataexpedicao"  class="boxZ" style="text-align:center;"/>
        </td>
      </tr>
      <%end if%>
      <%if campo_celular="s" then%>
      <tr class="contLink">
        <td align="right" class="tre14-666666">Celular</td>
        <td align="left">
        <input type="text" name="tel" id="tel" class="boxZ ArialUni3nob" onkeyup="Mascara('CEL',this,event);" maxlength="15" style="text-align:center;" required>&nbsp;
        <a href="#">
            <i class="icon-info-sign"></i>
            <span>É necessário informar o número de celular do beneficiário para que se torne possível a comunicação entre o beneficiário e a operadora de saúde.</span>
        </a>
        </td>
      </tr>
      <%end if%>
      <%if campo_sexo="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Sexo</td>
        <td align="left">
        <select name="sexo" id="sexo" class="tre14-0099ff boxZ" required>
            <option value="">Selecione...</option>
            <option value="Feminino">Feminino</option>
            <option value="Masculino">Masculino</option>
        </select></td>
      </tr>
      <%end if%>
      <%if campo_estadocivil="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Estado Civil</td>
        <td align="left">
        <select name="ecivil" id="ecivil" class="tre14-0099ff boxZ" required>
            <option value="">Selecione...</option>
            <option value="Solteiro">Solteiro</option>
            <option value="Casado">Casado</option>
            <option value="Viúvo">Viúvo</option>
            <option value="Outros">Outros</option>
        </select>&nbsp;&nbsp;
        
        </td>
      </tr>
      <%end if%>
      <%if campo_mae="s" then%>
      <tr>
        <td align="right" class="tre16-00337f" style="padding-left:15px;">Nome da m&atilde;e deste usu&aacute;rio</td>
        <td align="left"><input type="text" name="mae" id="mae" class="boxZ" size="50" pattern="[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" required></td>
      </tr>
      <%end if
	  	if campo_pesoaltura="s" then%>
		<div class="form-group row">
			<label for="peso" class="col-md-2 col-form-label">Peso:</label>
			<div class="col-md-10">
				<input class="form-control" type="text" name="peso" id="peso" required> kg
			</div>
		</div>
		<div class="form-group row">
			<label for="altura" class="col-md-2 col-form-label">Altura:</label>
			<div class="col-md-10">
				<input class="form-control" type="text" name="altura" id="altura" required> 
			</div>
		</div>
		<%end if%>
      <tr>
        <td align="right" class="tre14-666666" style="padding-left:15px;">Data da Solicita&ccedil;&atilde;o</td>
        <td align="left">&nbsp;&nbsp;<strong><%if hour(now)>17 then%><%=cdate(date+1)%><%else%><%=cdate(date)%><%end if%></strong></td>
      </tr>
      <tr>
        <td align="right" bgcolor="#FFEAEB" class="tre14-666666">Data Sugerida</td>
        <td align="left" bgcolor="#FFEAEB">&nbsp;&nbsp;<strong><%=sugestao%></strong>&nbsp;<i class="icon-info-sign" title="Sugestão de data para que sua inclusão não gere pró-rata"></i></td>
      </tr>
      <tr>
        <td align="right" class="tre14-666666" style="padding-left:15px;">Efetuar a inclus&atilde;o em</td>
        <td align="left"><input type="date" name="datainicio" id="datainicio" class="boxZ ArialUni3nob"  style="text-align:center;" placeholder="Defina a data de início da cobertura" required />&nbsp;<small></small></td>
      </tr>
      <tr>
        <td colspan="2" bgcolor="#FFEAEB" class="tre14-666666" style="padding-left:15px; text-align:justify;"><strong>ATENÇÃO!</strong><br />caso o usuário seja contributário, orientamos a empresa a descontar a contribuição do funcionário a partir do mês de competência da inclusão independente da cobrança na fatura da empresa. A operadora poderá cobrar mais de uma mensalidade de uma vez, em função da data de inclusão e data corte da fatura. </td>
        
      </tr>
      <tr>
        <td colspan="2" align="left" style="padding-left:15px; padding-right:15px;">
        	<div style="border-bottom-width:1px; border-bottom-style: solid; border-bottom-color:#006;">
                <strong><img src="img/setadir.png" style="vertical-align:middle;" />&nbsp;Observa&ccedil;&otilde;es</strong>
            </div>
        </td>
      </tr>
      <tr>
        <td colspan="2" align="center" style="padding-left:15px;"><span class="tre14-666666">
          <textarea name="descricao" id="descricao" cols="45" rows="5" style="overflow:hidden; width:100%;" class="boxZ"></textarea>
        </span></td>
      </tr>
      <tr>
         <td colspan="2" valign="middle" class="tre11-RED" align="center">
         <div style="padding-left:15px; padding-right:15px; text-align:center; border-radius:10px; border-width:1px; border-style:solid; border-color:#F00; background-color:#FFEAEB; padding:8px; margin-left:10%; margin-right:10%; margin-bottom:30px;">
        <strong>ATENÇÃO!</strong><br />
        *Em dias de feriado municipal na cidade de Belo Horizonte ou feriados estaduais ou nacionais, <br>essa movimentação será executada no próximo dia útil.<br />
        <br />Novo horário para recebimento de MOVIMENTAÇÕES:<br />
        Segunda a quinta-feira: 08:00 às 16:00 horas<br />
        Sexta-feira: 08:00 às 15:00 horas<br />
        As movimentações recebidas após este horário serão realizadas no próximo dia útil.
        </div>
         </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
			<input type="submit" name="gravar" value="GRAVAR" class="boxZ tre18-006699">
		</td>
      </tr>
	  <tr>
        <td colspan="2" align="center">
			
		</td>
      </tr>
	  <tr>
        <td colspan="2" align="center">
			
		</td>
      </tr>
	  <tr>
        <td colspan="2" align="center">
			
		</td>
      </tr>
      </form>
    </table>
</div>
</div>
</div>
