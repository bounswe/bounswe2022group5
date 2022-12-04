import React, { useState } from "react";
import { CalendarOutlined } from "@ant-design/icons";
import "./Article.css";
import Vote from "../../components/Vote/Vote";

const Articles = ({articles}) => {
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

          ></Article>
        ))
      }
  
      
    </div>
  );
};



const Article = (propsComing) => {

  const [props, setArticle] = useState(propsComing);

  return (
    <div className="article-container">
      <div className="article">
        <div className="article-header">
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

              <Vote item={props} setItem={setArticle}/>

            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Articles;
