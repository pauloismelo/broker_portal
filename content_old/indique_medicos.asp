<%if request("gravar")="ok" then
AbreConexao
	set rs=conexao.execute("select * from INDICACAO_PROFISSIONAL order by id desc")
	if rs.eof then
	idz=1
	else
	idz=rs("id")+1
	end if
	set rs=nothing
	
	Sql = "INSERT INTO INDICACAO_PROFISSIONAL (id, id_empresa, nome, registro, celular, especialidade, solpor, datareg, obs, tipo) VALUES ("&idz&", "&idx&", '"&request("nome")&"', '"&request("registro")&"', '"&request("cel")&"', '"&request("especialidade")&"', '"&userxy&"', '"&month(now)&"/"&day(now)&"/"&year(now)&"', '"&request("obs")&"', 'medico' )"
	conexao.Execute(Sql)

	response.Write("<script>alert('Indicação enviada com sucesso\nEncaminharemos à Operadora!');</script>")
	response.Write("<script>window.location='index.asp';</script>")
FechaConexao
end if%>




<div class="page-content">
    <div class="container-fluid">

        
		
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Indique seu médico</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item active">Indique seu médico</li>
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
                       		Encaminharemos essa solicitação à operadora para o possível credenciamento do médico.
                        </p>
                        
						<form action="painel.asp?go=indique_medicos" method="post" name="form01">
                        <input type="hidden" name="gravar" value="ok">
                       
                       <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="name">Nome do Profissional</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="nome" id="nome" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="registro">CRM</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="registro" id="registro" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="cel">Celular</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control input-mask" data-inputmask="'mask': '(99)99999-9999'" im-insert="true" name="cel" id="cel" required/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="especialidade">Especialidade</label>
            				<div class="col-md-9">
                            	<input type="text" class="form-control" name="especialidade" id="especialidade" required/>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="obs">Observações</label>
            				<div class="col-md-9">
                            	<textarea name="obs" rows="3" class="form-control" id="obs" placeholder="Descreva aqui informações que você julgue importantes para essa movimentação."></textarea>
                            </div>
                        </div>
                        
                        
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Indicar
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

    
                