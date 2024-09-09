<%
response.Cookies("sso")("authi")=""
response.Cookies("sso")("senha")=""
response.Cookies("sso")("matricula")=""
response.Cookies("sso")("user")=""
response.Cookies("sso")("manager")=""

	Response.CacheControl = "no-cache" 
	Response.Expires = -1 
	Response.addHeader "pragma", "no-cache"

response.Write("<script>window.location='https://compactasaude.com.br';</script>")

%>