import React, { useState, useEffect } from "react";
import { useSelector} from 'react-redux';
import { useParams, useNavigate } from 'react-router-dom';
import { Image, notification } from 'antd';
import moment from "moment";

import Vote from "../../components/Vote/Vote";

import "./Article.css";
import logo from "../../layouts/NavBar/logo.png"

import { fetchArticleById } from "../../redux/articleSlice";

const Article = () => {
    const id = useParams()?.id;
    const navigate = useNavigate();

    const [article, setArticle] = useState();
    const [images, setImages] = useState([]);

    const { status: userStatus } = useSelector((state) => state.user);

    useEffect(() => {
        fetchArticleById(id)
            .then(res => {
                console.log(res)
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
                        <div className="article-display-body-votes">
                            <div dangerouslySetInnerHTML={{ __html: article?.body }} />
                            <Vote item={article} setItem={setArticle} itemType="article"/>
                            
                        </div>
                    </div>
                </div>

				{images?.length ? 
				<div className="article-display-images">
					<Image.PreviewGroup>
						{
							images?.map(image => (
								<span className="article-display-image">
									<Image width={100} height={100} src={image} />
								</span>
							))
						}
					</Image.PreviewGroup>
				</div> : null}

            </div>
        </div></>
    );
};

export default Article;