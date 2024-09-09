<%if request("gravar")="ok" then
AbreConexao
	set rs=conexao.execute("select * from TB_MOVIMENTACOES order by id desc")
	if rs.eof then
		idp=1
	else
		idp=rs("id")+1
	end if
	set rs=nothing
	
	protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&idp
	
	SQL="insert into TB_MOVIMENTACOES (id, nome, cpf, id_empresa, id_contrato, id_usuario, datareg, horareg, solpor, tipo, protocolo, downgrade_upgrade, status, filial_atual, filial_desejada) values("&idp&", '"&request("nome")&"', '"&request("cpf")&"', "&idx&", "&request("idcontrato")&", "&request("idusuario")&", '"&date&"', '"&hour(now)&":"&minute(now)&"', '"&userxy&"', 'TROCAFILIAL', '"&protocolo&"', '"&request("plano")&"', 'ENVIADO', '"&request("filial_atual")&"', '"&request("plano")&"')"
	'response.Write(SQL)
	conexao.execute(SQL)
	
	
	conexao.execute("insert into CADASTROGERAL_OBS (id_usuario, obs, datareg, userreg) values ("&request("idusuario")&", 'solicitação de alteração de filial/unidade através do Portal do Cliente. Id da movimentação: "&idp&"', '"&databrx2(date)&"' , '"&userxy&"' )")
	
	response.Write("<script>alert('Solicitado com Sucesso!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacao_finaliza&id="&idp&"';</script>")

FechaConexao
end if%>



<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Alteração de Unidade/Base/Filial</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Alteração de Unidade/Base/Filial</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
		
        <%set ex=conexao.execute("select * from CADASTROGERAL where id="&request("id")&" ")
        nome=ex("titular")
		cpf=ex("cpf")
		filial=ex("idfilial")
		
		set emp=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("contrato")&"")%>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                    	<p class="card-title-desc">
                       		Solicitar alteração de filial/unidade
                        </p>
                        
                        
						<form action="painel.asp?go=trocafilial" method="post" name="form01">
                        <input type="hidden" name="gravar" value="ok">
                        <input type="hidden" name="idusuario" value="<%=ex("id")%>">
                    	<input type="hidden" name="idcontrato" value="<%=emp("id")%>">
                       
                       <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="name">Nome</label>
            				<strong><%=nome%></strong>
                            <div class="col-md-9">
                            	<input type="hidden" class="form-control" name="nome" id="nome" value="<%=nome%>"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="email">CPF</label>
            				<div class="col-md-9">
                                <%if cpf<>"" then%>
                                    <strong><%=cpf%></strong>
                                    <input type="hidden" name="cpf" id="cpf" value="<%=cpf%>" />
                                <%else%>
                                    <input type="text" name="cpf" id="cpf" class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true"  />
                                <%end if%>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="plano">Unidade/Base/Filial atual</label>
            				<div class="col-md-9">
                            	<%set pla=conexao.execute("select nome from CADASTROGERAL_FILIAL where id="&filial&" ")
								if not pla.eof then%>
                                	<strong><%=pla("nome")%></strong>
                                    <input type="hidden" name="filial_atual" value="<%=filial%>" />
                                <%end if
								set pla=nothing%>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="plano">Unidade/Base/Filial desejado</label>
            				<div class="col-md-9">
                            	<%set pla=conexao.execute("select id, numero, nome from CADASTROGERAL_FILIAL where idcadastro="&idx&" and id<>"&filial&" order by nome asc ")
								if not pla.eof then%>
                                	<select name="plano" class="form-control" required>
                                    	<option value="">Selecione...</option>
                                        <%while not pla.eof%>
                                        <option value="<%=pla("id")%>"><%=pla("numero")%> - <%=pla("nome")%></option>
                                        <%pla.movenext
										wend%>
                                    </select>
                                <%else
                                	dow="n"%>
                                	<div class="alert alert-danger alert-dismissible fade show px-4 mb-0 text-left">
                                   	Atualmente este contrato tem apenas uma opção Filial/Unidade.<br />Dúvidas, consultar nosso departamento de Manutenção e Relacionamento.
                                    </div>
								<%end if
								set pla=nothing%>
                            	
                            </div>
                        </div>
                        
                        
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <%if dow<>"n" then%>
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Alteração
                                </button>
                                <%end if%>
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

    
                