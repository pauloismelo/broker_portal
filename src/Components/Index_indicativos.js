import axios from "axios";
import { useEffect, useState } from "react";

import { useAuth } from "../Auth/useAuth";
import Loading from "../forms/Loading.js";

function Index_indicativos() {
    const { user } = useAuth(); // pega o token que é configurado no useAuth
    const [dados, setDados] = useState(false);


    useEffect(()=>{
        try{
            const return_data = async () =>{
                const response = await axios.get(`http://localhost:3001/indicativos/${user}`);           
                setDados(response.data);
            }
            return_data();
        }catch{
            console.log('Erro catch!')
        }
    },[])
    
    return ( 
        dados ? (

            <div className="col-sm-6">
                <div className="row">
                    
                    <div className="col-sm-6">
                        
                        <div className="card">
                            <div className="card-body">
                                <div className="float-right mt-2">
                                    <div id="customers-chart"> </div>
                                </div>
                                <div>
                                    <h4 className="mb-1 mt-1"><span data-plugin="counterup">
                                        {dados ?
                                        dados.inc+dados.exc
                                        : '0'
                                        }
                                        </span></h4>
                                    <p className="text-muted mb-0">Movimentações Em aberto</p>
                                </div>
                                <p className="text-muted mt-3 mb-0"><span className="text-danger mr-1">{dados.inc}</span> Inclusões 
                                </p>
                                <p className="text-muted mt-3 mb-0"><span className="text-danger mr-1">{dados.exc}</span> Exclusões 
                                </p>
                            </div>
                        </div>
                    
                        
                        
                        <div className="card">
                            <div className="card-body">
                                <div className="float-right mt-2">
                                    <div id="growth-chart"></div>
                                </div>
                                <div>
                                    <h4 className="mb-1 mt-1">
                                        <span data-plugin="counterup">
                                        {dados ?
                                            dados.ocorrencias
                                        : '0'}
                                        </span></h4>
                                    <p className="text-muted mb-0">Ocorrências</p>
                                </div>
                                <p className="text-muted mt-3 mb-0"><span className="text-success mr-1">&nbsp;</span>&nbsp;
                                </p>
                            </div>
                        </div>
                        
                    </div> 
                    
                    <div className="col-sm-6">
                        
                        <div className="card">
                            <div className="card-body">
                                <div className="float-right mt-2">
                                    <div id="orders-chart"> </div>
                                </div>
                                <div>
                                    <h4 className="mb-1 mt-1"><span data-plugin="counterup">
                                        {dados ?
                                            dados.inc_concluida+dados.exc_concluida
                                        : '0'}
                                    
                                    </span></h4>
                                    <p className="text-muted mb-0">Movimentações concluidas</p>
                                </div>
                                <p className="text-muted mt-3 mb-0">
                                    <span className="text-success mr-1">{dados.inc_concluida}</span> Inclusões
                                </p>
                                <p className="text-muted mt-3 mb-0">
                                    <span className="text-success mr-1">{dados.exc_concluida}</span> Exclusões 
                                </p>
                            </div>
                        </div>
                    
                        
                        <div className="card">
                            <div className="card-body">
                                <div className="float-right mt-2">
                                    <div id="total-revenue-chart"></div>
                                </div>
                                <div>
                                    <h4 className="mb-1 mt-1"> <span data-plugin="counterup">
                                        {dados ?
                                            dados.pendencia
                                        : '0'}
                                        </span></h4>
                                    <p className="text-muted mb-0">Pendencias</p>
                                </div>
                                <p className="text-muted mt-3 mb-0"><span className="text-success mr-1">&nbsp;</span> &nbsp;
                                </p>
                            </div>
                        </div>
                    </div> 
                    
                </div>
            </div>
        )
                
        :
        (
            <div className="col-sm-6">
                <Loading/>
            </div>
        )
        

        
     );
}

export default Index_indicativos;