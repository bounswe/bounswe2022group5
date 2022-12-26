import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchPostUpvotesByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_posts?page=${pageNo}&page_size=10&sort=desc`);
    return data;
}

export const fetchPostUpvotesByDoctorId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_posts?page=${pageNo}&page_size=10&sort=desc&user_id=${id}`);
    return data;
}

export const fetchArticleUpvotesByUserId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_articles?page=${pageNo}&page_size=10&sort=desc`);
    return data;
}

export const fetchArticleUpvotesByDoctorId = async (id, pageNo) => {
    const { data } = await axios.get(`${url}/profile/upvoted_articles?page=${pageNo}&page_size=10&sort=desc&user_id=${id}`);
    return data;
}

export const fetchPersonalInfo = async () => {
    const {data} = await axios.get(`${url}/profile/get_personal_info`);
    return data;
}

export const fetchUpdatePersonalInfo = async (userData) => {
    const {data} = await axios.post(`${url}/profile/update_personal_info`, userData);
    return data;
}

export const fetchUpdateAvatar = async (idAvatar) => {
    const {data} = await axios.post(`${url}/profile/set_avatar`, idAvatar);
    return data;
}

export const fetchUpdateProfilePicture = async (img) => {
    const {data} = await axios.post(`${url}/profile/upload_profile_picture`, img);
    return data;
}

export const fetchDoctorProfile = async (id) => {
    const {data} = await axios.get(`${url}/profile/get_doctor_profile/${id}`);
    return data;
}

export const fetchDeleteAccount = async () => {
    const {data} = await axios.delete(`${url}/profile/delete_account`);
    return data;
}

