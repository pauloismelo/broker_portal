<div class="page-content">
    <div class="container-fluid">

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <%AbreConexao
						set rs=conexao.execute("select * from PORTALCLIENTE_OCORRENCIAS where id="&request("id")&"")%>
                        <h4 class="card-title">Insira os documentos referentes a essa ocorrência </h4>
                        <p class="card-title-desc">Título: <strong><%=rs("titulo")%></strong><br>
                        Tipo: <strong><%=rs("tipo")%></strong><br>
                        Status: <strong><%=rs("status")%></strong>
                        </p>
                        
                        <div class="row">
                        	<div class="col-6">
                            	<div>
                                <form action="uploadocorrencia.php" class="dropzone" id="my-awesome-dropzone" method="post">
                                <input type="hidden" name="id" value="<%=request("id")%>">
                                    <div class="fallback">
                                        <input name="arquivos[]" type="file" multiple="multiple">
                                    </div>
                                    <div class="dz-message needsclick">
                                        <div class="mb-3">
                                            <i class="display-4 text-muted uil uil-cloud-upload"></i>
                                        </div>
                                        
                                        <h4>Para fazer o upload, arraste os arquivos para esse espaço.</h4>
                                    </div>
                                </form>
                        		</div>
                            </div>
                            
                            <div class="col-6">
                            <%Set objFS = Server.CreateObject("Scripting.FileSystemObject")
							folder=caminho&"docs_ocorrencia\"&request("id")
							'response.Write(folder)
							'response.End()
							nfiles=0
							if objFS.FolderExists(folder)=true then
							else
								objFS.CreateFolder(folder)
							end if
							%>         
							<%if objFS.FolderExists(folder) then
							
								Set fs = server.CreateObject("Scripting.FileSystemObject") 
								Set pasta = fs.GetFolder(folder) %>
								   <ul>
									<%FOR EACH file IN pasta.Files %>
									<%nfiles=nfiles+1%>
										<div class="media align-items-center bg-white ui-bordered py-3 mb-2">
											<a href="javascript:void(0)" class="d-block ui-w-100 mr-4">
												<%if file.Type="PNG image" or file.Type="JPEG image" then%>
													<img src="../DOCS_OCORRENCIA/<%=request("id")%>/<%=file.name%>" width="180">
												<%else%>
												<I class="fas fa-file fas-2x"></I>
												<%end if%>
											</a>
											<div class="media-body">
												<strong>Arquivo: </strong> <%=file.name%>
											</div>
										</div>
									<%NEXT%>
								   </ul>
								  <%if nfiles=0 then
								  response.Write("Nenhum arquivo encontrado!")
								  end if%>
							
							<%end if%>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->