import React from "react";

import "./Post.css";

const CommentEditor = () => {
    const user = {
        name: "Burak Mert",
        avatar: "https://www.w3schools.com/howto/img_avatar.png"
    }

    return(
        <div className="comment-editor-container">
            <div>
                <img className="comment-editor-avatar" alt="avatar" src={user?.avatar}/>
            </div>
            <div className="comment-editor-body">Write a comment</div>
        </div>
    );
};

export default CommentEditor;