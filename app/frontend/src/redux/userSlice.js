import axios from 'axios';
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
const url = process.env.BACKEND_URL;

axios.interceptors.request.use(
  function (config) {
    const token = typeof window !== "undefined" ? localStorage.getItem('token') : null;

    if (token) config.headers.authorization = `Bearer ${token}`;

    return config;
  },
  function (error) {
    return Promise.reject(error);
  }
);

export const fetchLogin = (userData) => {
  return axios.post(`${url}/customer/login`, userData);
};

export const fetchMe = createAsyncThunk('user/fetchMe', async () => {
  const { data } = await axios.get(`${url}/customer/me`);
  return data;
});

export const fetchRegister = (userData) =>
  axios.post(`${url}/customer/register`, userData);

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
      delete action.payload._id;
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