<%set rs2=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and id="&request("id")&"")
if not rs2.eof then
%>
<div class="page-content">
    <div class="container-fluid">


        <%
		SQL="select * from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='s' and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' OR coproduto='"&request("id")&"' and etitular='s' and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' order by titular asc"
				
		'response.Write(SQL)
		set rs=conexao.execute(SQL)
		if not rs.eof then%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">&nbsp;</h4>
                   	<p class="card-title-desc">Você está acessando o relatório de  beneficiários ATIVOS do contrato <strong><%=rs2("ramo")%> | <%=rs2("operadora")%> | <%=rs2("nome_amigavel")%></strong>.<br />
                    <%set op=conexao.execute("select count(id) as beneficiarios, sum(vlrmensalidadeatual) as mensalidade from CADASTROGERAL where idcadvenda="&request("id")&" and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' or coproduto="&request("id")&" and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' ")
					if not op.eof then%>
                    Número de beneficiários ativos: <strong><%=op("beneficiarios")%></strong><br />
                    Valor da mensalidade atual: <strong><%=MoedaBrasileira(op("mensalidade"))%></strong><br />
                    <%end if
					set op=nothing%>
                    Você poderá fazer o download desse relatório através do botões "<strong>EXCEL</strong>" ou "<strong>PDF</strong>" abaixo.
                      	</p>

                      	<table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                            	<td colspan="6">
                                Empresa: <%=titularx%><br />
                                Contrato: <%=rs2("ramo")%> | <%=rs2("operadora")%> | <%=rs2("nome_amigavel")%>
                                </td>
                            </tr>
                            <tr>
                                <td>Nome</td>
                                <th>Tipo</th>
                                <th>CPF</th>
                                <th>Plano</th>
                                <th>Unidade</th>
                                <th>Valor</th>
                              </tr>
                            </thead>
                            <tbody>
                            <%if not rs.eof then
							while not rs.eof%>
                            <tr>
                              	
                                <td>
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
								<%set ce=conexao.execute("select nome from CADASTROGERAL_FILIAL where id="&rs("idfilial")&" and idcadvenda="&request("id")&" or  numero="&rs("idfilial")&" and idcadvenda="&request("id")&" ")%><%if not ce.eof then%><%=ucase(ce("nome"))%><%end if%><%set ce=nothing%>
                                <%end if%>
                    			</td>
                                <td>
									<%total=total+CDBL(rs("vlrmensalidadeatual"))%>
                        			R$ <%=replace(rs("vlrmensalidadeatual"),".",",")%>
                                </td>
                              </tr>
                              <!-- /////////////////////////////////////////////////-->
                              <%set rs2=conexao.execute("select id,cpf,edependente,status2,titular,iddependente,redecontratada,idfilial,vlrmensalidadeatual from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='n' and edependente='s' and iddependente="&rs("id")&" and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' or coproduto="&request("id")&" and etitular='n' and edependente='s' and iddependente="&rs("id")&" and status2='ATIVO' and datavigencia<='"&databrx2(date)&"' ")
								if not rs2.eof then
								while not rs2.eof
								x=x+1%>
								<tr>
								  	
									<td>
									   <%=ucase(rs2("titular"))%>
									</td>
                                    <td><span class="badge badge-soft-primary font-size-12" title="Dependente">D</span></td>
                                    <td><%=rs2("cpf")%></td>
									<td>
									<%set dep=conexao.execute("select redecontratada from CADASTROGERAL where id="&rs2("iddependente")&"")
										if not dep.eof then%>
											<%if isnumeric(dep("redecontratada")) then%>
												<%set cad=conexao.execute("select nome,acomodacao from CADASTROGERAL_PLANOS where id="&dep("redecontratada")&" ")
												if not cad.eof then%>
													<%=cad("nome")%>
												<%end if
												set cad=nothing%>
											<%else%>
												<%=dep("redecontratada")%>
									  		<%end if%>
											
											
										<%end if
										set dep=nothing%>
									</td>
									<td>&nbsp;</td>
									<td>
										<%total=total+CDBL(rs2("vlrmensalidadeatual"))%>
										R$ <%=replace(rs2("vlrmensalidadeatual"),".",",")%>
									</td>
								  </tr>
								<%rs2.movenext
								wend
								end if
								set rs2=nothing%>
                              <!-- /////////////////////////////////////////////////-->
                            <%rs.movenext
							wend%>
                            	
							<%else%>
                            <tr>
                                <td colspan="6" class="text-center">Nenhum beneficiário encontrado!</td>
                            </tr>
                            <%end if%>
                            
                                
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
<%
end if
set rs2=nothing%>
                
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>      
<script>


$('#datatable-buttons').DataTable( {
    buttons: [
        'copy', 'excel', 'pdf'
    ]
} );
</script>
