<%
diretorio=Request.ServerVariables("APPL_PHYSICAL_PATH")

diretorio=diretorio&"documentos\"&request("id")
'response.Write(diretorio)
'response.End()

Set ObjFS = Server.CreateObject("Scripting.FileSystemObject") 
If ObjFS.FolderExists(diretorio) = True then
Set objFolder = ObjFS.GetFolder(diretorio) 


For Each file in objFolder.files%>

	<li>
    <a href="documentos/<%=request("id")%>/<%=file.Name%>" TITLE='VISUALIZAR ARQUIVO' target=_blank><%=ucase(file.Name)%></a>
    &nbsp;&nbsp;&nbsp;Upload do Arquivo em: - <%=day(file.DateLastModified)%>/<%=month(file.DateLastModified)%>/<%=year(file.DateLastModified)%> às <%=hour(file.DateLastModified)%>:<%=minute(file.DateLastModified)%></li>

<%next
else
response.Write("<span style='color:#F00;'>Nenhum arquivo inserido!</span>")
end if

Set objFolder = Nothing 

%>