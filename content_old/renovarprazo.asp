<%
	response.Cookies("sso")("entrada")=""
	response.Cookies("sso")("entrada")=hour(now)&":"&minute(now)
	
	response.redirect("index.asp")
	response.End()
%>