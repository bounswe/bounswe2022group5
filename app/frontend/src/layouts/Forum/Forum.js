import React from "react";
import {
  LikeOutlined,
  CheckCircleOutlined,
} from "@ant-design/icons";
import "./Forum.css";



const Forum = () => {
  return (
    <div className="forum-page">
      <Post header="ACNELYSTE BURNS OCCURRED" date="03.07.2022" content="I have been using ACNELYSTE for about 2 months, my cheeks were
            burning while I was using it, but there was no redness. I applied more
            than a pea pod and I got a rash on my cheek. Will this redness go
            away? Please help" answeredBy="Answered by Dr. Betty Black" dislikeCount="7" likeCount="13" userVote="like"/>
      <Post header="LOTION FOR HAIR ECZEMA" date="02.11.2022" content="I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do?
            away? Please help" dislikeCount="2" likeCount="6" userVote="dislike" />
      <Post header="FACE NUMBING AND BLURRED VISION" date="03.17.2022" content="I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a 
            cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is ....." dislikeCount="1" likeCount="16" userVote="like" />
      <Post header="ACNELYSTE BURNS OCCURRED" date="03.21.2022" content="As a result of the blood test I had, iron was found to be 211.117. Ferritin 53.99. My doctor said it was not anemia. 
            Is it normal for iron to be this high? What do you suggest?" dislikeCount="21" likeCount="76" userVote="dislike" />
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
              <div className="like-icon"> { props.userVote === "like" ? <LikeOutlined style={{fontSize: '30px', color: '#3EBE11'}}/> : <LikeOutlined style={{fontSize: '30px'}}/> } </div>
            </div>
            <div className="dislike-rating">
              <div className="dislike-count"> <p>{props.dislikeCount}</p> </div>
              <div className="dislike-icon"> </div> {props.userVote === "dislike" ? <LikeOutlined style={{fontSize: '30px', color: '#FB2727', rotate: '180deg'}} /> : <LikeOutlined style={{fontSize: '30px', rotate: '180deg'}} /> }</div>
            </div>
            
          </div>
        </div>
    </div>
  );
}

export default Forum;
