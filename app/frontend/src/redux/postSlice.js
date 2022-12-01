import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchPostById = async (id) => {
    const { data } = await axios.get(`${url}/forum/post/${id}`);
    return data;
}