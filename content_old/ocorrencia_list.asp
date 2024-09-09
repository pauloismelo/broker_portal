
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<%if request("gravar")="ok" then
	AbreConexao
	set cli=conexao.execute("select * from CADASTROGERAL where id="&idx&" ")
		cliente=cli("titular")
	set cli=nothing
	
	mailmanager=""
	set ma=conexao.execute("select * from CADASTROGERAL_USUARIOS where idcadastro="&idx&" and email_ocorrencia='s'")
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
	
	protocolo=year(now)&""&month(now)&""&day(now)&""&hour(now)&""&minute(now)&""&second(now)

    AbreConexao
        set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS order by id desc")
        if rs.eof then
        idz=1
        else
        idz=rs("id")+1
        end if
        set rs=nothing
        
        
        Sql = "INSERT INTO PORTALCLIENTE_OCORRENCIAS (id, id_cliente, usuario, tipo, titulo, descricao, datareg, status, id_contrato, celula, id_movimentacao, protocolo) VALUES ("&idz&", "&idx&", '"&userxy&"', '"&request("tipo")&"', '"&request("titulo")&"', '"&request("descricao")&"', '"&databrx2(date)&" "&time&"', 'ABERTO', "&request("contrato")&", '"&request("celula")&"', 0, '"&protocolo&"' )"
        'response.Write("<br><br><br>"&Sql)
        conexao.Execute(Sql)

        set con=conexao.execute("select ramo, segmento, operadora from CADASTROGERAL_VENDAS where id="&request("contrato")&" ")
        if not con.eof then
            contrato=con("ramo")&" . "&con("segmento")&" . "&con("operadora")
        end if
        set con=nothing
    FechaConexao

	'-------------------Envia Email -----------
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	Set cdoConfig = Server.CreateObject("CDO.Configuration")
	servidor_smtp = "mail.compactasaude.com.br" 
	email_autentica = "noreply@compactasaude.com.br" 
	senha_autentica = "x7hd0%F8" 
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
	myMail.Subject="OCORRENCIA ABERTA NO PORTAL"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="deman@compactasaude.com"
	myMail.Bcc=mailmanager
	myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>NOVA OCORRENCIA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Uma ocorr&ecirc;ncia foi aberta.<br><BR>Usuario: <strong>"&userxy&"</strong><br> Cliente: <strong>"&cliente&"</strong><br>Protocolo <strong>"&protocolo&"</strong><br>Contrato <strong>"&contrato&"</strong><br>Titulo: <strong>"&SemAcento(request("titulo"))&"</strong><br><br>Favor, verificar as informa&ccedil;&otilde;es da ocorr&ecirc;ncia no sistema SISCAD<br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
	
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing
	
	
	'-------------------Envia Email para o Luciano com o texto -----------
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	Set cdoConfig = Server.CreateObject("CDO.Configuration")
	servidor_smtp = "mail.compactasaude.com.br" 
	email_autentica = "noreply@compactasaude.com.br" 
	senha_autentica = "x7hd0%F8" 
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
	myMail.Subject="OCORRENCIA ABERTA"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="luciano@compactasaude.com"
	'myMail.Bcc="detec@compactasaude.com"
	myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>NOVA OCORRENCIA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Usuario: <strong>"&userxy&"</strong><br> Cliente <strong>"&cliente&"</strong><br>Protocolo <strong>"&protocolo&"</strong><br>Contrato <strong>"&contrato&"</strong><br>Titulo: <strong>"&request("titulo")&"</strong><br><br>Descri&ccedil;&atilde;o da ocorr&ecirc;ncia: <br><strong>"&request("descricao")&"</strong><br><br>Favor, verificar as informa&ccedil;&otilde;es da ocorr&ecirc;ncia no sistema SISCAD<br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
	
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing

	response.Write("<script>alert('Ocorencia enviada com sucesso\nCaso necessite anexar documentos, faça na proxima etapa!\n\nEm breve responderemos e voce podera acompanhar aqui no portal!');</script>")
    response.Write("<script>window.location='painel.asp?go=ocorrencia&pesq=ok&abremodal="&idz&"';</script>")
	%>
    
<%
end if%>







<%if request("gravar")="ok2" then
AbreConexao
	set oc=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id="&request("id_ocorrencia")&" ")
	if not oc.eof then
		protocolo=oc("protocolo")
		datareg=oc("datareg")
		
		mailmanager=""
		set ma=conexao.execute("select * from CADASTROGERAL_USUARIOS where idcadastro="&oc("id_cliente")&" and email_ocorrencia='s'")
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
	end if
	set oc=nothing
	

	'-------------------Envia Email -----------
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	Set cdoConfig = Server.CreateObject("CDO.Configuration")
	servidor_smtp = "mail.compactasaude.com.br" 
	email_autentica = "noreply@compactasaude.com.br" 
	senha_autentica = "x7hd0%F8" 
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
	myMail.Subject="OCORRENCIA RESPONDIDA"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.To="deman@compactasaude.com"
	myMail.Bcc=mailmanager
	'myMail.ReplyTo=""&lcase(departamentox)&"@compactasaude.com"
	mensagem="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>OCORR&Ecirc;NCIA RESPONDIDA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Prezado(a) <strong>DEMAN</strong>,<br>o usuario "&userxy&" <strong>RESPONDEU</strong> a ocorr&ecirc;ncia [<strong>"&protocolo&"</strong>] aberta no dia "&day(datareg)&"/"&month(datareg)&"/"&year(datareg)&".<br><br>Verifique as informações através do nosso sistema interno.<br></font></td></tr><tr><td><FONT FACE=arial SIZE=2><br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&".</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 	
	myMail.HTMLBody=mensagem		
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing
	
	'-------------------Envia Email -----------
	
	conexao.execute("insert into PORTALCLIENTE_OCORRENCIAS_HIST (id_ocorrencia, texto, datareg, usuario) values("&request("id_ocorrencia")&", '"&replace(request("historico"),chr(13),"<br>")&"', '"&month(now)&"/"&day(now)&"/"&year(now)&" "&hour(time)&":"&minute(time)&"', '"&userxy&"' )")
	
	conexao.execute("update PORTALCLIENTE_OCORRENCIAS set status='RESPONDIDO' where id="&request("id_ocorrencia")&" ")
	
	response.Write("<script>window.location='painel.asp?go=ocorrencia&pesq=ok';</script>")
FechaConexao
end if

if request("concluir")="ok" then
AbreConexao
	set oc=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id="&request("id_ocorrencia")&" ")
	if not oc.eof then
		protocolo=oc("protocolo")
		datareg=oc("datareg")
	end if
	set oc=nothing

	'-------------------Envia Email -----------
		sch = "http://schemas.microsoft.com/cdo/configuration/"
		Set cdoConfig = Server.CreateObject("CDO.Configuration")
		servidor_smtp = "mail.compactasaude.com.br" 
		email_autentica = "noreply@compactasaude.com.br" 
		senha_autentica = "x7hd0%F8" 
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
		myMail.Subject="OCORRENCIA CONCLUIDA"
		myMail.From="COMPACTA SAUDE <"&email_autentica&">"
		myMail.To="deman@compactasaude.com"
		'myMail.Bcc="detec@compactasaude.com"
		'myMail.ReplyTo=""&lcase(departamentox)&"@compactasaude.com"
		mensagem="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>OCORR&Ecirc;NCIA CONCLUIDA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Prezado(a) <strong>DEMAN</strong>,<br>o usuario "&userxy&" <strong>CONCLUIU</strong> a ocorr&ecirc;ncia [<strong>"&protocolo&"</strong>] aberta no dia "&day(datareg)&"/"&month(datareg)&"/"&year(datareg)&".<br><br><br></font></td></tr><tr><td><FONT FACE=arial SIZE=2><br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&".</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 	
		myMail.HTMLBody=mensagem		
		myMail.Send 
		set myMail=nothing 
		Set cdoConfig = Nothing
	
	'-------------------Envia Email -----------
	conexao.execute("update PORTALCLIENTE_OCORRENCIAS set status='CONCLUIDO', conclusao_user='"&userxy&"', conclusao_data='"&databrx2(date)&" "&time&"' where id="&request("id_ocorrencia")&" ")
	
	response.Write("<script>window.location='painel.asp?go=ocorrencia&pesq=ok';</script>")
FechaConexao
end if
%>



<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Ocorrências</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Ocorrências</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
        <div class="row">
            <div class="col-12">
            	
            	<form action="painel.asp?go=ocorrencia" method="post">
                <input type="hidden" name="pesq" value="ok" />
            	<div class="form-group row">
        
                    <div class="col-md-1">
                    	&nbsp;
                    </div>
                    <div class="col-md-2" style="text-align:right;">
                        <button type="button" class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target="#myModalx">Abrir ocorrência</button>
                    </div>
                    <div class="col-md-2">
                    <input type="text" name="protocolo" value="<%=request("protocol")%>" class="form-control" placeholder="PROTOCOLO" />
                    </div>
                    <div class="col-md-2">
                        <select name="tipo" class="form-control" >
                            <option value="">Tipos de ocorrências</option>
                            <option value="ANULACAO" <%if request("tipo")="ANULACAO" then response.Write("selected") end if%>>ANULACAO</option>
                            <option value="SINISTRO" <%if request("tipo")="SINISTRO" then response.Write("selected") end if%>>COMUNICAR SINISTRO</option>
                            <option value="DUVIDAS" <%if request("tipo")="DUVIDAS" then response.Write("selected") end if%>>DUVIDAS</option>                            
                            <option value="MOVIMENTACAO" <%if request("tipo")="MOVIMENTACAO" then response.Write("selected") end if%>>MOVIMENTACAO</option>
                            <option value="RECLAMACOES" <%if request("tipo")="RECLAMACOES" then response.Write("selected") end if%>>RECLAMACOES</option>
                            <option value="SUGESTOES" <%if request("tipo")="SUGESTOES" then response.Write("selected") end if%>>SUGESTOES</option>
                            <option value="SOLICITACOES" <%if request("tipo")="SOLICITACOES" then response.Write("selected") end if%>>SOLICITACOES</option>
                            <option value="OUTROS" <%if request("tipo")="OUTROS" then response.Write("selected") end if%>>OUTROS</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                    	<select name="statuss" id="statuss" class="form-control">
                            <option value="">Todos os status</option>
                            <option value="ABERTO" <%if request("statuss")="ABERTO" then response.Write("selected") end if%>>EM ABERTO</option>
                            <option value="EM TRATAMENTO" <%if request("statuss")="EM TRATAMENTO" then response.Write("selected") end if%>>EM TRATAMENTO</option>
                            <option value="CONCLUIDO" <%if request("statuss")="CONCLUIDO" then response.Write("selected") end if%>>CONCLUIDO</option>
                            <option value="SOLUCIONADO" <%if request("statuss")="SOLUCIONADO" then response.Write("selected") end if%>>SOLUCIONADO</option>
                            <option value="RESPONDIDO" <%if request("statuss")="RESPONDIDO" then response.Write("selected") end if%>>RESPONDIDO-CLIENTE</option>
                            <option value="RESPONDIDO-COMPACTA" <%if request("statuss")="RESPONDIDO-COMPACTA" then response.Write("selected") end if%>>RESPONDIDO-COMPACTA</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <input type="submit" class="btn btn-success btn-large" value="Pesquisar ocorrências"/>
                    </div>
                    <div class="col-md-1">
                    	&nbsp;
                    </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
            

        <%if request("pesq")="ok" then
			if request("tipo")<>"" then
				tipos=" and tipo='"&request("tipo")&"' "
			end if
			if request("protocolo")<>"" then
				protocolos=" and protocolo like '%"&request("protocolo")&"%' "
			end if
			
			if request("statuss")<>"" then
				statuss=" and status='"&request("statuss")&"' "
			'else
				'statuss=" and status<>'CONCLUIDO' "
			end if
			
			set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id_cliente="&idx&" "&tipos&" "&statuss&" "&protocolos&"  order by id desc ")
            
			if not rs.eof then%>
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							<p class="card-title-desc">Esse é o local mais apropriado para manter contato com nosso departamento de manutenção. Abra uma nova ocorrência e em breve responderemos.
							</p>
                            <p>
                           	
                           	</p>
	
							<table class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
								<thead>
								<tr>
								  <th>Visualizar</th>
                                    <th>Protocolo</th>
									<th>Tipo</th>
									<th>Contrato</th>
									<th>Solicitado por</th>
									<th>Registro</th>
									<th>Status</th>
								</tr>
								</thead>
								<tbody>
								<%if not rs.eof then
								while not rs.eof%>
                                    <tr>
                                      <td class="text-center">
                                          <button type="button" class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target="#myModal<%=rs("id")%>"><i class="fas fa-search" title="Visualizar dados da ocorrência"></i></button>
                                            
                                          <!-- sample modal content -->
                                          <div id="myModal<%=rs("id")%>" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                              <div class="modal-dialog modal-lg">
                                                  <div class="modal-content">
                                                      <div class="modal-header">
                                                          <h5 class="modal-title mt-0" id="myModalLabel">Visualizar Ocorrência</h5>
                                                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                              <span aria-hidden="true">&times;</span>
                                                          </button>
                                                      </div>
                                                      <div class="modal-body" style="white-space: normal;">
                                                            
                                                           	  <%if rs("status")="ABERTO" then
                                                                    label="-primary"
                                                                elseif rs("status")="EM TRATAMENTO" then
                                                                    label="-warning"
																elseif rs("status")="RESPONDIDO" or rs("status")="RESPONDIDO-COMPACTA" then
                                            						label="-secondary"
                                                                elseif rs("status")="CONCLUIDO" or rs("status")="RESOLVIDA" or rs("status")="SOLUCIONADO" then
                                                                    label="-success"
                                                                end if%>
                                                              <span class="badge badge-soft<%=label%>"><%=ucase(rs("status"))%></span>
                                                          </p>
                                                          <p style="text-align:left;">
                                                              <small>
                                                               	  Solicitada por <%=rs("usuario")%> em <%=day(rs("datareg"))%>/<%=month(rs("datareg"))%>/<%=year(rs("datareg"))%> às <%=hour(rs("datareg"))%>:<%=minute(rs("datareg"))%>
                                                              </small>
                                                              <br />
                                                              Protocolo: <strong><%=rs("protocolo")%></strong><br />
                                                              Tipo: <strong><%=rs("tipo")%></strong><br />
                                                              <%if rs("tipo")="MOVIMENTACAO" then%>
                                                                  Referente a movimentação: <%set mo=conexao.execute("select * from TB_MOVIMENTACOES where id="&rs("id_movimentacao")&"")
                                                                    if not mo.eof then%><strong><a href="#"><%=mo("nome")%></a></strong><%end if%><%set mo=nothing%>
                                                              <%end if%>
                                                              Contrato: <strong>
															  <%if rs("id_contrato")<>"" then%>
                                                              <%set con=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&rs("id_contrato")&"")
                                                                if not con.eof then%>
                                                                  <%=con("ramo")%> . <%=con("operadora")%>
                                                              <%end if
                                                                set con=nothing
                                                                end if%>
                                                              </strong><br />
                                                              Célula Responsável: <strong><%=rs("celula")%></strong>
                                                              <br />
                                                              Título: <strong><%=rs("titulo")%></strong>
                                                              <br />
                                                              Descrição: <strong><%=rs("descricao")%></strong>
                                                          </p>
                                                          <h5 class="font-size-16">
                                                            <%if rs("celula")<>"SEGUROS" then%>
                                                            <!-- //////////////// ANEXOS ///////////////-->
                                                            <div class="alert alert-primary" role="alert">     
                                                                <h5 class="font-size-16"><i class="fas fa-paperclip"></i>&nbsp;ANEXOS</h5>
                                                                <p><!--#include file="lista_arquivos2.asp"--></p>
                                                                <p class="text-center">
                                                                <%if ucase(trim(rs("status")))<>"CONCLUIDO" then%>
                                                                        <i class="fas fa-upload" style="cursor:pointer;" onclick="window.open('painel.asp?go=ocorrencia_anexos&id=<%=rs("id")%>','Anexar Documentos','width=950,height=650');"></i>
                                                                     Inserir anexos
                                                                <%end if%>
                                                                </p>
                                                            </div>
                                                            <!-- //////////////// FIM ANEXOS ///////////////-->
                                                            
                                                            <%end if%>
                                                            
                                                            <div class="alert alert-primary" role="alert">
                                                            Histórico
                                                            </div>
                                                          </h5>
                                                          <p style="text-align:left;">
                                                            <%set hist=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS_HIST where id_ocorrencia="&rs("id")&" order by id asc")
															  if not hist.eof then%>
														    <ul style="text-align:left;">
															  <%while not hist.eof%>
                                                           	  <li style="font-size:14px; border-bottom-color:#CCC; border-bottom-style:solid; border-bottom-width:1px;">
                                                               	  <small style="color:#F00;"><%=hist("usuario")%> em <%=day(hist("datareg"))%>/<%=month(hist("datareg"))%>/<%=year(hist("datareg"))%> às <%=hour(hist("datareg"))%>:<%=minute(hist("datareg"))%> </small>
																  <br />
																  <%=hist("texto")%>
    																
                                                              </li>
                                                              <%hist.movenext
															  wend%>
                                                            </ul>
                                                            <%else%>
                                                                  Nenhum histórico encontrado!
                                                            <%end if
															  set hist=nothing%>
                                                          </p>
                                                          <p>&nbsp;</p>
                                                          <%if rs("status")<>"CONCLUIDO" then%>
                                                            <form action="painel.asp?go=ocorrencia" method="post">
                                                              <input type="hidden" name="id_ocorrencia" value="<%=rs("id")%>" />
                                                              <input type="hidden" name="gravar" value="ok2" />
                                                              <p>
                                                                <textarea name="historico" rows="3" id="historico" class="form-control" style="width:98%;" placeholder="Digite suas informações aqui"></textarea><br />
                                                                
                                                                <input type="submit" value="Responder" class="btn btn-warning btn-mini"/>
                                                              </p>
                                                            </form>
                                                            <%end if%>
                                                            
                                                      </div>
                                                      <div class="modal-footer" style="text-align:center; justify-content:center;">
                                                            
                                                          <%if rs("status")<>"CONCLUIDO" and rs("usuario")=userxy then%>
                                                          <small style="color:#F00;">Prezado, se não houver mais nenhuma pendência ou dúvida, favor clicar em Concluir Ocorrência.</small>
                                                          <div style="text-align:center; margin:8px;">
                                                              <a href="painel.asp?go=ocorrencia&id_ocorrencia=<%=rs("id")%>&concluir=ok">
                                                              <button type="button" class="btn btn-success waves-effect waves-light">Concluir Ocorrência</button>
                                                              </a>
                                                          </div>
                                                          <%end if%>
                                                            
                                                            
                                                      </div>
                                                  </div><!-- /.modal-content -->
                                              </div><!-- /.modal-dialog -->
                                          </div>
                                          <!-- /.modal -->
                                        </td>
                                        <td><%=rs("protocolo")%></td>
                                        <td><%=rs("tipo")%></td>
                                        <td>
                                        <%if rs("id_contrato")<>"" then%>
                                        <%set con=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&rs("id_contrato")&"")
                                        if not con.eof then%>
                                            <%=con("ramo")%> . <%=con("operadora")%>
                                        <%end if
                                        set con=nothing
                                        end if%>
                                        </td>
                                        <td><%=rs("usuario")%></td>
                                        <td style="text-align:center;">
                                        <%=databrx3(rs("datareg"))%> às <%=hour(rs("datareg"))%>:<%=minute(rs("datareg"))%> 
                                        </td>
                                        <td  class="text-center">
                                        <%if rs("status")="ABERTO" then
                                            label="-primary"
											text="EM ABERTO"
                                        elseif rs("status")="EM TRATAMENTO" then
                                            label="-warning"
											text="EM TRATAMENTO"
										elseif rs("status")="RESPONDIDO" then
                                            label="-secondary"
											text="RESPONDIDO-CLIENTE"
                                        elseif rs("status")="RESPONDIDO-COMPACTA" then
											label="-secondary"
											text="RESPONDIDO-COMPACTA"
										elseif rs("status")="CONCLUIDO" then
                                            label="-success"
											text="CONCLUIDO"
										elseif rs("status")="RESOLVIDA" or rs("status")="SOLUCIONADO" then
										 	label="-success"
											text="SOLUCIONADO"
                                        else
                                            label=""
                                        end if%>
                                        <span class="badge badge-soft<%=label%>"><%=ucase(text)%></span>
                                        </td>
                                    </tr>
                                
								<%rs.movenext
								wend
								else%>
								<tr>
									<td colspan="8" class="text-center">Nenhuma ocorrência encontrada!</td>
								</tr>
								<%end if%>
								
								</tbody>
							</table>
						</div>
					</div>
				</div> <!-- end col -->
			</div> <!-- end row -->
			<%end if
			set rs=nothing
		end if%>

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->


<script>
	function VerificaTipo(x){
		if (x=='SINISTRO'){
			document.getElementById('celula').value='SEGUROS';
			document.getElementById('descricao').setAttribute("placeholder","Informe a data, horario, nome do segurado e descreva o ocorrido para abertura desse sinistro.");
		}else{
			document.getElementById('celula').value='';
			document.getElementById('descricao').setAttribute("placeholder","Descreva aqui informações que você julgue importantes para essa ocorrência.");
		}
	}
</script>


<!--  modal Nova Ocorrencia -->
<div id="myModalx" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" id="myLargeModalLabel">Nova Ocorrência</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="painel.asp?go=ocorrencia" method="post" name="formx">
                <input type="hidden" name="gravar" value="ok" />
                <p>Tipo: 
                <select name="tipo" id="tipo" class="form-control" required onchange="VerificaTipo(this.value)">
                    <option value="">Selecione...</option>
                    <option value="SINISTRO">COMUNICAR SINISTRO</option>
                    <option value="DUVIDAS">DUVIDAS</option>
                    <option value="RECLAMACOES">RECLAMACOES</option>
                    <option value="SUGESTOES">SUGESTOES</option>
                    <option value="SOLICITACOES">SOLICITACOES</option>
                    <option value="OUTROS">OUTROS</option>
                 </select>
                 </p>
                 <p>
                 Contrato: 
                 
                    <select name="contrato" id="contrato" class="form-control" required>
                    <option value="">Selecione...</option>
                      <%AbreConexao
					  if contrato_permitido<>"" then
                            if contrato_permitido<>"0" then
                                con=split(trim(contrato_permitido),",")
                                for i=0 to ubound(con)
                                    if sqlcon<>"" then
                                        sqlcon=sqlcon&" or idcadastro="&idx&" and id="&con(i)&""
                                    else
                                        sqlcon="where idcadastro="&idx&" and id="&con(i)&""
                                    end if
                                next
                                
                                set cad=conexao.execute("select * from CADASTROGERAL_VENDAS "&sqlcon&" and status='ATIVO' and esconde_contrato='n'")
                            else
                                set cad=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
                            end if
                        else
                            set cad=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
                        end if%>
                  
                      <%if not cad.eof then
                      while not cad.eof%>
                        <option value="<%=cad("id")%>"><%=cad("ramo")%> . <%=cad("operadora")%> [<%=cad("codigo")%>]</option>
                      <%cad.movenext
                      wend
                      end if%>
                  </select>
                 </p>
                 <p>
                 Célula Responsável: 
                 <select name="celula" id="celula" class="form-control" required>
                    <option value="">Selecione...</option>
                    <option value="CADASTRO">CADASTRO</option>
                    <option value="FINANCEIRO">FINANCEIRO</option>
                    <option value="MANUTENCAO">MANUTENCAO</option>
                    <option value="RELACIONAMENTO">RELACIONAMENTO</option>
                    <option value="SEGUROS">SEGUROS</option>
                    <option value="SUPERVISAO">SUPERVISAO</option>
                  </select>
                 </p>
                 <p>Título: 
                   <input name="titulo" type="text" class="form-control" id="titulo" required />
                 </p>
                 <p>Descrição: 
                 <textarea name="descricao" rows="3" class="form-control" id="descricao" style="width:98%;" placeholder="Descreva aqui informações que você julgue importantes para essa ocorrência." required></textarea>
                 </p>
                 <p>
                 <div class="form-actions">
                    <input type="submit" class="btn btn-success btn-large" value="Gravar Ocorrência"/> 
                </div>	
                 </p>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!--  modal Nova Ocorrencia -->

                

<%if request("oco")="abre" then%>
	<script>
        $('#myModal').modal('show');
        
        document.getElementById('tipo').value='SINISTRO';
        document.getElementById('celula').value='SEGUROS';
        document.getElementById('descricao').setAttribute("placeholder","Informe a data, horario, nome do segurado e descreva o ocorrido para abertura desse sinistro.");
    </script>
<%end if%>  


<%if request("abremodal")<>"" then%>
<script>
	$('#myModal<%=request("abremodal")%>').modal('show');
</script>     
<%end if%>

