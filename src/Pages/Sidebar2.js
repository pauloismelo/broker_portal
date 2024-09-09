import { Sidebar, Menu, MenuItem, SubMenu } from 'react-pro-sidebar';
import { NavLink } from 'react-router-dom';
import logo from '../assets/images/compactabeneficios.png'
import { useAuth } from '../Auth/useAuth';



function Sidebar2() {

    const {logout} = useAuth();

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
            <div data-simplebar="" className="sidebar-menu-scroll">

                <div id="sidebar-menu">
                <Sidebar>
                    <Menu>
                    <MenuItem component={<NavLink to="/" />}> Inicio </MenuItem>
                    <SubMenu label="Perfil ">
                        <MenuItem component={<NavLink to="/painel/perfil" />}> Meu Perfil </MenuItem>
                        <MenuItem component={<NavLink to="/painel/contratos" />}> Consultar Beneficiários </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Meus Dados </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Alterar Meus Dados </MenuItem>
                    </SubMenu>

                    <SubMenu label="Documentos ">
                        <MenuItem component={<NavLink to="/" />}> Aditivos/Documentos </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Informativos </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Dicas de Saúde </MenuItem>
                    </SubMenu>
                    <MenuItem component={<NavLink to="/" />}> Kit Faturamento </MenuItem>
                    <SubMenu label="Movimentações ">
                        <MenuItem component={<NavLink to="/" />}> Incluir Titular </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Incluir Dependente </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Excluir Beneficiário </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Consultar Movimentações </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Downgrade de Plano </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Upgrade de Plano </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Transferencia p/ outro cnpj </MenuItem>
                    </SubMenu>
                    <MenuItem component={<NavLink to="/" />}> Pendencias </MenuItem>
                    <SubMenu label="Indicações ">
                        <MenuItem component={<NavLink to="/" />}> Indique a Compacta </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Indique seu médico </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Indique seu dentista </MenuItem>
                    </SubMenu>
                    <MenuItem component={<NavLink to="/" />}> Ocorrências </MenuItem>
                    <SubMenu label="Solicitações ">
                        <MenuItem component={<NavLink to="/" />}> 2ª via de boleto </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> 2ª via de carteirinha </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Sub-Faturas </MenuItem>
                    </SubMenu>
                    <SubMenu label="Cotações ">
                        <MenuItem component={<NavLink to="/" />}> Cotação para novo grupo </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Cotação Seguro de Vida </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Cotação Plano Odontológico </MenuItem>
                    </SubMenu>
                    <SubMenu label="Seguro de Vida ">
                        <SubMenu label="Movimentação ">
                            <MenuItem component={<NavLink to="/" />}> Inserir </MenuItem>
                            <MenuItem component={<NavLink to="/" />}> Consultar </MenuItem>
                        </SubMenu>
                        <MenuItem component={<NavLink to="/" />}> Comunicar Sinistro </MenuItem>
                    </SubMenu>
                    <SubMenu label="Manager ">
                        <MenuItem component={<NavLink to="/" />}> Rel. acessos </MenuItem>
                        <MenuItem component={<NavLink to="/" />}> Usuários </MenuItem>
                    </SubMenu>
                    <MenuItem component={<NavLink to="/" />}> Subfaturas </MenuItem>
                    <MenuItem onClick={logout} > <i className="fas fa-arrow-right"></i> Sair </MenuItem>
                    </Menu>
                </Sidebar>
                </div>
            </div>
        </div>
        
     );
}

export default Sidebar2;