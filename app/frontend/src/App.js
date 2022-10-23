import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import HomePageLayout from './layouts/HomePage/HomePage';
import Login from './pages/Login/Login';
import SignUp from './pages/SignUp/SignUp';

import './App.css';
import 'antd/dist/antd.css'

function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={ <HomePageLayout /> }/>

        <Route path='/signup' element={ <SignUp /> }/>

        <Route path='/login' element={ <Login /> }/>
      </Routes>
    </Router>
  );
}

export default App;
