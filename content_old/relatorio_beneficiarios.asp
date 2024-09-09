<!--#include file="db.asp"-->


<%Response.CacheControl = "no-cache" 
Response.Expires = -1 
Response.addHeader "pragma", "no-cache"
server.ScriptTimeout=350
 'Response.Charset="ISO-8859-1"

AbreConexao

set cad=conexao.execute("select titular from CADASTROGERAL where id="&request("idcadastro")&"")
if not cad.eof then
	cliente=cad("titular")
end if
set cad=nothing

set cad=conexao.execute("select ramo, operadora, codigo, nome_amigavel, vencimento, dvigencia,diafaturamento_inclusao,diafaturamento_exclusao from CADASTROGERAL_VENDAS where id="&request("id")&"")%>
<style type="text/css">
.th {
	border-bottom-width: 3px;
	border-bottom-style: solid;
	border-bottom-color: #000;
}
.td {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000;
}
</style>

<div class="row-fluid">
	<div class="page-header">
        
        
        <table width="100%" border="0">
          <tr>
            <td colspan="2">
            	<table width="100%" border="0">
                  <tr>
                    <td width="30%" align="left">
                    	<img src="https://www.compactasaude.com.br/img/logo_beneficios.png" width="130"/>
                    </td>
                    <td width="70%" style="width:70%;" align="left">
                        <h2 style="width:100%; color:#036;">
                            <small>Relat&oacute;rio de Benefici&aacute;rios Ativos </small>
                        </h2>
                        
                        <h4 style="width:100%; color:#036;">
                            <small>
                            <%=cliente%><br />
                            Contrato: <%=cad("ramo")%>.<%=cad("operadora")%><br />Cod.: <%=cad("codigo")%> - <%=cad("nome_amigavel")%>
                            </small>
                        </h4>
                    </td>
                  </tr>
                </table>
            </td>
          <tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          <tr>
            <td width="50%" style="color:#036;">
            <h4>
            <small>
            VENCIMENTO DA FATURA: <span style="color:#000;"><%=cad("vencimento")%></span><br>
            VIG&Ecirc;NCIA: <span style="color:#000;"><%=databrx3(cad("dvigencia"))%></span><br />
            <%SQLB="select count(id) as total from cadastrogeral where  etitular='s' and idcadvenda='"&request("id")&"' and status2='ATIVO'  OR etitular='s' and coproduto='"&request("id")&"' and status2='ATIVO'"
            set com=conexao.execute(SQLB)
                titux=com("total")
            set com=nothing%>
            TITULARES ATIVOS: <span style="color:#000;"><%=titux%></span>
            </small>
            </h4>
            </td>
            <td width="50%" style="color:#036;">
            <h4>
            <small>
            
            CORTE DA FATURA P/ INCLUS&Atilde;O: <span style="color:#000;"><%=cad("diafaturamento_inclusao")%></span><br>
            CORTE DA FATURA P/ EXCLUS&Atilde;O: <span style="color:#000;"><%=cad("diafaturamento_exclusao")%></span><br>
            <%SQLC="select count(id) as total from cadastrogeral where etitular='n' and idcadvenda='"&request("id")&"' and status2='ATIVO' OR etitular='n' and coproduto='"&request("id")&"' and status2='ATIVO'   "
            set com=conexao.execute(SQLc)
                depex=com("total")
            set com=nothing%>
            DEPENDENTES ATIVOS: <span style="color:#000;"><%=depex%></span>
            
            </small>
            </h4>
            </td>
          </tr>
        </table>
			
  </div>





		
           	            
  <%SQL="select id,edependente,status2,titular,iddependente,redecontratada,idfilial,vlrmensalidadeatual from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='s' and status2='ATIVO' OR coproduto='"&request("id")&"' and etitular='s' and status2='ATIVO' order by titular asc"
				
	'response.Write(SQL)
	set rss=conexao.execute(SQL)%>
            <br />
			<table width="100%" border="0">
				<thead>
					<tr>
				  	  	<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px; text-align:center;"><strong>#</strong></th>
					  	<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px;"><strong>U</strong></th>
					  	<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px;"><strong>Nome</strong></th>
						<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px; text-align:center;"><strong>Plano</strong></th>
						<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px; text-align:center;"><strong>Unidade</strong></th>
						<th style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:2px; text-align:center;"><strong>Valor</strong></th>
					</tr>
				</thead>
                <tbody>
                <%x=0
				while not rss.eof
				x=x+1%>
				
				<tr>
				  	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; font-size:11px;"><%=x%></td>
				  	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
                        	<%if rss("edependente")="s" then%>D<%else%>T<%end if%>
                    </td>
				  	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; color:#000; font-size:11px;">
                        <%if rss("status2")="ATIVO" then%>
                            <%=rss("titular")%>
                        
                            <%if rss("edependente")="s" then%>
                            <%set ti=conexao.execute("select id,titular from CADASTROGERAL where id="&rss("iddependente")&" ")%>
                            <%if not ti.eof then%>
                            <DIV style="cursor:pointer;" onClick="window.location='index.asp?go=contrato&id=<%=request("id")%>&pesq=ok&centrodecusto=<%=request("centrodecusto")%>&campo=<%=ti("titular")%>';"><strong>Titular:</strong> <span style="font-size:11px;color:#06C "><%=ti("titular")%>
                                <%set ct=conexao.execute("select Count(id) as total from CADASTROGERAL where iddependente="&ti("id")&"")
                                    if ct("total")>0 then
                                        if ct("total")>1 then
                                            response.Write(" + <b>"&ct("total")&"</b> dependentes")
                                        else
                                            response.Write(" + <b>"&ct("total")&"</b> dependente")
                                        end if
                                    end if
                                set ct=nothing%></span>
                               </DIV>
                            <%end if%>
							<%set ti=nothing%>
                            <%end if%>
                        <%else%>
                        <span style="color:#F00;"><%=ucase(rss("titular"))%></span>
                        <%end if%>

                  	</td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
                    	<%if isnumeric(rss("redecontratada")) then%>
							<%set cad=conexao.execute("select nome,acomodacao from CADASTROGERAL_PLANOS where id="&rss("redecontratada")&" ")
                            if not cad.eof then%>
                                <%=cad("nome")%><br />(<%=cad("acomodacao")%>)
                                <%rede=cad("nome")&"<br>"&cad("acomodacao")%>
                            <%end if
                            set cad=nothing%>
                        <%else%>
                            <%=rss("redecontratada")%>
                            <%rede=rss("redecontratada")%>
                        <%end if%>
                    </td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
                    <%if rss("idfilial")<>"" then%>
                    <%set ce=conexao.execute("select nome from CADASTROGERAL_FILIAL where id="&rss("idfilial")&" and idcadastro="&request("idcadastro")&" or  numero="&rss("idfilial")&" and idcadastro="&request("idcadastro")&" ")%><%if not ce.eof then%><%=ucase(ce("nome"))%><%else%>MATRIZ<%end if%><%set ce=nothing%>
                    <%end if%>
                    </td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
						<%total=total+CDBL(rss("vlrmensalidadeatual"))%>
                        R$ <%=MoedaBrasileira(rss("vlrmensalidadeatual"))%>
                    </td>
				  </tr>
                <%if request("campo")="" then 'so aparecer se nao houver palavra na pesquisa
				
				set rs2=conexao.execute("select id,titular,iddependente,redecontratada,idfilial,vlrmensalidadeatual from CADASTROGERAL where idcadvenda="&request("id")&" and etitular='n' and edependente='s' and iddependente="&rss("id")&" and status2='ATIVO' or coproduto="&request("id")&" and etitular='n' and edependente='s' and iddependente="&rss("id")&" and status2='ATIVO' ")
				if not rs2.eof then
				while not rs2.eof
				x=x+1%>
                <tr>
                  	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; font-size:11px;"><%=x%></td>
				 	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
                    D
                    </td>
				  	<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; padding-left:20px; color:#000; font-size:11px;">
                       <%=ucase(rs2("titular"))%>
                    </td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">	
						<%=rede%>
                    </td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; font-size:11px;">&nbsp;</td>
					<td style="border-bottom:solid; border-bottom-color:#000; border-bottom-width:1px; text-align:center; color:#000; font-size:11px;">
                   		<%total=total+CDBL(rs2("vlrmensalidadeatual"))%>
                        R$ <%=MoedaBrasileira(rs2("vlrmensalidadeatual"))%>
                    </td>
				  </tr>
                <%rs2.movenext
				wend
				end if
				set rs2=nothing
				end if%>
				
				
                <%rede=""
				rss.movenext
				wend
				set rss=nothing%>
                <tr>
                	<td colspan="5"></td>
                    <td style="text-align:center; border:solid; border-width:3px; border-color:#000;">
                    <strong>R$ <%=MoedaBrasileira(total)%></strong>
                    </td>
                </tr>
                </tbody>
                
			</table>
		
		  	<p style="text-align:left; width:100%; color:#036; font-size:12px;">
            Emitido em <%=databrx3(date)%><br />
            <strong>Aten&ccedil;&atilde;o!</strong> <br />
            Esse relat&oacute;rio informa os usu&aacute;rios ATIVOS no PORTAL DE MOVIMENTA&Ccedil;&Atilde;O - COMPACTA.<br />
			Dependendo da operadora contratada, a fatura de usu&aacute;rios e o valor do boleto podem ser diferentes dos aqui apresentados, uma vez que a data de apura&ccedil;&atilde;o e data corte s&atilde;o diferentes entre si.<br />
			D&uacute;vidas consultar nosso Departamento de Manuten&ccedil;&atilde;o, obrigado!
        	</p>
          </div>
          