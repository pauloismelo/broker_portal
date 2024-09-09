

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Notas Fiscais</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Início</a></li>
                            <li class="breadcrumb-item active">Notas Fiscais</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <%
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
					 
					  set rss=conexao.execute("select * from STB_ARTIGOS where categoria='PORTALCLIENTE_NF' and operadora='"&idoperadora&"' and cliente="&idx&" and contrato="&rs("id")&" order by id desc")
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
									sem foto
								<%else%>
									<%extensao=split(rss("foto"),".")
									'response.Write(extensao(1))
									if lcase(extensao(1))="pdf"  then%>
										<a href="http://www.<%=rss("site")%>/artigos/<%=rss("foto")%>" target="_blank" class="tre18-0099ff">
										<i class="fas fa-file-pdf fa-3x"></i>
										</a>
									<%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
					  					<a href="http://www.<%=rss("site")%>/artigos/<%=rss("foto")%>" target="_blank" class="tre18-0099ff">
										<i class="fas fa-file-word fa-3x"></i>
										</a>
									<%else%>
										<a href="<%if rss("url")="http://" then%>/conteudo.asp?go=noticias&id=<%=rss("id")%>&cat=CANALCORRETOR<%else%><%=rss("url")%><%end if%>" target="_blank" class="tre18-0099ff">
										<i class="fas fa-file-image fa-3x"></i>
										</a>
									<%end if%>
								<%end if%>
                                
                                
                                <div class="card-body">
                                    <h4 class="card-title mt-0"><%=ucase(rss("titulo"))%></h4>
                                </div>
                            </div>
                        </div><!-- end col -->
                     
                     <%rss.movenext
					 wend
					 end if%>
                    
                    
                </div>
            <!-- end row -->
            <%rs.movenext
            wend
		end if%>

        
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                