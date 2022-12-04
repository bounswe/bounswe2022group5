import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchUpvotePost = async (id) => {
    const { data } = await axios.post(`${url}/forum/post/${id}/upvote`);
    return data;
}

export const fetchDownvotePost = async (id) => {
    const { data } = await axios.post(`${url}/forum/post/${id}/downvote`);
    return data;
}

export const fetchUpvoteComment = async (id) => {
    const { data } = await axios.post(`${url}/forum/post/comment/${id}/upvote`);
    return data;
}

export const fetchDownvoteComment = async (id) => {
    const { data } = await axios.post(`${url}/forum/post/comment/${id}/downvote`);
    return data;
}

export const fetchUpvoteArticle = async (id) => {
    const { data } = await axios.post(`${url}/articles/article/${id}/upvote`);
    return data;
}

export const fetchDownvoteArticle = async (id) => {
    const { data } = await axios.post(`${url}/articles/article/${id}/downvote`);
    return data;
}