import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchArticleById = async (id) => {
    const { data } = await axios.get(`${url}/articles/article/${id}`);
    return data;
}