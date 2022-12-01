import React, {useState, useEffect} from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Avatar, Button } from "antd";
import { UserOutlined } from "@ant-design/icons";
import "./Profile.css"

import Articles from "../../layouts/Article/Article";
import Forum from "../../layouts/Forum/Forum";

import { useSelector } from 'react-redux';

import { fetchPostByUserId } from "../../redux/postSlice";

const buttonStyleClicked = {
    width: "45%",
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(104,172,252)',
    color: 'rgb(255,255,255)'
}

const buttonStyleUnclicked = {
    width: "45%",
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(255,255,255)',
    color: 'rgb(104,172,252)',
}

const renderPosts = (results) => {
    return (
        
        <div>
            <Forum posts={results}/>
        </div>
        
        
    )
}

const renderArticles = () => {
    return (
        <div>
            <Articles/>
        </div>
    )
}

const renderComments = (results) => {
    return (
        <div>
            <Forum posts={results}/>
        </div>
    )
}

const renderUpvotes = (results) => {
    return (
        <div>
            <Forum posts={results}/>
        </div>
    )
}

const renderActivityHistory = (pageType, results) => {
    if (pageType==0) return renderPosts(results);
    else if(pageType==1) return renderArticles();
    else if(pageType==2) return renderComments();
    else if(pageType==3) return renderUpvotes();
}


const Profile = () => {

    const [pageType, setPageType] = useState(0);

    const { user } = useSelector((state) => state.user);

    const userID = 14;

    const [postCount, setPostCount] = useState();
    const [next, setNext] = useState();
    const [prev, setPrev] = useState();
    const [results, setResults] = useState();
    
    useEffect(() => {
        fetchPostByUserId(userID, 1).then(res => {
            setPostCount(res.count);
            setNext(res.next);
            setPrev(res.previous);
            setResults(res.results)
        });
        
    }, []);


    return (
        <div className="profile-container">
            <NavBar></NavBar>

            <div className="profile-header">
                <div className="profile-avatar">
                    <Avatar size={100} icon={<UserOutlined></UserOutlined>}>

                    </Avatar>
                </div>

                <div className="profile-info">
                    {user.email}
                    <br></br>
                    {user.type}
                </div>
            </div>

            <div className="profile-activity-buttons">
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 0 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(0)}
                    >
                        Posts
                </Button>
                {user.type === 1 ? 
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 1 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(1)}
                    >
                        Articles
                </Button>
                : <></>}
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 2 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(2)}
                    >
                        Comments
                </Button>
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 3 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(3)}
                    >
                        Upvotes
                </Button>
            </div>

            <div className="profile-activity">
                {renderActivityHistory(pageType, results)}
            </div>


        </div>

        

    )
}

export default Profile;




