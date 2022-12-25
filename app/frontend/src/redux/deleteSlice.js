import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchDeletePost = async (id) => {
    const { data } = await axios.delete(`${url}/forum/post/${id}`);
}