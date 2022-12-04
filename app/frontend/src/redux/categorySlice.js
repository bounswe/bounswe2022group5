import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchCategories = async () => {
    const {data} = await axios.get(`${url}/forum/categories`);
    return data;
}

