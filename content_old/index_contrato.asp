<div class="col-xl-12">
    <div class="card">
        <div class="card-body">
            <%set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and esconde_contrato='n'")
			if not rs.eof then%>
            <h4 class="card-title mb-4">Contratos</h4>

            <div data-simplebar="" style="max-height: 336px;">
                <div class="table-responsive">
                    <table class="table table-borderless table-centered table-nowrap">
                        <thead>
                        	<tr>
                        	    <th>Ramo</th>
                        	    <th>Operadora</th>
                                <th>Vigência</th>
                                <th>Nome amigável</th>
                                <th>Código</th>
                                <th>Dia de Vencimento</th>
                                <th>Data Corte<br />inclusão</th>
                                <th>Data Corte<br />exclusão</th>
                                <th>Mensalidade</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%while not rs.eof%>
                            <tr>
                              <td><span class="font-size-15 mb-1 font-weight-normal"><%=rs("ramo")%></span></td>
                              <td><%=rs("operadora")%></td>
                                <td>
                                    <p class="text-muted font-size-13 mb-0"><%=databrx3(rs("dvigencia"))%></p>
                                </td>
                                <td><%=rs("nome_amigavel")%></td>
                                <td><p class="text-muted font-size-13 mb-0"><%=rs("codigo")%></p></td>
                                <td><p class="text-muted font-size-13 mb-0"><%=rs("vencimento")%></p></td>
                                <td><p class="text-muted font-size-13 mb-0"><%=rs("diafaturamento_inclusao")%></p></td>
                                <td><p class="text-muted font-size-13 mb-0"><%=rs("diafaturamento_exclusao")%></p></td>
                                <td>R$ 
                                <%set va=conexao.execute("select sum(vlrmensalidadeatual) as total from CADASTROGERAL where idempresa="&idx&" and idcadvenda="&rs("id")&" and status2='ATIVO' or idempresa="&idx&"  and coproduto="&rs("id")&" and status2='ATIVO'")
									if not va.eof then
										if va("total")>0 then%>
								  <%=MoedaBrasileira(va("total"))%>
								  <%'=replace(vlr,"/",".")%>
								  <%else%>
								  0,00
								  <%end if%>
								<%else%>
								  0,00
							  <%end if%>
                                </td>
                                <td>
                                <%if rs("status")="ATIVO" then%>
                                <span class="badge badge-soft-success font-size-12"><%=rs("status")%></span>
                                <%else%>
                                <span class="badge badge-soft-warning font-size-12"><%=rs("status")%></span>
                                <%end if%></td>
                                
                            </tr>
                            <%rs.movenext
							wend%>
                            
                           
                        </tbody>
                    </table>
                </div> <!-- enbd table-responsive-->
            </div> <!-- data-sidebar-->
            <%end if
			set rs=nothing%>
        </div><!-- end card-body-->
    </div> <!-- end card-->
</div><!-- end col -->