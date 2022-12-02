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

