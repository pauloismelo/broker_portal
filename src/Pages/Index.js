import Header from "./Header";
import Index_bemvindo from "../Components/Index_bemvindo";
import Index_indicativos from '../Components/Index_indicativos'
import SideBar from "./SideBar";
import Index_contrato from "../Components/Index_contrato";

import '../assets/css/bootstrap.min.css'
import '../assets/css/icons.min.css'
import '../assets/css/app.min.css'
import Sidebar2 from "./Sidebar2";

/*
    import '../assets/libs/bootstrap/js/bootstrap.bundle.min.js'
    import '../assets/libs/metismenu/metisMenu.min.js'
    import '../assets/libs/simplebar/simplebar.min.js'
    import '../assets/libs/node-waves/waves.min.js'
    import '../assets/libs/waypoints/lib/jquery.waypoints.min.js'
    import '../assets/libs/jquery.counterup/jquery.counterup.min.js'
    import '../assets/libs/apexcharts/apexcharts.min.js'
    import '../assets/js/pages/dashboard.init.js'

    import '../assets/js/app.js'
*/



function Index() {
    return (
    
    <div id="layout-wrapper">
        <Header/>
        <Sidebar2/>

        <div className="main-content">

            <div className="page-content">
                <div className="container-fluid">
                    
                    <div className="row">
                        <div className="col-12">
                            <div className="page-title-box d-flex align-items-center justify-content-between">
                                <h4 className="mb-0">Portal do Cliente</h4>

                                <div className="page-title-right">
                                    <ol className="breadcrumb m-0">
                                        <li className="breadcrumb-item"><a href="">Home</a></li>
                                        <li className="breadcrumb-item active">Painel</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <Index_bemvindo/>
                        <Index_indicativos/>
                    </div>
                    <div className="row">
                        <Index_contrato/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
     );
}

export default Index;