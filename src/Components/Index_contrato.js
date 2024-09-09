import { useState, useEffect } from "react";
import { useAuth } from "../Auth/useAuth";

import axios from "axios";
import Loading from './../forms/Loading.js';

function Index_contrato() {

    const {user} = useAuth();
    const [contratos, setcontratos] = useState('');
   //console.log('contratos:'+ contratos)

    
    useEffect(()=>{
        try{
            const return_data = async () =>{
                const response = await axios.get(`http://localhost:3001/contratos/${user}`);           
                setcontratos(response.data);
            }
            return_data();
        }catch{
            console.log('Erro catch!')
        }
    },[])    
    
    

    return ( 
        <div className="col-xl-12">
            <div className="card">
                <div className="card-body">
                    <h4 className="card-title mb-4">Contratos</h4>

                    <div data-simplebar="" style={{maxHeight: '336px'}}>
                        <div className="table-responsive">
                            <table className="table table-borderless table-centered table-nowrap">
                                <thead>
                                    <tr>
                                        <th>Ramo</th>
                                        <th>Operadora</th>
                                        <th>Vig&ecirc;ncia</th>
                                        <th>Nome amig&aacute;vel</th>
                                        <th>C&oacute;digo</th>
                                        <th>Dia de Vencimento</th>
                                        <th>Data Corte<br />inclus&atilde;o</th>
                                        <th>Data Corte<br />exclus&atilde;o</th>
                                        <th>Mensalidade</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                {contratos ?
                                    contratos.length>0 ? (
                                        <tbody>

                                            {contratos.map((value)=>(
                                                <tr key={value.id}>
                                                    <td>{value.ramo}</td>
                                                    <td>{value.operadora}</td>
                                                    <td>{value.dvigencia}</td>
                                                    <td>{value.nome_amigavel}</td>
                                                    <td>{value.codigo}</td>
                                                    <td>{value.vencimento}</td>
                                                    <td>{value.diafaturamento_inclusao}</td>
                                                    <td>{value.diafaturamento_exclusao}</td>
                                                    <td>R$ {value.vlrmensalidade}</td>
                                                    <td>{value.status}</td>
                                                </tr>
                                            ))}

                                        </tbody>
                                        
                                    ) : (
                                        <tbody>
                                            <tr>
                                                <td colSpan="10" style={{textAlign:"center"}}>Nenhum contrato encontrado</td>
                                            </tr>
                                        </tbody>
                                    )
                                :  //Enquanto a solicitacao nao chega do backend, carrega o loading
                                (
                                    <tbody>
                                        <tr>
                                            <td colSpan="10">
                                                <Loading/>
                                            </td>
                                        </tr>
                                    </tbody>
                                )
                                    
                                } 
                                
                            </table>
                        </div>
                    </div> 
                    {/*
                    <%end if
                    set rs=nothing%>
                    */}
                    
                </div>
            </div> 
        </div>
     );
}

export default Index_contrato;