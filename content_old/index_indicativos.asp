<div class="col-xl-8">
	<div class="row">

        <div class="col-sm-6">
            <%
			set ind=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='ENVIADO' and tipo='INCLUSAO' and solicitacao_principal is null and aguardando='n'  or id_empresa="&idx&" and status='EXECUCAO' and tipo='INCLUSAO' and solicitacao_principal is null and aguardando='n' ")
			if not ind.eof then
				inc=ind("total")
			end if
			set ind=nothing
			
			set ind=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='ENVIADO' and tipo='EXCLUSAO' and solicitacao_principal is null and aguardando='n'  or id_empresa="&idx&" and status='EXECUCAO' and tipo='EXCLUSAO' and solicitacao_principal is null and aguardando='n'")
			if not ind.eof then
				exc=ind("total")
			end if
			set ind=nothing%>
            <div class="card">
                <div class="card-body">
                    <div class="float-right mt-2">
                        <div id="customers-chart"> </div>
                    </div>
                    <div>
                        <h4 class="mb-1 mt-1"><span data-plugin="counterup"><%=inc+exc%></span></h4>
                        <p class="text-muted mb-0">Movimentações Em aberto</p>
                    </div>
                    <p class="text-muted mt-3 mb-0"><span class="text-danger mr-1"><%=inc%></span> Inclusões 
                    <p class="text-muted mt-3 mb-0"><span class="text-danger mr-1"><%=exc%></span> Exclusões 
                    </p>
                </div>
            </div>
        
            <%set oc=conexao.execute("select count(id) as total from PORTALCLIENTE_OCORRENCIAS where id_cliente="&idx&" and status<>'CONCLUIDO' ")%>
            <div class="card">
                <div class="card-body">
                    <div class="float-right mt-2">
                        <div id="growth-chart"></div>
                    </div>
                    <div>
                        <h4 class="mb-1 mt-1"><span data-plugin="counterup"><%=oc("total")%></span></h4>
                        <p class="text-muted mb-0">Ocorrências</p>
                    </div>
                    <p class="text-muted mt-3 mb-0"><span class="text-success mr-1">&nbsp;</span>&nbsp;
                    </p>
                </div>
            </div>
            <%set oc=nothing%>
        </div> <!-- end col-->
        
        <div class="col-sm-6">
        	<%set ind=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='ENVIADO' and tipo='INCLUSAO' or id_empresa="&idx&" and status='EXECUCAO' and tipo='INCLUSAO'")
			if not ind.eof then
				inc=ind("total")
			end if
			set ind=nothing
			
			set ind=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='concluida' and tipo='EXCLUSAO' ")
			if not ind.eof then
				exc=ind("total")
			end if
			set ind=nothing%>
            <div class="card">
                <div class="card-body">
                    <div class="float-right mt-2">
                        <div id="orders-chart"> </div>
                    </div>
                    <div>
                        <h4 class="mb-1 mt-1"><span data-plugin="counterup"><%=inc+exc%></span></h4>
                        <p class="text-muted mb-0">Movimentações concluidas</p>
                    </div>
                    <p class="text-muted mt-3 mb-0"><span class="text-success mr-1"><%=inc%></span> Inclusões
                    <p class="text-muted mt-3 mb-0"><span class="text-success mr-1"><%=exc%></span> Exclusões 
                    </p>
                </div>
            </div>
        
            <%
			set ind=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='COM_PENDENCIA' ")
			if not ind.eof then
				inc=ind("total")
			end if
			set ind=nothing
			%>
            <div class="card">
                <div class="card-body">
                    <div class="float-right mt-2">
                        <div id="total-revenue-chart"></div>
                    </div>
                    <div>
                        <h4 class="mb-1 mt-1"> <span data-plugin="counterup"><%=inc%></span></h4>
                        <p class="text-muted mb-0">Pendencias</p>
                    </div>
                    <p class="text-muted mt-3 mb-0"><span class="text-success mr-1">&nbsp;</span> &nbsp;
                    </p>
                </div>
            </div>
        </div> <!-- end col-->
        
        
        
    </div>
</div>