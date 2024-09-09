<!--#include file="db.asp"--><%
Response.Charset="ISO-8859-1"
AbreConexao

empresa = request("empresa")
contrato = request("contrato")
id = ucase(request("id"))
acomodacao = request("acomodacao")

SQL="Select * from CADASTROGERAL_PLANOS where idcadastro="&empresa&" and contrato="&contrato&" and id='"&id&"'  "

'response.Write(SQL)
Set con=conexao.execute(SQL)
if not con.eof then
	'vlr_enf=con("vlr_enf")
	'vlr_apa=con("vlr_apa")
	acomodacao=con("acomodacao")
	valor=con("valor_titular")
	msg="ok"
end if
FechaConexao
%>

<%
	if msg="ok" then%>
    	{"vlr":"<%=valor%>","acomodacao":"<%=ucase(acomodacao)%>"}
    <%else%>
    	{"vlr":"-","acomodacao":"-"}
    <%end if

%>
