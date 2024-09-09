import { useAuth } from "../Auth/useAuth";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import axios from "axios";

function Header() {
    const {user} = useAuth();
    const {date} = useAuth();
    const {logout} = useAuth();

    const navigate = useNavigate();

    const [dados, setDados] = useState({});
    const [restante, setRestante] = useState({});

    useEffect(()=>{
        axios.get(`http://localhost:3001/header/${user}`)
        .then((result)=>{
            setDados(result.data)
        })
        .catch((err)=>console.log(err));
    },[])


    function ChamaHora(){
        setInterval(() => {
            const DataAtual = new Date();
            const DataEntrada= new Date(date);

            const diffMilissegundos = DataAtual - DataEntrada;
            const diffSegundos = diffMilissegundos / 1000;
            const diffMinutos = diffSegundos / 60;

            //console.log('Dife: '+diffMinutos);
            let restante=0;
            restante = 60 - diffMinutos;
            var porcentagem = diffMinutos*100/60;

            //console.log("Restante: "+restante)
            if (restante.toFixed(0)<0){
                logout();
                navigate('/login');
            }else{
               
                setRestante({
                    falta:restante.toFixed(0),
                    percorrido:diffMinutos,
                    porcentagem:porcentagem,
                }) ;
            }

            
          }, "5000");    //Atualiza o timer a cada 5 segundos
    }
 
    return ( 
        <header id="page-topbar">
            <div className="navbar-header">
                
                <div className="d-flex">
                    <div className="navbar-brand-box">
                        <a href="index.asp" className="logo logo-dark">
                            <span className="logo-sm">
                                <img src="assets\images\compactabeneficios.png" alt="" height="22"/>
                            </span>
                            <span className="logo-lg">
                                <img src="assets\images\compactabeneficios.png" alt="" height="20"/>
                            </span>
                        </a>
                        <a href="index.asp" className="logo logo-light">
                            <span className="logo-sm">
                                <img src="assets\images\compactabeneficios.png" alt="" height="22"/>
                            </span>
                            <span className="logo-lg">
                                <img src="assets\images\compactabeneficios.png" alt="" height="20"/>
                            </span>
                        </a>
                    </div>
                    <button type="button" className="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn">
                        <i className="fa fa-fw fa-bars"></i>
                    </button>
                    
                    <div className="dropdown d-lg-inline-block d-lg-none ml-2">
                        <div className="btn" style={{color: '#000', textAlign:'left'}}>
                            <h4 className="mb-0">{dados.titular}<br/>
                            <small>{dados.nomefantasia} - {dados.cnpj}</small>
                            </h4>
                        </div>
                    </div>
                </div>

                <div className="d-flex">
                    <div className="dropdown d-none d-lg-inline-block ml-1">
                        {
                            ChamaHora()
                        }
                        <div id="hora" className="btn" style={{color: '#000', textAlign: 'center'}}>
                        <span style={{fontSize:'10px'}}>
                            
                            Tempo restante: {restante.falta} min
                            </span>
                        <div style={{width: '100%', border:'solid', borderWidth: '1px', borderColor: '#666', textAlign: 'center', borderRadius: '7px', height:'10px', backgroundColor: '#F00'}}>
                            <div style={{width:restante.porcentagem+'%', height:'10px', marginTop: '-1px', marginLeft: '-1px', backgroundColor:'#fff', borderRadius: '7px'}}>&nbsp;</div>
                        </div>
                    </div>
                    </div>
                    <div className="dropdown d-inline-block">
                        <button type="button" className="btn header-item waves-effect" id="page-header-user-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img className="rounded-circle header-profile-user" src="assets\images\users\user.png"/>
                            <span className="d-none d-xl-inline-block ml-1 font-weight-medium font-size-15">{dados.user}</span>
                            <i className="uil-angle-down d-none d-xl-inline-block font-size-15"></i>
                        </button>
                        <div className="dropdown-menu dropdown-menu-right">
                            
                            <a className="dropdown-item" href="painel.asp?go=contratos">
                                <i className="uil uil-wallet font-size-18 align-middle mr-1 text-muted"></i>
                                <span className="align-middle">Meus Contratos</span>
                            </a>
                            <a className="dropdown-item" href="painel.asp?go=senha&amp;id=560">
                                <i className="uil uil-user-circle font-size-18 align-middle text-muted mr-1"></i> 
                                <span className="align-middle">Alterar senha</span>
                            </a>
                            <a className="dropdown-item" href="close.asp">
                                <i className="uil uil-sign-out-alt font-size-18 align-middle mr-1 text-muted"></i> 
                                <span className="align-middle">Sair</span>
                            </a>
                            
                        </div>
                    </div>

                    
                </div>
            </div>
        </header>
     );
}

export default Header;