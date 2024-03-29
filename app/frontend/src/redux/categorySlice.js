import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchCategories = async () => {
    const {data} = await axios.get(`${url}/forum/categories`);
    return data;
}

export const fetchFollowedCategories = async () => {
    const {data} = await axios.get(`${url}/profile/followed_categories`);
    return data;
}

export const fetchFollowUnfollowCategory = async (id) => {
    const {data} = await axios.post(`${url}/profile/follow_category/${id}`);
    return data;
}
