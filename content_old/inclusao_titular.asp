<script>
	function AbreDiv(){
		alert('Preencha os dados da carta e envie para o email deman@compactasaude.com!');	
		window.open('CARTASEMCONTACORRENTE.pdf');
	}
	
	function openInfo(){
		if (document.getElementById('Info').style.display=='none'){
			document.getElementById('Info').style.display='block';
		}else{
			document.getElementById('Info').style.display='none';	
		}
	}
	
	
	function getHTTPObject() { 
	  var xmlhttp; 
	
	  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') { 
		try { 
		  xmlhttp = new XMLHttpRequest(); 
		} catch (e) { 
		  xmlhttp = false; 
		} 
	  } 
	  return xmlhttp; 
	} 
	var http = getHTTPObject();
	
	function ConsultaRegistro(x,y,w,k,a){
		
		if (document.getElementById("cpf").value==''){
			window.alert('Opção Invalida para consulta!');
		}else{
		 
		if (k!=0){
			var data = k.split('-');
			var admissao = data[2]+'_'+data[1]+'_'+data[0];
			
			//alert('consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&data='+admissao+'&titular='+a);
			http.open("GET", 'consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&data='+admissao+'&titular='+a, true);
		}else{
			//alert('consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&titular='+a);
			http.open("GET", 'consultaregistro.asp?cpf='+x+'&id_contrato='+y+'&tipo='+w+'&titular='+a, true);
		}
		
		http.onreadystatechange = handleHttpResponse;
		http.send(null);
	
		var arr; //array com os dados retornados
		function handleHttpResponse() 
		{
			if (http.readyState == 4) 
			{
				var response = http.responseText;
				eval("var arr = "+response); //cria objeto com o resultado
				//alert(arr.nome);
				if (arr.id!='-'){
				
				if (arr.tipo=='movimentacao'){
					window.alert('Encontramos uma solicitaçao em andamento para esse CPF!\nVocê será redirecionado para a tela de solicitações');
					window.location='index.asp?go=movimentacoes&pesq=ok&tipo='+arr.tipox+'&protocolo='+arr.protocolo+'&status='+arr.status;
				}else if (arr.tipo=='cadastro'){
					window.alert('O CPF '+arr.cpf+' se encontra ATIVO nesse contrato para o(a) beneficiario(a) '+arr.nome+'\n Você sera direcionado para o cadastro desse(a) beneficiario(a)');
					window.location='index.asp?go=contrato&id='+arr.contrato+'&pesq=ok&campo='+arr.cpf;
					
				}
				//window.location='index.asp?go=movimentacoes';
				//window.open('index.asp?go=movimentacoes')
				}
		
			}
		
		}
		}
	}
	
	
	function ConsultaVlrPlano(x,y,z,w){
		//alert(x);
		//alert(y);
		//alert(z);
		if (y==''){
			window.alert('Informe em qual PLANO deseja incluir esse beneficiário!');
		}else{
			//alert('consultaVlrPlano.asp?empresa='+x+'&contrato='+y+'&nome='+z);
			http.open("GET", 'consultaVlrPlano.asp?empresa='+x+'&contrato='+y+'&id='+z, true);
		
			http.onreadystatechange = handleHttpResponse;
			http.send(null);
		
			var arr; //array com os dados retornados
			function handleHttpResponse() 
			{
				if (http.readyState == 4) 
				{
					//alert(http.responseText);
					var response = http.responseText;
					eval("var arr = "+response); //cria objeto com o resultado
					//alert(arr.nome);
					/*
					if (w=='TABELA LINEAR'){
						if (arr.vlr!='-'){
							var valor=parseFloat(arr.vlr);
							document.getElementById('ValorAdesao').innerHTML='<br>O valor por beneficiário será de R$'+valor.toFixed(2);
						}
					}
					*/
					
					if (arr.acomodacao!='-'){
						document.getElementById('acomodacao').value=arr.acomodacao;
						document.getElementById('aco').innerHTML=arr.acomodacao;
					
					}
			
				}
			
			}
		}
	}
	
	
	function ConsultaData(x){
			//alert('consultaData.asp?dinicio='+x);
			http.open("GET", 'consultaData.asp?dinicio='+x, true);
		
			http.onreadystatechange = handleHttpResponse;
			http.send(null);
		
			var arr; //array com os dados retornados
			function handleHttpResponse() 
			{
				if (http.readyState == 4) 
				{
					//alert(http.responseText);
					var response = http.responseText;
					eval("var arr = "+response); //cria objeto com o resultado
					//alert(arr.nome);
					
					if (arr.data=='-'){
						alert('Impossivel prosseguir!\nA data de inicio da inclusao não pode ser inferior a data de hoje');
						document.getElementById('datainicio').value='';
					}
					
			
				}
			
			}
	}
	
	function ConsultaCongenere(x){
		//alert('consultaData.asp?dinicio='+x);
		http.open("GET", 'consultacongenere.asp?id='+x, true);
	
		http.onreadystatechange = handleHttpResponse;
		http.send(null);
	
		var arr; //array com os dados retornados
		function handleHttpResponse() {
			if (http.readyState == 4) {
				//alert(http.responseText);
				var response = http.responseText;
				eval("var arr = "+response); //cria objeto com o resultado
				//alert(arr.nome);
				
				if (arr.congenere!='-'){
					
					document.getElementById('congenere').innerHTML='Essa unidade/base/filial é atendida pela congênere <strong>'+arr.congenere+'</strong>';
				}
				
			}
		
		}
	}
	
	
		/**
	 * Implementação da requisição na web
	 */
	
	function jsonp(url, timeout) {
		// Gera um nome aleatório para a função de callback
		const func = 'jsonp_' + Math.random().toString(36).substr(2, 5);
	
		return new Promise(function(resolve, reject) {
			// Cria um script
			let script = document.createElement('script');
	
			// Cria um timer para controlar o tempo limite
			let timer = setTimeout(() => {
				reject('Tempo limite atingido');
				document.body.removeChild(script);
			}, timeout);
	
			// Cria a função de callback
			window[func] = (json) => {
				clearTimeout(timer);
				resolve(json);
				document.body.removeChild(script);
				delete window[func];
			};
	
			// Adiciona o script na página para inicializar a solicitação
			script.src = url + '?callback=' + encodeURI(func);
			document.body.appendChild(script);
		});
	}
	
	
	/**
	 * Consulta um CNPJ
	 */
	function consultaCNPJ(cnpj) {
		// Limpa o CNPJ para conter somente numeros, removendo traços e pontos
		cnpj = cnpj.replace(/\D/g, '');
	
		// Consulta o CNPJ na ReceitaWS com 60 segundos de tempo limite
		return jsonp('https://www.receitaws.com.br/v1/cnpj/' + encodeURI(cnpj), 60000)
			.then((json) => {
				if (json['status'] === 'ERROR') {
					alert('Erro ao consultar CNPJ!\nConfira os dados informados.');
					//return Promise.reject(json['message']);
					
				} else {
					//alert('OK');
					//console.log(json);
					
					document.getElementById('nome').value=json.nome;
					document.getElementById('telefone').value=json.telefone;
					document.getElementById('email').value=json.email;
					document.getElementById('cep').value=json.cep;
					document.getElementById('rua').value=json.logradouro;
					document.getElementById('numero').value=json.numero;
					document.getElementById('complemento').value=json.complemento;
					document.getElementById('bairro').value=json.bairro;
					document.getElementById('cidade').value=json.municipio;
					document.getElementById('uf').value=json.uf;
				}
			});
	}
	
	/**
	 * Consulta um CEP
	 */
	function consultaCEP(cep) {
		// Limpa o CEP para conter somente numeros, removendo traços e pontos
		cep = cep.replace(/\D/g, '');
	
		// Como a API retorna 404 com CEPs com tamanhos inválidos
		// Iremos validar antes para não ter que esperar o tempo limite do JSONP
		if (cep.length !== 8) return Promise.reject('CEP inválido');
	
		// Consulta o CEP na ViaCEP com 30 segundos de tempo limite
		return jsonp('https://viacep.com.br/ws/' + encodeURI(cep) + '/json/', 30000)
			.then((json) => {
				if (json['erro'] === true) {
					return Promise.reject('CEP não encontrado');
				} else {
					//return Promise.resolve(json);
					document.getElementById('rua').value=json.logradouro;
					document.getElementById('complemento').value=json.complemento;
					document.getElementById('bairro').value=json.bairro;
					document.getElementById('cidade').value=json.localidade;
					document.getElementById('estado').value=json.uf;
					
				}
			});
	}
</script>



<%AbreConexao
		set rs=conexao.execute("select * from CADASTROGERAL_VENDAS where idcadastro="&idx&" and id="&request("id")&"")
		if not rs.eof then
		
			
			'============ dados para regras ================
			tipotabela_titular=rs("tipotabela_titular")
			carencia=rs("carencia")
			aditivo_experiencia=rs("aditivo_experiencia")
			vencimento=rs("vencimento")
				if trim(rs("diafaturamento_inclusao"))<>"" then
					if month(now)=2 and trim(rs("diafaturamento_inclusao"))=30 then'se for fevereiro e dia 30, subtrair 2 dias para a regra funcionar
						corte = trim(rs("diafaturamento_inclusao")-2)&"/"&month(now)&"/"&year(now)
					else		
						corte = trim(rs("diafaturamento_inclusao"))&"/"&month(now)&"/"&year(now)
					end if
					'Se a data corte do mês atual tiver passado, joga a sugestao para o proximo mês
					'response.Write(day(now)&"<br>")
					'response.Write(cad("diafaturamento_inclusao")-4)
					if day(now)>=rs("diafaturamento_inclusao")-4 then
						mesvencimentox=DateAdd("m",1,corte)
						mesvencimento=month(mesvencimentox)
					else
						mesvencimentox=corte
						mesvencimento=month(now)
					end if
				
				else
				
					response.write("<script>alert('Erro! Entre em contato com suporte, e informe que a data corte de inclusão ou exclusão precisa ser preenchido!');</script>")
					response.Write("<script>history.back(-1);</script>")
					response.End()
				
				end if
					
				sugestao=mesvencimentox
				sugestao=databrx3(DateAdd("d",-4,sugestao))
				
				
				if rs("tipocobranca_inclusao")="MÊS CHEIO" then
				alerta1="Seu contrato tem data de vigência fixa, por esse motivo a próxima vigência será: "
					if trim(rs("data_vigencia_inclusao"))<>"" then
						if month(now)=2 and trim(rs("data_vigencia_inclusao"))=30 then'se for fevereiro e dia 30, subtrair 2 dias para a regra funcionar
							vigencia = year(now)&"-"&month(now)&"-"&trim(rs("data_vigencia_inclusao")-2)
						else		
							vigencia = year(now)&"-"&month(now)&"-"&trim(rs("data_vigencia_inclusao"))
						end if
						'Se a data corte do mês atual tiver passado, joga a sugestao para o proximo mês
						'response.Write(day(now)&"<br>")
						'response.Write(cad("diafaturamento_inclusao")-4)
						
						if int(rs("diafaturamento_inclusao"))>=int(rs("data_vigencia_inclusao")) then
						'//se o dia de corte for maior que o dia da vigencia
							
							'//se a data atual for maior que a data corte da fatura, aumenta dois meses
							if day(now)>=int(rs("diafaturamento_inclusao")) then
								vigenciax=DateAdd("m",2,vigencia)
							else
								vigenciax=DateAdd("m",1,vigencia)
							end if
							
						else
							if int(rs("diafaturamento_inclusao"))<day(now) then
							'// se ja tiver passado o dia de corte do mes atual, joga pro proximo mes
								vigenciax=DateAdd("m",1,vigencia)
							else
								vigenciax=vigencia
							end if
						end if
					
					else
					
						response.write("<script>alert('Erro! Entre em contato com suporte, e informe que a data de vigencia da inclusão precisa ser preenchido!');</script>")
						response.Write("<script>history.back(-1);</script>")
						response.End()
					
					end if
				else '===============PRO-RATA'
					if feriadox="s" or weekday(date)=1 then
						vigenciaxx=year(now)&"-"&month(now)&"-"&day(now)
						vigenciax=dateadd("d",1,vigenciaxx)
					elseif weekday(date)=7 then
						vigenciaxx=year(now)&"-"&month(now)&"-"&day(now)
						vigenciax=dateadd("d",2,vigenciaxx)
					else
						vigenciaxx=year(now)&"-"&month(now)&"-"&day(now)
						vigenciax=dateadd("d",1,vigenciaxx)
					end if
				end if
			'============ fim dados para regras ================
			
		
			set regra=conexao.execute("select * from CADASTROGERAL_VENDAS_FORMPORTAL where ramo='"&rs("ramo")&"' and segmento='"&rs("segmento")&"' and operadora='"&rs("operadora")&"' ")
			if not regra.eof then
				campo_nome=regra("campo_nome")
				campo_admissao=regra("campo_admissao")
				campo_cpf=regra("campo_cpf")
				campo_matricula=regra("campo_matricula")
				campo_nascimento=regra("campo_nascimento")
				campo_cns=regra("campo_cns")
				campo_rg=regra("campo_rg")
				campo_sexo=regra("campo_sexo")
				campo_estadocivil=regra("campo_estadocivil")
				campo_celular=regra("campo_celular")
				campo_email=regra("campo_email")
				campo_mae=regra("campo_mae")
				campo_cargo=regra("campo_cargo")
				campo_plano=regra("campo_plano")
				campo_endereco=regra("campo_endereco")
				campo_banco=regra("campo_banco")
				campo_pesoaltura=regra("campo_pesoaltura")
			else
				response.Write("<script>alert('Impossivel Prosseguir!\nSolicite ao Departamento de Manutenção e Relacionamento que cadastre as regras de formulario para esse contrato.');</script>")
				response.End()
			end if
			set regra=nothing
			
		%>




<%if request("gravar")="ok" then
	AbreConexao
	set rs=conexao.execute("select * from TB_MOVIMENTACOES order by id desc")
	if rs.eof then
		idp=1
	else
		idp=rs("id")+1
	end if
	set rs=nothing
	
	if request("datacob")<>"" then
		datacob="'"&request("datacob")&"'"
	else
		datacob="NULL"
	end if
	
	protocolo=right("00"&day(date),2)&right("00"&month(date),2)&year(date)&idp
	
		x1="id"
		x2=""&idp&""
		
	if campo_nome="s" then
		x1=x1&", nome"
		x2=x2&", '"&request("nome")&"'"
	end if
	
	if campo_admissao="s" then
		x1=x1&", dadmissao"
		x2=x2&", '"&databrx2(request("admissao"))&"'"
	end if
	
	if campo_cpf="s" then
		x1=x1&", cpf"
		x2=x2&", '"&request("cpf")&"'"
	end if
	
	if campo_matricula="s" then
		x1=x1&", matriculaf"
		x2=x2&", '"&request("matriculaf")&"'"
	end if
	
	if campo_nascimento="s" then
		x1=x1&", dnasc"
		x2=x2&", '"&request("dnasc")&"'"
	end if
	
	if campo_cns="s" then
		x1=x1&", cns"
		x2=x2&", '"&request("cns")&"'"
	end if
	
	if campo_rg="s" then
		x1=x1&", rg, rg_dataexpedicao, expedicaorg"
		x2=x2&", '"&request("rg")&"', '"&request("data_expedicaorg")&"', '"&request("expedicaorg")&"'"
	end if
	
	if campo_sexo="s" then
		x1=x1&", sexo"
		x2=x2&", '"&request("sexo")&"'"
	end if
	
	if campo_estadocivil="s" then
		x1=x1&", ecivil"
		x2=x2&", '"&request("ecivil")&"'"
	end if
	
	if campo_celular="s" then
		x1=x1&", tel"
		x2=x2&", '"&request("tel")&"'"
	end if
	
	if campo_email="s" then
		x1=x1&", email"
		x2=x2&", '"&request("email")&"'"
	end if
	
	if campo_mae="s" then
		x1=x1&", mae"
		x2=x2&", '"&request("mae")&"'"
	end if
	
	if campo_cargo="s" then
		x1=x1&", cargo"
		x2=x2&", '"&request("cargo")&"'"
	end if

	if campo_pesoaltura="s" then
		x1=x1&", peso, altura"
		x2=x2&", '"&request("peso")&"', '"&request("altura")&"'"
	end if
	
	if campo_plano="s" then
		x1=x1&", plano, acomodacao"
		x2=x2&", '"&request("plano")&"', '"&request("acomodacao")&"'"
	end if
	
	if campo_endereco="s" then
		x1=x1&", cep, rua, numero, complemento, bairro, cidade, estado"
		x2=x2&", '"&request("cep")&"', '"&replace(replace(request("rua"),"'",""),"*","")&"', '"&request("numero")&"', '"&request("complemento")&"', '"&replace(replace(request("bairro"),"'",""),"*","")&"', '"&replace(replace(request("cidade"),"'",""),"*","")&"', '"&request("estado")&"'"
	end if
	
	if campo_banco="s" then
		x1=x1&", banco, agencia, conta"
		x2=x2&", '"&request("banco")&"', '"&request("nagencia")&"', '"&request("conta")&"'"
	end if
	
	SQL="insert into TB_MOVIMENTACOES ("&x1&", dinicio, status, id_empresa, datareg, id_contrato, horareg, solpor, datacob, descricao, tipo, protocolo, centrodecusto, filial, aguardando) values("&x2&", '"&databrx2(request("datainicio"))&"', 'ENVIADO', "&idx&", '"&databrx2(DATE)&"', '"&request("id_contrato")&"', '"&time&"', '"&userxy&"', "&datacob&", '"&request.form("descricao")&"', 'INCLUSAO', '"&protocolo&"', '"&request("centrodecusto")&"', '"&request("filial")&"', 'n')"
	'response.Write(SQL)
	conexao.execute(SQL)
	
	
	set cont=conexao.execute("select * from CADASTROGERAL_VENDAS where id="&request("id_contrato")&" ")
	if not cont.eof then
		ramo=cont("ramo")
		operadora=cont("operadora")
	end if
	set cont=nothing
	
	
	
	
	'response.Write("<script>window.location='album/index.php?id="&idp&"&tipo=inclusao';</ script>")
	response.Write("<script>window.location='painel.asp?go=inclusao_pergunta&id="&idp&"';</script>")
	
	FechaConexao
end if%>



<div class="page-content">
    <div class="container-fluid">

        
        <!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0">Incluir Titular</h4>

                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="index.asp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="painel.asp?go=contratos">Contratos</a></li>
                            <li class="breadcrumb-item active">Incluir Titular</li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
        <!-- end page title -->

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">

                        <h4 class="card-title"><small>CONTRATO:</small> <%=rs("ramo")%> | <%=rs("operadora")%> | <%=rs("nome_amigavel")%></h4>
                        <p class="card-title-desc">
                       	Data corte - Inclus&atilde;o: <strong><%=rs("diafaturamento_inclusao")%></strong> <i class="fas fa-info-circle" title="A data ideal para a movimentação vigorar na proxima fatura é de 5 dias antes da data corte"></i><br>
                        Dia de vigência da Inclus&atilde;o: <strong><%=rs("data_vigencia_inclusao")%></strong> <i class="fas fa-info-circle" title="Solicita&ccedil;&otilde;es feitas ap&oacute;s a data corte, a cobrança ser&aacute; para a vig&ecirc;ncia do pr&oacute;ximo m&ecirc;s"></i><br>
                        Data corte - Exclus&atilde;o: <strong><%=rs("diafaturamento_exclusao")%></strong> <i class="fas fa-info-circle" title="*A data ideal para a movimentação vigorar na proxima fatura é de 5 dias antes da data corte"></i><br>
                        Dia de vencimento do boleto: <strong><%=rs("vencimento")%></strong><br />
                        Tipo de cobrança na inclusão: <strong><%=rs("tipocobranca_inclusao")%> </strong>
                        <%if rs("tipocobranca_inclusao")="MÊS CHEIO" then%>
                            <i class="fas fa-asterisk" title="Mês Cheio = Só existe um único dia para vigência da Inclusão"></i>
                        <%else%>
                            <i class="fas fa-asterisk" title="Pro Rata = Múltiplas datas de inclusão, após a data corte"></i>
                        <%end if%><br />
                        Tipo de cobrança na exclusão: <strong><%=rs("tipocobranca_exclusao")%></strong>
                        <%if rs("tipocobranca_exclusao")="MÊS CHEIO" then%>
                            <i class="fas fa-asterisk" title="Mês Cheio = Só existe um único dia para vigência da Inclusão"></i>
                        <%else%>
                            <i class="fas fa-asterisk" title="Pro Rata = Múltiplas datas de inclusão, após a data corte"></i>
                        <%end if%><br />
                        Dia de emissao da fatura: <strong><%=rs("data_emissao_fatura")%></strong><br />
                        
                        </p>
						<form action="painel.asp?go=inclusao_titular&gravar=ok" method="post" name="form01">
                		<input type="hidden" name="id" value="<%=request("id")%>" />
                        
                        <%'=====REGRA PARA DATA DE CORTE
							'se a data atual for maior que a data de corte 
						
						if corte<>"" then	
							
							if databrx3(date)>=databrx3(corte) then
								textoo="A data corte (fechamento) da sua fatura &eacute; todo dia "&rs("diafaturamento_inclusao")&".<br> As movimentações efetuadas após a data corte só aparecerão na fatura posterior ao proximo m&ecirc;s.<br>Se programe para solicitar suas movimenta&ccedil;&otilde;es com pelo menos 5 dias de antecedencia da data corte."
							else
								textoo=""
								textoo="A data corte (fechamento) da sua fatura &eacute; todo dia "&rs("diafaturamento_inclusao")&".<br> As movimentações efetuadas após a data corte só aparecerão na fatura posterior ao proximo m&ecirc;s.<br>Se programe para solicitar suas movimenta&ccedil;&otilde;es com pelo menos 5 dias de antecedencia da data corte."
							end if
						end if
							
						'======REGRA PARA AVISO DE HORARIO
						if weekday(now)=1 or weekday(now)=7 then'sabado e domingo
							aparece="s"
						elseif weekday(now)=2 or weekday(now)=3 or weekday(now)=4 or weekday(now)=5 then'segunda a quinta
							if hour(now)>16 then
								aparece="s"
							elseif hour(now)=16 and minute(now)>=30 then
								aparece="s"
							else
								aparece="n"
							end if
						elseif  weekday(now)=6 then'sexta feira
							if hour(now)>15 then
								aparece="s"
							else
								aparece="n"
							end if
						end if%>
						
					   <%if aparece="s" then%>
                       <div class="form-group row">
                            <div class="col-md-12">
                            	<div class="alert alert-border alert-border-warning alert-dismissible fade show mt-4 px-4 mb-0 text-center">
                                <i class="uil uil-exclamation-triangle d-block display-4 mt-2 mb-3 text-warning"></i>
                                <h5 class="text-warning">ATENÇÃO</h5>
                                <p>Em função do <strong>horário</strong>, essa movimentação só será executada no próximo dia útil!!</p>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                                </div>
                                
                            </div>
                       </div>
					   <%end if%>
					   <%if feriadox="s" then%>
                       <div class="form-group row">
                            <div class="col-md-12">
                            	<div class="alert alert-border alert-border-warning alert-dismissible fade show mt-4 px-4 mb-0 text-center">
                                <i class="uil uil-exclamation-triangle d-block display-4 mt-2 mb-3 text-warning"></i>
                                <h5 class="text-warning">ATENÇÃO</h5>
                                <p>Em função do <strong>feriado nacional</strong>, essa movimentação só será executada no próximo dia útil!!</p>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                                </div>
                                
                            </div>
                       </div>
					   <%end if%>
					   
						  <%operadora=rs("operadora")
                          dia=day(now)
                          mes=month(now)+1
                          
                          if operadora="SAUDE SISTEMA" then
                            if dia>=5 and dia<=15 then
                                vencimento=10
                            elseif dia>=16 and dia<=25 then
                                vencimento=20
                            elseif dia >=26 and dia>=4 then 
                                vencimento=30
                            end if
                            
                          elseif operadora="PROMED" then
                          end if
                          %>
                        
                        
                        
						
                        <%if campo_nome="s" then%>
                        	<div class="form-group row">
                                <label for="nome" class="col-md-2 col-form-label">Nome Completo</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="nome" id="nome" required>
                                </div>
                            </div>
                        <%end if
                        if campo_cpf="s" then%>
                          <div class="form-group row">
                               <label for="cpf" class="col-md-2 col-form-label">CPF</label>
                               <div class="col-md-10">
                                   <input class="form-control input-mask" data-inputmask="'mask': '999.999.999-99'" im-insert="true" type="text" name="cpf" id="cpf" required onblur="ConsultaRegistro(this.value,<%=request("id")%>,'INCLUSAO',document.form01.admissao.value,'s');">
                               </div>
                          </div>
                        <%end if
						if campo_matricula="s" then%>
                        	<div class="form-group row">
                                <label for="matriculaf" class="col-md-2 col-form-label">Matr&iacute;cula funcional</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="matriculaf" id="matriculaf" required>
                                </div>
                            </div>
                         <%end if
                         if campo_nascimento="s" then%>
                          
                         	<div class="form-group row">
                                <label for="dnasc" class="col-md-2 col-form-label">Data de Nascimento</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="date" name="dnasc" id="dnasc" required max="<%=databrx2(date)%>">
                                </div>
                            </div>
                         <%end if
						 if campo_cns="s" then%>
                         	<div class="form-group row">
                                <label for="cns" class="col-md-2 col-form-label">CNS</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="cns" id="cns" required>
                                </div>
                            </div>
                          <%end if
                          if campo_rg="s" then%>
                          	<div class="form-group row">
                                <label for="rg" class="col-md-2 col-form-label">RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="rg" id="rg" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="expedicaorg" class="col-md-2 col-form-label">&Oacute;rg&atilde;o Expedidor RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="expedicaorg" id="expedicaorg" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="data_expedicaorg" class="col-md-2 col-form-label">Data Expedi&ccedil;&atilde;o RG</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="date" name="data_expedicaorg" id="data_expedicaorg" required>
                                </div>
                            </div>
                          <%end if
						  if campo_sexo="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Sexo</label>
                                    <div class="col-md-10">
                                        <select name="sexo" id="sexo" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Masculino">Masculino</option>
                                			<option value="Feminino">Feminino</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
                          if campo_estadocivil="s" then%>
                          		<div class="form-group row">
                                    <label class="col-md-2 col-form-label">Estado Civil</label>
                                    <div class="col-md-10">
                                        <select name="ecivil" id="ecivil" class="form-control" required>
                                            <option value="">Selecione...</option>
                                            <option value="Solteiro">Solteiro</option>
                                            <option value="Casado">Casado</option>
                                            <option value="Vi&uacute;vo">Vi&uacute;vo</option>
                                            <option value="Outros">Outros</option>
                                        </select>
                                    </div>
                                </div>
                          <%end if
						  if campo_celular="s" then%>
                              <div class="form-group row">
                                   <label for="tel" class="col-md-2 col-form-label">Celular <i class="fas fa-info-circle" title="É necessário informar o número de celular do beneficiário para que se torne possível a comunicação entre o beneficiário e a operadora de saúde."></i></label>
                                   <div class="col-md-10">
                                       <input class="form-control input-mask" data-inputmask="'mask': '(99)99999-9999'" im-insert="true" type="text" name="tel" id="tel" required>
                                       
                                   </div>
                              </div>
                          <%end if
                          if campo_email="s" then%>
                              <div class="form-group row">
                                <label for="email" class="col-md-2 col-form-label">Email</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="email" name="email" id="email" required>
                                </div>
                              </div>
                          <%end if
						  if campo_mae="s" then%>
                              <div class="form-group row">
                                <label for="mae" class="col-md-2 col-form-label">Nome da M&atilde;e:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="mae" id="mae" required>
                                </div>
                              </div>
                          <%end if
                          if campo_cargo="s" then%>
                          	<div class="form-group row">
                                <label for="cargo" class="col-md-2 col-form-label">Cargo na Empresa:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="cargo" id="cargo" required>
                                </div>
                            </div>
                          <%end if
						  if campo_pesoaltura="s" then%>
                          	<div class="form-group row">
                                <label for="peso" class="col-md-2 col-form-label">Peso:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="peso" id="peso" required> kg
                                </div>
                            </div>
							<div class="form-group row">
                                <label for="altura" class="col-md-2 col-form-label">Altura:</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="altura" id="altura" required> 
                                </div>
                            </div>
                          <%end if%>

						  <%set ce=conexao.execute("select * from CADASTROGERAL_FILIAL where idcadastro="&idx&" order by nome asc")
						  if ce.eof then%>
						  	<input type="hidden" name="filial" value="0">
						  <%else%>
							<div class="form-group row">
								<label class="col-md-2 col-form-label">Unidade / Base:</label>
								
								
								<div class="col-md-6">
								<%if filialx<>"0" and filialx<>"" then
					
									fil=split(trim(filialx),",")
									for i=0 to ubound(fil)
										if sqlfil<>"" then
											sqlfil=sqlfil&" or idcadastro="&idx&" and id="&fil(i)&""
										else
											sqlfil="where idcadastro="&idx&" and id="&fil(i)&""
										end if
									next
									
									
									set ce=conexao.execute("select * from CADASTROGERAL_FILIAL "&sqlfil&" order by nome asc")%>
									<select name="filial" id="filial" class="form-control" required onchange="ConsultaCongenere(this.value);">
										<option value="">Selecione...</option>
										<%if not ce.eof then
										while not ce.eof%>
										<option value="<%=ce("id")%>"><%=ce("nome")%></option>
										<%ce.movenext
										wend%>
										<%end if
										set ce=nothing%>
									</select>
								
								<%else
									set ce=conexao.execute("select * from CADASTROGERAL_FILIAL where idcadastro="&idx&" order by nome asc")
									if not ce.eof then%>
									<select name="filial" id="filial" class="form-control" required  onchange="ConsultaCongenere(this.value);">
										<option value="">Selecione...</option>
										<%
										while not ce.eof%>
										<option value="<%=ce("id")%>"><%=ce("nome")%></option>
										<%ce.movenext
										wend%>
										<%set ce=nothing%>
									</select>
									<%else%>
										<input type="hidden" name="filial" value="0"> UNIDADE ÚNICA
									<%end if%>
								<%end if%>
								</div>
								<div class="col-md-4" id="congenere">
									
								</div>
							</div>
						<%end if
						set ce2=nothing%>
                        

						<%
						set ce2=conexao.execute("select * from CADASTROGERAL_CENTROS where idcadastro="&idx&" and idcadvenda="&rs("id")&" order by nome asc")
						if ce2.eof then%>
							<input type="hidden" name="centrodecusto" value="0">
						<%else%>
                        <div class="form-group row">
                            <label class="col-md-2 col-form-label">Centro de Custo:</label>    
                            
                            <div class="col-md-6">
                                <%if centrox<>"0" and centrox<>"" then
					
								cen=split(trim(centrox),",")
								for x=0 to ubound(cen)
									if sqlcen<>"" then
										sqlcen=sqlcen&" or idcadastro="&idx&" and idcadvenda="&rs("id")&" and id="&cen(x)&""
									else
										sqlcen="where idcadastro="&idx&" and idcadvenda="&rs("id")&" and id="&cen(x)&""
									end if
								next
								
								set ce=conexao.execute("select * from CADASTROGERAL_CENTROS "&sqlcen&" order by nome asc")
								if not ce.eof then%>
									<select name="centrodecusto" id="centrodecusto" class="form-control" required>
										<option value="">Selecione...</option>
										<%while not ce.eof%>
										<option value="<%=ce("id")%>"><%=ce("numero")%> - <%=ce("nome")%></option>
										<%ce.movenext
										wend%>
									</select>
								<%else  'nenhum centro encontrado pela pesquisa%>
									<select name="centrodecusto" id="centrodecusto" class="form-control" required>
										<option value="">Selecione...</option>
										<option value="0">NENHUM</option>
									</select>
								<%end if%>
							
							<%else
								set ce=conexao.execute("select * from CADASTROGERAL_CENTROS where idcadastro="&idx&" and idcadvenda="&rs("id")&" order by nome asc")
								if not ce.eof then%>
									<select name="centrodecusto" id="centrodecusto" class="form-control" required>
										<option value="">Selecione...</option>
										<%while not ce.eof%>
										<option value="<%=ce("id")%>"><%=ce("numero")%> - <%=ce("nome")%></option>
										<%ce.movenext
										wend%>
									</select>
								<%else 'nenhum centro encontrado pela pesquisa%>
									<select name="centrodecusto" id="centrodecusto" class="form-control" required>
                                        <option value="">Selecione...</option>
                                        <option value="0">NENHUM</option>
									</select>
								<%end if
								set ce=nothing%>
							<%end if%>
                            </div>
                        </div>
						<%end if
						set ce2=nothing%>
                        <div class="form-group row">
                            <label class="col-md-2 col-form-label">Contrato:</label>
                            <div class="col-md-6 col-form-label">
                            	<%=rs("ramo")%>-<%=rs("operadora")%>
                    			<input type="hidden" name="id_contrato" id="id_contrato" value="<%=rs("id")%>" />
                            </div>
                        </div>
                        
                        
                        
                        <%if campo_plano="s" then%>
                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Plano</label>
                                <div class="col-md-6">
                                    <%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where idcadastro="&idx&" and contrato="&request("id")&" and status='Ativo' ")
                                    if pla.eof then%>
                                         <input type="text" name="plano" id="plano" required />
                                    <%else%>
                                        <select name="plano" id="plano" class="form-control" onchange="ConsultaVlrPlano(<%=idx%>,<%=request("id")%>,this.value,'<%=tipotabela_titular%>');" required >
                                            <option value="">Selecione...</option>
                                            <%while not pla.eof%>
                                            <option value="<%=pla("id")%>"><%=ucase(pla("nome"))%> <%if rs("ramo")<>"ODONTO" then%>- <%=ucase(pla("acomodacao"))%><%end if%></option>
                                            <%pla.movenext
                                            wend%>
                                        </select>
                                    <%end if
                                    set pla=nothing%>
                                </div>
                            </div>
                          
                          
							  <%if rs("ramo")="SAUDE" then%>
                              <div class="form-group row">
                                    <label class="col-md-2 col-form-label">Acomodação:</label>
                                    <div class="col-md-10">
                                        <%set pla=conexao.execute("select * from CADASTROGERAL_PLANOS where idcadastro="&idx&" and contrato="&request("id")&" order by id desc")
                                        if pla.eof then%>
                                             <select name="acomodacao" id="acomodacao" class="form-control" required >
                                                <option value="">Selecione...</option>
                                                <option value="Enfermaria">Enfermaria</option>
                                                <option value="Apartamento">Apartamento</option>
                                            </select>
                                        <%else%>
                                            <input type="hidden" name="acomodacao" id="acomodacao" value="" />
                                            <strong id="aco"><span style="color:#F00; font-size:9px;">*Informe um plano acima</span></strong>
                                        <%end if
                                        set pla=nothing%>
                                        &nbsp;&nbsp;&nbsp;
                                        <span id="ValorAdesao" style="font-weight:bold; color:#F00;"></span>
                                    </div>
                              </div>
                              <%else%>
                                <input type="hidden" name="acomodacao" id="acomodacao" value="NENHUM" />
                              <%end if%>
                        <%end if%>
                        
                        <div class="form-group row">
                            <div class="col-md-12">
                            &nbsp;
                            </div>
                        </div>
                        
                        
                        	
                            <%if alerta1<>"" then%>
                            <div class="form-group row">	
								<div class="col-md-12">
                                    <div class="alert alert-border alert-border-warning alert-dismissible fade show mt-4 px-4 mb-0 text-center">
                                    <i class="uil uil-exclamation-triangle d-block display-4 mt-2 mb-3 text-warning"></i>
                                    <h5 class="text-warning">ATENÇÃO</h5>
                                    <p>*<%=alerta1%> <strong><%=databrx3(vigenciax)%></strong><br />*Essa data pode ser alterada caso aconteça pendências na movimentação ou outros impedimentos.<br>Se for necessário fazer a inclusão em outra data, diferente da informada acima, favor consultar a Equipe do Departamento de Manutenção e Relacionamento da COMPACTA.</p>
                                    </div>
                                </div>
							</div>
                            <%else%>
                            <div class="form-group row">    
								<div class="col-md-12">
                                    <div class="alert alert-warning alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
									<i class="uil uil-exclamation-triangle d-block display-4 mt-2 mb-3 text-warning"></i>
									
										<p class="text-left">
											A data que a movimentação será efetuada pode ser alterada caso aconteça pendências na movimentação ou outros impedimentos.
											<%if textoo<>"" then%>
												<br><%=textoo%>
											<%end if%>
										</p>
									</div>
									
                                    </div>
                                </div>
                            </div>
							<%end if%>
                       	
                        
                        
                        
                        <%if campo_admissao="s" then%>
                        <script>
						  	function AbreInfo(x,v,c,a,vigenciasugerida){
								//alert(x);	
								if (c=='n'){ //so entra se houver carencia para esse contrato

									if (a=='NAO - REGRA CONTRATUAL'){
										var iniciocontagem=0;
										var diferenca=30;
									}else if (a=='SIM - JANELA DE INCLUSAO APOS 30 DIAS DE EXPERIENCIA'){
										var iniciocontagem=31;
										var diferenca=60;
									}else if (a=='SIM - JANELA DE INCLUSAO APOS 45 DIAS DE EXPERIENCIA'){
										var iniciocontagem=46;
										var diferenca=75;
									}else if (a=='SIM - JANELA DE INCLUSAO APOS 60 DIAS DE EXPERIENCIA'){
										var iniciocontagem=61;
										var diferenca=90;
									}else if (a=='SIM - JANELA DE INCLUSAO APOS 90 DIAS DE EXPERIENCIA'){
										var iniciocontagem=91;
										var diferenca=120;
									}else if (a=='SIM - JANELA DE INCLUSAO APOS 120 DIAS DE EXPERIENCIA'){
										var iniciocontagem=121;
										var diferenca=150;

									}else if (a=='SIM - 0 a 45 DIAS'){
										var iniciocontagem=0;
										var diferenca=45;
									}else if (a=='SIM - 0 a 60 DIAS'){
										var iniciocontagem=0;
										var diferenca=60;
									}else if (a=='SIM - 0 a 90 DIAS'){
										var iniciocontagem=0;
										var diferenca=90;
									}else if (a=='SIM - 0 a 120 DIAS'){
										var iniciocontagem=0;
										var diferenca=120;
									}

									var d1 = new Date(x); //admissao
									var d2 = new Date(v); //vigencia
									var diff = moment(d2,"DD/MM/YYYY HH:mm:ss").diff(moment(d1,"DD/MM/YYYY HH:mm:ss"));
									var dias = moment.duration(diff).asDays();
									//console.log(dias); // 105
									
									<%if rs("tipocobranca_inclusao")="PRÓ-RATA" then%>
									//fazer um calculo - apartir de qual dia podemos aceitar a inclusao 
									var teste =moment(d1).format("YYYY-MM-DD");
									//console.log(d1);
									//console.log(teste);
									var iniciopermitido = moment(teste,"YYYY-MM-DD").add(iniciocontagem, "days");
									var limitepermitido = moment(d1,"DD/MM/YYYY").add(diferenca, "days");

									inicio=moment(iniciopermitido).format("YYYY-MM-DD");
									limite=moment(limitepermitido).format("YYYY-MM-DD");
									vigenciasugerida=moment(vigenciasugerida).format("YYYY-MM-DD");

									//console.log('inicio:'+inicio);
									//console.log('termino: '+limite);

									var datasugerida=document.getElementById('datainicio').value;

									if (moment(datasugerida).isBefore(inicio)){
										console.log('altera a data');
										document.getElementById('datainicio').value=inicio;
									}else{
										console.log('mantem a data sugerida:' +vigenciasugerida);
										document.getElementById('datainicio').value=vigenciasugerida;
										}
									<%end if%>

									if (dias<iniciocontagem) {
										document.getElementById('divtxtadmissao2').style.display='block';
										document.getElementById('divtxtadmissao').style.display='none';
										document.getElementById('BTNGRAVAR').style.display='none';
										
									}else{
										document.getElementById('divtxtadmissao2').style.display='none';
										document.getElementById('BTNGRAVAR').style.display='block';
										if (dias>diferenca) {
											document.getElementById('divtxtadmissao').style.display='block';
	
											document.getElementById('Div_isencao').innerHTML="<strong>1 - Baseado na data de admissão informada, a janela de inclusão desse usuário é  de "+moment(inicio).format("DD/MM/YYYY")+" até "+moment(limite).format("DD/MM/YYYY")+".<br>2 - O usuário que vigenciar fora da janela de inclusão será incluído com carências contratuais.<br>3 - Observar as regras contratuais do seu aditivo ou cláusula sobre o período de experiência.</strong>"
										}else{
											document.getElementById('divtxtadmissao').style.display='none';	
										}
									}
								}		
							}
						</script>
						<div class="form-group row">
                            <label for="admissao" class="col-md-2 col-form-label">Há aditivo de experi&ecirc;ncia?</label>
                            <label for="admissao" class="col-md-10 col-form-label">
								<%=rs("aditivo_experiencia")%>
							</label>
							
                        </div>
                        <div class="form-group row">
                            <label for="admissao" class="col-md-2 col-form-label">Data de Admiss&atilde;o na Empresa</label>
                            <div class="col-md-10">
                                <input class="form-control" type="date" name="admissao" id="admissao" required onblur="AbreInfo(this.value,document.getElementById('datainicio').value,'<%=carencia%>','<%=aditivo_experiencia%>','<%=vigenciax%>');" max="<%=databrx2(date)%>">
                            </div>
                        </div>
                        <div class="form-group row" id="divtxtadmissao" style="display:none;">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                    
                                <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                <h5 class="text-danger">ATENÇÃO</h5>
								<div id="Div_isencao"></div>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                                </div>
                                
                            </div>
                       	</div>

						<div class="form-group row" id="divtxtadmissao2" style="display:none;">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show mt-4 px-4 mb-0 text-center" role="alert">
                                                    
                                <i class="uil uil-exclamation-octagon d-block display-4 mt-2 mb-3 text-danger"></i>
                                <h5 class="text-danger">ATENÇÃO!</h5>
                                <p>A data escolhida para vigência dessa inclusão está fora da janela de inclusão de acordo com o aditivo de experiencia da empresa.<br><br>
								Para mais detalhes, consulte o aditivo de experiência ou contacte o departamento de Manutenção da Compacta Saúde.</p>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                                </div>
                            </div>
							
                       	</div>
						<%end if%>
                        
                        <div class="form-group row">
                            <label for="datainicio" class="col-md-2 col-form-label">Efetuar a inclus&atilde;o em</label>
                            <div class="col-md-10">
                                
                                <%if rs("tipocobranca_inclusao")="MÊS CHEIO" then%> 
                                    <strong><%=databrx3(vigenciax)%></strong>
                                    <input type="hidden" name="datainicio" id="datainicio" min="<%=databrx2(date)%>" required onblur="ConsultaData(this.value);" value="<%=databrx2(vigenciax)%>" class="form-control" >
                                <%else%>
                                    <input type="date" name="datainicio" id="datainicio" min="<%=databrx2(date)%>" required onblur="ConsultaData(this.value);" value="<%=databrx2(vigenciax)%>" class="form-control" >
                                <%end if%>
                            </div>
                        </div>
                        
                      
                      <%if campo_endereco="s" then%>
                      		<div class="form-group row">
                                   <label for="cep" class="col-md-2 col-form-label">CEP</label>
                                   <div class="col-md-10">
                                       <input class="form-control input-mask" data-inputmask="'mask': '99999-999'" im-insert="true" type="text" name="cep" id="cep" onBlur="consultaCEP(this.value);" required>
                                       
                                   </div>
                            </div>
                            <div class="form-group row">
                                <label for="rua" class="col-md-2 col-form-label">Endereço</label>
                                <div class="col-md-8">
                                    <input class="form-control" type="text" name="rua" id="rua" required>
                                </div>
                                <div class="col-md-2">
                                    <input class="form-control" type="text" name="numero" id="numero" placeholder="Numero" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="complemento" class="col-md-2 col-form-label">Complemento</label>
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="complemento" id="complemento" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                
                                <div class="col-md-4">
                                	<label for="bairro" class="col-md-6 col-form-label">Bairro</label>
                                    <input class="form-control" type="text" name="bairro" id="bairro" required>
                                </div>
                                <div class="col-md-4">
                                	<label for="cidade" class="col-md-6 col-form-label">Cidade</label>
                                    <input class="form-control" type="text" name="cidade" id="cidade" required>
                                </div>
                                <div class="col-md-4">
                                	<label for="estado" class="col-md-6 col-form-label">Estado</label>
                                    <select name="estado" id="estado" class="form-control" required>
                                        <option value="">Selecione...</option>
                                        <option value="AC">Acre</option>
                                        <option value="AL">Alagoas</option>
                                        <option value="AM">Amazonas</option>
                                        <option value="AP">Amapá</option>
                                        <option value="BA">Bahia</option>
                                        <option value="CE">Ceará</option>
                                        <option value="DF">Distrito Federal</option>
                                        <option value="ES">Espirito Santo</option>
                                        <option value="GO">Goiás</option>
                                        <option value="MA">Maranhão</option>
                                        <option value="MG">Minas Gerais</option>
                                        <option value="MS">Mato Grosso do Sul</option>
                                        <option value="MT">Mato Grosso</option>
                                        <option value="PA">Pará</option>
                                        <option value="PB">Paraíba</option>
                                        <option value="PE">Pernambuco</option>
                                        <option value="PI">Piauí</option>
                                        <option value="PR">Paraná</option>
                                        <option value="RJ">Rio de Janeiro</option>
                                        <option value="RN">Rio Grande do Norte</option>
                                        <option value="RO">Rondônia</option>
                                        <option value="RR">Roraima</option>
                                        <option value="RS">Rio Grande do Sul</option>
                                        <option value="SC">Santa Catarina</option>
                                        <option value="SE">Sergipe</option>
                                        <option value="SP">São Paulo</option>
                                        <option value="TO">Tocantins</option>
                                    </select>   
                                </div>
                            </div>
                            
                      
                      <%end if%> 
                      
                      	<div class="form-group row">
                                
                            <div class="col-md-12 text-center" id="BTNGRAVAR">
                                <button type="submit" class="btn btn-success waves-effect waves-light">
                                    <i class="uil uil-check mr-2"></i> GRAVAR
                                </button>
                            </div>
                        </div> 
                      </form>
                    </div>
                </div>
            </div> <!-- end col -->
        </div>
        <!-- end row -->

        
        <%end if
		set rs=nothing
		FechaConexao%>
        
    </div> <!-- container-fluid -->
</div>
<!-- End Page-content -->

                
                