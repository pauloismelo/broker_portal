import { useState, useEffect } from "react";
import axios from "axios";
import { useAuth } from "../../Auth/useAuth";
import { FaSearch, FaPlusCircle, FaRegTrashAlt } from "react-icons/fa";
import { Link } from "react-router-dom";
import Loading from "../../forms/Loading";



function Contratos() {

    const {user} = useAuth();
    const [dados, setDados] = useState({});

    useEffect(()=>{

        try{
            const return_data2 = async () =>{
                const response2 = await axios.get(`http://localhost:3001/contratos/${user}`);           
                setDados(response2.data);
            }
            return_data2();
        }catch{
            console.log('Erro catch!')
        }

    },[])

    return ( 
        <>
            <div className="row">
                <div className="col-12">
                    <div className="page-title-box d-flex align-items-center justify-content-between">
                        <h4 className="mb-0">Contratos</h4>

                        <div className="page-title-right">
                            <ol className="breadcrumb m-0">
                                <li className="breadcrumb-item"><a href="/">Início</a></li>
                                <li className="breadcrumb-item active">Contratos</li>
                            </ol>
                        </div>

                    </div>
                </div>
            </div>


            <div className="row">
                <div className="col-12">
                    <div className="card">
                        <div className="card-body">

                            <p className="card-title-desc">Segue abaixo os contratos cadastrados para a sua empresa.
                            </p>

                            <table id="datatable" className="table table-bordered dt-responsive nowrap"  style={{borderCollapse: "collapse", borderSpacing: "0", width: "100%"}}>
                                <thead>
                                <tr>
                                    <th className="text-center">Consultar<br/>Beneficiário</th>
                                    <th>Contrato</th>
                                    <th className="text-center">Dia de<br/>Vencimento</th>
                                    <th className="text-center">Incluir<br/>Titular</th>
                                    <th className="text-center">Incluir<br/>Dependente</th>
                                    <th className="text-center">Excluir<br/>Beneficiário</th>
                                    
                                </tr>
                                </thead>

                              

                                <tbody>

                                {dados ? 
                                    dados.length>0 ?
                                        dados.map((value) => (
                                            
                                            <>
                                                <tr>
                                                    <td className="text-muted font-weight-semibold text-center">
                                                        <FaSearch/>
                                                    </td>
                                                    <td>
                                                        <h6 className="font-size-15 mb-1 font-weight-normal">{value.ramo} . {value.operadora} . {value.codigo}
                                                            <br /><small>{value.nome_amigavel}</small>
                                                        </h6>
                                                    </td>
                                                    <td><p className="text-muted font-size-13 mb-0 text-center">{value.vencimento}</p></td>
                                                    <td className="text-muted font-weight-semibold text-center">
                                                    {value.movimentacoes_autorizadas==='n' ?
                                                        <i className="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                                    : value.movimentacoes_autorizadas==='t' ?
                                                        <i className="fas fa-info-circle" title="As movimentações estão temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                                    :
                                                        value.status==='ATIVO' || value.status==='CADASTRO' ?
                                                            <Link to={`/painel/inclusao_titular/${value.id}`}>
                                                                <FaPlusCircle />
                                                            </Link>
                                                        : ''
                                                        
                                                    }
                                                    
                                                    
                                                    </td>
                                                    <td className="text-muted font-weight-semibold text-center">
                                                    {value.movimentacoes_autorizadas==='n' ?
                                                        
                                                        <i className="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderão ser efetivadas via portal."></i>
                                                    : value.movimentacoes_autorizadas==='t' ?
                                                        <i className="fas fa-info-circle" title="As movimentações estào temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                                    :
                                                        value.status==='ATIVO' || value.status==='CADASTRO' ?
                                                            <Link to={`/painel/contrato/${value.id}`}>
                                                                <FaPlusCircle />
                                                            </Link>
                                                        : ''

                                                    }
                                                    
                                                    </td>
                                                    <td className="text-muted font-weight-semibold text-center">

                                                    {value.movimentacoes_autorizadas==='n' ?
                                                        
                                                        <i className="fas fa-info-circle" title="Em função do aviso prévio emitido, as movimentações desse contrato não poderào ser efetivadas via portal."></i>
                                                    : value.movimentacoes_autorizadas==='t' ?
                                                        <i className="fas fa-info-circle" title="As movimentações estào temporariamente suspensas. Mais informa&ccedil;&otilde;es, contatar o Departamento de Manuten&ccedil;&atilde;o"></i>
                                                    :
                                                        value.status==='ATIVO' || value.status==='CADASTRO' ?
                                                            <Link to={`/painel/contrato/${value.id}`}>
                                                                <FaRegTrashAlt />
                                                            </Link>
                                                        : ''

                                                    }
                                                    
                                                    </td>
                                                </tr>
                                            </>

                                        ))
                                    :
                                    'Nenhum contrato encontrado'
                                :
                                    (
                                        <tr>
                                            <td colspan="6" align="center">
                                                <Loading/>
                                            </td>
                                        </tr>
                                    )
                                }

                               
                                
                              
                                
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div> 
            </div> 
        </>
     );
}

export default Contratos;