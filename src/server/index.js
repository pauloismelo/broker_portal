
 
require("dotenv").config();
const connStr = process.env.CONNECTION_STRING;
const port = process.env.PORT_BACKEND;

const express = require('express');
const app = express();

const cors = require('cors');

const jwt=require("jsonwebtoken");
const secret ="pc"

const sql = require("mssql");

app.use(cors());
app.use(express.json());

async function conecta(){
    try {
       await sql.connect(connStr);
       console.log("conectou!");
    }catch(err){
       console.error("Nao conecta!!!");
    }
 }

 conecta();

 function isNumber(value){

   if (parseInt(value)){
      return 1;
   }else{
      return 0;
   }
 }


 app.get("/header/:token", (req,res) => {
  
   const {token} = req.params;

   const idUser = jwt.verify(token, secret); //id do usuario logado

   sql.query(`select * from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
        
         const idCadastro =result.recordset[0].idcadastro;
         const user = result.recordset[0].nome;
         const user_email = result.recordset[0].login;
         const user_cargo = result.recordset[0].cargo;
         
         sql.query(`select * from cadastrogeral where id=${idCadastro}`)
         .then(result1=>{
            if (result1.rowsAffected > 0){
               //console.log(result1);
               const titular =result1.recordset[0].titular;
               const cnpj =result1.recordset[0].cnpj;
               const nomefantasia =result1.recordset[0].nomefantasia;

               res.send({
                  user:user,
                  user_email:user_email,
                  user_cargo:user_cargo,
                  titular:titular,
                  cnpj:cnpj,
                  nomefantasia:nomefantasia,
                  
               })
            }
         })
      }
   })
 })


 app.get("/bemvindo/:token", (req,res) => {
  
   const {token} = req.params;

   const idUser = jwt.verify(token, secret); //id do usuario logado

   sql.query(`select * from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result)
         const idCadastro =result.recordset[0].idcadastro;
         
         
         sql.query(`select * from cadastrogeral where id=${idCadastro}`)
         .then(result1=>{
            if (result1.rowsAffected > 0){
               //console.log(result1)

               sql.query(`select count(id) as total from cadastrogeral_vendas where idcadastro=${idCadastro} `)
               .then(result4=>{
                  if (result4.rowsAffected > 0){
                     const contratos=result4.recordset[0].total;

                     sql.query(`select count(id) as total from cadastrogeral where idempresa=${idCadastro} and status2='ATIVO'`)
                     .then(result5=>{
                        if (result5.rowsAffected > 0){
                           const vidas=result5.recordset[0].total;

                           sql.query(`select count(id) as total from tb_movimentacoes where id_empresa=${idCadastro} `)
                           .then(result6=>{
                              if (result6.rowsAffected > 0){
                                 const mov=result6.recordset[0].total;

                                 res.send({
                                    mensagem:"OK",
                                    idcadastro:idCadastro,
                                    iduser:idUser,
                                    titular:result1.recordset[0].titular,
                                    nomefantasia:result1.recordset[0].nomefantasia,
                                    contratos:contratos,
                                    vidas:vidas,
                                    mov:mov,
                                    
                                 })
                              }
                           })
                        }
                     }) 
                  }
               })
               

            }else{
               res.send({mensagem:"Erro"})
            }
         })
         .catch()
      }else{
         res.send({mensagem:"Erro"})
      }
   })
   .catch()
 })


 app.get("/indicativos/:token", (req,res) => {
  
   const {token} = req.params;

   const idUser = jwt.verify(token, secret); //id do usuario logado

   sql.query(`select * from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result)
         const idCadastro =result.recordset[0].idcadastro;
         
         sql.query(`select count(id) as total from TB_MOVIMENTACOES where id_empresa=${idCadastro} and status='ENVIADO' and tipo='INCLUSAO' and solicitacao_principal is null and aguardando='n'  or id_empresa=${idCadastro} and status='EXECUCAO' and tipo='INCLUSAO' and solicitacao_principal is null and aguardando='n'`)
         .then(result2=>{
            if (result2.rowsAffected > 0){
               const inc=result2.recordset[0].total;
               
               sql.query(`select count(id) as total from TB_MOVIMENTACOES where id_empresa=${idCadastro} and status='ENVIADO' and tipo='EXCLUSAO' and solicitacao_principal is null and aguardando='n'  or id_empresa=${idCadastro} and status='EXECUCAO' and tipo='EXCLUSAO' and solicitacao_principal is null and aguardando='n'`)
               .then(result3=>{
                  if (result3.rowsAffected > 0){
                     const exc=result3.recordset[0].total;

                     sql.query(`select count(id) as total from TB_MOVIMENTACOES where id_empresa=${idCadastro} and status='concluida' and tipo='INCLUSAO' and solicitacao_principal is null `)
                     .then(result4=>{
                        if (result4.rowsAffected > 0){
                           const inc_concluida=result4.recordset[0].total;

                           sql.query(`select count(id) as total from TB_MOVIMENTACOES where id_empresa=${idCadastro} and status='concluida' and tipo='EXCLUSAO' and solicitacao_principal is null `)
                           .then(result5=>{
                              if(result5.rowsAffected>0){
                                 const exc_concluida=result5.recordset[0].total;

                                 sql.query(`select count(id) as total from PORTALCLIENTE_OCORRENCIAS where id_cliente=${idCadastro} and status<>'CONCLUIDO' `)
                                 .then(result6=>{
                                    if (result6.rowsAffected>0){
                                       const ocorrencias = result6.recordset[0].total;
                                       
                                       sql.query(`select count(id) as total from TB_MOVIMENTACOES where id_empresa=${idCadastro} and status='COM_PENDENCIA' `)
                                       .then(result7=>{
                                          if(result7.rowsAffected>0){
                                             const pendencia = result7.recordset[0].total;

                                             res.send({
                                                mensagem:"OK",
                                                idcadastro:idCadastro,
                                                iduser:idUser,
                                                inc:inc,
                                                exc:exc,
                                                inc_concluida: inc_concluida,
                                                exc_concluida: exc_concluida,
                                                ocorrencias: ocorrencias,
                                                pendencia:pendencia,
                                             })
                                          }
                                       })
                                       
                                    }
                                 })
                                 
                              }
                           })

                           
                        }
                     })

                     

                  }
               })
            }
         })  

      }else{
         res.send({mensagem:"Erro"})
      }
   })
   .catch()
 })



 app.post("/login", (req,res) => {
   
   const {cnpj} = req.body;
   const {login} = req.body;
   const {senha} = req.body;

   const cnpj2= cnpj.replace(".","").replace("-","").replace("/","");
   
   
   sql.query(`select * from cadastrogeral WHERE REPLACE(REPLACE(REPLACE(CNPJ,'.',''),'-',''),'/','')= '${cnpj2}' `)
   .then(result =>{
      //console.log(result)
      if (result.rowsAffected > 0){
         //console.log(result.recordset[0].id)
         sql.query(`select * from cadastrogeral_usuarios where idcadastro=${result.recordset[0].id} and login='${login}' and senha= '${senha}' and status='ATIVO'`)
         .then(result1 =>{
            
            if (result1.rowsAffected > 0){
               const token = jwt.sign(result1.recordset[0].ID, secret);
               res.send({mensagem: "ok", token: token});
            }else{
               res.send({mensagem: "erro"});
            }          
         })
         .catch(err=>console.log(err))

     }else{
         res.send({mensagem: "erro"});
         
     }
   })
   .catch(err => console.log(err))
 })
 

app.get("/contratos/:token", (req,res) => {

   const {token} = req.params;

   const idUser = jwt.verify(token, secret); //id do usuario logado
   sql.query(`select idcadastro,idcontrato_permitido from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result)
         const idCadastro =result.recordset[0].idcadastro;
         const idcontrato_permitido =result.recordset[0].idcontrato_permitido;

         if (idcontrato_permitido!=0){
            const con=idcontrato_permitido.split(",");
            let sqlcon="";

            for (const x=0; x<=con.length; x++){
               if(sqlcon.length===0){
                  sqlcon=`where idcadastro=${idCadastro} and id=${con(x)} and status='ATIVO' and esconde_contrato='n' `;
               }else{
                  sqlcon=sqlcon+` or idcadastro=${idCadastro} and id=${con(x)} and status='ATIVO' and esconde_contrato='n' `;
               }
            }

            sqlgeral=`select * from cadastrogeral_vendas ${sqlcon}`
         }else{
            sqlgeral=`select * from cadastrogeral_vendas where idcadastro=${idCadastro} and status='ATIVO' and esconde_contrato='n'`
         }

         sql.query(sqlgeral)
         .then( result1=>{
            if(result1.rowsAffected>0){
               //console.log(result1)
               res.send(
                  result1.recordset)
            }
         })
         
      }
   })
   
})

app.get ("/contrato/:id", (req,res) =>{
   const {id} = req.params;

   sql.query(`select * from cadastrogeral_vendas where id=${id}`)
   .then( result =>{
      if(result.rowsAffected>0){
         //console.log(result.recordset)
         //res.send(result.recordset);
         res.send({
            ramo:result.recordset[0].ramo,
            segmento:result.recordset[0].segmento,
            operadora:result.recordset[0].operadora,
            nome_amigavel:result.recordset[0].nome_amigavel,

         })
      }
   })
})

app.get("/filiais/:token", (req,res) => {
   const {token} = req.params;
   const idUser = jwt.verify(token, secret); //id do usuario logado
   sql.query(`select idfilial,idCadastro from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result)
         const idfilial =result.recordset[0].idfilial;
         const idCadastro =result.recordset[0].idCadastro;
         //console.log(idCadastro);
         if (idfilial==='0' && idfilial!=''){
            //Here i search all Filiais of the account
            
            sql.query(`select id,nome from CADASTROGERAL_FILIAL where idcadastro=${idCadastro} order by numero asc`)
            .then( result1=>{
               if(result1.rowsAffected>0){
                  //console.log(result1.recordset)
                  res.send(result1.recordset)
               }
            })

         }else{
            // here i need make a loop for search the filiais allowed for this user
            const array_filiais = idfilial.split(',');
            for (let x=0; x<=idfilial.length; x++){
               sql.query(`select id,nome from CADASTROGERAL_FILIAL where idcadastro=${idCadastro} and id=${parseInt(array_filiais[x])} order by numero asc`)
               .then( result1=>{
                  if(result1.rowsAffected>0){
                     //console.log(result1)
                     res.send(result1.recordset)
                  }
               })
            }



         }

         
      }
   })
})

app.get("/centrodecustos/:token", (req,res) => {
   const {token} = req.params;
   const idUser = jwt.verify(token, secret); //id do usuario logado
   sql.query(`select idcentro, idCadastro from cadastrogeral_usuarios where id=${idUser}`)
   .then( result =>{
      if (result.rowsAffected > 0){
         
         const idcentro =result.recordset[0].idcentro;
         const idCadastro =result.recordset[0].idCadastro;

         if (idcentro==='0' && idcentro!=''){
            //Here i search all Filiais of the account
            
            sql.query(`select id,nome from CADASTROGERAL_CENTROS where idcadastro=${idCadastro} order by numero asc`)
            .then( result1=>{
               if(result1.rowsAffected>0){
                  //console.log(result1)
                  res.send(result1.recordset)
               }
            })

         }else{
            // here i need make a loop for search the filiais allowed for this user
            const array_centros = idcentro.split(',');
            for (let x=0; x<=idcentro.length; x++){
               sql.query(`select id,nome from CADASTROGERAL_CENTROS where idcadastro=${idCadastro} and id=${parseInt(array_centros[x])} order by numero asc`)
               .then( result1=>{
                  if(result1.rowsAffected>0){
                     //console.log(result1)
                     res.send(result1.recordset)
                  }
               })
            }

         }
      }
   })
})

app.post("/users", async (req,res) => {
   const {nome} = req.body;
   const {filial} = req.body;
   const {centros} = req.body;
   const {tipo} = req.body;
   const {idcontrato} = req.body;

   let sql_nome='';
   let sql_filial='';
   let sql_centros='';
   let sql_tipo='';
   
   if (!nome){
      sql_nome='';
   }else{
      sql_nome=` and titular like '%${nome}%'`;
   }

   if (!filial){
      sql_filial='';
   }else{
      
      sql_filial=` and idfilial='${filial}'`;
   }

   if (!centros){
      sql_centros='';
   }else{
      
      sql_centros=` and idcentro='${centros}'`;
   }
   
   if (!tipo){
      sql_tipo='';
   }else{
      
      sql_tipo=` and status='${tipo}'`;
   }

   
   const rs=`select * from cadastrogeral where idcadvenda=${idcontrato} ${sql_tipo}  ${sql_filial} ${sql_centros} ${sql_nome} `;
   //console.log(rs);
   sql.query(rs)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result.recordset);
         //res.send(result.recordset);
         let response = [];

         async function processData() {
            for (let x = 0; x < result.rowsAffected; x++) {
               let plano = '';
               let unidade = '';
         
               if (!result.recordset[x].idfilial) {
                  if (isNumber(result.recordset[x].redecontratada) === 1) {
                     // Esperar a consulta
                     const result_plano = await sql.query(`SELECT nome FROM CADASTROGERAL_PLANOS WHERE id=${result.recordset[x].redecontratada}`);
                     if (result_plano.rowsAffected > 0) {
                        response.push({
                           id: result.recordset[x].id,
                           titular: result.recordset[x].titular,
                           edependente: result.recordset[x].edependente,
                           cpf: result.recordset[x].cpf,
                           status: result.recordset[x].status,
                           nome_filial: '',
                           nome_plano: result_plano.recordset[0].nome
                        });
                     }
                  } else {
                     response.push({
                        id: result.recordset[x].id,
                        titular: result.recordset[x].titular,
                        edependente: result.recordset[x].edependente,
                        cpf: result.recordset[x].cpf,
                        status: result.recordset[x].status,
                        nome_filial: '',
                        nome_plano: result.recordset[x].redecontratada
                     });
                  }
               } else {
                  if (isNumber(result.recordset[x].redecontratada) === 1) {
                     const result_plano = await sql.query(`SELECT nome FROM CADASTROGERAL_PLANOS WHERE id=${result.recordset[x].redecontratada}`);
                     if (result_plano.rowsAffected > 0) {
                        const result_filial = await sql.query(`SELECT nome FROM cadastrogeral_filial WHERE id=${result.recordset[x].idfilial}`);
                        if (result_filial.rowsAffected > 0) {
                           response.push({
                              id: result.recordset[x].id,
                              titular: result.recordset[x].titular,
                              edependente: result.recordset[x].edependente,
                              cpf: result.recordset[x].cpf,
                              status: result.recordset[x].status,
                              nome_filial: result_filial.recordset[0].nome,
                              nome_plano: result_plano.recordset[0].nome
                           });
                        } else {
                           response.push({
                              id: result.recordset[x].id,
                              titular: result.recordset[x].titular,
                              edependente: result.recordset[x].edependente,
                              cpf: result.recordset[x].cpf,
                              status: result.recordset[x].status,
                              nome_filial: '',
                              nome_plano: result_plano.recordset[0].nome
                           });
                        }
                     }
                  } else {
                     const result_filial = await sql.query(`SELECT nome FROM cadastrogeral_filial WHERE id=${result.recordset[x].idfilial}`);
                     if (result_filial.rowsAffected > 0) {
                        response.push({
                           id: result.recordset[x].id,
                           titular: result.recordset[x].titular,
                           edependente: result.recordset[x].edependente,
                           cpf: result.recordset[x].cpf,
                           status: result.recordset[x].status,
                           nome_filial: result_filial.recordset[0].nome,
                           nome_plano: result.recordset[x].redecontratada
                        });
                     } else {
                        response.push({
                           id: result.recordset[x].id,
                           titular: result.recordset[x].titular,
                           edependente: result.recordset[x].edependente,
                           cpf: result.recordset[x].cpf,
                           status: result.recordset[x].status,
                           nome_filial: '',
                           nome_plano: result.recordset[x].redecontratada
                        });
                     }
                  }
               }
         
               console.log(x + ' - ' + response);
            }
         
            res.send(response);
         }
         
         processData();
      }
   })
})


app.post("/users2", async (req,res) => {
   const {nome} = req.body;
   const {filial} = req.body;
   const {centros} = req.body;
   const {tipo} = req.body;
   const {idcontrato} = req.body;

   let sql_nome='';
   let sql_filial='';
   let sql_centros='';
   let sql_tipo='';
   
   if (!nome){
      sql_nome='';
   }else{
      sql_nome=` and C.titular like '%${nome}%'`;
   }

   if (!filial){
      sql_filial='';
   }else{
      
      sql_filial=` and C.idfilial='${filial}'`;
   }

   if (!centros){
      sql_centros='';
   }else{
      
      sql_centros=` and C.idcentro='${centros}'`;
   }
   
   if (!tipo){
      sql_tipo='';
   }else{
      
      sql_tipo=` and C.status='${tipo}'`;
   }

   //criar inner join pegando filial e plano
   const rs=`select C.id, C.titular, C.edependente, C.cpf, C.status, F.nome as nome_filial, P.nome as nome_plano from cadastrogeral as C inner join cadastrogeral_filial as F on C.idfilial=F.id inner join cadastrogeral_planos as P on C.redecontratada=P.id where C.idcadvenda=${idcontrato} ${sql_tipo}  ${sql_filial} ${sql_centros} ${sql_nome} `;
   //console.log(rs);
   sql.query(rs)
   .then( result =>{
      if (result.rowsAffected > 0){
         //console.log(result.recordset);
         res.send(result.recordset);
            
      }
   })
})

//exemplo async/await - criar uma funcao asyncfunc
app.get('/', async (req, res) => {
   const result = await asyncFunc()
   return res.send(result)
 })


app.listen(port,()=>{
    console.log(`Rodando server na porta ${port} `)
})