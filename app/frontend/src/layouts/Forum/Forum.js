import React, {useState} from "react";
import {
  LikeOutlined,
  CheckCircleOutlined,
} from "@ant-design/icons";
import "./Forum.css";
import Vote from "../../components/Vote/Vote";
import { useNavigate } from "react-router-dom";


const Forum = ({posts, setPosts}) => {
  return (
    <div className="forum-page">
      {
        posts?.map(post => (

          <Post 
            title={post.title} 
            date={post.date} 
            author={post.author.username} 
            body={post.body} 
            commented_by_doctor={post.commented_by_doctor} 
            downvote={post.downvote} 
            upvote={post.upvote} 
            vote={post.vote} 
            id={post.id} 
            setPosts={setPosts}
          />

        ))

        //check if current user liked this post.
        
      }
    </div>
  );
}

const Post = (props) => {

  const navigate = useNavigate();

  return (
    <div className="post-container">
      <div className="post">
        <div className="post-header" onClick={() => navigate(`/post/${props.id}`)}>
            <div className="post-header-text">
            <h2>{props.title}</h2>
            </div>
            <div className="post-date">
              <p>Shared by {props.author}</p>
              <p>{props.date}</p>
            </div>
        </div>
        
        <div className="post-body">
          <div className="post-content">
            <p dangerouslySetInnerHTML={{ __html: props?.body }} />
            <div className="answered-by"> {props.commented_by_doctor ? <CheckCircleOutlined className="site-form-item-icon" /> : null } {props.commented_by_doctor} </div>
          </div>
          <div className="rating">

            <Vote item={props} type={"post"} setItem={props?.setPost}/>
            </div>  

          </div>
        </div>
    </div>
  );
}

export default Forum;
