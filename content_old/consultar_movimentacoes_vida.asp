
<%
if request("acao")="delete" then
	AbreConexao
	conexao.execute("update TB_MOVIMENTACAO_SEGURADOS set removido='s', removido_por='"&userxy&"', removido_em='"&date&" "&time&"', status='ANULADO' where id="&request("id")&" ")
	FechaConexao
	response.Write("<script>alert('Registro Anulado com sucesso!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacoes';</script>")
end if
%>

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Consultar Movimentações - Seguro de vida</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item">Seguro de Vida</li>
                            <li class="breadcrumb-item active">Consultar</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
        <div class="row">
            <div class="col-12" >
            	<form action="painel.asp?go=movimentacoes_vida" method="post">
                <input type="hidden" name="pesq" value="ok" />
            	<div class="form-group row">
                    <div class="col-md-3">
                    	<label for="statuss">Status</label>
						<select name="statuss" id="statuss" class="form-control">
                            <option value="">Selecione...</option>
                            <option value="ANULADO" <%if ucase(request("statuss"))="ANULADO" then response.Write("selected") end if%>>ANULADO</option>
                            <option value="ENVIADO" <%if ucase(request("statuss"))="ENVIADO" then response.Write("selected") end if%>>ENVIADO</option>
                            <option value="EXECUCAO" <%if ucase(request("statuss"))="EXECUCAO" then response.Write("selected") end if%>>EM EXECUCAO</option>
                            <option value="CONCLUIDA" <%if ucase(request("statuss"))="CONCLUIDA" then response.Write("selected") end if%>>CONCLUIDA</option>
                      	</select>	
                    </div>
                    <div class="col-md-3">
                    	<label for="contrato">Contrato</label>
                        <select name="contrato" id="contrato" class="form-control">
                            <option value="">Selecione...</option>
                            <%set con=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n' and ramo<>'SAUDE' and ramo<>'ODONTO'")
                            if not con.eof then
                                while not con.eof%>
                                    <option value="<%=con("id")%>" <%if trim(request("contrato"))=trim(con("id")) then response.Write("selected") end if%>><%=con("ramo")%> . <%=con("segmento")%> . <%=con("operadora")%></option>
                                <%con.movenext
                                wend
                            end if
                            set con=nothing%>
                      	</select>   
                    </div>
                    <div class="col-md-3">
                    	<label for="mes">Mês da Solicitação</label>
                        <input type="month" name="mes" id="mes" value="<%=request("mes")%>" class="form-control" />
                    </div>
                    <div class="col-md-3">
                    	<label for="protocolo">Protocolo</label>
                    	<input type="text" name="protocolo" id="protocolo" value="<%=request("protocolo")%>" placeholder="Insira o protocolo" class="form-control"  />
                    </div>
                    
                   	
                </div>
                <div class="form-group row">
                	<div class="col-md-12 text-center">
                       	<input type="submit" class="btn btn-success btn-large" value="Pesquisar"/>
                    </div>
                </div>
                </form>
            </div>
        </div>
        <%if request("pesq")="ok" then			
			
				
				
				if request("protocolo")<>"" then
					protocolos=" and protocolo like '%"&request("protocolo")&"%'"
					frase_protocolo="| protocolo: "&request("protocolo")&" "
				end if
				
				if request("statuss")<>"" then
					statuss=" and status='"&request("statuss")&"'"
					frase_status="| status: "&request("statuss")&" "
				end if
				
				if request("contrato")<>"" then
					contratos=" and contrato='"&request("contrato")&"'"
				end if
				
				if request("mes")<>"" then
					'mess=" and month(convert(DATE, datareg, 103))='"&request("mes")&"'"
					mess=" and month(datareg)='"&month(request("mes"))&"'"
					frase_mes="| mês: "&monthname(month(request("mes")))&" "
					
					anoss=" and year(datareg)='"&year(request("mes"))&"'"
					frase_ano="| Ano: "&year(request("mes"))&" "
				end if
				

								
				if contrato_permitido<>"0" then
				con=split(trim(contrato_permitido),",")
				for w=0 to ubound(con)
					if sqlx<>"" then
						sqlx=sqlx&" or id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&" "&contratos&" and contrato="&con(w)&" "
						sqlx=sqlx&" or id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&" "&contratos&" and contrato="&con(w)&" "
					else
						sqlx="where id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&" "&contratos&" and contrato="&con(w)&" "
					end if
				next	
				else'sem distinção de contrato
					if sqlx<>"" then
						sqlx=sqlx&" or id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&" "&contratos&" "
						sqlx=sqlx&" or id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&" "&contratos&" "
					else
						sqlx="where id_cliente="&idx&" "&protocolos&" "&statuss&" "&mess&""&anoss&""&contratos&" "
					end if
				end if

				
				SQLS="select * from TB_MOVIMENTACAO_SEGURADOS "&sqlx&" order by id desc "
				'response.Write(SQLS)
				'response.End()
				set cad=conexao.execute(SQLS)
				%>
        
            
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                <thead>
                                <tr>
                                    <th>Por</th>
                                    <th>Enviado em</th>
                                    <th>Contrato</th>
                                    <th>Arquivo</th>
                                    <th>Referencia</th>
                                    <th>Anular</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%if not cad.eof then
                                while not cad.eof
                                
                                    set co=conexao.execute("select count(id) as total from MOVIMENTACAO_PENDENCIA where id_movimentacao="&cad("id")&" and finalizou='n' ")
                                    if cad("status")="concluida" then
                                        stat="CONCLUIDA"
                                        label="-success"
                                    elseif cad("status")="ENVIADO" then
                                        stat="ENVIADO"
                                        label="-info"
                                    elseif cad("status")="ANULADO" then
                                        stat="ANULADO"
                                        label="-danger"                                    
                                    elseif cad("status")="EXECUCAO" then
										stat="EM EXECUCAO"
										label="-primary"
                                    end if%>
                                <tr>
                                    
                                    <td>
                                        <i class="fas fa-user" title="<%=databrx3(cad("datareg"))%> às <%=hour(cad("datareg"))%>:<%=minute(cad("datareg"))%> por <%=cad("userreg")%>"></i>
                                    </td>
                                    <td align="center">
									<%=databrx3(cad("datareg"))%> <br /> <%=hour(cad("datareg"))%>:<%=minute(cad("datareg"))%></td>
                                    <td>
                                        <%set em=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&cad("contrato")&"")%><%if not em.eof then%><%=em("ramo")%><br /><%=em("operadora")%><%end if%><%set em=nothing%>
                                    </td>
                                    
                                    <td>
										<%if cad("ausente")="s" then%>
                                            <span title="O usuario informou que não há movimentação para esse mês">SM</span>
                                        <%else%>
                                            <%if cad("planilha")<>"nenhum" then%>
                                            <a target="_blank" href="docs_movimentacao/<%=cad("planilha")%>">
                                            	<i class="fas fa-download" title="Download da Planilha"></i>
                                            </a>
                                            <%else%>
                                                <%if cad("userreg")="ROTINA AUTOMATICA" then%>
                                                    Faturamento nao enviado
                                                <%else%>
                                                -
                                                <%end if%>
                                            <%end if
                                        end if%>
                                        
                                        &nbsp;
										<%=ucase(cad("planilha"))%>
                                        
                                        <br />
                                        <small>Protocolo: <%=cad("protocolo")%></small>
                                    </td>
                                    <script type="text/javascript"> 
                                    function confirmation<%=cad("id")%>() {
                                        var answer = confirm("Deseja realmente [ANULAR] este registro?")
                                        if (answer){
                                            //alert("Registro Removido com sucesso!")
                                            window.location = 'painel.asp?go=movimentacoes_vida&id=<%=cad("id")%>&acao=delete';
                                        }
                                    }
                                    </script>
                                    <td>
                                        <%mes_vigente=split(cad("vigencia"),"-")
                                        response.Write(mes_vigente(1)&"/"&mes_vigente(0))%>
                                    </td>
                                    <td>
										<%if cad("status")="ENVIADO" then%>
                                            <i class="fas fa-trash-alt" title="Anular Solicitação de Movimentação" style="cursor:pointer;" onclick="confirmation<%=cad("id")%>();"></i>
                                        <%end if%>
                                    </td>
                                    <td>
                                        <span class="badge badge-soft<%=label%> font-size-12"><%=ucase(stat)%></span>
                                        <%if cad("status")="ANULADO" then%>
                                        	<i class="fas fa-info-circle" title="<%=cad("removido_motivo")%>"></i>
										<%elseif cad("status")="concluida" then%>
                                            <small>
                                            <br />Concluida em: <strong><%=day(cad("dataconcluiu"))%>/<%=month(cad("dataconcluiu"))%>/<%=year(cad("dataconcluiu"))%></strong>
                                            </small>
										<%end if%>
                                    </td>
                                    
                                </tr>
                                <%cad.movenext
                                wend
                                else%>
                                <tr>
                                    <td colspan="8" class="text-center">Nenhuma movimentação encontrada!</td>
                                </tr>
                                <%end if
								set cad=nothing%>
                                
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> <!-- end col -->
            </div> <!-- end row -->
            <%end if
		
		
		'end if
		%>

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
<script>
$('#datatable').dataTable( {
    "order": []
} );
</script>
                
       

