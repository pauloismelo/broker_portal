<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enviar Planilha por email</title>
<!--#include file="verifica.asp"-->
<link rel="stylesheet" type="text/css" href="css.css"/>
</head>

<body>
<%if request("envio")="ok" then
AbreConexao

set mov=conexao.execute("select * from TB_MOVIMENTACAO_SEGURADOS where id="&request("id")&"")
if not mov.eof then

set cad=conexao.execute("select * from CADASTROGERAL where id="&mov("id_cliente")&"")
if not cad.eof then
	titular=cad("titular")
	cnpj=cad("cnpj")
end if

set con=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&mov("contrato")&" ")
if not con.eof then
	codigo=con("codigo")
end if


assunto=request("assunto")
mensagem="<body><center><table width=650 border=0 cellpadding=4 cellspacing=4><tr><td bgcolor=#FFFFFF><img src='https://www.compactasaude.com.br/mailling/deman/topo.png'></td></tr><tr><td bgcolor=#FFFFFF><FONT FACE=arial SIZE=2>Prezados(as),<br><br>Anexo planilha com as movimentações seguro de vida:<br><br>EMPRESA: <strong>"&ucase(titular)&"</strong><br>CNPJ: <strong>"&ucase(cnpj)&"</strong><br>CONVENIO: <strong>"&ucase(codigo)&"</strong> <br><br></FONT><FONT FACE=arial SIZE=2><B>Atenciosamente,<br><br>"&nomex&" - Plataforma Compacta<br><br>Este e-mail foi enviado para voc&ecirc; no dia: "&day(now)&"/"&month(now)&"/"&year(now)&" &agrave;s: "&time&" .</b></FONT></td></tr><tr><td bgcolor=#FFFFFF><img src='https://www.compactasaude.com.br/mailling/deman/botton.png'></td></tr></table></center></body>"

sch = "http://schemas.microsoft.com/cdo/configuration/"

' Inicio da configuracao dos parametros
servidor_smtp = "mail.compactasaude.com.br" 
email_autentica = "noreply@compactasaude.com.br" 
senha_autentica = "x7hd0%F8" 
email_remetente = "Compacta Saúde <"&email_autentica&">"

' Fim da configuracao dos parametros
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

cdoConfig.Fields.Item(sch & "sendusing") = 2
cdoConfig.Fields.Item(sch & "smtpauthenticate") = 1
cdoConfig.Fields.Item(sch & "smtpserver") = servidor_smtp
cdoConfig.Fields.Item(sch & "smtpserverport") = 587
cdoConfig.Fields.Item(sch & "smtpconnectiontimeout") = 30
cdoConfig.Fields.Item(sch & "sendusername") = email_autentica
cdoConfig.Fields.Item(sch & "sendpassword") = senha_autentica
cdoConfig.fields.update

Set cdoMessage = Server.CreateObject("CDO.Message")
Set cdoMessage.Configuration = cdoConfig
cdoMessage.From = email_remetente
cdoMessage.To = request("emailto")
cdoMessage.Bcc = "deman@compactasaude.com"
cdoMessage.ReplyTo = "deman@compactasaude.com"
cdoMessage.Subject = ucase(assunto)
cdoMessage.HTMLBody = mensagem
cdoMessage.AddAttachment "D:\Websites\portalcompacta.com.br\httpdocs\docs_movimentacao\"&mov("planilha")&""
cdoMessage.Send
Set cdoMessage = Nothing
Set cdoConfig = Nothing


conexao.execute("update TB_MOVIMENTACAO_SEGURADOS set email_user='"&nomex&"', email_data='"&databrx2(date)&" "&time&"' where id="&request("id")&"")

'response.Write("insert into TB_MOVIMENTACAO_SEGURADOS_EMAIL (id_movimentacao, userreg, datareg, mensagem, email) values ("&request("id")&", '"&request("nomex")&"', '"&databrx2(date)&" "&time&"', '"&mensagem&"', '"&request("emailto")&"')")
conexao.execute("insert into TB_MOVIMENTACAO_SEGURADOS_EMAIL (id_movimentacao, userreg, datareg, mensagem, email) values ("&request("id")&", '"&request("nomex")&"', '"&databrx2(date)&" "&time&"', '"&replace(mensagem,"'","")&"', '"&request("emailto")&"')")

response.Write("<script>alert('Planilha enviada com sucesso!');</script>")
response.Write("<script>window.close();</script>")

end if

FechaConexao
end if%>


<%AbreConexao
set rs=conexao.execute("select * from TB_MOVIMENTACAO_SEGURADOS where id="&request("id")&"")
if not rs.eof then%>

	<table width="100%" border="0" style="border:solid; border-color:#000; border-width:1px;">
  <tr>
    <td colspan="2" align="center" style="background-color:#000; color:#FFF" height="40">MOVIMENTAÇÃO DE SEGURADOS</td>
  </tr>
  <tr>
    <td align="center" style="font-weight:bold;" colspan="2">Enviar email para o responsavel pela movimentação dentro da operadora</td>
  </tr>
  <tr>
    <td align="right" width="50%">Movimentação solicitada por</td>
    <td width="50%"><%=rs("userreg")%></td>
  </tr>
  <tr>
    <td align="right">Movimentação solicitada em</td>
    <td><%=databrx3(rs("datareg"))%> às <%=hour(rs("datareg"))%>:<%=minute(rs("datareg"))%></td>
  </tr>
  <tr>
    <td align="right">Cliente</td>
    <td>
    <%set cad=conexao.execute("select * from CADASTROGERAL where id="&rs("id_cliente")&"")
	if not cad.eof then%>
    	<%=cad("titular")%>
        <%titular=cad("titular")%>
    <%end if
	set cad=nothing%>
    </td>
  </tr>
  <tr>
    <td align="right">Contrato</td>
    <td>
    <%set con=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&rs("contrato")&"")
	if not con.eof then%>
    	<%=con("ramo")%> - <%=con("segmento")%> - <%=con("operadora")%><%if con("nome_amigavel")<>"" then%> - <%=con("nome_amigavel")%><%end if%>
    <%end if
	set con=nothing%>
    </td>
  </tr>
  <tr>
    <td align="right">Planilha</td>
    <td><%=rs("planilha")%></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <form action="home_movimentacao_site-envio.asp" method="post">
  <input type="hidden" name="id" value="<%=request("id")%>" />
  <input type="hidden" name="nomex" value="<%=request("nomex")%>" />
  <input type="hidden" name="envio" value="ok" />
  <tr>
    <td align="right">Assunto do email:</td>
    <td>
    <input type="text" name="assunto" class="boxZ" style="width:98%;" value="MOVIMENTAÇÃO SEGURO DE VIDA - <%=ucase(titular)%>" />
    </td>
  </tr>
  <tr>
    <td align="right">Enviar para o email:</td>
    <td><input type="text" name="emailto" class="boxZ" style="width:98%;" /></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
    <input type="submit" value="ENVIAR" />
    </td>
    </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </form>
  <tr>
    <td colspan="2" align="center" style="background-color:#000; color:#FFF" >Histórico de envios</td>
  </tr>
  <%set his=conexao.execute("select * from TB_MOVIMENTACAO_SEGURADOS_EMAIL where id_movimentacao="&request("id")&"")
  if not his.eof then
  while not his.eof%>
  <tr>
  	<td>Enviado por <%=his("userreg")%> em <%=databrx3(his("datareg"))%> para <strong><%=his("email")%></strong><br />
    </td>
  </tr>
  <%his.movenext
  wend
  end if%>
</table>


<%else%>
<div align="center">Movimentação não encontrada!</div>
<%end if%>
</body>
</html>
