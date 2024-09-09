<script>
	var sBrowser, sUsrAg = navigator.userAgent;

	if(sUsrAg.indexOf("Chrome") > -1) {
		sBrowser = "Google Chrome";
	} else if (sUsrAg.indexOf("Safari") > -1) {
		sBrowser = "Apple Safari";
	} else if (sUsrAg.indexOf("Opera") > -1) {
		sBrowser = "Opera";
	} else if (sUsrAg.indexOf("Firefox") > -1) {
		sBrowser = "Mozilla Firefox";
	} else if (sUsrAg.indexOf("MSIE") > -1) {
		sBrowser = "Microsoft Internet Explorer";
	}
	
	if (sBrowser == "Mozilla Firefox"){
		//alert("Você está utilizando: " + sBrowser);
	}
	
	
	
</script>
<%if request("envia")="mail" then
	AbreConexao
		set con=conexao.execute("select ramo, operadora,nome_amigavel, vencimento from CADASTROGERAL_VENDAS where id="&request("contrato")&"")
		if not con.eof then
			contratos=con("ramo")&"."&con("operadora")&"."&con("nome_amigavel")
			vencimento=con("vencimento")
		end if
		set con=nothing
	FechaConexao
	'-------------------Envia para DEMAN E DETEC
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
		myMail.Subject="Solicitacao de boleto via Portal"
		myMail.From="COMPACTA SAUDE <"&email_autentica&">"
		myMail.To="deman@compactasaude.com"
		myMail.bcc="luciano@compactasaude.com"
		mesx=split(request("mes"),"-")
		mes=mesx(1)
		ano=mesx(0)
		myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#000000><tr> <td><font color=#FFFFFF size=2 face=Arial><b>Compacta Sa&uacute;de - Solicita&ccedil;&atilde;o de Boleto</b></font></td></tr> <tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Prezado DEMAN,<br><br>o(a) usuario(a): <br><strong>"&request("usuario")&"</strong> <br><br>da empresa:<br><strong> "&request("titular")&" </strong><br><br>n&atilde;o encontrou o kit faturamento do contrato: <br><strong>"&contratos&"</strong><br><br>para o m&ecirc;s <strong>"&mes&" / "&ano&"</strong><br>Dia de vencimento: "&vencimento&"<br><br>Gentileza verificar o envio dos boletos<br><br> <br></FONT><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr></table></center></body>"
										
		myMail.Send 										
														
		set myMail=nothing 
		Set cdoConfig = Nothing


response.Write("<script>alert('Solicitação Enviada com Sucesso!\nAguarde nosso retorno!');</script>")
response.Write("<script>window.location='index.asp';</script>")
end if%>
<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Kit Faturamento</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Início</a></li>
                            <li class="breadcrumb-item active">Kit Faturamento</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <form action="painel.asp?go=kit_faturamento" method="post">
        <input type="hidden" name="pesq" value="ok" />
        <div class="row">
        	<div class="col-md-12 col-xl-12">
             	Selecione no campo/calendário abaixo o <strong>mês e ano</strong> de vencimento desejado para consultar o seu boleto:<br />
            </div>
        </div>
        <div class="row">
        	<div class="col-md-12 col-xl-12 mb-2">
             	<input type="month" class="form-control col-md-4" name="mes" value="<%=request("mes")%>" />
                <small style="color:#F00;">*Caso nao visualize o calendário no campo acima, digite a data no formato a seguir: <strong> mm/aaaa | Exemplo: 02/2001</strong>.<br /> Preferenciamente utilize os navegadores Edge, Internet Explorer ou Chrome.
                 </small>
            </div>
        </div>
        <div class="row mb-4">
        	<div class="col-md-12 col-xl-12">
             	<input type="submit" class="btn btn-success" value="Consultar" />
            </div>
        </div>
        </form>
        <%if request("pesq")="ok" then
		'response.Write(request("mes"))
		if request("id")<>"" then
			sqlz="select * from CADASTROGERAL_VENDAS where id="&request("id")&" and status='ATIVO' and esconde_contrato='n' "
		else
			if contrato_permitido<>"" then
				if contrato_permitido="0" or contrato_permitido="" then 'Tem acesso GERAL (todos os contratos)
					sqlz="select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato<>'s' "
				
				elseif contrato_permitido<>"" and contrato_permitido<>"0" then 'Tem acesso a contratos distintos
					box=split(trim(contrato_permitido),",")
					
					for i=0 to ubound(box)
						if sql2<>"" then
							sql2=sql2&" or id="&box(i)&" and status='ATIVO' and esconde_contrato<>'s'"
						else
							sql2= "where id="&box(i)&" and status='ATIVO' and esconde_contrato<>'s'"
						end if
					next
					
					sqlz="select * from CADASTROGERAL_VENDAS "&sql2&" "
				
				end if
			else
				response.Write("<script>alert('Impossivel Prosseguir!\nProcure o depto de Manutenção da Compacta Saúde e solicite a autorização para visualizar os documentos.');</script>")
			end if
		end if
		
		'response.Write(sqlz)
		set rs=conexao.execute(sqlz)
		if not rs.eof then
			while not rs.eof%>

                <div class="row" >
                	<div class="col-xl-12">
                    	<h5><i class="fas fa-arrow-alt-circle-right"></i>&nbsp;<%=rs("ramo")%> . <%=rs("operadora")%><%if rs("nome_amigavel")<>"" then%> . <%=rs("nome_amigavel")%><%end if%></h5>
                    </div>
                </div>
                <div class="row">
                	<div class="col-xl-12">
                    
						<%set op=conexao.execute("select * from OPERADORAS where nome='"&rs("operadora")&"'")
						if not op.eof then
							idoperadora=op("id")
						end if
						set op=nothing
						
						
						if request("mes")<>"" then
							if instr(request("mes"),"-")>0 then
								mesx=split(request("mes"),"-")
								mes=mesx(1)
								ano=mesx(0)
							elseif instr(request("mes"),"/")>0 then
								mesx=split(request("mes"),"/")
								mes=mesx(1)
								ano=mesx(0)
							end if
							
								
							set rss=conexao.execute("select * from CADASTROGERAL_LANCPGTO where idcadastro="&idx&" and idcadvenda="&rs("id")&" and month(dvencimento)='"&AcrescentaZero(month(request("mes")))&"' and year(dvencimento)='"&year(request("mes"))&"' and substituido is null  order by dvencimento desc")
							if not rss.eof then
							
								while not rss.eof
									
									if rss("naohafaturamento")="s" and  rss("tipo_boleto")<>"padrao" then %>
											N&atilde;o houve fatura de coparticipa&ccedil;&atilde;o para esse mês!
									<%
									else
									
										if rss("foto")<>"nenhum" and trim(rss("foto"))<>"" then
										%>
										<li>
											<i class="fa fa-file"></i>&nbsp;<a href="https://www.compactabh.com.br/SISCAD/boleto_cliente/<%=rss("foto")%>" target="_blank" class="verm01"><%=ucase(replace(rss("foto"),"%20"," "))%></a>&nbsp;
										</li>
										<%end if%>
									
										<%url="https://compactabh.com.br/SISCAD/webservice_lancpgto.asp?idcadastro="&rss("idcadastro")&"&idcadvenda="&rss("idcadvenda")&"&id="&rss("id")&"&foto="&rss("foto")
										'response.Write(url)
										SET objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
										objHttp.OPEN "GET", url, FALSE
										objHttp.SetRequestHeader "Content-type", "application/x-www-form-urlencoded"
										objHttp.Send
										if instr(objHttp.ResponseText,"fa fa-file")>0 then
											'response.Write(encontrou&"<br>")
											response.Write(objHttp.ResponseText)
										else

											if AcrescentaZero(month(rs("dvigencia")))<mes and year(rs("dvigencia"))<=ano then%>
												<form action="painel.asp?go=kit_faturamento" method="post">
													<input type="hidden" name="envia" value="mail">
													<input type="hidden" name="mes" value="<%=request("mes")%>">
													<input type="hidden" name="usuario" value="<%=userxy%>" />
													<input type="hidden" name="titular" value="<%=titularx%>" />
													<input type="hidden" name="contrato" value="<%=rs("id")%>" />
													<button type="submit" class="btn btn-danger">Solicitar envio do kit faturamento (<%=mes%>/<%=ano%>)</button>
												</form>
											<%end if
											'response.Write(encontrou&"<br>")
											'if encontrou<>"s" then
											'	response.Write("Nao encontrou")
											'	encontrou="n"
											'end if
										end if 
									end if%>

								<%rss.movenext
								wend
							else
								
								if AcrescentaZero(month(rs("dvigencia")))<mes and year(rs("dvigencia"))<=ano then%>
									<form action="painel.asp?go=kit_faturamento" method="post">
										<input type="hidden" name="envia" value="mail">
										<input type="hidden" name="mes" value="<%=request("mes")%>">
										<input type="hidden" name="usuario" value="<%=userxy%>" />
										<input type="hidden" name="titular" value="<%=titularx%>" />
										<input type="hidden" name="contrato" value="<%=rs("id")%>" />
										<button type="submit" class="btn btn-danger">Solicitar envio do kit faturamento (<%=mes%>/<%=ano%>)</button>
									</form>
								<%end if
							end if
							set rss=nothing%>
							
						<%else ' se nao tiver pesquisado o mes%>
							<div class="alert alert-danger col-xl-12 text-center" role="alert">
								Insira um mês e ano válido para pesquisa
							</div>
						<%end if%>
                    </div>
                    
                </div>
            <!-- end row -->
            <hr />
            <%rs.movenext
            wend

		end if
		end if%>
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                