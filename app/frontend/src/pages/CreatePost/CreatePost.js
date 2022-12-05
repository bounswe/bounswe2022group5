import React, { useState , useEffect } from "react";
import NavBar from "../../layouts/NavBar/NavBar";
import { Button, Input, notification, Upload, Modal, Form, Select} from 'antd';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
import { useNavigate } from 'react-router-dom';
import {
    PlusOutlined
} from "@ant-design/icons";

import "./CreatePost.css";
import { fetchCreatePost, fetchAllCategories } from "../../redux/postSlice";


const CreatePost = () => {
    const navigate = useNavigate();
    const { Option } = Select;

    const [location, setLocation] = useState({
        longitude: 0,
        latitude: 0,
    });
    const [postTitle, setPostTitle] = useState("");
    const [postText, setPostText] = useState('');
    const [previewOpen, setPreviewOpen] = useState(false);
    const [showImageButton, setShowImageButton] = useState(true);
    const [previewImage, setPreviewImage] = useState('');
    const [previewTitle, setPreviewTitle] = useState('');
    const [fileList, setFileList] = useState([]);

    const [categories, setCategories] = useState([]);
    const [category, setCategory] = useState();

    useEffect(() => {
        fetchAllCategories()
            .then(res => {
                console.log(res)
                setCategories(res)
            })
            .catch(err => console.log(err))
    }, []);

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

    function setPositions(position) {
        setLocation(location => ({
            ...location,
            latitude: position.coords.latitude
        }));
          setLocation(location => ({
            ...location,
            longitude: position.coords.longitude
        }));
    }

    const getAndSetLocation = () => {
        if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPositions);
        } else { 
            notification["error"]({
                message: 'Geolocation is not supported by this browser.',
                placement: "top"
            });
        }
    }

    const resetLocation = () => {
        setLocation(location => ({
            ...location,
            latitude: null
        }));
          setLocation(location => ({
            ...location,
            longitude: null
        }));
    }

    const renderUseMyLocationButton = () => {
        return (
            <div className="create-post-geolocation-button">
                <Button 
                type="secondary"
                shape="round" 
                size="large" 
                onClick={getAndSetLocation}
                >
                    Use My Location
                </Button>
            </div>
        )
    }

    const renderResetMyLocationButton = () => {
        return (
            <div className="create-post-geolocation-button">
                <Button 
                type="secondary"
                shape="round" 
                size="large" 
                onClick={resetLocation}
                >
                    Do Not Use My Location
                </Button>
            </div>
        )
    }
        

    const onCreatePost = async () => {
        let postData = new FormData();
        postData.append("title", postTitle)
        postData.append("body", postText);
        postData.append("longitude", location.longitude);
        postData.append("latitude", location.latitude);
        postData.append("category", category);

        for (let i = 0; i<fileList.length; i++) {
            postData.append(`image${i+1}`, fileList[i]?.originFileObj);
        }

        await fetchCreatePost(postData)
            .then((res) => {
                notification["success"]({
                    message: 'Post is created',
                    placement: "top"
                });
                navigate(`/post/${res.post.id}`)
            })
            .catch(() => {
                notification["error"]({
                    message: 'Post is not created',
                    placement: "top"
                });
            })
    }

    return (
        <div className="layout">
            <div className="header">
                <NavBar></NavBar>
            </div>
            <div className="create-post-content">
                <div className="create-post-forms-and-layout">
                    <div className="create-post-layout">
                        <div className="create-post-add-new-post">
                            Create New Post
                        </div>
                        <div className="create-post-title">
                            <Input 
                                placeholder="Title of the Post" 
                                value={postTitle}
                                onChange={(e) => setPostTitle(e.target.value)}
                            />
                        </div>
                        <div className="create-post-input">
                        <ReactQuill theme="snow" value={postText} onChange={setPostText} className="create-post-react-quill-area"/>
                        </div>
                        <div className="create-post-create-button">
                            <Button 
                            type="primary"
                            shape="round" 
                            size="large" 
                            onClick={onCreatePost}
                            >
                                Create Post
                            </Button>
                        </div>
                    </div>
                    <div className="create-post-forms">
                        <div className="create-post-images">
                            <div className="create-post-images-text">
                                {"Upload images on your post"}
                            </div>
                            { showImageButton ? <div className="create-post-images-images">
                            <Upload
                                listType="picture-card"
                                fileList={fileList}
                                onPreview={handlePreview}
                                onChange={handleChange}
                            >
                                {fileList.length >= 6 ? null : 
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

                        <div className="label-input">
                            <br></br>
                            <Form.Item
                                name="category"
                            >
                                <Select onChange={(e) => setCategory(e)} value={category} placeholder="Category">
                                    <Option key="empty" value=""></Option>
                                    { categories.map(category => (
                                        <Option key={category?.id} value={category?.name}>{category?.name}</Option>
                                    )) }
                                </Select>
                            </Form.Item>
                        </div>

                        <div className="create-post-geolocation">
                            {location.latitude ? renderResetMyLocationButton() : renderUseMyLocationButton()}
                            <div className="create-post-geolocation-text">
                            {"Using your location in your post helps us to find similar users with respect to your location"}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}


export default CreatePost;