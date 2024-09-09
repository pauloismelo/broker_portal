import {BrowserRouter, Routes, Route} from 'react-router-dom'
import Login from './Pages/Login';
import Index from './Pages/Index';

import { AuthProvider} from './Auth/useAuth';
import { ProtectedRoute } from './Auth/ProtectedRoute';
import Painel from './Pages/Painel';
import Perfil from './Pages/Perfil';
import Contratos from './Pages/Contratos/Contratos';
import Contrato from './Pages/Contratos/Contrato';



function App() {
  return (
    <AuthProvider>
     
    <BrowserRouter>
        <Routes>
          <Route exact path='/' element={
            <ProtectedRoute>
            <Index/>
            </ProtectedRoute>
            }/>

          <Route path='/painel' element={<Painel/>}>
            
              <Route path="perfil" element={<ProtectedRoute><Perfil/></ProtectedRoute>} />
              <Route path="contratos" element={<ProtectedRoute><Contratos/></ProtectedRoute>} />
              <Route path="contrato/:id" element={<ProtectedRoute><Contrato/></ProtectedRoute>} />
            
          </Route>
          
          <Route path='/login' element={<Login/>}/>
          
        </Routes>
      
    </BrowserRouter>
    </AuthProvider>
    
  );
}

export default App;
