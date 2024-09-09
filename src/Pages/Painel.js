import { Outlet } from "react-router-dom";
import Header from "./Header";
import Sidebar2 from "./Sidebar2";

function Painel() {
    return ( 
        <div id="layout-wrapper">
        <Header/>
        <Sidebar2/>

        <div className="main-content">

            <div className="page-content">
                <div className="container-fluid">
                    <Outlet/>
                </div>
            </div>
        </div>
    </div>
     );
}

export default Painel;