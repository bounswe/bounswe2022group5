import React from 'react';
import { useSelector } from 'react-redux';
import { Button, notification} from "antd";

import {
    DeleteOutlined
} from "@ant-design/icons";

import { 
    fetchDeleteArticle,
    fetchDeletePost
} from '../../redux/deleteSlice';

import { useNavigate } from 'react-router-dom';

import "./Delete.css";

const Delete = ({ item, type, className }) => {
    const { status: userStatus, user } = useSelector((state) => state.user);
    const navigate = useNavigate();

    const handleDeletePost = async () => {
        await fetchDeletePost(item.id)
            .then((res) => {
                console.log(res)
                notification["success"]({
                    message: 'Post is deleted',
                    placement: "top"
                });
                navigate(`/`)
            })
            .catch((err) => {
                console.log(err.response.data)
                notification["error"]({
                    message: 'Post is not deleted',
                    placement: "top"
            });
        })
    }

    const handleDeleteArticle = async () => {
        await fetchDeleteArticle(item?.id).then(res => {
            notification["success"]({
                message: 'Article is deleted',
                placement: "top"
            });
            navigate(`/`)
        })
        .catch((err) => {
            console.log(err.response.data)
            notification["error"]({
                message: 'Article is not deleted',
                placement: "top"
        });
        })
    }

    const renderDeletePostButton = () => {
        return (
            <div>
                <div
                    className="delete-icon"
                    onClick={handleDeletePost}
                    >
                    <Button shape="circle" icon={<DeleteOutlined style={{ fontSize: '24px', color: '#FF5C5C' }}/>}/>
                    </div>
            </div>
        )
    }

    const renderDeleteArticleButton = () => {
        return (
            <div>
                <div
                    className="delete-icon"
                    onClick={handleDeleteArticle}
                    >
                    <Button shape="circle" icon={<DeleteOutlined style={{ fontSize: '24px', color: '#FF5C5C' }}/>}/>
                    </div>
            </div>
        )
    }

    const renderDeletePost = () => {
        return (
            <div>
                {user.id === item.author.id ? renderDeletePostButton(): null}
            </div>
        )
    }

    const renderDeleteArticle = () => {
        return (
            <div>
                {user.id === item?.author?.id ? renderDeleteArticleButton(): null}
            </div>
        )
    }

    return(
        <div>
            {type === "post" ? renderDeletePost(): renderDeleteArticle()}
        </div>
    );
};

export default Delete;