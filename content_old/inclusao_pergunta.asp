<%if request("acao")="finaliza" then
AbreConexao
	set rs=conexao.execute("select * from TB_MOVIMENTACOES where id="&request("id")&"")
	if not rs.eof then
		conexao.execute("update TB_MOVIMENTACOES set aguardando='n' where id="&request("id")&"")
		titular=rs("nome")
		protocolo=rs("protocolo")
		set cont=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&rs("id_contrato")&" ")
		if not cont.eof then
			ramo=cont("ramo")
			operadora=cont("operadora")
		end if
		set cont=nothing
	end if
	set rs=nothing
	
	set rs=conexao.execute("select * from TB_MOVIMENTACOES where solicitacao_principal="&request("id")&"")
	if not rs.eof then
		nome_dependentes="DEPENDENTES:"
		while not rs.eof
			if nome_dependentes<>"" then
				nome_dependentes=nome_dependentes&"<br> "&rs("nome")
			else
				nome_dependentes=rs("nome")
			end if
		rs.movenext
		wend
		nome_dependentes=nome_dependentes&"<br><br>"
	end if
	set rs=nothing
	
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
		myMail.Subject="NOVA INCLUSAO DE TITULAR SOLICITADA"
		myMail.From="PORTAL COMPACTA <"&email_autentica&">"
		myMail.To=mailmanager&";"&emailx
		myMail.bcc="deman2@compactasaude.com;informativo@compactasaude.com"
		myMail.HTMLBody="<body style='color:#666666; font-size:24px; font-family:Arial'><table border=0 cellpadding=0 cellspacing=0 align='center' style='min-width:500px; width:690px;'><tr><td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left'><a href='http://plataformacompacta.com.br/painel_login.asp' title='ENTRAR NO PORTAL DO CORRETOR'><img src='http://www.compactasaude.com.br/mailling/deman/logobeneficios.png' height='60'  border='0'></a></td><td style='color:#fff; text-align:right; font-weight:bold'>ACOMPANHAMENTO DE MOVIMENTA&Ccedil;&Otilde;ES<BR>NO PORTAL DO CLIENTE</td></tr></table></td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000; font-weight: 400;'  bgcolor='#fff'>Nova inclus&atilde;o de titular solicitada no Portal do Cliente</td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000;' bgcolor='#DFE8FD'>EMPRESA: "&titularx&"<br><br>CONTRATO: "&ramo&" . "&operadora&"<br><br> MOVIMENTA&Ccedil;&Atilde;O: INCLUS&Atilde;O DE TITULAR<BR><br>TITULAR: "&ucase(titular)&" <BR><BR>"&nome_dependentes&"<br>SOLICITADO POR: "&userxy&"<br><br>PROTOCOLO DA SOLICITA&Ccedil;&Atilde;O: "&protocolo&"</td></tr><tr><td width=100% align='center' valign=top bgcolor='#f8f9fa' style='border-radius:10px; padding:20px;'><a href='https://www.compactasaude.com.br/canalcliente/login/' style='font-weight: 400; font-size: 20px;  color:#06F; text-decoration:underline;'>CLIQUE AQUI PARA ACOMPANHAR NO PORTAL</a></td> </tr> <tr> <td height='30' align='left' bgcolor='#EBEBEB' style='padding:20px; font-size:14px; border-radius:10px;'><strong>SE N&Atilde;O HOUVER PEND&Ecirc;NCIAS, ESSA SOLICITA&Ccedil;&Atilde;O SERÁ EXECUTADA EM AT&Eacute; 48 HS ÚTEIS.<br><br>Solicitado por "&userxy&" em:  "&databrx3(date)&" &agrave;s "&hour(now)&":"&minute(now)&"</strong></td></tr><tr><td align='center' valign=top bgcolor='#f8f9fa'  style='padding:15px;  border-radius:10px;'></td></tr><tr> <td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px; color:#FFFFFF; text-align:center'><span style='padding:15px; font-size:12px;'>Copyright &copy; "&year(now)&" - Plataforma Compacta. <br>  Todos os Direitos Reservados.</span></td></tr></table></body>"
			
										
		on error resume next										
		myMail.Send 										
		if err.number>0 then
			
		end if
		on error goto 0													
		set myMail=nothing 
		Set cdoConfig = Nothing
	end if
	'====================================FIM ENVIA EMAIL
	
	response.Write("<script>window.location='painel.asp?go=inclusao_finaliza&id="&request("id")&"';</script>")
FechaConexao
end if%>
<div class="page-content">
    <div class="container-fluid">

        <div class="row">
            <div class="col-xl-12">
                <div class="card">
                    <div class="card-body">
                        
                        
                        <div class="row">

                            <div class="col-sm-12">
                                <div class="alert alert-border alert-border-info alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                    <i class="uil uil-question-circle d-block display-4 mt-2 mb-3 text-info"></i>
                                    <h5 class="text-info">Titular Cadastrado</h5>
                                    <p>Deseja Cadastrar um dependente para esse titular ou finalizar a sua solicitação?</p>
                                    <div class="row">

                            			<div class="col-sm-6">
                                        	<a href="painel.asp?go=inclusao_dependente&id=<%=request("id")%>">
                                            <button type="button" class="btn btn-primary waves-effect waves-light">
                                                Cadastrar dependente <i class="uil uil-arrow-right ml-2"></i> 
                                            </button>
                                            </a>
                                        </div>
                                        <div class="col-sm-6">
                                        	<a href="painel.asp?go=inclusao_pergunta&id=<%=request("id")%>&acao=finaliza">
                                            <button type="button" class="btn btn-success waves-effect waves-light">
                                                <i class="uil uil-check mr-2"></i> Finalizar Solicitação
                                            </button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end row -->
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                