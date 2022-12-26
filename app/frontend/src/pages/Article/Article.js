
import { Image, notification } from 'antd';
import React, { useState, useEffect, useRef } from "react";
import { useParams, useNavigate } from 'react-router-dom';
import { useSelector} from 'react-redux';
import moment from "moment";

import Vote from "../../components/Vote/Vote";

import "./Article.css";
import logo from "../../layouts/NavBar/logo.png";
import Delete from '../../components/Delete/Delete';

import { Annotorious } from '@recogito/annotorious';
import '@recogito/annotorious/dist/annotorious.min.css';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

import { fetchArticleById } from "../../redux/articleSlice";
import { 
    fetchAnnotationById,
    createTextAnnotation,
    createImageAnnotation,
    updateTextAnnotation,
    deleteTextAnnotation,
    deleteImageAnnotation
} from "../../redux/annotationSlice";

const Article = () => {
    const id = useParams()?.id;
    const navigate = useNavigate();
    const { user } = useSelector((state) => state.user);

    const imgsRef = useRef([]);
    const textRef = useRef();

    const [refState, setRefState] = useState([]);
    const [textRefState, setTextRefState] = useState(false);

    const [article, setArticle] = useState();
    const [images, setImages] = useState([]);


    const { status: userStatus } = useSelector((state) => state.user);

    const [imageAnnotations, setImageAnnotations] = useState([]);
    const [textAnnotations, setTextAnnotations] = useState([]);


    useEffect(() => {
        fetchArticleById(id)
            .then(res => {
                setArticle(res.article);
                setImages(res.image_urls);
            })
    }, [id]);


    const articleClickHandle = () => {

        if(userStatus==="fulfilled"){
            navigate(`/profile/${article?.author?.id}`)
        }else{
            notification["error"]({
            message: 'You need to login to see doctor profiles',
            placement: "top"
            });
        }
        
    }

    useEffect(() => {
        fetchAnnotationById(id, "ARTICLE")
            .then(res => {
                console.log(res)
                setImageAnnotations(res?.image_annotations);
                setTextAnnotations(res?.text_annotations);
            })
            .catch(err => console.log(err))
    }, [id])

    useEffect(() => {
        if(!user?.id) return;
        if(refState?.filter((v, i, a) => a.indexOf(v) === i)?.length !== refState?.length) return;

        for (const image of imgsRef.current) {
            if (image) {
                let annotorious = null;
                // Init
                annotorious = new Annotorious({
                    image,
                });
        
                // Attach event handlers here
                annotorious.on('createAnnotation', async annotation => {
                    console.log('created', annotation);
                    await createImageAnnotation(id, "ARTICLE", annotation);
                });
        
                annotorious.on('updateAnnotation', (annotation, previous) => {
                    console.log('updated', annotation, previous);
                });
        
                annotorious.on('deleteAnnotation', async annotation => {
                    console.log('deleted', annotation);
                    await deleteImageAnnotation(annotation?.id, "ARTICLE");
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
                await createTextAnnotation(id, "ARTICLE", annotation);
            });
    
            recogitto.on('updateAnnotation', async (annotation, previous) => {
                console.log('updated', annotation, previous);
                await updateTextAnnotation(id, "ARTICLE", annotation);
            });
    
            recogitto.on('deleteAnnotation', async annotation => {
                console.log('deleted', annotation);
                await deleteTextAnnotation(annotation?.id, "ARTICLE");
            });
    
            recogitto.setAuthInfo({
                id: `http://3.91.54.225:3000/profile/${user?.id}`,
                displayName: user?.username
            });

            recogitto.clearAnnotations();
            recogitto.setAnnotations(textAnnotations);
        }

    }, [id, user, textRefState, textAnnotations]);


    return(<>
        <div className="article-display-logo" onClick={() => navigate("/")}>
            <Image src={logo} preview={false}/>
        </div>
        <div className="article-display-container">
            <div className="article-display-post">
                <div className="article-display-avatar-body">
                    <div>
                        <img className="article-display-avatar" alt="avatar" src={article?.author?.profile_photo} onClick={
                                    () => { articleClickHandle() }
                                }/>
                    </div>
                    <div style={{ width: "100%" }}>
                        <div className="article-display-upper">
                            <div className="article-display-title">
                                <span className="article-display-title-text" style={{fontSize: "28px"}}>{article?.title}</span>
                                <span className="article-display-title-author" style={{fontSize: "12px"}} onClick={
                                    () => { articleClickHandle() }
                                }>by {article?.author?.username}</span>
                            </div>
                            <div className="article-display-date">{moment(article?.date).format("DD.MM.YYYY")}</div>
                        </div>

                        {console.log(article)}
                        <div className="article-display-delete">
                            <br></br>
                            <div>
                                <Delete item={article} type={"article"}/>
                            </div>
                        </div>

                        <div className="article-display-body-votes">
                            <div dangerouslySetInnerHTML={{ __html: article?.body }} ref={el => {
                                textRef.current = el;
                                if(!textRefState) setTextRefState(true);
                            }}/>
                            <Vote item={article} setItem={setArticle} itemType="article"/>
                            
                        </div>
                    </div>
                </div>

				{images?.length ? 
				<div className="article-display-images">
						{
							images?.map((image, index) => (
								<span className="article-display-image">
									<img alt="article" width={300} height={300} src={image} ref={el => {
                                        imgsRef.current[index] = el;
                                        if(!refState.includes(index))setRefState(refState => [...refState, index])
                                    }}/>
								</span>
							))
						}
				</div> : null}

            </div>
        </div></>
    );
};

export default Article;