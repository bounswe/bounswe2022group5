import React, { useState } from "react";

import NavBar from "../NavBar/NavBar";
import Articles from "../Article/Article";
import Forum from "../Forum/Forum";

import { useSelector} from 'react-redux';

import "./HomePage.css";
import { Button, Input} from "antd";

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

const renderPosts = () => {
    return (
        <div>
            <Forum/>
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
    const {status: userStatus } = useSelector((state) => state.user);
    const [categorySearchInput, setCategorySearchInput] = useState("");

    const [pageType, setPageType] = useState(0);
    // This is for determining whether the page renders post or article. 0 for post, 1 for article

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
                        {userStatus === "fulfilled" ? 
                        <Button shape="round" size="large" style={{width:"60%", height:"12%", flex:1, marginLeft:"20%", marginTop:"5%"}}>
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
                        {pageType === 0 ? renderPosts(): renderArticles()}
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

