

function Button({tipo, cor, value}) {
    const tipobutao = `btn btn-${cor} btn-large`;
    return ( 
        <button type={tipo} className={tipobutao} >{value}</button>
     );
}

export default Button;