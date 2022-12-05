import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchArticleById = async (id) => {
    const { data } = await axios.get(`${url}/articles/article/${id}`);
    return data;
}

export const fetchAllArticles = async (pageNo) => {
    const {data} = await axios.get(`${url}/articles/all?page=${pageNo}&page_size=10`);
    return data;
}

export const fetchCreateArticle = async (formData) => {
    const {data} = await axios.post(`${url}/articles/article`, formData, {headers: { "Content-Type": "multipart/form-data" }});
    return data;
}


export const fetchArticleByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/articles/article/user/${id}?page=${pageNo}&page_size=10`);
    return data;
}
