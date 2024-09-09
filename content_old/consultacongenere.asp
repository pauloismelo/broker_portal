<!--#include file="db.asp"--><%
Response.Charset="ISO-8859-1"
AbreConexao


id = request("id")

SQL="Select congenere from CADASTROGERAL_FILIAL where id="&id&"  "

'response.Write(SQL)
Set con=conexao.execute(SQL)
if not con.eof then
	if con("congenere")<>"" then
		SQL2="Select nome from CADASTROGERAL_VENDAS_CONGENERE where id="&con("congenere")&"  "
		'response.Write(SQL)
		Set con2=conexao.execute(SQL2)
		if not con2.eof then
			congenere=con2("nome")
		else
			congenere="-"
		end if
		set con2=nothing
	else
		congenere="-"	
	end if
end if
FechaConexao
%>


{"congenere":"<%=congenere%>"}
    