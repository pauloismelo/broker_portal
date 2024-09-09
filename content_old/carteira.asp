<%if request("modo")="solicitar" then
	AbreConexao
	set rs=conexao.execute("select * from VIA_CARTEIRA order by id desc")
	if rs.eof then
	idp=1
	else
	idp=rs("id")+1
	end if
	set rs=nothing
	
	x="insert into VIA_CARTEIRA (id, id_cliente, datareg, nome, matricula, contrato, usuario) values("&idp&", "&idx&", '"&day(now)&"/"&month(now)&"/"&year(now)&"', '"&request("nome")&"', '"&request("matricula")&"', '"&request("contrato")&"', '"&request("usuario")&"')"
	'response.Write(x)
	conexao.execute(x)



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
	myMail.Subject="2ª Via de Carteirinha - Portal Cliente"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="deman@compactasaude.com"
	myMail.Bcc="informativo@compactasaude.com"
	myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#02335C><tr><td><font color=#FFFFFF size=2 face=Arial><b>Compacta Saúde - Segunda Via de Carteirinha</b></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Empresa: "&request.form("empresa")&" ["&request.form("cnpj")&"]<br>Nome: <strong>"&request.form("nome")&"</strong><br>CPF / Matricula:<strong>"&request.form("matricula")&"</strong><br>Contrato:<strong>"&request.form("contrato")&"</strong><br>Usuario:<strong>"&request.form("usuario")&"</strong><br>Solicitante:<strong>"&userxy&"</strong>  <br><br></FONT><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr></table></center></body>" 
	
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing


response.Write("<script>alert('Solicitação Enviada com Sucesso!\nAguarde nosso retorno através do email informado.');</script>")
response.Write("<script>window.location='index.asp';</script>")

end if%>

<script>
function AbreInfo(x){
	if (x=='-'){
		document.getElementById('info').style.display='block';
		document.getElementById('botao').style.display='none';	
	}else{
		document.getElementById('info').style.display='none';
		document.getElementById('botao').style.display='block';	
	}
}
</script>


<div class="page-content">
    <div class="container-fluid">
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">2ª via de Carteirinha</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">2ª via de Carteirinha</li>
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
                       		Preencha os campos abaixo para solicitar a segunda via de carteirinha do beneficiário
                        </p>
                        
						<form action="painel.asp?go=carteira" method="post" name="form01">
                        <input type="hidden" name="modo" value="solicitar">
                        <input type="hidden" name="parametro" value="deman">
                        <input type="hidden" name="empresa" value="<%=titularx%>">
            			<input type="hidden" name="cnpj" value="<%=cnpjx%>">
                       
                       
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="nome">Nome do Beneficiário</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="nome" id="nome" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="matricula">CPF / Matrícula</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="matricula" id="matricula" required/>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="contrato">Contrato</label>
            				<div class="col-md-9">
                            	<select name="contrato" id="contrato" class="form-control" onchange="AbreInfo(this.value);"  required>
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
                                while not cad.eof
									
										if trim(cad("emitecarteira"))="s" then%>
											<option value="<%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%>"><%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%></option>
										<%else%>
                                            <option value="-"><%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%></option>
										<%end if%>
                                <%cad.movenext
                                wend%>
                                
                            </select>
                            </div>
                        </div>
                        <div class="form-group row" id="info" style="display:none;">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                    
                                <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                <h5 class="text-danger">ATENÇÃO</h5>
                                	<p>A operadora escolhida não emite carteira física para beneficiários.<br /> Favor, faça o download do aplicativo do seu plano e consulte a sua carteira virtual através do aplicativo.</p>
                                </div>
                                
                            </div>
                          
                       	</div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="usuario">Usuário</label>
            				<div class="col-md-9">
                            	<select name="usuario" id="usuario" class="form-control" required>
                                    <option value="">Selecione...</option>
                                    <option value="TITULAR">TITULAR</option>
                                    <option value="DEPENDENTE">DEPENDENTE</option>
                                </select>
                            </div>
                        </div>
                        
                        
                        <div class="form-group row" id="botao">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Carteirinha
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

    
                