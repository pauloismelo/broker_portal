 <!DOCTYPE html>
<!--#include file="db.asp"-->
<html lang="pt-br">
	
<head>
    <meta charset="utf-8">
    <title>Portal do Cliente | Grupo Compacta</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Portal do Cliente Compacta Saúde">
    <meta name="keywords" content="Portal do Cliente, cliente, Compacta, Compacta Saúde, Grupo Compacta, Grupo compacta, Plano de Saúde, Saúde, Clientes, Bradesco, Golden Cross, Sulamérica, Amil">
    <meta name="author" content="compactasaude.com">

    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/site.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <script src="js/js.js"></script> 
</head>
  <%if request("go")="auth" then
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
					response.Cookies("sso")("cargo")=con2("cargo")
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
  
  
 <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          
          <div style="width:100%;">
          	<div style="float:left; margin-right:50px;"><img src="img/compactabeneficios.png" width="120" style="margin:5px;"></div>
            
            <div style="float:left; text-align:left;">
            <a class="brand" href="index.asp"><strong style="font-size:24px;">Portal do Cliente</strong> <br><small style="font-size:14px; font-style:italic;">Compacta Benef&iacute;cios - Sa&uacute;de, Odonto, Vida, Previd&ecirc;ncia e Seguros</small> </a>
            </div>
          </div>
         
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
        
        <div class="span12 pagination-centered">
        
            <div class="well hero-unit">
            <h2>Seja bem vindo(a) ao Portal do Cliente!</h2>
            <p>Entre com os seus dados abaixo:</p>
            </div>
            
            <form class="form-horizontal" action="login.asp?go=auth" method="post">
                <fieldset>
                    <div class="control-group">
                        <div class="controls">
                        	<label style="color:#F00;">CNPJ (Apenas números)</label>
                            <input type="text" class="input-xlarge" name="cnpj" id="cnpj" placeholder="CNPJ (Apenas números)" required style="text-align:center;"/>
                        </div>
                    </div>	
                    <div class="control-group">
                        <div class="controls">
                        	<label style="color:#F00;">Email cadastrado</label>
                            <input type="text" class="input-xlarge" name="login" id="login" placeholder="Login" required style="text-align:center;"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <input type="password" class="input-xlarge" name="senha" id="senha" placeholder="Senha" required style="text-align:center;"/>
                        </div>
                    </div>
                    <div class="form-actions">
                        <input type="submit" class="btn btn-success btn-large" value="Entrar" /> 
                        
                    </div>
                </fieldset>
            </form>
              
        </div>
       
      </div>

    </div>

    
  </body>
</html>
