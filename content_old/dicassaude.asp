

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Dicas de Saúde</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Início</a></li>
                            <li class="breadcrumb-item active">Dicas de Saúde</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <%		
		sqlz="select * from sTB_ARTIGOS where categoria='PORTALCLIENTE_DICASSAUDE' order by titulo asc "
				
		set rs=conexao.execute(sqlz)%>

                
                <div class="row" style="margin-bottom:5%;">
                    
                    <%if rs.eof then%>
                    <div class="alert alert-danger col-xl-12 text-center" role="alert">
                        Nenhum documento encontrado para esse contrato
                    </div>
                     <%else
					 while not rs.eof%>
                     	
                        <div class="col-md-6 col-xl-3">
                            <!-- Simple card -->
                            <div class="card text-center" >
                                <%if rs("foto")="nenhum" then%>
									sem foto
								<%else%>
									<%extensao=split(rs("foto"),".")
									'response.Write(extensao(1))
									if lcase(extensao(1))="pdf"  then%>
										<a href="http://www.<%=rs("site")%>/artigos/<%=rs("foto")%>" target="_blank" class="tre18-0099ff">
										<i class="fas fa-file-pdf fa-3x"></i>
										</a>
									<%elseif lcase(extensao(1))="doc" or lcase(extensao(1))="docx" then%>
					  					<a href="http://www.<%=rs("site")%>/artigos/<%=rs("foto")%>" target="_blank" class="tre18-0099ff">
										<i class="fas fa-file-word fa-3x"></i>
										</a>
									<%else%>
										
                                        <a class="image-popup-vertical-fit" href="https://www.compactasaude.com.br/artigos/<%=rs("foto")%>">
										<img class="card-img-top img-fluid" src="https://www.compactasaude.com.br/artigos/<%=rs("foto")%>" style="max-height:220px; width:auto;">
										</a>
									<%end if%>
								<%end if%>
                                
                                
                                <div class="card-body">
                                    <h4 class="card-title mt-0"><%=ucase(rs("titulo"))%></h4>
                                </div>
                            </div>
                        </div><!-- end col -->
                     
                     <%rs.movenext
					 wend
					 end if%>
                    
                    
                </div>
            <!-- end row -->
        <%set rs=nothing%>

        
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                