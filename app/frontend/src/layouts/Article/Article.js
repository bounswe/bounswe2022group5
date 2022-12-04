import React, { useReducer, useState } from "react";
import { LikeOutlined, CalendarOutlined } from "@ant-design/icons";
import "./Article.css";

const Articles = ({articles}) => {
  return (
    <div className="articles">
      {
        articles?.map(article => (
          <Article
            header={article.title}
            author={article.author.username}
            date={article.date}
            dislike_count={article.downvote}
            like_count={article.upvote}
            user_vote={article.vote}
          ></Article>
        ))
      }
  
      
    </div>
  );
};

const voteReducer = (state, action) => {
  switch (action.type) {
    case "clickLike": {
      if (state.userVote == "upvote") {
        return {
          userVote: "",
          likeCount: state.likeCount - 1,
          dislikeCount: state.dislikeCount,
        };
      }
      if (state.userVote == "downvote") {
        return {
          userVote: "upvote",
          likeCount: state.likeCount + 1,
          dislikeCount: state.dislikeCount - 1,
        };
      }
      return {
        userVote: "upvote",
        likeCount: state.likeCount + 1,
        dislikeCount: state.dislikeCount,
      };
    }
    case "clickDislike": {
      if (state.userVote == "downvote") {
        return {
          userVote: "",
          likeCount: state.likeCount,
          dislikeCount: state.dislikeCount - 1,
        };
      }
      if (state.userVote == "upvote") {
        return {
          userVote: "downvote",
          likeCount: state.likeCount - 1,
          dislikeCount: state.dislikeCount + 1,
        };
      }
      return {
        userVote: "downvote",
        likeCount: state.likeCount,
        dislikeCount: state.dislikeCount + 1,
      };
    }
    default:
      return state;
  }
};

const Article = (props) => {
  //   const [userVote, setUserVote] = useState(props.user_vote);
  //   const [likeCount, setLikeCount] = useState(props.like_count);
  //   const [dislikeCount, setDislikeCount] = useState(props.dislike_count);

  const [vote, dispatch] = useReducer(voteReducer, {
    userVote: props.user_vote,
    likeCount: props.like_count,
    dislikeCount: props.dislike_count,
  });

  /*
  useEffect(() => {
    return() => {
        //API CALL FOR LIKE & DISLIKE
    }
  }, [])
  */

  const handleOnVote = (event, param) => {
    dispatch({
      type: param,
    });
  };

  return (
    <div className="article-container">
      <div className="article">
        <div className="article-header">
          <h2>{props.header}</h2>
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
              <div className="like-rating">
                <div className="like-count">{vote.likeCount}</div>
                <div
                  className="like-icon"
                  onClick={(event) => handleOnVote(event, "clickLike")}
                >
                  {vote.userVote === "upvote" ? (
                    <LikeOutlined
                      style={{ fontSize: "30px", color: "#3EBE11" }}
                    />
                  ) : (
                    <LikeOutlined style={{ fontSize: "30px" }} />
                  )}
                </div>
              </div>
              <div className="dislike-rating">
                <div className="dislike-count">{vote.dislikeCount}</div>
                <div
                  className="dislike-icon"
                  onClick={(event) => handleOnVote(event, "clickDislike")}
                >
                  {vote.userVote === "downvote" ? (
                    <LikeOutlined
                      style={{
                        fontSize: "30px",
                        color: "#FB2727",
                        rotate: "180deg",
                      }}
                    />
                  ) : (
                    <LikeOutlined
                      style={{ fontSize: "30px", rotate: "180deg" }}
                    />
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Articles;
