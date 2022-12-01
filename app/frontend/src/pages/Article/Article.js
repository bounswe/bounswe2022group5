import React, { useState, useEffect } from "react";
import { useParams } from 'react-router-dom';
import { Image } from 'antd';
import moment from "moment";

import Vote from "../../components/Vote/Vote";

import "./Article.css";

import { fetchArticleById } from "../../redux/articleSlice";

const Article = () => {
    const id = useParams()?.id;

    const [article, setArticle] = useState();
    const [images, setImages] = useState([]);

    useEffect(() => {
        fetchArticleById(id)
            .then(res => {
                console.log(res)
                setArticle(res.article);
                setImages(res.image_urls);
            })
    }, [id]);

    return(
        <div className="article-container">
            <div className="article-post">
                <div className="article-avatar-body">
                    <div>
                        <img className="article-avatar" alt="avatar" src={article?.author?.profile_photo}/>
                    </div>
                    <div style={{ width: "100%" }}>
                        <div className="article-upper">
                            <div className="article-title">
                                <span className="article-title-text" style={{fontSize: "28px"}}>{article?.title}</span>
                                <span className="article-title-author" style={{fontSize: "12px"}}>by {article?.author?.username}</span>
                            </div>
                            <div className="article-date">{moment(article?.date).format("DD.MM.YYYY")}</div>
                        </div>
                        <div className="article-body-votes">
                            <div>{article?.body}</div>
                            <Vote item={article} setItem={setArticle} itemType="article"/>
                            
                        </div>
                    </div>
                </div>

				{images?.length ? 
				<div className="article-images">
					<Image.PreviewGroup>
						{
							images?.map(image => (
								<span className="article-image">
									<Image width={100} height={100} src={image} />
								</span>
							))
						}
					</Image.PreviewGroup>
				</div> : null}

            </div>
        </div>
    );
};

export default Article;