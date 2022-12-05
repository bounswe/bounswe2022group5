import React, {useState, useEffect} from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Avatar, Button , Pagination , Image , Dropdown , Form , Input , notification, Card, Upload, Modal } from "antd";
import { LoadingOutlined , PlusOutlined } from '@ant-design/icons';

import "./Profile.css"
import Popup from "../../components/Popup/Popup";

import Articles from "../../layouts/Article/Article";
import Forum from "../../layouts/Forum/Forum";

import { useSelector, useDispatch } from 'react-redux';


import { fetchPostByUserId } from "../../redux/postSlice";
import { fetchArticleByUserId } from "../../redux/articleSlice";
import { fetchCommentByUserId } from "../../redux/commentSlice";
import { fetchPostUpvotesByUserId, fetchArticleUpvotesByUserId, fetchPersonalInfo, fetchUpdatePersonalInfo, fetchUpdateAvatar, fetchUpdateProfilePicture } from "../../redux/profileSlice";
import { setUser } from "../../redux/userSlice";

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

const renderPosts = (results, setPosts) => {
    return (
        
        <div>
            <Forum posts={results} setPosts={setPosts}/>
        </div>
        
        
    )
}

const renderArticles = (results, setArticles) => {
    return (
        <div>
            <Articles articles={results} setArticles={setArticles}/>
        </div>
    )
}

const renderComments = (results, setPosts) => {
    return (
        <div>
            <Forum posts={results} setPosts={setPosts}/>
        </div>
    )
}

const renderUpvotedPosts = (results, setPosts) => {
    return (
        <div>
            <Forum posts={results} setPosts={setPosts}/>
        </div>
    )
}

const renderUpvotedArticles = (results, setArticles) => {
    return (
        <div>
            <Articles articles={results} setArticles={setArticles}/>
        </div>
    )
}

const getBase64 = (file) => {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => resolve(reader?.result);
        reader.onerror = (error) => reject(error);
    });
};

const Profile = () => {

    const { status: userStatus, user } = useSelector((state) => state.user);
    const userID = user.id; //user.id

    const [pageType, setPageType] = useState(0);

    const [pageNo, setPageNo] = useState(1);

    const [picturePopup, setPicturePopup] = useState(false);
    const [infoPopup, setInfoPopup] = useState(false);

    const onChange = (page) => {
        setPageNo(page);
    }

    const userPhotoURL = user?.profile_image; //user.profile_image
    
    console.log(user);
    console.log(userID);

    //const userName = user.username;

    const [userPhoto, setUserPhoto] = useState(userPhotoURL);

    const [postCount, setPostCount] = useState();
    const [posts, setPosts] = useState();
    
    useEffect(() => {
        if(user.id){
            fetchPostByUserId(userID, pageNo).then(res => {
                setPostCount(res.count);
                setPosts(res.results)
            });
        }
        
    }, [pageNo, user, pageType]);

    const [articleCount, setArticleCount] = useState();
    const [articles, setArticles] = useState();
    
    useEffect(() => {
        if(user.id){
            fetchArticleByUserId(userID, pageNo).then(res => {
                setArticleCount(res.count);
                setArticles(res.results)
            });
        }
        
    }, [pageNo, user, pageType]);

    const [commentCount, setCommentCount] = useState();
    const [comments, setComments] = useState();
    
    useEffect(() => {
        if(user.id){
            fetchCommentByUserId(userID, pageNo).then(res => {
                setCommentCount(res.count);
                setComments(res.results)
            });
        }
        
    }, [pageNo, user, pageType]);

    const [upvotedPostCount, setUpvotedPostCount] = useState();
    const [upvotedPosts, setUpvotedPosts] = useState();

    useEffect(() => {
        fetchPostUpvotesByUserId(userID, pageNo).then(res => {
            setUpvotedPostCount(res.count);
            setUpvotedPosts(res.results)
        })
    }, [pageNo, pageType])

    const [upvotedArticleCount, setUpvotedArticleCount] = useState();
    const [upvotedArticles, setUpvotedArticles] = useState();

    useEffect(() => {
        fetchArticleUpvotesByUserId(userID, pageNo).then(res => {
            setUpvotedArticleCount(res.count);
            setUpvotedArticles(res.results)
        })
    }, [pageNo, pageType])
    

    const whichState = (pageType) => {
        if(pageType===0) return postCount;
        else if(pageType===1) return articleCount;
        else if(pageType===2) return commentCount;
        else if(pageType===3) return upvotedPostCount;
        else if(pageType===4) return upvotedArticleCount;
    }

    const [username, setUsername] = useState();
    const [hospitalName, setHospitalName] = useState();

    useEffect(() => {
        fetchPersonalInfo().then(res => {
            setUsername(res.member_username);
            setHospitalName(res.hospital_name);
        })
    }, [])
    
    const [form] = Form.useForm();

    const onFinishInfoMember = (values) => {
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

        })

    };

    const onFinishInfoDoctor = (values) => {
        const body = {...values, hospital_name:hospitalName}
        
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

        })

    };

    const onFinishAvatar = (pid) => {
        const body = {avatar: pid}

        fetchUpdateAvatar(body).then(res => {
            notification["success"]({
                message: 'Editing avatar is successful',
                placement: "top"
            });

        }).catch((err) => {
            notification["error"]({
                message: "Editing avatar is not successful",
                description: err?.message,
                placement: "top"
            });
        })
    }

    const renderActivityHistory = () => {
        if (pageType==0) return renderPosts(posts, setPosts);
        else if(pageType==1) return renderArticles(articles, setArticles);
        else if(pageType==2) return renderComments(comments, setComments);
        else if(pageType==3) return renderUpvotedPosts(upvotedPosts, setUpvotedPosts);
        else if(pageType==4) return renderUpvotedArticles(upvotedArticles, setUpvotedArticles);
    }

   
    const [previewOpen, setPreviewOpen] = useState(false);
    const [previewImage, setPreviewImage] = useState('');
    const [previewTitle, setPreviewTitle] = useState('');
    const [fileList, setFileList] = useState([]);

    const handleCancel = () => setPreviewOpen(false);

    const handlePreviewProfilePicture = async (file) => {
        if (!file.url && !file.preview) {
        file.preview = await getBase64(file?.originFileObj);
        }

        setPreviewImage(file?.url || (file?.preview));
        setPreviewOpen(true);
        setPreviewTitle(file?.name || file?.url?.substring(file?.url?.lastIndexOf('/') + 1));
    };

    const handleChangeProfilePicture = ({ fileList: newFileList }) => {
        if(fileList.length < newFileList.length) {
            setFileList([...newFileList.slice(0, newFileList.length - 1), { ...newFileList[newFileList.length - 1], status: "done" }]);
          } else if (fileList.length > newFileList.length){
            setFileList(newFileList.filter(f => f.status !== "removed"));
        }
    };

    const handleSubmit = () => {

        let postData = new FormData();

        for (let i = 0; i<fileList.length; i++) {
            postData.append(`image${i+1}`, fileList[i]?.originFileObj);
        }

        fetchUpdateProfilePicture(postData)
            .then((res) => {

                notification["success"]({
                    message: 'Profile picture is changed',
                    placement: "top"
                });
            })
            .catch(() => {
                notification["error"]({
                    message: 'Profile Picture is not changed',
                    placement: "top"
                });
            })
    };

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
                            <div>
                                <Upload
                                name="avatar"
                                listType="picture-card"
                                maxCount={1}
                                onPreview={handlePreviewProfilePicture}
                                onChange={handleChangeProfilePicture}
                                >
                                    <div>
                                        <PlusOutlined />
                                        <div style={{ marginTop: 8 }}>Upload</div>
                                    </div>
                                </Upload>
                                <Modal open={previewOpen} title={previewTitle} footer={null} onCancel={handleCancel}>
                                    <img alt="example" style={{ width: '100%' }} src={previewImage} />
                                </Modal>

                                <Button 
                                type="primary"
                                shape="round" 
                                size="large" 
                                onClick={handleSubmit}
                                >
                                    Change Profile Picture
                                </Button>

                            </div>
                            
                            
                            }
                        </Popup>

                    </div> : null
                }
                


                <div className="profile-info">
                    Email: {user.email}
                    <br></br>
                    {user.type===1 ? 'Name Surname' : 'Username'}: {username} 
                    {/* user.username yerine const username'den cekmek istiyorum */}
                    <br></br>
                    User ID: {userID}
                    <br></br>
                    User Type: {user.type===2 ? 'Member' : 'Doctor'}
                    <br></br>
                    {user.type===1 && hospitalName ? `Hospital Name: ${hospitalName}` : <></>}
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
                            {user.type===2 ? 
                                <Form 
                                form={form} 
                                layout="inline" 
                                onFinish={onFinishInfoMember} 
                                className="form"
                                initialValues={{ remember: true }}
                                >
                                <Form.Item
                                    name="username"
                                >
                                    <Input 
                                        placeholder="New Username"
                                        onChange={(e) => setUsername(e.target.value)}
                                    />
                                </Form.Item>

                                <Form.Item >
                                    <Button type="primary" htmlType="submit" className="input-box">
                                        Submit
                                    </Button>
                                </Form.Item>
                                </Form>

                                :
                                
                                <Form 
                                form={form} 
                                layout="inline" 
                                onFinish={onFinishInfoDoctor} 
                                className="form"
                                initialValues={{ remember: true }}
                                >
                                <Form.Item
                                    name="hospitalName"
                                >
                                    <Input 
                                        placeholder="New Hospital Name"
                                        value={hospitalName}
                                        onChange={(e) => setHospitalName(e.target.value)}
                                    />
                                </Form.Item>

                                <Form.Item >
                                    <Button type="primary" htmlType="submit" className="input-box">
                                        Submit
                                    </Button>
                                </Form.Item>
                                </Form>

                            }
                            

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
                {renderActivityHistory(pageType, posts, articles, comments, upvotedPosts, upvotedArticles)}
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




