<script>
function getHTTPObject() { 
  var xmlhttp; 
  
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

<%if request("gravar")="ok" then
	AbreConexao
	
	set tit=conexao.execute("select * from CADASTROGERAL where id="&request("idtitular")&"")
	if not tit.eof then
		
		if tit("plano")<>"" then
			plano=tit("plano")
		else
			if tit("redecontratada")<>"" then
				plano=tit("redecontratada")
			else
				'busca o nome gravado no titular para encontrar o id na tabela
				set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where contrato="&request("plano")&" and idcadastro="&idx&" and nome='"&plano&"' ")
				if not pla.eof then
					plano=pla("id")
				end if
				set pla=nothing
			end if
			
		end if
		
		
		
		
		
		
		acomodacao=tit("acomodacao")
		TXTtitular ="<br><br>TITULAR: "&ucase(tit("titular"))&""
		
		if tit("idfilial")<>"" and tit("idfilial")<>"0" then
			set fil=conexao.execute("select * from CADASTROGERAL_FILIAL where id="&tit("idfilial")&"")
			if not fil.eof then
				filialx2=tit("idfilial")
				TXTfilial="<br><br>FILIAL: "&ucase(fil("nome"))&""
			else
				filialx2=0
			end if
			set fil=nothing
		end if
		
		if tit("idcentro")<>"" and tit("idcentro")<>"0" then
			set cen=conexao.execute("select * from CADASTROGERAL_CENTROS where id="&tit("idcentro")&"")
			if not cen.eof then
				centrox2=tit("idcentro")
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
	
	SQZ="insert into TB_MOVIMENTACOES (id, id_titular, nome, dnasc, cpf, sexo, ecivil, parentesco, mae, status, id_empresa, datareg, rg, rg_dataexpedicao, id_contrato, horareg, solpor, dinicio, datacob, descricao, tipo, cns, expedicaorg, tel, protocolo, dcasamento, centrodecusto, filial, plano, acomodacao, peso, altura) values("&idz&", '"&request("idtitular")&"', '"&request("nome")&"', '"&databr(request("dnasc"))&"', '"&request("cpf")&"', '"&request("sexo")&"', '"&request("ecivil")&"', '"&request("parentesco")&"', '"&request("mae")&"', 'ENVIADO', "&idx&", '"&databrx2(date)&"', '"&request("rg")&"', '"&databr(request("dataexpedicao"))&"', '"&request("contrato")&"', '"&time&"', '"&userxy&"', '"&databr(request("datainicio"))&"', '"&datacob&"', '"&request("descricao")&"', 'INCLUSAO', '"&request("cns")&"', '"&request("expedicaorg")&"', '"&request("tel")&"', '"&protocolo&"', '"&databr(request("datacasamento"))&"', '"&centrox2&"', '"&filialx2&"', '"&plano&"', '"&ucase(acomodacao)&"', '"&request("peso")&"', '"&request("altura")&"')"
	'response.Write("<br><br>")
	response.Write(SQZ)
	conexao.execute(SQZ)
	
	set cont=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("contrato")&" ")
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
		myMail.To=mailmanager&";"&emailx
		myMail.bcc="deman@compactasaude.com;informativo@compactasaude.com"
		myMail.HTMLBody="<body style='color:#666666; font-size:24px; font-family:Arial'><table border=0 cellpadding=0 cellspacing=0 align='center' style='min-width:500px; width:690px;'><tr><td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left'><a href='http://plataformacompacta.com.br/painel_login.asp' title='ENTRAR NO PORTAL DO CORRETOR'><img src='http://www.compactasaude.com.br/mailling/deman/logobeneficios.png' height='60'  border='0'></a></td><td style='color:#fff; text-align:right; font-weight:bold'>ACOMPANHAMENTO DE MOVIMENTAÇÕES<BR>NO PORTAL DO CLIENTE</td></tr></table></td></tr><tr><td align='center' valign=top style='padding:20px; border-radius:10px; color:#000; font-weight: 400;'  bgcolor='#fff'>Uma nova movimentação foi solicitada no Portal do Cliente da Compacta Beneficios</td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000;' bgcolor='#DFE8FD'>EMPRESA: "&titularx&"<br><br>CONTRATO: "&ramo&" . "&operadora&"<br><br> MOVIMENTAÇÃO: INCLUSÃO DE DEPENDENTE<br><br>PROTOCOLO DA SOLICITAÇÃO: "&protocolo&"<BR><br>BENEFICIÁRIO: "&ucase(request("nome"))&" "&TXTtitular&""&TXTfilial&""&TXTcentro&"</td></tr><tr><td width=100% align='center' valign=top bgcolor='#f8f9fa' style='border-radius:10px; padding:20px;'><a href='https://www.compactasaude.com.br/canalcliente/login/' style='font-weight: 400; font-size: 20px;  color:#06F; text-decoration:underline;'>CLIQUE AQUI PARA ACOMPANHAR NO PORTAL</a></td> </tr> <tr> <td height='30' align='center' bgcolor='#EBEBEB' style='padding:20px; font-size:14px; border-radius:10px;'><strong>SE NÃO HOUVER PENDÊNCIAS, ESSA SERÁ EXECUTADA EM ATÉ 48 HS ÚTEIS.<br><br>Solicitado por "&userxy&" em: &nbsp; "&databrx3(date)&" &nbsp; &agrave;s &nbsp; "&time&"</strong></td></tr><tr><td align='center' valign=top bgcolor='#f8f9fa'  style='padding:15px;  border-radius:10px;'></td></tr><tr> <td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px; color:#FFFFFF; text-align:center'><span style='padding:15px; font-size:12px;'>Copyright &copy; "&year(now)&" - Plataforma Compacta. <br>  Todos os Direitos Reservados.</span></td></tr></table></body>"
											
		myMail.Send 										
														
		set myMail=nothing 
		Set cdoConfig = Nothing
	end if
	'====================================FIM ENVIA EMAIL
	
	response.Write("<script>alert('Dependente gravado com Sucesso!');</script>")
	
	'response.Write("<script>window.location='album/index.php?id="&idz&"&tipo=inclusao';</ script>")
    response.Write("<script>window.location='painel.asp?go=inclusao_finaliza&id="&idz&"';</script>")
	FechaConexao
end if%>



<div class="page-content">
    <div class="container-fluid">

        <%AbreConexao
		
		set rss=conexao.execute("select * from CADASTROGERAL where id="&request("id")&" ")
    	if not rss.eof then
			idtitular=rss("id")
			cpftitular=rss("cpf")
			titular=rss("titular")
			plano=rss("plano")
			if rss("idcadvenda")<>"0" then
				contrato=rss("idcadvenda")
			else
				contrato=rss("coproduto")
			end if
		end if
		
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
				
				if cint(cad("diafaturamento_inclusao"))>cint(UltDiaMEs) then
					corte = trim(UltDiaMEs)&"/"&month(now)&"/"&year(now)
					diadecorte=UltDiaMEs
				else
					corte = trim(cad("diafaturamento_inclusao"))&"/"&month(now)&"/"&year(now)
					diadecorte=cad("diafaturamento_inclusao")
				end if			
			end if
			'response.Write("Data de Corte: "&corte)
			if cad("tipocobranca_inclusao")="MÊS CHEIO" then
				'Se a data corte do mês atual tiver passado, joga a sugestao para o proximo mês
				if day(now)>diadecorte-4 then
					mesvencimentox=DateAdd("m",1,databrx3(corte))
					mesvencimento=month(mesvencimentox)
					
					response.Write("<script>alert('"&mesvencimento&"');</script>")
				else
					mesvencimentox=corte
					mesvencimento=month(now)
				end if
				
				'response.Write(mesvencimentox)
				sugestao=mesvencimentox
				sugestao=DateAdd("d",-4,sugestao)
			else
				sugestao=date
			end if
			

			
		%>
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Incluir Dependente</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Incluir Titular</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <h4 class="card-title">Incluindo Dependente para:</h4>
                        <p class="card-title-desc">
                        Contrato: <strong><%=cad("ramo")%> | <%=cad("operadora")%> | <%=cad("nome_amigavel")%></strong><br />
                        Plano: <strong>
						<%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&plano&" ")
						if not pla.eof then%>
							<%=pla("nome")%>
						<%end if
						set pla=nothing%>
                        </strong><br />
                        Titular: <strong><%=titular%></strong><br />
                        </p>
						<form action="painel.asp?go=inclusao_dependente2&gravar=ok" method="post" name="form01">
                		<input type="hidden" name="id" value="<%=request("id")%>" />
                        <input type="hidden" name="idtitular" id="idtitular" value="<%=idtitular%>" />
                        <input type="hidden" name="cpft" id="cpft" value="<%=cpftitular%>">
                        <input type="hidden" name="contrato" id="contrato" value="<%=contrato%>">
                        
                         
                        
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
                        <div class="form-group row">
                            <div class="col-md-12">
                            	<div class="alert alert-border alert-border-warning alert-dismissible fade show mt-4 px-4 mb-0 text-center">
                                <i class="uil uil-exclamation-triangle d-block display-4 mt-2 mb-3 text-warning"></i>
                                <h5 class="text-warning">ATENÇÃO</h5>
                                <p>Em função do <strong>horário</strong>, essa movimentação só será executada no próximo dia útil!!</p>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                                </div>
                                
                            </div>
                       </div>
                       <%end if%>
                        
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
                        <div class="form-group row">
                                <label for="parentesco" class="col-md-2 col-form-label">Parentesco</label>
                                <div class="col-md-10">
                                    <%if ucase(cad("ramo"))="ODONTO" then%>
                                    <select name="parentesco" id="parentesco"class="form-control" required onchange="AbreData(this.value);">
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
                                    <select name="parentesco" id="parentesco" class="form-control" required onchange="AbreData(this.value);">
                                        <option value="">Selecione...</option>
                                        <option value="Conjuge">Cônjuge</option>
                                        <option value="Companheiro(a)">Companheiro(a)</option>
                                        <option value="Filho(a)">Filho(a)</option>
                                    </select>&nbsp;&nbsp;
                                    <%end if%>
                                </div>
                            </div>
                        
                        <div id="dtcasamento" class="form-group row" style="display:none;">
                         <label for="datacasamento" id="txtcasamento" class="col-md-4 col-form-label">Data de Casamento:</label>
                        	<div class="col-md-8">
                            <input type="date" name="datacasamento" id="datacasamento" onblur="AbreInfo(this.value);" class="form-control" />
                            </div>
                        </div>
                        
                        
                        <div class="form-group row" id="divtxtcasamento" style="display:none;">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                    
                                <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                <h5 class="text-danger">ATENÇÃO</h5>
                                <p>Esse dependente não terá redução de carência, pois a inclusão está sendo solicitada após 30 dias da data de casamento.<br /><br />A regra para inclusão de dependentes segue a mesma que para inclusão de titulares, ou seja, é necessário que o dependente seja incluído em até 30 dias do ato de ELEGIBILIDADE (fato que dá direito ao usuário de aderir ao plano, nesse caso, casamento), para que o mesmo NÃO tenha que cumprir os prazos de carências contratuais.</p>
                                </div>
                                
                            </div>
                       	</div>
						
						
						
						
						
						<%if campo_nome="s" then%>
                        	<div class="form-group row">
                                <label for="nome" class="col-md-2 col-form-label">Nome Completo</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="nome" id="nome" required>
                                </div>
                            </div>
                        <%end if
                        if campo_cpf="s" then%>
                          <div class="form-group row">
                               <label for="cpf" class="col-md-2 col-form-label">CPF</label>
                               <div class="col-md-10">
                                   <input class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true" type="text" name="cpf" id="cpf" required>
                               </div>
                          </div>
                        <%end if						
                         if campo_nascimento="s" then%>
                          
                         	<div class="form-group row">
                                <label for="dnasc" class="col-md-2 col-form-label">Data de Nascimento</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="date" name="dnasc" id="dnasc" required onblur="AbreInfo2(this.value, document.getElementById('parentesco').value);">
                                </div>
                            </div>
                            
                            <div class="form-group row" id="divtxtnascimento" style="display:none;">
                                <div class="col-md-12">
                                    <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                        
                                    <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                    <h5 class="text-danger">ATENÇÃO</h5>
                                    <p>Esse dependente não terá redução de carência, pois a inclusão está sendo solicitada após 30 dias da data de nascimento.<br /><br />A regra para inclusão de dependentes segue a mesma que para inclusão de titulares, ou seja, é necessário que o dependente seja incluído em até 30 dias do ato de ELEGIBILIDADE (fato que dá direito ao usuário de aderir ao plano, nesse caso, nascimento), para que o mesmo NÃO tenha que cumprir os prazos de carências contratuais.</p>
                                    </div>
                                    
                                </div>
                            </div>
                         <%end if
						 if campo_cns="s" then%>
                         	<div class="form-group row">
                                <label for="cns" class="col-md-2 col-form-label">CNS</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="cns" id="cns" required>
                                </div>
                            </div>
                          <%end if
						  if campo_celular="s" then%>
                          		<div class="form-group row">
                                    <label for="tel" class="col-md-2 col-form-label">Celular</label>
                                    <div class="col-md-10">
                                        <input class="form-control input-mask" data-inputmask="'mask': '(99)99999-9999'" type="text" name="tel" id="tel" required>
                                    </div>
                                </div>
                          <%end if
						  if campo_sexo="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Sexo</label>
                                    <div class="col-md-10">
                                        <select name="sexo" id="sexo" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Masculino">Masculino</option>
                                			<option value="Feminino">Feminino</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
                          if campo_estadocivil="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Estado Civil</label>
                                    <div class="col-md-10">
                                        <select name="ecivil" id="ecivil" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Solteiro">Solteiro</option>
                                            <option value="Casado">Casado</option>
                                            <option value="Vi&uacute;vo">Vi&uacute;vo</option>
                                            <option value="Outros">Outros</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
						  if campo_mae="s" then%>
                              <div class="form-group row">
                                <label for="mae" class="col-md-2 col-form-label">Nome da M&atilde;e:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="mae" id="mae" required>
                                </div>
                              </div>
                          <%end if
                          if campo_rg="s" then%>
                          	<div class="form-group row">
                                <label for="rg" class="col-md-2 col-form-label">RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="rg" id="rg" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="expedicaorg" class="col-md-2 col-form-label">&Oacute;rg&atilde;o Expedidor RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="expedicaorg" id="expedicaorg" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="dataexpedicao" class="col-md-2 col-form-label">Data de Expedi&ccedil;&atilde;o RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="date" name="dataexpedicao" id="dataexpedicao" required>
                                </div>
                            </div>
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
                          
                          	<div class="form-group row">
                                <label class="col-md-2 col-form-label">Data sugerida</label>
                                <div class="col-md-10">
                                    <%=databrx3(sugestao)%>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Efetuar a inclus&atilde;o em</label>
                                <div class="col-md-10">
                                    <input type="date" name="datainicio" id="datainicio" class="form-control" required />
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <div class="col-md-6">
                                    <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                        
                                    <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                    <h5 class="text-danger">ATENÇÃO</h5>
                                    <p>caso o usuário seja contributário, orientamos a empresa a descontar a contribuição do funcionário a partir do mês de competência da inclusão independente da cobrança na fatura da empresa. A operadora poderá cobrar mais de uma mensalidade de uma vez, em função da data de inclusão e data corte da fatura.</p>
                                    </div>
                                    
                                </div>
                                <div class="col-md-6">
                                    <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                        
                                    <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                    <h5 class="text-danger">ATENÇÃO</h5>
                                    <p>*Em dias de feriado municipal na cidade de Belo Horizonte ou feriados estaduais ou nacionais, <br>essa movimentação será executada no próximo dia útil.<br />
                                    <br />Novo horário para recebimento de MOVIMENTAÇÕES:<br />
                                    Segunda a quinta-feira: 08:00 às 16:00 horas<br />
                                    Sexta-feira: 08:00 às 15:00 horas<br />
                                    As movimentações recebidas após este horário serão realizadas no próximo dia útil.</p>
                                    </div>
                                    
                                </div>
                            </div>
                            
                     
                            <div class="form-group row">
                                
                                <div class="col-md-12 text-center">
                                	<button type="submit" class="btn btn-success waves-effect waves-light">
                                        <i class="uil uil-check mr-2"></i> GRAVAR
                                    </button>
                                </div>
                            </div>
                      
                     
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
        <%
		FechaConexao%>
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                