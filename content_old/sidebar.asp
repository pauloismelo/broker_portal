<div class="vertical-menu">

    <!-- LOGO -->
    <div class="navbar-brand-box">
        <a href="index.asp" class="logo logo-dark">
            <span class="logo-sm">
                <img src="assets\images\compactabeneficios.png" alt="" height="30">
            </span>
            <span class="logo-lg">
                <img src="assets\images\compactabeneficios.png" alt="" height="50">
            </span>
        </a>

        <a href="index.asp" class="logo logo-light">
            <span class="logo-sm">
                <img src="assets\images\compactabeneficios.png" alt="" height="30">
            </span>
            <span class="logo-lg">
                <img src="assets\images\compactabeneficios.png" alt="" height="50">
            </span>
        </a>
    </div>

    <button type="button" class="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn">
        <i class="fa fa-fw fa-bars"></i>
    </button>

    <div data-simplebar="" class="sidebar-menu-scroll">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title">Menu</li>

                <li>
                    <a href="index.asp">
                        <i class="uil-home-alt"></i>
                        <span>Início</span>
                    </a>
                </li>
                
                
                <li <%if request("go")="meusdados" or request("go")="cadastro" or request("go")="perfil" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-user-circle"></i>
                        <span>Perfil</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=perfil"<%if request("go")="perfil" then%> class="active"<%end if%>>Meu Perfil</a></li>
                        <li><a href="painel.asp?go=contratos"<%if request("go")="contratos" then%> class="active"<%end if%>>
                        Consultar Beneficiários
                        </a></li>
                        <li><a href="painel.asp?go=meusdados"<%if request("go")="meusdados" then%> class="active"<%end if%>>Meus Dados</a></li>
                        <li><a href="painel.asp?go=cadastro"<%if request("go")="cadastro" then%> class="active"<%end if%>>Alterar Meus Dados</a></li>
                    </ul>
                </li>
                <li <%if request("go")="documentos" or request("go")="informativos" or request("go")="dicassaude" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-file-alt"></i>
                        <span>Documentos</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=documentos"<%if request("go")="documentos" then%> class="active"<%end if%>>
                        Aditivos/Documentos
                        </a></li>
                        <li><a href="painel.asp?go=informativos"<%if request("go")="informativos" then%> class="active"<%end if%>>
                        Informativos
                        </a></li>
                        <li><a href="painel.asp?go=dicassaude"<%if request("go")="dicassaude" then%> class="active"<%end if%>>
                        Dicas de Saúde
                        </a></li>
                    </ul>
                </li>
                
                <li <%if request("go")="kit_faturamento" then%>class="mm-active"<%end if%>>
                    <a href="painel.asp?go=kit_faturamento">
                        <i class="fas fa-dollar-sign"></i>
                        <span>Kit Faturamento</span>
                    </a>
                </li>
                
                <li <%if request("go")="contratos" or request("go")="contrato" or request("go")="inclusao_titular" or request("go")="inclusao_dependente2" or request("go")="exclusao" or request("go")="movimentacoes" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="fas fa-people-arrows"></i>
                        <span>Movimentações</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=contratos"<%if request("go")="contratos" then%> class="active"<%end if%>>
                        Incluir Titular
                        </a></li>
                        <li><a href="painel.asp?go=contratos"<%if request("go")="contratos" then%> class="active"<%end if%>>
                        Incluir Dependente
                        </a></li>
                        <li><a href="painel.asp?go=contratos"<%if request("go")="contratos" then%> class="active"<%end if%>>
                        Excluir Beneficiário
                        </a></li>
                        <li><a href="painel.asp?go=movimentacoes"<%if request("go")="movimentacoes" and request("status")="com_pendencia" then%> class="active"<%end if%>>
                        Consultar Movimentações
                        </a></li>
                       
                        <li><a href="painel.asp?go=contratos"<%if request("go")="contratos" then%> class="active"<%end if%>>
                        Downgrade de Plano
                        </a></li>
                        <li><a href="painel.asp?go=contratos" <%if request("go")="contratos" then%> class="active"<%end if%>>
                        Upgrade de Plano
                        </a></li>
                        <%if subfatx="s" then%>
                        <li><a href="painel.asp?go=contratos_transferencia" <%if request("go")="contratos" then%> class="active"<%end if%>>
                        Transferencia p/ outro cnpj
                        </a></li>
                        <%end if%>
                    </ul>
                </li>
                <li>
                	<a href="painel.asp?go=movimentacoes&pesq=ok&statuss=com_pendencia&tipo=INCLUSAO">
                    	<div>
                            <div style="float:left;">
                                <i class="fas fa-exclamation"></i>
                                Pendencias
                            </div>
                            <div style="float:right;">
                                <%set rss=conexao.execute("select count(id) as total from TB_MOVIMENTACOES where id_empresa="&idx&" and status='COM_PENDENCIA' and solicitacao_principal is null ")
                                if not rss.eof then
									if rss("total")>0 then%>
									<div style="border-radius:8px; background-color:#F00; color:#FFF; padding:1px; height:20px; width:20px; text-align:center; font-size:10px;" title="<%=rss("total")%> Movimentações com pendência"><%=rss("total")%></div>
									<%end if
                                end if
                                set rss=nothing%>
                            </div>
                        </div>
                    </a>
                </li>
                <br />
                
                <li <%if request("go")="indique_compacta" or request("go")="indique_medicos" or request("go")="indique_dentistas" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="fas fa-hands-helping"></i>
                        <span>Indicações</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=indique_compacta"<%if request("go")="indique_compacta" then%> class="active"<%end if%>>
                        Indique a Compacta
                        </a></li>
                        <li><a href="painel.asp?go=indique_medicos"<%if request("go")="indique_medicos" then%> class="active"<%end if%>>
                        Indique seu médico
                        </a></li>
                        <li><a href="painel.asp?go=indique_dentistas"<%if request("go")="indique_dentistas" then%> class="active"<%end if%>>
                        Indique seu dentista
                        </a></li>
                    </ul>
                </li>
                
                <li <%if request("go")="ocorrencia" then%>class="mm-active"<%end if%>>
                	<a href="painel.asp?go=ocorrencia"<%if request("go")="ocorrencia" then%> class="active"<%end if%>>
                    	<div>
                            <div style="float:left;">
                                <i class="fas fa-exclamation"></i>
                                Ocorrências
                            </div>
                            <div style="float:right;">
                                <%set rss=conexao.execute("select count(id) as total from PORTALCLIENTE_OCORRENCIAS where id_cliente="&idx&" and status='RESPONDIDO-COMPACTA' or id_cliente="&idx&" and status='ABERTO' ")
                                if not rss.eof then
                                if rss("total")>0 then%>
                                <div style="border-radius:8px; background-color:#F00; color:#FFF; padding:1px; height:20px; width:20px; text-align:center; font-size:10px;" title="<%=rss("total")%> ocorrencia(s) aberta(s) ou respondida(s)"><%=rss("total")%></div>
                                <%end if
                                end if
                                set rss=nothing%>
                            </div>
                        </div>
                    </a>
                </li>
                <br />
                <li <%if request("go")="boleto" or request("go")="carteira" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="fas fa-file-upload"></i>
                        <span>Solicitações</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=boleto"<%if request("go")="boleto" then%> class="active"<%end if%>>
                        2º via de boleto
                        </a></li>
                        <li><a href="painel.asp?go=carteira"<%if request("go")="carteira" then%> class="active"<%end if%>>
                        2º via de carteirinha
                        </a></li>
                        <li><a href="painel.asp?go=subfaturas"<%if request("go")="subfaturas" then%> class="active"<%end if%>>
                        Sub-Faturas
                        </a></li>
                    </ul>
                </li>
                
                <li <%if request("go")="cotacao" or request("go")="cotacao_vida" or request("go")="cotacao_odonto" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-invoice"></i>
                        <span>Cotações</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=cotacao"<%if request("go")="cotacao" then%> class="active"<%end if%>>
                        Cotação para novo grupo
                        </a></li>
                        <li><a href="painel.asp?go=cotacao_vida"<%if request("go")="cotacao_vida" then%> class="active"<%end if%>>
                        Cotação Seguro de Vida
                        </a></li>
                        <li><a href="painel.asp?go=cotacao_odonto"<%if request("go")="cotacao_odonto" then%> class="active"<%end if%>>
                        Cotação Plano Odontológico
                        </a></li>
                    </ul>
                </li>
                
                <li <%if request("go")="contratos_segurovida" or request("go")="ocorrencia" and request("oco")="abre" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="fas fa-heart"></i>
                        <span>Seguro de vida</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li>
                        	<a href="javascript: void(0);" class="has-arrow waves-effect">
                                <span>Movimentação</span>
                            </a>
                            <ul class="sub-menu" aria-expanded="false">
                                <li><a href="painel.asp?go=contratos_segurovida"<%if request("go")="contratos_segurovida" then%> class="active"<%end if%>>
                                Inserir
                                </a></li>
                                <li><a href="painel.asp?go=movimentacoes_vida"<%if request("go")="movimentacoes_vida" then%> class="active"<%end if%>>
                                Consultar
                                </a></li>
                            </ul>
                        </li>
                        
                        <li><a href="painel.asp?go=ocorrencia&oco=abre"<%if request("go")="ocorrencia" and request("oco")="abre" then%> class="active"<%end if%>>
                        Comunicar Sinistro
                        </a></li>
                    </ul>
                </li>
                <%IF trim(managerx)="on" then%>
                <li <%if request("go")="acessos" or request("go")="usuarios" then%>class="mm-active"<%end if%>>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="fas fa-user-cog"></i>
                        <span>Manager</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="painel.asp?go=acessos"<%if request("go")="acessos" then%> class="active"<%end if%>>Rel. acessos</a></li>
                        <li><a href="painel.asp?go=usuarios"<%if request("go")="usuarios" then%> class="active"<%end if%>>Usuários</a></li>
                    </ul>
                </li>
                <%end if%>
                
                <%subfat=""
				set rs=conexao.execute("select idvenda from CADASTROGERAL_VENDAS where idcadastro="&idx&" and idvenda<>0")
				if not rs.eof then
					while not rs.eof
						set rs2=conexao.execute("select * from CAIXAVENDAS where subfaturadeidcx="&rs("idvenda")&"")
						if not rs2.eof then
							subfat="ok"						
						end if
						set rs2=nothing
					rs.movenext
					wend
				end if
				set rs=nothing%>
                
                <%if subfat="ok" then%>
                <li>
                    <a href="painel.asp?go=contratos_subfatura">
                        <i class="fas fa-building"></i>
                        <span>Subfaturas</span>
                    </a>
                </li>
                <%end if%>
                <li>
                    <a href="close.asp">
                        <i class="fas fa-arrow-right"></i>
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

                <%if idxy=560 then%>
                
                
                
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-window-section"></i>
                        <span>Layouts</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="layouts-horizontal.html">Horizontal</a></li>
                        <li><a href="layouts-dark-sidebar.html">Dark Sidebar</a></li>
                        <li><a href="layouts-compact-sidebar.html">Compact Sidebar</a></li>
                        <li><a href="layouts-icon-sidebar.html">Icon Sidebar</a></li>
                        <li><a href="layouts-boxed.html">Boxed Width</a></li>
                        <li><a href="layouts-preloader.html">Preloader</a></li>
                        <li><a href="layouts-colored-sidebar.html">Colored Sidebar</a></li>
                    </ul>
                </li>

                <li class="menu-title">Apps</li>

                <li>
                    <a href="calendar.html" class="waves-effect">
                        <i class="uil-calender"></i>
                        <span>Calendar</span>
                    </a>
                </li>

                <li>
                    <a href="chat.html" class=" waves-effect">
                        <i class="uil-comments-alt"></i>
                        <span class="badge badge-pill badge-warning float-right">New</span>
                        <span>Chat</span>
                    </a>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-store"></i>
                        <span>Ecommerce</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
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
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-envelope"></i>
                        <span>Email</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="email-inbox.html">Inbox</a></li>
                        <li><a href="email-read.html">Read Email</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-invoice"></i>
                        <span>Invoices</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="invoices-list.html">Invoice List</a></li>
                        <li><a href="invoices-detail.html">Invoice Detail</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-book-alt"></i>
                        <span>Contacts</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="contacts-grid.html">User Grid</a></li>
                        <li><a href="contacts-list.html">User List</a></li>
                        <li><a href="contacts-profile.html">Profile</a></li>
                    </ul>
                </li>

                <li class="menu-title">Pages</li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-user-circle"></i>
                        <span>Authentication</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="auth-login.html">Login</a></li>
                        <li><a href="auth-register.html">Register</a></li>
                        <li><a href="auth-recoverpw.html">Recover Password</a></li>
                        <li><a href="auth-lock-screen.html">Lock Screen</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-file-alt"></i>
                        <span>Utility</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
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

                <li class="menu-title">Components</li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-flask"></i>
                        <span>UI Elements</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
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
                    <a href="javascript: void(0);" class="waves-effect">
                        <i class="uil-shutter-alt"></i>
                        <span class="badge badge-pill badge-info float-right">6</span>
                        <span>Forms</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
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
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-list-ul"></i>
                        <span>Tables</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="tables-basic.html">Bootstrap Basic</a></li>
                        <li><a href="tables-datatable.html">Datatables</a></li>
                        <li><a href="tables-responsive.html">Responsive</a></li>
                        <li><a href="tables-editable.html">Editable</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-chart"></i>
                        <span>Charts</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="charts-apex.html">Apex</a></li>
                        <li><a href="charts-chartjs.html">Chartjs</a></li>
                        <li><a href="charts-flot.html">Flot</a></li>
                        <li><a href="charts-knob.html">Jquery Knob</a></li>
                        <li><a href="charts-sparkline.html">Sparkline</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-streering"></i>
                        <span>Icons</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="icons-unicons.html">Unicons</a></li>
                        <li><a href="icons-boxicons.html">Boxicons</a></li>
                        <li><a href="icons-materialdesign.html">Material Design</a></li>
                        <li><a href="icons-dripicons.html">Dripicons</a></li>
                        <li><a href="icons-fontawesome.html">Font Awesome</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-location-point"></i>
                        <span>Maps</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="maps-google.html">Google</a></li>
                        <li><a href="maps-vector.html">Vector</a></li>
                        <li><a href="maps-leaflet.html">Leaflet</a></li>
                    </ul>
                </li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="uil-share-alt"></i>
                        <span>Multi Level</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="true">
                        <li><a href="javascript: void(0);">Level 1.1</a></li>
                        <li><a href="javascript: void(0);" class="has-arrow">Level 1.2</a>
                            <ul class="sub-menu" aria-expanded="true">
                                <li><a href="javascript: void(0);">Level 2.1</a></li>
                                <li><a href="javascript: void(0);">Level 2.2</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <%end if%>
            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>