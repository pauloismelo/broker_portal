<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Movimentação Seguro de Vida</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Início</a></li>
                            <li class="breadcrumb-item active">Movimentação Seguro de Vida</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <%set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where ramo='VIDA' and idcadastro="&idx&"")
		if not rs.eof then%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Segue abaixo os contratos cadastrados para a sua empresa.
                        </p>

                        <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                <th class="text-center">Anexar<br>Planilha</th>
                                <th>Contrato</th>
                                <th class="text-center">Vigencia</th>
                                <th class="text-center">Dia de<br>Vencimento</th>
                                <th class="text-center">Data Corte<br />Inclusao</th>
                                <th class="text-center">Data Corte<br />Exclusao</th>
                                <th class="text-center">Vidas</th>
                                <th class="text-center">Mensalidade</th>
                                <th class="text-center">Status</th>
                                
                            </tr>
                            </thead>


                            <tbody>
                            <%while not rs.eof%>
                            <tr>
                                <td class="text-muted font-weight-semibold text-center">
                                    <%if rs("status")="ATIVO" or rs("status")="CADASTRO" then%>
                                    <form action="painel.asp?go=contratos_segurovida_form" method="post">
                                    	<input type="hidden" name="id" value="<%=rs("id")%>" />
                                        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i></button>
                                    </form>
                                    <%end if%>
                                    
                                </td>
                                <td>
                                    <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("ramo")%> . <%=rs("operadora")%> . <%=rs("codigo")%> <br /><small><%=rs("nome_amigavel")%></small></h6>
                                </td>
                                <td>
                                <p class="text-muted font-size-13 mb-0 text-center"><%=databrx3(rs("dvigencia"))%></p>
                                </td>
                                <td>
                                <p class="text-muted font-size-13 mb-0 text-center"><%=rs("vencimento")%></p>
                                </td>
                                <td>
                                <p class="text-muted font-size-13 mb-0 text-center"><%=rs("diafaturamento_inclusao")%></p>
                                </td>
                                <td>
                                <p class="text-muted font-size-13 mb-0 text-center"><%=rs("diafaturamento_exclusao")%></p>
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
									<%'=====contador de vidas do plano especifico escolhido====
									set com=conexao.execute("select * from cadastrogeral where idempresa="&idx&" and idcadvenda="&rs("id")&" and status2='ATIVO' or idempresa="&idx&"  and coproduto="&rs("id")&" and status2='ATIVO' order by id asc")
						
									if not com.eof then
										contador=0
										while not com.eof
												contador=contador+1
										com.movenext
										wend
									end if
									set com=nothing
									'==============================================================================%>
									<%=contador%>                                
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
                                	R$ <%=MoedaBrasileira(rs("vlrpremio_atual"))%>
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
                                <%if rs("status")="ATIVO" then%>
                                    <span class="badge badge-success">
                                        <%=rs("status")%>
                                    </span>
								<%else%>
                                    <span class="badge badge-danger">
                                    	<%=rs("status")%>
                                    </span>
								<%end if%>
                                </td>
                            </tr>
                            <%rs.movenext
							wend%>
                            
                            </tbody>
                        </table>

                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->                        
		<%end if
		set rs=nothing%>
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                