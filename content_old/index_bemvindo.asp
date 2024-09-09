<div class="col-xl-4">
    <div class="card">
        <div class="card-body">

            <h5>Bem vindo !<br></h5> <h2 class="text-primary mb-1"><%=titularx%></h2>
            <h5><%=nfantasia%></h5>

            <%set rs=conexao.execute("select count(id) as total from CADASTROGERAL_VENDAS where idcadastro="&idx&"")
			if not rs.eof then
				contratos=rs("total")
			end if
			set rs=nothing
			
			set rs=conexao.execute("select count(id) as total from CADASTROGERAL where idempresa="&idx&" and status2='ATIVO' and edependente='s' OR idempresa="&idx&" and status2='ATIVO' and etitular='s'")
			if not rs.eof then
				vidas=rs("total")
			end if
			set rs=nothing
			
			set rs=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&"  ")
			if not rs.eof then
				movimentacoes=rs("total")
			end if
			set rs=nothing
			%>
            <div class="row mt-1 align-items-center">
                <div class="col-sm-12">
                    <p class="text-muted">
                        <span class="text-success mr-1"><%=contratos%></span> Contratos no total<br>
                        <span class="text-success mr-1"><%=vidas%></span> Beneficiários ativos no total<br>
                        <span class="text-success mr-1"><%=movimentacoes%></span> Movimentações no total<br>
                    </p>

                    <div class="mt-3">
                        <a href="painel.asp?go=perfil" class="btn btn-primary waves-effect waves-light">Ver Perfil
                            <i class="uil uil-arrow-right"></i></a>
                    </div>
                </div> <!-- end col-->
                
            </div> <!-- end row -->
        </div> <!-- end card-body-->
    </div><!-- end card-->
</div> <!-- end col-->