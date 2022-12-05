import React, { useState } from "react";
import { CalendarOutlined } from "@ant-design/icons";
import "./Article.css";
import Vote from "../../components/Vote/Vote";
import { useNavigate } from "react-router-dom";


const Articles = ({articles, setArticles}) => {
  return (
    <div className="articles">
      {
        articles?.map(article => (
          <Article
            title={article.title}
            author={article.author.username}
            date={article.date}
            downvote={article.downvote}
            upvote={article.upvote}
            vote={article.vote}
            id={article.id}
            setArticles={setArticles}
          />
        ))
      }
  
      
    </div>
  );
};



const Article = (props) => {

  const navigate = useNavigate();

  return (
    <div className="article-container">
      <div className="article">
        <div className="article-header" onClick={() => navigate(`/article/${props.id}`)}>
          <h2>{props.title}</h2>
        </div>

        <div className="article-footer">
          <div className="article-author"></div>
          {props.author}
          <div className="article-info">
            <div className="article-date">
              {
                <CalendarOutlined className="site-form-item-icon"></CalendarOutlined>
              }
              {props.date}
            </div>

            <div className="article-rating">

              <Vote item={props} setItem={props.setArticle}/>

            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Articles;
