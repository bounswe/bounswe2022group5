import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchCreateComment = async (postId, formData) => {
    const { data } = await axios.post(`${url}/forum/post/${postId}/comment`, formData, {headers: { "Content-Type": "multipart/form-data" }});
    return data;
}

export const fetchCommentByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/forum/post/user/${id}/comment?page=${pageNo}&page_size=10`);
    return data;
}