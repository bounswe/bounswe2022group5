import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchCreateComment = async (postId, formData) => {
    const { data } = await axios.post(`${url}/forum/post/${postId}/comment`, formData, {headers: { "Content-Type": "multipart/form-data" }});
    return data;
}