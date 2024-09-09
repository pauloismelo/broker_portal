


<%if request("acao")="gravar" then
AbreConexao
set rs=conexao.execute("select * from CADASTROGERAL where id="&idx&"")

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
		myMail.Subject=ucase(request("nome"))&", "&ucase(userxy)&" TE INDICOU"
		myMail.From="COMPACTA SAUDE <"&email_autentica&">"
		myMail.AddAttachment caminho&"APRESENTACAOCOMPACTA.pdf"
		myMail.To=request("email")
		myMail.bcc="detec@compactasaude.com;luciano@compactasaude.com"
		myMail.HTMLBody="<body style='color:#666666; font-size:24px; font-family:Arial'><table border=0 cellpadding=0 cellspacing=0 align='center' style='width:650px;'><tr><td><img src=https://www.portalcompacta.com.br/img/mailing/topo.png></td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000;' bgcolor='#DFE8FD'>Olá <strong>"&request("nome")&"</strong>,<br><br>você foi indicado por "&userxy&",<br> da empresa "&rs("nomefantasia")&"<br> para conhecer nossos serviços e produtos.<br><br> Segue em anexo nossa apresentação para sua apreciação.<br><br>Caso deseje mais informações, estaremos sempre à disposição.<br><br><br><strong>3201-9969</strong><br><strong>deman@compactasaude.com</strong></td></tr><tr><td align='center' valign=top bgcolor='#f8f9fa'  style='padding:15px;  border-radius:10px;'></td></tr><tr><td><img src=https://www.portalcompacta.com.br/img/mailing/botton.png></td></tr></table></body>"
			
										
											
		myMail.Send 										
														
		set myMail=nothing 
		Set cdoConfig = Nothing
	

	response.Write("<script>alert('Indicação enviada com sucesso\nObrigado por confiar em nosso trabalho!');</script>")
	response.Write("<script>window.location='index.asp';</script>")
FechaConexao
end if%>




<div class="page-content">
    <div class="container-fluid">

        
		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Indique a Compacta</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Excluir Beneficiário</li>
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
                    	<p class="card-title-desc">
                       		Informe o e-mail e o nome da pessoa que deseja indicar. Enviaremos um email para a pessoa indicada.
                        </p>
                        
						<form action="painel.asp?go=indique_compacta" method="post" name="form01">
                        <input type="hidden" name="acao" value="gravar">
                       
                       <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="name">Nome</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="nome" id="nome" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="email">Email</label>
            				<div class="col-md-9">
                            	<input type="email" class="form-control" name="email" id="email" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="empresa">Empresa</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="empresa" id="empresa" required/>
                            </div>
                        </div>
                        
                        
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Indicar
                                </button>
                            </div>
                        </div>
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
       
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

    
                