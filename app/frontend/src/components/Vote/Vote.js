import React from 'react';

import {
    LikeOutlined
} from "@ant-design/icons";

import "./Vote.css";

const Vote = ({ item, setItem, className }) => {
    
    const handleVote = (voteValue) => {
        if(voteValue === "upvote") {
            if(item?.user_vote === "upvote") {
                setItem({ ...item, upvote: item?.upvote - 1, user_vote: null })
                return;
            }
            if(item?.user_vote === "downvote") {
                setItem({ ...item, downvote: item?.downvote - 1, upvote: item?.upvote + 1, user_vote: "upvote" })
                return;
            }
            setItem({ ...item, upvote: item?.upvote + 1, user_vote: "upvote" })
        }
        if(voteValue === "downvote") {
            if(item?.user_vote === "downvote") {
                setItem({ ...item, downvote: item?.downvote - 1, user_vote: null })
                return;
            }
            if(item?.user_vote === "upvote") {
                setItem({ ...item, downvote: item?.downvote + 1, upvote: item?.upvote - 1, user_vote: "downvote" })
                return;
            }
            setItem({ ...item, downvote: item?.downvote + 1, user_vote: "downvote" })
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
                    {item?.user_vote === "upvote" ? (
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
                {item?.user_vote === "downvote" ? (
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