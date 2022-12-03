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

export const fetchAllPosts = async (pageNo,pageSize) => {
    const {data} = await axios.get(`${url}/forum/posts?page=${pageNo}&page_size=${pageSize}`);
    return data;
}

