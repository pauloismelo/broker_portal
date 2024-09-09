import styles from './Login.module.css'

import { useAuth } from '../Auth/useAuth';
import { useNavigate } from 'react-router-dom';

import logo from '../img/compactabeneficios.png'
import Input from '../forms/Input'
import Button from '../forms/Button'

import axios from 'axios'

import { useState } from 'react'
import Message from '../forms/Message';


function Login() {
    const [user, setUser] = useState([]);
    const [message, setmessage] = useState();
    const [Type, setType] = useState();

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
            if(response.data.mensagem==='ok'){

                login( response.data.token );
                setmessage('Login efetuado com sucesso!')
                setType('success')  
                //alert('Usuario logado com sucesso!');
                setTimeout(() =>{
                    navigate('/');
                },3000)
                
            }else if(response.data.mensagem==='erro'){
                //chama mensagem
                setmessage('Erro ao efetuar o login. Tente novamente!')
                setType('error')  
                //alert('Erro!');
            }
            //console.log(response);
            //console.log('Response: '+response.data.mensagem);
        })
        .catch((err) => console.log(err));

    }

    return ( 
        <>
      

        <div className={styles.topbar}>
            <div className={styles.DivLogo}>
                <img src={logo} width="120" style={{margin: '5px'}}/>
            </div>

            <div className={styles.DivTexto}>
            <a href="index.asp" style={{color: '#fff'}}>
                <strong style={{fontSize:'24px'}}>Portal do Cliente</strong> 
                <br/>
                <small style={{fontSize:'14px', fontStyle:'italic'}}>
                    Compacta Benef&iacute;cios - Sa&uacute;de, Odonto, Vida, Previd&ecirc;ncia e Seguros
                </small> 
                </a>
            </div>
        </div>
                    
                
        <div className={styles.mediumbar}>
            <div>
            
            <div>
                <div>
                <h2>Seja bem vindo(a) ao Portal do Cliente!</h2>
                <p>Entre com os seus dados abaixo:</p>
                </div>
                {message && <Message type={Type} text={message} />}
                <form onSubmit={handleSubmit} >
                    <fieldset>
                        <div>
                            <Input type="text" text="CNPJ (Apenas numeros)" name="cnpj" align="center" handleOnChange={handlechange}/>
                        </div>	
                        <div>
                            <Input type="mail" text="Email cadastrado" name="login" align="center" handleOnChange={handlechange}/>
                        </div>

                        <div>
                            <Input type="password" text="Senha" name="senha" align="center" handleOnChange={handlechange} />
                            
                        </div>
                        <div>
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