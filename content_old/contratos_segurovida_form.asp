<%
function MesPt(x)
    if x="January" then
        mes="Janeiro"
    elseif x="February" then
        mes="Fevereiro"
    elseif x="March" then
        mes="Março"
    elseif x="April" then
        mes="Abril"
    elseif x="May" then
        mes="Maio"
    elseif x="June" then
        mes="Junho"
    elseif x="July" then
        mes="Julho"
    elseif x="August" then
        mes="Agosto"
    elseif x="September" then
        mes="Setembro"
    elseif x="October" then
        mes="Outubro"
    elseif x="November" then
        mes="Novembro"
    elseif x="December" then
        mes="Dezembro"
    end if  

    MesPt=mes
end function
if request("envio")="email" then
AbreConexao
    set con=conexao.execute("select id,idcadastro,ramo,segmento,operadora from CADASTROGERAL_VENDAS where id="&request("contrato")&" ")
    if not con.eof then
        contrato=con("ramo")&"."&con("segmento")&""&con("operadora")
        set cad=conexao.execute("select * from CADASTROGERAL where id="&con("idcadastro")&" ")
        if not cad.eof then
            cadastro=cad("titular")
        end if
        set cad=nothing
    end if
    set con=nothing

    sch = "http://schemas.microsoft.com/cdo/configuration/"
    Set cdoConfig = Server.CreateObject("CDO.Configuration")
    servidor_smtp = "mail.portalcompacta.com.br" 
    email_autentica = "noreply@portalcompacta.com.br" 
    senha_autentica = "7^5pey0B" 
    cdoConfig.Fields.Item(sch & "sendusing") = 2
    cdoConfig.Fields.Item(sch & "smtpauthenticate") = 1
    cdoConfig.Fields.Item(sch & "smtpserver") = servidor_smtp
    cdoConfig.Fields.Item(sch & "smtpserverport") = 587
    cdoConfig.Fields.Item(sch & "smtpconnectiontimeout") = 30
    cdoConfig.Fields.Item(sch & "sendusername") = email_autentica
    cdoConfig.Fields.Item(sch & "sendpassword") = senha_autentica
    cdoConfig.fields.update
    Set myMail=CreateObject("CDO.Message") 
    Set myMail.Configuration = cdoConfig
    myMail.Fields.update
    myMail.Subject="VIDA - REENVIO DE MOVIMENTACAO"
    myMail.From="COMPACTA SAUDE <"&email_autentica&">"
    myMail.To="seguros@compactaseguros.com"
    myMail.bcc="pauloisaquecpd@hotmail.com"
    myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#000000><tr><td>Prezado CESEG,<br><Br> o(a) usuario(a) "&userxy&" tentou reenviar uma movimentacao de Seguro Vida no Portal do Cliente.<br><br>Cliente: <strong>"&cadastro&"</strong><br>Contrato: <strong>"&contrato&"</strong><br>Vigencia: <strong>"&request("vigencia")&"</strong><br>Motivo do reenvio: <strong>"&request("motivo")&"</strong></td></tr> <tr><td ><br>Avalie essa situação e se for preciso, entre em contato com o cliente para orienta-lo.<br><br>Para liberar um novo envio, basta anular a movimentaçao atual.<br><br></td></tr> <tr><td bgcolor=#FFFFFF><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></td></tr></table></center></body>"
        
                                        
    myMail.Send 										
                                                    
    set myMail=nothing 
    Set cdoConfig = Nothing

    protocolo=year(now)&""&month(now)&""&day(now)&""&hour(now)&""&minute(now)&""&second(now)

    set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS order by id desc")
    if rs.eof then
        idz=1
    else
        idz=rs("id")+1
    end if
    set rs=nothing

    Sql = "INSERT INTO PORTALCLIENTE_OCORRENCIAS (id, id_cliente, usuario, tipo, titulo, descricao, datareg, status, id_contrato, celula, id_movimentacao, protocolo) VALUES ("&idz&", "&idx&", '"&userxy&"', 'MOVIMENTACAO', 'REENVIO DE MOVIMENTACAO SEGURO DE VIDA', '"&request("motivo")&"', '"&databrx2(date)&" "&time&"', 'ABERTO', "&request("contrato")&", 'SEGUROS', 0, '"&protocolo&"' )"
    'response.Write("<br><br><br>"&Sql)
    conexao.Execute(Sql)

FechaConexao
response.Write("<script>alert('Sua informacao foi enviada para a Compacta Seguros.\nFavor acompanhar no link ocorrencias.');</script>")
response.Write("<script>window.location='painel.asp?go=contratos_segurovida';</script>")
end if%>


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
							<%if cad("nome_amigavel")<>"" then%> . <%=cad("nome_amigavel")%>
                            <%end if%><BR />
							
							Data corte - Inclus&atilde;o: <%=cad("diafaturamento_inclusao")%><br>
							Data corte - Exclus&atilde;o: <%=cad("diafaturamento_exclusao")%><br>
							Dia de vencimento do boleto: <%=cad("vencimento")%><br />
							Tipo de cobrança: <%=cad("tipocobranca_inclusao")%><br />
							Dia de emissao da fatura: <%=cad("data_emissao_fatura")%><br />
                        </p>
                        <p class="card-title-desc  text-danger">
                            ATENÇÃO:<br>Somente estarão cobertos os usuários relacionados na planilha de segurados.<br>Não se esqueça de incluir os funcionários afastados.
                        </p>
                        <!-- //////// ETAPA 1 /////// -->
                        <form action="painel.asp?go=contratos_segurovida_form" method="post">
                        <input type="hidden" name="id" value="<%=request("id")%>">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <label class="col-form-label" for="email">
                                    Planilha referente a:
                                </label>
                                <input type="month" name="vigencia" id="vigencia" min="<%=prox%>" value="<%=request("vigencia")%>" required/>
                            </div>
                        </div>
                        <div class="form-group row mb-4">
                            <div class="col-md-12">
                                <button class="btn btn-dark" type="submit">
                                    PRÓXIMA ETAPA
                                </button>
                            </div>
                        </div>
                        </form>

                        <!-- //////// ETAPA 2 /////// -->
                        <%if request("vigencia")<>"" then
                            SQLSx="select * from TB_MOVIMENTACAO_SEGURADOS where contrato="&request("id")&"  and vigencia='"&request("vigencia")&"' and removido is NULL and status<>'ANULADO' order by id desc "
                            set mov=conexao.execute(SQLSx)
                            if not mov.eof then%>
                                <div class="alert alert-danger text-left">
                                    <form action="painel.asp?go=contratos_segurovida_form" method="post">
                                    <input type="hidden" name="envio" value="email">
                                    <input type="hidden" name="empresa" value="<%=titularx%>">
            			            <input type="hidden" name="contrato" value="<%=request("id")%>" />
                                    <input type="hidden" name="vigencia" value="<%=request("vigencia")%>" />

                                    <h5 class="text-danger">2ª Etapa</h5>
                                    <hr>
                                    <%vigencia=split(request("vigencia"),"-")%>
                                    <strong>ATENÇÃO! <br>A movimentação referente a <%=MesPt(monthname(vigencia(1)))%> de <%=vigencia(0)%> foi enviada no dia <%=databrx3(mov("datareg"))%> pelo usuário(a) <%=mov("userreg")%>.</strong>
                                    <br />
                                    <br />
                                    <strong>
                                        Por qual motivo você deseja reenviar essa movimentacão?<br>
                                    </strong>

                                    <select name="motivo" class="form-control">
                                        <option value="">Selecione...</option>
                                        <option value="CORRIGIR DADOS ENVIADOS ERRADO">CORRIGIR DADOS ERRADOS</option>
                                        <option value="INCLUIR FUNCIONARIO RECEM ADMITIDO">INCLUIR FUNCIONARIO RECEM ADMITIDO</option>
                                    </select>
                                    <br>
                                    <br>
                                    <button class="btn btn-danger" type="submit">
                                        ENVIAR
                                    </button>
                                    </form>
                                </div>
                            <%else%>
                                <div class="alert alert-dark text-left">
                                    <h5>2ª Etapa</h5>
                                    <hr>
                                    <form action="movimentacao_segurados_upload.asp" method="post" enctype="multipart/form-data" name="form01">
                                    <input type="hidden" name="empresa" value="<%=titularx%>">
                                    <input type="hidden" name="contrato" value="<%=request("id")%>" />
                                    <input type="hidden" name="vigencia" value="<%=request("vigencia")%>" />
                                    <input type="hidden" name="reenvio" id="reenvio" value="-"/>

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
                                    
                                    
                                    
                                    <div class="form-group row" id="planilha">
                                        <label class="col-md-12 col-form-label" for="foto">
                                            Anexe a planilha contendo a movimenta&ccedil;&atilde;o atual. Não esquecer os segurados afastados.
                                            <br>Favor nomear o arquivo da seguinte maneira: VIDA_NOMEDAEMPRESA_MESANO.xls (nome abreviado ou nome fantasia)
                                        </label>
                                        <input type="file" name="foto" id="foto" required/>
                                    </div>

                                    <div class="form-group row">&nbsp;</div>

                                    <label class="row">Caso NÃO haja movimentação(inclusão ou exclusão de funcionário) para esse mês, marque a opção abaixo:&nbsp;&nbsp;</label>
                                    <div class="row">
                                        <div class="col-12 text-left">
                                            <input type="checkbox" name="ausente2" id="ausente2" onclick="Altera(this.value);" />&nbsp;Favor emitir o faturamento com os mesmos segurados do mês anterior, pois não há movimentação de usuários para esse mês.
                                        </div>
                                    </div>
                                    <input type="hidden" name="ausente" id="ausente" />
                                    <div class="form-group row">&nbsp;</div>
                                    
                                    <div class="form-group row">
                                        <button class="btn btn-dark" type="submit">
                                            ENVIAR
                                        </button>
                                    </div>
                                    </form>
                                </div>
                            <%end if
                            set mov=nothing%>

                        <%end if%>

						
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
                                                    <%=databrx3(cad("datareg"))%> <br /> <%=hour(cad("datareg"))%>:<%=minute(cad("datareg"))%>
                                                </td>
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

    
                