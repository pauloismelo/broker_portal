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
                    <h4 class="mb-0">Kit Faturamento</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Início</a></li>
                            <li class="breadcrumb-item active">Kit Faturamento</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <form action="painel.asp?go=kit_faturamento" method="post">
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
                <div class="row">
                	<div class="col-xl-12">
                    
                    <%set op=conexao.execute("select * from OPERADORAS where nome='"&rs("operadora")&"'")
					 if not op.eof then
						idoperadora=op("id")
					 end if
					 set op=nothing
					 
					 
					 if request("mes")<>"" then%>
						 <table width="100%" id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                <th class="text-center">Tipo do<br />Documento</th>
                                <th class="text-center">Tipo de<br />Arquivo</th>
                                <th>Nome do Arquivo</th>
                                <th class="text-center">Mês de<br /> referencia</th>
                            </tr>
                            </thead>
                            <tbody>
						 	<%set rss=conexao.execute("select * from CADASTROGERAL_LANCPGTO where foto<>'nenhum' and idcadastro="&idx&" and idcadvenda="&rs("id")&" and month(dvencimento)='"&month(request("mes"))&"' and year(dvencimento)='"&year(request("mes"))&"' and tipo_boleto='padrao' order by dvencimento desc")
						 	if not rss.eof then
							while not rss.eof%>
                         		<tr>
                                	<td>Boleto e Fatura</td>
                                    <td align="center">
                                    <%extensao=split(rss("foto"),".")
									'response.Write(extensao(1))
									if lcase(extensao(1))="pdf"  then%>
										<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
										<i class="fas fa-file-pdf fa-2x"></i><br />PDF
										</a>
									<%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
										<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" download="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>">
										<i class="fas fa-file-word fa-2x"></i><br />Word
										</a>
									<%elseif lcase(extensao(1))="txt" then%>
                                           <a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" download="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file fa-2x"></i><br />Txt
                                            </a>
									<%else%>
										<a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
										<i class="fas fa-file-image fa-2x"></i>
										</a>
									<%end if%>
                                    </td>
                                    <td><%=rss("foto")%></td>
                                    <td class="text-center"><%=month(rss("dvencimento"))%> / <%=year(rss("dvencimento"))%></td>
                                </tr>
						 	<%rss.movenext
						 	wend
							else%>
								<tr>
                                	<td>Boleto e Fatura</td>
                                    <td colspan="3" style="color:#F00; font-weight:bold;">Arquivo ainda não foi anexado</td>
                                </tr>
							<%end if
							set rss=nothing
							
							set rss=conexao.execute("select * from STB_ARTIGOS where categoria='PORTALCLIENTE_FATURA' and operadora='"&idoperadora&"'  and cliente="&idx&" and contrato="&rs("id")&" and month(vigencia)='"&month(request("mes"))&"' and year(vigencia)='"&year(request("mes"))&"' order by id desc")
                                if not rss.eof then
                                while not rss.eof%>
                                    <tr>
                                        <td>Fatura em Excel/TXT</td>
                                        <td align="center">
                                        <%if trim(rss("foto"))<>"nenhum" then%>
											<%extensao=split(rss("foto"),".")
                                            'response.Write(extensao(1))
                                            if lcase(extensao(1))="pdf"  then%>
                                                <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-pdf fa-2x"></i><br />PDF
                                                </a>
                                            <%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
                                                <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-word fa-2x"></i><br />Word
                                                </a>
                                            <%elseif lcase(extensao(1))="xls" or lcase(extensao(1))="xlsx"  then%>
                                               <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-excel fa-2x"></i><br />Planilha
                                                </a>
                                            <%elseif lcase(extensao(1))="csv" then%>
                                               <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-excel fa-2x"></i><br />CSV
                                                </a>
                                            <%elseif lcase(extensao(1))="txt" then%>
                                               <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file fa-2x"></i><br />Txt
                                                </a>
                                            <%else%>
                                               <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-image fa-2x"></i>
                                                </a>
                                            <%end if
										end if%>
                                        </td>
                                        <td><%=rss("foto")%></td>
                                        <td class="text-center">&nbsp;</td>
                                    </tr>
                                <%rss.movenext
                                wend
								else%>
                                	<tr>
                                        <td>Fatura em Excel/TXT</td>
                                        <td colspan="3" style="color:#F00; font-weight:bold;">Arquivo ainda não foi anexado</td>
                                    </tr>
                                <%end if
                            set rss=nothing
							
							'////////////////verifica se existe boleto copart separado////////////////
							if trim(rs("envio_boleto_copart"))="on" then
								set rss=conexao.execute("select * from CADASTROGERAL_LANCPGTO where foto<>'nenhum' and idcadastro="&idx&" and idcadvenda="&rs("id")&" and month(dvencimento)='"&month(request("mes"))&"' and year(dvencimento)='"&year(request("mes"))&"' and tipo_boleto='copart' order by dvencimento desc")
                                if not rss.eof then
                                while not rss.eof%>
                                    <tr>
                                        <td>Boleto Copart</td>
                                        <td align="center">
                                        <%extensao=split(rss("foto"),".")
                                        'response.Write(extensao(1))
                                        if lcase(extensao(1))="pdf"  then%>
                                            <a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-pdf fa-2x"></i>
                                            </a>
                                        <%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
                                            <a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" download="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>">
                                            <i class="fas fa-file-word fa-2x"></i>
                                            </a>
                                        <%else%>
                                            <a href="https://www.compactabh.com.br/siscad/boleto_cliente/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-image fa-2x"></i>
                                            </a>
                                        <%end if%>
                                        </td>
                                        <td><%=rss("foto")%></td>
                                        <td class="text-center"><%=month(rss("dvencimento"))%> / <%=year(rss("dvencimento"))%></td>
                                    </tr>
                             
                                <%rss.movenext
                                wend
								else%>
                                	<tr>
                                        
                                        <td>Boleto Copart</td>
                                        <td colspan="3" style="color:#F00; font-weight:bold;">Arquivo ainda não foi anexado</td>
                                    </tr>
                                <%end if
                                set rss=nothing
                            
							
							
							'////////////////ERLATORIO DE COPART////////////////
							set rss=conexao.execute("select * from STB_ARTIGOS where categoria='PORTALCLIENTE_COPART' and operadora='"&idoperadora&"' and cliente="&idx&" and contrato="&rs("id")&" and month(vigencia)='"&month(request("mes"))&"' and year(vigencia)='"&year(request("mes"))&"' order by id desc ")
                                if not rss.eof then
                                while not rss.eof%>
                                    <tr>
                                        <td>Relatorio Copart</td>
                                        <td align="center">
                                        <%if trim(rss("foto"))<>"nenhum" then%>
											<%extensao=split(rss("foto"),".")
                                            'response.Write(extensao(1))
                                            if lcase(extensao(1))="pdf"  then%>
                                                <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-pdf fa-2x"></i><br />PDF
                                                </a>
                                            <%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
                                                <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-word fa-2x"></i><br />Word
                                                </a>
                                            <%elseif lcase(extensao(1))="xls" or lcase(extensao(1))="xlsx" then%>
                                               <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-excel fa-2x"></i><br />Planilha
                                                </a>
                                            <%elseif lcase(extensao(1))="csv" then%>
                                               <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-excel fa-2x"></i><br />CSV
                                                </a>
                                            <%elseif lcase(extensao(1))="txt" then%>
                                               <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file fa-2x"></i><br />Txt
                                                </a>
                                            <%else%>
                                               <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                                <i class="fas fa-file-image fa-2x"></i>
                                                </a>
                                            <%end if
										end if%>
                                        </td>
                                        <td><%=rss("foto")%></td>
                                        <td class="text-center">&nbsp;</td>
                                    </tr>
                                <%rss.movenext
                                wend
								else%>
                                	<tr>
                                        <td>Relatorio Copart</td>
                                        <td colspan="3" style="color:#F00; font-weight:bold;">Arquivo ainda não foi anexado</td>
                                    </tr>
                                <%end if
                                set rss=nothing
							end if	
								
								'////////////////NF////////////////
							set rss=conexao.execute("select * from STB_ARTIGOS where categoria='PORTALCLIENTE_NF' and operadora='"&idoperadora&"' and cliente="&idx&" and contrato="&rs("id")&" and month(vigencia)='"&month(request("mes"))&"' and year(vigencia)='"&year(request("mes"))&"' order by id desc ")
                                if not rss.eof then
                                while not rss.eof%>
                                    <tr>
                                        <td>Nota Fiscal</td>
                                        <td align="center">
                                        <%extensao=split(rss("foto"),".")
                                        'response.Write(extensao(1))
                                        if lcase(extensao(1))="pdf"  then%>
                                            <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-pdf fa-2x"></i><br />PDF
                                            </a>
                                        <%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
                                            <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-word fa-2x"></i><br />Word
                                            </a>
                                        <%elseif lcase(extensao(1))="xls" or lcase(extensao(1))="xlsx" then%>
                                           <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-excel fa-2x"></i><br />Planilha
                                            </a>
                                        <%elseif lcase(extensao(1))="txt" then%>
                                           <a href="https://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file fa-2x"></i><br />Txt
                                            </a>
                                        <%else%>
                                           <a href="http://www.compactasaude.com.br/artigos/<%=rss("foto")%>" target="_blank">
                                            <i class="fas fa-file-image fa-2x"></i>
                                            </a>
                                        <%end if%>
                                        </td>
                                        <td><%=rss("foto")%></td>
                                        <td class="text-center">&nbsp;</td>
                                    </tr>
                                <%rss.movenext
                                wend
								else%>
                                	<tr>
                                        <td>Nota Fiscal</td>
                                        <td colspan="3" style="color:#F00; font-weight:bold;">Arquivo ainda não foi anexado</td>
                                    </tr>
                                <%end if
                                set rss=nothing%>
								
								
								
								
								
								
								
								
                         	</tbody>
                            <tfoot>
                            	<tr>
                                	<td colspan="4" style="color:#F00; font-weight:bold;">Atenção! Os arquivos de faturamento são anexados nesse portal de acordo com a data de emissão na operadora.<br /> Se o tipo de arquivo que você precisa ainda nao está disponível, retorne ao portal para acompanhar a disponibilização. </td>
                                </tr>
                            </tfoot>
                         </table>
                     	 
					<%else ' se nao tiver pesquisado o mes%>
					 	 <div class="alert alert-danger col-xl-12 text-center" role="alert">
							Insira um mês e ano válido para pesquisa
						</div>
					<%end if%>
                     </div>
                    
                </div>
            <!-- end row -->
            <hr />
            <%rs.movenext
            wend
		end if
		end if%>

        
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                