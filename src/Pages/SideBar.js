import logo from '../assets/images/compactabeneficios.png'
import 'cdbreact'

function SideBar() {
    var url_atual = window.location.pathname;

    return (
        
        <div className="vertical-menu">
            
            <div className="navbar-brand-box">
                <a href="index.asp" className="logo logo-dark">
                    <span className="logo-sm">
                        <img src={logo} alt="" height="30"/>
                    </span>
                    <span className="logo-lg">
                        <img src={logo} alt="" height="50"/>
                    </span>
                </a>

                <a href="index.asp" className="logo logo-light">
                    <span className="logo-sm">
                        <img src={logo} alt="" height="30"/>
                    </span>
                    <span className="logo-lg">
                        <img src={logo} alt="" height="50"/>
                    </span>
                </a>
            </div>

            <button type="button" className="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn">
                <i className="fa fa-fw fa-bars"></i>
            </button>

            <div data-simplebar="" className="sidebar-menu-scroll">


                <div id="sidebar-menu">
                    
                    <ul className="metismenu list-unstyled" id="side-menu">
                        <li className="menu-title">Menu</li>

                        <li>
                            <a href="index.asp">
                                <i className="uil-home-alt"></i>
                                <span>Início</span>
                            </a>
                        </li>
                        
                        
                        <li { ...(url_atual=='meusdados' || url_atual=='cadastro' || url_atual=='perfil') ? 'className="mm-active"' : ''} >
                            <a className="has-arrow waves-effect">
                                <i className="uil-user-circle"></i>
                                <span>Perfil</span>
                            </a>
                            
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=perfil" { ...(url_atual=='perfil') ? 'className="active"' : ''} >Meu Perfil</a></li>
                                <li><a href="painel.asp?go=contratos" { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Consultar Beneficiários
                                </a></li>
                                <li><a href="painel.asp?go=meusdados" { ...(url_atual=='meudados') ? 'className="active"' : ''}>Meus Dados</a></li>
                                <li><a href="painel.asp?go=cadastro" { ...(url_atual=='cadastro') ? 'className="active"' : ''}>Alterar Meus Dados</a></li>
                            </ul>
                        </li>
                        <li { ...(url_atual=='documentos' || url_atual=='informativos' || url_atual=='dicassaude') ? 'className="mm-active"' : ''} >
                            <a className="has-arrow waves-effect">
                                <i className="uil-file-alt"></i>
                                <span>Documentos</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=documentos" { ...(url_atual=='documentos') ? 'className="active"' : ''}>
                                Aditivos/Documentos
                                </a></li>
                                <li><a href="painel.asp?go=informativos" { ...(url_atual=='informativos') ? 'className="active"' : ''}>
                                Informativos
                                </a></li>
                                <li><a href="painel.asp?go=dicassaude" { ...(url_atual=='dicassaude') ? 'className="active"' : ''}>
                                Dicas de Saúde
                                </a></li>
                            </ul>
                        </li>
                        
                        <li { ...url_atual=='kit_faturamento' ? 'className="mm-active"' : ''} >
                            <a href="painel.asp?go=kit_faturamento">
                                <i className="fas fa-dollar-sign"></i>
                                <span>Kit Faturamento</span>
                            </a>
                        </li>
                        
                        <li { ...(url_atual=='contratos' || url_atual=='contrato' || url_atual=='inclusao_titular' || url_atual=='inclusao_dependente2' || url_atual=='exclusao' || url_atual=='movimentacoes') ? 'className="mm-active"' : ''} >
                            <a className="has-arrow waves-effect">
                                <i className="fas fa-people-arrows"></i>
                                <span>Movimentações</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=contratos" { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Incluir Titular
                                </a></li>
                                <li><a href="painel.asp?go=contratos" { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Incluir Dependente
                                </a></li>
                                <li><a href="painel.asp?go=contratos" { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Excluir Beneficiário
                                </a></li>
                                <li><a href="painel.asp?go=movimentacoes" { ...(url_atual=='movimentacoes') ? 'className="active"' : ''}>
                                Consultar Movimentações
                                </a></li>
                            
                                <li><a href="painel.asp?go=contratos"  { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Downgrade de Plano
                                </a></li>
                                <li><a href="painel.asp?go=contratos"  { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Upgrade de Plano
                                </a></li>


 
                                {/* if subfatx=S then */}
                                <li><a href="painel.asp?go=contratos_transferencia"  { ...(url_atual=='contratos') ? 'className="active"' : ''}>
                                Transferencia p/ outro cnpj
                                </a></li>
                               
                            </ul>
                        </li>
                        <li>
                            <a href="painel.asp?go=movimentacoes&pesq=ok&statuss=com_pendencia&tipo=INCLUSAO">
                                <div>
                                    <div style={{float:'left'}}>
                                        <i className="fas fa-exclamation"></i>
                                        Pendencias
                                    </div>
                                    <div style={{float:'right'}}>
                                        {/* Pesquisa as pendencias atraves de API e retorna aqui */}
                                        
                                            <div style={{borderRadius:'8px', backgroundColor:'#F00', color:'#FFF', padding:'1px', height:'20px', width:'20px', textAlign:'center', fontSize:'10px'}}  title="Movimentações com pendência"></div>
                                            
                                    </div>
                                </div>
                            </a>
                        </li>
                        <br />
                        
                        <li { ...(url_atual=='indique_compacta' || url_atual=='indique_medicos' || url_atual=='indique_dentistas') ? 'className="mm-active"' : ''} >
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="fas fa-hands-helping"></i>
                                <span>Indicações</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=indique_compacta" { ...(url_atual=='indique_compacta') ? 'className="active"' : ''}>
                                Indique a Compacta
                                </a></li>
                                <li><a href="painel.asp?go=indique_medicos" { ...(url_atual=='indique_medicos') ? 'className="active"' : ''}>
                                Indique seu médico
                                </a></li>
                                <li><a href="painel.asp?go=indique_dentistas" { ...(url_atual=='indique_dentistas') ? 'className="active"' : ''}>
                                Indique seu dentista
                                </a></li>
                            </ul>
                        </li>
                        
                        <li { ...(url_atual=='ocorrencia') ? 'className="mm-active"' : ''} >
                            <a href="painel.asp?go=ocorrencia" { ...(url_atual=='ocorrencia') ? 'className="active"' : ''}>
                                <div>
                                    <div style={{float: 'left'}}>
                                        <i className="fas fa-exclamation"></i>
                                        Ocorrências
                                    </div>
                                    <div style={{float: 'right'}}>
                                        {/* Consultar a tabela PORTALCLIENTE_OCORRENCIAS atraves de uma api*/}
                                        
                                        <div style={{borderRadius:'8px', backgroundColor:'#F00', color:'#FFF', padding:'1px;', height:'20px;', width:'20px;', textAlign:'center;', fontSize:'10px'}}  title=" ocorrencia(s) aberta(s) ou respondida(s)">0</div>
                                        
                                    </div>
                                </div>
                            </a>
                        </li>
                        <br />
                        <li { ...(url_atual=='boleto' || url_atual=='carteira') ? 'className="mm-active"' : ''} >
                        
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="fas fa-file-upload"></i>
                                <span>Solicitações</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=boleto" { ...(url_atual=='boleto' ) ? 'className="active"' : ''}>
                                2º via de boleto
                                </a></li>
                                <li><a href="painel.asp?go=carteira" { ...(url_atual=='carteira') ? 'className="active"' : ''} >
                                2º via de carteirinha
                                </a></li>
                                <li><a href="painel.asp?go=subfaturas" { ...(url_atual=='subfaturas' || url_atual=='carteira') ? 'className="active"' : ''} >
                                Sub-Faturas
                                </a></li>
                            </ul>
                        </li>
                        
                        
                        <li { ...(url_atual=='cotacao' || url_atual=='cotacao_vida' || url_atual=='cotacao_odonto') ? 'className="mm-active"' : ''} >
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-invoice"></i>
                                <span>Cotações</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=cotacao" { ...(url_atual=='cotacao' ) ? 'className="active"' : ''}>
                                Cotação para novo grupo
                                </a></li>
                                <li><a href="painel.asp?go=cotacao_vida" { ...( url_atual=='cotacao_vida') ? 'className="active"' : ''}>
                                Cotação Seguro de Vida
                                </a></li>
                                <li><a href="painel.asp?go=cotacao_odonto" { ...(url_atual=='cotacao_odonto') ? 'className="active"' : ''}>
                                Cotação Plano Odontológico
                                </a></li>
                            </ul>
                        </li>
                        
                        <li { ...(url_atual=='contratos_segurovida' || url_atual=='ocorrencia') ? 'className="mm-active"' : ''} >
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="fas fa-heart"></i>
                                <span>Seguro de vida</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li>
                                    <a href="javascript: void(0);" className="has-arrow waves-effect">
                                        <span>Movimentação</span>
                                    </a>
                                    <ul className="sub-menu" aria-expanded="false">
                                        <li><a href="painel.asp?go=contratos_segurovida" { ...(url_atual=='contratos_segurovida') ? 'className="active"' : ''}>
                                        Inserir
                                        </a></li>
                                        <li><a href="painel.asp?go=movimentacoes_vida" { ...(url_atual=='movimentacoes_vida') ? 'className="active"' : ''}>
                                        Consultar
                                        </a></li>
                                    </ul>
                                </li>
                                
                                <li><a href="painel.asp?go=ocorrencia&oco=abre" { ...(url_atual=='ocorrencia') ? 'className="active"' : ''}>
                                Comunicar Sinistro
                                </a></li>
                            </ul>
                        </li>
                        {/* if manager = on */}
                       
                        <li { ...(url_atual=='acessos' || url_atual=='usuarios') ? 'className="mm-active"' : ''}>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="fas fa-user-cog"></i>
                                <span>Manager</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=acessos" { ...(url_atual=='acessos') ? 'className="active"' : ''}>Rel. acessos</a></li>
                                <li><a href="painel.asp?go=usuarios" { ...(url_atual=='usuarios') ? 'className="active"' : ''} >Usuários</a></li>
                            </ul>
                        </li>
                        
                        {/* pesquisar se é uma subfatura ou contem uma subfatura
                         "select idvenda from CADASTROGERAL_VENDAS where idcadastro="&idx&" and idvenda<>0
                         */}
                        
                        
                        
                        {/*<%if subfat="ok" then%>*/}
                        <li>
                            <a href="painel.asp?go=contratos_subfatura">
                                <i className="fas fa-building"></i>
                                <span>Subfaturas</span>
                            </a>
                        </li>
                        {/*<%end if%>*/}
                        <li>
                            <a href="close.asp">
                                <i className="fas fa-arrow-right"></i>
                                <span>Sair</span>
                            </a>
                        </li>
                        
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>
                        <li>&nbsp;</li>

                        {/*<%if idxy=560 then%>*/}
                        
                        
                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-window-section"></i>
                                <span>Layouts</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="layouts-horizontal.html">Horizontal</a></li>
                                <li><a href="layouts-dark-sidebar.html">Dark Sidebar</a></li>
                                <li><a href="layouts-compact-sidebar.html">Compact Sidebar</a></li>
                                <li><a href="layouts-icon-sidebar.html">Icon Sidebar</a></li>
                                <li><a href="layouts-boxed.html">Boxed Width</a></li>
                                <li><a href="layouts-preloader.html">Preloader</a></li>
                                <li><a href="layouts-colored-sidebar.html">Colored Sidebar</a></li>
                            </ul>
                        </li>

                        <li className="menu-title">Apps</li>

                        <li>
                            <a href="calendar.html" className="waves-effect">
                                <i className="uil-calender"></i>
                                <span>Calendar</span>
                            </a>
                        </li>

                        <li>
                            <a href="chat.html" className=" waves-effect">
                                <i className="uil-comments-alt"></i>
                                <span className="badge badge-pill badge-warning float-right">New</span>
                                <span>Chat</span>
                            </a>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-store"></i>
                                <span>Ecommerce</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="ecommerce-products.html">Products</a></li>
                                <li><a href="ecommerce-product-detail.html">Product Detail</a></li>
                                <li><a href="ecommerce-orders.html">Orders</a></li>
                                <li><a href="ecommerce-customers.html">Customers</a></li>
                                <li><a href="ecommerce-cart.html">Cart</a></li>
                                <li><a href="ecommerce-checkout.html">Checkout</a></li>
                                <li><a href="ecommerce-shops.html">Shops</a></li>
                                <li><a href="ecommerce-add-product.html">Add Product</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-envelope"></i>
                                <span>Email</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="email-inbox.html">Inbox</a></li>
                                <li><a href="email-read.html">Read Email</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-invoice"></i>
                                <span>Invoices</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="invoices-list.html">Invoice List</a></li>
                                <li><a href="invoices-detail.html">Invoice Detail</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-book-alt"></i>
                                <span>Contacts</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="contacts-grid.html">User Grid</a></li>
                                <li><a href="contacts-list.html">User List</a></li>
                                <li><a href="contacts-profile.html">Profile</a></li>
                            </ul>
                        </li>

                        <li className="menu-title">Pages</li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-user-circle"></i>
                                <span>Authentication</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="auth-login.html">Login</a></li>
                                <li><a href="auth-register.html">Register</a></li>
                                <li><a href="auth-recoverpw.html">Recover Password</a></li>
                                <li><a href="auth-lock-screen.html">Lock Screen</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-file-alt"></i>
                                <span>Utility</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="pages-starter.html">Starter Page</a></li>
                                <li><a href="pages-maintenance.html">Maintenance</a></li>
                                <li><a href="pages-comingsoon.html">Coming Soon</a></li>
                                <li><a href="pages-timeline.html">Timeline</a></li>
                                <li><a href="pages-faqs.html">FAQs</a></li>
                                <li><a href="pages-pricing.html">Pricing</a></li>
                                <li><a href="pages-404.html">Error 404</a></li>
                                <li><a href="pages-500.html">Error 500</a></li>
                            </ul>
                        </li>

                        <li className="menu-title">Components</li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-flask"></i>
                                <span>UI Elements</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="ui-alerts.html">Alerts</a></li>
                                <li><a href="ui-buttons.html">Buttons</a></li>
                                <li><a href="ui-cards.html">Cards</a></li>
                                <li><a href="ui-carousel.html">Carousel</a></li>
                                <li><a href="ui-dropdowns.html">Dropdowns</a></li>
                                <li><a href="ui-grid.html">Grid</a></li>
                                <li><a href="ui-images.html">Images</a></li>
                                <li><a href="ui-lightbox.html">Lightbox</a></li>
                                <li><a href="ui-modals.html">Modals</a></li>
                                <li><a href="ui-rangeslider.html">Range Slider</a></li>
                                <li><a href="ui-session-timeout.html">Session Timeout</a></li>
                                <li><a href="ui-progressbars.html">Progress Bars</a></li>
                                <li><a href="ui-sweet-alert.html">Sweet-Alert</a></li>
                                <li><a href="ui-tabs-accordions.html">Tabs & Accordions</a></li>
                                <li><a href="ui-typography.html">Typography</a></li>
                                <li><a href="ui-video.html">Video</a></li>
                                <li><a href="ui-general.html">General</a></li>
                                <li><a href="ui-colors.html">Colors</a></li>
                                <li><a href="ui-rating.html">Rating</a></li>
                                <li><a href="ui-notifications.html">Notifications</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="waves-effect">
                                <i className="uil-shutter-alt"></i>
                                <span className="badge badge-pill badge-info float-right">6</span>
                                <span>Forms</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="form-elements.html">Basic Elements</a></li>
                                <li><a href="form-validation.html">Validation</a></li>
                                <li><a href="form-advanced.html">Advanced Plugins</a></li>
                                <li><a href="form-editors.html">Editors</a></li>
                                <li><a href="form-uploads.html">File Upload</a></li>
                                <li><a href="form-xeditable.html">Xeditable</a></li>
                                <li><a href="form-repeater.html">Repeater</a></li>
                                <li><a href="form-wizard.html">Wizard</a></li>
                                <li><a href="form-mask.html">Mask</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-list-ul"></i>
                                <span>Tables</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="tables-basic.html">Bootstrap Basic</a></li>
                                <li><a href="tables-datatable.html">Datatables</a></li>
                                <li><a href="tables-responsive.html">Responsive</a></li>
                                <li><a href="tables-editable.html">Editable</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-chart"></i>
                                <span>Charts</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="charts-apex.html">Apex</a></li>
                                <li><a href="charts-chartjs.html">Chartjs</a></li>
                                <li><a href="charts-flot.html">Flot</a></li>
                                <li><a href="charts-knob.html">Jquery Knob</a></li>
                                <li><a href="charts-sparkline.html">Sparkline</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-streering"></i>
                                <span>Icons</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="icons-unicons.html">Unicons</a></li>
                                <li><a href="icons-boxicons.html">Boxicons</a></li>
                                <li><a href="icons-materialdesign.html">Material Design</a></li>
                                <li><a href="icons-dripicons.html">Dripicons</a></li>
                                <li><a href="icons-fontawesome.html">Font Awesome</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-location-point"></i>
                                <span>Maps</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="false">
                                <li><a href="maps-google.html">Google</a></li>
                                <li><a href="maps-vector.html">Vector</a></li>
                                <li><a href="maps-leaflet.html">Leaflet</a></li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript: void(0);" className="has-arrow waves-effect">
                                <i className="uil-share-alt"></i>
                                <span>Multi Level</span>
                            </a>
                            <ul className="sub-menu" aria-expanded="true">
                                <li><a href="javascript: void(0);">Level 1.1</a></li>
                                <li><a href="javascript: void(0);" className="has-arrow">Level 1.2</a>
                                    <ul className="sub-menu" aria-expanded="true">
                                        <li><a href="javascript: void(0);">Level 2.1</a></li>
                                        <li><a href="javascript: void(0);">Level 2.2</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        {/*<%end if>*/}
                    </ul>
                </div>
              
            </div>
        </div>
        
     );
}

export default SideBar;