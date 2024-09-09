<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Histórico de acessos</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Histórico de acessos</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
       
		<%set cad=conexao.execute("select * from CANAL_CLIENTE_ACESSO where id_empresa="&idx&" order by id desc")%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <h4 class="card-title">Histórico de acessos</h4>
                        <p class="card-title-desc">Visualize abaixo o relatório de acesso dos usuários</p>

                        <table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                
                                <th>Usuário</th>
                                <th>Data</th>
                                <th>Hora</th>
                                <th>IP</th>
                            </tr>
                            </thead>


                            <tbody>
                            <%if not cad.eof then
							while not cad.eof%>
                            <tr> 
                                <td>
                                <%set us=conexao.execute("select * from CADASTROGERAL_USUARIOS where id="&cad("id_usuario")&"")%>
									<%if not us.eof then%>
                                    	<%=us("nome")%>
                                    <%end if
                                set us=nothing%>
                                </td>
                                <td><%=day(cad("data"))%>/<%=month(cad("data"))%>/<%=year(cad("data"))%></td>
                                <td>
									<%=hour(cad("hora"))%>:<%=minute(cad("hora"))%>
                                </td>
                                <td>
									<%=cad("ip")%>
                    			</td>
                            </tr>
                            <%cad.movenext
							wend
							else%>
                            <tr>
                                <td colspan="7" class="text-center">Nenhum acesso encontrado!</td>
                            </tr>
                            <%end if%>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                
       

