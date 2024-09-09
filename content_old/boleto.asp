<%if request("modo")="solicitar" then
	AbreConexao
	set rs=conexao.execute("select * from VIA_BOLETO order by id desc")
	if rs.eof then
	idp=1
	else
	idp=rs("id")+1
	end if
	set rs=nothing
	
	conexao.execute("insert into VIA_BOLETO (id, id_cliente, matricula, cnpj, razao_social, mes, ano, email, datareg, contrato) values("&idp&", "&idx&", '"&request("matricula")&"', '"&cnpjx&"', '"&RAZAOSOCIAL&"', '"&request("mes")&"', '"&request("ano")&"', '"&request("email")&"', '"&databrx2(date)&"', '"&request("contrato")&"')")



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
		myMail.Subject="2 via de boleto"
		myMail.From="COMPACTA SAUDE <"&email_autentica&">"
		myMail.To="deman@compactasaude.com"
		'myMail.bcc="detec@compactasaude.com"
		myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#000000><tr> <td><font color=#FFFFFF size=2 face=Arial><b>Compacta Saúde - Segunda Via de Boleto</b></font></td></tr> <tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>CNPJ:<strong> "&cnpjx&"</strong><br>Razão Social:<strong>"&RAZAOSOCIAL&"</strong><br>Email: <strong>"&request.form("email")&"</strong><br>Contrato: <strong>"&request.form("contrato")&"</strong><br>Data Refer&ecirc;ncia: <strong>"&request.form("mes")&"/"&request.form("ano")&"</strong><br>Solicitado por: <strong>"&userxy&"</strong><br><br> <br></FONT><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr></table></center></body>"
			
											
		myMail.Send 										
														
		set myMail=nothing 
		Set cdoConfig = Nothing
	
	
	


response.Write("<script>alert('Solicitação Enviada com Sucesso!\nAguarde nosso retorno através do email informado.');</script>")
response.Write("<script>window.location='index.asp';</script>")

end if%>





<div class="page-content">
    <div class="container-fluid">

        
		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">2ª via de boleto</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">2ª via de boleto</li>
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
                       		Preencha os campos abaixo para solicitar a segunda via do seu boleto
                        </p>
                        
						<form action="painel.asp?go=boleto" method="post" name="form01">
                        <input type="hidden" name="modo" value="solicitar">
                        <input type="hidden" name="parametro" value="deman">
                       
                       <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="mes">Mês de Referência</label>
            				<div class="col-md-9">
                            	
                                <select name="mes" id="mes" class="form-control" required>
                                    <option value="">Selecione...</option>
                                    <option value="01">Janeiro</option>
                                    <option value="02">Fevereiro</option>
                                    <option value="03">Mar&ccedil;o</option>
                                    <option value="04">Abril</option>
                                    <option value="05">Maio</option>
                                    <option value="06">Junho</option>
                                    <option value="07">Julho</option>
                                    <option value="08">Agosto</option>
                                    <option value="09">Setembro</option>
                                    <option value="10">Outubro</option>
                                    <option value="11">Novembro</option>
                                    <option value="12">Dezembro</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="ano">Ano de Referência</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="ano" id="ano" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="email">Email</label>
            				<div class="col-md-9">
                            	<input type="email" class="form-control" name="email" id="email" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="contrato">Contrato</label>
            				<div class="col-md-9">
                            	<select name="contrato" id="contrato" class="form-control"  required>
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
								end if
                                while not cad.eof%>
                                    <option value="<%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%>"><%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%> - Dia de venc: <%=cad("vencimento")%></option>
                                <%cad.movenext
                                wend%>
                                
                            </select>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Boleto
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

    
                