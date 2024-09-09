// JavaScript Document
function validaData(str) { 

	dia = (str.value.substring(0,2)); 
    mes = (str.value.substring(3,5)); 
	ano = (str.value.substring(6,10)); 

	cons = true; 
	var tam = str.value;
	
	// verifica se foram digitados números
	if (isNaN(dia) || isNaN(mes) || isNaN(ano)){
		alert("Preencha a data somente com números."); 
		str.value = "";
		str.focus(); 
		return false;
	}
		
    // verifica o dia valido para cada mes 
    if ((dia < 01)||(dia < 01 || dia > 30) && 
		(mes == 04 || mes == 06 || 
		 mes == 09 || mes == 11 ) || 
		 dia > 31) { 
    	cons = false; 
	} 

	// verifica se o mes e valido 
	if (mes < 01 || mes > 12 ) { 
		cons = false; 
	} 

	// verifica se e ano bissexto 
	if (mes == 2 && ( dia < 01 || dia > 29 || 
	   ( dia > 28 && 
	   (parseInt(ano / 4) != ano / 4)))) { 
		cons = false; 
	} 
	if(tam.length != 10){
		alert("A data inserida não é válida: " + str.value); 
		str.focus();
		str.value = "";
		 
	}
		
    
	if (cons == false) { 
		alert("A data inserida não é válida: " + str.value); 
		str.value = "";
		str.focus(); 
		return false;
	} 
}

// colocar no evento onKeyUp passando o objeto como parametro
function formata(val)
{
   	var pass = val.value;
	var expr = /[0123456789]/;
		
	for(i=0; i<pass.length; i++){
		// charAt -> retorna o caractere posicionado no índice especificado
		var lchar = val.value.charAt(i);
		var nchar = val.value.charAt(i+1);
	
		if(i==0){
		   // search -> retorna um valor inteiro, indicando a posição do inicio da primeira
		   // ocorrência de expReg dentro de instStr. Se nenhuma ocorrencia for encontrada o método retornara -1
		   // instStr.search(expReg);
		   if ((lchar.search(expr) != 0) || (lchar>3)){
			  val.value = "";
		   }
		   
		}else if(i==1){
			   
			   if(lchar.search(expr) != 0){
				  // substring(indice1,indice2)
				  // indice1, indice2 -> será usado para delimitar a string
				  var tst1 = val.value.substring(0,(i));
				  val.value = tst1;				
 				  continue;			
			   }
			   
			   if ((nchar != '/') && (nchar != '')){
				 	var tst1 = val.value.substring(0, (i)+1);
				
					if(nchar.search(expr) != 0) 
						var tst2 = val.value.substring(i+2, pass.length);
					else
						var tst2 = val.value.substring(i+1, pass.length);
	
					val.value = tst1 + '/' + tst2;
			   }

		 }else if(i==4){
			
				if(lchar.search(expr) != 0){
					var tst1 = val.value.substring(0, (i));
					val.value = tst1;
					continue;			
				}
		
				if	((nchar != '/') && (nchar != '')){
					var tst1 = val.value.substring(0, (i)+1);

					if(nchar.search(expr) != 0) 
						var tst2 = val.value.substring(i+2, pass.length);
					else
						var tst2 = val.value.substring(i+1, pass.length);
	
					val.value = tst1 + '/' + tst2;
				}
   		  }
		
		  if(i>=6){
			  if(lchar.search(expr) != 0) {
					var tst1 = val.value.substring(0, (i));
					val.value = tst1;			
			  }
		  }
	 }
	
     if(pass.length>10)
		val.value = val.value.substring(0, 10);
	 	return true;
		
}
/* FIM VERIFICA NOVO*/
function VerificaTam(formname,elementname,nomeelem, tam){
	if (document.forms[formname].elements[elementname].value.length < tam){
		alert(nomeelem + " deve conter no mínimo " + tam + " caracteres");
		document.forms[formname].elements[elementname].select();
		document.forms[formname].elements[elementname].focus();
	}
}

function VerificaTamData(formname,elementname,nomeelem, tam){
	if (document.forms[formname].elements[elementname].value.length != tam){
		alert(nomeelem + " deve estar no formato dd/mm/aaaa");
		document.forms[formname].elements[elementname].select();
		document.forms[formname].elements[elementname].focus();
	}
}
		

/* Esta função recebe o nome de um formulário e um campo que deseja selecionar e enviar o foco */
function SetFocus(spanname, formname, elementname)
{
	if (navigator.appName!='Netscape')
	{
		if (document.all[spanname])
		{
			if (document.all[spanname].style.display == 'inline')
			{
				if (document.forms[formname])
				{
					if (document.forms[formname].elements[elementname])
					{
						document.forms[formname].elements[elementname].select();
						document.forms[formname].elements[elementname].focus();  
					}
				}
			}
		}
	}
	else
		if (document.forms[formname])
		{
			if (document.forms[formname].elements[elementname])
			{
				document.forms[formname].elements[elementname].select();
				document.forms[formname].elements[elementname].focus();  

			}
		}	
	
}

// JavaScript Document
function FormataData(formname, elementname, teclapres) {
	if (navigator.appName!='Netscape')
	{
		if (document.forms[formname])
		{		
			var num = "0123456789";
			var tecla = teclapres.keyCode;
			var vr = document.forms[formname].elements[elementname].value;
			vr = vr.substr(0, 10);
			if ( tecla != 9 && tecla != 8 ){
				for (var i = 0; i< vr.length; i++)
				{
					if (num.indexOf(vr.charAt(i)) == -1){vr = vr.replace(vr.charAt(i), ""); i--;}
				}
				document.forms[formname].elements[elementname].value = vr;
				var tam = vr.length + 1;
	
				if ( tam > 2 && tam < 5 )
					document.forms[formname].elements[elementname].value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 2 );
				if ( tam >= 5)
					document.forms[formname].elements[elementname].value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 2 ) + '/' + vr.substr( 4, 4 ); 
			}
		}
	}
}

function somenteNumero(campo){
    var digits="0123456789"
    var campo_temp 
    for (var i=0;i<campo.value.length;i++){
      campo_temp=campo.value.substring(i,i+1)    
      if (digits.indexOf(campo_temp)==-1){
            campo.value = campo.value.substring(0,i);
            break;
       }
    }
}

// JavaScript Document

function Mascara(tipo, campo, teclaPress) {
	if (window.event)
	{
		var tecla = teclaPress.keyCode;
	} else {
		tecla = teclaPress.which;
	}
 
	var s = new String(campo.value);
	// Remove todos os caracteres à seguir: ( ) / - . e espaço, para tratar a string denovo.
	s = s.replace(/(\.|\(|\)|\/|\-| )+/g,'');
 
	tam = s.length + 1;
 
	if ( tecla != 9 && tecla != 8 ) {
		switch (tipo)
		{
		case 'CPF' :
			if (tam > 3 && tam < 7)
				campo.value = s.substr(0,3) + '.' + s.substr(3, tam);
			if (tam >= 7 && tam < 10)
				campo.value = s.substr(0,3) + '.' + s.substr(3,3) + '.' + s.substr(6,tam-6);
			if (tam >= 10 && tam < 12)
				campo.value = s.substr(0,3) + '.' + s.substr(3,3) + '.' + s.substr(6,3) + '-' + s.substr(9,tam-9);
		break;
 		
		case 'CNPJ' :
 
			if (tam > 2 && tam < 6)
				campo.value = s.substr(0,2) + '.' + s.substr(2, tam);
			if (tam >= 6 && tam < 9)
				campo.value = s.substr(0,2) + '.' + s.substr(2,3) + '.' + s.substr(5,tam-5);
			if (tam >= 9 && tam < 13)
				campo.value = s.substr(0,2) + '.' + s.substr(2,3) + '.' + s.substr(5,3) + '/' + s.substr(8,tam-8);
			if (tam >= 13 && tam < 15)
				campo.value = s.substr(0,2) + '.' + s.substr(2,3) + '.' + s.substr(5,3) + '/' + s.substr(8,4)+ '-' + s.substr(12,tam-12);
		break;
 
		case 'TEL' :
			if (tam > 2 && tam < 4)
				campo.value = '(' + s.substr(0,2) + ') ' + s.substr(2,tam);
			if (tam >= 7 && tam < 11)
				campo.value = '(' + s.substr(0,2) + ') ' + s.substr(2,4) + '-' + s.substr(6,tam-6);
		break;
		
		case 'CEL' :
			if (tam > 2 && tam < 4)
				campo.value = '(' + s.substr(0,2) + ') ' + s.substr(2,tam);
			if (tam >= 8 && tam < 12)
				campo.value = '(' + s.substr(0,2) + ') ' + s.substr(2,5) + '-' + s.substr(7,tam-7);
		break;
 
		case 'DATA' :
			if (tam > 2 && tam < 4)
				campo.value = s.substr(0,2) + '/' + s.substr(2, tam);
			if (tam > 4 && tam < 11)
				campo.value = s.substr(0,2) + '/' + s.substr(2,2) + '/' + s.substr(4,tam-4);
		break;
		case 'CEP' :                       
		if (tam > 5 && tam < 7)                               
		campo.value = s.substr(0,5) + '-' + s.substr(5, tam);               
		break;
		
		case 'PLACA' :                       
		if (tam > 3 && tam < 5)                               
		campo.value = s.substr(0,3) + '-' + s.substr(3, tam);               
		break;
		
		case 'HORA' :                       
		if (tam > 2 && tam < 4)                               
		campo.value = s.substr(0,2) + ':' + s.substr(2, tam);               
		break;
		
		}
	}
}
function chkCpf (campo,valor) {

 

 strcpf = valor;

 str_aux = "";

 

 for (i = 0; i <= strcpf.length - 1; i++)

   if ((strcpf.charAt(i)).match(/\d/)) 

     str_aux += strcpf.charAt(i);

   else if (!(strcpf.charAt(i)).match(/[\.\-]/)) {

     alert ("O campo CPF apresenta caracteres inválidos !!!");

     campo.focus();

     return false;

   }

 

 if (str_aux.length != 11) {

   alert ("O campo CPF deve conter 11 dígitos !!!");

   campo.focus();

   return false;

 }

 

 soma1 = soma2 = 0;

 for (i = 0; i <= 8; i++) {

   soma1 += str_aux.charAt(i) * (10-i);

   soma2 += str_aux.charAt(i) * (11-i);

 }

 d1 = ((soma1 * 10) % 11) % 10;

 d2 = (((soma2 + (d1 * 2)) * 10) % 11) % 10;

 if ((d1 != str_aux.charAt(9)) || (d2 != str_aux.charAt(10))) {

   alert ("O CPF digitado é inválido !!!");

   campo.focus();

   return false;

 }



 return true;

}



// Verifica se o CNPJ é válido

function chkCnpj(s)

{

var i;

 //s = limpa_string(numero);

 var c = s.substr(0,12);

 var dv = s.substr(12,2);

 var d1 = 0;



 for (i = 0; i < 12; i++)

 {

  d1 += c.charAt(11-i)*(2+(i % 8));

 }

 

if (d1 == 0) return false;



       d1 = 11 - (d1 % 11);



if (d1 > 9) d1 = 0;



if (dv.charAt(0) != d1)

{

 return false;

}



 d1 *= 2;



 for (i = 0; i < 12; i++)

{

 d1 += c.charAt(11-i)*(2+((i+1) % 8));

}



d1 = 11 - (d1 % 11);



if (d1 > 9) d1 = 0;



if (dv.charAt(1) != d1)

{

 return false;

}

       return true;

}
function MascaraMoeda(objTextBox, SeparadorMilesimo, SeparadorDecimal, e){
    var sep = 0;
    var key = '';
    var i = j = 0;
    var len = len2 = 0;
    var strCheck = '0123456789';
    var aux = aux2 = '';
    var whichCode = (window.Event) ? e.which : e.keyCode;
    if (whichCode == 13) return true;
    key = String.fromCharCode(whichCode); // Valor para o código da Chave
    if (strCheck.indexOf(key) == -1) return false; // Chave inválida
    len = objTextBox.value.length;
    for(i = 0; i < len; i++)
        if ((objTextBox.value.charAt(i) != '0') && (objTextBox.value.charAt(i) != SeparadorDecimal)) break;
    aux = '';
    for(; i < len; i++)
        if (strCheck.indexOf(objTextBox.value.charAt(i))!=-1) aux += objTextBox.value.charAt(i);
    aux += key;
    len = aux.length;
    if (len == 0) objTextBox.value = '';
    if (len == 1) objTextBox.value = '0'+ SeparadorDecimal + '0' + aux;
    if (len == 2) objTextBox.value = '0'+ SeparadorDecimal + aux;
    if (len > 2) {
        aux2 = '';
        for (j = 0, i = len - 3; i >= 0; i--) {
            if (j == 3) {
                aux2 += SeparadorMilesimo;
                j = 0;
            }
            aux2 += aux.charAt(i);
            j++;
        }
        objTextBox.value = '';
        len2 = aux2.length;
        for (i = len2 - 1; i >= 0; i--)
        objTextBox.value += aux2.charAt(i);
        objTextBox.value += SeparadorDecimal + aux.substr(len - 2, len);
    }
    return false;
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



function x(){
		if (document.getElementById("cep").value==''){
		window.alert('Opção Invalida para consulta!');
	}else{
	
	http.open("GET", 'cepbr/cep.asp?cep='+document.getElementById("cep").value, true);
	http.onreadystatechange = handleHttpResponse;
	http.send(null);

	var arr; //array com os dados retornados
	function handleHttpResponse() {
		if (http.readyState == 4) 	{
			var response = http.responseText;
			eval("var arr = "+response); //cria objeto com o resultado
			document.getElementById("uf").value = arr.uf;
			document.getElementById("cidade").value = arr.cidade;
			document.getElementById("bairro").value = arr.bairro;
			document.getElementById("endereco").value = arr.logra+', '+arr.rua;
				
		}
	}
	}
}

function FormataCep(formname, elementname, teclapres) {
	if (navigator.appName!='Netscape')
	{
		if (document.forms[formname])
		{		
			var num = "0123456789";
			var tecla = teclapres.keyCode;
			var vr = document.forms[formname].elements[elementname].value;
			vr = vr.substr(0, 9);
			if ( tecla != 9 && tecla != 8 ){
				for (var i = 0; i< vr.length; i++)
				{
					if (num.indexOf(vr.charAt(i)) == -1){vr = vr.replace(vr.charAt(i), ""); i--;}
				}
				document.forms[formname].elements[elementname].value = vr;
				var tam = vr.length + 1;
	
				
				if ( tam >= 6)
					document.forms[formname].elements[elementname].value = vr.substr( 0, 5 ) + '-' + vr.substr( 5, 5 ); 
			}
		}
	}
}


function dois_pontos(tempo){
      if(event.keyCode<48 || event.keyCode>57){
        event.returnValue=false;}
      if(tempo.value.length==2 || tempo.value.length==5){
        tempo.value+=":";}
}
function valida_horas(tempo){
  while (tempo.value.length < 8){
      if(tempo.value.length==2 || tempo.value.length==5){
        tempo.value+=":";}
      tempo.value+="0";}

  horario = tempo.value.split(":");
  var horas = horario[0];
  var minutos = horario[1];
  var segundos = horario[2];
if(horas > 24){ 
  tempo.focus()
  Break} 
if(minutos > 59){
  tempo.focus()
  Break}
if(segundos > 59){
  tempo.focus()
  Break}
  
}

function confereInd(){
	if (document.getElementById("espera").value=='NÃO'){
	alert('Selecione um motivo de espera diferente de [NÃO]!');
	}else{
	document.getElementById("proxCorretor").value='sim';
	document.form1.submit();
	}
	}
	
function open_win(url_add)  {
   window.open(url_add,'welcome', 'width=800,height=450,menubar=no,status=yes,location=no,toolbar=no,scrollbars=yes');
   }
   
function conta(x,y,z) {
var totalChar = parseInt(document.getElementById(x).value.length);
maximo = y;
if (totalChar <= maximo) {
document.getElementById(z).innerText  = maximo - totalChar;
return true;
} else {
alert("Máximo de caracteres permitido!");
return false;
} 
}

function path(x){
	if (x=="etiqueta"){
	document.formd.action = "cliente/6080-Aniver.asp";
   
	}else if(x=="relatorio"){
	document.formd.action = "cliente/relMembroAniver2.asp";

	}
	
}