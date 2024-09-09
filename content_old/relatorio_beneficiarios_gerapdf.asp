
<!--#include file="verifica.asp"-->

<%' Cria uma instância do controle

Set aspPdf = Server.CreateObject("Persits.Pdf")
' Cria um documento em branco
Set Doc = aspPdf.CreateDocument
' Importa a URL da Internet
SET param = aspPdf.CreateParam("x=0;y=0;height=260;width=196; size=10;")

Doc.ImportFromUrl "https://portalcompacta.com.br/relatorio_beneficiarios.asp?id="&request("idcadvenda")&"&idcadastro="&request("idcadastro")

'Doc.ImportFromUrl "https://portalcompacta.com.br/relatorio_beneficiarios.asp?id="&request("idcadvenda")&"&idcadastro="&request("idcadastro")
' Salva o documento.
arquivo="RELATORIO_BENEFICIARIOS-"&request("idcadvenda")&"-"&year(now)&"-"&month(now)&"-"&day(now)&".pdf"
ArquivoPDF = Doc.Save(Server.MapPath("RELATORIO_BENEFICIARIOS/"&arquivo), true )
' Tira os objetos da memória
Set Doc = Nothing
Set aspPdf = Nothing

'Response.Write "Arquivo criado com sucesso : " & ArquivoPDF

	AbreConexao
	  set cli=conexao.execute("select * from CADASTROGERAL_USUARIOS where idcadastro="&request("idcadastro")&" and email_relatoriogerencial='s'")
	  if not cli.eof then
		  while not cli.eof
			if emailto="" then
				emailto=cli("login")
			else
				emailto=emailto&";"&cli("login")
			end if
		  cli.movenext
		  wend
	  end if
	  set cli=nothing
	  
	  set ven=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("idcadvenda")&" ")
	  if not ven.eof then
	  	contrato=ven("ramo")&" - "&ven("operadora")&""
	  end if
	  set ven=nothing
	  
	  set ven=conexao.execute("select * from CADASTROGERAL where id="&request("idcadastro")&" ")
	  if not ven.eof then
	  	titular=ven("titular")
	  end if
	  set ven=nothing
		
		if emailto<>"" then
		sch = "http://schemas.microsoft.com/cdo/configuration/"
		Set cdoConfig = Server.CreateObject("CDO.Configuration")

		servidor_smtp = "mail.compactasaude.com.br" 
		email_autentica = "noreply@compactasaude.com.br" 
		senha_autentica = "x7hd0%F8" 
		cdoConfig.Fields.Item(sch & "sendusing") = 2
		cdoConfig.Fields.Item(sch & "smtpauthenticate") = 1
		cdoConfig.Fields.Item(sch & "smtpserver") = servidor_smtp
		cdoConfig.Fields.Item(sch & "smtpserverport") = 587
		cdoConfig.Fields.Item(sch & "smtpconnectiontimeout") = 30
		cdoConfig.Fields.Item(sch & "sendusername") = email_autentica
		cdoConfig.Fields.Item(sch & "sendpassword") = senha_autentica
		cdoConfig.fields.update

		Set myMail=CreateObject("CDO.Message") 
		Set myMail.Configuration = cdoConfig
		myMail.Subject="RELATORIO DE BENEFICIARIOS ATIVOS . "&contrato&""
		myMail.From="PORTAL DO CLIENTE - COMPACTA BENEFICIOS<"&email_autentica&">"
		myMail.To=emailto
		'myMail.To="supervisao.deman@compactasaude.com"
		myMail.Bcc="luciano@compactasaude.com;lucianaoliveira@compactasaude.com;supervisao.deman@compactasaude.com"
		myMail.AddAttachment caminho&"\RELATORIO_BENEFICIARIOS\"&arquivo
		myMail.HTMLBody="<body><font face=arial><center><table width=650 border=0 cellpadding=0 cellspacing=0><tr><td valign=top><img src=http://www.compactasaude.com.br/mailling/deman/topo.jpg></td></tr> <tr><td width=778 valign=top><br><font face=arial size=3>Prezado(a) "&userxy&", <br><br>em anexo enviamos o Relatório de beneficiarios solicitado através do Portal do Cliente .<br></font><br></td></tr><tr><td><font face=arial size=3>Nele você encontrará todos os beneficiarios ativos do contrato: <br><br><strong>"&contrato&"</strong></font></td></tr><tr><td>&nbsp;</td></tr><tr><td valign=top class=texto><a href=http://www.compactasaude.com.br><img src=http://www.compactasaude.com.br/mailling/deman/botton.png></a></td></tr></table></center></font></body>"		
		myMail.Send
		set myMail=nothing    
		Set cdoConfig = Nothing
		
		'registro de envios
		'conexao.execute("insert into TB_RELATORIOGERENCIAL_ENVIOS (id_cadastro, id_cadvenda, datareg, userreg) values ("&request("idcadastro")&", "&request("idcadvenda")&", '"&databrx2(date)&" "&time&"', '"&nomex&"')")
					
		response.Write("<script>alert('RELATORIO ENVIADO PARA O EMAIL CADASTRADO NA COMPACTA!');</script>")
		'response.Write("<meta http-equiv=refresh content=0;URL=CADASTRO-editEMP_contratos.asp?idcadastro="&request("idcadastro")&"&idcadvenda="&request("idcadvenda")&">")
		'response.Redirect("index.asp?go=contrato&id="&request("idcadvenda")&"&pesq=ok")
		response.Write("<script>window.close();</script>")

		else
			response.Write("<script>alert('IMPOSSIVEL PROSSEGUIR!\Nao ha contato habilitado para receber esse tipo de email!');</script>")
			response.Write("<script>window.close();</script>")
		end if
%>