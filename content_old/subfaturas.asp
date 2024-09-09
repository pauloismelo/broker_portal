<%if request("modo")="solicitar" then
	set cli=conexao.execute("select * from CADASTROGERAL where id="&idx&" ")
		cliente=cli("titular")
	set cli=nothing
	
	set con=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("contrato")&"")
	if not con.eof then
		contrato=ucase(con("ramo"))&"."&ucase(con("segmento"))&"."&ucase(con("operadora"))
	end if
	set con=nothing
	
	texto="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#02335C><tr><td><font color=#FFFFFF size=2 face=Arial><b>Compacta Saúde - Solicitação de abertura de sub-fatura</b></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Cliente: <strong>"&cliente&"</strong><br>Sub-estipulante: <strong>"&request.form("subestipulante")&"</strong> <br>CNPJ: <strong>"&request.form("cnpj")&"</strong><br>Contrato: <strong>"&contrato&"</strong><br>Vinculo:<strong>"&request.form("vinculo")&"</strong><br>Quantidade de titulares:<strong>"&request.form("titulares")&"</strong><br>Quantidade de dependentes:<strong>"&request.form("dependentes")&"</strong><br>Motivo:<strong>"&request.form("motivo")&"</strong><br>Solicitante:<strong>"&userxy&"</strong>  <br><br></FONT><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr></table></center></body>" 
	
	protocolo=year(now)&""&month(now)&""&day(now)&""&hour(now)&""&minute(now)&""&second(now)
	set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS order by id desc")
	if rs.eof then
	idz=1
	else
	idz=rs("id")+1
	end if
	set rs=nothing
	
	
	Sql = "INSERT INTO PORTALCLIENTE_OCORRENCIAS (id, id_cliente, usuario, tipo, descricao, datareg, status, id_contrato, celula, id_movimentacao, protocolo) VALUES ("&idz&", "&idx&", '"&userxy&"', 'ABERTURA SUBFATURA', '"&texto&"', '"&month(now)&"/"&day(now)&"/"&year(now)&" "&hour(time)&":"&minute(time)&"', 'ABERTO', "&request("contrato")&", 'MANUTENÇÃO', 0, '"&protocolo&"' )"
	conexao.Execute(Sql)



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
	myMail.Subject="Abertura de Sub-fatura - Portal Cliente"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="deman@compactasaude.com"
	myMail.Bcc="informativo@compactasaude.com"
	myMail.HTMLBody=texto
	
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
                    <h4 class="mb-0">Sub-Faturas</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">Sub-Faturas</li>
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
                       		Preencha os campos abaixo para solicitar a abertura da sub-fatura
                        </p>
                        
						<form action="painel.asp?go=subfaturas" method="post" name="form01">
                        <input type="hidden" name="modo" value="solicitar">
                        <input type="hidden" name="parametro" value="deman">
                        <input type="hidden" name="empresa" value="<%=titularx%>">
            			<input type="hidden" name="cnpj" value="<%=cnpjx%>">
                       
                       
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="subestipulante">Sub Estipulante</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="subestipulante" id="subestipulante" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="cnpj">CNPJ</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="cnpj" id="cnpj" required/>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="contrato">Contrato</label>
            				<div class="col-md-9">
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
								end if
                                while not cad.eof%>
											<option value="<%=cad("id")%>"><%=ucase(cad("ramo"))%>.<%=ucase(cad("segmento"))%>.<%=ucase(cad("operadora"))%></option>
                                <%cad.movenext
                                wend%>
                                
                            </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="vinculo">Vínculo com o Estipulante</label>
            				<div class="col-md-9">
                            	<select name="vinculo" id="vinculo" class="form-control" required>
                                <option value="">Selecione...</option>
                                <option value="FILIAL">FILIAL</option>
                                <option value="PRESTADOR DE SERVIÇO PJ">PRESTADOR DE SERVIÇO PJ</option>
                                <option value="EMPRESA COLIGADA">EMPRESA COLIGADA</option>
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="titulares">Quantidade de titulares</label>
            				<div class="col-md-9">
                            	<input type="number" name="titulares" id="titulares" class="form-control" value="0" required  />
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="dependentes">Quantidade de dependentes</label>
            				<div class="col-md-9">
                            	<input type="number" name="dependentes" id="dependentes" class="form-control" value="0" required  />
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="motivo">Descreva o motivo da solicitação de abertura</label>
            				<div class="col-md-9">
                              <textarea name="motivo" rows="3" class="form-control" id="motivo" required="required"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group row" id="botao">
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Abertura
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

    
                