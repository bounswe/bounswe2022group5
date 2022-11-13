import React, { useState, useEffect } from "react";
import { useParams } from 'react-router-dom';
import {
    CheckCircleOutlined,
    LikeOutlined
} from "@ant-design/icons";

import "./Post.css";

import { fetchPostById } from "../../redux/postSlice";

const Post = () => {
    const id = useParams()?.id;

    const [post, setPost] = useState({
        title: "Lotion for hair eczama",
        body: "I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help",
        date: "02.11.2022",
        author: "Betty Black",
        user_vote: "upvote",
        upvote_count: 3,
        downvote_count: 6,
        comments: [{
            author: {
                type: "doctor",
                name: "Dr. Belly Button"
            }
        }]
    });

    useEffect(() => {
        post.comments.forEach(comment => {
            if(comment.author.type === "doctor") {
                setPost(post => ({ ...post, answered_by: comment.author.name }))
            }
        })
    // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [])

    // useEffect(() => {
    //     fetchPostById(id)
    //         .then(res => setPost(res))
    // }, [id])

    const handleVote = (voteValue) => {
        if(voteValue === "upvote") {
            if(post.user_vote === "upvote") {
                setPost({ ...post, upvote_count: post.upvote_count - 1, user_vote: null })
                return;
            }
            if(post.user_vote === "downvote") {
                setPost({ ...post, downvote_count: post.downvote_count - 1, upvote_count: post.upvote_count + 1, user_vote: "upvote" })
                return;
            }
            setPost({ ...post, upvote_count: post.upvote_count + 1, user_vote: "upvote" })
        }
        if(voteValue === "downvote") {
            if(post.user_vote === "downvote") {
                setPost({ ...post, downvote_count: post.downvote_count - 1, user_vote: null })
                return;
            }
            if(post.user_vote === "upvote") {
                setPost({ ...post, downvote_count: post.downvote_count + 1, upvote_count: post.upvote_count - 1, user_vote: "downvote" })
                return;
            }
            setPost({ ...post, downvote_count: post.downvote_count + 1, user_vote: "downvote" })
        }
    }

    return(
        <div className="discussion-container">
            <div className="discussion-post">
                <div className="discussion-avatar-body">
                    <div>
                        <img className="discussion-avatar" alt="avatar" src="https://www.w3schools.com/w3images/avatar6.png"/>
                    </div>
                    <div>
                        <div className="discussion-upper">
                            <div className="discussion-title">
                                <span className="discussion-title-text" style={{fontSize: "28px"}}>{post?.title}</span>
                                <span className="discussion-title-author" style={{fontSize: "12px"}}>by {post.author}</span>
                            </div>
                            <div className="discussion-date">{post?.date}</div>
                        </div>
                        <div className="discussion-body-votes">
                            <div>{post?.body}</div>
                            <div className="discussion-rating">
                                <div className="discussion-upvote">
                                    <div className="upvote-count">{post?.upvote_count}</div>
                                    <div
                                        className="like-icon"
                                        onClick={() => handleVote("upvote")}
                                    >
                                        {post.user_vote === "upvote" ? (
                                            <LikeOutlined
                                                style={{ fontSize: "30px", color: "#3EBE11" }}
                                            />
                                        ) : (
                                            <LikeOutlined style={{ fontSize: "30px" }} />
                                        )}
                                    </div>
                                </div>
                                <div className="discussion-downvote">
                                    <div className="downvote-count">{post?.downvote_count}</div>
                                    <div
                                        className="dislike-icon"
                                        onClick={() => handleVote("downvote")}
                                    >
                                    {post.user_vote === "downvote" ? (
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
                        { post?.answered_by ? <div className="discussion-doctor">
                             <CheckCircleOutlined className="discussion-check-sign"/>
                            Answered by {post?.answered_by}
                        </div> : null }
                    </div>
                </div>

                <div className="discussion-comments">
                    { post?.comments?.length > 0 ? <div></div> :
                    
                    <div className="discussion-no-comment">
                        This post has no comment yet. Be the first one
                    </div> }
                </div>
            </div>
        </div>
    );
};

export default Post;