import axios from 'axios';
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
const url = process.env.REACT_APP_BACKEND_URL;

axios.interceptors.request.use(
  function (config) {
    const token = typeof window !== "undefined" ? localStorage.getItem('token') : null;

    if (token) config.headers.authorization = `Token ${token}`;

    return config;
  },
  function (error) {
    return Promise.reject(error);
  }
);

export const fetchLogin = (userData) => {
  return axios.post(`${url}/auth/login`, userData);
};

export const fetchMe = createAsyncThunk('user/fetchMe', async () => {
  const { data } = await axios.get(`${url}/auth/me`);
  return data;
});

export const fetchRegister = (userData) =>
  axios.post(`${url}/auth/register`, userData, {headers: { "Content-Type": "multipart/form-data" }});

const userSlice = createSlice({
  name: 'user',
  initialState: {
    user: {},
    status: 'idle',
    error: null,
  },
  reducers: {
    logOut: (state) => {
      localStorage.removeItem('token');
      state.status = 'idle';
      state.user = {};
      window.location.reload();
    },
    login: (state, action) => {
      localStorage.setItem('token', action.payload.token);
      delete action.payload.token;
      state.user = action.payload;
      state.status = 'fulfilled';
    },
    setUser: (state, action) => {
      state.item = action.payload;
    },
  },
  extraReducers: {
    [fetchMe.pending]: (state) => {
      state.status = 'pending';
    },
    [fetchMe.fulfilled]: (state, action) => {
      state.status = 'fulfilled';
      state.user = action.payload;
    },
    [fetchMe.rejected]: (state, action) => {
      state.status = 'rejected';
      state.error = action.message;
    },
  }
});

export const { 
  logOut, 
  login, 
  setUser, 
} = userSlice.actions;
export default userSlice.reducer;