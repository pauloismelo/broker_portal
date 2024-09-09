import styles from './Forms.module.css'
import gif_loading from './../assets/images/loading.svg'


function Loading() {
    return ( 
        <div className={styles.div_loading}>
            <img width='80' src={gif_loading} alt='Loading'/>
        </div>
    );
}

export default Loading;