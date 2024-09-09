<%if request("acao")="excluir" then
	AbreConexao
	set rs=conexao.execute("select * from TB_MOVIMENTACOES order by id desc")
		if rs.eof then
			idz=1
		else
			idz=rs("id")+1
		end if
	set rs=nothing
	
	if request("tipo")="TITULAR" then
		TITULO= "TRANSFERENCIA DE TITULAR"
	end if

	set cont=conexao.execute("select ramo, operadora, codigo from CADASTROGERAL_VENDAS where id="&request("contrato")&" ")
	if not cont.eof then
		ramo=cont("ramo")
		operadora=cont("operadora")
		codigo=cont("codigo")
	end if
	set cont=nothing

	set user=conexao.execute("select * from CADASTROGERAL where id="&request("usuario")&"")
		if not user.eof then
			if user("idcentro")<>"" then
				centro = user("idcentro")
			else
				centro = 0
			end if
			
			if user("idfilial")<>"" then
				filial = user("idfilial")
			else
				filial = 0
			end if
				
			x1=", dadmissao, matriculaf, dnasc, sexo, ecivil, email, mae, cep, rua, numero, complemento, bairro, cidade, estado, descricao"

			x2=", '"&user("dataadmissao")&"', '"&user("matriculaf")&"', '"&user("dnasc")&"', '"&user("sexo")&"', '"&user("ecivil")&"', '"&user("email")&"', '"&user("mae")&"', '"&user("cep")&"', '"&user("endereco")&"', '"&user("numero")&"', '"&user("bairro")&"', '"&user("complemento")&"', '"&user("cidade")&"', '"&user("estado")&"', 'TRANSFERENCIA DO BENEFICIARIO(A) "&user("titular")&" PROVENIENTE DO CONTRATO "&ramo&"."&operadora&" ["&codigo&"] | "&request("descricao")&"' "
			
		else
			centro = 0
			filial = 0
		end if
	set user=nothing
	
	
	
	
	protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&idz
	
	set mov2=conexao.execute("select * from TB_MOVIMENTACOES where tipo='EXCLUSAO' and id_usuario="&request("usuario")&" and id_contrato='"&request("contrato")&"' and status<>'concluida' and status<>'ANULADO' ")
	if not mov2.eof then
		response.Write("<script>alert('ATENÇAO!\nHá uma solicitacao de exclusao para esse beneficiario em aberto.\n Verifique no link Consultar Movimentações');</script>")
		response.Write("<script>window.history.back(-1);</script>")
	else
		Sql = "insert into TB_MOVIMENTACOES (id, nome, cpf, id_contrato, motivo, status, id_usuario, id_empresa, datareg, horareg, protocolo, solpor, tipo, descricao, dinicio, rn279, centrodecusto, filial, id_titular, ddemissao) VALUES ("&idz&", '"&request("nome")&"', '"&request("cpf")&"', '"&request("contrato")&"', 'TRANSFERENCIA', 'ENVIADO', "&request("usuario")&", "&idx&" , '"&databrx2(DATE)&"', '"&time&"', '"&protocolo&"', '"&userxy&"', 'EXCLUSAO', '"&request("descricao")&"', '"&request("vigencia")&"', '"&request("adesaorn")&"', "&centro&", "&filial&", "&request("idtitular")&", '"&databrx2(request("ddemissao"))&"' ) "
		'response.Write(Sql)
		conexao.Execute(Sql)
		'///////////////////////////

			concad=split(request("destino"),"|")
			id_contrato=concad(1)
			id_cadastro=concad(0)
			id_plano=request("plano")

			set cont=conexao.execute("select ramo, operadora, codigo from CADASTROGERAL_VENDAS where id="&id_contrato&" ")
			if not cont.eof then
				ramo2=cont("ramo")
				operadora2=cont("operadora")
				codigo2=cont("codigo")
			end if
			set cont=nothing

			TXT_TRANSFERENCIA="<br><br>MOTIVO: TRANSFERENCIA PARA OUTRO CNPJ DO GRUPO<br><br>TRANSFERIDO(A) PARA O CONTRATO: "&ramo2&"."&operadora2&" ["&codigo2&"]"

			idz2=idz+1
			protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&idz2

			Sql2 = "insert into TB_MOVIMENTACOES (id, nome, cpf, motivo, status, id_usuario, id_empresa, id_contrato, datareg, horareg, protocolo, solpor, tipo, dinicio, centrodecusto, filial, id_titular, aguardando, plano "&x1&") VALUES ("&idz2&", '"&request("nome")&"', '"&request("cpf")&"', 'TRANSFERENCIA', 'ENVIADO', "&request("usuario")&", "&id_cadastro&", "&id_contrato&", '"&databrx2(DATE)&"', '"&time&"', '"&protocolo&"', '"&userxy&"', 'INCLUSAO', '"&request("vigencia")&"', "&centro&", "&filial&", "&request("idtitular")&", 'n', '"&id_plano&"' "&x2&" ) "

			'response.Write("<br><Br><br><br>")
			'response.Write(Sql2)
			conexao.Execute(Sql2)

			set cad2=conexao.execute("select * from CADASTROGERAL where iddependente="&request("usuario")&" and  status2='ATIVO' ")
			if not cad2.eof then
			idz3=idz2
				while not cad2.eof
				idz3=idz3+1
					Sql3 = "insert into TB_MOVIMENTACOES (id, nome, cpf, motivo, status, solicitacao_principal, id_empresa, id_contrato, datareg, horareg, protocolo, solpor, tipo, dinicio, centrodecusto, filial, id_titular, aguardando, plano "&x1&") VALUES ("&idz3&", '"&cad2("titular")&"', '"&cad2("cpf")&"', 'TRANSFERENCIA', 'ENVIADO', "&idz2&", "&id_cadastro&", "&id_contrato&", '"&databrx2(DATE)&"', '"&time&"', '"&protocolo&"', '"&userxy&"', 'INCLUSAO', '"&request("vigencia")&"', "&centro&", "&filial&", "&request("idtitular")&", 'n', '"&id_plano&"' "&x2&" ) "

					'response.Write("<br><Br><br><br>")
					'response.Write(Sql3)
					conexao.Execute(Sql3)
				cad2.movenext
				wend
			end if
		
	
	end if
	
	'====================================ENVIA EMAIL
	mailmanager=""
	set ma=conexao.execute("select * from CADASTROGERAL_USUARIOS where idcadastro="&idx&" and email_novaexclusao='s'")
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
		set user=conexao.execute("select * from CADASTROGERAL where id="&request("usuario")&"")
		if not user.eof then
			if user("idfilial")<>"" and user("idfilial")<>"0" then
				set fi=conexao.execute("select * from CADASTROGERAL_FILIAL where id="&user("idfilial")&" ")
				if not fi.eof then
					mailfilial="<br><br>FILIAL: "&fi("nome")&""
				end if
				set fi=nothing
			end if
			
			if user("idcentro")<>"" and user("idcentro")<>"0" then
				set fi=conexao.execute("select * from CADASTROGERAL_CENTROS where id="&user("idcentro")&" ")
				if not fi.eof then
					mailcentro="<br><br>CENTRO DE CUSTO: "&fi("nome")&""
				end if
				set fi=nothing
			end if
		end if
	
	
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
		myMail.Subject="NOVA TRANSFERENCIA SOLICITADA"
		myMail.From="PORTAL COMPACTA <"&email_autentica&">"
		myMail.To=mailmanager&";"&emailx
		myMail.bcc="deman2@compactasaude.com;informativo@compactasaude.com"
		myMail.HTMLBody="<body style='color:#666666; font-size:24px; font-family:Arial'><table border=0 cellpadding=0 cellspacing=0 align='center' style='min-width:500px; width:690px;'><tr><td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left'><a href='http://plataformacompacta.com.br/painel_login.asp' title='ENTRAR NO PORTAL DO CORRETOR'><img src='http://www.compactasaude.com.br/mailling/deman/logobeneficios.png' height='60'  border='0'></a></td><td style='color:#fff; text-align:right; font-weight:bold'>ACOMPANHAMENTO DE MOVIMENTA&Ccedil;&Otilde;ES<BR>NO PORTAL DO CLIENTE</td></tr></table></td></tr><tr>  <td align='center' valign=top style='padding:20px; border-radius:10px; color:#000; font-weight: 400;'  bgcolor='#fff'>Nova transferencia solicitada via Portal do Cliente.</td></tr><tr><td align='left' valign=top style='padding:20px; border-radius:10px; color:#000;' bgcolor='#DFE8FD'>EMPRESA: "&titularx&"<br><br>CONTRATO: "&ramo&" . "&operadora&"<br><br> MOVIMENTA&Ccedil;&Atilde;O: "&TITULO&"<br><br>BENEFICI&Aacute;RIO: "&request("nome")&"<br><br>PROTOCOLO DA SOLICITA&Ccedil;&Atilde;O: "&protocolo&"<BR> "&mailfilial&""&mailcentro&"</td></tr><tr><td width=100% align='center' valign=top bgcolor='#f8f9fa' style='border-radius:10px; padding:20px;'><a href='https://www.compactasaude.com.br/canalcliente/login/' style='font-weight: 400; font-size: 20px;  color:#06F; text-decoration:underline;'>CLIQUE AQUI PARA ACOMPANHAR NO PORTAL</a></td> </tr> <tr> <td height='30' align='center' bgcolor='#EBEBEB' style='padding:20px; font-size:14px; border-radius:10px;'><strong>SE N&Atilde;O HOUVER PEND&Ecirc;NCIAS, ESSA SER&Aacute; EXECUTADA EM AT&Eacute; 48 HS &Uacute;TEIS.<br><br>Solicitado por "&userxy&" em: &nbsp; "&cdate(date)&" &nbsp; &agrave;s &nbsp; "&time&"</strong></td></tr><tr> <td valign=top bgcolor='#365cad' style='padding:10px; border-radius:10px; color:#FFFFFF; text-align:center'><span style='padding:15px; font-size:12px;'>Copyright &copy; "&year(now)&" - Plataforma Compacta. <br>  Todos os Direitos Reservados.</span></td></tr></table></body>"
						
		on error resume next								
		myMail.Send 										
		if err.number>0 then
			
		end if
		on error goto 0													
		set myMail=nothing 
		Set cdoConfig = Nothing
	end if
	'====================================FIM ENVIA EMAIL
	
	
	
	response.Write("<script>alert('Exclusao Solicitada com sucesso!');</script>")
	'response.Write("<script>window.open('album/index.php?id="&idz&"&tipo=exclusao');")
	response.Write("<script>window.location='painel.asp?go=inclusao_finaliza&id="&idz&"';</script>")
FechaConexao
end if%>





<div class="page-content">
    <div class="container-fluid">

        <%contrato=request("contrato")

		AbreConexao
		set ex=conexao.execute("select * from CADASTROGERAL where id="&request("id")&" ")
		
		set emp=conexao.execute("select * from CADASTROGERAL where id="&ex("idempresa")&"")
		if not emp.eof then
		%>
		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Transferir Beneficiário</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos_transferencia">Contratos</a></li>
                            <li class="breadcrumb-item active">Transferir Beneficiário</li>
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
                        
						<form action="painel.asp?go=transferencia" method="post" name="form01">
                        <input type="hidden" name="usuario" value="<%=ex("id")%>">
                    	<input type="hidden" name="empresa" value="<%=emp("titular")%>">
						<input type="hidden" name="id" value="<%=request("id")%>">
						<input type="hidden" name="etapa" value="2">
                         
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
                       
                       <div class="form-group row">
                            <label for="nome" class="col-md-3 col-form-label">Essa solicita&ccedil;&atilde;o &eacute; para:</label>
                            <div class="col-md-9">
                                 <%if ex("etitular")="s" then
                                    tit="TITULAR"
                                    texto="<br>Aten&ccedil;&atilde;o!!! <br>A transferencia de um titular exclui automaticamente todos os seus dependentes."			
                                    idtitular=0    
                                elseif ex("etitular")="n" then
                                
                                    tit="DEPENDENTE"
                                    idtitular=ex("iddependente")
                                end if%>
                                <strong><%=tit%></strong>
                                <input type="hidden" name="tipo" id="tipo" value="<%=tit%>" />
                                <input type="hidden" name="idtitular" id="idtitular" value="<%=idtitular%>" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="nome" class="col-md-3 col-form-label">Nome do Benefici&aacute;rio</label>
                            <div class="col-md-9">
                            	<%=ex("titular")%>
                                <input type="hidden" class="input-xlarge" name="nome" id="nome" value="<%=ex("titular")%>"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="nome" class="col-md-3 col-form-label">CPF</label>
                            <div class="col-md-9">
                            	<%if ex("cpf")<>"" and ex("cpf")<>"0" then%>
                                   	<%=ex("cpf")%>
                                    <input type="hidden" class="form-control" name="cpf" id="cpf" value="<%=ex("cpf")%>"/>
                                <%else%>
                                    <input type="text" name="cpf" id="cpf" class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true"/>
                                <%end if%>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="nome" class="col-md-3 col-form-label">CNPJ Origem</label>
                            <div class="col-md-9">
                            	<%set cadd=conexao.execute("select id, ramo, segmento, operadora, idvenda, contributario from CADASTROGERAL_VENDAS where id="&contrato&" ")
								if not cadd.eof then

									contributario=cadd("contributario")
									idvenda=cadd("idvenda")%>

									<strong><%=cnpjx%> | <%=cadd("ramo")%> - <%=cadd("segmento")%> - <%=cadd("operadora")%></strong>
									<input type="hidden" name="contrato" id="contrato" value="<%=cadd("id")%>" />
									<input type="hidden" name="contributario" id="contributario" value="<%=cadd("contributario")%>" />
								
								<%end if
								set cadd=nothing%>    
                            </div>
                        </div>
                        

						<%set subf=conexao.execute("select id, subfaturadeidcx from CAIXAVENDAS where id="&idvenda&"  ")
						if not subf.eof then
							if subf("subfaturadeidcx")<>"0" then 'é uma subatura
								
								id_principal=subf("subfaturadeidcx")
							else
								'VErifica se esse registro e matriz de alguma subfatura
								set subf2=conexao.execute("select id from CAIXAVENDAS where subfaturadeidcx="&idvenda&" order by id desc")
								if not subf2.eof then
									
									id_principal=subf("id")
								end if       
								set subf2=nothing 
							end if
						end if
						set subf=nothing%>
						
						<div style="color:#F00;">
						<div class="form-group row">
                            <label for="nome" class="col-md-3 col-form-label">CNPJ Destino</label>
                            <div class="col-md-9">
								<%if request("destino")<>"" then%>
									<strong>
										<%idd_contrato=split(request("destino"),"|")
										set con=conexao.execute("select idvenda from CADASTROGERAL_VENDAS where id="&idd_contrato(1)&" ")
										if not con.eof then
											set con2=conexao.execute("select cnpjcpf from CAIXAVENDAS where id="&con("idvenda")&"")
											if not con2.eof then
												response.Write(con2("cnpjcpf"))
											end if
											set con2=nothing
										end if
										set con=nothing%>
									</strong>
								<%else%>
								<select name="destino" id="destino" style="width:80%;" class="form-control" required onchange="AlertaTransf();">								
                                    <option value="">Selecione...</option>
									<%set subf=conexao.execute("select id, ramo, segmento, operadora, cnpjcpf from CAIXAVENDAS where id="&id_principal&" and id<>"&idvenda&" or subfaturadeidcx="&id_principal&" and id<>"&idvenda&" ")
									if not subf.eof then
										while not subf.eof
											set subf2=conexao.execute("select id,idcadastro, ramo, segmento,operadora from CADASTROGERAL_VENDAS where idvenda="&subf("id")&" ")
											if not subf2.eof then%>

												<option value="<%=subf2("idcadastro")%>|<%=subf2("id")%>"><%=subf("cnpjcpf")%></option>

											<%end if
											set subf2=nothing%>
										<%subf.movenext
										wend
									end if
									set subf=nothing%>

								</select>
								<%end if%>
							</div>
							
						</div>
						<%if request("etapa")<>"2" then%>
						<div class="form-group row">
							<div class="col-md-12 text-center">
								<button type="submit" class="btn btn-success waves-effect waves-light">
									<i class="uil uil-check mr-2"></i> Pr&oacute;xima etapa
								</button>
							</div>
						</div>
						<%end if%>
						</form>

						<%if request("etapa")="2" then%>
						<form action="painel.asp?go=transferencia&acao=excluir" method="post" name="form01">
							<input type="hidden" name="usuario" value="<%=ex("id")%>">
							<input type="hidden" name="empresa" value="<%=emp("titular")%>">
							<input type="hidden" name="destino" value="<%=request("destino")%>">
							<input type="hidden" name="contrato" value="<%=request("contrato")%>" />
							<input type="hidden" name="contributario" value="<%=request("contributario")%>" />
							<input type="hidden" name="cpf" value="<%=request("cpf")%>">
							<input type="hidden" name="tipo" value="<%=request("tipo")%>" />
							<input type="hidden" name="idtitular" value="<%=request("idtitular")%>" />
							<input type="hidden" name="nome" value="<%=request("nome")%>" />
							<input type="hidden" name="id" value="<%=request("id")%>" />

							<div class="form-group row">
								<div class="col-md-12">
									<div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
										<div class="row">
											<div class="col-md-6 text-right">
												<i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
											</div>
											<div class="col-md-6 text-left pt-4">
												<h3 class="text-danger">ATENÇÃO</h3>
											</div>
										</div>
										
										<p>Voc&ecirc; est&aacute; solicitando uma TRANSFERENCIA de um usu&aacute;rio PARA OUTRO CNPJ DO GRUPO.<br>Automaticamente será criado um protocolo de <strong>exclusão</strong> para o CNPJ atual e um protocolo de <strong>inclusão</strong> para o CNPJ de destino.<br><br>É obrigatório o envio de vínculo empregatício com o CNPJ de destino!<br>Favor atentar-se abaixo para o plano escolhido. Sempre que possível o plano escolhido deverá ser o mesmo plano que o usuario ja estava.<br>Caso contrário poderá haver carências se a acomodação ou o plano forem diferentes do anterior.</p>
									</div>
									
								</div>
							</div>
							</div>
							
							<div class="form-group row">
								<label for="nome" class="col-md-3 col-form-label">
									Planos disponíveis
								</label>
								<div class="col-md-9">
									<%idd_contrato=split(request("destino"),"|")%>
									
									<select name="plano" id="plano" class="form-control" required>	
										<option value="">Selecione...</option>
										<%set subf=conexao.execute("select id,nome,acomodacao from CADASTROGERAL_PLANOS where contrato="&idd_contrato(1)&" and status='ATIVO' ")
										if not subf.eof then
											while not subf.eof%>
												<option value="<%=subf("id")%>"><%=subf("nome")%>&nbsp;<%=ucase(subf("acomodacao"))%></option>
											<%subf.movenext
											wend
										end if
										set subf=nothing%>

									</select>
									
								</div>
								
							</div>
							
							
							
							<div class="form-group row">
								<label for="nome" class="col-md-3 col-form-label">Efetuar a transfer&ecirc;ncia em:</label>
								<div class="col-md-9">
									<input class="form-control" type="date" name="vigencia" id="vigencia" value="<%=databrx3(date)%>" min="<%=databrx2(date)%>" required>
								</div>
							</div>
							
							<div class="form-group row">
								<label for="nome" class="col-md-3 col-form-label">Observa&ccedil;&otilde;es</label>
								<div class="col-md-9">
									<textarea name="descricao" rows="3" class="form-control" id="descricao" style="width:98%;" placeholder="Descreva aqui informações que você julge importantes para essa movimentação."></textarea>
								</div>
							</div>
							
							<div class="form-group row">
								<div class="col-md-12">
									<div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
									<i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
									<h5 class="text-danger">ATENÇÃO</h5>
									<p>*Em dias de feriado municipal na cidade de Belo Horizonte ou feriados estaduais ou nacionais, <br />essa movimentação será executada no próximo dia útil.<br />
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
										<i class="uil uil-check mr-2"></i> Solicitar Transfer&ecirc;ncia
									</button>
								</div>
							</div>
                      	</form>
						<%end if%>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
        <%end if
		set rs=nothing
		FechaConexao%>
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

<script>
function ConfereExc(){
	if(document.getElementById('motivo').value==''){
		alert('Selecione o motivo referente à sua solicitação!');
		document.formx.motivo.focus();
	}	else{
		document.formx.submit();	
	}
}


function Abrecampo(x){
	if (x=='DEMITIDO - SEM JUSTA CAUSA'){
		document.getElementById('demissao').style.display='block';
		document.getElementById('RN').style.display='block';
		document.getElementById('Div_Transf').style.display='none';
		document.getElementById('destino').removeAttribute("required");

	}else if (x=='TRANSFERENCIA'){
		document.getElementById('Div_Transf').style.display='block';
		document.getElementById('destino').setAttribute("required","required");

		document.getElementById('demissao').style.display='none';
		document.getElementById('RN').style.display='none';

	}else if (x=='DEMITIDO - COM JUSTA CAUSA' || x=='DESLIGAMENTO DE COMUM ACORDO' || x=='FIM DE CONTRATO DO TRABALHO INTERMITENTE' || x=='PEDIDO DE DEMISSÃO VOLUNTÁRIA' || x=='PEDIDO DE DESLIGAMENTO - RN 279'){
		document.getElementById('demissao').style.display='block';
		document.getElementById('Div_Transf').style.display='none';

		document.getElementById('Div_Transf').style.display='none';
		document.getElementById('destino').removeAttribute("required");
	}else{
		document.getElementById('demissao').style.display='none';
		document.getElementById('RN').style.display='none';
		document.getElementById('Div_Transf').style.display='none';
		document.getElementById('destino').removeAttribute("required");
	}
}



 $(function(){
        $('#vigencia').datepicker({
			selectOtherMonths: true,
            numberOfMonths: 1,
			dateFormat: 'dd/mm/yy',
			minDate: 0 //quantidade de meses mostrados
			});
        });
</script>
                
                