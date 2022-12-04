import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchPostUpvotesByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_posts?page=${pageNo}&page_size=10&sort=desc`);
    return data;
}

export const fetchArticleUpvotesByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_articles?page=${pageNo}&page_size=10&sort=desc`);
    return data;
}

export const fetchPersonalInfo = async () => {
    const {data} = await axios.get(`${url}/profile/get_personal_info`);
    return data;
}

export const fetchUpdatePersonalInfo = (userData) => {
    const {data} = axios.post(`${url}/profile/update_personal_info`, userData);
    return data;
}

export const fetchUpdateAvatar = (idAvatar) => {
    const {data} = axios.post(`${url}/profile/set_avatar`, idAvatar);
    return data;
}

export const fetchUpdateProfilePicture = (img) => {
    const {data} = axios.post(`${url}/profile/upload_profile_picture`, img);
    return data;
}

