<div class="page-content">
    <div class="container-fluid">		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Movimentação Seguro de Vida por planilha</h4>
                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">Movimentação Seguro de Vida por planilha</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <!-- end page title -->

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                    	<p class="card-title-desc">
                       		<%AbreConexao
							set cad=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("id")&"")
							%>
							CONTRATO: <%=cad("ramo")%> . <%=cad("operadora")%> . <%=cad("codigo")%> 
							<%if cad("nome_amigavel")<>"" then%> . <%=cad("nome_amigavel")%><%end if%><BR />
							
							Data corte - Inclus&atilde;o: <%=cad("diafaturamento_inclusao")%><br>
							Data corte - Exclus&atilde;o: <%=cad("diafaturamento_exclusao")%><br>
							Dia de vencimento do boleto: <%=cad("vencimento")%><br />
							Tipo de cobrança: <%=cad("tipocobranca_inclusao")%><br />
							Dia de emissao da fatura: <%=cad("data_emissao_fatura")%><br />
                        </p>
                        <p class="card-title-desc  text-danger">
                            ATENÇÃO:<br>Somente estarão cobertos os usuários relacionados na planilha de segurados.<br>Não se esqueça de incluir os afastados previamente autorizados.
                        </p>

						<form action="movimentacao_segurados_upload.asp" method="post" enctype="multipart/form-data" name="form01">
            			<input type="hidden" name="empresa" value="<%=titularx%>">
            			<input type="hidden" name="contrato" value="<%=request("id")%>" />
                        
                        <%set rs=conexao.execute("select * from TB_MOVIMENTACAO_SEGURADOS where id_cliente="&idx&" and contrato="&request("id")&" and month(datareg)='"&month(now)&"'  and year(datareg)='"&year(now)&"' ")
						if not rs.eof then%>
                       	  <div class="alert alert-danger text-left">
                            	
                                <strong>Encontramos um envio de movimentação esse mês!</strong><br /><br />
                                <ul>
                                	<%while not rs.eof%>
                                	<li>
                                        Enviado em <%=databrx3(rs("datareg"))%> às <%=hour(rs("datareg"))%>:<%=minute(rs("datareg"))%> por <%=rs("userreg")%> <br>Arquivo: <%=rs("planilha")%> - <strong><%=rs("status")%></strong>
                                    </li>
                                    <br>
                                    <%rs.movenext
									wend%>
                                </ul>
                                <br />
                                <strong>Deseja reenviar uma nova movimentação para esse mês?</strong>
                                
                                &nbsp;<br>Se sim, informe o motivo do reenvio no campo abaixo.
            				
                                <textarea name="reenvio" class="form-control" id="reenvio" required="required"></textarea>
                            
                            </div>
                        <%else%>
                        	<input type="hidden" name="reenvio" id="reenvio" value="-"/>
						<%end if
						set rs=nothing%>
                        <script>
                            function Altera(x){
                                if (document.getElementById('ausente2').checked){
                                    document.getElementById('ausente').value='s';
                                    document.getElementById('foto').removeAttribute("required");
                                    document.getElementById('planilha').style.display='none';
                                    document.getElementById('planilha2').style.display='none';
                                }else{
                                    document.getElementById('ausente').value='n';
                                    document.getElementById('foto').setAttribute("required","required");
                                    document.getElementById('planilha').style.display='block';
                                    document.getElementById('planilha2').style.display='block';
                                }
                            }
						</script>
                       
                       
                        <label class="row">Caso NÃO haja movimentação(inclusão ou exclusão de funcionário) para esse mês, marque a opção abaixo:&nbsp;&nbsp;</label>
                        <div class="row">
                        
                            <div class="col-12 text-left">
                            	<input type="checkbox" name="ausente2" id="ausente2" onclick="Altera(this.value);" />&nbsp;Favor emitir o faturamento com os mesmos segurados do mês anterior, pois não há movimentação de usuários para esse mês.
                            </div>
                        </div>
                        <input type="hidden" name="ausente" id="ausente" />
                        
                        <div class="form-group row">&nbsp;</div>
                        
                        <div class="form-group row" id="planilha">
                            <label class="col-md-12 col-form-label" for="foto">
                                Anexe a planilha contendo a movimenta&ccedil;&atilde;o atual. Não esquecer os segurados afastados.
                                <br>Favor nomear o arquivo da seguinte maneira: VIDA_NOMEDAEMPRESA_MESANO.xls (nome abreviado ou nome fantasia)
                            </label>
                            <input type="file" name="foto" id="foto" required/>
                        </div>
                        
                        <div class="form-group row">&nbsp;</div>
                        
                        <div class="form-group row">
                            <div class="col-md-6">
                                <%SQLS="select * from TB_MOVIMENTACAO_SEGURADOS where contrato="&request("id")&" and removido is NULL order by id desc "
                                'response.Write(SQLS)
                                'response.End()
                                set cad=conexao.execute(SQLS)
                                if not cad.eof then
                                    ult_mes_enviado=cad("vigencia")
                                    mes_a_ser_enviado=dateadd("m",1,ult_mes_enviado)
                                end if
                                set cad=nothing%>
                                <%if ult_mes_enviado<>"" then%>
                                <div class="alert alert-warning">
                                    <p>
                                        Seu ultimo envio foi referente a: <%ult=split(ult_mes_enviado,"-")%>
                                        <strong><%response.Write(ult(1)&"/"&ult(0))%></strong>
                                    </p>
                                    <p>
                                        A planilha a ser enviada hoje deverá ser referente a: 
                                        <%prox=year(mes_a_ser_enviado)&"-"&AcrescentaZero(month(mes_a_ser_enviado))%>
                                        <strong><%response.Write(month(mes_a_ser_enviado)&"/"&year(mes_a_ser_enviado))%></strong>
                                    </p>
                                </div>
                                <%end if%>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-6">
                                <label class="col-form-label" for="email">
                                    Planilha referente a:
                                </label>
                                <input type="month" name="vigencia" id="vigencia" min="<%=prox%>" value="<%=prox%>" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            &nbsp;
                        </div>
                        <div class="form-group row">
                            &nbsp;
                        </div>
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar
                                </button>
                            </div>
                        </div>
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                    	<p class="card-title-desc">
                            <h4 class="mb-0">Últimos envios</h4>
                        </p>
                        <div class="col-12 text-left">
                            <%
                            
                            SQLS="select top 5 * from TB_MOVIMENTACAO_SEGURADOS where contrato='"&request("id")&"' order by id desc "
                            'response.Write(SQLS)
                            'response.End()
                            set cad=conexao.execute(SQLS)%>
                            
                            <table class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                <thead>
                                <tr>
                                    <th>Por</th>
                                    <th>Enviado em</th>
                                    <th>Contrato</th>
                                    <th>Arquivo</th>
                                    <th>Referencia</th>
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
                </div>
            </div>
        </div>
       
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

    
                