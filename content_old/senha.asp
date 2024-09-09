<%
if request("update")="ok" then
	AbreConexao
	set rs=conexao.execute("select * from CADASTROGERAL_USUARIOS where id="&idxy&" and senha='"&request("senhaatual")&"' and idcadastro="&idx&" ")
	if not rs.eof then
		
		if request("senha")=request("senha2") then
			AbreConexao
				conexao.execute("update cadastrogeral_usuarios set senha='"&request("senha")&"' where id="&request("id")&"")
				response.Write("<script>alert('Senha Atualizada com sucesso!');</script>")
				response.Write("<script>window.close();</script>")
			FechaConexao
		else
				response.Write("<script>alert('As novas senhas não coincidem!!\nTente novamente!');</script>")
				response.Write("<script>window.location='senha-view.asp?id="&request("id")&"';</script>")
		end if
	
	else
		response.Write("<script>alert('Senha atual incorreta!!\nTente novamente!');</script>")
		response.Write("<script>window.location='senha-view.asp?id="&request("id")&"';</script>")
	end if
	
	

end if
%>

<div class="page-content">
    <div class="container-fluid">
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Alteração de Senha</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Alteração de Senha</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
       
		
		<%set rs=conexao.execute("select * from cadastrogeral_usuarios where id="&request("id")&" and idcadastro="&idx&" ")
		if rs.eof then%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc text-center">Usuário não encontrado!</p>
                    </div>
                </div>
            </div>
        </div>
        <%else%>
        
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Atualize seus dados cadastrais abaixo, caso necessário.</p>
                        
                       
                             <form action="painel.asp?go=senha" method="post">
                             <input type="hidden" name="update" value="ok" />
                             <input type="hidden" name="id" value="<%=request("id")%>" />
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Usuário</label>
                                <div class="col-md-10"><strong><%=rs("nome")%></strong></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Login</label>
                                <div class="col-md-10"><strong><%=rs("login")%></strong></div>
                             </div>
                             <div class="form-group row">
                                &nbsp;
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Senha Atual</label>
                                <div class="col-md-10"><input type="password" class="form-control" id="senhaatual" name="senhaatual" required></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Digite uma nova senha</label>
                                <div class="col-md-10"><input type="password" class="form-control" id="senha" name="senha" required></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Repita a nova senha</label>
                                <div class="col-md-10"><input type="password" class="form-control" id="senha2" name="senha2" required></div>
                             </div>
                             
                             
                             
                             <div class="form-group row">
                                <div class="col-md-12 text-center">
                                	<button type="submit" class="btn btn-success waves-effect waves-light">
                                        <i class="uil uil-check mr-2"></i> SOLICITAR ALTERAÇÃO
                                    </button>
                                </div>
                             </div>
                             
                             </form>

                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->
        <%end if%>

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                
       

