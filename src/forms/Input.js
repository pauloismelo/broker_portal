import styles from './Forms.module.css'

function Input({type, name, placeholder, text, value, align, handleOnChange}) {
    return ( 
        <>
        <label htmlFor={name}>{text}</label><br/>
        <input type={type} className={styles.input_xlarge} name={name} id={name} placeholder={placeholder} required="" value={value} style={{textAlign:align}} onChange={handleOnChange} />
        </>
     );
}

export default Input;