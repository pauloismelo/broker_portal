import axios from "axios";
import { useEffect, useState } from "react";

import { useAuth } from "../Auth/useAuth";

function Index_bemvindo() {
    const { user } = useAuth(); // pega o token que � configurado no useAuth
    const [dados, setDados] = useState({});

    useEffect(()=>{
        axios.get(`http://localhost:3001/bemvindo/${user}`)
        .then((result)=>{
            //console.log(result.data)
            
            setDados(result.data);
        })
        .catch((err)=>console.log(err))
    },[])
    
    return ( 
            <div className="col-sm-6">
                <div className="card">
                    <div className="card-body">

                        <h5>Bem vindo !<br/></h5> 
                        <h2 className="text-primary mb-1">{dados.titular}</h2>
                        <h5>{dados.nomefantasia}</h5>

                        {/* Pegar o numero de  contratos 
                        pegar o numero de vidas 
                        
                        pegar o numero de movimentacoes*/}
                        
                        <div className="row mt-1 align-items-center">
                            <div className="col-12">
                                <p className="text-muted">
                                    <span className="text-success mr-1">{dados.contratos}</span> Contratos no total<br/>
                                    <span className="text-success mr-1">{dados.vidas}</span> Beneficiários ativos no total<br/>
                                    <span className="text-success mr-1">{dados.mov}</span> Movimentações no total<br/>
                                </p>

                                <div className="mt-3">
                                    <a href="painel.asp?go=perfil" className="btn btn-primary waves-effect waves-light">Ver Perfil
                                        <i className="uil uil-arrow-right"></i></a>
                                </div>
                            </div> 
                            
                        </div> 
                    </div> 
                </div>
            </div> 
       
     );
}

export default Index_bemvindo;