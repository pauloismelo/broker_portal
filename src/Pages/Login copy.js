import  '../css/bootstrap.css';
import '../css/site.css';
import '../css/bootstrap-responsive.css';

import { useAuth } from '../Auth/useAuth';
import { useNavigate } from 'react-router-dom';

import logo from '../img/compactabeneficios.png'
import Input from '../forms/Input'
import Button from '../forms/Button'

import axios from 'axios'

import { useState } from 'react'

const DivLogo={
    float:'left',
    marginRight:'50px',
}

const DivTexto={
    float:'left',
    textAlign: 'left',
    color: '#fff',
}
   
function Login() {
    const [user, setUser] = useState([]);

    const {login} = useAuth();

    const navigate = useNavigate();

    //console.log(token)
    function handlechange(e) {
        setUser({...user,[e.target.name] : e.target.value});
        
    }

    const handleSubmit = (e) =>{
        e.preventDefault()
        //console.log(user);
        axios.post(`http://localhost:3001/login`, user)
        .then((response)=>{
            if(response.data.mensagem=='ok'){

                login( response.data.token );
                alert('Usuario logado com sucesso!');
                navigate('/');
            }else if(response.data.mensagem=='erro'){
                //chama mensagem
                alert('Erro!');
            }
            console.log(response);
            console.log('Response: '+response.data.mensagem);
        })
        .catch((err) => console.log(err));

    }

    return ( 
        <>
        <div className="navbar2 navbar2-fixed-top">
            <div className="navbar2-inner">
                <div className="container-fluid">
                    <a className="btn btn-navbar2" data-toggle="collapse" data-target=".nav-collapse">
                        <span className='icon-bar'></span>
                        <span className='icon-bar'></span>
                        <span className='icon-bar'></span>
                    </a>

                    <div style={{width:'100%'}}>
                        <div style={DivLogo}>
                            <img src={logo} width="120" style={{margin: '5px'}}/>
                        </div>

                        <div style={DivTexto}>
                        <a className={'brand'} href="index.asp" style={{color: '#fff'}}>
                            <strong style={{fontSize:'24px'}}>Portal do Cliente</strong> 
                            <br/>
                            <small style={{fontSize:'14px', fontStyle:'italic'}}>
                                Compacta Benef&iacute;cios - Sa&uacute;de, Odonto, Vida, Previd&ecirc;ncia e Seguros
                            </small> 
                            </a>
                        </div>
                    </div>
                    
                </div>

            </div>
        </div>

        <div className="container-fluid">
            <div className="row-fluid">
            
            <div className="span12 pagination-centered">
            
                <div className="well hero-unit">
                <h2>Seja bem vindo(a) ao Portal do Cliente!</h2>
                <p>Entre com os seus dados abaixo:</p>
                </div>
                
                <form className="form-horizontal" onSubmit={handleSubmit} >
                    <fieldset>
                        <div className="control-group">
                            <div className="controls2">
                                <Input type="text" text="CNPJ (Apenas numeros)" name="cnpj" handleOnChange={handlechange}/>
                                
                            </div>
                        </div>	
                        <div className="control-group">
                            <div className="controls2">
                                <Input type="mail" text="Email cadastrado" name="login" handleOnChange={handlechange}/>
                            </div>
                        </div>
                        <div className="control-group">
                            <div className="controls2">
                                <Input type="password" text="Senha" name="senha" handleOnChange={handlechange} />
                                
                            </div>
                        </div>
                        <div className="form-actions">
                           <Button tipo="submit" cor="success" value="Entrar"/>
                        </div>
                    </fieldset>
                </form>
                
            </div>
        
        </div>
        </div>
        </>
     );
}

export default Login;