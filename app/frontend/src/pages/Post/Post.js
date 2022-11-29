import React, { useState, useEffect } from "react";
import { useParams } from 'react-router-dom';
import { Image } from 'antd';
import moment from "moment";
import {
    CheckCircleOutlined
} from "@ant-design/icons";

import CommentEditor from "./CommentEditor";
import Vote from "../../components/Vote/Vote";

import "./Post.css";

import { fetchPostById } from "../../redux/postSlice";

const Post = () => {
    const id = useParams()?.id;

    const [post, setPost] = useState();
    const [comments, setComments] = useState();
    const [images, setImages] = useState();

    useEffect(() => {
        fetchPostById(id)
            .then(res => {
                console.log(res)
                setPost(res.post);
                setComments(res.comments);
                setImages(res.image_urls);
            })
    }, [id])

    const getCommentSetter = (commentId) => {
        const commentIndex = comments?.findIndex(c => c?.comment?.id === commentId);

        return function (value) {
            setComments([
                ...comments?.slice(0, commentIndex),
                {
                    comment: value?.comment,
                    image_urls: value?.images
                },
                ...comments?.slice(commentIndex + 1),
            ])
        }
    }

    return(
        <div className="discussion-container">
            <div className="discussion-post">
                <div className="discussion-avatar-body">
                    <div>
                        <img className="discussion-avatar" alt="avatar" src={"https://www.w3schools.com/w3images/avatar6.png"}/>
                    </div>
                    <div style={{ width: "100%" }}>
                        <div className="discussion-upper">
                            <div className="discussion-title">
                                <span className="discussion-title-text" style={{fontSize: "28px"}}>{post?.title}</span>
                                <span className="discussion-title-author" style={{fontSize: "12px"}}>by {post?.author?.username}</span>
                            </div>
                            <div className="discussion-date">{moment(post?.date).format("DD.MM.YYYY")}</div>
                        </div>
                        <div className="discussion-body-votes">
                            <div>{post?.body}</div>
                            <Vote item={post} setItem={setPost}/>
                            
                        </div>
                        { post?.commented_by_doctor ? <div className="discussion-doctor">
                             <CheckCircleOutlined className="discussion-check-sign"/>
                            Answered by {post?.answered_by}
                        </div> : null }
                    </div>
                </div>

				{images?.lenght ? 
				<div className="discussion-images">
					<Image.PreviewGroup>
						{
							images?.map(image => (
								<span className="discussion-image">
									<Image width={100} height={100} src={image} />
								</span>
							))
						}
					</Image.PreviewGroup>
				</div> : null}

                <div className="discussion-comment-editor">
                    <CommentEditor postId={post?.id} setComments={setComments}/>
                </div>

                {comments?.length ? <div className="discussion-comments">
                    <h3>Comments</h3>
                    {
						comments?.map(item => (
							<div className="discussion-comment">
                                <img className="discussion-comment-avatar" alt="avatar" src={item?.comment?.author?.profile_photo}/>
                                <div className="discussion-comment-container">
                                    <div className="discussion-comment-title">
                                        <span className="discussion-commment-author">{item?.comment?.author?.username}</span>
                                        <span> at </span>
                                        <span className="discussion-date">{item?.comment?.date}</span>
                                    </div>
                                    <div className="discussion-comment-body">
                                        <span>{item?.comment?.body}</span>
                                        <Vote item={item?.comment} setItem={getCommentSetter(item?.comment?.id)} className="discussion-vote" isComment={true}/>
                                    </div>

                                    {item?.image_urls ? 
                                        <div className="discussion-comment-images">
                                            <Image.PreviewGroup>
                                                {
                                                    item?.image_urls?.map(image => (
                                                        <span className="discussion-image">
                                                            <Image width={70} height={70} src={image} />
                                                        </span>
                                                    ))
                                                }
                                            </Image.PreviewGroup>
                                        </div> 
                                    : null}
                                </div>
							</div>
						))
					}
                </div> : null}
            </div>
        </div>
    );
};

export default Post;