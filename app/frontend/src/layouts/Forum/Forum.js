import React from "react";
import {
  LikeOutlined,
  CheckCircleOutlined,
} from "@ant-design/icons";
import "./Forum.css";



const Forum = ({posts}) => {
  return (
    <div className="forum-page">
      {
        posts?.map(post => (
          <Post header={post.title} date={post.date} author={post.author} content={post.body} answeredBy={post.commented_by_doctor} dislikeCount={post.downvote} likeCount={post.upvote} userVote={post.vote}/>
        ))

        //check if current user liked this post.
        
      }
    </div>
  );
}

const Post = (props) => {
  return (
    <div className="post-container">
      <div className="post">
        <div className="post-header">
            <div className="post-header-text">
            <h2>{props.header}</h2>
            </div>
            <div className="post-date">
              <p>Shared by {props.author}</p>
              <p>{props.date}</p>
            </div>
        </div>
        
        <div className="post-body">
          <div className="post-content">
            <p>
              {props.content}
            </p>
            <div className="answered-by"> {props.answeredBy ? <CheckCircleOutlined className="site-form-item-icon" /> : null } {props.answeredBy} </div>
          </div>
          <div className="rating">
            <div className="like-rating">
              <div className="like-count"> <p>{props.likeCount}</p> </div>
              <div className="like-icon"> { props.userVote === "upvote" ? <LikeOutlined style={{fontSize: '30px', color: '#3EBE11'}}/> : <LikeOutlined style={{fontSize: '30px'}}/> } </div>
            </div>
            <div className="dislike-rating">
              <div className="dislike-count"> <p>{props.dislikeCount}</p> </div>
              <div className="dislike-icon"> </div> {props.userVote === "downvote" ? <LikeOutlined style={{fontSize: '30px', color: '#FB2727', rotate: '180deg'}} /> : <LikeOutlined style={{fontSize: '30px', rotate: '180deg'}} /> }</div>
            </div>
            
          </div>
        </div>
    </div>
  );
}

export default Forum;
