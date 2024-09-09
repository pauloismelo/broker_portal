<%if request("modo")="solicitar" then
AbreConexao
	set rs=conexao.execute("select * from TB_SOLICITACOES order by id desc")
	if rs.eof then
	idz=1
	else
	idz=rs("id")+1
	end if
	set rs=nothing
	
	Sql = "INSERT INTO TB_SOLICITACOES (id, id_empresa, nvidas, solpor, datareg, obs, tipo, lido) VALUES ("&idz&", "&idx&", '"&request("nvidas")&"', '"&userxy&"', '"&databrx2(date)&"', '"&request("obs")&"', 'novogrupo', 'n' )"
	conexao.Execute(Sql)

	response.Write("<script>alert('Solicitacao enviada com sucesso\nEm breve entraremos em contato!');</script>")
	response.Write("<script>window.location='index.asp';</script>")
FechaConexao
end if%>


<div class="page-content">
    <div class="container-fluid">

        
		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Cotação para novos grupos</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">Cotação para novos grupos</li>
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
                       		Solicite a sua cotação e em breve entraremos em contato
                        </p>
                        
						<form action="painel.asp?go=cotacao" method="post" name="form01">
                        <input type="hidden" name="modo" value="solicitar">
                       
                       <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="mes">Cotação para: </label>
            				<div class="col-md-9"><%=nfantasia%></div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="ano">CNPJ</label>
            				<div class="col-md-9"><%=cnpjx%></div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-4 col-form-label" for="email">Nos informe quantos beneficiários farão parte do novo plano.</label>
            				<div class="col-md-8">
                            	<input type="text" class="form-control" name="nvidas" id="nvidas" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Cotação
                                </button>
                            </div>
                        </div>
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
       
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

    
                