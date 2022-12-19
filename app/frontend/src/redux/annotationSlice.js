import axios from "axios";

const url = process.env.REACT_APP_BACKEND_URL;

export const fetchAnnotationById = async (id, type) => {
    const { data } = await axios.get(`${url}/annotation/${id}?type=${type}`);
    return data;
}

export const createTextAnnotation = async (id, type, annotation) => {
    const { data } = await axios.post(`${url}/annotation/text/${id}?type=${type}`, annotation);
    return data;
}

export const createImageAnnotation = async (id, type, annotation) => {
    const { data } = await axios.post(`${url}/annotation/image/${id}?type=${type}`, annotation);
    return data;
}

export const updateTextAnnotation = async (id, type, annotation) => {
    const { data } = await axios.put(`${url}/annotation/text/${id}?type=${type}`, annotation);
    return data;
}

export const deleteTextAnnotation = async (annotationId, type) => {
    const { data } = await axios.delete(`${url}/annotation/text/delete?type=${type}`, { id: annotationId });
    return data;
}

export const deleteImageAnnotation = async (annotationId, type) => {
    const { data } = await axios.delete(`${url}/annotation/image/delete?type=${type}`, { id: annotationId });
    return data;
}

export const deleteAllTextAnnotations = async (id, type) => {
    const { data } = await axios.delete(`${url}/annotation/delete/${id}?type=${type}`);
    return data;
}