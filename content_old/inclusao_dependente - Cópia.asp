
<%if request("gravar")="ok" then
	AbreConexao
		set rs=conexao.execute("select * from TB_MOVIMENTACOES where id="&request("id")&"")
		if not rs.eof then
			contrato=rs("id_contrato")
			plano=rs("plano")
			dinicio=rs("dinicio")
			datacob=rs("datacob")
			
		end if
		set rs=nothing
	
		set rs=conexao.execute("select * from TB_MOVIMENTACOES order by id desc")
		if rs.eof then
			idp=1
		else
			idp=rs("id")+1
		end if
		set rs=nothing
		
		SQZ="insert into TB_MOVIMENTACOES (id, solicitacao_principal, nome, dnasc, cpf, sexo, ecivil, parentesco, mae, status, id_empresa, datareg, id_contrato, plano, horareg, solpor, dinicio, datacob, tipo, cns) values("&idp&", '"&request("id")&"', '"&request("nome")&"', '"&request("dnasc")&"', '"&request("cpf")&"', '"&request("sexo")&"', '"&request("ecivil")&"', '"&request("parentesco")&"', '"&request("mae")&"', 'ENVIADO', "&idx&", '"&databrx2(DATE)&"', '"&contrato&"', '"&plano&"', '"&time&"', '"&userxy&"', '"&dinicio&"', '"&datacob&"', 'INCLUSAO', '"&request("cns")&"')"
		response.Write(SQZ)
		conexao.execute(SQZ)
	
	
	
	
	'response.Write("<script>window.location='album/index.php?id="&idp&"&tipo=inclusao';</ script>")
	response.Write("<script>window.location='painel.asp?go=inclusao_pergunta2&id="&request("id")&"';</script>")
	
	FechaConexao
end if%>

<div class="page-content">
    <div class="container-fluid">

        <%AbreConexao
		set rs=conexao.execute("select * from TB_MOVIMENTACOES where id="&request("id")&"")
		if not rs.eof then
			contrato=rs("id_contrato")
			titular=rs("nome")
		end if
		set rs=nothing
		
		set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and id="&contrato&"")
		if not rs.eof then
		
			set regra=conexao.execute("select * from CADASTROGERAL_VENDAS_FORMPORTAL where ramo='"&rs("ramo")&"' and segmento='"&rs("segmento")&"' and operadora='"&rs("operadora")&"' ")
			if not regra.eof then
				campo_nome=regra("campo_nome")
				campo_admissao=regra("campo_admissao")
				campo_cpf=regra("campo_cpf")
				campo_matricula=regra("campo_matricula")
				campo_nascimento=regra("campo_nascimento")
				campo_cns=regra("campo_cns")
				campo_rg=regra("campo_rg")
				campo_sexo=regra("campo_sexo")
				campo_estadocivil=regra("campo_estadocivil")
				campo_celular=regra("campo_celular")
				campo_email=regra("campo_email")
				campo_mae=regra("campo_mae")
				campo_cargo=regra("campo_cargo")
				campo_plano=regra("campo_plano")
				campo_endereco=regra("campo_endereco")
				campo_banco=regra("campo_banco")
			else
				response.Write("<script>alert('Impossivel Prosseguir!\nSolicite ao Departamento de Manutenção e Relacionamento que cadastre as regras de formulario para esse contrato.');</script>")
				response.End()
			end if
			set regra=nothing
			
			
			
		%>
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Incluir Dependente</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Incluir Titular</li>
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

                        <h4 class="card-title"></h4>
                        <p class="card-title-desc">
                       	Incluindo Dependente para o titular <strong><%=titular%></strong>
                        </p>
						<form action="painel.asp?go=inclusao_dependente&gravar=ok" method="post" name="form01">
                		<input type="hidden" name="id" value="<%=request("id")%>" />
                         
                        <%if campo_nome="s" then%>
                        	<div class="form-group row">
                                <label for="nome" class="col-md-2 col-form-label">Nome Completo</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="nome" id="nome" required>
                                </div>
                            </div>
                        <%end if
                        if campo_cpf="s" then%>
                          <div class="form-group row">
                               <label for="cpf" class="col-md-2 col-form-label">CPF</label>
                               <div class="col-md-10">
                                   <input class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true" type="text" name="cpf" id="cpf" required>
                               </div>
                          </div>
                        <%end if						
                         if campo_nascimento="s" then%>
                          
                         	<div class="form-group row">
                                <label for="dnasc" class="col-md-2 col-form-label">Data de Nascimento</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="date" name="dnasc" id="dnasc" required>
                                </div>
                            </div>
                         <%end if
						 if campo_cns="s" then%>
                         	<div class="form-group row">
                                <label for="cns" class="col-md-2 col-form-label">CNS</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="cns" id="cns" required>
                                </div>
                            </div>
                          <%end if
						  if campo_sexo="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Sexo</label>
                                    <div class="col-md-10">
                                        <select name="sexo" id="sexo" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Masculino">Masculino</option>
                                			<option value="Feminino">Feminino</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
                          if campo_estadocivil="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Estado Civil</label>
                                    <div class="col-md-10">
                                        <select name="ecivil" id="ecivil" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Solteiro">Solteiro</option>
                                            <option value="Casado">Casado</option>
                                            <option value="Vi&uacute;vo">Vi&uacute;vo</option>
                                            <option value="Outros">Outros</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
						  if campo_mae="s" then%>
                              <div class="form-group row">
                                <label for="mae" class="col-md-2 col-form-label">Nome da M&atilde;e:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="mae" id="mae" required>
                                </div>
                              </div>
                          <%end if%>
                          	  <div class="form-group row">
                                    <label class="col-md-2 col-form-label">Parentesco</label>
                                    <div class="col-md-10">
                                        <select name="parentesco" id="parentesco" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Cônjuge">Cônjuge</option>
                                            <option value="Filho(a)">Filho(a)</option>
                                            <option value="Pai">Pai</option>
                                            <option value="Mãe">Mãe</option>
                                            <option value="Sogro(a)">Sogro(a)</option>
                                            <option value="Irmãos(ãs)">Irmãos(ãs)</option>
                                        </select>
                                    </div>
                                </div>
                     
                            <div class="form-group row">
                                
                                <div class="col-md-12 text-center">
                                	<button type="submit" class="btn btn-success waves-effect waves-light">
                                        <i class="uil uil-check mr-2"></i> GRAVAR
                                    </button>
                                </div>
                            </div>
                      
                     
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
        <%end if
		set rs=nothing
		FechaConexao%>
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                