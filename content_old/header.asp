<script>
function Carregahora(){
			setInterval(horamonitora, 1000);
		}
		function Carregarelogio(x){
			setInterval(aviso(x), 1000);
		}
		
		function horamonitora(){
			  $("#hora").load('relogio.asp');
		}
			
		function aviso(x){
			//alert(x);
			var entrada = x;
			
			// Obtém a data/hora atual
			var data = new Date();
			
			// Guarda cada pedaço em uma variável
			//var dia     = data.getDate();           // 1-31
			//var dia_sem = data.getDay();            // 0-6 (zero=domingo)
			//var mes     = data.getMonth();          // 0-11 (zero=janeiro)
			//var ano2    = data.getYear();           // 2 dígitos
			//var ano4    = data.getFullYear();       // 4 dígitos
			var hora    = data.getHours();          // 0-23
			var minu     = data.getMinutes();        // 0-59
			//var seg     = data.getSeconds();        // 0-59
			//var mseg    = data.getMilliseconds();   // 0-999
			//var tz      = data.getTimezoneOffset(); // em minutos
			
			var horaatual= hora+':'+ minu;
			
			var start = moment("'"+entrada+"'", "hh:mm");
			var end = moment("'"+horaatual+"'", "hh:mm");
			
			var resultado = end.diff(start, 'minutes');
			
			resultado = 60 - resultado;
			//alert(resultado);
			if (resultado<10){
				$('#ModalRelogio').modal(options)
			}else if (resultado<=0){
				alert('Você atingiu o tempo limite de sessão e será desconectado');
				window.location='https://portalcompacta.com.br/close.asp';
			}
		}
</script>
<header id="page-topbar">
    <div class="navbar-header">
        <div class="d-flex">
            <!-- LOGO -->
            <div class="navbar-brand-box">
                <a href="index.asp" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="assets\images\compactabeneficios.png" alt="" height="22">
                    </span>
                    <span class="logo-lg">
                        <img src="assets\images\compactabeneficios.png" alt="" height="20">
                    </span>
                </a>
                <a href="index.asp" class="logo logo-light">
                    <span class="logo-sm">
                        <img src="assets\images\compactabeneficios.png" alt="" height="22">
                    </span>
                    <span class="logo-lg">
                        <img src="assets\images\compactabeneficios.png" alt="" height="20">
                    </span>
                </a>
            </div>
            <button type="button" class="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn">
                <i class="fa fa-fw fa-bars"></i>
            </button>
            
            <div class="dropdown d-lg-inline-block d-lg-none ml-2">
                <div class="btn" style="color:#000; text-align:left;">
                	 <h4 class="mb-0"><%=titularx%><br /><small><%=nfantasia%> - <%=cnpjx%></small></h4>
                </div>
            </div>
        </div>

        <div class="d-flex">
            <div class="dropdown d-none d-lg-inline-block ml-1">
            	<div id="hora" class="btn" style="color:#000; text-align:center;">&nbsp;</div>
            </div>
            <div class="dropdown d-inline-block">
                <button type="button" class="btn header-item waves-effect" id="page-header-user-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img class="rounded-circle header-profile-user" src="assets\images\users\user.png" >
                    <span class="d-none d-xl-inline-block ml-1 font-weight-medium font-size-15"><%=userxy%></span>
                    <i class="uil-angle-down d-none d-xl-inline-block font-size-15"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-right">
                    <!-- item-->
                    <a class="dropdown-item" href="painel.asp?go=contratos"><i class="uil uil-wallet font-size-18 align-middle mr-1 text-muted"></i> <span class="align-middle">Meus Contratos</span></a>
                    <a class="dropdown-item" href="painel.asp?go=senha&id=<%=idxy%>"><i class="uil uil-user-circle font-size-18 align-middle text-muted mr-1"></i> <span class="align-middle">Alterar senha</span></a>
                    <a class="dropdown-item" href="close.asp"><i class="uil uil-sign-out-alt font-size-18 align-middle mr-1 text-muted"></i> <span class="align-middle">Sair</span></a>
                    <!-- item-->
                </div>
            </div>

            
        </div>
    </div>
</header>