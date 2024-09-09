<%
if request("modo")="solicitar" then

'-------------------Envia para DEMAN E DETEC
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
		myMail.Subject="Atualizacao Cadastral - Portal Cliente"
		myMail.From="COMPACTA SAUDE <"&email_autentica&">"
		myMail.ReplyTo=request.Form("email")
		myMail.To="deman@compactasaude.com"
		myMail.Bcc="informativo@compactasaude.com"
		myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#FFF><tr><td><font color=#000 size=2 face=Arial><b>Compacta Sa&uacute;de - Altera&ccedil;&atilde;o Cadastral</b></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2>Deman, <br>segue dados da empresa <strong>"&request("nome")&"</strong> para altera&ccedil;&atilde;o cadastral.<br><br>Empresa: <strong>"&request.form("nome")&"</strong><br>CNPJ: <strong>"&request.form("cnpj")&"</strong><br>Funcion&aacute;rios no FGTS:<strong>"&request.form("fgts")&"</strong><br>Telefone:<strong>"&request.form("telefone")&"</strong><br>Endere&ccedil;o:<strong>"&request.form("endereco")&"</strong><br>Bairro:<strong>"&request.form("bairro")&"</strong><br>Cidade:<strong>"&request.form("cidade")&"</strong><br>UF:<strong>"&request.form("uf")&"</strong><br>CEP:<strong>"&request.form("cep")&"</strong><br><br><strong>Endere&ccedil;o de Correspondencia</strong><br>Endereco:<strong>"&request.form("endereco2")&"</strong><br>Bairro:<strong>"&request.form("bairro2")&"</strong><br>cidade:<strong>"&request.form("cidade2")&"</strong><br>UF:<strong>"&request.form("uf2")&"</strong><br>CEP:<strong>"&request.form("cep2")&"</strong><br><br><br><br></FONT><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr></table></center></body>" 
		
		myMail.Send 
		set myMail=nothing 
		Set cdoConfig = Nothing


response.Write("<script>alert('Solicitação Enviada com Sucesso!\nAguarde nosso retorno através do email informado.');</script>")
response.Write("<script>window.location='index.asp';</script>")

end if
%>

<div class="page-content">
    <div class="container-fluid">
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Alteração Cadastral</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Alteração Cadastral</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
       
		
		<%set rs=conexao.execute("select * from cadastrogeral where id="&idx&" ")%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Atualize seus dados cadastrais abaixo, caso necessário.</p>
                        
                       
                             <form action="painel.asp?go=cadastro" method="post">
                             <input type="hidden" name="modo" value="solicitar" />
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Nome</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="nome" name="nome" value="<%=rs("titular")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">CNPJ</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="cnpj" name="cnpj" value="<%=rs("cnpj")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Funcionários no FGTS</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="fgts" name="fgts" value="<%=rs("qtdfgts")%>"></div>
                             </div>
                             
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Telefone</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="telefone" name="telefone" value="<%=rs("telefone1")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Endereço</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="endereco" name="endereco" value="<%=rs("endereco")%>, <%=rs("numero")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Complemento</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="complemento" name="complemento" value="<%=rs("complemento")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Bairro</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="bairro" name="bairro" value="<%=rs("bairro")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Cidade</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="cidade" name="cidade" value="<%=rs("cidade")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">UF</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="uf" name="uf" value="<%=rs("estado")%>"></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">CEP</label>
                                <div class="col-md-10"><input type="text" class="form-control" id="cep" name="cep" value="<%=rs("cep")%>"></div>
                             </div>
                             
                             <div class="form-group row">
                                <div class="col-md-12 text-center">
                                	<button type="submit" class="btn btn-success waves-effect waves-light">
                                        <i class="uil uil-check mr-2"></i> SOLICITAR ALTERAÇÃO
                                    </button>
                                </div>
                             </div>
                             
                             </form>

                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                
       

