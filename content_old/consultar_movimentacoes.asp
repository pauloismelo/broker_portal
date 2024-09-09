
<%
if request("acao")="delete" then
	AbreConexao
	conexao.execute("update TB_MOVIMENTACOES set removido='s', removido_por='"&userxy&"', removido_em='"&date&" "&time&"', status='ANULADO' where id="&request("id")&" or solicitacao_principal='"&request("id")&"' ")

    
	
	set mov=conexao.execute("select id,protocolo,nome,id_contrato,id_empresa from TB_MOVIMENTACOES where id="&request("id")&" ")
	if not mov.eof then
		protocolo_mov=mov("protocolo")
		id_mov=mov("id")
        cliente_mov=mov("nome")

        set con=conexao.execute("select ramo, segmento, operadora from CADASTROGERAL_VENDAS where id="&mov("id_contrato")&"")
        if not con.eof then
            ramo=con("ramo")
            segmento=con("segmento")
            operadora=con("operadora")
        end if
        set con=nothing

        set cli=conexao.execute("select titular from CADASTROGERAL where id="&mov("id_empresa")&" ")
            cliente=cli("titular")
        set cli=nothing
	end if
	set mov=nothing
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
	myMail.Subject="MOVIMENTACAO ANULADA"
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="adm2@compactasaude.com;manutencao@compactasaude.com"
	myMail.Cc="supervisao.deman@compactasaude.com"
	'myMail.Bcc="pauloisaquecpd@hotmail.com"
	myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong> MOVIMENTA&Ccedil;&Atilde;O ANULADA</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Uma movimenta&ccedil;&atilde;o foi anulada.<br><br>Anulada pelo usuario <strong>"&userxy&"</strong><br>Beneficiario <strong>"&cliente_mov&"</strong><br>Protocolo <strong>"&protocolo_mov&"</strong><br><br>Empresa/Cliente <strong>"&cliente&"</strong><br>Contrato <strong>"&ramo&"."&segmento&"."&operadora&"</strong><br><br>Favor, verificar as informa&ccedil;&otilde;es da ocorrência no sistema SISCAD<br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
	
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing
	
	FechaConexao
	response.Write("<script>alert('Registro Anulado com sucesso!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacoes';</script>")
end if

if request("gravar")="ok" then
	AbreConexao
	set cli=conexao.execute("select titular from CADASTROGERAL where id="&idx&" ")
	    cliente=cli("titular")
	set cli=nothing
	
	set mov=conexao.execute("select * from TB_MOVIMENTACOES where id="&request("id")&" ")
	if not mov.eof then
		protocolo_mov=mov("protocolo")
		id_mov=mov("id")
	end if
	set mov=nothing
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
	if instr(request("titulo"),"PEDIDO DE ANUL")>0 then
		myMail.Subject="PEDIDO DE ANULAÇAO DE MOVIMENTAÇÃO"
		titul="PEDIDO DE ANULAÇAO DE MOVIMENTA&Ccedil;&Atilde;O"
		tipo="ANULACAO"
	else
		myMail.Subject="OCORRENCIA ABERTA"
		titul="NOVA OCORRENCIA EM MOVIMENTA&Ccedil;&Atilde;O"
		tipo="MOVIMENTACAO"
	end if
	
	myMail.From="COMPACTA SAUDE <"&email_autentica&">"
	myMail.ReplyTo=request.Form("email")
	myMail.To="deman@compactasaude.com"
	'myMail.Bcc="pauloisaquecpd@hotmail.com"
	myMail.HTMLBody="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr><tr><td align=center><font color=#02335C><strong>"&titul&"</strong></font></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2><br>Uma nova ocorr&ecirc;ncia foi aberta.<br><br>Usuario <strong>"&userxy&"</strong><br>Cliente <strong>"&cliente&"</strong> na movimenta&ccedil;&atilde;o de protocolo <strong>"&protocolo_mov&"</strong>.<br><br>Favor, verificar as informa&ccedil;&otilde;es da ocorrência no sistema SISCAD<br><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></td></tr></table></center></body>" 
	
	myMail.Send 
	set myMail=nothing 
	Set cdoConfig = Nothing

AbreConexao
	set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS order by id desc")
	if rs.eof then
		idz=1
	else
		idz=rs("id")+1
	end if
	set rs=nothing
	
	protocolo=year(now)&""&month(now)&""&day(now)&""&hour(now)&""&minute(now)&""&second(now)
	Sql = "INSERT INTO PORTALCLIENTE_OCORRENCIAS (id, id_cliente, usuario, tipo, titulo, descricao, datareg, status, id_contrato, celula, id_movimentacao, protocolo) VALUES ("&idz&", "&idx&", '"&userxy&"', '"&tipo&"', '"&request("titulo")&"', '"&request("descricao")&"', '"&databrx22(date)&" "&time&"', 'ABERTO', "&request("contrato")&", '"&request("celula")&"', "&id_mov&", '"&protocolo&"' )"
	conexao.Execute(Sql)

	response.Write("<script>alert('Ocorencia enviada com sucesso\nEm breve responderemos e voce podera acompanhar aqui no portal!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacoes';</script>")
FechaConexao
end if%>

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Consultar Movimentações</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Consultar Movimentações</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
        <div class="row">
            <div class="col-12" >
            	<form action="painel.asp?go=movimentacoes" method="post">
                <input type="hidden" name="pesq" value="ok" />
            	<div class="form-group row">
                    <div class="col-md-2">
                    	<label for="tipo">Tipo de movimentação</label>
                        <select name="tipo" id="tipo" required class="form-control">
                            <option value="">Selecione...</option>
                            <option value="INCLUSAO" <%if request("tipo")="INCLUSAO" then response.Write("selected") end if%>>Inclusão</option>
                            <option value="EXCLUSAO" <%if request("tipo")="EXCLUSAO" then response.Write("selected") end if%>>Exclusão</option>
                            <option value="DOWNGRADE" <%if request("tipo")="DOWNGRADE" then response.Write("selected") end if%>>Downgrade</option>
                            <option value="UPGRADE" <%if request("tipo")="UPGRADE" then response.Write("selected") end if%>>Upgrade</option>
                            <option value="REEMBOLSO" <%if request("tipo")="REEMBOLSO" then response.Write("selected") end if%>>Reembolso</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                    	<label for="statuss">Status</label>
						<select name="statuss" id="statuss" class="form-control">
                            <option value="">Selecione...</option>
                            <option value="ANULADO" <%if ucase(request("statuss"))="ANULADO" then response.Write("selected") end if%>>ANULADO</option>
                            <option value="ENVIADO" <%if ucase(request("statuss"))="ENVIADO" then response.Write("selected") end if%>>ENVIADO</option>
                            <option value="EXECUCAO" <%if ucase(request("statuss"))="EXECUCAO" then response.Write("selected") end if%>>EM EXECUCAO</option>
                            <option value="COM_PENDENCIA" <%if ucase(request("statuss"))="COM_PENDENCIA" then response.Write("selected") end if%>>COM PENDENCIA</option>
                            <option value="AGUARDANDO VIGENCIA" <%if ucase(request("statuss"))="AGUARDANDO VIGENCIA" then response.Write("selected") end if%>>AGUARDANDO VIGENCIA</option>
                            <option value="AGUARDANDO EXCLUSAO" <%if ucase(request("statuss"))="AGUARDANDO EXCLUSAO" then response.Write("selected") end if%>>AGUARDANDO EXCLUSAO</option>
                            <option value="CONCLUIDA" <%if ucase(request("statuss"))="CONCLUIDA" then response.Write("selected") end if%>>CONCLUIDA</option>
                      	</select>	
                    </div>
                    <div class="col-md-2">
                    	<label for="contrato">Contrato</label>
                        <select name="contrato" id="contrato" class="form-control">
                            <option value="">Selecione...</option>
                            <%set con=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
                            if not con.eof then
                                while not con.eof%>
                                    <option value="<%=con("id")%>" <%if trim(request("contrato"))=trim(con("id")) then response.Write("selected") end if%>><%=con("ramo")%> . <%=con("segmento")%> . <%=con("operadora")%></option>
                                <%con.movenext
                                wend
                            end if
                            set con=nothing%>
                      	</select>   
                    </div>
                    <div class="col-md-2">
                    	<label for="mes">Mês da Solicitação</label>
                        <input type="month" name="mes" id="mes" value="<%=request("mes")%>" class="form-control" />
                    </div>
                    <div class="col-md-2">
                    	<label for="protocolo">Protocolo</label>
                    	<input type="text" name="protocolo" id="protocolo" value="<%=request("protocolo")%>" placeholder="Insira o protocolo" class="form-control"  />
                    </div>
                    <div class="col-md-2">
                    	<label for="beneficiario">Beneficiário</label>
                    	<input type="text" name="beneficiario" id="beneficiario" value="<%=request("beneficiario")%>" placeholder="Insira o nome do beneficiario" class="form-control"  />
                    </div>
                   	
                </div>
                <div class="form-group row">
                	<div class="col-md-12 text-center">
                       	<input type="submit" class="btn btn-success btn-large" value="Pesquisar"/>
                    </div>
                </div>
                </form>
            </div>
        </div>
        <%if request("pesq")="ok" then			
			
				if request("tipo")<>"" then
					tipos=" and tipo='"&request("tipo")&"' "
					frase_tipo=" tipo: "&request("tipo")&" "
				else
					frase_tipo=" todos os tipos"
				end if
				
				if request("protocolo")<>"" then
					protocolos=" and protocolo like '%"&request("protocolo")&"%'"
					frase_protocolo="| protocolo: "&request("protocolo")&" "
				end if
				
				if request("beneficiario")<>"" then
					beneficiarios=" and nome like '%"&request("beneficiario")&"%'"
					frase_beneficiario="| Beneficiário: "&request("beneficiario")&" "
				end if
				
				if request("statuss")<>"" then
					statuss=" and status='"&request("statuss")&"'"
					frase_status="| status: "&request("statuss")&" "
                    if request("statuss")="EXECUCAO" then
                        statuss2=" and status='NA OPERADORA'"
                    else
                        statuss2=" and status='"&request("statuss")&"'"
                    end if
				end if
				
				if request("contrato")<>"" then
					contratos=" and id_contrato='"&request("contrato")&"'"
				end if
				
				if request("mes")<>"" then
					'mess=" and month(convert(DATE, datareg, 103))='"&request("mes")&"'"
					mess=" and month(datareg)='"&month(request("mes"))&"'"
					frase_mes="| mês: "&monthname(month(request("mes")))&" "
					
					anoss=" and year(datareg)='"&year(request("mes"))&"'"
					frase_ano="| Ano: "&year(request("mes"))&" "
				end if
				
				'if request("status")="COM PENDENCIA" then
				'	set cad=conexao.execute("select * from MOVIMENTACAO_PENDENCIA AS P JOIN TB_MOVIMENTACOES AS M ON P.id_movimentacao=M.id where M.status='EXECUCAO' and M.id_empresa="&idx&"")
				'else
					
				if filialx<>"0" and filialx<>"" then
					fil=split(trim(filialx),",")
					for i=0 to ubound(fil)
						
						if centrox<>"0" and centrox<>"" then
							cen=split(trim(centrox),",")
							for x=0 to ubound(cen)
								
								if contrato_permitido<>"0" then
								con=split(trim(contrato_permitido),",")
								for w=0 to ubound(con)
									if sqlx<>"" then
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&" "&contratos&" and filial=0 and centrodecusto=0 and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&" "&contratos&" and filial=0 and centrodecusto=0 and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
									else
										sqlx="where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx="or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
									end if
								next	
								else'sem distinção de contrato
									if sqlx<>"" then
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&" "&contratos&" and filial=0 and centrodecusto=0 and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&" "&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&" "&contratos&" and filial=0 and centrodecusto=0 and solicitacao_principal is null and aguardando<>'s'"
									else
										sqlx="where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx="or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and centrodecusto="&cen(x)&" and solicitacao_principal is null and aguardando<>'s'"
									end if
								end if
								
							next
							
						else'sem o centro de custo
							
							if contrato_permitido<>"0" then
								con=split(trim(contrato_permitido),",")
								for w=0 to ubound(con)
									if sqlx<>"" then
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial=0 and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial=0 and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
									else
										sqlx="where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx="or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and id_contrato="&con(w)&" and solicitacao_principal is null and aguardando<>'s'"
									end if
								next	
							else'sem distinção de contrato
									if sqlx<>"" then
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial=0 and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and solicitacao_principal is null and aguardando<>'s'"
										sqlx=sqlx&" or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial=0 and solicitacao_principal is null and aguardando<>'s'"
									else
										sqlx="where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and solicitacao_principal is null and aguardando<>'s'"

                                        sqlx="or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and filial="&fil(i)&" and solicitacao_principal is null and aguardando<>'s'"
									end if
							end if
							
						
						end if
						
					next
				else
					
					if contrato_permitido<>"0" and contrato_permitido<>"" then
						'response.Write("ok2: "&contrato_permitido&"<br>")
						con=split(trim(contrato_permitido),",")
						for y=0 to ubound(con)
								
								if sqlx<>"" then
									sqlx=sqlx&" OR id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and id_contrato="&con(y)&" and solicitacao_principal is null and aguardando<>'s'"

                                    sqlx=sqlx&" OR id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and id_contrato="&con(y)&" and solicitacao_principal is null and aguardando<>'s'"
								else
									sqlx=" where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and id_contrato="&con(y)&" and solicitacao_principal is null and aguardando<>'s' id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and id_contrato="&con(y)&" and solicitacao_principal is null and aguardando<>'s'"
								end if
						next
					else
						sqlx="where id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss&" "&mess&""&anoss&""&contratos&" and solicitacao_principal is null and aguardando<>'s' or id_empresa="&idx&" "&tipos&" "&protocolos&" "&beneficiarios&" "&statuss2&" "&mess&""&anoss&""&contratos&" and solicitacao_principal is null and aguardando<>'s'"
						'response.Write("ok")
					end if				
					'sqlx="where id_empresa="&idx&" "&sqlx&""
				end if
				
				SQLS="select * from TB_MOVIMENTACOES "&sqlx&" order by id desc "
				'response.Write(SQLS)
			    'response.End()
				set cad=conexao.execute(SQLS)
				'end if
			'SEnao REtirado daqui para carregar resultado somente apos pesquisa
			'else
				'set cad=conexao.execute("select * from TB_MOVIMENTACOES where id_empresa="&idx&"  and solicitacao_principal is null order by id desc")
			'end if%>
        
            
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                <thead>
                                <tr>
                                    <th>Por</th>
                                    <th>Tipo</th>
                                    <th>Contrato</th>
                                    <th>Beneficiário</th>
                                    <th>Visualizar</th>
                                    <th>Anular</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%if not cad.eof then
                                while not cad.eof
                                
                                    set co=conexao.execute("select count(id) as total from MOVIMENTACAO_PENDENCIA where id_movimentacao="&cad("id")&" and finalizou='n' ")
                                    if cad("status")="concluida" then
                                        stat="CONCLUIDA"
                                        label="-success"
                                    elseif cad("status")="ENVIADO" then
                                        stat="ENVIADO"
                                        label="-info"
                                    elseif cad("status")="ANULADO" then
                                        stat="ANULADO"
                                        label="-danger"
                                    elseif cad("status")="COM_PENDENCIA" then
                                        stat="COM PENDENCIA"
                                        label="-warning"
                                    elseif cad("status")="AGUARDANDO VIGENCIA" then
                                        stat="AGUARDANDO VIGENCIA"
                                        label="-warning"
                                    elseif cad("status")="AGUARDANDO EXCLUSAO" then
                                        stat="AGUARDANDO EXCLUSAO"
                                        label="-secondary"
                                    elseif cad("status")="EXECUCAO" then
                                        if co("total")>0 then
                                            stat="COM PENDENCIA"
                                            label="-warning"
                                        else
                                            stat="EM EXECUCAO"
                                            label="-primary"
                                        end if
                                    elseif cad("status")="NA OPERADORA" then
                                        stat="EM EXECUCAO"
                                        label="-primary"
                                    end if%>
                                <tr>
                                    
                                    <td>
                                        <i class="fas fa-user" title="<%=databrx3(cad("datareg"))%> às <%=hour(cad("horareg"))%>:<%=minute(cad("horareg"))%> por <%=cad("solpor")%>"></i>
                                    </td>
                                    <td><%=cad("tipo")%></td>
                                    <td>
                                        <%set em=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&cad("id_contrato")&"")%><%if not em.eof then%><%=em("ramo")%><br /><%=em("operadora")%><%end if%><%set em=nothing%>
                                    </td>
                                    
                                    <td>
                                    <%if cad("id_titular")<>"" and cad("id_titular")<>"0" then
                                        titularx="DEPENDENTE"
                                        titx="D"%>
                                        <span class="badge badge-soft-primary font-size-12" title="Dependente">D</span>
                                      <%else
                                        titularx="TITULAR"
                                        titx="T"%>
                                            <span class="badge badge-soft-primary font-size-12" title="Titular">T</span>
                                      <%end if%>
                                      
                                    <%=ucase(cad("nome"))%>
                                    &nbsp;
                                    <%if ucase(trim(stat))<>"CONCLUIDA" and ucase(trim(stat))<>"ANULADO" then
                                        if request("tipo")="INCLUSAO" then%>
                                            <i class="fas fa-paperclip" style="cursor:pointer;" onclick="window.open('painel.asp?go=inclusao_finaliza&id=<%=cad("id")%>');"></i>
                                        <%elseif request("tipo")="EXCLUSAO" then%>
                                            <i class="fas fa-paperclip" style="cursor:pointer;" onclick="window.open('painel.asp?go=exclusao_finaliza&id=<%=cad("id")%>');"></i>
                                        <%end if%>
                                    <%end if%>
                                    <br />
                                    <small>Protocolo: <%=cad("protocolo")%></small>
                                    
                                    </td>
                                    
                                    <td>
                                    <!-- ////////////////////////////////////////// -->
                                        <button type="button" class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target=".bs-example-modal-lg<%=cad("id")%>"> <i class="fas fa-search"></i></button>
                                       
                                        <!-- sample modal content -->
                                        <div class="modal fade bs-example-modal-lg<%=cad("id")%>" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                              <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title mt-0" id="myModalLabel">
                                                        <%if cad("id_titular")<>"" and cad("id_titular")<>"0" then
                                                            titular="DEPENDENTE"
                                                          else
                                                            titular="TITULAR"
                                                          end if%>
                                                          <strong><%=cad("tipo")%> DE <%=titular%></strong>
                                                        </h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <%if cad("status")="concluida" then%>
                                                        <div class="alert alert-success text-center" role="alert">
                                                            <h5 class="font-size-16">
                                                            CONCLUIDA
                                                            <%SET hi=conexao.execute("select * from TB_INCLU_EXCLU_HISTORICO where idtipo='"&cad("id")&"' and tipo='MOVIMENTACAO' and acao='CONCLUIDO' order by id desc")
                                                            if not hi.eof then%>
                                                                &nbsp;por <%=hi("nome")%> em <%=databrx3(hi("data"))%> às <%=hi("hora")%>
                                                            <%end if
                                                            set hi=nothing%>
                                                            </strong><BR />
                                                            Nº da carteira do beneficiário: <strong><U><%=cad("matricula")%></U></strong><br />Vigência do beneficiário: <%=day(cad("vigencia"))%>/<%=month(cad("vigencia"))%>/<%=year(cad("vigencia"))%>
                                                            
                                                            </h5>
                                                        </div>
                                                        <%elseif cad("status")="ANULADO" then%>
      
                                                        <div class="alert alert-danger text-center" role="alert">
                                                        <h5 class="font-size-16">ANULADO</h5>
                                                        <strong><%=statuss%></strong><BR />
                                                            Anulado em <%=day(cad("removido_em"))%>/<%=month(cad("removido_em"))%>/<%=year(cad("removido_em"))%> às <%=hour(cad("removido_em"))%>:<%=minute(cad("removido_em"))%> por <%=cad("removido_por")%>
                                                        
                                                        </div>
                                                        <%end if%>
                                                        
                                                        
                                                        <p><i class="fas fa-calendar-alt"></i>&nbsp;Solicitada por <%=cad("solpor")%> em <%=databrx3(cad("datareg"))%> às <%=hour(cad("horareg"))%>:<%=minute(cad("horareg"))%></p>
                                                        <p>
                                                        Protocolo: <strong><%=cad("protocolo")%></strong><br />
                                                        Beneficiário: <strong><%=ucase(cad("nome"))%></strong><br />
                                                        <%if titular="DEPENDENTE" then%>
                                                          Dependente de: <strong>
                                                            <%set cad2=conexao.execute("select * from CADASTROGERAL where id="&cad("id_titular")&"")
                                                            if not cad2.eof then%>
                                                            <%=cad2("titular")%>
                                                            <%end if
                                                            set cad2=nothing%>
                                                            </strong>
                                                          <br />
                                                         
                                                        <%end if%>
                                                        CPF: <strong><%=cad("cpf")%></strong><br />
                                                        Contrato: <strong><%set em=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&cad("id_contrato")&"")%><%if not em.eof then%><%=em("ramo")%> . <%=em("operadora")%><%end if%><%set em=nothing%></strong><br />
                                                        <%if isnumeric(cad("plano")) then%>
                                                            Plano: <strong><%set em=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&cad("plano")&"")%><%if not em.eof then%><%=em("nome")%><%end if%><%set em=nothing%></strong>
                                                        <%else%>
                                                            Plano: <strong><%=cad("plano")%></strong>
                                                        <%end if%>
                                                        <br />
                                                        Acomodação: <strong><%=cad("acomodacao")%></strong><br />
                                                        <%if titular="TITULAR" then%>
                                                          Data de admissão: <strong><%=databrx3(cad("dadmissao"))%></strong><br />
                                                        <%end if
                                                        if cad("status")="concluida" then%>
                                                            Carência: <strong><%=cad("reducaocarencia")%></strong><br />
                                                        <%end if%>
                                                        <%if ucase(cad("tipo"))="EXCLUSAO" then%>
                                                       		Exclusao solicitada para: 
                                                        <%else%>
                                                        	Inclusao solicitada para:
                                                        <%end if%>
                                                        <strong><%=databrx3(cad("dinicio"))%></strong> <br />
                                                            <small style="font-size:10px; color:#F00;">*A data pode ser alterada caso aconteça pendencias na movimentação ou outros impedimentos</small>
                                                        <br />
                                                        <%if cad("status")="concluida" or ucase(cad("status"))="AGUARDANDO VIGENCIA" then%>
                                                          Data de vigência aplicada: <strong><%=day(cad("vigencia"))%>/<%=month(cad("vigencia"))%>/<%=year(cad("vigencia"))%></strong><br />
                                                        <%end if%>
                                                        
                                                        <%set dep=conexao.execute("select * from TB_MOVIMENTACOES where solicitacao_principal="&cad("id")&"")
                                                          if not dep.eof then%>
                                                          <div class="alert alert-secondary" role="alert">
                                                          <h5 class="font-size-16"><i class="fas fa-user-friends"></i>&nbsp;DEPENDENTES</h5>
                                                          <p>
                                                            <%while not dep.eof%>
                                                            <li><%=dep("nome")%> <%if dep("matricula")<>"" then%>| Nº da carteira: <strong><%=dep("matricula")%></strong><%end if%></li>
                                                            <%dep.movenext
                                                          wend%>
                                                            </p>
                                                          </div>
                                                        <%end if
                                                        set dep=nothing%>
                                                        
                                                        <%if cad("infoaocliente")<>"" then%>
                                                          <p>Observações: <strong><%=cad("infoaocliente")%></strong></p>
                                                        <%end if%>
                                                        
                                                        <!-- //////////////// ANEXOS ///////////////-->
                                                        <div class="alert alert-primary" role="alert">     
                                                            <h5 class="font-size-16"><i class="fas fa-paperclip"></i>&nbsp;ANEXOS</h5>
                                                            <p><!--#include file="lista_arquivos.asp"--></p>
                                                            <p class="text-center">
                                                            <%if ucase(trim(cad("status")))<>"CONCLUIDA" and ucase(trim(cad("status")))<>"ANULADO" then%>
                                                                <%if cad("tipo")="INCLUSAO" then%>
                                                                    <i class="fas fa-upload" style="cursor:pointer;" onclick="window.open('painel.asp?go=inclusao_finaliza&id=<%=cad("id")%>','Anexar Documentos','width=950,height=650');"></i>
                                                                <%elseif cad("tipo")="EXCLUSAO" then%>
                                                                    <i class="fas fa-upload" style="cursor:pointer;" onclick="window.open('painel.asp?go=exclusao_finaliza&id=<%=cad("id")%>','Anexar Documentos','width=950,height=650');"></i>
                                                                <%end if%> Inserir anexos
                                                                
                                                            <%end if%>
                                                            </p>
                                                        </div>
                                                        <!-- //////////////// FIM ANEXOS ///////////////-->
                                                          
                                                        <!-- //////////////// PENDENCIAS ///////////////-->
                                                        <%set co=conexao.execute("select * from MOVIMENTACAO_PENDENCIA where id_movimentacao="&cad("id")&" ")
                                                        if not co.eof then%> 
                                                            <div class="alert alert-warning" role="alert">     
                                                            <h5 class="font-size-16"><i class="fas fas fa-exclamation"></i>&nbsp;PENDÊNCIAS</h5>
                                                            <%z=1
                                                            while not co.eof%>
                                                            
                                                                <p>
                                                                    <i class="fas fa-arrow-right"></i>&nbsp;<strong>#<%=co("protocolo")%><small> em <%=databrx3(co("datareg"))%> às <%=hour(co("datareg"))%>:<%=minute(co("datareg"))%> por <%=co("por")%></small> </strong>
                                                                    <br />
                                                                    
                                                                    <%set it=conexao.execute("select * from MOVIMENTACAO_PENDENCIA_ITENS where id_pendencia="&co("id")&"")
                                                                    'if not it.eof then
                                                                    while not it.eof%>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;<strong>Pendência:</strong> <%=it("pendencia")%><br />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;<strong>Resolução:</strong> <%=it("resolucao")%><br />
                                                                    <%it.movenext
                                                                    wend
                                                                    'end if
                                                                    set it=nothing%>  
                                                                    
                                                                    <%set pe=conexao.execute("select * from MOVIMENTACAO_pendencia_hist where id_pendencia="&co("id")&" ")
                                                                    if not pe.eof then%>
                                                                        &nbsp;&nbsp;&nbsp;&nbsp;<strong>Observações na Conclusão da pendência:</strong> <%=pe("historico")%>
                                                                    <%end if
                                                                    set pe=nothing%> 
                                                                    
                                                                </p>
                                                               
                                                            <%z=z+1
                                                            co.movenext
                                                            wend%>    
                                                            </div>
                                                        <%end if
                                                        set co=nothing%>  
                                                        <!-- //////////////// FIM PENDENCIAS ///////////////-->
                                                        
                                                        <!-- //////////////// OCORRENCIAS ///////////////-->
                                                        <div class="alert alert-danger" role="alert">     
                                                            <h5 class="font-size-16"><i class="fas fa-exclamation-circle"></i>&nbsp;OCORRÊNCIAS</h5>									
															<%set oc=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id_movimentacao="&cad("id")&" ")
                                                        	if not oc.eof then%>
                                                        	
                                                                <%while not oc.eof%>
                                                                <p>
                                                                    <i class="fas fa-arrow-right"></i>&nbsp;<small><strong>#<%=oc("protocolo")%></strong> aberta em <%=day(oc("datareg"))%>/<%=month(oc("datareg"))%>/<%=year(oc("datareg"))%> às <%=hour(oc("datareg"))%>:<%=minute(oc("datareg"))%></small><BR />
                                                                    &nbsp;&nbsp;&nbsp;<%=oc("descricao")%> 
                                                                </p>
                                                                <%oc.movenext
                                                                wend%>
                                                        	<%end if%>
                                                        	<br /><br />
                                                        
                                                        
                                                        <%if ucase(trim(statuss))<>"CONCLUIDA" and ucase(trim(statuss))<>"ANULADO" then%>
                                                        <form action="painel.asp?go=movimentacoes&gravar=ok" method="post" >
                                                        <input type="hidden" name="id" value="<%=cad("id")%>" />
                                                        <input type="hidden" name="contrato" id="contrato" value="<%=cad("id_contrato")%>" />
                                                        <div class="form-group row">
                                                            <div class="col-md-4">C&eacute;lula Respons&aacute;vel</div>
                                                            <div class="col-md-8">
                                                             <select name="celula" id="celula" class="form-control" required>
                                                                <option value="">Selecione...</option>
                                                                <option value="CADASTRO">CADASTRO</option>
                                                                <option value="FINANCEIRO">FINANCEIRO</option>
                                                                <option value="MANUTENCAO">MANUTENCAO</option>
                                                                <option value="RELACIONAMENTO">RELACIONAMENTO</option>
                                                              </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-4">T&iacute;tulo</div>
                                                            <div class="col-md-8">
                                                              <input name="titulo" type="text" required="required" class="form-control" id="titulo" value="" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-4">Descri&ccedil;&atilde;o</div>
                                                            <div class="col-md-8">
                                                             <textarea name="descricao" rows="5" class="form-control" id="descricao" placeholder="Descreva aqui informações que você julgue importantes para essa ocorrência." required></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row text-center">
                                                            <div class="col-md-12"> <input type="submit" class="btn btn-danger btn-large" value="Gravar Ocorrência" /> </div>
                                                        </div>
                                                        
                                                        </form>
                                                        <%end if%>
                                                        </div>
                                                        <!-- //////////////// FIM OCORRENCIAS ///////////////-->
                                                        
                                                        
                                                        <%if ucase(trim(cad("status")))="EXECUCAO" OR ucase(trim(cad("status")))="AGUARDANDO VIGENCIA" OR ucase(trim(cad("status")))="AGUARDANDO EXCLUSAO" then%>
                                                        <!-- //////////////// ANULAR ///////////////-->
                                                        <div class="alert alert-secondary" role="alert">     
                                                            <h5 class="font-size-16">
                                                            <i class="fas fa-trash"></i>&nbsp;ANULAR MOVIMENTA&Ccedil;&Atilde;O<br />
                                                            <small>Movimentações em execução ou aguardando vigência</small>
                                                            </h5>									
															<%set oc=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id_movimentacao="&cad("id")&" ")
                                                        	if not oc.eof then%>
                                                        	
                                                                <%while not oc.eof%>
                                                                <p>
                                                                    <i class="fas fa-arrow-right"></i>&nbsp;<small><strong>#<%=oc("protocolo")%></strong> aberta em <%=day(oc("datareg"))%>/<%=month(oc("datareg"))%>/<%=year(oc("datareg"))%> às <%=hour(oc("datareg"))%>:<%=minute(oc("datareg"))%></small><BR />
                                                                    &nbsp;&nbsp;&nbsp;<%=oc("descricao")%> 
                                                                </p>
                                                                <%oc.movenext
                                                                wend%>
                                                        	<%end if%>
                                                        	<br />
                                                        
                                                        
                                                        
                                                        <form action="painel.asp?go=movimentacoes&gravar=ok" method="post" >
                                                        <input type="hidden" name="id" value="<%=cad("id")%>" />
                                                        <input type="hidden" name="contrato" id="contrato" value="<%=cad("id_contrato")%>" />
                                                        <input name="titulo" type="hidden" value="PEDIDO DE ANULAÇÃO - <%=cad("tipo")%> de <%=cad("nome")%>" />
                                                        
                                                        <input name="celula" type="hidden" value="MANUTENCAO" />
                                                        <div class="form-group row">
                                                            <div class="col-md-12 text-danger">
                                                            A solicitação de anulação do protocolo passará por análise da operadora/seguradora que pode dar um parecer favorável ou não.<br />
                                                             O pedido de anulação depende do estágio em que a movimentação se encontra na operadora/seguradora.<br />
                                                             Em alguns casos, a movimentação pode estar concluída. <br />Nesses casos, será necessário entrar com o pedido de exclusão do beneficiário.<br />
                                                              Acompanhe o processo através do menu ocorrências no Portal do Cliente.<br />
                                                             </div>
                                                            
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-12">
                                                             <textarea name="descricao" rows="3" class="form-control" id="descricao" placeholder="Descreva aqui informações que justifique o pedido de anulação." required></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row text-center">
                                                            <div class="col-md-12"> <input type="submit" class="btn btn-dark btn-large" value="Gravar Pedido de anulação" /> </div>
                                                        </div>
                                                        
                                                        </form>
                                                        
                                                        </div>
                                                        <!-- //////////////// FIM ANULAR ///////////////-->
                                                        <%end if%>
                                                            
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-light waves-effect" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div><!-- /.modal -->
                                    <!-- ///////////////////////////////////////// -->
                                    
                                    
                                    
                                    </td>
                                    <script type="text/javascript"> 
                                    function confirmation<%=cad("id")%>() {
                                        var answer = confirm("Deseja realmente [ANULAR] este registro?")
                                        if (answer){
                                            //alert("Registro Removido com sucesso!")
                                            window.location = 'painel.asp?go=movimentacoes&id=<%=cad("id")%>&acao=delete';
                                        }
                                    }
                                    </script>
                                    <td>
										<%if cad("status")="ENVIADO" or cad("status")="COM_PENDENCIA" then%>
                                            <i class="fas fa-trash-alt" title="Anular Solicitação de Movimentação" style="cursor:pointer;" onclick="confirmation<%=cad("id")%>();"></i>
                                        <%end if%>
                                    </td>
                                    <td>
                                        <span class="badge badge-soft<%=label%> font-size-12"><%=ucase(stat)%></span>
                                        <%if cad("status")="concluida" or cad("status")="AGUARDANDO VIGENCIA" then%>
                                            <small>
                                            <br />Matrícula: <%=cad("matricula")%><br />Vigência: <strong><%=day(cad("vigencia"))%>/<%=month(cad("vigencia"))%>/<%=year(cad("vigencia"))%></strong>
                                            </small>
										<%end if%>
                                    </td>
                                    
                                </tr>
                                <%cad.movenext
                                wend
                                else%>
                                <tr>
                                    <td colspan="7" class="text-center">Nenhuma movimentação encontrada!</td>
                                </tr>
                                <%end if
								set cad=nothing%>
                                
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> <!-- end col -->
            </div> <!-- end row -->
            <%end if
		
		
		'end if
		%>

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
<script>
$('#datatable').dataTable( {
    "order": []
} );
</script>
                
       

