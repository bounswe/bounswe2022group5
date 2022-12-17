import React, { useState, useEffect, useRef } from "react";
import { useParams, useNavigate } from 'react-router-dom';
import { useSelector} from 'react-redux';
import { Image } from 'antd';
import moment from "moment";

import Vote from "../../components/Vote/Vote";

import "./Article.css";
import logo from "../../layouts/NavBar/logo.png";

import { Annotorious } from '@recogito/annotorious';
import '@recogito/annotorious/dist/annotorious.min.css';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

import { fetchArticleById } from "../../redux/articleSlice";

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

    useEffect(() => {
        fetchArticleById(id)
            .then(res => {
                setArticle(res.article);
                setImages(res.image_urls);
            })
    }, [id]);

    useEffect(() => {
        let annotorious = null;

        for (const image of imgsRef.current) {
            if (image) {
                // Init
                annotorious = new Annotorious({
                    image,
                });
        
                // Attach event handlers here
                annotorious.on('createAnnotation', annotation => {
                    console.log('created', annotation);
                });
        
                annotorious.on('updateAnnotation', (annotation, previous) => {
                    console.log('updated', annotation, previous);
                });
        
                annotorious.on('deleteAnnotation', annotation => {
                    console.log('deleted', annotation);
                });

                annotorious.setAuthInfo({
                    id: `http://3.91.54.225:3000/profile/${user?.id}`,
                    displayName: user?.username
                });
            }
        }

    }, [user, refState]);

    useEffect(() => {
        if(textRef.current) {
            const recogitto = new Recogito({
                content: textRef.current
            });
    
            // Attach event handlers here
            recogitto.on('createAnnotation', annotation => {
                console.log('created', JSON.stringify(annotation, null, 2));
            });
    
            recogitto.on('updateAnnotation', (annotation, previous) => {
                console.log('updated', annotation, previous);
            });
    
            recogitto.on('deleteAnnotation', annotation => {
                console.log('deleted', annotation);
            });
    
            recogitto.setAuthInfo({
                id: `http://3.91.54.225:3000/profile/${user?.id}`,
                displayName: user?.username
            });
        }

    }, [user, textRefState]);

    return(<>
        <div className="article-display-logo" onClick={() => navigate("/")}>
            <Image src={logo} preview={false}/>
        </div>
        <div className="article-display-container">
            <div className="article-display-post">
                <div className="article-display-avatar-body">
                    <div>
                        <img className="article-display-avatar" alt="avatar" src={article?.author?.profile_photo}/>
                    </div>
                    <div style={{ width: "100%" }}>
                        <div className="article-display-upper">
                            <div className="article-display-title">
                                <span className="article-display-title-text" style={{fontSize: "28px"}}>{article?.title}</span>
                                <span className="article-display-title-author" style={{fontSize: "12px"}}>by {article?.author?.username}</span>
                            </div>
                            <div className="article-display-date">{moment(article?.date).format("DD.MM.YYYY")}</div>
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