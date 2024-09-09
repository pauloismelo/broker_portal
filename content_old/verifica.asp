<!--#include file="db.asp"-->
<%
if request.Cookies("sso")("authi")="47sdjhj2266w8wh585872322--2-*/s+ws226ahwsn2GASS73H399E2111AS4877/**54225SS2S1871123344" then
	
	entradax = request.Cookies("sso")("entrada")
	prazo =DateAdd("n",60,entradax)
	aviso =DateAdd("n",50,entradax)
	
	'response.Write(entradax&"<br>")
	'response.Write(prazo&"<br>")
	'response.Write(time&"<br>")
	
	
	if prazo < time then
		response.Write("<script>alert('Voce atingiu o tempo limite de sessao e sera desconectado');</script>")
		response.Write("<script>window.location='https://portalcompacta.com.br/close.asp';</script>")
	else
		
		idx= request.Cookies("sso")("senha")
		cnpjx = request.Cookies("sso")("matricula")
		emailx = request.Cookies("sso")("login")
		cargox = request.Cookies("sso")("cargo")
		userx = split(request.Cookies("sso")("login"),"@")
		userxy = request.Cookies("sso")("user")
		idxy = request.Cookies("sso")("iduser")
		managerx = request.Cookies("sso")("manager")
		centrox = request.Cookies("sso")("centro")
		filialx = request.Cookies("sso")("filial")
		contrato_permitido = request.Cookies("sso")("contrato_permitido")
		AbreConexao
		set ca=conexao.execute("select * from CADASTROGERAL where id="&idx&"")
			titularx=ca("titular")
			razaosocial=ca("titular")
			nfantasia=ca("nomefantasia")
		set ca=nothing
		'------------------------------------
		set cli=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and status='ATIVO'  and esconde_contrato='n' or  idcadastro="&idx&" and status='ENVIADO' and esconde_contrato='n'")
		if not cli.eof then
		subfat=""
		operadorax=""
			while not cli.eof

				<!--
					
						set subf=conexao.execute("select id, subfaturadeidcx from CAIXAVENDAS where id="&cli("idvenda")&"  ")
						if not subf.eof then
							if subf("subfaturadeidcx")<>"0" then 'é uma subatura
								subfatx="s"
								id_principal=subf("subfaturadeidcx")
							else
								'VErifica se esse registro e matriz de alguma subfatura
								set subf2=conexao.execute("select id from CAIXAVENDAS where subfaturadeidcx="&cli("idvenda")&" order by id desc")
								if not subf2.eof then
									subfatx="s"
									id_principal=subf("id")
								end if       
								set subf2=nothing 
							end if
						end if
						set subf=nothing
				-->
					set op=conexao.execute("select id,nome from OPERADORAS where nome='"&ucase(cli("operadora"))&"'")
					if not op.eof then
						if operadorax="" then
							operadorax=op("id")
							contratox=cli("id")
						else
							operadorax=operadorax&","&op("id")
							contratox=contratox&","&cli("id")
						end if
						
						if nome_operadorax="" then
							nome_operadorax=op("nome")
						else
							nome_operadorax=nome_operadorax&","&op("nome")
						end if
						
						
					end if
			cli.movenext
			wend
		end if
		set cli=nothing
		'-----------------------------------
	end if
else
	
	response.Write("<script>window.location='https://portalcompacta.com.br/login.asp';</script>")
end if



'=======PEGA O DIA QUE A PASCOA CAIR�=======
Function EasterMonday(iYear)
 
  'Dim iMonth, iDay, iMoon, iEpact, iSunDay, iGold, iCent, iCorx, iCorz
 
  If IsNumeric (iYear) Then
    iYear = CInt(iYear)
 
    If (iYear >= 1583) And (iYear <= 8702) Then
      iGold = ((iYear Mod 19) + 1) 'the golden number of the year in the 19 year metonic cycle
      iCent = ((Int(iYear / 100)) + 1) 'calculate the century
      iCorx = (Int((3 * iCent) / 4) - 12) 'no. of years in which leap year was dropped in order to keep in step with the sun
      iCorz = (Int((8 * iCent + 5) / 25) - 5) 'special correction to syncronize easter with the moon's orbit
      iSunDay = (Int((5 * iYear) / 4) - iCorx - 10) 'find sunday
      iEpact = ((11 * iGold + 20 + iCorz - iCorx) Mod 30) 'set epact (specifies occurance of full moon

      If (iEpact < 0) Then
        iEpact = iEpact + 30
      End If
 
      If ((iEpact = 25) And (iGold > 11)) Or (iEpact = 24) Then
        iEpact = iEpact + 1
      End If
 
      iMoon = 44 - iEpact 'Find Full Moon

      If (iMoon < 21) Then
        iMoon = iMoon + 30
      End If
 
      iMoon = (iMoon + 7 - ((iSunDay + iMoon) Mod 7)) 'advance to sunday

      If (iMoon > 31) Then
        iMonth = 4
        iDay = (iMoon - 31)
      Else
        iMonth = 3
        iDay = iMoon
      End If
 
      EasterMonday = DateSerial(iYear, iMonth, iDay)
    Else
      EasterMonday = False
    End If
  Else
    EasterMonday = False
  End If
End Function

'=====VERIFICA SE HOJE � FERIADO
if date=cdate(EasterMonday(year(now)))-47 then 'ter�a-feira de carnaval
feriadox="s"
elseif date=cdate(EasterMonday(year(now)))-48 then 'segunda-feira de carnaval
feriadox="s"
elseif date=cdate(EasterMonday(year(now)))-2 then 'sexta-feira santa
feriadox="s"
elseif date=cdate(EasterMonday(year(now)))+60 then 'corpus christ
feriadox="s"
elseif date=cdate(EasterMonday(year(now))) then 'pascoa
feriadox="s"
elseif date="01/01/"&year(now) then 'confraterniza��o mundial
feriadox="s"
elseif date="21/04/"&year(now) then 'Tiradentes
feriadox="s"
elseif date="01/05/"&year(now) then 'Dia do trabalhador
feriadox="s"
elseif date="07/09/"&year(now) then 'Independencia
feriadox="s"
elseif date="12/10/"&year(now) then 'N. Sra. Aparecida
feriadox="s"
elseif date="02/11/"&year(now) then 'Todos os santos
feriadox="s"
elseif date="15/11/"&year(now) then 'Procl. Republica
feriadox="s"
elseif date="25/12/"&year(now) then 'Natal
feriadox="s"
else
feriadox="n"
end if
%>