<!--#include file="verifica.asp"-->
<%
 Response.CacheControl = "no-cache" 
 Response.Expires = -1 
 Response.Charset="ISO-8859-1"
 
 tempo=DateDiff("n",entradax, time)
 temporestante=60-tempo
 response.Write("")
 'Response.Write(time)
 calculo = (tempo*100)/60
%>
<span style="font-size:10px;">Tempo restante: <%=temporestante%> minutos</span>
<div style="width:100%; border:solid; border-width:1px; border-color:#666; text-align:center; border-radius:7px; height:10px;background-color:#F00;">
	<div style="width:<%=calculo%>%; height:10px; margin-top:-1px; margin-left:-1px; background-color:#FFF; border-radius:7px;">&nbsp;</div>
</div>
<%
' if request.Cookies("os")("idx")="1" and (hour(now) mod 2)=0 then
 ' if request.Cookies("op")("time2")="" then
	' response.Cookies("op")("time2")=request.Cookies("os")("idx")
	 'Response.Cookies("op")("time2").Expires = dateAdd("n", 10, Now())
	' Response.Cookies("os")("key").Expires = dateAdd("n", 10, Now())
   'end if
 'end if
%>
