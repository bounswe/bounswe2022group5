import React, {useState, useEffect} from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Avatar, Button , Pagination , Image , Dropdown , Form , Input , notification, Card} from "antd";
import { LockOutlined, UserOutlined } from '@ant-design/icons';

import "./Profile.css"
import Popup from "../../components/Popup/Popup";

import Articles from "../../layouts/Article/Article";
import Forum from "../../layouts/Forum/Forum";

import { useSelector } from 'react-redux';

import { fetchPostByUserId } from "../../redux/postSlice";
import { fetchArticleByUserId } from "../../redux/articleSlice";
import { fetchPostUpvotesByUserId, fetchArticleUpvotesByUserId, fetchPersonalInfo, fetchUpdatePersonalInfo, fetchUpdateAvatar } from "../../redux/profileSlice";

const {Meta} = Card;
const AVATAR_API_KEY = process.env.AVATAR_API_KEY;

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

const renderArticles = (results) => {
    return (
        <div>
            <Articles articles={results}/>
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

const renderUpvotedPosts = (results) => {
    return (
        <div>
            <Forum posts={results}/>
        </div>
    )
}

const renderUpvotedArticles = (results) => {
    return (
        <div>
            <Articles articles={results}/>
        </div>
    )
}

const renderActivityHistory = (pageType, posts, articles, upvotedPosts, upvotedArticles) => {
    if (pageType==0) return renderPosts(posts);
    else if(pageType==1) return renderArticles(articles);
    else if(pageType==2) return renderComments();
    else if(pageType==3) return renderUpvotedPosts(upvotedPosts);
    else if(pageType==4) return renderUpvotedArticles(upvotedArticles);
}


const Profile = () => {

    const [pageType, setPageType] = useState(0);

    const [pageNo, setPageNo] = useState(1);

    const [picturePopup, setPicturePopup] = useState(false);
    const [infoPopup, setInfoPopup] = useState(false);

    const onChange = (page) => {
        setPageNo(page);
    }

    const { status: userStatus, user } = useSelector((state) => state.user);

    const userPhotoURL = `https://api.multiavatar.com/1.svg?apikey=${AVATAR_API_KEY}`; //user.profile_image
    const userID = 14; //user.id
    //const userName = user.username;

    const [userPhoto, setUserPhoto] = useState(userPhotoURL);

    const [postCount, setPostCount] = useState();
    const [posts, setPosts] = useState();
    
    useEffect(() => {
        fetchPostByUserId(userID, pageNo).then(res => {
            setPostCount(res.count);
            setPosts(res.results)
        });
    }, [pageNo]);

    const [articleCount, setArticleCount] = useState();
    const [articles, setArticles] = useState();
    
    useEffect(() => {
        fetchArticleByUserId(userID, pageNo).then(res => {
            setArticleCount(res.count);
            setArticles(res.results)
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

    const [upvotedArticleCount, setUpvotedArticleCount] = useState();
    const [upvotedArticles, setUpvotedArticles] = useState();

    useEffect(() => {
        fetchArticleUpvotesByUserId(userID, pageNo).then(res => {
            setUpvotedArticleCount(res.count);
            setUpvotedArticles(res.results)
        })
    }, [pageNo])

    const whichState = (pageType) => {
        if(pageType===0) return postCount;
        else if(pageType===1) return postCount; //articleCount;
        else if(pageType===2) return postCount; //commentCount;
        else if(pageType===3) return upvotedPostCount;
        else if(pageType===4) return upvotedArticleCount;
    }

    const [username, setUsername] = useState();

    useEffect(() => {
        fetchPersonalInfo().then(res => {
            setUsername(res.member_username);
        })
    }, [infoPopup])
    
    const [form] = Form.useForm();

    const onFinishInfo = (values) => {
        const body = {...values, member_username:username}
        
        fetchUpdatePersonalInfo(body).then(res => {
            notification["success"]({
                message: 'Editing info is successful',
                placement: "top"
            });
            
            console.log("zartzurt");
        }).catch((err) => {
            notification["error"]({
                message: "Editing info is not successful",
                description: err?.message,
                placement: "top"
            });

            console.log("asdhjasgdasd");
        })

    };

    const onFinishAvatar = (id) => {
        fetchUpdateAvatar(id).then(res => {
            notification["success"]({
                message: 'Editing info is successful',
                placement: "top"
            });

        }).catch((err) => {
            notification["error"]({
                message: "Editing info is not successful",
                description: err?.message,
                placement: "top"
            });
        })
    }

    return (
        <div className="profile-container">
            <NavBar></NavBar>

            <div className="profile-header">
                <div className="profile-avatar">
                    
                    <Avatar size={100} src={<Image src={userPhoto}></Image>}>

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
                            
                            {user.type === 2 ?
                            <Card style={{width:'80%'}}>
                            <Card.Grid>
                                <Card
                                    style={{ width: 100 }}
                                    cover={<img src={`https://api.multiavatar.com/1.svg?apikey=${AVATAR_API_KEY}`}
                                    onClick={() => {
                                        setUserPhoto(`https://api.multiavatar.com/1.svg?apikey=${AVATAR_API_KEY}`); 
                                        onFinishAvatar(1);
                                    }} />}
                                >
                            
                                </Card>
                            </Card.Grid>
                            <Card.Grid >
                                <Card
                                    style={{ width: 100 }}
                                    cover={<img  src={`https://api.multiavatar.com/2.svg?apikey=${AVATAR_API_KEY}`}
                                    onClick={() => {
                                        setUserPhoto(`https://api.multiavatar.com/2.svg?apikey=${AVATAR_API_KEY}`); 
                                        onFinishAvatar(2)
                                    }} />}
                                >
                            
                                </Card>
                            </Card.Grid>
                            <Card.Grid >
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/3.svg?apikey=${AVATAR_API_KEY}`} 
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/3.svg?apikey=${AVATAR_API_KEY}`); onFinishAvatar(3)}}/>}
                                >
                            
                                </Card>
                            </Card.Grid>
                            <Card.Grid >
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/4.svg?apikey=${AVATAR_API_KEY}`}
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/4.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(4)}} />}
                                >
                            
                                </Card>
                            </Card.Grid>
                            <Card.Grid >
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/5.svg?apikey=${AVATAR_API_KEY}`} 
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/5.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(5)}}/>}
                                >   
                    
                                </Card>
                            </Card.Grid>
                            <Card.Grid>
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/6.svg?apikey=${AVATAR_API_KEY}`}
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/6.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(6)}} />}
                                >
                    
                                </Card>
                            </Card.Grid>
                            <Card.Grid>
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/7.svg?apikey=${AVATAR_API_KEY}`}
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/7.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(7)}} />}
                                >
                    
                                </Card>
                            </Card.Grid>
                            <Card.Grid>
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/8.svg?apikey=${AVATAR_API_KEY}`}
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/8.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(8)}} />}
                                >
                    
                                </Card>
                            </Card.Grid>
                            <Card.Grid>
                                <Card
                                style={{ width: 100 }}
                                cover={<img  src={`https://api.multiavatar.com/9.svg?apikey=${AVATAR_API_KEY}`}
                                onClick={() => {setUserPhoto(`https://api.multiavatar.com/9.svg?apikey=${AVATAR_API_KEY}`) ; onFinishAvatar(9)}} />}
                                >
                    
                                </Card>
                            </Card.Grid>
                            </Card>
                
                            :
                            <>sadasd</>
                            
                            }
                        </Popup>

                    </div> : null
                }
                


                <div className="profile-info">
                    {user.email}
                    <br></br>
                    user type {user.type}
                    aa{username}aa
                    <br></br>
                    post count {postCount}
                </div>

                {
                    !picturePopup && userStatus==="fulfilled" ? 
                    <div className="profile-edit-pp">
                        <Button style={editButton} onClick={() => setInfoPopup(true)}>
                            {
                                "Edit Info"
                            }
                        </Button>
                        
                        <Popup trigger={infoPopup} setTrigger={setInfoPopup}>
                            
                            <Form 
                                form={form} 
                                layout="inline" 
                                onFinish={onFinishInfo} 
                                className="form"
                                initialValues={{ remember: true }}
                            >
                                <Form.Item
                                    name="username"
                                >
                                    <Input 
                                        placeholder="New Username"
                                        value={username}
                                        onChange={(e) => setUsername(e.target.value)}
                                    />
                                </Form.Item>

                                <Form.Item >
                                    <Button type="primary" htmlType="submit" className="input-box">
                                        Submit
                                    </Button>
                                </Form.Item>
                            </Form>

                        </Popup>

                    </div> : null
                }
            </div>
            
            {!picturePopup && !infoPopup ? 
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
                        Upvoted Posts
                </Button>
                <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 4 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => {setPageType(4) ; setPageNo(1)}}
                    >
                        Upvoted Articles
                </Button>
            </div>
            : null}

            <div className="profile-activity">
                {renderActivityHistory(pageType, posts, articles, upvotedPosts, upvotedArticles)}
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




