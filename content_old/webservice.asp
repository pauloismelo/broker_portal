<!--#include file="db.asp"-->
<center>
<%	if request("cat")="exclusao" then
		folderx="docs_exclusao"
	else
		folderx="documentos"	
	end if

		dim objFS
		Set objFS = Server.CreateObject("Scripting.FileSystemObject")
		if request("cat")="exclusao" then
			folder=caminho&""&folderx
		else
			folder=caminho&""&folderx&"\"&request("id")
		end if
		'response.Write(folder)
		'response.Write("<br>")
		nfiles=0
		%>         
		<%if objFS.FolderExists(folder) then
		
			Set fs = server.CreateObject("Scripting.FileSystemObject") 
			Set pasta = fs.GetFolder(folder)%>
					
				<%FOR EACH file IN pasta.Files %>
                    <%nfiles=nfiles+1%>
                    <%if request("cat")="exclusao" then%>
                         <%if inStr(file.name,request("id")&"_")>0 then%>
                            <a href="http://portalcompacta.com.br/<%=folderx%>/<%=file.name%>" title="<%=formatnumber(file.size)%>kb | <%=file.datelastmodified%> | <%=file.type%>" target="_blank" class="ArialUni3nobVer"><%=ucase(replace(file.name,"%20"," "))%></a><br />
                         <%end if%>
                    <%else%>
                           <a href="http://portalcompacta.com.br/<%=folderx%>/<%=request("id")%>/<%=server.HTMLEncode(file.name)%>" title="<%=formatnumber(file.size)%>kb | <%=file.datelastmodified%> | <%=file.type%>" target="_blank" class="ArialUni3nobVer"><%=ucase(replace(server.HTMLEncode(file.name),"%20"," "))%></a><br />
                    <%end if%>
                <%NEXT%>
					  
				  <%if nfiles=0 then
                    response.Write("<font size=1>Nenhum arquivo encontrado!</font>")
                  end if
		else
			response.Write("<font size=1>Não foi realizado upload de arquivos nessa solicitação!</font>")
		end if%>
		
        </center>
        