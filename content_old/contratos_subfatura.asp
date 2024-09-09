<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Subfaturas</h4>

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
        <%set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n'")
		if not rs.eof then%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Selecione um contrato abaixo para visualizar suas respectivas subfaturas.
                        </p>

                        <table class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                <th class="text-center">Consultar<br>Subfaturas</th>
                                <th>Ramo</th>
                                <th>Operadora</th>
                                <th class="text-center">Dia de<br>Vencimento</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%while not rs.eof%>
                            <tr>
                                <td class="text-muted font-weight-semibold text-center">
                                <%set rs2=conexao.execute("select id from CAIXAVENDAS where subfaturadeidcx="&rs("idvenda")&"")
								if not rs2.eof then%>
                                <a href="painel.asp?go=contratos_subfatura-view&id=<%=rs("id")%>" title="Visualizar as subfaturas desse contrato">
                                <i class="fas fa-search"></i>
                                </a>
                                <%else%>
                                <small>
                                	Não há subfatura <br />para esse contrato
                                </small>
                                <%end if
								set rs2=nothing%>
                                </td>
                                <td>
                                    <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("ramo")%> </h6>
                                </td>
                                <td>
								<h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("operadora")%></h6>
                                <p class="text-muted font-size-13 mb-0">Cod: <%=rs("codigo")%></p>
                                </td>
                                <td><p class="text-muted font-size-13 mb-0 text-center"><%=rs("vencimento")%></p></td>
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

                
                