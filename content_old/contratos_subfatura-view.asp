<%if request("acessar")="ok" then

	response.Cookies("sso")("authi")=""
	response.Cookies("sso")("senha")=""
	response.Cookies("sso")("matricula")=""
	response.Cookies("sso")("user")=""
	response.Cookies("sso")("manager")=""

	Response.CacheControl = "no-cache" 
	Response.Expires = -1 
	Response.addHeader "pragma", "no-cache"

	
	AbreConexao
		set con=conexao.execute("select * from cadastrogeral WHERE REPLACE(REPLACE(REPLACE(CNPJ,'.',''),'-',''),'/','')='"&replace(replace(replace(replace(REQUEST("cnpj"),".",""),"-",""),"/","")," ","")&"' order by id desc")
		if not con.eof then

			
			set con2=conexao.execute("select * from cadastrogeral_usuarios where idcadastro="&con("id")&" and login='"&request("login")&"' and senha='"&request("senha")&"' and status='ATIVO'")
			
			if not con2.eof then
				if trim(con("id"))=trim(request("senha")) then
					'REDIRECIONA PARA ALTERARSENHA
					response.Write("<script>alert('É necessário atualizar a sua senha!\nVocê será redirecionado para a tela de atualização.');</script>")
					response.redirect("updatepass.asp?wx="&con2("id")&"")
						
				else
				
					'INSERE O REGISTRO DE ACESSO
					set rs=conexao.execute("select * from CANAL_CLIENTE_ACESSO order by id desc")
					if not rs.eof then
						idp=rs("id")+1
					else
						idp=1
					end if
					set rs=nothing
					conexao.execute("insert into CANAL_CLIENTE_ACESSO (id, id_empresa, id_usuario, data, hora, ip) values("&idp&", "&con("id")&", "&con2("id")&", '"&databr(date)&"', '"&hour(now)&":"&minute(now)&"', '"&Request.ServerVariables("REMOTE_ADDR")&"')")
				
					response.Cookies("sso")("authi")="47sdjhj2266w8wh585872322--2-*/s+ws226ahwsn2GASS73H399E2111AS4877/**54225SS2S1871123344"
					response.Cookies("sso")("matricula")=con("cnpj")
					response.Cookies("sso")("senha")=con("id")
					response.Cookies("sso")("login")=con2("login")
					if trim(con2("manager"))="on" then
						response.Cookies("sso")("manager")=con2("manager")
					else
						response.Cookies("sso")("manager")="off"
					end if
					if con2("nome")<>"" then
						response.Cookies("sso")("user")=con2("nome")
					else
						response.Cookies("sso")("user")=con2("login")
					end if
					
					if con2("idfilial")<>"" then
						response.Cookies("sso")("filial")=con2("idfilial")
					else
						response.Cookies("sso")("filial")=""
					end if
					
					if con2("idcentro")<>"" then
						response.Cookies("sso")("centro")=con2("idcentro")
					else
						response.Cookies("sso")("centro")=""
					end if
					
					if con2("idcontrato_permitido")<>"" then
						response.Cookies("sso")("contrato_permitido")=con2("idcontrato_permitido")
					else
						response.Cookies("sso")("contrato_permitido")=""
					end if
					
					
					response.Cookies("sso")("iduser")=con2("id")
					response.Cookies("sso")("entrada")=time
					
					response.redirect("index.asp")
					response.End()
				end if
			
			else
				response.Write("<script>alert('Login ou Senha incorreta, volte e tente novamente!');</script>")
				response.Write("<script>history.back(-1);</script>")
				response.End()
			end if
					
		else
			response.Write("<script>alert('Não foi encontrado registro com o CNPJ informado, volte e tente novamente!');</script>")
			response.Write("<script>history.back(-1);</script>")
			response.End()
		end if
		set con=nothing
	
	FechaConexao
  

end if%>

<div class="page-content">
    <div class="container-fluid">

        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Subfaturas</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Início</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos_subfatura">Contratos</a></li>
                            <li class="breadcrumb-item active">Subfaturas</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->
        <%set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO' and esconde_contrato='n' and id="&request("id")&" order by id desc")
		if not rs.eof then
		%>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <p class="card-title-desc">Segue abaixo as subfaturas do contrato <%=rs("ramo")%>/<%=rs("segmento")%>/<%=rs("operadora")%>.
                        </p>

                        <table class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                            <thead>
                            <tr>
                                <th class="text-center">&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>Ramo</th>
                                <th>Operadora</th>
                                <th class="text-center">Dia de<br>Vencimento</th>
                            </tr>
                            </thead>


                            <tbody>
                            <%while not rs.eof
							set ve=conexao.execute("select titular, cnpjcpf from CAIXAVENDAS where id="&rs("idvenda")&"")
							if not ve.eof then%>
                            <tr>
                                <td class="text-muted font-weight-semibold text-center">
									Contrato Principal <i class="fas fa-arrow-right"></i>
                                </td>
                                <td class="text-muted font-weight-semibold text-center">
                                	<%=ve("cnpjcpf")%><br />
									<%=ve("titular")%>
                                </td>
                                <td>
                                    <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("ramo")%> </h6>
                                </td>
                                <td>
								<h6 class="font-size-15 mb-1 font-weight-normal"><%=rs("operadora")%></h6>
                                <p class="text-muted font-size-13 mb-0">Cod: <%=rs("codigo")%></p>
                                </td>
                                <td><p class="text-muted font-size-13 mb-0 text-center"><%=rs("vencimento")%></p></td>
                            </tr>
                            
                            <%set rs2=conexao.execute("select id, titular, cnpjcpf, ramo, operadora, codigo, vencimento from CAIXAVENDAS where subfaturadeidcx="&rs("idvenda")&"")
							if not rs2.eof then
							while not rs2.eof
								set cad=conexao.execute("select idcadastro from CADASTROGERAL_VENDAS where idvenda="&rs2("id")&"")
								if not cad.eof then%>
                                    <tr>
                                        <td class="text-muted font-weight-semibold text-center">
                                        	<small>
                                            <%set us=conexao.execute("select senha from CADASTROGERAL_USUARIOS where idcadastro="&cad("idcadastro")&" and login='"&trim(emailx)&"' ")
											if not us.eof then%>
                                            <form class="form-horizontal" action="painel.asp?go=contratos_subfatura-view" method="post">
                                            
                                            <input type="hidden" name="acessar" value="ok" />
                                            
                                            <input type="hidden" name="cnpj" id="cnpj" value="<%=rs2("cnpjcpf")%>" required />
                                            <input type="hidden" name="login" id="login" value="<%=emailx%>" required />
                                            <input type="hidden" name="senha" id="senha" value="<%=us("senha")%>" required />
                                            
                                            <button type="submit" class="btn btn-success waves-effect waves-light">Acessar 
                                            <i class="fas fa-arrow-right" title="Clique aqui para acessar o Portal dessa subfatura!"></i>
                                            </button>
                                            
                                            </form>
                                            <%else%>
                                            <button type="submit" class="btn btn-danger waves-effect waves-light">Você não tem acesso a essa subfatura
                                            </button>
                                            
											<%end if
											set us=nothing%>
                                            
                                            </small>
                                        </td>
                                        <td class="text-muted font-weight-semibold text-center">
                                        	<small>
											<%=rs2("cnpjcpf")%><br />
											<%=rs2("titular")%>
                                            </small>
                                        </td>
                                        <td>
                                            <small>
                                            <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs2("ramo")%> </h6>
                                            </small>
                                        </td>
                                        <td>
                                        <small>
                                        <h6 class="font-size-15 mb-1 font-weight-normal"><%=rs2("operadora")%></h6>
                                        <p class="text-muted font-size-13 mb-0">Cod: <%=rs2("codigo")%></p>
                                        </small>
                                        </td>
                                        <td>
                                        <small>
                                        <p class="text-muted font-size-13 mb-0 text-center"><%=rs2("vencimento")%></p>
                                        </small>
                                        </td>
                                    </tr>
                                <%end if
								set cad=nothing%>
							<%rs2.movenext
							wend
							else%>
								<tr>
                                    <td class="text-muted font-weight-semibold text-center" colspan="7">
                                        Nenhuma Subfatura para esse contrato
                                    </td>
                                </tr>
							<%end if
							set rs2=nothing
							end if
							set ve=nothing
							rs.movenext
							wend
							%>
                            
                            </tbody>
                        </table>

                    </div>
                </div>
            </div> <!-- end col -->
        </div> <!-- end row -->                        
		<%end if
		set rs=nothing%>
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

<script>
	$('#datatable').dataTable( {
		"order": []
	} );
</script>   