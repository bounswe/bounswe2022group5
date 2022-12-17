import React, { useState , useEffect} from "react";
import { useParams } from 'react-router-dom';
import NavBar from "../NavBar/NavBar";
import Articles from "../Article/Article";
import Forum from "../Forum/Forum";

import { useSelector} from 'react-redux';
import { useNavigate } from "react-router-dom";

import "./HomePage.css";
import { Button, Input, Pagination} from "antd";
import { fetchAllPosts } from "../../redux/postSlice";
import {fetchAllArticles} from "../../redux/articleSlice";
import { fetchCategories } from "../../redux/categorySlice";

const buttonStyleClicked = {
    width: "40%",
    borderRadius: 2,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(104,172,252)',
    color: 'rgb(255,255,255)'
}

const buttonStyleUnclicked = {
    width: "40%",
    borderRadius: 2,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(255,255,255)',
    color: 'rgb(104,172,252)',
}

const categoryButtonsStyle = {
    width: "75%",
    borderRadius: "4px",
    backgroundColor: 'rgb(173,216,230)',
    marginTop: "2%",
    whiteSpace: "normal",
    height:'auto',
}

const categoryFollowStyle = {
    width: "20%",
    borderRadius: "4px",
    backgroundColor: '#1890ff',
    color: 'rgb(255,255,255)',
    marginTop: "2%",
    whiteSpace: "normal",
    height:'auto',
}

const categoryUnfollowStyle = {
    width: "20%",
    borderRadius: "4px",
    backgroundColor: 'rgb(255,255,255)',
    color: '#1890ff',
    marginTop: "2%",
    whiteSpace: "normal",
    height:'auto',
}

const categorySearchStyle = {
    width: "90%",
}

const renderPosts = (posts, setPosts) => {
    return (
        <div>
            <Forum posts={posts} setPosts={setPosts}/>
        </div>
    )
}

const renderArticles = (articles, setArticles) => {
    return (
        <div>
            <Articles articles={articles} setArticles={setArticles}/>
        </div>
    )
}


const RenderCategories = (searchKey) => {

    // There should be categories and related links
    const navigate = useNavigate();

    const [categories, setCategories] = useState([]);
    
    useEffect(() => {
        fetchCategories().then(res => {
            setCategories(res);
        });
    }, []);

    return (
        categories.filter((obj) => {
            if(obj.name.toLowerCase().search(searchKey.toLowerCase()) > -1) {
                return obj
            }
            return null;
          }).map((item) => (
            <div className="follow-category">
            <Button style={categoryButtonsStyle} onClick={() => navigate('/' + item.name )}>
                {item.name}
            </Button>
            <Button style={true ? categoryUnfollowStyle : categoryFollowStyle} >{true ? 'Unfollow' : 'Follow'}</Button>
            </div>
        ))
    )
}

const HomePageLayout = () => {
    const param = useParams()?.category?.replaceAll("%20", "");
    const query = useParams()?.query?.replaceAll("%20", "");

    const category = param !== undefined ? param : "";

    const navigate = useNavigate();
    const {status: userStatus, user } = useSelector((state) => state.user);
    const [categorySearchInput, setCategorySearchInput] = useState("");

    const [pageType, setPageType] = useState(0);
    // This is for determining whether the page renders post or article. 0 for post, 1 for article

    const [postCount, setPostCount] = useState();
    const [posts, setPosts] = useState();

    const [articleCount, setArticleCount] = useState();
    const [articles, setArticles] = useState();
    
    useEffect(() => {
        fetchAllPosts(1, 10, query ? null : category, query !== "" ? query : null).then(res => {
            setPosts(res.results)
            setPostCount(res.count);
        });

        fetchAllArticles(1, 10, query ? null : category, query !== "" ? query : null).then(res => {
            setArticleCount(res.count);
            setArticles(res.results)
        })
        return () =>{

        }
    }, [category, query]);


    const onChangePost = (pageNumber, itemPerPage) => {
        fetchAllPosts(pageNumber,itemPerPage,category).then(res => {
            setPosts(res.results)
        });
    };

    const onChangeArticle = (pageNumber, itemPerPage) => {
        fetchAllArticles(pageNumber,itemPerPage,category).then(res => {
            setArticles(res.results)
        });
    };

    return(
        <div className="layout">
            <div className="header">
                <NavBar query={query}></NavBar>
            </div>
            <div className="content">
                <div className="category-post-articles">
                    <div className="categories-and-create-post">
                        {user.type === 1 ? 
                        <Button 
                        shape="round" 
                        size="large" 
                        onClick={() => navigate("/create-article")} 
                        style={{width:"60%", height:"12%", flex:1, marginLeft:"20%", marginTop:"5%"}}>
                            Create Article
                        </Button> :
                        null}
                        {user.type === 1 || user.type === 2 ? 
                        <Button 
                        shape="round" 
                        size="large"  
                        onClick={() => navigate("/create-post")} 
                        style={{width:"60%", height:"12%", flex:1, marginLeft:"20%", marginTop:"5%"}}>
                            Create Post
                        </Button> :
                        null}
                        <div className="categories">
                            <h3>CATEGORIES</h3>
                            <div className="category-search-bar">
                                <Input 
                                    style={categorySearchStyle}
                                    placeholder="Search Categories" 
                                    value={categorySearchInput}
                                    onChange={(e) => setCategorySearchInput(e.target.value)}
                                />
                            </div>
                            {RenderCategories(categorySearchInput)}
                        </div>
                    </div>
                    <div className="articles-or-posts">
                        <div className="forum-article-buttons">
                            <Button 
                                size="large" 
                                style={pageType === 0 ? buttonStyleClicked : buttonStyleUnclicked}
                                onClick={() => setPageType(0)}
                            >
                                Posts
                            </Button>
                            <Button 
                                size="large" 
                                style={pageType === 1 ? buttonStyleClicked : buttonStyleUnclicked}
                                onClick={() => setPageType(1)}
                            >
                                Articles
                            </Button>
                        </div>
                        {pageType === 0 ? renderPosts(posts, setPosts): renderArticles(articles, setArticles)}
                        {pageType === 0 ? <Pagination  showQuickJumper defaultCurrent={1} total={postCount} onChange={onChangePost} /> : <Pagination showQuickJumper defaultCurrent={1} total={articleCount} onChange={onChangeArticle} /> }
                    </div>
                </div>
            </div>
        </div>
    )
}

export default HomePageLayout;
