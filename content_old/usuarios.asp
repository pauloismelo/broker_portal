<%
if request("gravar")="ok" then
	AbreConexao
	SQL="insert into CADASTROGERAL_USUARIOS (nome, cpf, nascimento, login, senha, por, datareg, idcadastro, celular, cargo, status) values ('"&ucase(request("nome"))&"', '"&request("cpf")&"', '"&databrx2(request("nascimento"))&"', '"&request("login")&"', '"&request("senha")&"', '"&userxy&"', '"&date&"', "&idx&", '"&request("celular")&"', '"&request("cargo")&"', 'PENDENTE')"
	conexao.execute(SQL)
	
	
	set cli=conexao.execute("select * from CADASTROGERAL where id="&idx&" ")
	cliente=cli("titular")
	set cli=nothing
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
	myMail.Subject="NOVA SOLICITACAO DE USUARIO CADASTRADO"
	myMail.From="PORTAL DO CLIENTE COMPACTA <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="deman2@compactasaude.com"
	'myMail.Bcc="detec@compactasaude.com"
	myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>NOVA SOLICITA&Ccedil;&Atilde;O DE  USU&Aacute;RIO</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Um novo usu&aacute;rio para acesso ao Portal do Cliente foi cadastrado.<br><br>Cliente: <strong>"&cliente&"</strong><br>Usuário: <strong>"&request("nome")&"</strong><br>Cadastrado por: <strong>"&userxy&"</strong><br><br>Favor, verificar as informa&ccedil;&otilde;es no sistema SISCAD, ativar o novo usu&aacute;rio e enviar o email com o login e senha para o novo usu&aacute;rio.<br><br><br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing
	
	
	FechaConexao
	response.Write("<script>alert('Solicitação realizada com sucesso!\nEm breve nossa equipe de relacionamento ativará o acesso.');</script>")
	response.Write("<script>window.location='painel.asp?go=usuarios';</script>")
end if

if request("acao")="block" then
	AbreConexao
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
		myMail.Subject="USUARIO BLOQUEADO NO PORTAL DO CLIENTE"
		myMail.From="PORTAL DO CLIENTE COMPACTA <"&email_autentica&">"
		myMail.To="deman2@compactasaude.com"
		'myMail.Bcc="detec@compactasaude.com"
		myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>USU&Aacute;RIO BLOQUEADO</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2>Um usu&aacute;rio teve o seu acesso ao Portal do Cliente <strong>bloqueado</strong>.<br><br>Usu&aacute;rio: <strong>"&request("nome")&"</strong><br>Bloqueado por: <strong>"&userxy&"</strong><br><br><br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
		myMail.Send 
		set myMail=nothing 
		Set cdoConfig = Nothing
		
		conexao.execute("update CADASTROGERAL_USUARIOS set status='BLOQUEADO' where id="&request("id")&" ")
		response.Write("<script>alert('Usuário Bloqueado com sucesso!.');</script>")
	response.Write("<script>window.location='painel.asp?go=usuarios';</script>")
	FechaConexao
end if

if request("acao")="ativar" then
	AbreConexao
		
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
		myMail.Subject="USUARIO REATIVADO NO PORTAL DO CLIENTE"
		myMail.From="PORTAL DO CLIENTE COMPACTA <"&email_autentica&">"
		myMail.To="deman2@compactasaude.com"
		'myMail.Bcc="detec@compactasaude.com"
		myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>USU&Aacute;RIO REATIVADO</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2>Um usu&aacute;rio teve o seu acesso ao Portal do Cliente <strong>reativado</strong>.<br><br>Usu&aacute;rio: <strong>"&request("nome")&"</strong><br>Reativado por: <strong>"&userxy&"</strong><br><br><br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
		myMail.Send 
		set myMail=nothing 
		Set cdoConfig = Nothing
		
		conexao.execute("update CADASTROGERAL_USUARIOS set status='ATIVO' where id="&request("id")&" ")
		response.Write("<script>alert('Usuário Ativado com sucesso!.');</script>")
	response.Write("<script>window.location='painel.asp?go=usuarios';</script>")
	FechaConexao
end if
%>

<div class="page-content">
    <div class="container-fluid">
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Usuários</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Usuários</li>
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
                    	 <button type="button" class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target="#myModal"><i class="fas fa-plus"></i> SOLICITAR CADASTRO DE NOVO USUÁRIO</button>
                         <!-- sample modal content -->
                                                <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                    	<form action="painel.asp?go=usuarios&gravar=ok" method="post">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title mt-0" id="myModalLabel">Solicitar cadastro de novo usuário</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <table border="0" cellpadding="4" cellspacing="4">                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">&nbsp;</td>
                                                                      <td align="left">&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">Nome</td>
                                                                      <td align="left"><input type="text" name="nome" class="form-control" required minlength="10" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">CPF</td>
                                                                      <td align="left"><input type="text" name="cpf" class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true" required /></td>
                                                                  <tr>
                                                                      <td align="right" style="padding-left:15px;">Nascimento</td>
                                                                      <td align="left"><input type="date" name="nascimento" class="form-control" required /></td>
                                                                  </tr>
                                                            <tr>
                                                                      <td align="right" style="padding-left:15px;">Celular</td>
                                                                      <td align="left"><input type="text" name="celular" class="form-control input-mask" data-inputmask="'mask': '(99)99999-9999'" im-insert="true" required /></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">Cargo na empresa</td>
                                                                      <td align="left"><input type="text" name="cargo" class="form-control" required /></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">Login</td>
                                                                      <td align="left"><input type="text" name="login" placeholder="Email para login" class="form-control" required /></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td align="right" style="padding-left:15px;">Senha</td>
                                                                      <td align="left"><input type="text" name="senha" class="form-control" required /></td>
                                                                    </tr>
                                                                    
                                                                    
                                                                </table>
                                                                    
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-light waves-effect" data-dismiss="modal">Fechar</button>
                                                                <button type="submit" class="btn btn-primary waves-effect waves-light">Gravar</button>
                                                            </div>
                                                        </div><!-- /.modal-content -->
                                                        </form>
                                                    </div><!-- /.modal-dialog -->
                                                </div><!-- /.modal -->
                        
                    </div>
                </div>
            </div>
        </div>
		<%set cad=conexao.execute("select * from cadastrogeral_usuarios where idcadastro="&idx&" and cargo<>'deman' order by nome asc")%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <h4 class="card-title">Usuários cadastrados</h4>
                        <p class="card-title-desc">Segue abaixo os usuários da sua empresa cadastrados para acessar o portal do cliente</p>

                        <table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Nascimento</th>
                                    <th>Login</th>
                                    <th>Cargo</th>
                                    <th>Status</th>
                                    <th>Gerenciar acesso</th>
                                    <th>Cadastrado</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%if not cad.eof then
							while not cad.eof%>
                            <tr> 
                                <td><%=cad("nome")%></td>
                                <td><%=databrx3(cad("nascimento"))%></td>
                                <td><%=cad("login")%></td>
                                <td><%=cad("cargo")%></td>
                                <td><%=cad("status")%></td>
                                <td style="text-align:center;">
								<%if cad("status")="ATIVO" then%>
                                    <script type="text/javascript"> 
                                    function confirmation<%=cad("id")%>() {
                                        var answer = confirm("Deseja realmente [BLOQUEAR] o usuário <%=cad("nome")%>?")
                                        if (answer){
                                            //alert("Registro Removido com sucesso!")
                                            window.location = 'painel.asp?go=usuarios&id=<%=cad("id")%>&acao=block&nome=<%=cad("nome")%>';
                                        }
                                    }
                                    </script>
                                    <i class="fas fa-trash-alt" onclick="confirmation<%=cad("id")%>();" style="cursor:pointer;" title="BLOQUEAR ACESSO DE <%=CAD("NOME")%>"></i>
                                <%elseif cad("status")="BLOQUEADO" then%>
                                    <script type="text/javascript"> 
                                    function ativation<%=cad("id")%>() {
                                        var answer = confirm("Deseja realmente [ATIVAR] o usuário <%=cad("nome")%>?")
                                        if (answer){
                                            //alert("Registro Removido com sucesso!")
                                            window.location = 'painel.asp?go=usuarios&id=<%=cad("id")%>&acao=ativar&nome=<%=cad("nome")%>';
                                        }
                                    }
                                    </script>
                                    <i class="fas fa-retweet" onclick="ativation<%=cad("id")%>();" style="cursor:pointer;" title="ATIVAR ACESSO DE <%=CAD("NOME")%>"></i>
                                <%end if%>
                                </td>
                                <td style="text-align:center;">
                                <%=day(cad("datareg"))%>/<%=month(cad("datareg"))%>/<%=year(cad("datareg"))%>
                                </td>
                            </tr>
                            <%cad.movenext
							wend
							else%>
                            <tr>
                                <td colspan="7" class="text-center">Nenhum usuário encontrado!</td>
                            </tr>
                            <%end if%>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                
       

