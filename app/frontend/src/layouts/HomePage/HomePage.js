import React, { useState , useEffect} from "react";

import NavBar from "../NavBar/NavBar";
import Articles from "../Article/Article";
import Forum from "../Forum/Forum";

import { useSelector} from 'react-redux';
import { useNavigate } from "react-router-dom";

import "./HomePage.css";
import { Button, Input} from "antd";
import { fetchAllPosts } from "../../redux/postSlice";
import {fetchAllArticles} from "../../redux/articleSlice";

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

const categoryButtonsStyle = {
    height: "10%",
    width: "90%",
    borderRadius: "15%",
    backgroundColor: 'rgb(173,216,230)',
    marginTop: "1%"
}

const categorySearchStyle = {
    width: "90%",
}

const renderPosts = (posts) => {
    return (
        <div>
            <Forum posts={posts}/>
        </div>
    )
}

const renderArticles = (articles) => {
    return (
        <div>
            <Articles articles={articles}/>
        </div>
    )
}

const renderCategories = (searchKey) => {
    // There should be categories and related links
    const categories = [
        {
            name: "Dermatology",
            link: "/"
        }, 
        {
            name: "Cardiovascular",
            link: "/"
        }, 
        {
            name: "Infection",
            link: "/"
        }, 
        {
            name: "Cancer and Neoplasms",
            link: "/"
        }, 
        {
            name: "Inflamatory and Immune",
            link: "/"
        }, 
        {
            name: "Mental Health",
            link: "/"
        }, 
        {
            name: "Metabolic and Endocrine",
            link: "/"
        }, 
        {
            name: "Musculosketal",
            link: "/"
        }, 
        {
            name: "Neurological",
            link: "/"
        }, 
    ]

    return (
        categories.filter((obj) => {
            if(obj.name.toLowerCase().search(searchKey.toLowerCase()) > -1) {
                return obj
            }
            return null;
          }).map((item) => (
            <Button style={categoryButtonsStyle}>
                {item.name}
            </Button>
        ))
    )
}

const HomePageLayout = () => {
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
        fetchAllPosts(1).then(res => {
            setPostCount(res.count);
            setPosts(res.results)
        });

        fetchAllArticles(1).then(res => {
            setArticleCount(res.count);
            setArticles(res.results)
        })
        
    }, []);

    return(
        <div className="layout">
            <div className="header">
                <NavBar></NavBar>
            </div>
            <div className="content">
                <div className="forum-article-buttons">
                    <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 0 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(0)}
                    >
                        Posts
                    </Button>
                    <Button 
                    shape="round" 
                    size="large" 
                    style={pageType === 1 ? buttonStyleClicked : buttonStyleUnclicked}
                    onClick={() => setPageType(1)}
                    >
                        Articles
                    </Button>
                </div>
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
                            <div className="category-search-bar">
                                <Input 
                                    style={categorySearchStyle}
                                    placeholder="Search Categories" 
                                    value={categorySearchInput}
                                    onChange={(e) => setCategorySearchInput(e.target.value)}
                                />
                            </div>
                            {renderCategories(categorySearchInput)}
                        </div>
                    </div>
                    <div className="articles-or-posts">
                        {pageType === 0 ? renderPosts(posts): renderArticles(articles)}
                    </div>
                </div>
            </div>
            {/* <div className="footer">
                Footer
            </div> */}
        </div>
    )
}

export default HomePageLayout;
