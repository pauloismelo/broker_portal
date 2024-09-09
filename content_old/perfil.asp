

                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-flex align-items-center justify-content-between">
                                    <h4 class="mb-0">Meu perfil</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Inicio</a></li>
                                            <li class="breadcrumb-item active">Meu perfil</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                        <%AbreConexao
						set us=conexao.execute("select * from CADASTROGERAL_USUARIOS where id="&idxy&"")%>

                        <div class="row mb-4">
                            <div class="col-xl-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="text-center">
                                            <div class="dropdown float-right">
                                                <a class="text-body dropdown-toggle font-size-18" href="#" role="button" data-toggle="dropdown" aria-haspopup="true">
                                                  <i class="uil uil-ellipsis-v"></i>
                                                </a>
                                              
                                                <div class="dropdown-menu dropdown-menu-right">
                                                    <a class="dropdown-item" href="#">Alterar Dados</a>
                                                    
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div>
                                                <img src="assets\images\users\user.png" alt="" class="avatar-lg rounded-circle img-thumbnail">
                                            </div>
                                            <h5 class="mt-3 mb-1"><%=titularx%></h5>
                                            <p class="text-muted">&nbsp;</p>

                                            
                                        </div>

                                        <hr class="my-4">

                                        <div class="text-muted">
                                        
                                            
                                            <div class="table-responsive mt-4">
                                                <div>
                                                    <p class="mb-1">Usuário :</p>
                                                    <h5 class="font-size-16"><%=userxy%></h5>
                                                </div>
                                                <div>
                                                    <p class="mb-1">Email :</p>
                                                    <h5 class="font-size-16"><%=emailx%></h5>
                                                </div>
                                                <div class="mt-4">
                                                    <p class="mb-1">Cargo na empresa :</p>
                                                    <h5 class="font-size-16"><%=us("cargo")%></h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-8">
                                <div class="card mb-0">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#about" role="tab">
                                                <i class="fas fa-people-arrows font-size-20"></i>
                                                <span class="d-none d-sm-block">Movimentações</span> 
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#ocorrencia" role="tab">
                                                <i class="fas fa-comment-dots font-size-20"></i>
                                                <span class="d-none d-sm-block">Ocorrências</span> 
                                            </a>
                                        </li>
                                        
                                    </ul>
                                    <!-- Tab content -->
                                    <div class="tab-content p-4">
                                        <div class="tab-pane active" id="about" role="tabpanel">
                                            <div>
                                                

                                                <div class="col-xl-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <h4 class="card-title mb-4">Movimentações <small> *ultimos 6 meses</small></h4>
                                                            
                                                            <div id="column_chart" class="apex-charts" dir="ltr"></div>                                      
                                                        </div>
                                                    </div><!--end card-->
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="tab-pane" id="ocorrencia" role="tabpanel">
                                            <div>
                                                
												<%set oc=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id_cliente="&idx&" order by id desc")%>
                                                <h5 class="font-size-16 mb-4">Ocorrências</h5>

                                                    <div class="table-responsive">
                                                        <table class="table table-nowrap table-hover mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">Tipo</th>
                                                                    <th scope="col">Descricao</th>
                                                                    <th scope="col">Abertura</th>
                                                                    <th scope="col">Status</th>
                                                                    <th scope="col" style="width: 120px;">Usuário</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            	<%if not oc.eof then
																while not oc.eof%>
                                                                <tr>
                                                                    <th scope="row"><%=oc("tipo")%></th>
                                                                    <td><a href="#" class="text-dark"><%=oc("descricao")%></a></td>
                                                                    <td>
                                                                        <%=databrx3(oc("datareg"))%>
                                                                    </td>
                                                                    <td>
                                                                    	<%if oc("status")="RESOLVIDA" or oc("status")="CONCLUIDO" then%>
                                                                        <span class="badge badge-soft-success font-size-12"><%=oc("status")%></span>
                                                                        <%elseif oc("status")="RESPONDIDO"  then%>
                                                                        <span class="badge badge-soft-primary font-size-12"><%=oc("status")%></span>
                                                                        <%elseif oc("status")="EM TRATAMENTO"  then%>
                                                                        <span class="badge badge-soft-warning font-size-12"><%=oc("status")%></span>
                                                                        <%end if%>
                                                                       
                                                                    </td>
                                                                    <td>
                                                                        <%=oc("usuario")%>
                                                                    </td>
                                                                </tr>
                                                                <%oc.movenext
																wend
																else%>
                                                                <tr>
                                                                    <th scope="row" colspan="5" align="center">Nenhuma ocorrência encontrada!</th>
                                                                </tr>
                                                                <%end if%>
                                                                
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <%set oc=nothing%>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                        <%set us=nothing
						
						
						for i=0 to 5
							mesatual=month(dateadd("m",-i, date))
							anoatual=year(dateadd("m",-i, date))
							set rs=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and tipo='INCLUSAO' and month(datareg)='"&mesatual&"' ")
							if not rs.eof then
								if inc<>"" then
									inc=inc&","&rs("total")
								else
									inc=rs("total")
								end if
							end if
							set rs=nothing
							
							set rs2=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and tipo='EXCLUSAO' and month(datareg)='"&mesatual&"' ")
							if not rs2.eof then
								if inc<>"" then
									exc=exc&","&rs2("total")
								else
									exc=rs2("total")
								end if
							end if
							set rs2=nothing
							
							'response.Write(mesatual&"<br>")
							if meses<>"" then
								meses=meses&", '"&left(monthname(mesatual),3)&"/"&anoatual&"'"
							else
								meses="'"&left(monthname(mesatual),3)&"/"&anoatual&"'"
							end if
						next
						FechaConexao%>
                        
                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->


            <!-- apexcharts -->
        <script src="assets\libs\apexcharts\apexcharts.min.js"></script>

        <script>
		
			var options={chart:{height:350,type:"bar",toolbar:{show:!1}},
				plotOptions:{bar:{horizontal:!1,columnWidth:"45%",endingShape:"rounded"}},
				dataLabels:{enabled:!1},
				stroke:{show:!0,width:2,colors:["transparent"]},
				series:[
						{name:"Inclusões",data:[<%=inc%>]},
						{name:"Exclusões ",data:[<%=exc%>]}
						],
				colors:["#5b8ce8","#CC0000"],
				xaxis:{categories:[<%=meses%>]},
				yaxis:{title:{text:"$ (thousands)"}},
				grid:{borderColor:"#f1f1f1"},
				fill:{opacity:1},
				tooltip:{y:{formatter:function(e){return" "+e+" "}}}};
				(chart=new ApexCharts(document.querySelector("#column_chart"),options)).render();
		</script>    