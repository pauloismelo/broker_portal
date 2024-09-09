<!doctype html>
<html lang="pt-BR">

    <!--#include file="head.asp"-->
    <body onLoad="Carregahora(); Carregarelogio('<%=entradax%>');">
        <div id="layout-wrapper">
            
            <!--#include file="header.asp"-->
            <!--#include file="sidebar.asp"-->

            <div class="main-content">
				<%if request("go")="perfil" then%>
                	<!--#include file="perfil.asp"-->
                <%elseif request("go")="contratos" then%>
                	<!--#include file="contratos.asp"-->
                <%elseif request("go")="contratos_transferencia" then%>
                	<!--#include file="contratos_transferencia.asp"-->
                <%elseif request("go")="contratos_subfatura" then%>
                	<!--#include file="contratos_subfatura.asp"-->
                <%elseif request("go")="contratos_subfatura-view" then%>
                	<!--#include file="contratos_subfatura-view.asp"-->
				<%elseif request("go")="contrato" then%>
                	<!--#include file="contrato.asp"-->
                <%elseif request("go")="contrato_transferencia" then%>
                	<!--#include file="contrato_transferencia.asp"-->
                <%elseif request("go")="contrato_ativos" then%>
                	<!--#include file="contrato_ativos.asp"-->
                    
                <%elseif request("go")="inclusao_titular" then%>
                	<!--#include file="inclusao_titular.asp"-->
                <%elseif request("go")="inclusao_dependente" then%>
                	<!--#include file="inclusao_dependente.asp"-->
                <%elseif request("go")="inclusao_dependente2" then%>
                	<!--#include file="inclusao_dependente2.asp"-->
                <%elseif request("go")="inclusao_pergunta" then%>
                	<!--#include file="inclusao_pergunta.asp"-->
                <%elseif request("go")="inclusao_pergunta2" then%>
                	<!--#include file="inclusao_pergunta2.asp"-->
                <%elseif request("go")="inclusao_finaliza" then%>
                	<!--#include file="inclusao_finaliza.asp"-->
                <%elseif request("go")="exclusao" then%>
                	<!--#include file="exclusao.asp"-->
                <%elseif request("go")="exclusao_finaliza" then%>
                	<!--#include file="exclusao_finaliza.asp"-->

                <%elseif request("go")="transferencia" then%>
                	<!--#include file="transferencia.asp"-->
                    
                <%elseif request("go")="movimentacoes" then%>
                	<!--#include file="consultar_movimentacoes.asp"-->
                 <%elseif request("go")="movimentacoes_vida" then%>
                	<!--#include file="consultar_movimentacoes_vida.asp"-->
                    
                <%elseif request("go")="documentos" then%>
                	<!--#include file="documentos.asp"-->
                <%elseif request("go")="informativos" then%>
                	<!--#include file="informativos.asp"-->
                <%elseif request("go")="docboleto" then%>
                	<!--#include file="docboleto.asp"-->
                <%elseif request("go")="docfatura" then%>
                	<!--#include file="docfatura.asp"-->
                <%elseif request("go")="doccopart_relatorio" then%>
                	<!--#include file="doccopart_relatorio.asp"-->
                <%elseif request("go")="doccopart_boleto" then%>
                	<!--#include file="doccopart_boleto.asp"-->
                <%elseif request("go")="docnf" then%>
                	<!--#include file="docnf.asp"-->
                <%elseif request("go")="dicassaude" then%>
                	<!--#include file="dicassaude.asp"-->
                    
                <%elseif request("go")="indique_compacta" then%>
                	<!--#include file="indique_compacta.asp"-->
                <%elseif request("go")="indique_medicos" then%>
                	<!--#include file="indique_medicos.asp"-->
                <%elseif request("go")="indique_dentistas" then%>
                	<!--#include file="indique_dentistas.asp"-->
                <%elseif request("go")="ocorrencia" then%>
                	<!--#include file="ocorrencia_list.asp"-->
                    
                <%elseif request("go")="downgrade" then%>
                	<!--#include file="downgrade.asp"-->
                <%elseif request("go")="upgrade" then%>
                	<!--#include file="upgrade.asp"-->
                <%elseif request("go")="trocafilial" then%>
                	<!--#include file="trocafilial.asp"-->
                <%elseif request("go")="movimentacao_finaliza" then%>
                	<!--#include file="movimentacao_finaliza.asp"-->
                    
                <%elseif request("go")="boleto" then%>
                	<!--#include file="boleto.asp"-->
                <%elseif request("go")="carteira" then%>
                	<!--#include file="carteira.asp"-->
                    
                <%elseif request("go")="cotacao" then%>
                	<!--#include file="cotacao.asp"-->
                <%elseif request("go")="cotacao_vida" then%>
                	<!--#include file="cotacao_vida.asp"-->
                <%elseif request("go")="cotacao_odonto" then%>
                	<!--#include file="cotacao_odonto.asp"-->
                <%elseif request("go")="contratos_segurovida" then%>
                	<!--#include file="contratos_segurovida.asp"-->
                <%elseif request("go")="contratos_segurovida_form" then%>
                	<!--#include file="contratos_segurovida_form.asp"-->
                    
                <%elseif request("go")="acessos" then%>
                	<!--#include file="acessos.asp"-->
                <%elseif request("go")="usuarios" then%>
                	<!--#include file="usuarios.asp"-->
                    
                <%elseif request("go")="meusdados" then%>
                	<!--#include file="meusdados.asp"-->
                <%elseif request("go")="cadastro" then%>
                	<!--#include file="cadastro.asp"-->
                <%elseif request("go")="senha" then%>
                	<!--#include file="senha.asp"-->
                <%elseif request("go")="subfaturas" then%>
                	<!--#include file="subfaturas.asp"--> 
                <%elseif request("go")="ocorrencia_anexos" then%>
                	<!--#include file="ocorrencia_anexos.asp"-->
                <%elseif request("go")="kit_faturamento" then%>
                	<!--#include file="kit_faturamento.asp"-->
                <%end if%>

                <!--#include file="footer.asp"-->
            </div>
        </div>


        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        
        <!-- JAVASCRIPT -->
        <%if request("go")<>"contrato_ativos" then%>
        <script src="assets\libs\jquery\jquery.min.js"></script>
        <%end if%>
        <script src="assets\libs\bootstrap\js\bootstrap.bundle.min.js"></script>
        <script src="assets\libs\metismenu\metisMenu.min.js"></script>
        <script src="assets\libs\simplebar\simplebar.min.js"></script>
        <script src="assets\libs\node-waves\waves.min.js"></script>
        <script src="assets\libs\waypoints\lib\jquery.waypoints.min.js"></script>
        <script src="assets\libs\jquery.counterup\jquery.counterup.min.js"></script>
		
        <!-- Required datatable js -->
		<script src="assets\libs\datatables.net\js\jquery.dataTables.min.js"></script>
        <script src="assets\libs\datatables.net-bs4\js\dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="assets\libs\datatables.net-buttons\js\dataTables.buttons.min.js"></script>
        <script src="assets\libs\datatables.net-buttons-bs4\js\buttons.bootstrap4.min.js"></script>
        
        <script src="assets\libs\jszip\jszip.min.js"></script>
        <script src="assets\libs\pdfmake\build\pdfmake.min.js"></script>
        <script src="assets\libs\pdfmake\build\vfs_fonts.js"></script>
        <script src="assets\libs\datatables.net-buttons\js\buttons.html5.min.js"></script>
        <script src="assets\libs\datatables.net-buttons\js\buttons.print.min.js"></script>
        <script src="assets\libs\datatables.net-buttons\js\buttons.colVis.min.js"></script>
        
        <!-- Responsive examples -->
        <script src="assets\libs\datatables.net-responsive\js\dataTables.responsive.min.js"></script>
        <script src="assets\libs\datatables.net-responsive-bs4\js\responsive.bootstrap4.min.js"></script>
        
        <!-- Datatable init js -->
        <script src="assets\js\pages\datatables.init.js"></script>
        
        <!-- form mask -->
        <script src="assets\libs\inputmask\min\jquery.inputmask.bundle.min.js"></script>
        <!-- form mask init -->
        <script src="assets\js\pages\form-mask.init.js"></script>

        <!-- Plugins js -->
        <%if request("go")="ocorrencia_anexos" then%>
        <script src="assets\libs\dropzone\dropzone_ocorrencia.js"></script>
        <%else%>
        <script src="assets\libs\dropzone\dropzone.js"></script>
        <%end if%>
        
        <!-- Magnific Popup-->
        <script src="assets\libs\magnific-popup\jquery.magnific-popup.min.js"></script>

        <!-- lightbox init js-->
        <script src="assets\js\pages\lightbox.init.js"></script>
        
        <script src="assets\js\app.js"></script>
        
        <script src="assets\js\moment.js" type="text/javascript"></script>
        
        <script>
		$('.carousel').carousel()
		</script>

    </body>
</html>
