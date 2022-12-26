import React, { useState } from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Button, Input, notification, Upload, Modal, } from 'antd';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
import { useNavigate } from 'react-router-dom';
import {
    PlusOutlined
} from "@ant-design/icons";

import { useSelector} from 'react-redux';

import "./CreateArticle.css";
import { fetchCreateArticle } from "../../redux/articleSlice";


const CreateArticle = () => {
    const navigate = useNavigate();

    const { user } = useSelector((state) => state.user);

    const [articleTitle, setArtitleTitle] = useState("");
    const [articleText, setArticleText] = useState('');
    const [previewOpen, setPreviewOpen] = useState(false);
    const [showImageButton, setShowImageButton] = useState(true);
    const [previewImage, setPreviewImage] = useState('');
    const [previewTitle, setPreviewTitle] = useState('');
    const [fileList, setFileList] = useState([]);

    const getBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () => resolve(reader?.result);
            reader.onerror = (error) => reject(error);
        });
    };

    const handleCancel = () => setPreviewOpen(false);

    const handlePreview = async (file) => {
        if (!file.url && !file.preview) {
        file.preview = await getBase64(file?.originFileObj);
        }

        setPreviewImage(file?.url || (file?.preview));
        setPreviewOpen(true);
        setPreviewTitle(file?.name || file?.url?.substring(file?.url?.lastIndexOf('/') + 1));
    };

    const handleChange = ({ fileList: newFileList }) => {
        if(fileList.length < newFileList.length) {
            setFileList([...newFileList.slice(0, newFileList.length - 1), { ...newFileList[newFileList.length - 1], status: "done" }]);
          } else if (fileList.length > newFileList.length){
            setFileList(newFileList.filter(f => f.status !== "removed"));
        }
    };

    const onCreateArticle = async () => {
        let postData = new FormData();
        postData.append("title", articleTitle)
        postData.append("body", articleText);

        for (let i = 0; i<fileList.length; i++) {
            postData.append(`image${i+1}`, fileList[i]?.originFileObj);
        }

        await fetchCreateArticle(postData)
            .then((res) => {
                notification["success"]({
                    message: 'Article is created',
                    placement: "top"
                });
                navigate(`/article/${res.article.id}`)
            })
            .catch(() => {
                notification["error"]({
                    message: 'Article is not created',
                    placement: "top"
                });
            })
    }

    return (
        <div className="layout">
            <div className="header">
                <NavBar></NavBar>
            </div>
            {user.type === 1 ? <div className="create-article-content">
                <div className="create-article-forms-and-layout">
                    <div className="create-article-layout">
                        <div className="create-article-add-new-post">
                            Create New Article
                        </div>
                        <div className="create-article-title">
                            <Input 
                                placeholder="Title of the Article" 
                                value={articleTitle}
                                onChange={(e) => setArtitleTitle(e.target.value)}
                            />
                        </div>
                        <div className="create-article-input">
                        <ReactQuill theme="snow" value={articleText} onChange={setArticleText} className="create-article-react-quill-area"/>
                        </div>
                        <div className="create-article-create-button">
                            <Button 
                            type="primary"
                            shape="round" 
                            size="large" 
                            onClick={onCreateArticle}
                            >
                                Create Article
                            </Button>
                        </div>
                    </div>
                    <div className="create-article-forms">
                        <div className="create-article-images">
                            <div className="create-article-images-text">
                                {"Upload images on the Article"}
                            </div>
                            { showImageButton ? <div className="create-article-images-images">
                            <Upload
                                listType="picture-card"
                                fileList={fileList}
                                onPreview={handlePreview}
                                onChange={handleChange}
                            >
                                {fileList.length >= 8 ? null : 
                                    <div>
                                        <PlusOutlined />
                                        <div style={{ marginTop: 8 }}>Upload</div>
                                    </div>
                                }
                            </Upload>
                            <Modal open={previewOpen} title={previewTitle} footer={null} onCancel={handleCancel}>
                                <img alt="example" style={{ width: '100%' }} src={previewImage} />
                            </Modal>
                                </div> : null
                            }
                        </div>
                    </div>
                </div>
            </div> 
            : 
            <div> You are not allowed to see this page</div>
            }
        </div>
    )
}


export default CreateArticle;