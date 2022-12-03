import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchAllArticles = async (pageNo,pageSize) => {
    const {data} = await axios.get(`${url}/articles/all?page=${pageNo}&page_size=${pageSize}`);
    return data;
}





