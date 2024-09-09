import styles from './Forms.module.css'

function Select({text, name, options, handleOnChange, value, require}) {
    return ( 
        <>
        <label htmlFor={name}>{text}</label><br/>
        <select name={name} id={name} onChange={handleOnChange} value={value} className={styles.input_xlarge} required={require && 'required'}>
            <option>Selecione uma opção</option>
            {options.map((option) => (
                    <option value={option.id} key={option.id} >{option.nome}</option>
                ))
            }
        </select>
        </>
     );
}

export default Select;