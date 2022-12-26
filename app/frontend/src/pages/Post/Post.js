import React, { useState, useEffect, useRef } from "react";
import { useParams, useNavigate } from 'react-router-dom';
import { Image, notification, Tag } from 'antd';
import { useSelector} from 'react-redux';
import moment from "moment";
import {
    CheckCircleOutlined
} from "@ant-design/icons";

import CommentEditor from "./CommentEditor";
import Vote from "../../components/Vote/Vote";
import Delete from "../../components/Delete/Delete";

import logo from "../../layouts/NavBar/logo.png";

import { Annotorious } from '@recogito/annotorious';
import '@recogito/annotorious/dist/annotorious.min.css';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

import "./Post.css";

import { fetchPostById } from "../../redux/postSlice";
import { 
    fetchAnnotationById,
    createTextAnnotation,
    createImageAnnotation,
    updateTextAnnotation,
    deleteTextAnnotation,
    deleteImageAnnotation
} from "../../redux/annotationSlice";

const Post = () => {
    const id = useParams()?.id;
    const navigate = useNavigate();
    const { user } = useSelector((state) => state.user);

    const imgsRef = useRef([]);
    const textRef = useRef();

    const [refState, setRefState] = useState([]);
    const [textRefState, setTextRefState] = useState(false);

    const [post, setPost] = useState();
    const [comments, setComments] = useState();
    const [images, setImages] = useState([]);

    const { status: userStatus } = useSelector((state) => state.user);

    const [imageAnnotations, setImageAnnotations] = useState([]);
    const [textAnnotations, setTextAnnotations] = useState([]);

    useEffect(() => {
        fetchPostById(id)
            .then(res => {
                setPost(res.post);
                setComments(res.comments);
                setImages(res.image_urls);
            })
            .catch(err => console.log(err))
    }, [id])

    useEffect(() => {
        fetchAnnotationById(id, "POST")
            .then(res => {
                console.log(res)
                setImageAnnotations(res?.image_annotations);
                setTextAnnotations(res?.text_annotations);
            })
            .catch(err => console.log(err))
    }, [id])

    const getCommentSetter = (commentId) => {
        const commentIndex = comments?.findIndex(c => c?.comment?.id === commentId);
        const comment = comments[commentIndex];

        return function (value) {
            setComments([
                ...comments?.slice(0, commentIndex),
                {
                    ...comment,
                    comment: {
                        ...comment?.comment,
                        ...value
                    }
                },
                ...comments?.slice(commentIndex + 1),
            ])
        }
    };

    useEffect(() => {
        if(!user?.id) return;
        if(refState?.filter((v, i, a) => a.indexOf(v) === i)?.length !== refState?.length) return;
        
        for (const image of imgsRef.current.filter((v, i, a) => a.indexOf(v) === i)) {
            if (image) {
                let annotorious = null;
                // Init
                annotorious = new Annotorious({
                    image,
                });
        
                // Attach event handlers here
                annotorious.on('createAnnotation', async annotation => {
                    console.log('created', annotation);
                    await createImageAnnotation(id, "POST", annotation);
                });
        
                annotorious.on('updateAnnotation', (annotation, previous) => {
                    console.log('updated', annotation, previous);
                });
        
                annotorious.on('deleteAnnotation', async annotation => {
                    console.log('deleted', annotation);
                    await deleteImageAnnotation(annotation?.id, "POST");
                });

                annotorious.setAuthInfo({
                    id: `http://3.91.54.225:3000/profile/${user?.id}`,
                    displayName: user?.username
                });

                const savedAnnotations = imageAnnotations.filter(annot => annot?.target?.source);
                annotorious.clearAnnotations();
                annotorious.setAnnotations(savedAnnotations);
            }
        }

    }, [id, user, refState, imageAnnotations]);

    useEffect(() => {
        if(!user?.id) return;
        
        if(textRef.current) {
            const recogitto = new Recogito({
                content: textRef.current
            });
    
            // Attach event handlers here
            recogitto.on('createAnnotation', async annotation => {
                console.log('created', annotation);
                await createTextAnnotation(id, "POST", annotation);
            });
    
            recogitto.on('updateAnnotation', async (annotation, previous) => {
                console.log('updated', annotation, previous);
                await updateTextAnnotation(id, "POST", annotation);
            });
    
            recogitto.on('deleteAnnotation', async annotation => {
                console.log('deleted', annotation);
                await deleteTextAnnotation(annotation?.id, "POST");
            });
    
            recogitto.setAuthInfo({
                id: `http://3.91.54.225:3000/profile/${user?.id}`,
                displayName: user?.username
            });

            recogitto.clearAnnotations();
            recogitto.setAnnotations(textAnnotations);
        }

    }, [id, user, textRefState, textAnnotations]);

    const postClickHandle = () => {
        if(post?.author?.is_doctor){
            if(userStatus==="fulfilled"){
                console.log(userStatus)
                navigate(`/profile/${post?.author?.id}`) 
            }else{
                notification["error"]({
                message: 'You need to login to see doctor profiles',
                placement: "top"
                });
            }
        }else{
            notification["error"]({
            message: 'User is not a doctor',
            placement: "top"
            });
        }
        
    }

    const commentClickHandle = (item) => {

        if(item?.comment?.author?.is_doctor){
            if(userStatus==="fulfilled"){
                navigate(`/profile/${item?.comment?.author?.id}`)
            }else{
                notification["error"]({
                message: 'You need to login to see doctor profiles',
                placement: "top"
                });
            }
        }else{
            notification["error"]({
            message: 'User is not a doctor',
            placement: "top"
            });
        }
        
    }
    
    const colours = ["magenta","red","volcano","orange","gold","lime","green","cyan","blue","geekblue","purple"];
    return(<>
        <div className="discussion-logo" onClick={() => navigate("/")}>
            <Image src={logo} preview={false}/>
        </div>
        <div className="discussion-container">
            { post ? <div className="discussion-post">
                <div className="discussion-avatar-body">
                    <div>
                        <img className="discussion-avatar" alt="avatar" src={post?.author?.profile_photo} onClick={
                                    () => { postClickHandle() }
                                }/>
                    </div>
                    <div style={{ width: "100%" }}>
                        <div className="discussion-upper">
                            <div className="discussion-title">
                                <span className="discussion-title-text" style={{fontSize: "28px"}}>{post?.title}</span>
                                <span className="discussion-title-author" style={{fontSize: "12px"}} onClick={
                                    () => { postClickHandle() }
                                }>by <span style={{fontSize: "14px", fontWeight: "550"}}>{post?.author?.username}</span></span>
                            </div>
                            <div className="discussion-date">{moment(post?.date).format("DD.MM.YYYY")}</div>
                        </div>

                         
                        <div className="discussion-upper-label-delete">
                            <div>
                                {console.log(post)}
                                {console.log(post?.labels)}
                                {post?.labels?.length > 0 ?'Labels:   ':<></>}  
                                
                                {
                                    // labelsArray.map((item, index) => (
                                    post?.labels?.map((item, index) => (
                                        // <Tag onClick={() => navigate(`/search/${item.name}`)} color={colours[index%colours.length]}>{item.name}</Tag>
                                        <Tag onClick={() =>  window.location.href=`https://en.wikipedia.org/wiki/${item.name}`} color={colours[index%colours.length]}>{item.name}</Tag>
                                    ))
                                }
                            </div>   
                            <div className="discussion-upper-delete-report">
                                <div>
                                    <Delete item={post} type={"post"}/>
                                </div>
                            </div>
                        </div>
                        <div>
                                {post?.related_labels?.length > 0 ?'Our Suggestions:   ':<></>}
                             
                            
                                {
                                    // labelsArray.map((item, index) => (
                                    post?.related_labels?.map((item, index) => (
                                        // <Tag onClick={() => navigate(`/search/${item}`)} color={colours[index%colours.length]}>{item}</Tag>
                                        <Tag onClick={() =>  window.location.href=`https://en.wikipedia.org/wiki/${item}`} color={colours[index%colours.length]}>{item}</Tag>
                                    ))
                                }
                        </div>
                        <br></br>

                        {/* <div>
                            {'Our Suggestions:   '}  
                            
                            {
                                // labelsArray.map((item, index) => (
                                colours.map((item, index) => (
                                    <Tag color={colours[index%colours.length]}>{item}</Tag>
                                ))
                            }
                        </div> */}
                            

                        <div className="discussion-body-votes">
                            <div dangerouslySetInnerHTML={{ __html: post?.body }} ref={el => {
                                textRef.current = el;
                                if(!textRefState) setTextRefState(true);
                            }}/>
                            <Vote item={post} type={"post"} setItem={setPost}/>
                        </div>
                        { post?.commented_by_doctor ? <div className="discussion-doctor">
                             <CheckCircleOutlined className="discussion-check-sign"/>
                            Answered by a doctor
                        </div> : null }
                    </div>
                </div>

				{Object.values(images).length ? 
				<div className="discussion-images">
                    {
                        images?.map((image, index) => (
                            <span className="discussion-image">
                                <img alt="discussion" width={300} height={300} src={image} ref={el => {
                                    imgsRef.current[index] = el;
                                    if(!refState.includes(index))setRefState(refState => [...refState, index])
                                }}/>
                            </span>
                        ))
                    }
				</div> : null}

                <div className="discussion-comment-editor">
                    <CommentEditor postId={post?.id} setComments={setComments}/>
                </div>

                {comments?.length ? <div className="discussion-comments">
                    <h3>Comments</h3>
                    {
						comments?.map(item => (
							<div className="discussion-comment">
                                <img className="discussion-comment-avatar" alt="avatar" src={item?.comment?.author?.profile_photo} onClick={
                                    () => { commentClickHandle(item) }
                                }/>
                                <div className="discussion-comment-container">
                                    <div className="discussion-comment-title">
                                        <span className="discussion-commment-author" onClick={
                                    () => { commentClickHandle(item) }
                                }>{item?.comment?.author?.username}</span>
                                        <span> at </span>
                                        <span className="discussion-date">{moment(item?.comment?.date).format("DD.MM.YYYY")}</span>
                                    </div>
                                    <div className="discussion-comment-body">
                                    
                                        <div dangerouslySetInnerHTML={{ __html: item?.comment?.body }} />
                                        <div style={{ display: "flex", flexDirection: "row" }}>
                                            
                                            <Vote item={item?.comment} type={"comment"} setItem={getCommentSetter(item?.comment?.id)} className="discussion-vote"/>
                                        </div>

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
            </div> : null}
        </div></>
    );
};

export default Post;