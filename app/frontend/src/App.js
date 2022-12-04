import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import HomePageLayout from './layouts/HomePage/HomePage';
import Login from './pages/Login/Login';
import SignUp from './pages/SignUp/SignUp';
import Post from './pages/Post/Post';

import Forum from './layouts/Forum/Forum';
import CreatePost from './pages/CreatePost/CreatePost'
import CreateArticle from './pages/CreateArticle/CreateArticle'


import './App.css';
import 'antd/dist/antd.css'
import Profile from './pages/Profile/Profile';

function App() {
  return (
    <Router>
      <Routes>
        <Route path='/' element={ <HomePageLayout /> }/>

        <Route path='/signup' element={ <SignUp /> }/>

        <Route path='/login' element={ <Login /> }/>

        <Route path='/forum' element={ <Forum /> } />

        <Route path='/post/:id' element={ <Post /> }/>

        <Route path='profile' element={ <Profile /> }/>

        <Route path='/create-post' element={ <CreatePost /> }/>

        <Route path='/create-article' element={ <CreateArticle /> }/>
      </Routes>
    </Router>
  );
}

export default App;
