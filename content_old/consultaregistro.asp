<!--#include file="db.asp"--><%
Response.Charset="ISO-8859-1"
AbreConexao
cpf=TRIM(replace(replace(request("cpf"),".",""),"-",""))
id_contrato = request("id_contrato")
tipo = request("tipo")
data = replace(request("data"),"_","/")
titular = trim(request("titular"))

if titular="n" then 'dependente
	SQL="Select * from TB_MOVIMENTACOES where replace(replace(cpf,'.',''),'-','')='"&cpf&"' and id_contrato="&id_contrato&" and tipo='"&tipo&"' and status<>'ANULADO' and status<>'concluida' "
	
else'titular confere a data de admissao

	SQL="Select * from TB_MOVIMENTACOES where replace(replace(cpf,'.',''),'-','')='"&cpf&"' and id_contrato="&id_contrato&" and tipo='"&tipo&"' and dadmissao='"&databrx22(data)&"' and status<>'ANULADO' and status<>'concluida' and aguardando='n'"
end if

'response.Write(SQL)
Set con=conexao.execute(SQL)
if not con.eof then
	id=con("id")
	nome=con("nome")
	cpfx=con("cpf")
	dataregx=con("datareg")
	protocolo=con("protocolo")
	statuss=con("status")
	msg="ok"

end if%>
<%if msg="ok" then%>
	{"id":"<%=id%>","nome":"<%=nome%>","cpf":"<%=cpfx%>","datareg":"<%=dataregx%>","protocolo":"<%=protocolo%>","status":"<%=statuss%>","tipox":"<%=tipo%>","contrato":"<%=id_contrato%>","tipo":"movimentacao"}
<%else
	'response.Write(cpf&"<br>")
	Set con2=conexao.execute("Select * from CADASTROGERAL where replace(replace(cpf,'.',''),'-','')='"&cpf&"' and idcadvenda="&id_contrato&" and status2='ATIVO' or replace(replace(cpf,'.',''),'-','')='"&cpf&"' and coproduto='"&id_contrato&"' and status2='ATIVO' ")
	if not con2.eof then
		id=con2("id")
		nome=con2("titular")
		cpfx=con2("cpf")
		dataregx=con2("dreg")%>
		
        {"id":"<%=id%>","nome":"<%=nome%>","cpf":"<%=cpfx%>","datareg":"<%=dataregx%>","contrato":"<%=id_contrato%>","tipo":"cadastro"}
	<%else%>
		{"id":"-","nome":"-","cpf":"-","datareg":"-"}
	<%end if%>
    
    
	
<%end if%>