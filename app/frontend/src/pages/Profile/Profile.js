import React, {useState, useEffect} from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Avatar, Button , Pagination , Image , Dropdown } from "antd";

import "./Profile.css"
import Popup from "../../components/Popup/Popup";

import Articles from "../../layouts/Article/Article";
import Forum from "../../layouts/Forum/Forum";

import { useSelector } from 'react-redux';

import { fetchPostByUserId } from "../../redux/postSlice";
import { fetchPostUpvotesByUserId } from "../../redux/profileSlice";

const buttonStyleClicked = {
    width: "40%",
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(104,172,252)',
    color: 'rgb(255,255,255)'
}

const buttonStyleUnclicked = {
    width: "30%",
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(255,255,255)',
    color: 'rgb(104,172,252)',
}

const editButton = {
    width: "10%",
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

const renderActivityHistory = (pageType, posts, upvotedPosts) => {
    if (pageType==0) return renderPosts(posts);
    else if(pageType==1) return renderArticles();
    else if(pageType==2) return renderComments();
    else if(pageType==3) return renderUpvotes(upvotedPosts);
}


const Profile = () => {

    const [pageType, setPageType] = useState(0);

    const [pageNo, setPageNo] = useState(1);

    const [picturePopup, setPicturePopup] = useState(false);

    const onChange = (page) => {
        setPageNo(page);
    }

    const { status: userStatus, user } = useSelector((state) => state.user);

    const userPhoto = 1;
    const userID = 14;

    const [userPhotoID, setUserPhotoID] = useState(userPhoto);

    const [postCount, setPostCount] = useState();
    const [posts, setPosts] = useState();
    
    useEffect(() => {
        fetchPostByUserId(userID, pageNo).then(res => {
            setPostCount(res.count);
            setPosts(res.results)
        });
    }, [pageNo]);

    const [upvotedPostCount, setUpvotedPostCount] = useState();
    const [upvotedPosts, setUpvotedPosts] = useState();

    useEffect(() => {
        fetchPostUpvotesByUserId(userID, pageNo).then(res => {
            setUpvotedPostCount(res.count);
            setUpvotedPosts(res.results)
        })
    }, [pageNo])

    const whichState = (pageType) => {
        if(pageType===0) return postCount;
        else if(pageType===1) return postCount; //articleCount;
        else if(pageType===2) return postCount; //commentCount;
        else if(pageType===3) return upvotedPostCount;
    }

    return (
        <div className="profile-container">
            <NavBar></NavBar>

            <div className="profile-header">
                <div className="profile-avatar">
                    {/* image src needs to be changed */}
                    <Avatar size={100} src={<Image src="https://m.media-amazon.com/images/M/MV5BODdhY2ZjY2UtYjY0NC00NTAxLWIwYzEtN2Y1ZjEyMWQ2MDJhXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg"></Image>}>

                    </Avatar>
                    <br></br>
                    
                </div>

                {
                    userStatus==="fulfilled" ? 
                    <div className="profile-edit-pp">
                        <Button style={editButton} onClick={() => setPicturePopup(true)}>
                            {
                                user.type===1 ? "Edit Profile Picture" : "Edit Avatar"
                            }
                        </Button>
                        
                        <Popup trigger={picturePopup} setTrigger={setPicturePopup}>
                            
                            <Image.PreviewGroup>
                                <Image 
                                width={200} 
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1" 
                                />
                                <Image
                                width={200}
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1"
                                />
                                <Image
                                width={200}
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1"
                                />
                                <Image
                                width={200}
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1"
                                />
                                <Image
                                width={200}
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1"
                                />
                                <Image
                                width={200}
                                src="https://img.a.transfermarkt.technology/portrait/big/8198-1668503200.jpg?lm=1"
                                />
                                
                            </Image.PreviewGroup>

                        </Popup>

                    </div> : null
                }
                


                <div className="profile-info">
                    {user.email}
                    <br></br>
                    user type {user.type}
                    <br></br>
                    post count {postCount}
                </div>
            </div>
            
            {!picturePopup ? 
            <div className="profile-activity-buttons">
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 0 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => {setPageType(0) ; setPageNo(1)}}
                    >
                        Posts
                </Button>
                {user.type === 1 ? 
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 1 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => {setPageType(1) ; setPageNo(1)}}
                    >
                        Articles
                </Button>
                : <></>}
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 2 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => {setPageType(2) ; setPageNo(1)}}
                    >
                        Comments
                </Button>
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 3 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => {setPageType(3) ; setPageNo(1)}}
                    >
                        Upvotes
                </Button>
            </div>
            : null}

            <div className="profile-activity">
                {renderActivityHistory(pageType, posts, upvotedPosts)}
            </div>
            
            <div className="profile-pagination">
                <Pagination 
                    defaultCurrent={pageNo} 
                    total={
                        whichState(pageType) 
                    } 
                    onChange={onChange}>

                </Pagination>
            </div>
        
        </div>

        

    )
}

export default Profile;




