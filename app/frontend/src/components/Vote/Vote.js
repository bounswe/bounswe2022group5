import React from 'react';

import {
    LikeOutlined
} from "@ant-design/icons";

import { 
    fetchDownvoteComment, 
    fetchUpvoteComment, 
    fetchUpvotePost, 
    fetchDownvotePost 
} from '../../redux/voteSlice';

import "./Vote.css";

const Vote = ({ item, setItem, className, isComment }) => {
    
    const handleVote = (voteValue) => {
        if(voteValue === "upvote") {
            if(item?.vote === "upvote") {
                setItem({ ...item, upvote: item?.upvote - 1, vote: null })
            } else if(item?.vote === "downvote") {
                setItem({ ...item, downvote: item?.downvote - 1, upvote: item?.upvote + 1, vote: "upvote" })
            } else {
                setItem({ ...item, upvote: item?.upvote + 1, vote: "upvote" });
            }

            if (isComment) {
                fetchUpvoteComment(item.id);
            } else {
                fetchUpvotePost(item.id);
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
            
            if (isComment) {
                fetchDownvoteComment(item.id);
            } else {
                fetchDownvotePost(item.id);
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