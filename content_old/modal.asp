<!doctype html>
<html lang="pt-BR">


    <!--#include file="head.asp"-->
    

   
    
    
    <body">

    <!-- <body data-layout="horizontal" data-topbar="colored"> -->

        <!-- Begin page -->
        <div id="layout-wrapper">

            
            

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">                    	

                        <%AbreConexao
						set rs=conexao.execute("select * from CADASTROGERAL where id="&request("id")&"")
						if not rs.eof then%>
                        <div class="row">
							<h5 class="font-size-16">Dados do Beneficiário</h5>
                        </div>
                        <div class="row">
                            <p>
                            Status: <strong style="font-size:12px; font-weight:bold; color:#003366;"><%if rs("status2")="NAO" then%>EXCLUIDO<%else%><%=rs("status2")%><%end if%></strong><br />
                            <%if rs("edependente")="s" then
                                  set dep=conexao.execute("select * from CADASTROGERAL where id="&rs("iddependente")&"")
                                  if not dep.eof then%>
                                  Tipo: <strong>Dependente de <%=dep("titular")%></strong><br />
                                  
                                  <%end if
                                  set dep=nothing
                              else%>
                              Tipo: <strong>Titular</strong><br />
                              <%end if%>
                              Nome: <strong style="font-size:12px; font-weight:bold; color:#003366;"><%=rs("titular")%></strong><br />
                              CPF: <strong><%=rs("cpf")%></strong><br />
                              Carteirinha: <strong><%=rs("codigo")%></strong><br />
                              Vigência: <strong><%=databrx3(rs("datavigencia"))%></strong><br />
                              Carência: <strong><%=rs("reducaocarencia")%></strong><br />
                              Sexo: <strong><%=rs("sexo")%></strong><br />
                              <%if rs("edependente")="s" then%>
                                  Parentesco: <strong><%=rs("parentesco")%></strong><br />
                              <%else%>
                                    Estado Civil: <strong><%=rs("ecivil")%></strong><br />
                              <%end if%>
                              Celular: <strong><%=rs("celular")%></strong><br />
                              Email: <strong><%=rs("email")%></strong><br />
                              Endereço: <strong><%=rs("endereco")%>, <%=rs("numero")%><BR /><%=rs("bairro")%> - <%=rs("cidade")%>/<%=rs("estado")%></strong><br />
                              <%if rs("etitular")="s" then%>
                              Data de admissão funcional: <strong><%=databrx3(rs("dataadmissao"))%></strong><br />
                              <%end if%>
                              </p>
                         </div>
                         <div class="row">
                              <h5 class="font-size-16">Plano Contratado</h5>
                        </div>
                        <div class="row">
                              <p>
                              <%set em=conexao.execute("select * from CADASTROGERAL_VENDAS where id='"&rs("coproduto")&"' or id='"&rs("idcadvenda")&"'")%>
                              <%if not em.eof then%>
                              Contrato: <strong><%=em("ramo")%> . <%=em("operadora")%></strong><br />
                              <%if rs("edependente")="s" then
                                  if isnumeric(rs("redecontratada")) then%>
                                    <%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&rs("redecontratada")&"")
                                    if not pla.eof then%>
                                        Plano: <strong><%=pla("nome")%></strong><br />
                                        Acomodacao: <strong><%=pla("acomodacao")%></strong><br />
                                    <%end if
                                    set pla=nothing%>
                                <%else%>
                                    Plano: <strong></strong><br />
                                    Acomodacao: <strong><%=rs("acomodacao")%></strong><br />
                                <%end if
                              else%>
                                <%if isnumeric(rs("redecontratada")) then%>
                                    <%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&rs("redecontratada")&"")
                                    if not pla.eof then%>
                                        Plano: <strong><%=pla("nome")%></strong><br />
                                        Acomodacao: <strong><%=pla("acomodacao")%></strong><br />
                                    <%end if
                                    set pla=nothing%>
                                <%else%>
                                    Plano: <strong></strong><br />
                                    Acomodacao: <strong><%=rs("acomodacao")%></strong><br />
                                <%end if%> 
                              <%end if%>
                              Valor da mensalidade: <strong style="font-size:12px; font-weight:bold; color:#003366;">R$ <%=rs("vlrmensalidadeatual")%></strong>
                              </p>
                              <%set dep=conexao.execute("select * from CADASTROGERAL where iddependente="&rs("id")&" and status2='ATIVO'")
                              if not dep.eof then%>
                       		</div>
                        	<div class="row">
                            	<h5 class="font-size-16">Dependentes</h5>
                            </div>
                        	<div class="row">
                                <%while not dep.eof%>
                                    <li>
                                        Nome: <strong><%=dep("titular")%></strong><br />
                                        Carteirinha: <strong><%=dep("codigo")%></strong><br />
                                        Vigência: <strong><%=databrx3(dep("datavigencia"))%></strong><br />
                                        Carência: <strong><%=dep("reducaocarencia")%></strong><br />
                                        Mensalidade: <strong style="font-size:12px; font-weight:bold; color:#003366;">R$ <%=dep("vlrmensalidadeatual")%></strong>
                                        <br /><br />
                                    </li>
                                <%dep.movenext
                                wend%>
                              <%end if
                              set dep=nothing%>                              
                              
                              <%end if
                              set em=nothing%>
                              
                        </div> <!-- end row -->
                        <%end if
						set rs=nothing%>
                        

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->


                <!--#include file="footer.asp"-->
            </div>
            <!-- end main content-->

        </div>
        <!-- END layout-wrapper -->

        

        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        <!-- JAVASCRIPT -->
        <script src="assets\libs\jquery\jquery.min.js"></script>
        <script src="assets\libs\bootstrap\js\bootstrap.bundle.min.js"></script>
        <script src="assets\libs\metismenu\metisMenu.min.js"></script>
        <script src="assets\libs\simplebar\simplebar.min.js"></script>
        <script src="assets\libs\node-waves\waves.min.js"></script>
        <script src="assets\libs\waypoints\lib\jquery.waypoints.min.js"></script>
        <script src="assets\libs\jquery.counterup\jquery.counterup.min.js"></script>

        <!-- apexcharts -->
        <script src="assets\libs\apexcharts\apexcharts.min.js"></script>

        <script src="assets\js\pages\dashboard.init.js"></script>

        <script src="assets\js\app.js"></script>
        
        

    </body>

</html>