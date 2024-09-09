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
			set con2=conexao.execute("select * from cadastrogeral_usuarios where id="&request("user")&" and senha='"&request("senha")&"' and status='ATIVO'")
			
			if not con2.eof then
				if trim(request("senha2"))<>trim(request("senha3")) then
					response.Write("<script>alert('As Senhas não coincidem!\nFavor tentar novamente.');</script>")
					response.Write("<script>history.back(-1);</script>")
				else
					if int(Len(trim(request("senha2")))<6) then
						response.Write("<script>alert('A senha deve ter no mínimo 6 dígitos!\nFavor tentar novamente.');</script>")
						response.Write("<script>history.back(-1);</script>")
					else
						if isnumeric(trim(request("senha2"))) = true then
							response.Write("<script>alert('A senha deve ter números e letras!\nFavor tentar novamente.');</script>")
							response.Write("<script>history.back(-1);</script>")
						else
							conexao.execute("update cadastrogeral_usuarios set senha='"&request("senha2")&"' where id="&request("user")&"")
							response.Write("<script>alert('Senha alterada com sucesso!');</script>")
							response.Write("<script>window.location='login.asp';</script>")
						end if
					end if
				end if
			else
				response.Write("<script>alert('Senha atual incorreta!\nVolte e tente novamente!');</script>")
				response.Write("<script>history.back(-1);</script>")
				response.End()
			end if
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
            <h2>Alteração de Senha</h2>
            <p>Para acessar ao Portal do Cliente, é necessário que altere sua senha abaixo:</p>
            </div>
            
            <form class="form-horizontal" action="updatepass.asp?go=auth" method="post">
            	<input type="hidden" name="user" value="<%=request("wx")%>">
                <fieldset>
                    <div class="control-group">
                        <div class="controls">
                        	<label>Senha Atual</label>
                            <input type="text" class="input-xlarge" name="senha" id="senha" required style="text-align:center;"/>
                        </div>
                    </div>	
                    <div class="control-group">
                        <div class="controls">
                        	<label>Nova Senha<br><small style="color:#F00; font-size:9px">*Mínimo de 6 digitos contendo letras e números</small></label>
                            <input type="text" class="input-xlarge" name="senha2" id="senha2" required style="text-align:center;"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                        <label>Repita a Nova Senha<br><small style="color:#F00; font-size:9px">*Mínimo de 6 digitos contendo letras e números</small></label>
                            <input type="text" class="input-xlarge" name="senha3" id="senha3" required style="text-align:center;"/>
                        </div>
                    </div>
                    <div class="form-actions">
                        <input type="submit" class="btn btn-success btn-large" value="Alterar" /> 
                    </div>
                </fieldset>
            </form>
              
        </div>
       
      </div>

    </div>

    
  </body>
</html>
