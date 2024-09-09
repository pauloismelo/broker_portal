

<div class="page-content">
    <div class="container-fluid">
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Dados Cadastrais</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">Home</a></li>
                            <li class="breadcrumb-item active">Dados Cadastrais</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        
       
		
		<%set rs=conexao.execute("select * from cadastrogeral where id="&idx&" ")%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Confira os seus dados cadastrados</p>
                        
                       
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Nome</label>
                                <div class="col-md-10"><%=rs("titular")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">CNPJ</label>
                                <div class="col-md-10"><%=rs("cnpj")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">E-mail</label>
                                <div class="col-md-10"><%=rs("email")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Telefone</label>
                                <div class="col-md-10"><%=rs("telefone1")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Celular</label>
                                <div class="col-md-10"><%=rs("celular")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Endereço</label>
                                <div class="col-md-10"><%=rs("endereco")%>, <%=rs("numero")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Bairro</label>
                                <div class="col-md-10"><%=rs("bairro")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">Cidade</label>
                                <div class="col-md-10"><%=rs("cidade")%></div>
                             </div>
                             <div class="form-group row">
                                <label class="col-md-2 col-form-label">UF</label>
                                <div class="col-md-10"><%=rs("estado")%></div>
                             </div>

                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                
       

