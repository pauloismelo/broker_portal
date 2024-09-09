<script>
	var sBrowser, sUsrAg = navigator.userAgent;

	if(sUsrAg.indexOf("Chrome") > -1) {
		sBrowser = "Google Chrome";
	} else if (sUsrAg.indexOf("Safari") > -1) {
		sBrowser = "Apple Safari";
	} else if (sUsrAg.indexOf("Opera") > -1) {
		sBrowser = "Opera";
	} else if (sUsrAg.indexOf("Firefox") > -1) {
		sBrowser = "Mozilla Firefox";
	} else if (sUsrAg.indexOf("MSIE") > -1) {
		sBrowser = "Microsoft Internet Explorer";
	}
	
	if (sBrowser == "Mozilla Firefox"){
		//alert("Você está utilizando: " + sBrowser);
	}
	
	
	
</script>

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Boletos e Faturamentos</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Início</a></li>
                            <li class="breadcrumb-item active">Boletos</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <form action="painel.asp?go=docboleto" method="post">
        <input type="hidden" name="pesq" value="ok" />
        <div class="row">
        	<div class="col-md-12 col-xl-12">
             	Selecione no campo/calendário abaixo o <strong>mês e ano</strong> de vencimento desejado para consultar o seu boleto:<br />
            </div>
        </div>
        <div class="row">
        	<div class="col-md-12 col-xl-12 mb-2">
             	<input type="month" class="form-control col-md-4" name="mes" value="<%=request("mes")%>" />
                <small style="color:#F00;">*Caso nao visualize o calendário no campo acima, digite a data no formato a seguir: <strong> mm/aaaa | Exemplo: 02/2001</strong>.<br /> Preferenciamente utilize os navegadores Edge, Internet Explorer ou Chrome.
                 </small>
            </div>
        </div>
        <div class="row mb-4">
        	<div class="col-md-12 col-xl-12">
             	<input type="submit" class="btn btn-success" value="Consultar" />
            </div>
        </div>
        </form>
        <%if request("pesq")="ok" then
		'response.Write(request("mes"))
		if request("id")<>"" then
			sqlz="select * from CADASTROGERAL_VENDAS where id="&request("id")&" and status='ATIVO' and esconde_contrato='n' "
		else
			if contrato_permitido<>"" then
				if contrato_permitido="0" or contrato_permitido="" then 'Tem acesso GERAL (todos os contratos)
					sqlz="select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n' "
				
				elseif contrato_permitido<>"" and contrato_permitido<>"0" then 'Tem acesso a contratos distintos
					box=split(trim(contrato_permitido),",")
					
					for i=0 to ubound(box)
						if sql2<>"" then
							sql2=sql2&" or id="&box(i)&" and status='ATIVO' and esconde_contrato='n'"
						else
							sql2= "where id="&box(i)&" and status='ATIVO' and esconde_contrato='n'"
						end if
					next
					
					sqlz="select * from CADASTROGERAL_VENDAS "&sql2&" "
				
				end if
			else
				response.Write("<script>alert('Impossivel Prosseguir!\nProcure o depto de Manutenção da Compacta Saúde e solicite a autorização para visualizar os documentos.');</script>")
			end if
		end if
		
		set rs=conexao.execute(sqlz)
		if not rs.eof then
			while not rs.eof%>

                <div class="row" >
                	<div class="col-xl-12">
                    	<h5><i class="fas fa-arrow-alt-circle-right"></i>&nbsp;<%=rs("ramo")%> . <%=rs("operadora")%><%if rs("nome_amigavel")<>"" then%> . <%=rs("nome_amigavel")%><%end if%></h5>
                    </div>
                </div>
                <div class="row" style="margin-bottom:5%;">
                    
                    <%set op=conexao.execute("select * from OPERADORAS where nome='"&rs("operadora")&"'")
					 if not op.eof then
						idoperadora=op("id")
					 end if
					 set op=nothing
					 
					 
					 if request("mes")<>"" then
						 set rss=conexao.execute("select * from CADASTROGERAL_LANCPGTO where foto<>'nenhum' and idcadastro="&idx&" and idcadvenda="&rs("id")&" and month(dvencimento)='"&month(request("mes"))&"' and year(dvencimento)='"&year(request("mes"))&"' and tipo_boleto='padrao' order by dvencimento desc")
						 'set rss=conexao.execute("select * from STB_ARTIGOS where categoria='PORTALCLIENTE_ADITIVOS' and operadora='"&idoperadora&"' order by id desc")
						 if rss.eof then%>
						 <div class="alert alert-danger col-xl-12 text-center" role="alert">
							Nenhum documento encontrado para esse contrato
						</div>
						 <%else
						 while not rss.eof%>
							
							<div class="col-md-6 col-xl-3">
								<!-- Simple card -->
								<div class="card text-center">
									<%if rss("foto")="nenhum" then%>
										Arquivo Indisponivel
									<%else%>
										<%extensao=split(rss("foto"),".")
										'response.Write(extensao(1))
										if lcase(extensao(1))="pdf"  then%>
											<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
											<i class="fas fa-file-pdf fa-3x"></i>
											</a>
										<%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
											<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" download="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>">
											<i class="fas fa-file-word fa-3x"></i>
											</a>
										<%else%>
											<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
											<i class="fas fa-file-image fa-3x"></i>
											</a>
										<%end if%>
									<%end if%>
									
									
									<div class="card-body">
										<h4 class="card-title mt-0"><%=month(rss("dvencimento"))%> / <%=year(rss("dvencimento"))%></h4>
									</div>
								</div>
							</div><!-- end col -->
						 
						 <%rss.movenext
						 wend
						 end if
					 
					 else%>
					 	 <div class="alert alert-danger col-xl-12 text-center" role="alert">
							Insira um mês e ano válido para pesquisa
						</div>
					 <%end if%>
                    
                    
                </div>
            <!-- end row -->
            <%rs.movenext
            wend
		end if
		end if%>

        
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                