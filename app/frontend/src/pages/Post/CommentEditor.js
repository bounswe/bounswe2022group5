import React, { useState } from "react";
import { useSelector} from 'react-redux';
import { Input, Upload, Modal, Button, notification } from 'antd';
import {
    FileImageOutlined,
    CloseOutlined,
    PlusOutlined
} from "@ant-design/icons";

import { fetchCreateComment } from "../../redux/commentSlice";

import "./Post.css";

const { TextArea } = Input;

const CommentEditor = ({ postId, setComments }) => {
    const [showImageButton, setShowImageButton] = useState(true);
    const [commentText, setCommentText] = useState("");
    const [previewOpen, setPreviewOpen] = useState(false);
    const [previewImage, setPreviewImage] = useState('');
    const [previewTitle, setPreviewTitle] = useState('');
    const [fileList, setFileList] = useState([]);
    const [longitude, setLongitude] = useState(null);
    const [latitude, setLatitude] = useState(null);
    const [isSharedLocation, setIsSharedLocation] = useState(false);

    const { user } = useSelector((state) => state.user);

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

    const handleLocation = () => {
        if(!isSharedLocation) {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    setLongitude(position.coords.longitude);
                    setLatitude(position.coords.latitude);
                    setIsSharedLocation(true);
                });
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        } else {
            setLongitude(null);
            setLatitude(null);
            setIsSharedLocation(false);
        }
    }

    const handleSubmit = () => {

        let postData = new FormData();
        postData.append("body", commentText);
        postData.append("longitude", longitude || null);
        postData.append("latitude", latitude || null);

        for (let i = 0; i<fileList.length; i++) {
            postData.append(`image${i+1}`, fileList[i]?.originFileObj);
        }

        fetchCreateComment(postId, postData)
            .then((res) => {
                setComments(comments => [ ...comments, { ...res, comment: { ...res?.comment, upvote: 0, downvote: 0, author: user }} ]);
                setFileList([]);
                setCommentText("");
                setShowImageButton(true);

                notification["success"]({
                    message: 'Comment is created',
                    placement: "top"
                });
            })
            .catch(() => {
                notification["error"]({
                    message: 'Comment is not created',
                    placement: "top"
                });
            })
    };
 
    return(
        <div className="comment-editor-container">
            <div className="comment-editor-body-container">
                <div>
                    <img className="comment-editor-avatar" alt="avatar" src={user?.avatar}/>
                </div>
                <div className="comment-body-container">
                    <div className="comment-editor-body">
                        <TextArea 
                            className="comment-text-area"
                            placeholder="Write your comment"
                            bordered={false}
                            autoSize={true}
                            value={commentText}
                            onChange={(e) => setCommentText(e.target.value)}
                        />
                    </div>
                    <div className="comment-image-button">
                        <span>{ showImageButton ? 
                            <FileImageOutlined big className="comment-image-sign" onClick={() => setShowImageButton(false)}/> : 
                            <CloseOutlined className="comment-image-sign" onClick={() => {
                                setShowImageButton(true);
                                setFileList([]);
                            }}/>
                        }</span>
                        {longitude && latitude ? 
                            <a href={`https://maps.google.com/?q=${latitude},${longitude}`} target="_blank" rel="noopener noreferrer" ><i class='fas fa-map-marker-alt' style={{ fontSize:'24px'}}></i></a>
                            : null
                        }
                        <span className="comment-send-button">
                            <Button type="primary" disabled={!commentText.length} onClick={handleSubmit}>Send</Button>
                        </span>
                        <span className="comment-send-button">
                            <Button type="primary" onClick={handleLocation}>{!isSharedLocation ? "Share My Location" : "Delete My Location"}</Button>
                        </span>
                    </div>
                </div>
            </div>
            { !showImageButton ? <div className="comment-editor-images">
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
            </div> : null}
        </div>
    );
};

export default CommentEditor;