<!doctype html>
<html lang="pt-BR">


    <!--#include file="head.asp"-->
    <%
	'response.Write("Operadora: "&operadorax&"<br>")
	boxop=split(nome_operadorax,",")
	for w=0 to ubound(boxop)
		if sqlop<>"" then
			sqlop=sqlop&" or  CHARINDEX('"&boxop(w)&"', operadoras)>0"
		else
			sqlop=" where  CHARINDEX('"&boxop(w)&"', operadoras)>0"
		end if
	next
	
	'response.Write("select * from INFORMATIVOS_DEMAN "&sqlop&" order by id desc ")
	'response.End()
	set ppo=conexao.execute("select * from INFORMATIVOS_DEMAN "&sqlop&" order by id desc ")
	if not ppo.eof then
	%>
    <div class="modal fade bd-example-modal-lg" id="modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          	
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
              <ol class="carousel-indicators">
              	<%x=0
				while not ppo.eof
				'if ppo("foto")<>"nenhum" then%>
                <li data-target="#carouselExampleIndicators" data-slide-to="<%=x%>" <%if x=0 then%>class="active"<%end if%>></li>
                <%x=x+1
				'end if
				ppo.movenext
				wend%>
              </ol>
              <div class="carousel-inner">
                <%set ppo2=conexao.execute("select * from INFORMATIVOS_DEMAN "&sqlop&" order by id desc ")
				y=0
				while not ppo2.eof
					if ppo2("foto")<>"" then%>
						<div class="carousel-item <%if y=0 then%>active<%end if%>">
						  <img class="d-block w-100" src="https://www.compactabh.com.br/siscad/INFORMATIVOS_DEMAN/<%=replace(ppo2("foto")," ","%20")%>" alt="First slide">
						</div>
						<%
					else%>
						<div class="carousel-item <%if y=0 then%>active<%end if%>" style="background:url(img/fundoazul.png); height:450px; text-align:center">
						  <h1 style="color:#FFF;">INFORMATIVOS</h1>
                          <br>
                          <h2 style="color:#FFF;"><%=ppo2("titulo")%></h2>
                          <br>
                          <p style="color:#FFF;"><%=ppo2("texto")%></p>
						</div>
					<%end if
				y=y+1
				ppo2.movenext
				wend%>
                
              </div>
              <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
              </a>
              <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
              </a>
            </div>
            
        </div>
      </div>
    </div>
    <%end if
	set ppo=nothing%>
	
    

    <!--  Small modal example -->
    <div class="modal fade bs-example-modal-sm" id="ModalRelogio" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h5 class="modal-title mt-0" id="mySmallModalLabel">SEU TEMPO ESTÁ ACABANDO</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <p><i class="far fa-clock fa-3x"></i></p>
                    <p class="mb-0">Selecione uma opção abaixo:</p>
                </div>
                <div class="modal-footer">
                    <a href="renovarprazo.asp">
                    <button type="button" class="btn btn-success waves-effect">Renovar Prazo</button>
                    </a>
                    <a href="close.asp">
                    <button type="button" class="btn btn-danger waves-effect waves-light">Sair do sistema</button>
                    </a>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    
    <body onLoad="Carregahora(); Carregarelogio('<%=entradax%>');">

    <!-- <body data-layout="horizontal" data-topbar="colored"> -->

        <!-- Begin page -->
        <div id="layout-wrapper">
            <!--#include file="header.asp"-->
            
            <!-- ========== Left Sidebar Start ========== -->
            <!--#include file="sidebar.asp"-->
            <!-- Left Sidebar End -->

            

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">                    	

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-flex align-items-center justify-content-between">
                                    <h4 class="mb-0">Portal do Cliente</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                                            <li class="breadcrumb-item active">Painel</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            
							<!--#include file="index_bemvindo.asp"-->
                            <!--#include file="index_indicativos.asp"-->
                        </div> <!-- end row -->
                        <div class="row">
                        	<!--#include file="index_contrato.asp"-->
                        </div>

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
        
        <script>
		$('#modal').modal(options)
		$('.carousel').carousel()
		</script>
        

    </body>

</html>