import React, { useState, useEffect } from "react";
import { useParams } from 'react-router-dom';
import { Image } from 'antd';
import {
    CheckCircleOutlined
} from "@ant-design/icons";

import CommentEditor from "./CommentEditor";
import Vote from "../../components/Vote/Vote";

import "./Post.css";

import { fetchPostById } from "../../redux/postSlice";

const Post = () => {
    const id = useParams()?.id;

    const [post, setPost] = useState({
        title: "Lotion for hair eczama",
        body: "I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help, Nunc ultricies ligula et tellus ornare convallis. Ut aliquet libero sed libero dapibus porttitor. Suspendisse potenti. Praesent nec tortor venenatis, finibus lorem nec, volutpat nibh. Quisque ante felis, lacinia eget mi a, tincidunt interdum lacus. Mauris quis nunc tristique, aliquet libero blandit, rhoncus lacus.",
        date: "02.11.2022",
        author: {
            name: "Betty Black"
        },
        user_vote: "upvote",
        upvote: 3,
        downvote: 6,
        comments: [{
            id: "asdfg",
            author: {
                type: "doctor",
                name: "Dr. Belly Button",
                avatar: "https://www.w3schools.com/w3images/avatar2.png"
            },
            date: "02.11.2022",
			body: "Duis ac risus ut lorem suscipit faucibus vel in velit. Phasellus accumsan mi sit amet sapien sodales, quis consequat mauris rutrum. Quisque sagittis dui risus, ac consequat diam sollicitudin at. Donec nunc urna, sollicitudin quis blandit at, ullamcorper ut nibh. Donec eget cursus tellus, sit amet sodales nulla. Cras vitae placerat nibh. Nunc ultricies ligula et tellus ornare convallis. Ut aliquet libero sed libero dapibus porttitor. Suspendisse potenti. Praesent nec tortor venenatis, finibus lorem nec, volutpat nibh. Quisque ante felis, lacinia eget mi a, tincidunt interdum lacus. Mauris quis nunc tristique, aliquet libero blandit, rhoncus lacus.",
            upvote: 2,
            downvote: 1
        },{
            id: "asdfgsd",
            author: {
                type: "member",
                name: "John Ben",
                avatar: "https://www.w3schools.com/w3images/avatar4.png"
            },
            date: "12.11.2022",
			body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas non cursus ipsum. Integer eget ornare felis. Donec eleifend turpis ante, eu dapibus erat luctus congue. Etiam molestie leo risus, eu placerat enim egestas at. Fusce augue diam, euismod vel accumsan eget, porta in ligula. Pellentesque convallis varius ligula nec sodales. Mauris pellentesque turpis non pulvinar tempor. Cras vel leo justo. Pellentesque eget molestie ipsum. Aliquam lobortis dui at dolor eleifend, a vestibulum purus tristique. Morbi a enim in quam venenatis maximus ultricies iaculis mi. Donec egestas leo id elit commodo lobortis. Maecenas sit amet molestie nibh, at mollis diam.",
            upvote: 0,
            downvote: 4,
            user_vote: "downvote",
            images: [
                {
                    url: "https://images.theconversation.com/files/175523/original/file-20170626-4492-mqyzj3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip"
                },
                {
                    url: "https://static.toiimg.com/photo/msid-90907929/90907929.jpg"
                }
            ]
        },
        {
            id: "asdfasagsd",
            author: {
                type: "member",
                name: "Melissa Donut",
                avatar: "https://www.w3schools.com/w3images/avatar1.png"
            },
            date: "12.11.2022",
			body: "You should go to hospital, freak!",
            upvote: 7,
            downvote: 2,
        }],
		images: [
			{
				url: "https://images.theconversation.com/files/175523/original/file-20170626-4492-mqyzj3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip"
			},
			{
				url: "https://static.toiimg.com/photo/msid-90907929/90907929.jpg"
			},
			{
				url: "https://domf5oio6qrcr.cloudfront.net/medialibrary/1974/conversions/headache-pain-thumb.jpg"
			},
			{
				url: "https://www.regionalneurological.com/wp-content/uploads/2019/08/AdobeStock_244803452.jpeg"
			},
			{
				url: "https://newsinhealth.nih.gov/sites/nihNIH/files/2014/March/illustration-man-pained-expression-hands-forehead_0.jpg"
			},
            {
				url: "https://images.theconversation.com/files/175523/original/file-20170626-4492-mqyzj3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip"
			},
			{
				url: "https://static.toiimg.com/photo/msid-90907929/90907929.jpg"
			},
			{
				url: "https://domf5oio6qrcr.cloudfront.net/medialibrary/1974/conversions/headache-pain-thumb.jpg"
			},
			{
				url: "https://www.regionalneurological.com/wp-content/uploads/2019/08/AdobeStock_244803452.jpeg"
			},
			{
				url: "https://newsinhealth.nih.gov/sites/nihNIH/files/2014/March/illustration-man-pained-expression-hands-forehead_0.jpg"
			}
		]
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

    const getCommentSetter = (commentId) => {
        const commentIndex = post?.comments?.findIndex(c => c?.id === commentId);

        return function (value) {
            setPost({
                ...post,
                comments: [
                    ...post?.comments?.slice(0, commentIndex),
                    value,
                    ...post?.comments?.slice(commentIndex + 1),
                ]
            })
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
                                <span className="discussion-title-author" style={{fontSize: "12px"}}>by {post?.author?.name}</span>
                            </div>
                            <div className="discussion-date">{post?.date}</div>
                        </div>
                        <div className="discussion-body-votes">
                            <div>{post?.body}</div>
                            <Vote item={post} setItem={setPost}/>
                            
                        </div>
                        { post?.answered_by ? <div className="discussion-doctor">
                             <CheckCircleOutlined className="discussion-check-sign"/>
                            Answered by {post?.answered_by}
                        </div> : null }
                    </div>
                </div>

				{post?.images ? 
				<div className="discussion-images">
					<Image.PreviewGroup>
						{
							post?.images?.map(image => (
								<span className="discussion-image">
									<Image width={100} height={100} src={image?.url} />
								</span>
							))
						}
					</Image.PreviewGroup>
				</div> : null}

                <div className="discussion-comment-editor">
                    <CommentEditor setPost={setPost}/>
                </div>

                {post?.comments ? <div className="discussion-comments">
                    <h3>Comments</h3>
                    {
						post?.comments?.map(comment => (
							<div className="discussion-comment">
                                <img className="discussion-comment-avatar" alt="avatar" src={comment?.author?.avatar}/>
                                <div className="discussion-comment-container">
                                    <div className="discussion-comment-title">
                                        <span className="discussion-commment-author">{comment?.author?.name}</span>
                                        <span> at </span>
                                        <span className="discussion-date">{comment?.date}</span>
                                    </div>
                                    <div className="discussion-comment-body">
                                        <span>{comment?.body}</span>
                                        <Vote item={comment} setItem={getCommentSetter(comment?.id)} className="discussion-vote"/>
                                    </div>

                                    {comment?.images ? 
                                        <div className="discussion-comment-images">
                                            <Image.PreviewGroup>
                                                {
                                                    comment?.images?.map(image => (
                                                        <span className="discussion-image">
                                                            <Image width={70} height={70} src={image?.url} />
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