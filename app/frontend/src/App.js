import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import HomePageLayout from './layouts/HomePage/HomePage';
import Login from './pages/Login/Login';
import SignUp from './pages/SignUp/SignUp';
import Post from './pages/Post/Post';
import Article from './pages/Article/Article';

import CreatePost from './pages/CreatePost/CreatePost'
import CreateArticle from './pages/CreateArticle/CreateArticle'
import Forum from './layouts/Forum/Forum';

import './App.css';
import 'antd/dist/antd.css'
import Profile from './pages/Profile/Profile';

import Kommunicate from '@kommunicate/kommunicate-chatbot-plugin';

Kommunicate.init("35f067c7290c8f7f05b2575bf22b44440", {restartConversationByUser:true, isSingleConversation:false, "botIds":["front-bot-pbkew"]});
function App() {
  return (
    <Router>
      <Routes>

        <Route path='/' element={ <HomePageLayout /> }/>

        <Route path=':category' element={ <HomePageLayout /> }/>

        <Route path='/search/:query' element={ <HomePageLayout /> }/>

        <Route path='/signup' element={ <SignUp /> }/>

        <Route path='/login' element={ <Login /> }/>

        <Route path='/forum' element={ <Forum /> } />

        <Route path='/post/:id' element={ <Post /> }/>

        <Route path='/article/:id' element={ <Article /> }/>

        <Route path='profile' element={ <Profile /> }/>

        <Route path='/create-post' element={ <CreatePost /> }/>

        <Route path='/create-article' element={ <CreateArticle /> }/>

      </Routes>
    </Router>
  );
}

export default App;