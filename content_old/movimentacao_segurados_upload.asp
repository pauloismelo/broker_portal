<!--#include file="inc_upload.asp"-->
<!--#include file="verifica.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>&nbsp;</title>
</head>
<body>
	<%
	Response.Expires=0 
	Response.Buffer = TRUE 
	Response.Clear 
	byteCount = Request.TotalBytes 
	RequestBin = Request.BinaryRead(byteCount) 
	Dim UploadRequest 
	Set UploadRequest = CreateObject("Scripting.Dictionary") 
	BuildUploadRequest RequestBin 
	%> 
	<%AbreConexao
	set rs=conexao.execute("select * from TB_MOVIMENTACAO_SEGURADOS order by id desc")
	if rs.eof then
		idz=1
	else
		idz=rs("id")+1
	end if
	set rs=nothing

	'-------------------------------------------------------------------------------------------
	contrato = trim(UploadRequest.Item("contrato").Item("Value"))
	foto= Trim(UploadRequest.Item("foto").Item("Value"))
	reenvio= Trim(UploadRequest.Item("reenvio").Item("Value"))
	vigencia= Trim(UploadRequest.Item("vigencia").Item("Value"))
	ausente= Trim(UploadRequest.Item("ausente").Item("Value"))
	if reenvio<>"-" then
		texto_reenvio="Motivo do reenvio de planilha: "&reenvio&""
	end if
	if trim(ausente)="s" then
		texto_ausente="<br><span style='color:#F00;'>A cliente notificou que n&atilde;o h&aacute; movimenta&ccedil;&atilde;o de usu&aacute;rios para esse m&ecirc;s</span>"
	end if
	'--------------------------------------------------------------------------------------------
	if foto<>"" then
		ContentType = UploadRequest.Item("foto").Item("ContentType")
		filepathname = UploadRequest.Item("foto").Item("FileName")
		FileName = Right(filepathname, Len(filepathname) - InStrRev(filepathname, "\"))
		NomeArquivo=day(now)&"_"&month(now)&"_"&year(now)&"-"&FileName
		'response.Write(NomeArquivo)
		'response.End()
		Value = UploadRequest.Item("foto").Item("Value")
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
		numero1 = instrrev(Request.servervariables("Path_Info"), "/")
		var3 = left(Request.servervariables("Path_Info"),numero1)
		Set MyFile = ScriptObject.CreateTextFile(caminho&"docs_movimentacao\"&NomeArquivo)
		For i = 1 To LenB(Value)
		MyFile.Write Chr(AscB(MidB(Value, i, 1)))
		Next
		MyFile.Close
	end if

	If foto <>"" then
		fig_p=NomeArquivo
	elseif foto="" then
		fig_p="nenhum"
	end if

	protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&"MS"&idz

	Sql = "INSERT INTO TB_MOVIMENTACAO_SEGURADOS (id, contrato, planilha, status, id_cliente, datareg, userreg, protocolo, reenvio, vigencia, ausente) VALUES ("&idz&", '"&contrato&"', '"&fig_p&"', 'ENVIADO', "&idx&", '"&databrx2(date)&" "&time&"', '"&userxy&"', '"&protocolo&"', '"&reenvio&"', '"&vigencia&"', '"&ausente&"') "
	'response.Write(Sql)
	conexao.Execute(Sql)
		
		set ve=conexao.execute("select operadora from CADASTROGERAL_VENDAS where codigo='"&contrato&"' and idcadastro="&idx&" ")
		if not ve.eof then
			txt_op="<br>Seguradora: <strong>"&ve("operadora")&"</strong>"
		end if
		set ve=nothing
		
		'********************************************************
		sch = "http://schemas.microsoft.com/cdo/configuration/"
		Set cdoConfig = Server.CreateObject("CDO.Configuration")
		servidor_smtp = "mail.portalcompacta.com.br" 
		email_autentica = "noreply@portalcompacta.com.br" 
		senha_autentica = "7^5pey0B" 
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
		myMail.Fields.update
		myMail.Subject="Movimentação Seguro de vida - Planilha"
		myMail.From="PORTAL COMPACTA <"&email_autentica&">"
		myMail.To="seguros@compactaseguros.com"
		'myMail.Cc="informativo@compactasaude.com;deman@compactasaude.com"
		myMail.HTMLBody="<body><center><table width=100% border=0 cellpadding=4 cellspacing=4 bgcolor=#006600><tr><td><font color=#FFFFFF size=2 face=Arial><b>Compacta Sa&uacute;de - Movimenta&ccedil;&atilde;o de Segurado</b></font></td></tr><tr><td bgcolor=#FFFFFF>Aten&ccedil;&atilde;o DEMAN, o cliente:<br><br><strong>"&titularx&"</strong><br><br>Contrato: <strong>"&contrato&"</strong>"&txt_op&"<br><br>Fez uma nova movimenta&ccedil;&atilde;o no Portal do Cliente."&texto_ausente&"<br><br>Verificar os dados no SISCAD.<p><FONT FACE=arial SIZE=2><B>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></p></td></tr></table></center></body>"
								
		on error resume next										
		myMail.Send 										
		if err.number>0 then
			response.Write("Erro ao envio email")
			response.end
		end if
		on error goto 0													
		set myMail=nothing 
		Set cdoConfig = Nothing
		'********************************************************

	response.Write("<script>alert('Movimentacao Solicitada com sucesso!!');</script>")
	response.Write("<script>window.location='painel.asp?go=movimentacoes_vida';</script>")
	'response.Write("<script>window.location='index.asp?go=finaliza2&protocolo="&protocolo&"';</ script>")
	%>
</body>
</html>