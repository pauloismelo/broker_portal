<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Contratos</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Início</a></li>
                            <li class="breadcrumb-item active">Contratos</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
        <%if contrato_permitido<>"" then
			if contrato_permitido<>"0" then
				con=split(trim(contrato_permitido),",")
				for i=0 to ubound(con)
					if sqlcon<>"" then
						sqlcon=sqlcon&" or idcadastro="&idx&" and id="&con(i)&" and status='ATIVO' and esconde_contrato='n'"
					else
						sqlcon="where idcadastro="&idx&" and id="&con(i)&" and status='ATIVO' and esconde_contrato='n'"
					end if
				next
				
				set rs=conexao.execute("select * from CADASTROGERAL_VENDAS "&sqlcon&" ")
			else
				set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
			end if
		else
			set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
		end if%>
        
        <%'set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO'")
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
                                <th class="text-center">Consultar<br>Beneficiário</th>
                                <th>Contrato</th>
                                <th class="text-center">Dia de<br>Vencimento</th>
                                <th class="text-center">Incluir<br>Titular</th>
                                <th class="text-center">Incluir<br>Dependente</th>
                                <th class="text-center">Excluir<br>Beneficiário</th>
                                
                            </tr>
                            </thead>


                            <tbody>
                            <%while not rs.eof%>
                            <tr>
                                <td class="text-muted font-weight-semibold text-center">
                                <a href="painel.asp?go=contrato&id=<%=rs("id")%>">
                                	<i class="fas fa-search"></i>
                                </a>
                                </td>
                                <td>
                                    <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("ramo")%> . <%=rs("operadora")%> . <%=rs("codigo")%> <br /><small><%=rs("nome_amigavel")%></small></h6>
                                </td>
                                <td><p class="text-muted font-size-13 mb-0 text-center"><%=rs("vencimento")%></p></td>
                                <td class="text-muted font-weight-semibold text-center">
                                <%if trim(rs("movimentacoes_autorizadas"))="n" then%>
                                        &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                               <%elseif trim(rs("movimentacoes_autorizadas"))="t" then%>
                                        &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                               <%else%>
                                    <%if rs("status")="ATIVO" or rs("status")="CADASTRO" then%>
                                    <a href="painel.asp?go=inclusao_titular&id=<%=rs("id")%>">
                                    	<i class="fas fa-plus"></i>
                                    </a>
									<%end if%>
                               <%end if%>
								
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
								  <%if trim(rs("movimentacoes_autorizadas"))="n" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                  <%elseif trim(rs("movimentacoes_autorizadas"))="t" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                  <%else%>
                                        <%if rs("status")="ATIVO" or rs("status")="CADASTRO" then%>
                                        <a href="painel.asp?go=contrato&id=<%=rs("id")%>">
                                            <i class="fas fa-plus"></i>
                                        </a>
                                        <%end if%>
                                  <%end if%>
								
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
                                <%if trim(rs("movimentacoes_autorizadas_exclusao"))="n" then%>
                                        &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                               <%elseif trim(rs("movimentacoes_autorizadas_exclusao"))="t" then%>
                                        &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                              <%else%>
                                    <%if rs("status")="ATIVO" or rs("status")="CADASTRO" then%>
                                    <a href="painel.asp?go=contrato&id=<%=rs("id")%>">
                                        <i class="fas fa-trash"></i>
                                    </a>
									<%end if%>
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

                
                