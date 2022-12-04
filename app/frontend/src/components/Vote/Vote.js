import React from 'react';

import {
    LikeOutlined
} from "@ant-design/icons";

import { 
    fetchDownvoteComment, 
    fetchUpvoteComment, 
    fetchUpvotePost, 
    fetchDownvotePost, 
    fetchUpvoteArticle,
    fetchDownvoteArticle
} from '../../redux/voteSlice';

import "./Vote.css";

const Vote = ({ item, type, setItem, className }) => {
    
    const handleVote = (voteValue) => {
        if(voteValue === "upvote") {
            if(item?.vote === "upvote") {
                setItem({ ...item, upvote: item?.upvote - 1, vote: null })
            } else if(item?.vote === "downvote") {
                setItem({ ...item, downvote: item?.downvote - 1, upvote: item?.upvote + 1, vote: "upvote" })
            } else {
                setItem({ ...item, upvote: item?.upvote + 1, vote: "upvote" });
            }

            if (type === "comment") {
                fetchUpvoteComment(item.id);
            } else if(type === "post"){
                fetchUpvotePost(item.id);
            }else{
                fetchUpvoteArticle(item.id);
            }
        }
        if(voteValue === "downvote") {
            if(item?.vote === "downvote") {
                setItem({ ...item, downvote: item?.downvote - 1, vote: null })
            } else if(item?.vote === "upvote") {
                setItem({ ...item, downvote: item?.downvote + 1, upvote: item?.upvote - 1, vote: "downvote" })
            } else {
                setItem({ ...item, downvote: item?.downvote + 1, vote: "downvote" });
            }
            

            if (type === "comment") {
                fetchDownvoteComment(item.id);
            } else if(type === "post"){
                fetchDownvotePost(item.id);
            }else{
                fetchDownvoteArticle(item.id);
            }
        }
    }

    return(
        <div className={`discussion-rating ${className}`}>
            <div className="discussion-upvote">
                <div className="upvote-count">{item?.upvote}</div>
                <div
                    className="like-icon"
                    onClick={() => handleVote("upvote")}
                >
                    {item?.vote === "upvote" ? (
                        <LikeOutlined
                            style={{ fontSize: "30px", color: "#3EBE11" }}
                        />
                    ) : (
                        <LikeOutlined style={{ fontSize: "30px" }} />
                    )}
                </div>
            </div>
            <div className="discussion-downvote">
                <div className="downvote-count">{item?.downvote}</div>
                <div
                    className="dislike-icon"
                    onClick={() => handleVote("downvote")}
                >
                {item?.vote === "downvote" ? (
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
    );
};

export default Vote;