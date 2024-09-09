<%
Set Conexao = CreateObject("ADODB.CONNECTION")
'conStr="Provider=SQLOLEDB;Data Source=189.113.160.110;Initial Catalog=compacta;User Id=compacta;Password=1974xd-1974c032"

conStr="Provider=SQLOLEDB;Data Source=45.164.92.21;Initial Catalog=compacta;User Id=compacta;Password=GJmizak!za1m"
ConexaoAberta = FALSE
Sub AbreConexao()
	if not ConexaoAberta then
	Conexao.Open ConStr
	ConexaoAberta = True
	end if
end sub
Sub FechaConexao()
	if ConexaoAberta then
	Conexao.close
	ConexaoAberta = False
	end if
end sub 


caminho=Request.ServerVariables("APPL_PHYSICAL_PATH")
dominio="compactasaude.com.br"
session.LCID=1033 'Idioma Americano
'session.LCID=1046 'Idioma Portugues Brasil


AbreConexao
set da=conexao.execute("select * from DADOS ")
if not da.eof then
	lote="http://www.iagentesms.com.br/webservices/"
	userxpac=da("iagente_user")
	passxpac=da("iagente_pass")
end if
set da=nothing


function databrx(x)
	databrx1=split(x,"-")
	databrx=databrx1(2)&"/"&databrx1(1)&"/"&databrx1(0)
end function



function databr(data)
	if data<>"" and data<>"NULL" then
		if len(day(data))=1 then
			dia = "0"&day(data)
		else
			dia = day(data)
		end if
		
		if len(month(data))=1 then
			mes = "0"&month(data)
		else
			mes = month(data)
		end if
		
		databr=year(data)&"-"&mes&"-"&dia
	else
		databr=data
	end if
end function





function databr2(datax)
	box=split(replace(datax,"'",""),"/")
	ano=box(2)
	mes=box(1)
	dia=box(0)
	databr2=dia&"/"&mes&"/"&ano
end  function


function databrx2(data)
	if data<>"" and data<>"NULL" then
		if len(day(data))=1 then
			dia = "0"&day(data)
		else
			dia = day(data)
		end if
		
		if len(month(data))=1 then
			mes = "0"&month(data)
		else
			mes = month(data)
		end if
		
		if len(year(data))=3 then
			ano = "20"&right(year(data),2)
		else
			ano = year(data)
		end if
		
		databrx2=ano&"-"&mes&"-"&dia
	else
		databrx2=data
	end if
end function

function databrx2_old(data)
'response.Write(data)
	if data<>"" and data<>"NULL" then
		if len(day(data))=1 then
			dia = "0"&day(data)
		else
			dia = day(data)
		end if
		
		if len(month(data))=1 then
			mes = "0"&month(data)
		else
			mes = month(data)
		end if
		
		if len(year(data))=3 then
			ano = "20"&right(year(data),2)
		else
			ano = year(data)
		end if
		
		databrx2_old=ano&"-"&mes&"-"&dia
	else
		databrx2_old=data
	end if
end function

function databrx22(data)
'response.Write(data)
	if data<>"" and data<>"NULL" then
		if len(day(data))=1 then
			dia = "0"&day(data)
		else
			dia = day(data)
		end if
		
		if len(month(data))=1 then
			mes = "0"&month(data)
		else
			mes = month(data)
		end if
		
		if len(year(data))=3 then
			ano = "20"&right(year(data),2)
		else
			ano = year(data)
		end if
		
		databrx22=ano&"-"&dia&"-"&mes
	else
		databrx22=data
	end if
end function

function databrx3(data)
'response.Write(data)
	if data<>"" and data<>"NULL" then
		if len(day(data))=1 then
			dia = "0"&day(data)
		else
			dia = day(data)
		end if
		
		if len(month(data))=1 then
			mes = "0"&month(data)
		else
			mes = month(data)
		end if
		
		databrx3=dia&"/"&mes&"/"&year(data)
	else
		databrx3=data
	end if
end function


function MoedaBrasileira(data)
'response.Write(data)
	
	
	if data<>"" and data<>"NULL" then
		variavel=replace(replace(formatnumber(data,2),",","/"),".",",")
		variavel=replace(variavel,"/",".")
		
		MoedaBrasileira=variavel
	else
		MoedaBrasileira=data
	end if
end function


Function SemAcento(txt) 
	
	if txt<>"" then
	saida=ucase(txt)
	
	saida=replace(saida,".","")
	saida=replace(saida,"(","")
	saida=replace(saida,")","")
	saida=replace(saida,"*","")
	saida=replace(saida,"&","E")
	saida=replace(saida,"Ç","C")
	
	saida=replace(saida,"Á","A")
	saida=replace(saida,"É","E")
	saida=replace(saida,"Í","I")
	saida=replace(saida,"Ó","O")
	saida=replace(saida,"Ú","U")
	saida=replace(saida,"á","a")
	saida=replace(saida,"é","e")
	saida=replace(saida,"í","i")
	saida=replace(saida,"ó","o")
	saida=replace(saida,"ú","u")
	
	saida=replace(saida,"À","A")
	saida=replace(saida,"È","E")
	saida=replace(saida,"Ì","I")
	saida=replace(saida,"Ò","O")
	saida=replace(saida,"Ù","U")
	saida=replace(saida,"à","a")
	saida=replace(saida,"è","e")
	saida=replace(saida,"ì","i")
	saida=replace(saida,"ò","o")
	saida=replace(saida,"ù","u")
	
	saida=replace(saida,"Â","A")
	saida=replace(saida,"Ê","E")
	saida=replace(saida,"Î","I")
	saida=replace(saida,"Ô","O")
	saida=replace(saida,"Û","U")
	saida=replace(saida,"ã","a")
	saida=replace(saida,"ê","e")
	saida=replace(saida,"î","i")
	saida=replace(saida,"ô","o")
	saida=replace(saida,"û","u")
	
	
	saida=replace(saida,"Ä","A")
	saida=replace(saida,"Ë","E")
	saida=replace(saida,"Ï","I")
	saida=replace(saida,"Ö","O")
	saida=replace(saida,"Ü","U")
	
	saida=replace(saida,"Ã","A")
	saida=replace(saida,"Õ","O")
	saida=replace(saida,"ã","a")
	saida=replace(saida,"õ","o")

	
	SemAcento = saida		
	 
	end if
End Function 

function AcrescentaZero(data)
	
	if(data<10) then
		saida="0"&data
	else
		saida=data
	end if
	
	AcrescentaZero=saida
	
end function%>
