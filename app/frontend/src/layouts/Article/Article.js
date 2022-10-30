import React, { useReducer, useState } from "react";
import { LikeOutlined, CalendarOutlined } from "@ant-design/icons";
import "./Article.css";

const Articles = () => {
  return (
    <div className="articles">
      <Article
        header="Right atrial and right ventricular rupture with cardiac tamponade secondary to nonpenetrating blunt trauma to the chest: report of case of survival and review of literature"
        author="Dr. Deitra Rebeccah"
        date="21.03.2022"
        dislike_count={2}
        like_count={2}
        user_vote="dislike"
      ></Article>

      <Article
        header="Effects of intermittent fasting on basal metabolism"
        author="Dr. Deitra Rebeccah"
        date="21.03.2022"
        dislike_count={2}
        like_count={25}
        user_vote=""
      ></Article>

      <Article
        header="ALCALINE DIET"
        author="Dr. Deitra Rebeccah"
        date="21.03.2022"
        dislike_count={23}
        like_count={214}
        user_vote=""
      ></Article>

      <Article
        header="Optimization and Validation of Dosage Regimen for Ceftiofur against Pasteurella multocida in Swine by Physiological Based Pharmacokinetic-Pharmacodynamic Model."
        author="Dr. Deitra Rebeccah"
        date="21.03.2022"
        dislike_count={44}
        like_count={14}
        user_vote=""
      ></Article>
    </div>
  );
};

const voteReducer = (state, action) => {
  switch (action.type) {
    case "clickLike": {
      if (state.userVote == "like") {
        return {
          userVote: "",
          likeCount: state.likeCount - 1,
          dislikeCount: state.dislikeCount,
        };
      }
      if (state.userVote == "dislike") {
        return {
          userVote: "like",
          likeCount: state.likeCount + 1,
          dislikeCount: state.dislikeCount - 1,
        };
      }
      return {
        userVote: "like",
        likeCount: state.likeCount + 1,
        dislikeCount: state.dislikeCount,
      };
    }
    case "clickDislike": {
      if (state.userVote == "dislike") {
        return {
          userVote: "",
          likeCount: state.likeCount,
          dislikeCount: state.dislikeCount - 1,
        };
      }
      if (state.userVote == "like") {
        return {
          userVote: "dislike",
          likeCount: state.likeCount - 1,
          dislikeCount: state.dislikeCount + 1,
        };
      }
      return {
        userVote: "dislike",
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
                  {vote.userVote === "like" ? (
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
                  {vote.userVote === "dislike" ? (
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
