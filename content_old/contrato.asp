
<%

set rs2=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and id="&request("id")&"")
if not rs2.eof then

set ce=conexao.execute("select count(id) as total from CADASTROGERAL_FILIAL where idcadastro="&idx&"")
if not ce.eof then
	if ce("total")>1 then
		hafilial="s"
	end if
end if
set ce=nothing
%>
<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0"><small>CONTRATO:</small> <%=rs2("ramo")%> | <%=rs2("operadora")%> | <%=rs2("nome_amigavel")%></h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Contrato</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
        <div class="row">
            <div class="col-12">
            	<form action="painel.asp?go=contrato" method="post">
                <input type="hidden" name="id" value="<%=request("id")%>" />
                <input type="hidden" name="pesq" value="ok" />
            	<div class="form-group row">
                    <div class="col-md-3">
                        <input class="form-control" placeholder="Digite o nome ou cpf do TITULAR" type="text" name="nome" id="nome" value="<%=request("nome")%>">
                    </div>
                    <div class="col-md-2">
						<%if filialx<>"0" and filialx<>"" then
							fil=split(trim(filialx),",")
							for i=0 to ubound(fil)
								if sqlfil<>"" then
									sqlfil=sqlfil&" or idcadastro="&idx&" and id="&fil(i)&""
								else
									sqlfil="where idcadastro="&idx&" and id="&fil(i)&""
								end if
							next
							
							
							'response.Write("select * from CADASTROGERAL_FILIAL "&sqlfil&" order by numero asc")
							set ce=conexao.execute("select * from CADASTROGERAL_FILIAL "&sqlfil&" order by numero asc")%>
							<select name="filial" id="filial" class="form-control">
								<option value="0">Unidade</option>
								<%if not ce.eof then
								while not ce.eof%>
								<option value="<%=ce("id")%>" <%if trim(request("centrodecusto"))=trim(ce("id")) then response.Write("selected") end if%>><%=ce("numero")%> - <%=server.HTMLEncode(ce("nome"))%></option>
								<%ce.movenext
								wend
								end if
								set ce=nothing%>
							</select>
                        <%else
                            set ce=conexao.execute("select * from CADASTROGERAL_FILIAL where idcadastro="&idx&" order by numero asc")%>
                            <select name="filial" id="filial" class="form-control">
                                <option value="0">Unidade</option>
                                <%if not ce.eof then
                                while not ce.eof%>
                                <option value="<%=ce("id")%>" <%if trim(request("centrodecusto"))=trim(ce("id")) then response.Write("selected") end if%>><%=ce("numero")%> - <%=server.HTMLEncode(ce("nome"))%></option>
                                <%ce.movenext
                                wend
                                end if
                                set ce=nothing%>
                            </select>
                        <%end if%>
                        
                        </div>
                    	<div class="col-md-2">
                        <%if trim(centrox)<>"0" and centrox<>"" then
                        
							cen=split(trim(centrox),",")
							for x=0 to ubound(cen)
								if sqlcen<>"" then
									sqlcen=sqlcen&" or idcadastro="&idx&" and id="&cen(x)&""
								else
									sqlcen="where idcadastro="&idx&" and id="&cen(x)&""
								end if
							next
                            'response.Write("select * from CADASTROGERAL_CENTROS "&sqlcen&" order by numero asc")
                            set ce=conexao.execute("select * from CADASTROGERAL_CENTROS "&sqlcen&" order by numero asc")%>
                            <select name="centrodecusto" id="centrodecusto" class="form-control">
                                <option value="0">Centro de Custo</option>
                                <%if not ce.eof then
                                while not ce.eof%>
                                <option value="<%=ce("id")%>" <%if trim(request("centrodecusto"))=trim(ce("id")) then response.Write("selected") end if%>><%=ce("numero")%> - <%=server.HTMLEncode(ce("nome"))%></option>
                                <%ce.movenext
                                wend
                                end if
                                set ce=nothing%>
                            </select>
                        <%else
                            set ce=conexao.execute("select * from CADASTROGERAL_CENTROS where idcadastro="&idx&" order by numero asc")%>
                            <select name="centrodecusto" id="centrodecusto" class="form-control">
                                <option value="0">Centro de Custo</option>
                                <%if not ce.eof then
                                while not ce.eof%>
                                <option value="<%=ce("id")%>" <%if trim(request("centrodecusto"))=trim(ce("id")) then response.Write("selected") end if%>><%=ce("numero")%> - <%=server.HTMLEncode(ce("nome"))%></option>
                                <%ce.movenext
                                wend
                                end if
                                set ce=nothing%>
                            </select>
              			<%end if%>
                        </div>
                    	<div class="col-md-3">
                            <select name="tipo" class="form-control" required>
                                <option value="">Selecione...</option>
                                <option value="ATIVOS" <%if request("tipo")="ATIVOS" then response.Write("selected") end if%>>BENEFICIÁRIO ATIVO</option>
                                <option value="EXCLUIDOS" <%if request("tipo")="EXCLUIDOS" then response.Write("selected") end if%>>BENEFICIÁRIO EXCLUIDO</option>
                            </select>
                        </div>
                    	<div class="col-md-2">
                        	<input type="submit" class="btn btn-success btn-large" value="Pesquisar"/>
                        </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
            

        <%if request("pesq")="ok" then
		
				if trim(request("centrodecusto"))<>"0" then
					if trim(request("centrodecusto"))<>"" then
						sqlcentro=" and idcentro='"&request("centrodecusto")&"'"
					end if
				end if
				
				if trim(request("filial"))<>"0" then
					if trim(request("filial"))<>"" then
						sqlfilial=" and filial="&request("filial")&""
					end if
				end if
				
				if trim(request("tipo"))="ATIVOS" then
					sqltipo=" and status2='ATIVO' and datavigencia<='"&databrx2(date)&"'"
				elseif trim(request("tipo"))="EXCLUIDOS" then
					sqltipo=" and status2='NAO'"
				end if 
				
				if request("nome")<>"" then
					'retirado em 24/02/2023
					'ORDEP=" OR idcadvenda="&request("id")&" and etitular='n' and dependente<>'s' and titular like '%"&request("nome")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" or coproduto='"&request("id")&"'  and etitular='n' and dependente<>'s' and status2='ATIVO' and titular like '%"&request("nome")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" OR idcadvenda="&request("id")&"  and etitular='n' and dependente<>'s' and replace(replace(cpf,'.',''),'-','') like '%"&replace(replace(request("nome"),".",""),"-","")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" OR coproduto='"&request("id")&"'  and etitular='n' and dependente<>'s' and replace(replace(cpf,'.',''),'-','') like '%"&replace(replace(request("nome"),".",""),"-","")&"%'  "&sqlcentro&" "&filial&" "&sqltipo&""
					
					SQL="select * from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='s' and titular like '%"&request("nome")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" OR coproduto='"&request("id")&"' and etitular='s' and titular like '%"&request("nome")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" OR idcadvenda="&request("id")&" and etitular='s' and replace(replace(cpf,'.',''),'-','') like '%"&replace(replace(request("nome"),".",""),"-","")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" OR coproduto='"&request("id")&"' and etitular='s' and replace(replace(cpf,'.',''),'-','') like '%"&replace(replace(request("nome"),".",""),"-","")&"%' "&sqlcentro&" "&filial&" "&sqltipo&" "&ORDEP&"  order by titular asc"
				else
					SQL="select * from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='s' "&sqlcentro&" "&filial&" "&sqltipo&" OR coproduto='"&request("id")&"' and etitular='s' "&sqlcentro&" "&filial&" "&sqltipo&"   order by titular asc"
				end if
				
				'response.Write(SQL)
				set rs=conexao.execute(SQL)
		
		'set rs=conexao.execute("select * from CADASTROGERAL where idempresa="&idx&" and idcadvenda="&request("id")&" OR idempresa="&idx&" and coproduto="&request("id")&" ")
		if not rs.eof then%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <h4 class="card-title">&nbsp;</h4>
                        <p class="card-title-desc">Você está acessando os beneficiários do contrato <strong><%=rs2("ramo")%> | <%=rs2("operadora")%> | <%=rs2("nome_amigavel")%></strong> baseado na pesquisa acima.<br />
						Aqui você pode consultar os titulares e seus dependentes, solicitar a exclusão de um dos beneficiários ou solicitar a inclusão de um dependente para um titular ativo.<br />
                        Além disso, pode baixar o relatório de ativos no formato PDF ou planilha.
                        </p>

                        <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>CPF</th>
                                <th>Plano</th>
                                <th>Unidade</th>
                                <th>Status</th>
                                <th>Incluir</th>
                                <th title="Solicitar alteração de plano para plano INFERIOR ou SUPERIOR ao atual">Down / UP</th>
                                <th>Excluir</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%if not rs.eof then
							while not rs.eof%>
                            <tr>
                                
                                <td width="20%">
								<button type="button" class="btn btn-primary waves-effect waves-light" onclick="window.open('modal.asp?id=<%=rs("id")%>', 'beneficiario', 'width=500,height=600,left=50,top=50');"><i class="fas fa-user"></i></button> 
								<%=rs("titular")%>
                                </td>
                                <td>
                                <%if rs("edependente")="s" then%>
									<span class="badge badge-soft-primary font-size-12" title="Dependente">D</span>
								<%else%>
                                	<span class="badge badge-soft-primary font-size-12" title="Titular">T</span>
								<%end if%>
                                </td>
                                <td><%=rs("cpf")%></td>
                                <td>
								<%if rs("edependente")="s" then
									set dep=conexao.execute("select * from CADASTROGERAL where id="&rs("iddependente")&"")
									if not dep.eof then
										%>
										<%if isnumeric(dep("redecontratada")) then%>
											<%set cad=conexao.execute("select nome from CADASTROGERAL_PLANOS where id="&dep("redecontratada")&" ")
											if not cad.eof then%>
												<%=cad("nome")%>
											<%end if
											set cad=nothing%>
										<%else%>
											<%=dep("redecontratada")%>
										<%end if%>
										
									<%end if
									set dep=nothing
								else%>
									<%if isnumeric(rs("redecontratada")) then%>
										<%set cad=conexao.execute("select nome from CADASTROGERAL_PLANOS where id="&rs("redecontratada")&" ")
										if not cad.eof then%>
											<%=cad("nome")%>
										<%end if
										set cad=nothing%>
									<%else%>
										<%=rs("redecontratada")%>
									<%end if%>
								<%end if%>
                                </td>
                                <td>
								<%if rs("idfilial")<>"" then%>
								<%set ce=conexao.execute("select nome from CADASTROGERAL_FILIAL where id="&rs("idfilial")&" and idcadastro="&idx&" or  numero="&rs("idfilial")&" and idcadastro="&idx&" ")%>
									<%if not ce.eof then%>
                                        <%=ucase(ce("nome"))%>
                                        <%if hafilial="s" then%>
                                        <a href="painel.asp?go=trocafilial&id=<%=rs("id")%>&contrato=<%=request("id")%>" title="Alteração de Filial/Unidade"> 
                                        <i class="fas fa-redo-alt"></i>
                                        </a>
                                        <%end if%>
                                    <%else%>
                                        
                                    <%end if%>
								<%set ce=nothing%>
                                <%end if%>
                    			</td>
                                <td>
									<%if rs2("status")="ATIVO" then 'contrato ativo%>
                                    
										<%if rs("status2")="ATIVO" then%>
                                            <span class="badge badge-soft-success font-size-12"><%=rs("status2")%></span>
                                        <%else%>
                                            <span class="badge badge-soft-danger font-size-12">EXCLUIDO</span>
                                        <%end if%>
                                    <%else%>
                                    	<span class="badge badge-soft-danger font-size-12">EXCLUIDO</span>
                                    <%end if%>
                                </td>
                                <td class="text-center">
								  <%if trim(rs2("movimentacoes_autorizadas"))="n" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                  <%elseif trim(rs2("movimentacoes_autorizadas"))="t" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                  <%else%>
                                        <%if rs2("status")="ATIVO" or rs2("status")="CADASTRO" then%>
                                            <%if rs("etitular")="s" and rs("status2")="ATIVO" then%>
                                                <a href="painel.asp?go=inclusao_dependente2&id=<%=rs("id")%>">
                                                    <i class="fas fa-plus" title="Incluir Dependente para <%=rs("titular")%>"></i>
                                                </a>
                                            <%end if%>
                                        <%end if%>
                                  <%end if%>
                                </td>
                                <td class="text-center">
                                <%if trim(rs2("movimentacoes_autorizadas"))="n" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                  <%elseif trim(rs2("movimentacoes_autorizadas"))="t" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                  <%else%>
                                        <%if rs2("status")="ATIVO" or rs2("status")="CADASTRO" then
                                            
                                            if month(now)=month(rs2("dvigencia")) then%>
                                                <a href="painel.asp?go=downgrade&id=<%=rs("id")%>&contrato=<%=request("id")%>" title="Alteração para plano inferior"><i class="fas fa-arrow-circle-down"></i></a>
                                                &nbsp;&nbsp;
                                                <a href="painel.asp?go=upgrade&id=<%=rs("id")%>&contrato=<%=request("id")%>" title="Alteração para plano superior"><i class="fas fa-arrow-alt-circle-up"></i></a>
                                            <%else%>
                                                <button type="button" class="btn btn-danger waves-effect waves-light" data-toggle="modal" data-target=".bs-example-modal-sm">
                                                    <i class="fas fa-times-circle text-white"></i>
                                                </button>

                                                <div class="modal fade bs-example-modal-sm" tabindex="-1" aria-labelledby="mySmallModalLabel" aria-hidden="true" style="display: none;">
                                                    <div class="modal-dialog modal-sm">
                                                        <div class="modal-content bg-danger text-white">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title mt-0" id="mySmallModalLabel">Downgrade/Upgrade</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">×</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body" style="white-space: normal">
                                                                <p>
                                                                    Upgrade e Downgrade só podem ser solicitados no mês de aniversário do contrato!
                                                                    Nesse contrato, o mês de aniversário é: <%=monthname(month(rs2("dvigencia")))%>
                                                                </p>
                                                            </div>
                                                        </div><!-- /.modal-content -->
                                                    </div><!-- /.modal-dialog -->
                                                </div>
                                            <%end if%>
                                        
                                        <%end if%>
                                  <%end if%>    
                                </td>
                                
                                <td class="text-center">
								<%if trim(rs2("movimentacoes_autorizadas_exclusao"))="n" then%>                                  &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                  <%elseif trim(rs2("movimentacoes_autorizadas_exclusao"))="t" then%>
                                            &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                  <%else%>
                                        <%if rs2("status")="ATIVO" or rs2("status")="CADASTRO" then%>
                                            <a href="painel.asp?go=exclusao&id=<%=rs("id")%>&contrato=<%=request("id")%>"><i class="fas fa-trash"></i></a>
                                        <%end if%>
                                  <%end if%> 
								
                                </td>
                            </tr>
                            <%set rs3=conexao.execute("select * from CADASTROGERAL where iddependente="&rs("id")&"")
                            if not rs3.eof then%>
                            <tr>
                            	<td colspan="9" style="padding:0px; padding-left:2%;">
                                	<table class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                		<thead>
                                        	<tr>
                                            	<th>Dependente(s) de <%=rs("titular")%></th>
                                                <th>CPF</th>
                                                <th>Plano</th>
                                                <th>Status</th>
                                                <th>Excluir</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
									<%while not rs3.eof%>
                                		
                                    	<tr>
                                            <td>
                                            <button type="button" class="btn btn-warning waves-effect waves-light" onclick="window.open('modal.asp?id=<%=rs3("id")%>', 'beneficiario', 'width=500,height=600,left=50,top=50');"><i class="fas fa-user"></i></button> 
                                            <%=rs3("titular")%>
                                            </td>
                                            <td><%=rs3("cpf")%></td>
                                            <td>
											<%if isnumeric(rs("redecontratada")) then%>
                                                <%set cad=conexao.execute("select nome from CADASTROGERAL_PLANOS where id="&rs("redecontratada")&" ")
                                                if not cad.eof then%>
                                                    <%=cad("nome")%>
                                                <%end if
                                                set cad=nothing%>
                                            <%else%>
                                                <%=rs("redecontratada")%>
                                            <%end if%>
                                            </td>
                                            <td>
                                                <%if rs2("status")="ATIVO"  then 'contrato ativo%>
                                                
                                                    <%if rs3("status2")="ATIVO" then%>
                                                        <span class="badge badge-soft-success font-size-12"><%=rs3("status2")%></span>
                                                    <%else%>
                                                        <span class="badge badge-soft-danger font-size-12">EXCLUIDO</span>
                                                    <%end if%>
                                                <%else%>
                                                    <span class="badge badge-soft-danger font-size-12">EXCLUIDO</span>
                                                <%end if%>
                                            </td>
                                            
                                            <td class="text-center">
                                            <%if trim(rs2("movimentacoes_autorizadas_exclusao"))="n" then%>
                                                        &nbsp;<i class="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
										  <%elseif trim(rs2("movimentacoes_autorizadas_exclusao"))="t" then%>
                                                    &nbsp;<i class="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                          <%else%>
                                                <%if rs2("status")="ATIVO" or rs2("status")="CADASTRO" then%>
                                                    <a href="painel.asp?go=exclusao&id=<%=rs3("id")%>&contrato=<%=request("id")%>"><i class="fas fa-trash"></i></a>
                                                <%end if%>
                                          <%end if%> 
                                            
                                            </td>
                                        </tr>
                                    
                                <%rs3.movenext
								wend%>
                                	</tbody>
									</table>
                                </td>
                            </tr>
                            <%end if
							set rs3=nothing%>
                            
                            
                            <!-- ///////////////////////////////////////inicio do dependente -->
								
                                
                            <%rs.movenext
							wend
							else%>
                            <tr>
                                <td colspan="8" class="text-center">Nenhum beneficiário encontrado!</td>
                            </tr>
                            <%end if%>
                            
                                
                            </tbody>

                        </table>
                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body" style="text-align:center;">
                    	<!--<a href="painel.asp?go=contrato_ativos&id=<%=request("id")%>" target="_blank"><button class="btn btn-danger btn-large" value="Pesquisar">VISUALIZAR RELATÓRIO DE ATIVOS</button></a>
                        -->
                         <a href="relatorio_beneficiarios_gerapdf.php?idcadastro=<%=idx%>&idcadvenda=<%=request("id")%>&user=<%=replace(userxy," ","_")%>" target="_blank"><button class="btn btn-danger btn-large" value="Pesquisar">ENVIAR RELATÓRIO DE ATIVOS - PDF</button></a> 
                         &nbsp;&nbsp;
                         <a href="phpexcel/example.php?idcadastro=<%=idx%>&id=<%=request("id")%>&user=<%=replace(userxy," ","_")%>" target="_blank"><button class="btn btn-success btn-large" value="Pesquisar">ENVIAR RELATÓRIO DE ATIVOS - PLANILHA</button></a> 
                    
                    </div>
                </div>
            </div>
        </div>
        
        <%end if
		set rs=nothing
		end if%>

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->
<%
end if
set rs2=nothing%>
                
                
       

