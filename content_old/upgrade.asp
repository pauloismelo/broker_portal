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
	
	SQL="insert into TB_MOVIMENTACOES (id, nome, cpf, id_empresa, id_contrato, id_usuario, datareg, horareg, solpor, tipo, protocolo, downgrade_upgrade, status) values("&idp&", '"&request("nome")&"', '"&request("cpf")&"', "&idx&", "&request("idcontrato")&", "&request("idusuario")&", '"&date&"', '"&hour(now)&":"&minute(now)&"', '"&userxy&"', 'UPGRADE', '"&protocolo&"', '"&request("plano")&"', 'ENVIADO')"
	response.Write(SQL)
	conexao.execute(SQL)
	
	response.Write("<script>alert('Upgrade solicitado com Sucesso!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacao_finaliza&id="&idp&"';</script>")

FechaConexao
end if%>



<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Upgrade de Plano</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Upgrade de Plano</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
		
        <%set ex=conexao.execute("select * from CADASTROGERAL where id="&request("id")&" ")
        nome=ex("titular")
		cpf=ex("cpf")
		plano=ex("plano")
		
		set emp=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("contrato")&"")%>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                    	<p class="card-title-desc">
                       		Solicitar alteração de plano para plano superior ao atual
                        </p>
                        <p> 
                            <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center">
                                <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                <h5 class="text-danger">ATENÇÃO</h5>
                                <p>Solicitações de <strong>Upgrade</strong> não são efetuadas automaticamente. A alteração depende de autorização da operadora.<br />Assim que nosso departamento de manutenção receber a resposta da operadora  informaremos sobre o resultado.<br />Via de regra a operadora só aceita pedidos de Downgrade e Upgrade na data de aniversário do contrato.<br />Havendo autorização da operadora para o Upgrade, o usuario deverá cumprir carências para utilizar a rede dos novos credenciados que não faziam parte do seu plano.</p>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                        </p>
                        
						<form action="painel.asp?go=upgrade" method="post" name="form01">
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
                            <label class="col-md-3 col-form-label" for="plano">Plano atual</label>
            				<div class="col-md-9">
                            	<%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where id="&plano&" ")
								if not pla.eof then%>
                                	<strong><%=pla("nome")%> - <%=pla("acomodacao")%></strong>
                                <%end if
								set pla=nothing%>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 col-form-label" for="plano">Plano desejado</label>
            				<div class="col-md-9">
                            	<%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where contrato="&request("contrato")&" and id<>"&plano&" order by nome asc ")
								if not pla.eof then%>
                                	<select name="plano" class="form-control" required>
                                    	<option value="">Selecione...</option>
                                        <%while not pla.eof%>
                                        <option value="<%=pla("nome")%>"><%=pla("nome")%></option>
                                        <%pla.movenext
										wend%>
                                    </select>
                                <%else
                                	dow="n"%>
                                	<div class="alert alert-danger alert-dismissible fade show px-4 mb-0 text-left">
                                   Atualmente este contrato tem apenas uma opção de plano cadastrado.<br />Dúvidas, consultar nosso departamento de Manutenção e Relacionamento.
                                    </div>
								<%end if
								set pla=nothing%>
                            	
                            </div>
                        </div>
                        
                        
                        <div class="form-group row">
                                
                            <div class="col-md-12 text-center">
                                <%if dow<>"n" then%>
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> Solicitar Upgrade
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

    
                