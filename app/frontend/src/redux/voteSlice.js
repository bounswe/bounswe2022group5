import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchUpvotePost = async (id) => {
    const { data } = await axios.post(`${url}/post/${id}/upvote`);
    return data;
}

export const fetchDownvotePost = async (id) => {
    const { data } = await axios.post(`${url}/post/${id}/upvote`);
    return data;
}

export const fetchUpvoteComment = async (id) => {
    const { data } = await axios.post(`${url}/comment/${id}/upvote`);
    return data;
}

export const fetchDownvoteComment = async (id) => {
    const { data } = await axios.post(`${url}/comment/${id}/upvote`);
    return data;
}