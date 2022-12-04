import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchPostById = async (id) => {
    const { data } = await axios.get(`${url}/forum/post/${id}`);
    return data;
}

export const fetchPostByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/forum/post/user/${id}?page=${pageNo}&page_size=10`);
    return data;
}

export const fetchAllPosts = async (pageNo,category) => {
    const {data} = await axios.get(`${url}/forum/posts?page=${pageNo}&page_size=10&c=${category}`);
    return data;
}

export const fetchCreatePost = async (formData) => {
    const {data} = await axios.post(`${url}/forum/post`, formData, {headers: { "Content-Type": "multipart/form-data" }});
    return data;
}

