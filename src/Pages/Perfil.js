
import { useAuth } from "../Auth/useAuth";
import { useState, useEffect } from "react";
import Loading from "../forms/Loading";

import axios from "axios";

function Perfil() {


    const {user} = useAuth();

    const [dados, setDados] = useState({});
    const [ocorrencias, setOcorrencias] = useState({});

    useEffect(()=>{
       

        try{
            const return_data2 = async () =>{
                const response2 = await axios.get(`http://localhost:3001/header/${user}`);           
                setDados(response2.data);
            }
            return_data2();
        }catch{
            console.log('Erro catch!')
        }


        
    },[])

    //console.log('Dados: '+dados);
    //console.log('Ocorrencias: '+ typeof ocorrencias);
    return ( 
        <>

            <div className="row">
                <div className="col-12">
                    <div className="page-title-box d-flex align-items-center justify-content-between">
                        <h4 className="mb-0">Meu perfil</h4>

                        <div className="page-title-right">
                            <ol className="breadcrumb m-0">
                                <li className="breadcrumb-item"><a href="/">Inicio</a></li>
                                <li className="breadcrumb-item active">Meu perfil</li>
                            </ol>
                        </div>

                    </div>
                </div>
            </div>
            

            <div className="row mb-12">
                <div className="col-xl-12">
                    <div className="card h-100">
                        <div className="card-body">
                            <div className="text-center">
                                <div className="dropdown float-right">
                                    <a className="text-body dropdown-toggle font-size-18" href="#" role="button" data-toggle="dropdown" aria-haspopup="true">
                                        <i className="uil uil-ellipsis-v"></i>
                                    </a>
                                    
                                    <div className="dropdown-menu dropdown-menu-right">
                                        <a className="dropdown-item" href="#">Alterar Dados</a>
                                        
                                    </div>
                                </div>
                                <div className="clearfix"></div>
                                <div>
                                    <img src="assets\images\users\user.png" alt="" className="avatar-lg rounded-circle img-thumbnail"/>
                                </div>
                                <h5 className="mt-3 mb-1">{dados.titular}</h5>
                                <p className="text-muted">&nbsp;</p>

                                
                            </div>

                            <hr className="my-4"/>

                            <div className="text-muted">
                            
                                
                                <div className="table-responsive mt-4">
                                    <div>
                                        <p className="mb-1">Usuário :</p>
                                        <h5 className="font-size-16">{dados.user}</h5>
                                    </div>
                                    <div>
                                        <p className="mb-1">Email :</p>
                                        <h5 className="font-size-16">{dados.user_email}</h5>
                                    </div>
                                    <div className="mt-4">
                                        <p className="mb-1">Cargo na empresa :</p>
                                        <h5 className="font-size-16">{dados.user_cargo}</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                
            </div>
            
        
        </>
     );
}

export default Perfil;