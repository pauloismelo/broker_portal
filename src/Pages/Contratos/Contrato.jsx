import { useState, useEffect } from "react";
import axios from "axios";
import { Link, useParams } from "react-router-dom";
import Loading from "../../forms/Loading";
import Input from "../../forms/Input";
import { useAuth } from "../../Auth/useAuth";
import Button from "../../forms/Button";
import Select from "../../forms/Select";
import { FaPlusCircle, FaArrowDown, FaArrowUp , FaRegTrashAlt} from "react-icons/fa";

function Contrato() {
    const {user} = useAuth();
    const {id} = useParams();

    const [contrato, setContrato] = useState();

    const [datasearch, setDatasearch] = useState({});

    const [filiais, setFiliais] = useState([]);
    const [centros, setcentros] = useState([]);
    const [viewloading, setviewloading] = useState(false);

    const [users, setUsers] = useState([]);


    const tipos = [{id:'ATIVO', nome: 'ATIVOS'},{id:'NAO', nome: 'EXCLUIDOS'} ];


    function handlechange(e){
        setDatasearch({ ...datasearch, [e.target.name]: e.target.value})
    }
    
    function search(e){
        e.preventDefault();
        setviewloading(true);
        
        axios.post('http://localhost:3001/users', {
            nome:datasearch.nome,
            filial:datasearch.filial,
            centros:datasearch.centros,
            tipo:datasearch.tipo,
            idcontrato:id,
        }).then((response)=> {
            console.log(response.data)
            setviewloading(false)
            setUsers(response.data);
        });
    }
    

    useEffect(()=>{
        try{
            //Aqui preciso buscar as filiais e centro de custos
            const return_data = async () =>{
                const response = await axios.get(`http://localhost:3001/contrato/${id}`);           
                setContrato(response.data);

                const response2 = await axios.get(`http://localhost:3001/filiais/${user}`);    
                setFiliais(response2.data); 

                const response3 = await axios.get(`http://localhost:3001/centrodecustos/${user}`);
                setcentros(response3.data); 
            }
            return_data();

        }catch{
            console.log('Erro catch!')
        }

    },[])

    return ( 
        <>
        {contrato ?
            (
                <>
                    <div className="row">
                        <div className="col-12">
                            <div className="page-title-box d-flex align-items-center justify-content-between">
                                <h4 className="mb-0"><small>CONTRATO:</small> {contrato.ramo} | {contrato.operadora} | {contrato.nome_amigavel}</h4>

                                <div className="page-title-right">
                                    <ol className="breadcrumb m-0">
                                        <li className="breadcrumb-item"><a href="/">Home</a></li>
                                        <li className="breadcrumb-item">
                                            <Link to="/painel/contratos">Contratos</Link>
                                            
                                        </li>
                                        <li className="breadcrumb-item active">Contrato</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-12">
                            <form onSubmit={search} >
                                <div className="form-group row">
                                    <div className="col-md-3">
                                        <Input type="text" text="Nome" name="nome" placeholder="Digite o nome ou cpf do TITULAR" handleOnChange={handlechange} value={datasearch.nome ? datasearch.nome : ''}/>
                                    </div>
                                    <div className="col-md-2">
                                        <Select name="filial" text="Unidade/Base" options={filiais} handleOnChange={handlechange} value={datasearch.filial ? datasearch.filial : ''}/>
                                    </div>
                                    <div className="col-md-2">
                                        <Select name="centros" text="Centro de Custo" options={centros} handleOnChange={handlechange} value={datasearch.centros ? datasearch.centros : ''}/>
                                    </div>
                                    <div className="col-md-2">
                                        <Select name="tipo" text="Beneficiários" options={tipos} handleOnChange={handlechange} value={datasearch.tipo ? datasearch.tipo : ''} require="required"/>
                                    </div>
                                    
                                    <div className="col-md-1">
                                            <Button tipo="submit" cor="info" value="Pesquisar"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                  

                    {viewloading ? <Loading/> 
                    :
                    (
                        <>
                        <table id="datatable" className="table table-striped table-bordered dt-responsive nowrap" style={{borderCollapse:"collapse", borderSpacing: "0", width: "100%"}} >
                            <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>CPF</th>
                                <th>Plano</th>
                                <th>Unidade</th>
                                <th>Status</th>
                                <th>Incluir</th>
                                <th title="Solicitar alteração de plano para plano INFERIOR ou SUPERIOR ao atual">Down / UP</th>
                                <th>Excluir</th>
                            </tr>
                            </thead>
                            <tbody>
                            {users.length>0 &&
                                users.map((user) => (
                                    <>
                                    <tr key={user.id}>
                                        <td width="20%">
                                            {user.titular}
                                        </td>
                                        <td>
                                            {user.edependente==="s" ?
                                                <span className="badge badge-soft-primary font-size-12" title="Dependente">D</span>
                                            :
                                            <span className="badge badge-soft-primary font-size-12" title="Titular">T</span>
                                            }
                                        
                                        </td>
                                        <td> {user.cpf}</td>
                                        <td>
                                            {user.nome_plano}
                                        </td>
                                        <td>
                                            {user.nome_filial}
                                        </td>
                                        <td>
                                            {user.status}
                                        </td>
                                        <td>
                                            <FaPlusCircle/>
                                        </td>
                                        <td>
                                            <FaArrowUp/>&nbsp;<FaArrowDown/>
                                        </td>
                                        <td>
                                            <FaRegTrashAlt/>
                                        </td>
                                        
                                    </tr>
                                    </>

                                ))
                            }
                            </tbody>
                        </table>
                        </>
                    )
                    }
                </>
            )
        :
        (
            <div className="row">
                <div className="col-12">
                    <Loading/>
                </div>
            </div>
        )
        
        }
        </> 
    );

}


export default Contrato;